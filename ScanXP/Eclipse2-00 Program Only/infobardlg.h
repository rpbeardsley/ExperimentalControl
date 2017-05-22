#if !defined(AFX_INFOBARDLG_H__27F59146_C34F_11D1_90D0_0060089615C2__INCLUDED_)
#define AFX_INFOBARDLG_H__27F59146_C34F_11D1_90D0_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// InfoBarDlg.h : header file
//
#include "resource.h"


/////////////////////////////////////////////////////////////////////////////
// CInfoBarDlg dialog

class CInfoBarDlg : public CDialog
{
// Construction
public:
	CInfoBarDlg(CWnd* pParent = NULL);   // standard constructor


	static int CALLBACK BrowseDestProc(HWND,UINT,LPARAM,LPARAM);

// Dialog Data
	//{{AFX_DATA(CInfoBarDlg)
	enum { IDD = IDD_INFOBAR };

	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInfoBarDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:


	// Generated message map functions
	//{{AFX_MSG(CInfoBarDlg)
	afx_msg void OnDestroy();
	virtual BOOL OnInitDialog();
	afx_msg void OnInfoBrowse();
	afx_msg void OnTrendSetup();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INFOBARDLG_H__27F59146_C34F_11D1_90D0_0060089615C2__INCLUDED_)
