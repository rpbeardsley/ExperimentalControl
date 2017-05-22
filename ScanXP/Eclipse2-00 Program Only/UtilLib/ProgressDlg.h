#if !defined(__ProgressDlg_h)
#define __ProgressDlg_h

#include "MyControls.h"

#ifndef __UtilLibResource_h
#define __UtilLibResource_h
#include "UtilLibResource.h"
#endif

/////////////////////////////////////////////////////////////////////////////
// CUpdateDlg dialog

class CProgressDlg : public TMyDialog
{
public:
	CProgressDlg(int iMaxProgress = 100,CWnd* pParent = NULL);   // standard constructor
	enum { IDD = IDD_PROGRESS };
    void SetProgress(int iProgress,const char* pszMessage = 0);
    void SetMaxProgress(int i);
protected:
    CString strMessage;
    int iMaxProgress;
    int iProgress;
    virtual BOOL OnInitDialog();
    void DoDataExchange(CDataExchange* pDX);
	CProgressCtrl m_Progress;
	DECLARE_MESSAGE_MAP()
    afx_msg void OnNcDestroy();
};

#endif // !defined(__ProgressDlg_h)
