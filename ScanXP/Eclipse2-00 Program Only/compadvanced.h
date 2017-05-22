#if !defined(AFX_COMPADVANCED_H__B9D9B422_DBA8_11D1_9110_0060089615C2__INCLUDED_)
#define AFX_COMPADVANCED_H__B9D9B422_DBA8_11D1_9110_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// CompAdvanced.h : header file
//
#include "FloatEdit.h"

/////////////////////////////////////////////////////////////////////////////
// CCompAdvanced dialog

class CCompAdvanced : public CDialog
{
// Construction
public:
	CCompAdvanced(CWnd* pParent = NULL, int iProtocol = 0);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CCompAdvanced)
	enum { IDD = IDD_COMP_ADVANCED };
	float	m_fProtect;
	short	m_sWidthBack;
	short	m_sWidthMax;
	short	m_sWidthMin;
	short	m_sPeriodBack;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCompAdvanced)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	int m_iProtocol;
	CFloatEdit m_RingProtect;

	// Generated message map functions
	//{{AFX_MSG(CCompAdvanced)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COMPADVANCED_H__B9D9B422_DBA8_11D1_9110_0060089615C2__INCLUDED_)
