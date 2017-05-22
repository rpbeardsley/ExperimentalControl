// UpdateDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ProgressDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CProgressDlg dialog


CProgressDlg::CProgressDlg(int AiMaxProgress,CWnd* pParent /*=NULL*/)
	: TMyDialog(CProgressDlg::IDD,pParent) {
    iMaxProgress = AiMaxProgress;
}
void CProgressDlg::SetProgress(int AiProgress,const char* pszMessage) {
    iProgress = AiProgress;
    if (m_Progress.GetSafeHwnd())
        m_Progress.SetPos(iProgress);
    if (pszMessage) {
        strMessage = pszMessage;
        HWND hwndStatic = GetSafeHwnd() ? ::GetDlgItem(*this,IDS_CAPTION) : 0;
        if (hwndStatic) 
            ::SetWindowText(hwndStatic,strMessage);
    }
}
void CProgressDlg::SetMaxProgress(int i) {
    iMaxProgress = i;
    if (m_Progress.GetSafeHwnd())
	    m_Progress.SetRange32(0,iMaxProgress);
}
BOOL CProgressDlg::OnInitDialog() {
    TMyDialog::OnInitDialog();
    SetMaxProgress(iMaxProgress);
    SetProgress(iProgress,strMessage);
    BeginWaitCursor();
    return TRUE;
}
void CProgressDlg::DoDataExchange(CDataExchange* pDX) {
	TMyDialog::DoDataExchange(pDX);
	DDX_Control(pDX,IDC_PROGRESS,m_Progress);
}
BEGIN_MESSAGE_MAP(CProgressDlg, TMyDialog)
    ON_WM_NCDESTROY()
END_MESSAGE_MAP()
void CProgressDlg::OnNcDestroy() {
    EndWaitCursor();
    TMyDialog::OnNcDestroy();
}

