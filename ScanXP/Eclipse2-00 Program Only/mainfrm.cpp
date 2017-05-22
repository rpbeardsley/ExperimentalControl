//***************************************************************************************
//MainFrm.cpp : implementation file
//
//	Functions: For details on functions in this file see MainFrm.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "EclipseDoc.h"
#include "PropSheet.h"
#include "MainFrm.h"
#include "AverageView.h"
#include "TrendView.h"
#include "InstStatusBarDlg.h"
#include "AcquisitionTab.h"
#include "AverageSaveDlg.h"
#include <Dlgs.h>
#include "SaveAs.h"
#include "Splash.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMainFrame

IMPLEMENT_DYNCREATE(CMainFrame, CFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CFrameWnd)
	//{{AFX_MSG_MAP(CMainFrame)
	ON_WM_CREATE()
	ON_COMMAND(IDM_INSTSTATUSBAR, OnInststatusbar)
	ON_UPDATE_COMMAND_UI(IDM_INSTSTATUSBAR, OnUpdateInststatusbar)
	ON_COMMAND(ID_GRAPH_AUTO, OnGraphAuto)
	ON_COMMAND(ID_GRAPH_HORZIN, OnGraphHorzin)
	ON_COMMAND(ID_GRAPH_HORZOUT, OnGraphHorzout)
	ON_COMMAND(ID_GRAPH_VERTAUTO, OnGraphVertauto)
	ON_COMMAND(ID_GRAPH_VERTIN, OnGraphVertin)
	ON_COMMAND(ID_GRAPH_VERTOUT, OnGraphVertout)
	ON_COMMAND(IDM_FILE_OPEN, OnFileOpen)
	ON_COMMAND(IDM_FILE_NEW, OnFileNew)
	ON_COMMAND(IDM_FILE_SAVE, OnFileSave)
	ON_WM_INITMENUPOPUP()
	ON_COMMAND(IDM_AVERAGE_MODE, OnAverageMode)
	ON_COMMAND(IDM_TREND_MODE, OnTrendMode)
	ON_COMMAND(ID_SMOOTH_NONE, OnSmoothNone)
	ON_COMMAND(ID_SMOOTH_3PT, OnSmooth3pt)
	ON_COMMAND(ID_SMOOTH_5PT, OnSmooth5pt)
	ON_COMMAND(IDM_VIEW_INFOBAR, OnViewInfobar)
	ON_UPDATE_COMMAND_UI(IDM_VIEW_INFOBAR, OnUpdateViewInfobar)
	ON_WM_CLOSE()
	ON_UPDATE_COMMAND_UI(ID_VIEWMODE_MARKER, OnUpdateViewmodeMarker)
	ON_UPDATE_COMMAND_UI(ID_VIEWMODE_ZOOM, OnUpdateViewmodeZoom)
	ON_UPDATE_COMMAND_UI(IDM_FILE_OPEN, OnUpdateFileOpen)
	ON_UPDATE_COMMAND_UI(IDM_FILE_SAVE, OnUpdateFileSave)
	ON_COMMAND(ID_START, OnStart)
	ON_COMMAND(ID_STOP, OnStop)
	ON_COMMAND(IDM_FILE_SAVEAS, OnFileSaveas)
	ON_UPDATE_COMMAND_UI(IDM_FILE_SAVEAS, OnUpdateFileSaveas)
	ON_COMMAND(IDM_VIEW_FFT, OnViewFft)
	ON_COMMAND(ID_VIEWMODE_MARKER, OnViewmodeMarker)
	ON_COMMAND(ID_VIEWMODE_ZOOM, OnViewmodeZoom)
	ON_COMMAND(IDM_PROPERTIES, OnProperties)
	ON_UPDATE_COMMAND_UI(IDM_VIEW_FFT, OnUpdateViewFft)
	ON_WM_TIMER() //Added by Paul Walker 160507
	//}}AFX_MSG_MAP
	ON_MESSAGE( WM_MYMESSAGE, OnMyMessage ) //Added by Paul Walker 160507
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_SEPARATOR,
	ID_INDICATOR_DSP,
};

/////////////////////////////////////////////////////////////////////////////
// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	// Start up initialization
	m_iActiveGraphIndex = 0;
	m_bEnableAcq = false;
	m_bDataIsActive = false;
	m_bIsZooming = false;
	m_bAcqInProgress = false;
	m_bSavable = false;
	m_bViewingFFT = false;
	SetCurrentTool(Zoom);
	SetCurrentSmooth(None);
}

CMainFrame::~CMainFrame()
{
}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;

	// CG: The following line was added by the Splash Screen component.
	//CSplashWnd::ShowSplashScreen(this);

	m_bAutoMenuEnable = false;
	
	if (!m_wndToolBar.Create(this) ||
		!m_wndToolBar.LoadToolBar(IDR_MAINFRAME))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;      // fail to create
	}

	if (!m_wndStatusBar.Create(this) ||
		!m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;      // fail to create
	}

	//Create the server!
	if (!m_ICSObject.CreateDispatch(_T("ICS.ICSGP")))
	{
		AfxMessageBox("Could not find the server");
		return -1;	// fail
	}

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_ICSObject.IsInstPresent())
	{
		pApp->SetIsInstrumentPresent(true);

		//Enable "DSP" indicator if present
	/*	if(m_ICSObject.GetIsDSPPresent())
		{
			pApp->SetIsDSPPresent(true);
			m_wndStatusBar.SetPaneStyle(2,SBPS_NORMAL);
		}
		else 
		{*/
			pApp->SetIsDSPPresent(false);
			m_wndStatusBar.SetPaneStyle(2,SBPS_DISABLED);
		//}
	}
	else
	{
		pApp->SetIsDSPPresent(false);
		pApp->SetIsInstrumentPresent(false);
		m_wndStatusBar.SetPaneStyle(2,SBPS_DISABLED);
	}


	if(!m_wndInstStatusBar.Create(this,CBRS_ALIGN_RIGHT | CBRS_BORDER_TOP, ID_INSTSTATUS))
	{
		TRACE0("Failed to create instrument status bar\n");
		return -1;
	}
	if(!m_wndInfoBar.Create(this,CBRS_ALIGN_TOP, ID_INFOBAR))
	{
		TRACE0("Failed to create instrument status bar\n");
		return -1;
	}

	m_wndToolBar.SetButtonStyle(13, TBBS_CHECKGROUP );
	m_wndToolBar.SetButtonStyle(14, TBBS_CHECKGROUP );
	m_wndToolBar.SetButtonStyle(16, TBBS_CHECKGROUP );
	m_wndToolBar.SetButtonStyle(17, TBBS_CHECKGROUP );
	m_wndToolBar.SetButtonStyle(18, TBBS_CHECKGROUP );

	int iOldState = m_wndToolBar.GetToolBarCtrl().GetState( ID_VIEWMODE_MARKER );
				    m_wndToolBar.GetToolBarCtrl().SetState( ID_VIEWMODE_MARKER, iOldState | TBSTATE_CHECKED);

	iOldState = m_wndToolBar.GetToolBarCtrl().GetState( ID_SMOOTH_NONE );
			    m_wndToolBar.GetToolBarCtrl().SetState( ID_SMOOTH_NONE, iOldState | TBSTATE_CHECKED);

	//Allow docking to be only left or right
	m_wndInstStatusBar.EnableDocking(CBRS_ALIGN_LEFT | CBRS_ALIGN_RIGHT);

	m_wndInfoBar.EnableDocking(CBRS_ALIGN_TOP | CBRS_ALIGN_BOTTOM);

	// TODO: Remove this if you don't want tool tips or a resizeable toolbar
	m_wndToolBar.SetBarStyle(m_wndToolBar.GetBarStyle() |
		CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC);

	// TODO: Delete these three lines if you don't want the toolbar to
	//  be dockable
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);

	DockControlBar(&m_wndToolBar);

//	CPoint pt(100,100);
//	FloatControlBar(&m_wndInstStatusBar, pt);

//	FloatControlBar(&m_wndInfoBar, CPoint(200,200));

	//Put the "Bars" where they where last left
	LoadBarState(_T("BarStates"));
	

	return 0;
}

BOOL CMainFrame::OnCreateClient( LPCREATESTRUCT lpcs, CCreateContext* pContext)
{
	// add the first splitter pane - the default view in column 0
	// create a splitter with 1 row, 2 columns

	if(!m_wndSplitter.CreateStatic(this, 2, 1))
	{
		TRACE0("Failed to CreateStaticSplitter\n");
		return FALSE;
	}

	CRect rect;

	GetClientRect(&rect);

	if (!m_wndSplitter.CreateView(0, 0,
		RUNTIME_CLASS(CTrendView), CSize(rect.Width(), 180), pContext))
	{
		TRACE0("Failed to create first pane\n");
		return FALSE;
	}

	// add the second splitter pane - an input view in column 1
	if (!m_wndSplitter.CreateView(1, 0,
		RUNTIME_CLASS(CAverageView), CSize(rect.Width(), 180), pContext))
	{
		TRACE0("Failed to create second pane\n");
		return FALSE;
	}


	return TRUE;
}


/////////////////////////////////////////////////////////////////////////////
// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CFrameWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMainFrame message handlers

void CMainFrame::OnInststatusbar() 
{
	ShowControlBar(&m_wndInstStatusBar,(m_wndInstStatusBar.GetStyle() & WS_VISIBLE)==0, FALSE);
}

void CMainFrame::OnUpdateInststatusbar(CCmdUI* pCmdUI) 
{
	pCmdUI->SetCheck((m_wndInstStatusBar.GetStyle() & WS_VISIBLE) ? 1 : 0);
}

void CMainFrame::OnProperties() 
{
	CPropSheet sheet("Eclipse Instrument Properties",this,0);

	sheet.DoModal();
}

void CMainFrame::OnGraphAuto() 
{
	if(m_iActiveGraphIndex == 0)GetTrendView()->GetGraph()->SetDefaultAxis();
	else GetAverageView()->GetGraph()->SetDefaultAxis();
}

void CMainFrame::OnGraphHorzin() 
{
	if(m_iActiveGraphIndex == 0)GetTrendView()->GetGraph()->ZoomXAxisIn();
	else GetAverageView()->GetGraph()->ZoomXAxisIn();
}

void CMainFrame::OnGraphHorzout() 
{
	if(m_iActiveGraphIndex == 0)GetTrendView()->GetGraph()->ZoomXAxisOut();
	else GetAverageView()->GetGraph()->ZoomXAxisOut();
}

void CMainFrame::OnGraphVertauto() 
{
	if(m_iActiveGraphIndex == 0)GetTrendView()->GetGraph()->ZoomYAxisAuto();
	else GetAverageView()->GetGraph()->ZoomYAxisAuto();
}

void CMainFrame::OnGraphVertin() 
{
	if(m_iActiveGraphIndex == 0)GetTrendView()->GetGraph()->ZoomYAxisIn();
	else GetAverageView()->GetGraph()->ZoomYAxisIn();
}

void CMainFrame::OnGraphVertout() 
{
	if(m_iActiveGraphIndex == 0)GetTrendView()->GetGraph()->ZoomYAxisOut();
	else GetAverageView()->GetGraph()->ZoomYAxisOut();
}
void CMainFrame::SetAverageFromIndex(int iIdx)
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	SetActiveView((CView*)m_wndSplitter.GetPane(1,0));
	m_iActiveGraphIndex = 1;

	CString NotNeeded;

	if(!m_bDataAcquiredByOpen)
	{
		CurrentAveragePath = pApp->GetDataDir();
		CurrentTrendPath = pApp->GetDataDir();

		CurrentAveragePath += _T("\\__ICS__TMP.FFT");
		CurrentTrendPath += _T("\\__ICS__TMP.FFC");
		 
		GetAverageView()->RetrieveAverageActive(iIdx);
	}
	else 
	{

		GetAverageView()->RetrieveTrendAverageFile(CurrentAveragePath, iIdx);
	}
}

void CMainFrame::SetActivePane(int iPane)
{
	m_bIsZooming = false;

	if(iPane == 0)
	{
		//Un Activate the Average (1) graph
		SetActiveView((CView*)m_wndSplitter.GetPane(1,0));
	
		GetAverageView()->GetGraph()->SetActiveGraph(FALSE);

		//Activate the Trend (0) graph
		SetActiveView((CView*)m_wndSplitter.GetPane(0,0));
	
		GetTrendView()->GetGraph()->SetActiveGraph(TRUE);

		m_iActiveGraphIndex = 0;
	}
	else
	{
		//Un Activate the Trend (0) graph
		SetActiveView((CView*)m_wndSplitter.GetPane(0,0));
	
		GetTrendView()->GetGraph()->SetActiveGraph(FALSE);

		//Activate the Average (1) graph
		SetActiveView((CView*)m_wndSplitter.GetPane(1,0));

		GetAverageView()->GetGraph()->SetActiveGraph(TRUE);

		m_iActiveGraphIndex = 1;
	}


}
void CMainFrame::StartTrendAcquisition()
{
	//Clear out the graph data of the Average Graph
	GetAverageView()->GetGraph()->ClearData(1);

	//Clear out the graph data of the Trend Graph
	SetActivePane(0);
	
	GetTrendView()->GetGraph()->ClearData(1);

	//Clear out the FFT window if it is up
	if(m_bViewingFFT)
	{
		GetAverageView()->GetFFTDlg()->Clear();
	}

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	//Set this to false to force ICS to get the data from the acquiring file
	m_bDataAcquiredByOpen = false;
	m_bAcqInProgress = true;
	m_bSavable = true;

	GetTrendView()->StartTrendAcquisition( pApp->GetDataDir() );
	
}
void CMainFrame::StopTrendAcquisition()
{
	m_bAcqInProgress = false;

	SetActivePane(0);

	CTrendView* pView = (CTrendView*)GetActiveView();
	ASSERT( pView );

	pView->StopTrendAcquisition();
	

}
void CMainFrame::StartAverageAcquisition()
{
	//Clear out the graph data of the Trend Graph
	GetTrendView()->GetGraph()->ClearData(1);
	//Clear out the graph data of the Average Graph
	SetActivePane(1);

	GetAverageView()->GetGraph()->ClearData(1);

	//Clear out the FFT window if it is up
	if(m_bViewingFFT)
	{
		GetAverageView()->GetFFTDlg()->Clear();
	}

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	m_bAcqInProgress = true;
	m_bSavable = true;

	GetAverageView()->StartAverageAcquisition( pApp->GetDataDir() );
	
}
void CMainFrame::StopAverageAcquisition()
{
	m_bAcqInProgress = false;

	GetAverageView()->StopAverageAcquisition();
}
void CMainFrame::OnFileOpen() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastOpenPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);

	if(pApp->GetMode() == TREND)// Trend Mode
	{
		static char BASED_CODE szFilter[] = "Eclipse Trend Mode Files (*.ffc)||";


		CFileDialog OpenFile(TRUE,NULL,_T("*.FFC"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_FILEMUSTEXIST | OFN_EXPLORER, szFilter, this );

		//Change the window caption
		OpenFile.m_ofn.lpstrTitle=_T("Open a Trend Mode spectrum from disk");
		OpenFile.m_ofn.lpstrInitialDir = DirPath;

		m_bDataIsActive = false;
		
		//Start up the modal file dialog
		if(OpenFile.DoModal()==IDOK)
		{
			GetTrendView()->GetGraph()->ClearData(1);
			GetAverageView()->GetGraph()->ClearData(1);

			//Clear out the FFT window if it is up
			if(m_bViewingFFT)
			{
				GetAverageView()->GetFFTDlg()->Clear();
			}

			m_bEnableAcq = false;

			GetActiveDocument()->SetTitle( OpenFile.GetFileTitle() );
			pApp->SetLastOpenPath( OpenFile.GetPathName() );
		
			// activate the input view
			SetActiveView((CView*)m_wndSplitter.GetPane(0,0));
			m_iActiveGraphIndex = 0;

			CTrendView* pTrendView = (CTrendView*)GetActiveView();
			ASSERT( pTrendView );

			pTrendView->RetrieveTrendFile( OpenFile.GetPathName() );

			CString AveragePath( OpenFile.GetPathName() );

			int iLength;
			iLength = AveragePath.GetLength();
			AveragePath = AveragePath.Left(iLength - 3);

			AveragePath += _T("FFT");

			CurrentTrendPath = OpenFile.GetPathName();
			CurrentAveragePath = AveragePath;

			//Set this to true to actually get the Average Data from file
			m_bDataAcquiredByOpen = true;

			//Clear the time and number of spectra
			GetAcqTab()->SetDlgItemText(IDC_ELAPSED_TIME, "");
			GetAcqTab()->SetDlgItemText(IDC_SPECTRA_ACQ, "");
		
		}

		
	}
	else // Average Mode
	{
		// activate the Average view
		SetActiveView((CView*)m_wndSplitter.GetPane(1,0));
		m_iActiveGraphIndex = 1;

		CAverageView* pAverageView = (CAverageView*)GetActiveView();
		ASSERT( pAverageView );

		static char BASED_CODE szFilter[] = "Eclipse Average Mode Files (*.flt)||";


		CFileDialog OpenFile(TRUE,NULL,_T("*.FLT"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_FILEMUSTEXIST | OFN_EXPLORER, szFilter, this );

		//Change the window caption
		OpenFile.m_ofn.lpstrTitle=_T("Open a Average Mode spectrum from disk");
		OpenFile.m_ofn.lpstrInitialDir = DirPath;
		
		//Start up the modal file dialog
		if(OpenFile.DoModal()==IDOK)
		{
			GetAverageView()->RemoveAllOverlays();
			GetTrendView()->GetGraph()->ClearData(1);
			GetAverageView()->GetGraph()->ClearData(1);

			//Clear out the FFT window if it is up
			if(m_bViewingFFT)
			{
				GetAverageView()->GetFFTDlg()->Clear();
			}

			pApp->SetLastOpenPath( OpenFile.GetPathName() );

			if(!pAverageView->OpenAverageFile( OpenFile.GetPathName(), 1) )
			{
				AfxMessageBox("Error loading the Average Data file");
			}

		
			CurrentAveragePath = OpenFile.GetPathName();

			GetActiveDocument()->SetTitle( OpenFile.GetFileTitle() );
			m_bSavable = true;

			//Clear the time and number of spectra
			GetAcqTab()->SetDlgItemText(IDC_ELAPSED_TIME, "");
			GetAcqTab()->SetDlgItemText(IDC_SPECTRA_ACQ, "");

		}
	}




	
	
}

void CMainFrame::OnFileNew() 
{


}



void CMainFrame::OnFileSave() 
{
	//Save must determine between Trend and Average Files
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CDocument* pDoc = (CDocument*)GetActiveDocument();
	ASSERT( pDoc );

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastOpenPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);


	if(pApp->GetMode() == TREND)// Trend Mode
	{
		CString Name;
		CString Title(pDoc->GetTitle());

		if(Title == "Untitled")
		{
			Name = "";
		}
		else Name = Title;

		CAverageSaveDlg dlg(this, &Name);

		if( Title == "Untitled")//Untitled in the title text indicates this is new data
		{

			if( dlg.DoModal() == IDOK)
			{

				if(!Name.IsEmpty())//If the Name is not null save it to disk!
				{
					//Save Trend Files using Name
					try
					{
						if( GetTrendView()->SaveTrendFile(Name, true) )pDoc->SetTitle(Name);
					}
					catch(COleException* e)
					{
						TRACE("Ole Exception occured.\n");
						e->Delete();
					}
				}
			}
		}
		else //data has been opened
		{
			if( GetTrendView()->SaveTrendFile(Name, false) )pDoc->SetTitle(Name);
		}
	}
	else // Average Mode
	{
		CAverageView* pAverageView = (CAverageView*)GetActiveView();
		ASSERT( pAverageView );

		static char BASED_CODE szFilter[] = "Eclipse Average Mode Files (*.flt)||";


		//Initialize a Common Open File dialog
		CFileDialog OpenFile(FALSE, _T("flt"), _T("*.flt"), OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_OVERWRITEPROMPT | OFN_EXPLORER, szFilter, this );

		//Change the window caption
		OpenFile.m_ofn.lpstrTitle=_T("Save the current Average Mode spectrum to disk");
		OpenFile.m_ofn.lpstrInitialDir = DirPath;

		
		//Start up the modal file dialog
		if(OpenFile.DoModal()==IDOK)
		{
			if(pAverageView->GetAverageYData()->parray != NULL)//Make sure we have good data
			{
				if( !pAverageView->SaveAverageFile(OpenFile.GetPathName()) )
				{
					AfxMessageBox("Error saving the Average Data file");
				}
				else
					GetActiveDocument()->SetTitle( OpenFile.GetFileTitle() );
				
			}

		}
	}
	
}

void CMainFrame::OnInitMenuPopup(CMenu* pPopupMenu, UINT nIndex, BOOL bSysMenu) 
{
	CFrameWnd::OnInitMenuPopup(pPopupMenu, nIndex, bSysMenu);
	
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);
	
	if(nIndex == 3 && !bSysMenu )//Acquisition Menu
	{
		if(pApp->GetMode() == TREND)
			pPopupMenu->CheckMenuRadioItem( IDM_TREND_MODE, IDM_AVERAGE_MODE, IDM_TREND_MODE, MF_BYCOMMAND ); 
		else
			pPopupMenu->CheckMenuRadioItem( IDM_TREND_MODE, IDM_AVERAGE_MODE, IDM_AVERAGE_MODE, MF_BYCOMMAND ); 
		
		if( m_bAcqInProgress )
		{
			pPopupMenu->EnableMenuItem(ID_STOP,MF_ENABLED);
			pPopupMenu->EnableMenuItem(ID_START,MF_GRAYED);
			pPopupMenu->EnableMenuItem(IDM_TREND_MODE, MF_GRAYED);
			pPopupMenu->EnableMenuItem(IDM_AVERAGE_MODE, MF_GRAYED);
		}
		else
		{
			pPopupMenu->EnableMenuItem(ID_STOP,MF_ENABLED);
			pPopupMenu->EnableMenuItem(ID_START,MF_ENABLED);
			pPopupMenu->EnableMenuItem(IDM_TREND_MODE, MF_ENABLED);
			pPopupMenu->EnableMenuItem(IDM_AVERAGE_MODE, MF_ENABLED);

		}
	
		if( !pApp->GetIsInstrumentPresent() )
		{
			pPopupMenu->EnableMenuItem(ID_START,MF_GRAYED);
			pPopupMenu->EnableMenuItem(ID_STOP,MF_GRAYED);
			pPopupMenu->EnableMenuItem(IDM_PROPERTIES,MF_GRAYED);
		}
	}

}

void CMainFrame::OnAverageMode() 
{
	GetAcqTab()->OnModeAverage();
}

void CMainFrame::OnTrendMode() 
{
	GetAcqTab()->OnModeTrend();
}
IICSGP* CMainFrame::GetICS()
{
	GetAcqTab()->GetLED2()->MomentaryOn();

	return &m_ICSObject;
}
CAcquisitionTab* CMainFrame::GetAcqTab()
{
	CInstStatusBar* pBar = (CInstStatusBar*)GetInstStatusBar();
	ASSERT(pBar);

	CInstStatusBarDlg* pBarDlg = (CInstStatusBarDlg*)pBar->GetStatusDlg();
	ASSERT(pBarDlg);

	return pBarDlg->GetAcqTab();

}
CInfoBarDlg* CMainFrame::GetInfo()
{
	CInfoBar* pBar = (CInfoBar*)GetInfoBar();
	ASSERT(pBar);

	return (CInfoBarDlg*)pBar->GetInfoDlg();
}

CAnalysisTab* CMainFrame::GetAnalysisTab()
{
	CInstStatusBar* pBar = (CInstStatusBar*)GetInstStatusBar();
	ASSERT(pBar);

	CInstStatusBarDlg* pBarDlg = (CInstStatusBarDlg*)pBar->GetStatusDlg();
	ASSERT(pBarDlg);

	return pBarDlg->GetAnaTab();

}
CCalibrationTab* CMainFrame::GetCalibrationTab()
{
	CInstStatusBar* pBar = (CInstStatusBar*)GetInstStatusBar();
	ASSERT(pBar);

	CInstStatusBarDlg* pBarDlg = (CInstStatusBarDlg*)pBar->GetStatusDlg();
	ASSERT(pBarDlg);

	return pBarDlg->GetCalibrationTab();

}
void CMainFrame::SetStatusBarText(int Pane, CString Text)
{
	m_wndStatusBar.SetPaneText(Pane,Text,TRUE);
}

void CMainFrame::OnViewmodeMarker() 
{
	SetCurrentTool(Marker);
	GetTrendView()->GetGraph()->SetActiveTool(Marker);
	GetAverageView()->GetGraph()->SetActiveTool(Marker);
}

void CMainFrame::OnViewmodeZoom() 
{
	SetCurrentTool(Zoom);
	GetTrendView()->GetGraph()->SetActiveTool(Zoom);
	GetAverageView()->GetGraph()->SetActiveTool(Zoom);
}

void CMainFrame::OnSmoothNone() 
{
	SetCurrentSmooth( None );
	GetTrendView()->GetGraph()->SetSmooth( None );
	GetAverageView()->GetGraph()->SetSmooth( None );
	
}

void CMainFrame::OnSmooth3pt() 
{
	SetCurrentSmooth( ThreePt );
	GetTrendView()->GetGraph()->SetSmooth( ThreePt );
	GetAverageView()->GetGraph()->SetSmooth( ThreePt );
	
}

void CMainFrame::OnSmooth5pt() 
{
	SetCurrentSmooth( FivePt );
	GetTrendView()->GetGraph()->SetSmooth( FivePt );
	GetAverageView()->GetGraph()->SetSmooth( FivePt );
}

void CMainFrame::OnViewInfobar() 
{
	ShowControlBar(&m_wndInfoBar,(m_wndInfoBar.GetStyle() & WS_VISIBLE)==0, FALSE);
}

void CMainFrame::OnUpdateViewInfobar(CCmdUI* pCmdUI) 
{
	pCmdUI->SetCheck((m_wndInfoBar.GetStyle() & WS_VISIBLE) ? 1 : 0);	
	
}

void CMainFrame::OnClose() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_bAcqInProgress)
	{
		if(pApp->GetMode() == AVERAGE)StopAverageAcquisition();
		else StopTrendAcquisition();
	}

	SaveBarState(_T("BarStates"));
	
	CFrameWnd::OnClose();
}

void CMainFrame::OnUpdateViewmodeMarker(CCmdUI* pCmdUI) 
{
	if(GetCurrentTool() == Marker)
	{
		int iOldState = m_wndToolBar.GetToolBarCtrl().GetState( ID_VIEWMODE_MARKER );
		m_wndToolBar.GetToolBarCtrl().SetState( ID_VIEWMODE_MARKER, iOldState | TBSTATE_CHECKED);
	
		iOldState = m_wndToolBar.GetToolBarCtrl().GetState( ID_VIEWMODE_ZOOM );
		m_wndToolBar.GetToolBarCtrl().SetState( ID_VIEWMODE_ZOOM, iOldState & ~TBSTATE_CHECKED);
	}
	
}

void CMainFrame::OnUpdateViewmodeZoom(CCmdUI* pCmdUI) 
{
	if(GetCurrentTool() == Zoom)
	{
		int iOldState = m_wndToolBar.GetToolBarCtrl().GetState( ID_VIEWMODE_ZOOM );
		m_wndToolBar.GetToolBarCtrl().SetState( ID_VIEWMODE_ZOOM, iOldState | TBSTATE_CHECKED);
	
		iOldState = m_wndToolBar.GetToolBarCtrl().GetState( ID_VIEWMODE_MARKER );
		m_wndToolBar.GetToolBarCtrl().SetState( ID_VIEWMODE_MARKER, iOldState & ~TBSTATE_CHECKED);
	}	
}

void CMainFrame::OnUpdateFileOpen(CCmdUI* pCmdUI) 
{
	if(m_bAcqInProgress)
	{
		pCmdUI->Enable(FALSE);
	}
	else
	{
		pCmdUI->Enable(TRUE);
	}	
}

void CMainFrame::OnUpdateFileSave(CCmdUI* pCmdUI) 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_bAcqInProgress)
	{
		pCmdUI->Enable(FALSE);
	}
	else
	{
		if(pApp->GetMode() == AVERAGE)
		{
			if(m_bSavable)pCmdUI->Enable(TRUE);
			else pCmdUI->Enable(FALSE);
		
		}
		else
		{
			if(m_bSavable)pCmdUI->Enable(TRUE);
			else pCmdUI->Enable(FALSE);

		}
	}	
}

void CMainFrame::OnStart() 
{
	GetAcqTab()->OnAcqStart();
}

void CMainFrame::OnStop() 
{
	GetAcqTab()->OnAcqStop();
}

void CMainFrame::OnFileSaveas() 
{
	ASSERT(GetAverageView());

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastOpenPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);

	static char BASED_CODE szFilter[] = "Eclipse Average Mode Files (*.FLT)||";
	CString CalPath;

	CSaveAs sa(FALSE,_T("FLT"),_T("*.FLT"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | OFN_OVERWRITEPROMPT |
								  OFN_EXPLORER, szFilter ,this, &CalPath);

	sa.m_ofn.lpstrInitialDir = DirPath;

	if(sa.DoModal() == IDOK)
	{
		GetAverageView()->RemoveAllOverlays();
		GetAverageView()->SaveAsAverageFile( sa.GetPathName(), CalPath );
		if(pApp->GetMode() == AVERAGE)GetActiveDocument()->SetTitle( sa.GetFileTitle() );

	}
}

void CMainFrame::OnUpdateFileSaveas(CCmdUI* pCmdUI) 
{
	if(m_bAcqInProgress)
	{
		pCmdUI->Enable(FALSE);
	}
	else
	{
		if(GetActiveGraphIndex())
		{
			pCmdUI->Enable(TRUE);
		}
		else pCmdUI->Enable(FALSE);
	}		
}
void CMainFrame::StripAxisTextLabels(CString* pText)
{
	int iStart = pText->Find('[');
	iStart--;//This is to also the the space thats add before the [
	if(iStart >= 0)
		*pText = pText->Left(iStart);
}

void CMainFrame::OnViewFft() 
{
	// TODO: Add your command handler code here
	
}

void CMainFrame::OnUpdateViewFft(CCmdUI* pCmdUI) 
{
	pCmdUI->SetCheck(m_bViewingFFT ? 1 : 0);

	if(GetActiveGraphIndex())
	{
		pCmdUI->Enable(TRUE);
		if(m_bViewingFFT)
		{
			
			int iOldState = m_wndToolBar.GetToolBarCtrl().GetState( IDM_VIEW_FFT );
			m_wndToolBar.GetToolBarCtrl().SetState( IDM_VIEW_FFT, iOldState | TBSTATE_CHECKED);
		
		}
		else
		{

			int iOldState = m_wndToolBar.GetToolBarCtrl().GetState( IDM_VIEW_FFT );
			m_wndToolBar.GetToolBarCtrl().SetState( IDM_VIEW_FFT, iOldState & ~TBSTATE_CHECKED);
			
		}
	}
	else
	{
		pCmdUI->Enable(FALSE);
	}
}

//Added by Paul Walker 160507
LRESULT CMainFrame::OnMyMessage( WPARAM wParam, LPARAM lParam ) 
{
   // ... Handle message here
		// TODO: Add your control notification handler code here

	m_iStartedExternally = wParam;
	SetTimer(DOSTARTACQ, 100, NULL);

   return 0L;
}
//End added by Paul Walker

//OnTimer added Paul Walker 160507
void CMainFrame::OnTimer(UINT nIDEvent)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	bool bStopped  = false;

	switch(nIDEvent)
	{
		case DOSTARTACQ:
		
		KillTimer(DOSTARTACQ);
		pWnd->GetAcqTab()->OnAcqStart();
	
		break;
	}


	CFrameWnd::OnTimer(nIDEvent);
}
//End added by Paul Walker