//***************************************************************************************
//AcquisitionTab.cpp : implementation file
//
//	Functions: For details on functions in this file see Acquisition.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************
 
#include "stdafx.h"
#include "Eclipse.h"
#include "MainFrm.h"
#include "AcquisitionTab.h"
#include "SelectedProperties.h"
#include "EclipseDoc.h"
#include "ShowFFT.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define UPDATESTATUS    9

/////////////////////////////////////////////////////////////////////////////
// CAcquisitionTab dialog


CAcquisitionTab::CAcquisitionTab(CWnd* pParent /*=NULL*/)
	: CDialog(CAcquisitionTab::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAcquisitionTab)
	m_ModeGroup = TREND;
	//}}AFX_DATA_INIT

}


void CAcquisitionTab::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAcquisitionTab)
	DDX_Control(pDX, IDC_ACQ_LED_2, m_LED1);
	DDX_Control(pDX, IDC_ACQ_LED_3, m_LED2);
	DDX_Radio(pDX, IDC_MODE_AVERAGE, m_ModeGroup);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAcquisitionTab, CDialog)
	//{{AFX_MSG_MAP(CAcquisitionTab)
	ON_BN_CLICKED(IDC_INST_PROPS, OnInstProps)
	ON_WM_TIMER()
	ON_WM_DESTROY()
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_MODE_TREND, OnModeTrend)
	ON_BN_CLICKED(IDC_MODE_AVERAGE, OnModeAverage)
	ON_BN_CLICKED(IDC_ACQ_START, OnAcqStart)
	ON_BN_CLICKED(IDC_ACQ_STOP, OnAcqStop)
	ON_BN_CLICKED(IDC_REALTIME, OnRealtime)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAcquisitionTab message handlers

void CAcquisitionTab::OnInstProps() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);
	
	pWnd->OnProperties();
}


void CAcquisitionTab::OnAcqStart() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseDoc* pDoc = (CEclipseDoc*)pWnd->GetActiveDocument();
	ASSERT(pDoc);

	SetDlgItemText(IDC_ELAPSED_TIME, _T(""));
	SetDlgItemText(IDC_SPECTRA_ACQ, _T(""));

	GetDlgItem(IDC_MODE_TREND)->EnableWindow(FALSE);
	GetDlgItem(IDC_MODE_AVERAGE)->EnableWindow(FALSE);
	GetDlgItem(IDC_ACQ_START)->EnableWindow(FALSE);
	GetDlgItem(IDC_REALTIME)->EnableWindow(FALSE);
	GetDlgItem(IDC_DISPLAY)->EnableWindow(FALSE);

	pWnd->GetInfo()->GetDlgItem(IDC_TREND_SETUP)->EnableWindow(FALSE);
	pWnd->GetInfo()->GetDlgItem(IDC_INFO_BROWSE)->EnableWindow(FALSE);
	pWnd->GetInfo()->GetDlgItem(IDC_INFO_DATADIR)->EnableWindow(FALSE);

	
	if(m_ModeGroup == 1)pWnd->StartTrendAcquisition();
	else pWnd->StartAverageAcquisition();

	SetTimer(UPDATESTATUS,500,NULL);

	pDoc->SetTitle(_T("Untitled"));

}

void CAcquisitionTab::OnAcqStop() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	KillTimer(UPDATESTATUS);

	GetDlgItem(IDC_MODE_TREND)->EnableWindow(TRUE);
	GetDlgItem(IDC_MODE_AVERAGE)->EnableWindow(TRUE);
	if(pApp->GetMode() == TREND)
	{
		GetDlgItem(IDC_REALTIME)->EnableWindow(TRUE);
		GetDlgItem(IDC_DISPLAY)->EnableWindow(TRUE);
		pWnd->GetInfo()->GetDlgItem(IDC_TREND_SETUP)->EnableWindow(TRUE);
		pWnd->GetInfo()->GetDlgItem(IDC_INFO_BROWSE)->EnableWindow(TRUE);
		pWnd->GetInfo()->GetDlgItem(IDC_INFO_DATADIR)->EnableWindow(TRUE);

	}
	
	if(m_ModeGroup == 1)
	{
		pWnd->StopTrendAcquisition();
	}
	else 
	{
		pWnd->StopAverageAcquisition();		
	}
	pWnd->GetAverageView()->UpdateLabels();
	GetDlgItem(IDC_ACQ_START)->EnableWindow(TRUE);
}

BOOL CAcquisitionTab::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if( !pApp->GetIsInstrumentPresent())
	{
		GetDlgItem(IDC_ACQ_START)->EnableWindow(FALSE);
		GetDlgItem(IDC_ACQ_STOP)->EnableWindow(FALSE);
		GetDlgItem(IDC_INST_PROPS)->EnableWindow(FALSE);
	}

	m_LED1.SetColor(1);
	m_LED2.SetColor(4);
	m_LED2.SetMomentaryTime(50);


	//Always start up in mode that was last chosen
	if(pApp->GetLastMode() == TREND)
	{
		((CButton*)GetDlgItem(IDC_MODE_TREND))->SetCheck(TRUE);
		((CButton*)GetDlgItem(IDC_MODE_AVERAGE))->SetCheck(FALSE);
		m_ModeGroup = TREND;
	}
	else
	{
		((CButton*)GetDlgItem(IDC_MODE_AVERAGE))->SetCheck(TRUE);
		((CButton*)GetDlgItem(IDC_MODE_TREND))->SetCheck(FALSE);
		m_ModeGroup = AVERAGE;
	}

	((CButton*)GetDlgItem(IDC_REALTIME))->SetCheck( pApp->GetLastRealTime() );
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CAcquisitionTab::OnTimer(UINT nIDEvent) 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString ElapsedTimeText;
	CString SpectraText;


	switch(nIDEvent)
	{
		case UPDATESTATUS:


			try
			{
				int iET = pWnd->GetICS()->GetTimeElapsed();
				ElapsedTimeText.Format(_T("%d seconds"), iET);
				SetDlgItemText(IDC_ELAPSED_TIME, ElapsedTimeText);

				if(pApp->GetMode() == TREND)
				{
					int iNumRecords = pWnd->GetICS()->GetRecords();
					SpectraText.Format(_T("%d"), iNumRecords );
					SetDlgItemText(IDC_SPECTRA_ACQ, SpectraText);

					if( pApp->GetIsMaxNumberUsed() )
					{
						if( iNumRecords > pApp->GetMaxNumber() )OnAcqStop();
					}
				}
				else //Average mode
				{
					if( pApp->GetIsMaxNumberUsed() )
					{
						if(pWnd->GetAverageView()->GetNumberOfAverages() >= pApp->GetMaxNumber() )OnAcqStop();
					}

					//Added Paul Walker 160507
					if( pWnd->GetIsStartedExternally() > 0 )
					{
						if(pWnd->GetAverageView()->GetNumberOfAverages() >= 1 )
						{

							
							long extWindowHandle;
							

							CAverageView* pAverageView = (CAverageView*)pWnd->GetActiveView();
							ASSERT( pAverageView );

							extWindowHandle = pWnd->GetIsStartedExternally();

							OnAcqStop();
							pWnd->SetNotStartedExternally();

							pAverageView->SendDataToExternalApp( extWindowHandle );

						}
					}
					//End added by Paul Walker


				}

				//If we are a timed run... stop when time
				if(pApp->GetIsMaxTimeUsed())
				{
					if( iET >= pApp->GetMaxTime() )OnAcqStop();
				}
			}
			catch(COleException* e)
			{
				TRACE("Ole Exception occured.\n");
				e->Delete();
				
			}

		break;
	}
	
	CDialog::OnTimer(nIDEvent);
}

BOOL CAcquisitionTab::DestroyWindow() 
{

	KillTimer(UPDATESTATUS);
	
	return CDialog::DestroyWindow();
}


void CAcquisitionTab::OnModeTrend() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	pApp->SetMode(TREND);

	UpdateData();
	
}

void CAcquisitionTab::OnModeAverage() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	pApp->SetMode(AVERAGE);

	UpdateData();
	
}


void CAcquisitionTab::OnDestroy() 
{

	KillTimer(UPDATESTATUS);

	CDialog::OnDestroy();

}

void CAcquisitionTab::OnClose() 
{

	
	CDialog::OnClose();
}

void CAcquisitionTab::OnRealtime() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	pApp->SetLastRealTime( ((CButton*)GetDlgItem(IDC_REALTIME))->GetCheck() );	
}
void CAcquisitionTab::OnCancel()
{
	//Don't do anything
	return;
}
void CAcquisitionTab::OnOK()
{
	//Don't do anything
	return;
}