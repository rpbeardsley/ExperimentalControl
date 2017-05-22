//***************************************************************************************
//InfoBar.cpp : implementation file
//
//	Functions: For details on functions in this file see InfoBar.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************

#include "stdafx.h"
#include "InfoBar.h"
#include "MainFrm.h"

#ifndef __AFXWIN_H__
	#include <afxwin.h>
#endif
#ifndef __AFXDLGS_H__
	#include <afxdlgs.h>
#endif

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define new DEBUG_NEW

CInfoBar::CInfoBar()
{
	//Initialize the CWnd*, this will be used to store the pointer form the "CreateControlBar"
	//function which is pointed to by the current experiment
	m_pInfoWnd = NULL;
	m_pInfoDlg = NULL;
	TRACE("Info Bar Constructor\n");
}

CInfoBar::~CInfoBar()
{
	if(m_pInfoDlg)
	{
		delete m_pInfoDlg;
		m_pInfoDlg = NULL;
	}

	//Destroy the window created to house the window
	DestroyWindow();   

}

BOOL CInfoBar::Create(CWnd* pParentWnd, UINT nStyle, UINT nID)
{
	
	CRect rect;
	rect.SetRectEmpty();

	CString szWndClass=AfxRegisterWndClass(NULL,AfxGetApp()->LoadStandardCursor(IDC_ARROW),(HBRUSH)(COLOR_3DFACE+1),NULL);
	BOOL Result=CWnd::Create(szWndClass,NULL,nStyle | WS_CHILD,rect,pParentWnd,nID);

	SetWindowText(_T("Trend Bar"));
	if(!Result)
		return FALSE;

	m_pInfoDlg = new CInfoBarDlg;

	m_pInfoDlg->Create(IDD_INFOBAR, this);

	//Get the size of the Status window
	m_pInfoDlg->GetWindowRect(&rect);
		
	//Store the size, to be used for sizing the experiment bar
	rect.left-=4;
	rect.right+=4;
	rect.top-=4;
	rect.bottom+=4;
	m_sizeDefault = rect.Size();

	ShowWindow(SW_SHOW);

	m_pInfoDlg->MoveWindow(4,4,m_sizeDefault.cx-8,m_sizeDefault.cy-8,TRUE);
	m_pInfoDlg->ShowWindow(SW_SHOW);


	return TRUE;
}

CSize CInfoBar::CalcFixedLayout(BOOL bStretch, BOOL bHorz)
{
	if (bStretch) // if not docked stretch to fit
		return CSize(bHorz ? 32767 : m_sizeDefault.cx,
			bHorz ? m_sizeDefault.cy : 32767);
	else
		return m_sizeDefault;
}

void CInfoBar::OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler)
{
	UpdateDialogControls(pTarget, bDisableIfNoHndler);
}



#ifdef AFX_INIT_SEG
#pragma code_seg(AFX_INIT_SEG)
#endif


///////////////////////////////////////////////////////////////////////////
