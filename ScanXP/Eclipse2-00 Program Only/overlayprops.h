#if !defined(AFX_OVERLAYPROPS_H__0005B340_FFD7_11D1_9167_0060089615C2__INCLUDED_)
#define AFX_OVERLAYPROPS_H__0005B340_FFD7_11D1_9167_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// OverlayProps.h : header file
//
#include "GSX2.h"
/////////////////////////////////////////////////////////////////////////////
// COverlayProps dialog

class COverlayProps : public CDialog
{
// Construction
public:
	COverlayProps(CWnd* pParent = NULL, CGSX2* pGraph = NULL);   // standard constructor

	virtual void LoadSelectedProperties();
	virtual void EnableSymbolProps(bool);
	virtual void EnableLineProps(bool);


// Dialog Data
	//{{AFX_DATA(COverlayProps)
	enum { IDD = IDD_OVERLAY_PROPS };
	CScrollBar	m_SymbolSizeSB;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COverlayProps)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	int m_iSelectedOverlay;
	CGSX2* m_pGraph;

	// Generated message map functions
	//{{AFX_MSG(COverlayProps)
	virtual BOOL OnInitDialog();
	afx_msg void OnLines();
	afx_msg void OnSymbols();
	afx_msg void OnSelchangeOverlayNumber();
	afx_msg void OnSelchangeLinesColor();
	afx_msg void OnSelchangeLinesWidth();
	afx_msg void OnSelchangeSymbolsColor();
	afx_msg void OnSelchangeSymbolsType();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_OVERLAYPROPS_H__0005B340_FFD7_11D1_9167_0060089615C2__INCLUDED_)
