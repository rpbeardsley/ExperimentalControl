//***************************************************************************************
//AddCalItem.cpp : implementation file
//
//	Functions: For details on functions in this file see AddCalItem.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************
#include "stdafx.h"
#include "Eclipse.h"
#include "AddCalItem.h" 

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAddCalItem dialog


CAddCalItem::CAddCalItem(CWnd* pParent,CString Time, CString* pCalValue)
	: CDialog(CAddCalItem::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAddCalItem)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

	m_Time = Time;
	m_pCalValue = pCalValue;
	
}


void CAddCalItem::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAddCalItem)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAddCalItem, CDialog)
	//{{AFX_MSG_MAP(CAddCalItem)
	ON_EN_UPDATE(IDC_CAL_VALUE, OnUpdateCalValue)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAddCalItem message handlers

BOOL CAddCalItem::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CString Tmp;

	m_FloatEdit.SubclassDlgItem(IDC_CAL_VALUE, this);

	GetDlgItem(IDOK)->EnableWindow(FALSE);

	if(!m_Time.IsEmpty())
	{
		Tmp.Format(_T("Time of %sns ="), m_Time);	
		SetDlgItemText(IDC_CAL_TIME, Tmp);
	}
	else 
	{
		SetDlgItemText(IDC_CAL_TIME, _T("No marker selection"));
		GetDlgItem(IDC_CAL_VALUE)->EnableWindow(FALSE);
	}
	
	GetDlgItem(IDC_CAL_VALUE)->SetFocus();
	
	return FALSE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CAddCalItem::OnUpdateCalValue() 
{
	CString Tmp;

	GetDlgItemText(IDC_CAL_VALUE, Tmp);

	*m_pCalValue = Tmp;

	if(Tmp.IsEmpty())GetDlgItem(IDOK)->EnableWindow(FALSE);
	else GetDlgItem(IDOK)->EnableWindow(TRUE);
	
}

void CAddCalItem::OnOK() 
{
	
	
	CDialog::OnOK();
}
