#if !defined(AFX_PROTOCOLADVANCED_H__DAA54FB1_DC3E_11D1_9111_0060089615C2__INCLUDED_)
#define AFX_PROTOCOLADVANCED_H__DAA54FB1_DC3E_11D1_9111_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// ProtocolAdvanced.h : header file
//
#include "FloatEdit.h"

/////////////////////////////////////////////////////////////////////////////
// CProtocolAdvanced dialog

class CProtocolAdvanced : public CDialog
{
// Construction
public:
	CProtocolAdvanced(CWnd* pParent = NULL,int iProtocol = 0);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CProtocolAdvanced)
	enum { IDD = IDD_PROTOCOL_ADVANCED };
	float	m_fDeadTime;
	BOOL	m_bEnhancer;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CProtocolAdvanced)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	int m_iProtocol;
	CFloatEdit m_DeadTime;
	// Generated message map functions
	//{{AFX_MSG(CProtocolAdvanced)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PROTOCOLADVANCED_H__DAA54FB1_DC3E_11D1_9111_0060089615C2__INCLUDED_)
