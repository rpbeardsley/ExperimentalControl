#if !defined(AFX_AVERAGESAVEDLG_H__A9A3E421_E74C_11D1_912F_0060089615C2__INCLUDED_)
#define AFX_AVERAGESAVEDLG_H__A9A3E421_E74C_11D1_912F_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// CAverageSaveDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CAverageSaveDlg dialog

class CAverageSaveDlg : public CDialog
{
// Construction
public:
	CAverageSaveDlg(CWnd* pParent = NULL,CString* pName = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CAverageSaveDlg)
	enum { IDD = IDD_TREND_SAVE };
	CListBox	m_DirList;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCTOFSaveDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	CString* m_pName;
	CString m_NewName;

	// Generated message map functions
	//{{AFX_MSG(CAverageSaveDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnUpdateName();
	virtual void OnOK();
	afx_msg void OnSelchangeDirFiles();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_AVERAGESAVEDLG_H__A9A3E421_E74C_11D1_912F_0060089615C2__INCLUDED_)
