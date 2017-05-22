
#if !defined __INFOBAR_H
#define __INFOBAR_H

#ifndef __AFXWIN_H__
	#include <afxwin.h>
#endif
#ifndef __AFXDLGS_H__
	#include <afxdlgs.h>
#endif

#include "InfoBarDlg.h"

class CInfoBar : public CControlBar
{

// Construction
public:
	CInfoBar();
	virtual ~CInfoBar();

	BOOL Create(CWnd* pParentWnd, UINT nStyle, UINT nID);

	virtual CSize CalcFixedLayout(BOOL bStretch, BOOL bHorz);
	virtual void OnUpdateCmdUI(CFrameWnd* pTarget, BOOL bDisableIfNoHndler);

	virtual CWnd* GetInfoWnd(){return m_pInfoWnd;}
	virtual CDialog* GetInfoDlg(){return m_pInfoDlg;}

	CSize m_sizeDefault;
protected:
	CWnd* m_pInfoWnd;

	CDialog* m_pInfoDlg;

};

#endif

