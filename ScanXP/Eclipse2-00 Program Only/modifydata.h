#if !defined(AFX_MODIFYDATA_H__8068BDE2_35CE_11D2_A0B6_0060089615C2__INCLUDED_)
#define AFX_MODIFYDATA_H__8068BDE2_35CE_11D2_A0B6_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// ModifyData.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CModifyData dialog
#include "FloatEdit.h"


class CModifyData : public CDialog
{
// Construction
public:
	CModifyData(CWnd* pParent = NULL, bool bSaveSettings = true);   // standard constructor

	virtual void EnableFileProps(bool);
	virtual void EnableConstProps(bool);
	virtual void UpdateImages();

// Dialog Data
	//{{AFX_DATA(CModifyData)
	enum { IDD = IDD_MODIFY_DATA };
	CButton	m_FileOperator;
	CButton	m_ApplyOperator;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CModifyData)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	CFloatEdit m_ConstValue;
	CString m_FilePath;
	CString m_Filename;

	int m_iConstOperator;
	int m_iFileOperator;
	bool m_bSaveSettings;

	// Generated message map functions
	//{{AFX_MSG(CModifyData)
	virtual BOOL OnInitDialog();
	afx_msg void OnFileCombine();
	afx_msg void OnApplyConstant();
	afx_msg void OnFileBrowse();
	virtual void OnOK();
	afx_msg void OnDestroy();
	afx_msg void OnApplyOperator();
	afx_msg void OnFileOperator();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MODIFYDATA_H__8068BDE2_35CE_11D2_A0B6_0060089615C2__INCLUDED_)
