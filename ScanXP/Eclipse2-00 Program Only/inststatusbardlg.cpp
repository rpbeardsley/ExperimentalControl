//***************************************************************************************
//InstStatusBarDlg.cpp : implementation file
//
//	Functions: For details on functions in this file see InstStatusBarDlg.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "InstStatusBarDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CInstStatusBarDlg dialog


CInstStatusBarDlg::CInstStatusBarDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CInstStatusBarDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CInstStatusBarDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

}


void CInstStatusBarDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CInstStatusBarDlg)
	DDX_Control(pDX, IDC_STATUSTAB, m_StatusTab);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CInstStatusBarDlg, CDialog)
	//{{AFX_MSG_MAP(CInstStatusBarDlg)
	ON_NOTIFY(TCN_SELCHANGE, IDC_STATUSTAB, OnSelchangeStatustab)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CInstStatusBarDlg message handlers


BOOL CInstStatusBarDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	

	m_tcAcqItem.mask = TCIF_TEXT;
	m_tcAcqItem.pszText = ("Acquisition");
	m_tcAcqItem.cchTextMax = 11;

	m_tcCalItem.mask = TCIF_TEXT;
	m_tcCalItem.pszText = ("Calibration");
	m_tcCalItem.cchTextMax = 11;

	m_tcAnaItem.mask = TCIF_TEXT;
	m_tcAnaItem.pszText = ("Analysis");
	m_tcAnaItem.cchTextMax = 13;

	m_StatusTab.InsertItem(0,&m_tcAcqItem);
	m_StatusTab.InsertItem(1,&m_tcCalItem);
	m_StatusTab.InsertItem(2,&m_tcAnaItem);

	m_AcqTab.Create(IDD_ACQTAB, this);
	m_CalTab.Create(IDD_CALTAB, this);
	m_AnaTab.Create(IDD_ANATAB, this);

	//Show the Acq tab controls
	CRect rect;
	m_StatusTab.GetWindowRect(&rect);
	SendDlgItemMessage(IDC_STATUSTAB,TCM_ADJUSTRECT,(WPARAM)FALSE,(LPARAM)&rect);
	m_StatusTab.ScreenToClient(&rect);
	m_AcqTab.MoveWindow(rect,true);
	m_AcqTab.ShowWindow(SW_SHOW);
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CInstStatusBarDlg::OnSelchangeStatustab(NMHDR* pNMHDR, LRESULT* pResult) 
{
	if(pNMHDR->idFrom == IDC_STATUSTAB)
	{
		int iSel = ((CTabCtrl*)GetDlgItem(IDC_STATUSTAB))->GetCurSel();

		CRect rect;

		switch(iSel)
		{
			case 0:
				m_CalTab.ShowWindow(SW_HIDE);
				m_AnaTab.ShowWindow(SW_HIDE);

				m_StatusTab.GetWindowRect(&rect);
				SendDlgItemMessage(IDC_STATUSTAB,TCM_ADJUSTRECT,(WPARAM)FALSE,(LPARAM)&rect);
				m_StatusTab.ScreenToClient(&rect);
				m_AcqTab.MoveWindow(rect,true);
				m_AcqTab.ShowWindow(SW_SHOW);

			break;
			case 1:
				m_AcqTab.ShowWindow(SW_HIDE);
				m_AnaTab.ShowWindow(SW_HIDE);

				m_StatusTab.GetWindowRect(&rect);
				SendDlgItemMessage(IDC_STATUSTAB,TCM_ADJUSTRECT,(WPARAM)FALSE,(LPARAM)&rect);
				m_StatusTab.ScreenToClient(&rect);
				m_CalTab.MoveWindow(rect,true);
				m_CalTab.ShowWindow(SW_SHOW);

			break;
			case 2:
				m_AcqTab.ShowWindow(SW_HIDE);
				m_CalTab.ShowWindow(SW_HIDE);
			
				m_StatusTab.GetWindowRect(&rect);
				SendDlgItemMessage(IDC_STATUSTAB,TCM_ADJUSTRECT,(WPARAM)FALSE,(LPARAM)&rect);
				m_StatusTab.ScreenToClient(&rect);
				m_AnaTab.MoveWindow(rect,true);
				m_AnaTab.ShowWindow(SW_SHOW);

			break;

		}
		
	}
	
	*pResult = 0;
}
void CInstStatusBarDlg::OnCancel()
{
	//Don't do anything
	return;
}
void CInstStatusBarDlg::OnOK()
{
	//Don't do anything
	return;
}