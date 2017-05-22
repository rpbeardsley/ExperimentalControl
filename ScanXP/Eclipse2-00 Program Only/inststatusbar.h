// InstStatusBar.h
#if !defined __INSTSTATUSBAR_H
#define __INSTSTATUSBAR_H

#ifndef __AFXWIN_H__
	#include <afxwin.h>
#endif
#ifndef __AFXDLGS_H__
	#include <afxdlgs.h>
#endif

#include "InstStatusBarDlg.h"

class CInstStatusBar : public CControlBar
{

// Construction
public:
	CInstStatusBar();
	virtual ~CInstStatusBar();
	
	BOOL Create(CWnd* pParentWnd, UINT nStyle, UINT nID);
	
	virtual CSize CalcFixedLayout(BOOL bStretch, BOOL bHorz);
	virtual void OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler);

	virtual CWnd* GetStatusWnd(){return m_pInstStatusWnd;}
	virtual CDialog* GetStatusDlg(){return m_pInstStatusDlg;}

	CSize m_sizeDefault;
protected:
	CWnd* m_pInstStatusWnd;

	CDialog* m_pInstStatusDlg;



};

#endif

