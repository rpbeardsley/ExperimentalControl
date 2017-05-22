#if !defined(AFX_ADDCALITEM_H__7C9058A3_06C5_11D2_A086_0060089615C2__INCLUDED_)
#define AFX_ADDCALITEM_H__7C9058A3_06C5_11D2_A086_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// AddCalItem.h : header file
//
#include "floatedit.h"

/////////////////////////////////////////////////////////////////////////////
// CAddCalItem dialog

class CAddCalItem : public CDialog
{
// Construction
public:
	CAddCalItem(CWnd* pParent = NULL, CString Time = "", CString* pCalValue = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CAddCalItem)
	enum { IDD = IDD_ADD_ITEM };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAddCalItem)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	CString m_Time;
	CString* m_pCalValue;

	CFloatEdit m_FloatEdit;

	// Generated message map functions
	//{{AFX_MSG(CAddCalItem)
	virtual BOOL OnInitDialog();
	afx_msg void OnUpdateCalValue();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ADDCALITEM_H__7C9058A3_06C5_11D2_A086_0060089615C2__INCLUDED_)
