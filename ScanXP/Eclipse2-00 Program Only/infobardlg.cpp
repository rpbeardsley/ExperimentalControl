//***************************************************************************************
//InfoBarDlg.cpp : implementation file
//
//	Functions: For details on functions in this file see InfoBarDlg.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include <shlobj.h>
#include "Eclipse.h"
#include "InfoBarDlg.h"
#include "TrendSetup.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CInfoBarDlg dialog


CInfoBarDlg::CInfoBarDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CInfoBarDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CInfoBarDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

}


void CInfoBarDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CInfoBarDlg)

	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CInfoBarDlg, CDialog)
	//{{AFX_MSG_MAP(CInfoBarDlg)
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDC_INFO_BROWSE, OnInfoBrowse)
	ON_BN_CLICKED(IDC_TREND_SETUP, OnTrendSetup)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CInfoBarDlg message handlers

void CInfoBarDlg::OnDestroy() 
{
	CDialog::OnDestroy();
	
}

BOOL CInfoBarDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);
	
	SetDlgItemText( IDC_INFO_DATADIR, pApp->GetDataDir() );

	if( !pApp->GetIsDSPPresent() )
	{
		GetDlgItem(IDC_INFO_DATADIR)->EnableWindow(FALSE);
		GetDlgItem(IDC_INFO_BROWSE)->EnableWindow(FALSE);
	}

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CInfoBarDlg::OnInfoBrowse() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	BROWSEINFO   bi;
	LPITEMIDLIST il;
	
	char DirPath[_MAX_PATH];

	bi.hwndOwner		= GetSafeHwnd();
	bi.pidlRoot			= NULL;
	bi.lpszTitle		= "Select Trend Data Destination Folder";
	bi.pszDisplayName	= NULL;
	bi.ulFlags			= BIF_RETURNONLYFSDIRS;
	bi.lpfn				= BrowseDestProc;
				
	il=SHBrowseForFolder(&bi);
	SHGetPathFromIDList(il, DirPath);

	if(DirPath[0] != NULL)
	{
		pApp->SetDataDir( DirPath );
		SetDlgItemText( IDC_INFO_DATADIR, pApp->GetDataDir() );
	}

	IMalloc* pMalloc; 
	SHGetMalloc(&pMalloc);
	pMalloc->Free(il);
	
}

int CALLBACK CInfoBarDlg::BrowseDestProc(HWND hwnd,UINT uMsg,LPARAM lParam,LPARAM lpData)
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);	

	switch(uMsg)
	{
	
		case BFFM_INITIALIZED:

			
			char DirPath[_MAX_PATH];
			lstrcpy(DirPath, pApp->GetDataDir());

			::SendMessage(hwnd,BFFM_SETSELECTION,TRUE,(LPARAM)DirPath);//Set StartUp path
				
		break;
		case BFFM_SELCHANGED:
			
			
		break;

	}

	return TRUE;
}

void CInfoBarDlg::OnTrendSetup() 
{
	CTrendSetup ts;

	ts.DoModal();
	
}
