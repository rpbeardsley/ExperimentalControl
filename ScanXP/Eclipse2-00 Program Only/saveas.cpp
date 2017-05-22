//***************************************************************************************
//SaveAs.cpp : implementation file
//
//	Functions: For details on functions in this file see SaveAs.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "MainFrm.h"
#include "SaveAs.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSaveAs

IMPLEMENT_DYNAMIC(CSaveAs, CFileDialog)

CSaveAs::CSaveAs(BOOL bOpenFileDialog, LPCTSTR lpszDefExt, LPCTSTR lpszFileName,
		DWORD dwFlags, LPCTSTR lpszFilter, CWnd* pParentWnd, CString* pCalPath) :
		CFileDialog(bOpenFileDialog, lpszDefExt, lpszFileName, dwFlags, lpszFilter, pParentWnd)
{
	//This adds our controls to the common file dialog
	SetTemplate(0, IDD_CUSTOM_FILEOPEN);
	m_pCalPath = pCalPath;
}


BEGIN_MESSAGE_MAP(CSaveAs, CFileDialog)
	//{{AFX_MSG_MAP(CSaveAs)
	ON_BN_CLICKED(IDC_SAVEAS_BROWSE, OnSaveasBrowse)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


BOOL CSaveAs::OnInitDialog() 
{
	CFileDialog::OnInitDialog();

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	ASSERT(pWnd->GetAverageView());
	CString Text;
	
	Text.Format(_T("%s"), pWnd->GetAverageView()->GetSettings()->
		ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_sFileName);

	SetDlgItemText(IDC_SAVEAS_CALPATH, Text);
	
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
void CSaveAs::OnInitDone()
{
	CFileDialog::OnInitDone();

	//Move the OK and Cancel buttons down to make the dialog look better
	CButton* pOKButton = (CButton*)GetParent()->GetDlgItem(IDOK);
	ASSERT(pOKButton);

	CButton* pCANCELButton = (CButton*)GetParent()->GetDlgItem(IDCANCEL);
	ASSERT(pCANCELButton);

	CRect cRect;
	CRect oRect;
	CRect newcRect;

	pOKButton->GetWindowRect(&oRect);
	pCANCELButton->GetWindowRect(&cRect);

	GetParent()->ScreenToClient(&oRect);
	GetParent()->ScreenToClient(&cRect);

	newcRect = cRect;
	newcRect.top = cRect.top + (cRect.top - oRect.top);
	newcRect.bottom = cRect.bottom + (cRect.bottom - oRect.bottom);

	pCANCELButton->MoveWindow(&newcRect,TRUE);
	pOKButton->MoveWindow(&cRect,TRUE);

}

void CSaveAs::OnSaveasBrowse() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastCalPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);

	static char BASED_CODE szFilter[] = "Calibration Files (*.CAL)|All Files (*.*)|*.*||";

	CFileDialog OpenFile(TRUE,NULL,_T("*.CAL"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_FILEMUSTEXIST | OFN_EXPLORER, szFilter ,this );

	//Change the window caption
	OpenFile.m_ofn.lpstrTitle=_T("Retrieve a Eclipse Calibration from disk");
	OpenFile.m_ofn.lpstrInitialDir = DirPath;

	//Start up the modal file dialog
	if(OpenFile.DoModal()==IDOK)
	{
		*m_pCalPath = OpenFile.GetPathName();
		m_sCalName = OpenFile.GetFileTitle();
		SetDlgItemText(IDC_SAVEAS_CALPATH, OpenFile.GetFileTitle() );
	}
}
