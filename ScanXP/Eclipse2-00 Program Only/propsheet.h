#if !defined(AFX_PROPSHEET_H__2862DF53_B79A_11D1_90A9_0060089615C2__INCLUDED_)
#define AFX_PROPSHEET_H__2862DF53_B79A_11D1_90A9_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// PropSheet.h : header file
//
#include "PropGeneralPage.h"
#include "PropProtocol1Page.h"
#include "PropProtocol2Page.h"
#include "PropProtocol3Page.h"
#include "PropProtocol4Page.h"
#include "PropProtocol5Page.h"
#include "PropProtocol6Page.h"
#include "PropProtocol7Page.h"
#include "PropProtocol8Page.h"

/////////////////////////////////////////////////////////////////////////////
// CPropSheet

class CPropSheet : public CPropertySheet
{
	DECLARE_DYNAMIC(CPropSheet)

// Construction
public:
	CPropSheet(UINT nIDCaption, CWnd* pParentWnd = NULL, UINT iSelectPage = 0);
	CPropSheet(LPCTSTR pszCaption, CWnd* pParentWnd = NULL, UINT iSelectPage = 0);

// Attributes
public:

protected:

	CPropGeneralPage   m_Page1;
	CPropProtocol1Page m_Page2;
	CPropProtocol2Page m_Page3;
	CPropProtocol3Page m_Page4;
	CPropProtocol4Page m_Page5;
	CPropProtocol5Page m_Page6;
	CPropProtocol6Page m_Page7;
	CPropProtocol7Page m_Page8;
	CPropProtocol8Page m_Page9;

// Operations
public:


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPropSheet)
	public:
	virtual BOOL OnInitDialog();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CPropSheet();

	// Generated message map functions
protected:
	//{{AFX_MSG(CPropSheet)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PROPSHEET_H__2862DF53_B79A_11D1_90A9_0060089615C2__INCLUDED_)
