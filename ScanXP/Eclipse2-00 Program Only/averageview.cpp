//***************************************************************************************
//AverageView.cpp : implementation file
//
//	Functions: For details on functions in this file see AverageView.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include <IO.h>
#include "MainFrm.h"
#include "Eclipse.h"
#include "AverageView.h"
#include "EclipseDoc.h"
#include "GraphProperties.h"
#include "SaveAs.h"
#include "ModifyData.h"
#include "SelectedProperties.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

int iTickStart;

#define TRACETIMEINIT() iTickStart = ::GetTickCount();
#define TRACETIME(msg) TRACE1(_T("%08i: "), ::GetTickCount() - iTickStart); TRACE0(msg);


/////////////////////////////////////////////////////////////////////////////
// CAverageView

IMPLEMENT_DYNCREATE(CAverageView, CView)

CAverageView::CAverageView()
{
	VariantInit(&m_vaAverageXData);
	VariantInit(&m_vaAverageYData);
	VariantInit(&m_vaCalXData);
	m_vaAverageXData.parray = NULL;
	m_vaAverageYData.parray = NULL;
	m_vaCalXData.parray = NULL;
	m_pHoverWnd = NULL;
	m_bApplyCalOnce = false;
	m_pShowFFTDlg = NULL;

	m_dIdealFreq = 927429.1992;
	m_bCanUpdate = true;
	m_iNumberOfAverages = 0;
}

CAverageView::~CAverageView()
{
	//Make sure the hover window is deleted
	if(m_pHoverWnd != NULL)
	{
		m_pHoverWnd->DestroyWindow();
		delete m_pHoverWnd;
		m_pHoverWnd = NULL;
	}

	//Extra clean up if something did not work correctly
	VariantClear(&m_vaAverageXData);
	VariantClear(&m_vaAverageYData);
	VariantClear(&m_vaCalXData);
}


BEGIN_MESSAGE_MAP(CAverageView, CView)
	//{{AFX_MSG_MAP(CAverageView)
	ON_WM_SIZE()
	ON_WM_TIMER()
	ON_COMMAND(IDM_COPYGRAPH, OnCopygraph)
	ON_WM_DESTROY()
	ON_WM_SETCURSOR()
	ON_COMMAND(IDM_VIEW_FFT, OnViewFFT)
	//}}AFX_MSG_MAP
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
	ON_COMMAND(ID_RIGHT_GRAPH_PROPS, OnRightGraphProperties)
	ON_COMMAND(ID_VIEWMODE_MARKER, OnRightSetMarkerTool)
	ON_COMMAND(ID_VIEWMODE_ZOOM, OnRightSetZoomTool)
	ON_COMMAND(ID_ADD_OVERLAY, OnAddOverlay)
	ON_COMMAND(ID_REMOVE_OVERLAY, OnRemoveOverlay)
	ON_COMMAND(IDM_CAL_ENABLED, OnRightCalibrationEnable)
	ON_COMMAND(IDM_MODIFYDATA, OnModifyData)
	ON_COMMAND(IDR_DATA_PROPS, OnDataProps)
		
END_MESSAGE_MAP()


BEGIN_EVENTSINK_MAP(CAverageView, CView)
    //{{AFX_EVENTSINK_MAP(CAverageView)
	ON_EVENT(CAverageView, IDC_GSXAVERAGE, 1 /* GSXMouseDown */, OnGSXMouseDown, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CAverageView, IDC_GSXAVERAGE, 2 /* GSXMouseUp */, OnGSXMouseUp, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CAverageView, IDC_GSXAVERAGE, 3 /* GSXMouseMove */, OnGSXMouseMove, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CAverageView, IDC_GSXAVERAGE, 4 /* GSXRepaint */, OnGSXRepaint, VTS_I4 VTS_I4 VTS_I4 VTS_I4 VTS_I4)
	ON_EVENT(CAverageView, IDC_GSXAVERAGE, 5 /* GSXClick */, OnGSXClick, VTS_NONE)
	ON_EVENT(CAverageView, IDC_GSXAVERAGE, 7 /* GSXUpdateComplete */, OnGSXUpdateComplete, VTS_NONE)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()
/////////////////////////////////////////////////////////////////////////////
// CAverageView drawing

void CAverageView::OnDraw(CDC* pDC)
{
	CDocument* pDoc = GetDocument();
}

/////////////////////////////////////////////////////////////////////////////
// CAverageView diagnostics

#ifdef _DEBUG
void CAverageView::AssertValid() const
{
	CView::AssertValid();
}

void CAverageView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CAverageView message handlers
bool CAverageView::CreateGraph()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CRect rect;

	rect.SetRectEmpty();
  
	//Create graph object
	if(!m_Graph.Create(NULL,WS_VISIBLE | WS_CHILD, rect, this, IDC_GSXAVERAGE, NULL, FALSE))
	{
		TRACE(_T("Could not create the GSX control"));
		return FALSE;
	}
	ASSERT(m_Graph);

	m_Graph.SetBatchMode(TRUE);
	m_Graph.SetScrollBar(TRUE);			//Enable Scroll bar
	m_Graph.SetInternalMarker(TRUE);	//Enable Marker
	m_Graph.SetInternalZoom(TRUE);		//Enable the Zoom
	m_Graph.SetInternalGain(TRUE);		//Enable the gain adjustment 
	m_Graph.SetShowActiveGraph(TRUE);	//Enable "Active Graph"
	m_Graph.SetActiveGraph(FALSE);		//This graph is not Active
	m_Graph.SetNumberOfSeries(1);
	m_Graph.SetAxisXText( pApp->GetXAxisText() );
	m_Graph.SetAxisYText(_T("mVolts"));

	m_Graph.SetPlotAreaColor(0);
	m_Graph.SetBatchMode(FALSE);

	m_Graph.SetChartAreaColor(0);
	m_Graph.SetMarkerHorzLine(TRUE);

	m_Graph.SetHorzLine1State(TRUE);
	m_Graph.SetHorzLine2State(TRUE);
	m_Graph.SetHorzLine1Color(8);
	m_Graph.SetHorzLine2Color(8);

	return true;
}


BOOL CAverageView::Create(LPCTSTR lpszClassName, LPCTSTR lpszWindowName, DWORD dwStyle, const RECT& rect, CWnd* pParentWnd, UINT nID, CCreateContext* pContext) 
{
	BOOL bRet = CWnd::Create(lpszClassName, lpszWindowName, dwStyle, rect, pParentWnd, nID, pContext);

	if( CreateGraph() )GraphSettings(false);//Load settings

	return bRet;
}

void CAverageView::OnSize(UINT nType, int cx, int cy) 
{
	CView::OnSize(nType, cx, cy);
	
	if(m_Graph)m_Graph.Size(0,0,cx,cy);
}
void CAverageView::LoadDataToBeCombined()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CFile File;
	CFileException e;
	long lNumPoints;
	HRESULT hr;

	try
	{
		if( File.Open( pApp->GetFilePath(), CFile::modeRead, &e ) )
		{
			//Move up past the settings object
			File.Seek( SETTINGS_SIZE, CFile::begin);
			//----------------------Load the actual data Data----------------------
			//Number of points
			File.Read( &lNumPoints, sizeof(long));

			//Now lets move up past the "X" data to the Y
			File.Seek( lNumPoints *  sizeof(double), CFile::current );

			// Create SAFEARRAY that will contain the data
			SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array
			SAFEARRAY FAR* psaValues = NULL;
		
			sabOneDim[0].cElements = lNumPoints;
			sabOneDim[0].lLbound = 1;
			
			// Create the actual SafeArray descriptors
			psaValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
		
			V_VT(&m_vaExtra) = VT_ARRAY | VT_R8;
			V_ARRAY(&m_vaExtra) = psaValues;

			double *pdTmpArray;
		
			//Set a pointer to access the safearray data directly
			hr = SafeArrayAccessData(psaValues, (void **)&pdTmpArray);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			//File opened now read the Y data
			File.Read( pdTmpArray, lNumPoints * sizeof(double));

			hr = SafeArrayUnaccessData(psaValues);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

			//-----------------------------------------------------------------------
		
			File.Close();
		
		}
	}
	catch(CFileException* e)
	{
		EndWaitCursor();	
		e->ReportError();
		e->Delete();
		
	}
}
void CAverageView::StartAverageAcquisition(CString FilePath)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	StopAverageAcquisition();

	m_iNumberOfAverages = 0;//Initialize the Number of Averages counter
						    //This is used by the AcqTab to determine when to stop
							//when set from the General instrument prop page

	try
	{
		VariantClear(&m_vaExtra);
		VariantInit(&m_vaExtra);

		int iFileOperator = eNone;
		int iConstOperator = eNone;
		double dConstValue = 1;

		if( pApp->GetIsCombineFile() )iFileOperator = pApp->GetFileOperator();
		if( pApp->GetIsApplyConst() )iConstOperator = pApp->GetConstOperator();

	
		CString strConstValue;
		strConstValue = pApp->GetConstValue();

		dConstValue = atof(strConstValue);

		if( pApp->GetIsCombineFile() )LoadDataToBeCombined();
		
		pWnd->GetICS()->StartAverageAcquisition(m_vaExtra, iFileOperator, dConstValue, iConstOperator);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured:\n");
		e->ReportError();
		e->Delete();
		
	}
	GetSettings()->Initialize();
	GetSettings()->LoadSettingsFromInstrument();

	if( GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bEnhancer )
	{
		m_Graph.HorzLine1(470, TRUE, FALSE);
		m_Graph.HorzLine2(-470, TRUE, FALSE);
	}
	else
	{
		m_Graph.HorzLine1(500, TRUE, FALSE);
		m_Graph.HorzLine2(-500, TRUE, FALSE);
	}

	//Open the cal file that was selected  
	if(GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCalValid)
	{
		//Start using calibration
		pApp->SetCalState(0);

		//Clean up any overlays...
		RemoveAllOverlays();

		if(pApp->GetCalState())
		{
			m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);
			pApp->SetCalState(0);
		}
		else 
		{
			if(CalibrateAverageXData())
			{
				m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
				pApp->SetCalState(1);
			}
			
		}
		m_bApplyCalOnce = true;
	}
	else
	{
		pApp->SetCalState(1);

		//Clean up any overlays...
		RemoveAllOverlays();

		if(pApp->GetCalState())
		{
			m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);
			pApp->SetCalState(0);
		}
		else 
		{
			if(CalibrateAverageXData())
			{
				m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
				pApp->SetCalState(1);
			}
			
		}
	}

	UpdateLabels();

	SetTimer(AVERAGEACQUISITION, 300, NULL);
}
void CAverageView::StopAverageAcquisition() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	KillTimer(AVERAGEACQUISITION);
	try
	{
		pWnd->GetICS()->StopAverageAcquisition();
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->ReportError();
		e->Delete();
		
	}
	VariantClear(&m_vaExtra);
}


void CAverageView::OnTimer(UINT nIDEvent) 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	bool bStopped  = false;

	switch(nIDEvent)
	{
		case AVERAGEHOVER:
		
		KillTimer(AVERAGEHOVER);

		if(m_pHoverWnd == NULL)
		{
			DisplayHoverWindow();
		}

		break;
		
		case AVERAGEACQUISITION:

			KillTimer(AVERAGEACQUISITION);
	
			if(m_bCanUpdate)
			{
	
				try //Catch any ole exceptions
				{
					if(!pWnd->GetICS()->GetActive())
					{
						pWnd->GetAcqTab()->OnAcqStop();
						bStopped = true;
						return;//dont need to go thru again in Average mode so just return now
					}
					else bStopped = false;

					VARIANT vaXTmpData;
					VARIANT vaYTmpData;

					VariantInit(&vaXTmpData);
					VariantInit(&vaYTmpData);

					if( pWnd->GetICS()->GetDataFromInst(&vaXTmpData, &vaYTmpData) )
					//if( GetSynthData(&vaXTmpData, &vaYTmpData) )
					{
						m_iNumberOfAverages++;//Increment once for every record going by

						VariantClear(&m_vaAverageXData);
						VariantClear(&m_vaAverageYData);
					
						VariantInit(&m_vaAverageXData);
						VariantInit(&m_vaAverageYData);

						VariantCopy(&m_vaAverageXData, &vaXTmpData);
						VariantCopy(&m_vaAverageYData, &vaYTmpData);

						VariantClear( &vaXTmpData );
						VariantClear( &vaYTmpData );

						m_bCanUpdate = true; //Don't update again until "UpdateComplete" event is fired from
											  //GSX.

						//Turn on the "Data Processed" LED on Acquisition Tab
						pWnd->GetAcqTab()->GetLED1()->MomentaryOn();
					
						if(pApp->GetCalState())
						{
							if(GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCompressionActive)
							{
								//We must calculate calibration everytime because the number of points
								//is not constant
								CalibrateAverageXData();
							}
							else
							{
								if(m_bApplyCalOnce)
								{
									CalibrateAverageXData();
									m_bApplyCalOnce = false;
								}
							}
							
							
							m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
						}
						else
						{
							m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);
							
						}

					

						UpdateAnalysisInfo();
					}

					

				}
				catch(COleException* e)
				{
					TRACE("Ole Exception caught and data collection has been stopped.\n");
					e->Delete();
					bStopped = true;
					pWnd->GetAcqTab()->OnAcqStop();
				}
			}
			
			if(!bStopped)
			{
				SetTimer(AVERAGEACQUISITION, 300, NULL);
				//KillTimer(AVERAGEACQUISITION);
			}
					
		
		break;
	}
	
	CView::OnTimer(nIDEvent);
}

void CAverageView::DisplayHoverWindow()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CRect rRect;
	CPoint pPoint;
	long lPoint;
	double dataX;
	double dataY;

	m_Graph.GetWindowRect(&rRect);

	::GetCursorPos(&pPoint);

	//Make sure the cursor is over the graph
	if(rRect.PtInRect(pPoint)  && WindowFromPoint(pPoint)->GetParent()->GetSafeHwnd() == m_Graph.GetSafeHwnd()) 
	{
		//Are we hovering over a data point?
		if( m_Graph.ScalePixelToDataIndex(m_lMousePointerX, m_lMousePointerY, 1, &lPoint, TRUE) )
		{
			dataY = m_Graph.GetYValueFromIndex(1, lPoint, TRUE);
			dataX = m_Graph.GetXValueFromIndex(1, lPoint, TRUE);


			m_pHoverWnd = new CDataHover();//Create a Hover Window
			m_pHoverWnd->Create();
		
			if( ::IsWindow(m_pHoverWnd->GetSafeHwnd()) )
			{
				//Move over 1 pixel so not on top of cursor
				pPoint.x += 1;
				CRect DrawRect;
				CString Text;

				DrawRect.SetRectEmpty();

				Text.Format("%s = %g\n%s = %g",m_Graph.GetAxisXText(), dataX, m_Graph.GetAxisYText(), dataY);

				//Calculate the size of the Hover window
				m_pHoverWnd->GetWindowSize(&DrawRect, Text);
								
				CRect rect;

				rect.left = pPoint.x;
				rect.top = pPoint.y - DrawRect.Height();
				rect.right = pPoint.x + DrawRect.Width() + 4;
				rect.bottom = pPoint.y;

				m_pHoverWnd->MoveWindow(rect,TRUE);
				m_pHoverWnd->ShowWindow(SW_SHOWNA);

			}
			else TRACE("Could not create hover window");
		}
	}
	
}
bool CAverageView::RetrieveAverageActive(int iIndex)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	bool bRet = false;

	VariantClear(&m_vaAverageXData);
	VariantClear(&m_vaAverageYData);
	VariantClear(&m_vaCalXData);

	VariantInit(&m_vaAverageXData);
	VariantInit(&m_vaAverageYData);
	VariantInit(&m_vaCalXData);

	BeginWaitCursor();

	try
	{
		if( pWnd->GetICS()->GetTrendRecord(&m_vaAverageXData, &m_vaAverageYData, iIndex, 
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fSamplingInterval, 
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fRecordLength, 
			GetSettings()->m_iProtocol, 
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_iRecordsPerSpectrum,
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bEnhancer,
			FALSE, FALSE) )
		{
			if( GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bEnhancer )
			{
				m_Graph.HorzLine1(470, TRUE, FALSE);
				m_Graph.HorzLine2(-470, TRUE, FALSE);
			}
			else
			{
				m_Graph.HorzLine1(500, TRUE, FALSE);
				m_Graph.HorzLine2(-500, TRUE, FALSE);
			}

			//Turn on the "Data Processed" LED on Acquisition Tab
			pWnd->GetAcqTab()->GetLED1()->MomentaryOn();
		
			//Copy retrieved data to the cal array for calibration
			if(GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCalValid)
			{
		
				m_vaCalXData.vt = m_vaAverageXData.vt;
				SafeArrayCopy(m_vaAverageXData.parray, &m_vaCalXData.parray);
				pApp->SetCalState(1);
				
				CalibrateAverageXData();
				m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
			}
			else
			{
				pApp->SetCalState(0);
				m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);
			}
		
			UpdateAnalysisInfo();
			UpdateLabels();
			
			bRet = true;
		}

	}
	catch(COleException* e)
	{
		TRACE("Ole Exception caught.\n");
		e->Delete();
	}

	EndWaitCursor();
	
	return bRet;
}

bool CAverageView::RetrieveTrendAverageFile(CString PathName, int iIndex)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	bool bRet = false;

	VariantClear(&m_vaAverageXData);
	VariantClear(&m_vaAverageYData);
	VariantClear(&m_vaCalXData);

	VariantInit(&m_vaAverageXData);
	VariantInit(&m_vaAverageYData);
	VariantInit(&m_vaCalXData);

	BeginWaitCursor();

	pWnd->GetICS()->SetupTrendFileInfo(PathName);

	try
	{
		if( GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bEnhancer )
		{
			m_Graph.HorzLine1(470, TRUE, FALSE);
			m_Graph.HorzLine2(-470, TRUE, FALSE);
		}
		else
		{
			m_Graph.HorzLine1(500, TRUE, FALSE);
			m_Graph.HorzLine2(-500, TRUE, FALSE);
		}

		if( pWnd->GetICS()->GetTrendRecord(&m_vaAverageXData, &m_vaAverageYData, iIndex, 
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fSamplingInterval, 
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fRecordLength, 
			GetSettings()->m_iProtocol, 
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_iRecordsPerSpectrum,
			GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bEnhancer,
			FALSE, TRUE) )
		{
		


			//Turn on the "Data Processed" LED on Acquisition Tab
			pWnd->GetAcqTab()->GetLED1()->MomentaryOn();
		
			//Copy retrieved data to the cal array for calibration
			if(GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCalValid)
			{
		
				m_vaCalXData.vt = m_vaAverageXData.vt;
				SafeArrayCopy(m_vaAverageXData.parray, &m_vaCalXData.parray);
				pApp->SetCalState(1);
				
				CalibrateAverageXData();
				m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
			}
			else
			{
				pApp->SetCalState(0);
				m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);
			}
		
			UpdateAnalysisInfo();
			UpdateLabels();
			
			bRet = true;
		}

	}
	catch(COleException* e)
	{
		TRACE("Ole Exception caught.\n");
		e->Delete();
	}

	EndWaitCursor();
	
	return bRet;
}
bool CAverageView::SaveAsAverageFile(CString FilePath, CString CalPath)
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if( (_access( CalPath, 0 )) != -1 )
	{
		//Remember this as last cal path
		pApp->SetLastCalPath(CalPath);

		//load the calibration file
		CFile CalFile(CalPath, CFile::modeRead );

		CCalibration cTmpCal;

		CArchive ar(&CalFile, CArchive::load);
		cTmpCal.Serialize(ar);
		CalFile.Close();

		//Update current settings with new calibration information
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCalValid = TRUE;
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_sFileName = cTmpCal.GetFileName();
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_sUnits = cTmpCal.GetUnitsText();
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_iCalType = (int)cTmpCal.GetCalType();
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef1 = cTmpCal.GetCoef1();
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef2 = cTmpCal.GetCoef2();
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef3 = cTmpCal.GetCoef3();
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef4 = cTmpCal.GetCoef4();
	}

	SaveAverageFile( FilePath );
	if(pApp->GetMode()==AVERAGE)OpenAverageFile( FilePath, 1);

	Invalidate();

	return true;
}
bool CAverageView::SaveAverageFile(CString FilePath)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	long lNumPoints = m_vaAverageYData.parray->rgsabound->cElements; 

	ASSERT(lNumPoints > 0);

	if(lNumPoints > 0)
	{
		CFile SaveFile;
		CFileException e;

		if( SaveFile.Open( FilePath, CFile::modeCreate | CFile::modeWrite, &e ) )
		{
			try
			{
				SaveFile.Flush();

				//---------------------Save the setting Object---------------------------
				//Load the current instrument settings into the Settings object
				CArchive ar(&SaveFile, CArchive::store);
				GetSettings()->Serialize(ar);
				ar.Close();
				//-----------------------------------------------------------------------

				//----------------------Save the actual data Data----------------------
				//Number of points
				SaveFile.Write( &lNumPoints, sizeof(long));
				//File opened now write the X data
				SaveFile.Write( m_vaAverageXData.parray->pvData, lNumPoints * sizeof(double));
				//File opened now write the Y data
				SaveFile.Write( m_vaAverageYData.parray->pvData, lNumPoints * sizeof(double));
				//-----------------------------------------------------------------------
			
				SaveFile.Close();
			
			}
			catch(CFileException* e)
			{
				e->ReportError();
				e->Delete();
				return false;
			}

		}

	}
	else 
	{
		AfxMessageBox("ERROR: Attempted to save a 0 length array of Average data.");
		return false;
	}

	return true;
}
bool CAverageView::OpenAverageFile(CString FilePath, int iSeries)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	HRESULT hr;

	BeginWaitCursor();	

	VariantClear(&m_vaAverageXData);
	VariantClear(&m_vaAverageYData);
	VariantClear(&m_vaCalXData);

	VariantInit(&m_vaAverageXData);
	VariantInit(&m_vaAverageYData);
	VariantInit(&m_vaCalXData);

	CFile OpenFile;
	CFileException e;

	long lNumPoints;

	if( OpenFile.Open( FilePath, CFile::modeRead, &e ) )
	{
		try
		{
			//---------------------Load the setting Object---------------------------
			//Calibration information is in the settings object
			CArchive ar(&OpenFile, CArchive::load);
			GetSettings()->Serialize(ar);
			ar.Close();

			if( GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bEnhancer )
			{
				m_Graph.HorzLine1(470, TRUE, FALSE);
				m_Graph.HorzLine2(-470, TRUE, FALSE);
			}
			else
			{
				m_Graph.HorzLine1(500, TRUE, FALSE);
				m_Graph.HorzLine2(-500, TRUE, FALSE);
			}
			
			//-----------------------------------------------------------------------

			//----------------------Load the actual data Data----------------------
			//Number of points
			OpenFile.Read( &lNumPoints, sizeof(long));

			// Create SAFEARRAY that will contain the data
			SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array
			SAFEARRAY FAR* psaYValues = NULL;
			SAFEARRAY FAR* psaXValues = NULL;

			sabOneDim[0].cElements = lNumPoints;
			sabOneDim[0].lLbound = 1;
			
			// Create the actual SafeArray descriptors
			psaYValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaYValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
		
			V_VT(&m_vaAverageYData) = VT_ARRAY | VT_R8;
			V_ARRAY(&m_vaAverageYData) = psaYValues;

			psaXValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaXValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
		
			V_VT(&m_vaAverageXData) = VT_ARRAY | VT_R8;
			V_ARRAY(&m_vaAverageXData) = psaXValues;

			double *pdTmpYArray;
			double *pdTmpXArray;

			//Set a pointer to access the safearray data directly
			hr = SafeArrayAccessData(psaYValues, (void **)&pdTmpYArray);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			hr = SafeArrayAccessData(psaXValues, (void **)&pdTmpXArray);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			//File opened now read the X data
			OpenFile.Read( pdTmpXArray, lNumPoints * sizeof(double));
			//File opened now read the Y data
			OpenFile.Read( pdTmpYArray, lNumPoints * sizeof(double));

			hr = SafeArrayUnaccessData(psaYValues);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

			hr = SafeArrayUnaccessData(psaXValues);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

			//-----------------------------------------------------------------------
		
			OpenFile.Close();
		
		}
		catch(CFileException* e)
		{
			EndWaitCursor();	
			e->ReportError();
			e->Delete();
			return false;
		}

		//Turn on the "Data Processed" LED on Acquisition Tab
		pWnd->GetAcqTab()->GetLED1()->MomentaryOn();

		if(GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCalValid)
		{
		


			pApp->SetCalState(1);
			
			CalibrateAverageXData();
			m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, iSeries, FALSE);
		}
		else
		{
			pApp->SetCalState(0);
			m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, iSeries, FALSE);
		}

		TRACE("Updating Average Data from File.\n");
		UpdateLabels();
		UpdateAnalysisInfo();


	}

	EndWaitCursor();

	return true;
}

//Messages from the Graph
void CAverageView::OnGSXMouseDown(short Button, short Shift, long x, long y)
{
		
}
void CAverageView::OnGSXMouseUp(short Button, short Shift, long x, long y)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(Button == 1)UpdateAnalysisInfo();
	
	pWnd->SetActivePane(1);

	if(Button == 2)//Right Click
	{
		CPoint mPt;

		mPt.x=x;
		mPt.y=y;//Screen coordinates from the mouse location

		//Convert the screen coordinates to client 
		m_Graph.ClientToScreen(&mPt);

		CMenu menu;

		VERIFY(menu.LoadMenu(IDR_RIGHT_AVERAGE));
		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup);

		
		if(!GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCalValid)
		{
			pPopup->EnableMenuItem(IDM_CAL_ENABLED, MF_GRAYED);
		}
		else
		{
			if(pApp->GetCalState())pPopup->CheckMenuItem(IDM_CAL_ENABLED, MF_CHECKED);
		}
		if(pApp->GetMode() == TREND)pPopup->EnableMenuItem(ID_ADD_OVERLAY, MF_GRAYED);

		if(m_Graph.GetNumberOfSeries() < 2)
		{
			pPopup->EnableMenuItem(ID_REMOVE_OVERLAY, MF_GRAYED);
		}

		if(m_Graph.GetNumberOfSeries() > 4)
		{
			pPopup->EnableMenuItem(ID_ADD_OVERLAY, MF_GRAYED);
		}

		if( pWnd->GetCurrentTool() == Zoom )
			pPopup->CheckMenuRadioItem( ID_VIEWMODE_ZOOM, ID_VIEWMODE_MARKER, ID_VIEWMODE_ZOOM, MF_BYCOMMAND ); 
		else
			pPopup->CheckMenuRadioItem( ID_VIEWMODE_ZOOM, ID_VIEWMODE_MARKER, ID_VIEWMODE_MARKER, MF_BYCOMMAND ); 

		pPopup->TrackPopupMenu(TPM_LEFTALIGN, mPt.x, mPt.y, this );
		menu.DestroyMenu();

		m_Graph.Invalidate(FALSE);
	}

}
void CAverageView::OnGSXMouseMove(short Button, short Shift, long x, long y)
{
	static double OldX,OldY;
	CString ValueInfo;

	KillTimer(AVERAGEHOVER);
	
	m_lMousePointerX = x;
	m_lMousePointerY = y;

	if(Button == 1)UpdateAnalysisInfo();

	CMainFrame* pWnd=(CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	double dataX, dataY;

	if( m_Graph.ScalePixelToData(x,y,&dataX,&dataY) )
	{
		if(dataX != OldX || dataY !=OldY)
		{
			if(m_pHoverWnd != NULL)
			{
				m_pHoverWnd->DestroyWindow();
				delete m_pHoverWnd;
				m_pHoverWnd = NULL;
			}

			SetTimer(AVERAGEHOVER,1000,NULL);

			if(dataX != 1e308 || dataY != 1e308)
			{
				//Show mouse pointer data in status bar
				ValueInfo.Format(_T("X = %g, Y = %g"),dataX,dataY);
			}
			else ValueInfo = _T("");

			//Update XY information in the status bar
			pWnd->SetStatusBarText(1,ValueInfo);
			OldX = dataX;
			OldY = dataY;
			
		}
	}
	else 
	{
		ValueInfo = _T("");
		pWnd->SetStatusBarText(1,ValueInfo);
	}	
}
void CAverageView::OnGSXRepaint(long Hdc, long Left, long Top, long Width, long Height)
{
	TRACE("Got GSXRepaint in Average view\n");
}
void CAverageView::OnGSXClick()
{

}

void CAverageView::OnPrint(CDC* pDC, CPrintInfo* pInfo) 
{
	CRect rect;
    m_Graph.GetClientRect(rect);

	//BLOCK: Set up scale mode
	{
        int  nPageWidth,  nPageHeight;
        int  nChartWidth, nChartHeight;
        long a,           b;

		pDC->SetMapMode(MM_ANISOTROPIC);

        nPageWidth   = pDC->GetDeviceCaps(HORZRES);
        nPageHeight  = pDC->GetDeviceCaps(VERTRES);
        nChartWidth  = rect.right  - rect.left;
        nChartHeight = rect.bottom - rect.top;

        a  = nPageHeight;
        a *= nChartWidth;
        b  = nPageWidth;
        b *= nChartHeight;

        //    PH/PW < GH/GW
        // or PH*GW < PW*GH 
        if(a < b) {
            // Fill vertically, center horizontally.
		    pDC->SetWindowExt(nChartHeight, nChartHeight);
		    pDC->SetViewportExt(nPageHeight, nPageHeight);
            pDC->LPtoDP(rect);
            nChartWidth = rect.right - rect.left;
            pDC->SetViewportOrg((nPageWidth - nChartWidth) / 2, 0);
        }
        else {
            // Fill horizontally, center vertically.
		    pDC->SetWindowExt(nChartWidth, nChartWidth);
		    pDC->SetViewportExt(nPageWidth, nPageWidth);
            pDC->LPtoDP(rect);
            nChartHeight = rect.bottom - rect.top;
            pDC->SetViewportOrg(0, (nPageHeight - nChartHeight) / 2);
        }
	}

    m_Graph.GetClientRect(rect);
    ::LPtoDP(pDC->GetSafeHdc(), (POINT*)(&rect), 2);
    m_Graph.DrawToDC((long) pDC->GetSafeHdc(),//oc2dFormatEnhMetafile, oc2dScaleToFit,
                     rect.left, rect.top, (rect.right-rect.left), (rect.bottom-rect.top));	

}

BOOL CAverageView::OnPreparePrinting(CPrintInfo* pInfo) 
{
		// default preparation
	return DoPreparePrinting(pInfo);
}

void CAverageView::OnCopygraph() 
{
	m_Graph.CopyToClipboard();
}
void CAverageView::OnViewFFT() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	if(!pWnd->m_bViewingFFT)
	{
		m_pShowFFTDlg = new CShowFFT(this, GetGraph());
		m_pShowFFTDlg->Create(IDD_SHOWFFT, this);

		m_pShowFFTDlg->ShowWindow(SW_SHOW);
	}
	
}

void CAverageView::UpdateAnalysisInfo()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	double dNetArea, dGrossArea, dCentroid;
	CString Text;

	//Update the FFT View if window is Valid
	if(pWnd->m_bViewingFFT)
	{
		TRACE("Updating FFT Window.\n");
		if(GetFFTDlg())
			GetFFTDlg()->Transfer2DtoFFT();

	}

	//Only do this work if the Tab is visible!
	if(::IsWindow(pWnd->GetAnalysisTab()->GetSafeHwnd()) )
	{
		if( pWnd->GetAnalysisTab()->IsWindowVisible() )
		{
			pWnd->GetAnalysisTab()->OnMeasurements();

			Text.Format( _T("%8g"), m_Graph.GetStartMarkerPos() );
			pWnd->GetAnalysisTab()->SetDlgItemText(IDC_AVERAGE_START, Text);

			Text.Format( _T("%8g"), m_Graph.GetEndMarkerPos() );
			pWnd->GetAnalysisTab()->SetDlgItemText(IDC_AVERAGE_END, Text);
	
		}
	}

	if( ::IsWindow(pWnd->GetCalibrationTab()->GetSafeHwnd()) )
	{
		//Show this information when the Calibration Tab is visible
		if(pWnd->GetCalibrationTab()->IsWindowVisible())
		{
			long lErrorCode = m_Graph.GetAnalysisFromSelection(1, &dNetArea, &dGrossArea, &dCentroid);
			if( lErrorCode == 0 || lErrorCode == -1)
			{
				Text.Format(_T("%8g"), dCentroid);
				pWnd->GetCalibrationTab()->SetDlgItemText(IDC_MARKER_CENTROID, Text);
				pWnd->GetCalibrationTab()->SetCalCentroid(dCentroid);
				pWnd->GetCalibrationTab()->SetCalStartMarker( m_Graph.GetStartMarkerPos() );
				pWnd->GetCalibrationTab()->SetCalEndMarker( m_Graph.GetEndMarkerPos() );
			}
			else if( lErrorCode == -2)
			{
				pWnd->GetCalibrationTab()->SetDlgItemText(IDC_MARKER_CENTROID, _T("Invalid"));
				pWnd->GetCalibrationTab()->SetCalCentroid( m_Graph.GetStartMarkerPos() );
				pWnd->GetCalibrationTab()->SetCalStartMarker( m_Graph.GetStartMarkerPos() );
				pWnd->GetCalibrationTab()->SetCalEndMarker( m_Graph.GetEndMarkerPos() );
			}
		}
	}

}
void CAverageView::OnRightCalibrationEnable()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);
	
	CString Text;

	m_Graph.SetBatchMode(TRUE);

	m_Graph.SetDefaultAxis();

	//Clean up any overlays...
	RemoveAllOverlays();

	if(pApp->GetCalState())
	{
		m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);
		pApp->SetCalState(0);
	}
	else 
	{
		if(CalibrateAverageXData())
		{
			m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
			pApp->SetCalState(1);
		}
		
	}

	
	m_Graph.SetBatchMode(FALSE);

	UpdateLabels();
	UpdateAnalysisInfo();
}
bool CAverageView::CalibrateAverageXData()
{
	VariantClear(&m_vaCalXData);
	VariantInit(&m_vaCalXData);

	CCalibration ca;

	ca.Calibrate((ECalType)GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_iCalType,
				 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef1, 
				 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef2,
				 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef3, 
				 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef4);

	//Copy retrieved data to the cal array for calibration
	m_vaCalXData.vt = m_vaAverageXData.vt;
	SafeArrayCopy(m_vaAverageXData.parray, &m_vaCalXData.parray);

	ca.Apply(&m_vaCalXData);

	return true;
}
void CAverageView::OnRightGraphProperties()
{
	CGraphProperties Graph(this,&m_Graph);

	Graph.DoModal();

	UpdateLabels();

}
void CAverageView::OnRightSetMarkerTool()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	pWnd->OnViewmodeMarker();
}
void CAverageView::OnRightSetZoomTool()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	pWnd->OnViewmodeZoom();
}

//if bStore == true, transfer current graph settings to the registry, otherwise load them...
void CAverageView::GraphSettings(bool bStore)
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	ASSERT(m_Graph);

	if(bStore)//Write graph settings to registry
	{
		CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
		ASSERT(pWnd);

		pApp->WriteProfileString(_T("Average"), _T("Title Text"), m_Graph.GetTitleText() );
		pApp->WriteProfileInt(_T("Average"), _T("Title Color"), m_Graph.GetTitleTextColor() );
		pApp->WriteProfileInt(_T("Average"), _T("Grid"), m_Graph.GetGridState() );
		pApp->WriteProfileInt(_T("Average"), _T("Grid Color"), m_Graph.GetGridColor() );
		pApp->WriteProfileInt(_T("Average"), _T("Axis Color"), m_Graph.GetAxisColor() );
		pApp->WriteProfileInt(_T("Average"), _T("Log Y Axis"), m_Graph.GetAxisYLog() );
		pApp->WriteProfileInt(_T("Average"), _T("Y Axis Scale"),(int)m_eScale );
		pApp->WriteProfileInt(_T("Average"), _T("Bkg Color"), m_Graph.GetPlotAreaColor() );
		

		CString Text;
		Text = m_Graph.GetAxisXText();
		pWnd->StripAxisTextLabels( &Text );
		pApp->WriteProfileString(_T("Average"), _T("X Axis Text"), Text );
		pApp->WriteProfileString(_T("Average"), _T("Y Axis Text"), m_Graph.GetAxisYText() );

		CString Tmp; //Store the settings that are indexed by series
		for(int n=1;n<6;n++)
		{
			Tmp.Format("Symbol %d", n);
			pApp->WriteProfileInt(_T("Average"), Tmp, m_Graph.GetDataSymbol(n) );
			Tmp.Format("Symbol Color %d", n);
			pApp->WriteProfileInt(_T("Average"), Tmp, m_Graph.GetDataSymbolColor(n) );
			Tmp.Format("Symbol Size %d", n);
			pApp->WriteProfileInt(_T("Average"), Tmp, m_Graph.GetDataSymbolSize(n) );
			Tmp.Format("Line %d", n);
			pApp->WriteProfileInt(_T("Average"), Tmp, m_Graph.GetDataLine(n) );
			Tmp.Format("Line Color %d", n);
			pApp->WriteProfileInt(_T("Average"), Tmp, m_Graph.GetDataLineColor(n) );
			Tmp.Format("Line Width %d", n);
			pApp->WriteProfileInt(_T("Average"), Tmp, m_Graph.GetDataLineWidth(n) );	
		}
	}
	else
	{
		m_Graph.SetTitleText( pApp->GetProfileString(_T("Average"), _T("Title Text")) );
		m_Graph.SetTitleTextColor( pApp->GetProfileInt(_T("Average"), _T("Title Color"), 0) );
		m_Graph.SetGridState( pApp->GetProfileInt(_T("Average"), _T("Grid"), 1) );
		m_Graph.SetGridColor( pApp->GetProfileInt(_T("Average"), _T("Grid Color"), 0) );
		m_Graph.SetAxisColor( pApp->GetProfileInt(_T("Average"), _T("Axis Color"), 0) );
		m_Graph.SetAxisYLog( pApp->GetProfileInt(_T("Average"), _T("Log Y Axis"), 0) );
		m_eScale = (enumVertScale) pApp->GetProfileInt(_T("Average"), _T("Y Axis Scale"), 0);
		m_Graph.SetAxisXText( pApp->GetProfileString(_T("Average"), _T("X Axis Text")) );
		m_Graph.SetAxisYText( pApp->GetProfileString(_T("Average"), _T("Y Axis Text")) );
		m_Graph.SetPlotAreaColor( pApp->GetProfileInt(_T("Average"), _T("Bkg Color"), 0));
		m_Graph.SetChartAreaColor( pApp->GetProfileInt(_T("Average"), _T("Bkg Color"), 0));


		CString Tmp;
		for(int n=1;n<6;n++)
		{
			Tmp.Format("Symbol %d", n);
			m_Graph.SetDataSymbol(n, pApp->GetProfileInt(_T("Average"), Tmp, 0) );
			Tmp.Format("Symbol Color %d", n);
			m_Graph.SetDataSymbolColor(n, pApp->GetProfileInt(_T("Average"), Tmp, 0) );
			Tmp.Format("Symbol Size %d", n);
			m_Graph.SetDataSymbolSize(n, pApp->GetProfileInt(_T("Average"), Tmp, 2) );
			Tmp.Format("Line %d", n);
			m_Graph.SetDataLine(n, pApp->GetProfileInt(_T("Average"), Tmp, 1) );
			Tmp.Format("Line Color %d", n);
			m_Graph.SetDataLineColor(n, pApp->GetProfileInt(_T("Average"), Tmp, 0) );
			Tmp.Format("Line Width %d", n);
			m_Graph.SetDataLineWidth(n, pApp->GetProfileInt(_T("Average"), Tmp, 1) );
		}
	}
}

void CAverageView::OnDestroy() 
{
	GraphSettings(true);//Save the current settings before leaving

	CView::OnDestroy();
	
}

BOOL CAverageView::OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message) 
{
	
	return CView::OnSetCursor(pWnd, nHitTest, message);
}
void CAverageView::OnAddOverlay()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CEclipseDoc* pDoc = (CEclipseDoc*)pWnd->GetActiveDocument();
	ASSERT(pDoc);

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastOpenPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);

	VARIANT vaXData;
	VARIANT vaYData;
	VARIANT vaXCalData;

	HRESULT hr;

	static char BASED_CODE szFilter[] = "Eclipse Average Mode Files (*.flt)||";


	CFileDialog OpenFile(TRUE,NULL,_T("*.FLT"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
					     OFN_FILEMUSTEXIST | OFN_EXPLORER, szFilter, this );

	//Change the window caption
	OpenFile.m_ofn.lpstrTitle=_T("Overlay a Average Mode spectrum from disk");
	OpenFile.m_ofn.lpstrInitialDir = DirPath;

	//Start up the modal file dialog
	if(OpenFile.DoModal()==IDOK)
	{
		VariantInit(&vaXData);
		VariantInit(&vaYData);
		CFile File;
		CFileException e;

		if( File.Open( OpenFile.GetPathName(), CFile::modeRead, &e ) )
		{
			long lNumPoints;

			BeginWaitCursor();

			//---------------------Load the setting Object---------------------------
			//Calibration information is in the settings object
			CSettings OverlaySettings;
			CArchive ar(&File, CArchive::load);
			OverlaySettings.Serialize(ar);
			ar.Close();
				
			//-----------------------------------------------------------------------

			//Make sure the data is compatable!
			bool bSamplingInterval = true;
			bool bOffset = true;
			bool bCalibration = true;
			bool bRecordLength = true;

			if(OverlaySettings.ProtSettings[ OverlaySettings.m_iProtocol ].m_fSamplingInterval != 
				GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fSamplingInterval)bSamplingInterval = false;

			if(OverlaySettings.ProtSettings[ OverlaySettings.m_iProtocol ].m_fTimeOffset != 
				GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fTimeOffset)bOffset = false;

			if(OverlaySettings.ProtSettings[ OverlaySettings.m_iProtocol ].m_sFileName != 
				GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_sFileName)bCalibration = false;

			if(OverlaySettings.ProtSettings[ OverlaySettings.m_iProtocol ].m_fRecordLength != 
				GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_fRecordLength)bRecordLength = false;

			//Tell the user that one or more of the items do no match
			if(!bSamplingInterval || !bOffset || !bCalibration || !bRecordLength)
			{
				EndWaitCursor();
				CString Message;

				Message.Format(_T("Cannot overlay data because the following settings do not match: "));
				if(!bSamplingInterval)Message += _T("\n\t-Sampling Interval");
				if(!bOffset)Message += _T("\n\t-Time Offset");
				if(!bCalibration)Message += _T("\n\t-Calibration");
				if(!bRecordLength)Message += _T("\n\t-Record Length");

				AfxMessageBox(Message, MB_ICONHAND | MB_OK);
				File.Close();
				m_Graph.Invalidate(FALSE);
				return;
			}



			//----------------------Load the actual data Data----------------------
			//Number of points
			File.Read( &lNumPoints, sizeof(long));

			// Create SAFEARRAY that will contain the data
			SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array
			SAFEARRAY FAR* psaYValues = NULL;
			SAFEARRAY FAR* psaXValues = NULL;

			sabOneDim[0].cElements = lNumPoints;
			sabOneDim[0].lLbound = 1;
			
			// Create the actual SafeArray descriptors
			psaYValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaYValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
		
			V_VT(&vaYData) = VT_ARRAY | VT_R8;
			V_ARRAY(&vaYData) = psaYValues;

			psaXValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaXValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
		
			V_VT(&vaXData) = VT_ARRAY | VT_R8;
			V_ARRAY(&vaXData) = psaXValues;

			double *pdTmpYArray;
			double *pdTmpXArray;

			//Set a pointer to access the safearray data directly
			hr = SafeArrayAccessData(psaYValues, (void **)&pdTmpYArray);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			hr = SafeArrayAccessData(psaXValues, (void **)&pdTmpXArray);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			//File opened now read the X data
			File.Read( pdTmpXArray, lNumPoints * sizeof(double));
			//File opened now read the Y data
			File.Read( pdTmpYArray, lNumPoints * sizeof(double));

			hr = SafeArrayUnaccessData(psaYValues);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

			hr = SafeArrayUnaccessData(psaXValues);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));
		
			int Series = m_Graph.GetNumberOfSeries() + 1;

			if(Series <= MAXSERIES)
			{
				m_Graph.SetNumberOfSeries( Series );

				if(pApp->GetCalState())
				{
					VariantClear(&vaXCalData);
					VariantInit(&vaXCalData);

					CCalibration ca;

					ca.Calibrate((ECalType)GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_iCalType,
						 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef1, 
						 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef2,
						 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef3, 
						 GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_dCoef4);

					//Copy retrieved data to the cal array for calibration
					vaXCalData.vt = vaXData.vt;
					SafeArrayCopy(vaXData.parray, &vaXCalData.parray);

					ca.Apply(&vaXCalData);

					m_Graph.SetDataEx(&vaXCalData, &vaYData, Series, FALSE);

					VariantClear(&vaXCalData);
				}
				else
					m_Graph.SetDataEx(&vaXData, &vaYData, Series, FALSE);

				//Set Legend info
				m_Graph.SetLegendState(TRUE);
				//Only add this when we are comparing
				if(Series == 2)m_Graph.AddLegendText(pDoc->GetTitle());
				m_Graph.AddLegendText(OpenFile.GetFileTitle());

				//Clean up the safe arrays (once they are passed to GSX, don't need anymore)
				VariantClear(&vaXData);
				VariantClear(&vaYData);
				
				
			}
			File.Close();
		}

		EndWaitCursor();
		m_Graph.Invalidate(FALSE);
	}
}

void CAverageView::OnRemoveOverlay()
{
	if(m_Graph.GetNumberOfSeries() > 1)
	{
		m_Graph.SetNumberOfSeries( m_Graph.GetNumberOfSeries() - 1 );
		m_Graph.RemoveLegendText(FALSE);
		if(m_Graph.GetNumberOfSeries() == 1)
		{
			m_Graph.RemoveLegendText(FALSE);
			m_Graph.SetLegendState(FALSE);
			
		}
	}

}
void CAverageView::RemoveAllOverlays()
{
	m_Graph.SetBatchMode(TRUE);
	//Loop through all 
	while(m_Graph.GetNumberOfSeries() > 1)
	{
		m_Graph.SetNumberOfSeries( m_Graph.GetNumberOfSeries() - 1 );
		m_Graph.RemoveLegendText(FALSE);
		if(m_Graph.GetNumberOfSeries() == 1)
		{
			//On the last iteration get rid of the Legend text
			m_Graph.RemoveLegendText(FALSE);
			m_Graph.SetLegendState(FALSE);
		
		}
		
	}
	m_Graph.SetBatchMode(FALSE);
}
void CAverageView::UpdateLabels()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;

	if(pApp->GetCalState())//Currently displaying calibrated data so show user defined units
	{

		Text = m_Graph.GetAxisXText();
		pWnd->StripAxisTextLabels( &Text );

		//Disable the Trend button
		pWnd->GetInfo()->GetDlgItem(IDC_TREND_SETUP)->EnableWindow(FALSE);

		CString sUnits;
		GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_sUnits.TrimRight();
		sUnits.Format(_T(" [%s]"), GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_sUnits );
		Text += sUnits;
		m_Graph.SetAxisXText(Text);

		//Fixup the start mkr units
		CAnalysisTab* pStart = (CAnalysisTab*)pWnd->GetAnalysisTab()->GetDlgItem(IDC_AVERAGEANA_START);
		ASSERT(pStart);
		Text.Format(_T("Start%s"), sUnits);
		pStart->SetWindowText( Text );

		//Fixup the end mkr units
		CAnalysisTab* pEnd = (CAnalysisTab*)pWnd->GetAnalysisTab()->GetDlgItem(IDC_AVERAGEANA_END);
		ASSERT(pEnd);
		Text.Format(_T("End%s"), sUnits);
		pEnd->SetWindowText( Text );

		//Fixup the Centroid units
	//	CAnalysisTab* pCentroid = (CAnalysisTab*)pWnd->GetAnalysisTab()->GetDlgItem(IDC_AVERAGEANA_CENTROID);
	//	ASSERT(pCentroid);
	//	Text.Format(_T("Centroid%s"), sUnits);
	//	pCentroid->SetWindowText( Text );

	}
	else //show units as "ns"
	{
		Text = m_Graph.GetAxisXText();
		pWnd->StripAxisTextLabels( &Text );

		//Enable the Trend button
		if(!pWnd->GetIsAcqInProgress())pWnd->GetInfo()->GetDlgItem(IDC_TREND_SETUP)->EnableWindow(TRUE);

		CString sUnits;
		sUnits.Format(_T(" [ns]"));
		Text += sUnits;
		m_Graph.SetAxisXText(Text);

		//Fixup the start mkr units
		CAnalysisTab* pStart = (CAnalysisTab*)pWnd->GetAnalysisTab()->GetDlgItem(IDC_AVERAGEANA_START);
		ASSERT(pStart);
		Text = _T("Start [ns]");
		pStart->SetWindowText( Text );

		//Fixup the end mkr units
		CAnalysisTab* pEnd = (CAnalysisTab*)pWnd->GetAnalysisTab()->GetDlgItem(IDC_AVERAGEANA_END);
		ASSERT(pEnd);
		Text = _T("End [ns]");
		pEnd->SetWindowText( Text );

		//Fixup the Centroid units
	//	CAnalysisTab* pCentroid = (CAnalysisTab*)pWnd->GetAnalysisTab()->GetDlgItem(IDC_AVERAGEANA_CENTROID);
		//ASSERT(pCentroid);
		//Text = _T("Centroid [ns]");
		//pCentroid->SetWindowText( Text );

	}
	m_Graph.Invalidate();
}



void CAverageView::OnGSXUpdateComplete()
{
	m_bCanUpdate = true;
	TRACE("GSX fired - UpdateComplete - .\n");

}
void CAverageView::OnModifyData()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CModifyData md;
	HRESULT hr;

	if( md.DoModal() == IDOK)
	{
		VariantClear(&m_vaExtra);
		VariantInit(&m_vaExtra);

		double dConstValue = 1;
		long lNumPoints;

		CString strConstValue;
		strConstValue = pApp->GetConstValue();

		dConstValue = atof(strConstValue);

		//Perform the "Apply Constant" function if needed
		if( pApp->GetIsApplyConst() )
		{
			double *pdYData;
			

			hr = SafeArrayAccessData(m_vaAverageYData.parray, (void **)&pdYData);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n"));

			lNumPoints = m_vaAverageYData.parray->rgsabound->cElements; 

			if(lNumPoints > 0)
			{
				long lOperator = pApp->GetConstOperator();
				for (long i=0;i<lNumPoints;i++)
				{

					//Make the constant adjustment to the Y value
					switch( lOperator )
					{
						//Add operator
						case 0: pdYData[i] += dConstValue; break;
						//Subtract operator
						case 1: pdYData[i] -= dConstValue; break;
						//Multiply operator
						case 2: pdYData[i] *= dConstValue; break;
						//Divide operator
						case 3: pdYData[i] /= dConstValue; break;
					}
				}
			}

			hr = SafeArrayUnaccessData(m_vaAverageYData.parray);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));	

		}

		//Now perform "Combine file" function if needed
		if( pApp->GetIsCombineFile() )
		{
			LoadDataToBeCombined();

			double *pdExtraData;
			double *pdYData;

			//Set a pointer to access the safearray data directly
			hr = SafeArrayAccessData(m_vaExtra.parray, (void **)&pdExtraData);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			hr = SafeArrayAccessData(m_vaAverageYData.parray, (void **)&pdYData);
			if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			lNumPoints = m_vaAverageYData.parray->rgsabound->cElements; 

			if(lNumPoints > 0)
			{
				long lOperator = pApp->GetFileOperator();
				for (long i=0;i<lNumPoints;i++)
				{
					//Make the file based adjustment to the Y value
					switch( lOperator )
					{
						//Add operator
						case 0: pdYData[i] += pdExtraData[i]; break;
						//Subtract operator
						case 1: pdYData[i] -= pdExtraData[i]; break;
						//Multiply operator
						case 2: pdYData[i] *= pdExtraData[i]; break;
						//Divide operator
						case 3: if(pdYData[i] != 0)pdYData[i] /= pdExtraData[i]; break;
					}

				}
			}
			
			hr = SafeArrayUnaccessData(m_vaExtra.parray);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));	
			hr = SafeArrayUnaccessData(m_vaAverageYData.parray);
			if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));	
		}
	}

	//Reload data into GSX
	if(pApp->GetCalState())
	{
		if(GetSettings()->ProtSettings[ GetSettings()->m_iProtocol ].m_bCompressionActive)
		{
			//We must calculate calibration everytime because the number of points
			//is not constant
			CalibrateAverageXData();
		}
		else
		{
			if(m_bApplyCalOnce)
			{
				CalibrateAverageXData();
				m_bApplyCalOnce = false;
			}
		}
		
		
		m_Graph.SetDataEx(&m_vaCalXData, &m_vaAverageYData, 1, FALSE);
	}
	else
		m_Graph.SetDataEx(&m_vaAverageXData, &m_vaAverageYData, 1, FALSE);

	//Update the FFT window if it is up
	if(pWnd->m_bViewingFFT)
	{
		pWnd->GetAverageView()->GetFFTDlg()->Transfer2DtoFFT();
	}

	m_Graph.Invalidate();

}

void CAverageView::OnDataProps()
{
	CSelectedProperties sp;

	sp.DoModal();
}

// This function is for testing purposes only! Replace the "GetAverageDataFromInst" function call in the 
// OnTimer function to the following function. Frequency is set by the m_dIdealFreq variable
bool CAverageView::GetSynthData(VARIANT* vXArray, VARIANT* vYArray)
{
	
	HRESULT hr;

	// Create SAFEARRAY that will contain the data
	SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array 
	SAFEARRAY FAR* psaYValues = NULL;
	SAFEARRAY FAR* psaXValues = NULL;

	// Set the bounds of the SafeArray
	// (Note: must be 1-based)
	//Set cElements to the number of points that aren't -1
	sabOneDim[0].cElements = 16384;
	sabOneDim[0].lLbound = 1;

	//m_dIdealFreq = 976562.5 * 4;
	m_dIdealFreq = 4321098.32;		//Modify here to change frequency
		
	// Create the actual SafeArray descriptors
	TRACE("Creating Safearray in GetCTOFFromActiveInst\n");
	psaYValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if (psaYValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

	V_VT(vYArray) = VT_ARRAY | VT_R8;

	// Place the safearray pointer in the VARIANT
	V_ARRAY(vYArray) = psaYValues;

	// Create the actual SafeArray descriptors
	psaXValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if (psaXValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

	V_VT(vXArray) = VT_ARRAY | VT_R8;

	// Place the safearray pointer in the VARIANT
	V_ARRAY(vXArray) = psaXValues;

	double *pdYData;
	double *pdXData;

	//Set a pointer to access the safearray data directly
	hr = SafeArrayAccessData(psaYValues, (void **)&pdYData);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	hr = SafeArrayAccessData(psaXValues, (void **)&pdXData);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	double d2Pi = (double)8 * atan((double)1);
	//m_dIdealFreq = 927429.1992;
	double dTime = 0;
	double dValid = 100000;//16384 * floor(32.768e-6 * m_dIdealFreq) / (32.768e-6 * m_dIdealFreq);

	for(int iIdx = 0; iIdx < 16384; iIdx++)
	{
		dTime = iIdx * 2e-9;

		if(iIdx < dValid)
		{							  //This value is equal to DC Component
								   // |
			pdYData[ iIdx ] = (double)4.0 * sin( d2Pi*m_dIdealFreq*dTime - 1.0);
		//	pdYData[ iIdx ] = (double)4.0 * sin( d2Pi*m_dIdealFreq*dTime - 1.0) - 123.0 + 1.75 * sin( d2Pi* 9965213.2 *dTime + 2.0);
		}
		else pdYData[ iIdx ] = (double)0.0;

		if( iIdx == 5)pdYData[ iIdx ] = 10;
		if( iIdx == 6)pdYData[ iIdx ] = 20;
		if( iIdx == 7)pdYData[ iIdx ] = 10;

		

		pdXData[ iIdx ] = dTime * 1e9;
	}


	hr = SafeArrayUnaccessData(psaYValues);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

	hr = SafeArrayUnaccessData(psaXValues);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));


	return true;
}

//Added Paul Walker 160507
void CAverageView::SendDataToExternalApp(long extWindowHandle)
{
	COPYDATASTRUCT cds;
	HWND rcvWindowHandle;
	long lNumPoints = m_vaAverageXData.parray->rgsabound->cElements;

	rcvWindowHandle = (HWND)extWindowHandle;

	cds.dwData = 1;   //Array of Doubles
	cds.cbData = lNumPoints * sizeof(double); //Size in bytes of data
	cds.lpData = m_vaAverageYData.parray->pvData; //Pointer to data to send
	::SendMessage(rcvWindowHandle, WM_COPYDATA, (WPARAM) 0, (LPARAM) &cds);


	cds.lpData = m_vaAverageXData.parray->pvData; //Pointer to data to send
	::SendMessage(rcvWindowHandle, WM_COPYDATA, (WPARAM) 0, (LPARAM) &cds);

	//FILE *fid;
	//fid = fopen("C:/out.txt","w");
	//fprintf(fid,"Hello");
	//fclose(fid);
}
//End added by Paul Walker