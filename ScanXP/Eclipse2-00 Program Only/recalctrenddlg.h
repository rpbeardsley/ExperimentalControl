#if !defined(AFX_RECALCTRENDDLG_H__9B771622_75BA_11D2_A131_0060089615C2__INCLUDED_)
#define AFX_RECALCTRENDDLG_H__9B771622_75BA_11D2_A131_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// RecalcTrendDlg.h : header file
//
#include "resource.h"

/////////////////////////////////////////////////////////////////////////////
// CRecalcTrendDlg dialog

class CRecalcTrendDlg : public CDialog
{
// Construction
public:
	CRecalcTrendDlg(CWnd* pParent = NULL);   // standard constructor


// Dialog Data
	//{{AFX_DATA(CRecalcTrendDlg)
	enum { IDD = IDD_RECALC_DLG };
	CProgressCtrl	m_Progess;
	//}}AFX_DATA

	CProgressCtrl* GetProgressBar(){return &m_Progess;}

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CRecalcTrendDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CRecalcTrendDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_RECALCTRENDDLG_H__9B771622_75BA_11D2_A131_0060089615C2__INCLUDED_)
