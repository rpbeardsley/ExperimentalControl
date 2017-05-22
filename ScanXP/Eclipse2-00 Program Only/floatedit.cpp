//***************************************************************************************
//FloatEdit.cpp : implementation file
//
//	Functions: For details on functions in this file see FloatEdit.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "FloatEdit.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFloatEdit

CFloatEdit::CFloatEdit()
{
	m_bAllowNegative = true;
}

CFloatEdit::~CFloatEdit()
{
}


BEGIN_MESSAGE_MAP(CFloatEdit, CEdit)
	//{{AFX_MSG_MAP(CFloatEdit)
	ON_WM_CHAR()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFloatEdit message handlers

void CFloatEdit::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	static CString ValidChars;
	
	if(m_bAllowNegative)ValidChars = _T(".,+-eE\b");
	else ValidChars = _T(".,+eE\b");

	TCHAR tChar = (TCHAR) nChar;

	if((IsCharAlphaNumeric(tChar) && !IsCharAlpha(tChar)) || ValidChars.Find(nChar) != -1)
	{
		CEdit::OnChar(nChar, nRepCnt, nFlags);
	}
	else MessageBeep(MB_ICONASTERISK);
}
