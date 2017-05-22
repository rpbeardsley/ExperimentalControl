// RecalcTrendDlg.cpp : implementation file
//

#include "stdafx.h"
#include "eclipse.h"
#include "RecalcTrendDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CRecalcTrendDlg dialog


CRecalcTrendDlg::CRecalcTrendDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CRecalcTrendDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CRecalcTrendDlg)
	//}}AFX_DATA_INIT
}


void CRecalcTrendDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CRecalcTrendDlg)
	DDX_Control(pDX, IDC_PROGRESS1, m_Progess);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CRecalcTrendDlg, CDialog)
	//{{AFX_MSG_MAP(CRecalcTrendDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CRecalcTrendDlg message handlers
