//***************************************************************************************
//PropSheet.cpp : implementation file
//
//	Functions: For details on functions in this file see PropSheet.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "PropSheet.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPropSheet

IMPLEMENT_DYNAMIC(CPropSheet, CPropertySheet)

CPropSheet::CPropSheet(UINT nIDCaption, CWnd* pParentWnd, UINT iSelectPage)
	:CPropertySheet(nIDCaption, pParentWnd, iSelectPage)
{
		AddPage(&m_Page1);
		AddPage(&m_Page2);
		AddPage(&m_Page3);
		AddPage(&m_Page4);
		AddPage(&m_Page5);
		AddPage(&m_Page6);
		AddPage(&m_Page7);
		AddPage(&m_Page8);
		AddPage(&m_Page9);
}

CPropSheet::CPropSheet(LPCTSTR pszCaption, CWnd* pParentWnd, UINT iSelectPage)
	:CPropertySheet(pszCaption, pParentWnd, iSelectPage)
{
		AddPage(&m_Page1);
		AddPage(&m_Page2);
		AddPage(&m_Page3);
		AddPage(&m_Page4);
		AddPage(&m_Page5);
		AddPage(&m_Page6);
		AddPage(&m_Page7);
		AddPage(&m_Page8);
		AddPage(&m_Page9);
}

CPropSheet::~CPropSheet()
{
}


BEGIN_MESSAGE_MAP(CPropSheet, CPropertySheet)
	//{{AFX_MSG_MAP(CPropSheet)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPropSheet message handlers

BOOL CPropSheet::OnInitDialog() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	BOOL bResult = CPropertySheet::OnInitDialog();

	
	return bResult;
}

