//***************************************************************************************
//CAverageSaveDlg.cpp : implementation file
//
//	Functions: For details on functions in this file see CTOFSaveDlg.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "AverageSaveDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAverageSaveDlg dialog


CAverageSaveDlg::CAverageSaveDlg(CWnd* pParent, CString* pName)
	: CDialog(CAverageSaveDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAverageSaveDlg)
	//}}AFX_DATA_INIT
	m_pName = pName;
	m_NewName = *pName;
}


void CAverageSaveDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAverageSaveDlg)
	DDX_Control(pDX, IDC_DIR_FILES, m_DirList);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAverageSaveDlg, CDialog)
	//{{AFX_MSG_MAP(CAverageSaveDlg)
	ON_EN_UPDATE(IDC_NAME, OnUpdateName)
	ON_LBN_SELCHANGE(IDC_DIR_FILES, OnSelchangeDirFiles)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAverageSaveDlg message handlers

BOOL CAverageSaveDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString DirPath( pApp->GetDataDir() );

	SetDlgItemText(IDC_DATA_DIR, DirPath);

	m_DirList.Dir(0, DirPath + "\\*.FFC");

	//Get rid of the temporary file name if found
	int TempIdx = m_DirList.FindString(-1, _T("__ICS__TMP.FFC"));

	if(TempIdx != LB_ERR)
	{
		m_DirList.DeleteString(TempIdx);
	}
	

	if(m_NewName.IsEmpty())
	{
		GetDlgItem(IDOK)->EnableWindow(FALSE);
	}
	else
	{
		SetDlgItemText(IDC_NAME, m_NewName);
		GetDlgItem(IDOK)->EnableWindow(TRUE);
	}
	
	GetDlgItem(IDC_NAME)->SetFocus();
	((CEdit*)GetDlgItem(IDC_NAME))->SetSel(0,-1);//Select text
	
	// TODO: Add extra initialization here
	
	return FALSE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CAverageSaveDlg::OnUpdateName() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function to send the EM_SETEVENTMASK message to the control
	// with the ENM_UPDATE flag ORed into the lParam mask.
	
	// TODO: Add your control notification handler code here
	GetDlgItemText(IDC_NAME, m_NewName);


	if(m_NewName.IsEmpty())GetDlgItem(IDOK)->EnableWindow(FALSE);
	else GetDlgItem(IDOK)->EnableWindow(TRUE);
	

}

void CAverageSaveDlg::OnOK() 
{
	CString Tmp;

	Tmp = m_NewName;
	Tmp.MakeUpper();

	if( m_DirList.FindString(-1, m_NewName) != LB_ERR )
	{
		if( AfxMessageBox("Overwrite the current file?", MB_YESNO) == IDYES)
		{
			if(Tmp.Find(_T(".FFC")) != -1)
			{	
				m_NewName = m_NewName.Left( m_NewName.GetLength() - 4 );
			}

			*m_pName = m_NewName;
		}
		else *m_pName = _T("");
	}
	else 
	{
		if(Tmp.Find(_T(".FFC")) != -1)
		{	
			m_NewName = m_NewName.Left( m_NewName.GetLength() - 4 );
		}
		*m_pName = m_NewName;//Set text to current selection
	}

	CDialog::OnOK();
}

void CAverageSaveDlg::OnSelchangeDirFiles() 
{
	CString Text;

	m_DirList.GetText( m_DirList.GetCurSel(), Text );
	SetDlgItemText( IDC_NAME, Text );

	GetDlgItem(IDC_NAME)->SetFocus();
	((CEdit*)GetDlgItem(IDC_NAME))->SetSel(0,-1);//Select text

}
