//***************************************************************************************
//SelectedProperties.cpp : implementation file
//
//	Functions: For details on functions in this file see SelectedProperties.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "SelectedProperties.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSelectedTOFProperties dialog


CSelectedProperties::CSelectedProperties(CWnd* pParent)
	: CDialog(CSelectedProperties::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectedProperties)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

}


void CSelectedProperties::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectedProperties)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectedProperties, CDialog)
	//{{AFX_MSG_MAP(CSelectedProperties)
	ON_BN_CLICKED(ID_COPY, OnCopy)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectedProperties message handlers

BOOL CSelectedProperties::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);


	CString Tmp;

	int iProtocol = pWnd->GetAverageView()->GetSettings()->m_iProtocol;

	//General
	Tmp.Format(_T("Protocol: %d"), iProtocol);
	SetDlgItemText(IDC_SEL_PROTOCOL, Tmp);

	int iMaxAcqTime = pWnd->GetAverageView()->GetSettings()->m_iMaxAcqTime;

	if(iMaxAcqTime == 0)
	{
		Tmp.Format(_T("Maximum Acquisition Time: Disabled"), iMaxAcqTime);
	}
	else
	{
		Tmp.Format(_T("Maximum Acquisition Time: %d s"), iMaxAcqTime);
	}

	SetDlgItemText(IDC_SEL_MAXACQTIME, Tmp);

	int iAveragesPerTrend = pWnd->GetAverageView()->GetSettings()->m_iAveragesPerTrend;

	if( iAveragesPerTrend == 0)
	{
		Tmp.Format("Stopped after: Disabled");
	}
	else
		Tmp.Format(_T("Stopped after: %d averages"), iAveragesPerTrend);

	SetDlgItemText(IDC_SEL_SPECTRAPER, Tmp);

//	if( pWnd->GetAverageView()->GetSettings()->m_bRapidProtocol )Tmp.Format(_T("Rapid Protocol: Enabled"));
//	else Tmp.Format(_T("Rapid Protocol: Disabled"));
//	SetDlgItemText(IDC_SEL_RPS, Tmp);

	if( pWnd->GetAverageView()->GetSettings()->m_bTriggerEnablePolarity )Tmp.Format(_T("Trigger Enable Polarity: +"));
	else Tmp.Format(_T("Trigger Enable Polarity: -"));
	SetDlgItemText(IDC_SEL_TRIGPOL, Tmp);

	//iProtocol used to index the protocol specific settings
	
	//Protocol specific
	Tmp.Format(_T("Record Length: %f us"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fRecordLength);
	SetDlgItemText(IDC_SEL_RECLEN, Tmp);

	Tmp.Format(_T("Records per Average: %d"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iRecordsPerSpectrum);
	SetDlgItemText(IDC_SEL_RECPERSPEC, Tmp);

	Tmp.Format(_T("Sampling Interval: %1.1f ns"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fSamplingInterval);
	SetDlgItemText(IDC_SEL_SAMPINTER, Tmp);

	Tmp.Format(_T("Time Offset: %f us"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fTimeOffset);
	SetDlgItemText(IDC_SEL_TIMEOFFSET, Tmp);

	Tmp.Format(_T("Vertical Offset: %f V"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fVerticalOffset);
	SetDlgItemText(IDC_SEL_VERTOFFSET, Tmp);

	Tmp.Format(_T("End-of-Scan DeadTime: %f us"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fEOSDeadTime);
	SetDlgItemText(IDC_SEL_EOSDEAD, Tmp);

	if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_bEnhancer )Tmp.Format(_T("Enhancer: Enabled"));
	else Tmp.Format(_T("Enhancer: Disabled"));
	SetDlgItemText(IDC_SEL_ENHANCER, Tmp);

	if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_bCalValid)
	{
		if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iCalType == 0)
			Tmp.Format(_T("Calibration Type: Linear"));
		else if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iCalType == 1)
			Tmp.Format(_T("Calibration Type: Quadratic"));
		else if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iCalType == 2)
			Tmp.Format(_T("Calibration Type: Cubic"));
		else Tmp.Format(_T("Calibration Type: Unknown"));
		SetDlgItemText(IDC_SEL_CALTYPE, Tmp);

		Tmp.Format(_T("Calibration Filename: %s"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_sFileName);
		SetDlgItemText(IDC_SEL_CALNAME, Tmp);
	}
	else
	{
		SetDlgItemText(IDC_SEL_CALTYPE, _T(""));
		SetDlgItemText(IDC_SEL_CALNAME, _T(""));
	}

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CSelectedProperties::OnCopy() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	if(!pWnd->OpenClipboard())return;
	if(!::EmptyClipboard())return;

	CString Tmp,AllText;
	AllText.Empty();

	int iProtocol = pWnd->GetAverageView()->GetSettings()->m_iProtocol;

	Tmp.Format(_T("FileName: %s\r\n"), pWnd->GetActiveDocument()->GetTitle());
	AllText += Tmp;

	//General
	Tmp.Format(_T("Protocol: %d\r\n"), iProtocol);
	AllText += Tmp;

	if( pWnd->GetAverageView()->GetSettings()->m_iMaxAcqTime == 0)
	{
		Tmp.Format(_T("Maximum Acquisition Time: Disabled\r\n"));
	}
	else
		Tmp.Format(_T("Maximum Acquisition Time: %d s\r\n"), pWnd->GetAverageView()->GetSettings()->m_iMaxAcqTime);
	AllText += Tmp;

	if( pWnd->GetAverageView()->GetSettings()->m_iAveragesPerTrend == 0)
	{
		Tmp.Format(_T("Stopped After: Disabled\r\n"));
	}
	else
		Tmp.Format(_T("Stopped After: %d averages\r\n"), pWnd->GetAverageView()->GetSettings()->m_iAveragesPerTrend);
	AllText += Tmp;

	if( pWnd->GetAverageView()->GetSettings()->m_bTriggerEnablePolarity )Tmp.Format(_T("Trigger Enable Polarity: +\r\n"));
	else Tmp.Format(_T("Trigger Enable Polarity: -\r\n"));
	AllText += Tmp;

	//iProtocol used to index the protocol specific settings
	
	//Protocol specific
	Tmp.Format(_T("Record Length: %f us\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fRecordLength);
	AllText += Tmp;

	Tmp.Format(_T("Records per Average: %d\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iRecordsPerSpectrum);
	AllText += Tmp;

	Tmp.Format(_T("Sampling Interval: %1.1f ns\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fSamplingInterval);
	AllText += Tmp;

	Tmp.Format(_T("Time Offset: %f us\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fTimeOffset);
	AllText += Tmp;

	Tmp.Format(_T("Vertical Offset: %f V\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fVerticalOffset);
	AllText += Tmp;

	Tmp.Format(_T("End-of-Scan DeadTime: %f us\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_fEOSDeadTime);
	AllText += Tmp;

	if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_bEnhancer )Tmp.Format(_T("Enhancer: Enabled\r\n"));
	else Tmp.Format(_T("Enhancer: Disabled\r\n"));
	AllText += Tmp;

	if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_bCalValid)
	{
		if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iCalType == 0)
			Tmp.Format(_T("Calibration Type: Linear\r\n"));
		else if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iCalType == 1)
			Tmp.Format(_T("Calibration Type: Quadratic\r\n"));
		else if( pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_iCalType == 2)
			Tmp.Format(_T("Calibration Type: Cubic\r\n"));
		else Tmp.Format(_T("Calibration Type: Unknown\r\n"));
		AllText += Tmp;

		Tmp.Format(_T("Calibration Filename: %s\r\n"), pWnd->GetAverageView()->GetSettings()->ProtSettings[iProtocol].m_sFileName);
		AllText += Tmp;
	}
	//Place the string into the clipboard

	HGLOBAL hglbCopy;
	LPTSTR lptstrCopy;

	//Allocate a global memory object for the text. 
    hglbCopy = GlobalAlloc(GMEM_DDESHARE, AllText.GetLength() + 1);
	
	lptstrCopy = (LPTSTR)GlobalLock(hglbCopy); 
    memcpy(lptstrCopy, AllText, AllText.GetLength() + 1 * sizeof(TCHAR)); 
            
    ::GlobalUnlock(hglbCopy); 
 
    // Place the handle on the clipboard. 
    ::SetClipboardData(CF_TEXT, hglbCopy); 

	::CloseClipboard();
	

}
