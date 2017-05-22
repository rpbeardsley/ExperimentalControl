#if !defined(AFX_FLOATEDIT_H__C027B991_9C84_11D1_BBFE_0060089615C2__INCLUDED_)
#define AFX_FLOATEDIT_H__C027B991_9C84_11D1_BBFE_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// FloatEdit.h : header file
//

//****************************
//NOTE: This class is used for subclassing an Edit control for a Number only control
//****************************

/////////////////////////////////////////////////////////////////////////////
// CFloatEdit window

class CFloatEdit : public CEdit
{
// Construction
public:
	CFloatEdit();

	virtual void DoNotAllowNegative(){m_bAllowNegative=false;}

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFloatEdit)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CFloatEdit();

	// Generated message map functions
protected:
	bool m_bAllowNegative;

	//{{AFX_MSG(CFloatEdit)
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FLOATEDIT_H__C027B991_9C84_11D1_BBFE_0060089615C2__INCLUDED_)
