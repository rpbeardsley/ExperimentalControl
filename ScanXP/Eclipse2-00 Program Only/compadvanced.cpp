//***************************************************************************************
//CompAdvanced.cpp : implementation file
//
//	Functions: For details on functions in this file see CompAdvanced.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "CompAdvanced.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCompAdvanced dialog


CCompAdvanced::CCompAdvanced(CWnd* pParent, int iProtocol)
	: CDialog(CCompAdvanced::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCompAdvanced)
	m_fProtect = 0.0f;
	m_sWidthBack = 0;
	m_sWidthMax = 0;
	m_sWidthMin = 0;
	m_sPeriodBack = 0;
	//}}AFX_DATA_INIT

	m_iProtocol = iProtocol;
}


void CCompAdvanced::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCompAdvanced)
	DDX_Text(pDX, IDC_PROTECT, m_fProtect);
	DDX_Text(pDX, IDC_WIDTHBACK, m_sWidthBack);
	DDX_Text(pDX, IDC_WIDTHMAX, m_sWidthMax);
	DDX_Text(pDX, IDC_WIDTHMIN, m_sWidthMin);
	DDX_Text(pDX, IDC_PERIOD_BACK, m_sPeriodBack);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCompAdvanced, CDialog)
	//{{AFX_MSG_MAP(CCompAdvanced)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCompAdvanced message handlers

BOOL CCompAdvanced::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	m_RingProtect.SubclassDlgItem(IDC_PROTECT, this);

/*	CString Str;

	try
	{
		Str.Format(_T("%d"), pWnd->GetICS()->GetBackgroundSpacing(m_iProtocol) );
		SetDlgItemText(IDC_PERIOD_BACK, Str);

		Str.Format(_T("%d"), pWnd->GetICS()->GetNumberBKGPoints(m_iProtocol) );
		SetDlgItemText(IDC_WIDTHBACK, Str);

		Str.Format(_T("%d"), pWnd->GetICS()->GetMaxPeakWidth(m_iProtocol) );
		SetDlgItemText(IDC_WIDTHMAX, Str);

		Str.Format(_T("%d"), pWnd->GetICS()->GetMinPeakWidth(m_iProtocol) );
		SetDlgItemText(IDC_WIDTHMIN, Str);

		Str.Format(_T("%f"), pWnd->GetICS()->GetProtectTime(m_iProtocol) );
		SetDlgItemText(IDC_PROTECT, Str);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}*/


	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CCompAdvanced::OnOK() 
{
	//Set instrument parameters
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	UpdateData();

/*	try
	{

		pWnd->GetICS()->SetBackgroundSpacing(m_iProtocol, m_sPeriodBack);
		pWnd->GetICS()->SetNumberBKGPoints(m_iProtocol, m_sWidthBack);
		pWnd->GetICS()->SetMaxPeakWidth(m_iProtocol, m_sWidthMax);
		pWnd->GetICS()->SetMinPeakWidth(m_iProtocol, m_sWidthMin);
		pWnd->GetICS()->SetProtectTime(m_iProtocol, m_fProtect);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}*/
	
	CDialog::OnOK();
}
