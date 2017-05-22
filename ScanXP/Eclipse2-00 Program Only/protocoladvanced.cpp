//***************************************************************************************
//ProtocolAdvanced.cpp : implementation file
//
//	Functions: For details on functions in this file see ProtocolAdvanced.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************

#include "stdafx.h"
#include "Eclipse.h"
#include "ProtocolAdvanced.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CProtocolAdvanced dialog


CProtocolAdvanced::CProtocolAdvanced(CWnd* pParent, int iProtocol)
	: CDialog(CProtocolAdvanced::IDD, pParent)
{
	//{{AFX_DATA_INIT(CProtocolAdvanced)
	m_fDeadTime = 0.0f;
	m_bEnhancer = FALSE;
	//}}AFX_DATA_INIT

	m_iProtocol = iProtocol;
}


void CProtocolAdvanced::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CProtocolAdvanced)
	DDX_Text(pDX, IDC_DEADTIME, m_fDeadTime);
	DDX_Check(pDX, IDC_ENHANCER, m_bEnhancer);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CProtocolAdvanced, CDialog)
	//{{AFX_MSG_MAP(CProtocolAdvanced)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CProtocolAdvanced message handlers

BOOL CProtocolAdvanced::OnInitDialog() 
{
	CDialog::OnInitDialog();
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	m_DeadTime.SubclassDlgItem(IDC_DEADTIME, this);

	try
	{
		((CButton*)GetDlgItem(IDC_ENHANCER))->SetCheck( pWnd->GetICS()->GetEnhancer(m_iProtocol) );
		CString Str;

		Str.Format(_T("%f"), pWnd->GetICS()->GetDeadTime(m_iProtocol) );
		SetDlgItemText(IDC_DEADTIME, Str);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CProtocolAdvanced::OnOK() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	UpdateData();

	try
	{
		pWnd->GetICS()->SetDeadTime(m_iProtocol, m_fDeadTime);
		pWnd->GetICS()->SetEnhancer(m_iProtocol, m_bEnhancer);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}	
	CDialog::OnOK();
}
