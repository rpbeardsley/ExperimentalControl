//***************************************************************************************
//DataHover.cpp : implementation file
//
//	Functions: For details on functions in this file see DataHover.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "DataHover.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDataHover

CDataHover::CDataHover()
{

}

CDataHover::~CDataHover()
{
}


BEGIN_MESSAGE_MAP(CDataHover, CWnd)
	//{{AFX_MSG_MAP(CDataHover)
	ON_WM_PAINT()
	ON_WM_NCHITTEST()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
// CDataHover message handlers

BOOL CDataHover::PreCreateWindow(CREATESTRUCT& cs) 
{

	return CWnd::PreCreateWindow(cs);
}
bool CDataHover::Create()
{
	CString szWndClass=AfxRegisterWndClass(0,NULL,(HBRUSH)(COLOR_INFOBK+1),NULL);
			
	CreateEx(WS_EX_TOOLWINDOW,szWndClass,NULL,WS_POPUP | WS_BORDER,0,0,0,0,NULL,0,NULL);
		
	return true;
}


void CDataHover::GetWindowSize(CRect* pRect,CString Text)
{
	m_Text = Text;

	CDC* pDC = GetDC();

	//Need a height to create the font with
	int nHeight =  -((pDC->GetDeviceCaps(LOGPIXELSY) * 12) / 72);
	int iXRes = pDC->GetDeviceCaps(HORZRES);

	CFont BetterFont;
	BetterFont.CreateFont(nHeight,0,0,0,FW_NORMAL,0,0,0,DEFAULT_CHARSET,
			  			   OUT_CHARACTER_PRECIS, CLIP_CHARACTER_PRECIS,DEFAULT_QUALITY,
						   DEFAULT_PITCH | FF_DONTCARE, "Arial");

	TEXTMETRIC tm;

	CFont* pOldFont = pDC->SelectObject(&BetterFont);

	pDC->GetTextMetrics(&tm);
	int iCharHeight = tm.tmHeight;
	int iXOffset = tm.tmAveCharWidth * 10;


	pDC->DrawText(m_Text, pRect, DT_CALCRECT);

	m_DrawRect.SetRectEmpty();
	m_DrawRect.right = pRect->Width() + 2;
	m_DrawRect.bottom = pRect->Height();

	pDC->SelectObject(pOldFont);

	ReleaseDC(pDC);
}

void CDataHover::OnPaint() 
{
	CPaintDC dc(this); // device context for painting

	dc.SetBkMode(TRANSPARENT);

	//Need a height to create the font with
	int nHeight =  -((dc.GetDeviceCaps(LOGPIXELSY) * 10) / 72);
	int iXRes = dc.GetDeviceCaps(HORZRES);

	CFont BetterFont;
	BetterFont.CreateFont(nHeight,0,0,0,FW_NORMAL,0,0,0,DEFAULT_CHARSET,
			  			   OUT_CHARACTER_PRECIS, CLIP_CHARACTER_PRECIS,DEFAULT_QUALITY,
						   DEFAULT_PITCH | FF_DONTCARE, "Arial");

	TEXTMETRIC tm;

	CFont* pOldFont = dc.SelectObject(&BetterFont);

	dc.GetTextMetrics(&tm);
	int iCharHeight = tm.tmHeight;
	int iXOffset = tm.tmAveCharWidth * 10;

	dc.DrawText(m_Text,m_DrawRect,DT_CENTER);

	dc.SelectObject(pOldFont);

	
	// Do not call CWnd::OnPaint() for painting messages
}

UINT CDataHover::OnNcHitTest(CPoint point) 
{
	UINT uRet;
	//Always make this transparent so that the underlying window gets the "MouseMove" 
	//messages
	uRet = HTTRANSPARENT;
	return uRet;
}
