#if !defined(AFX_GRAPHPROPERTIES_H__149DA301_DDC7_11D1_9113_0060089615C2__INCLUDED_)
#define AFX_GRAPHPROPERTIES_H__149DA301_DDC7_11D1_9113_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// GraphProperties.h : header file
//
#include "GSX2.h"

/////////////////////////////////////////////////////////////////////////////
// CGraphProperties dialog

class CGraphProperties : public CDialog
{
// Construction
public:
	CGraphProperties(CWnd* pParent = NULL,CGSX2* pGraph = NULL,bool bAverage = true);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CGraphProperties)
	enum { IDD = IDD_GRAPH_PROPS };
	CScrollBar	m_SymbolSizeSB;
	BOOL	m_bSymbols;
	CString	m_XAxisText;
	CString	m_YAxisText;
	//}}AFX_DATA

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGraphProperties)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	CGSX2* m_pGraph;
	bool m_bAverage;

	// Generated message map functions
	//{{AFX_MSG(CGraphProperties)
	afx_msg void OnSymbols();
	virtual BOOL OnInitDialog();
	afx_msg void OnSelchangeSymbolsColor();
	afx_msg void OnSelchangeSymbolsType();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnLines();
	afx_msg void OnSelchangeLinesColor();
	afx_msg void OnSelchangeLinesWidth();
	afx_msg void OnGrid();
	afx_msg void OnSelchangeGridColor();
	afx_msg void OnSelchangeAxisColor();
	afx_msg void OnAxisLog();
	afx_msg void OnUpdateAxisXtext();
	afx_msg void OnUpdateAxisYtext();
	afx_msg void OnOverlayPropsButton();
	afx_msg void OnSelchangeBkgColor();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GRAPHPROPERTIES_H__149DA301_DDC7_11D1_9113_0060089615C2__INCLUDED_)
