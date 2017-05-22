#if !defined(AFX_DATAHOVER_H__363D69C1_2097_11D1_9BE2_004005253168__INCLUDED_)
#define AFX_DATAHOVER_H__363D69C1_2097_11D1_9BE2_004005253168__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// DataHover.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDataHover window


class CDataHover : public CWnd
{
// Construction
public:
	CDataHover();
	virtual void GetWindowSize(CRect*,CString);

	virtual bool Create();

// Attributes
public:

// Operations
public:

protected:


	CRect m_DrawRect;
	CString m_Text;


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDataHover)
	protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CDataHover();

	// Generated message map functions
protected:
	//{{AFX_MSG(CDataHover)
	afx_msg void OnPaint();
	afx_msg UINT OnNcHitTest(CPoint point);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DATAHOVER_H__363D69C1_2097_11D1_9BE2_004005253168__INCLUDED_)
