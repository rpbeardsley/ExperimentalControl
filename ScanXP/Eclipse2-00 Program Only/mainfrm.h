// MainFrm.h : interface of the CMainFrame class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAINFRM_H__27F5913A_C34F_11D1_90D0_0060089615C2__INCLUDED_)
#define AFX_MAINFRM_H__27F5913A_C34F_11D1_90D0_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "TrendView.h"
#include "AverageView.h"
#include "InstStatusBar.h"
#include "InfoBar.h"
#include "ICS.h"
#include "AcquisitionTab.h"
#include "AnalysisTab.h"
#include "InfoBar.h"
#include "InfoBarDlg.h"
#include "CalibrationTab.h"

#define MAXSERIES 8

#define WM_MYMESSAGE (WM_USER + 1)

enum enumTools
{
	Marker,
	Zoom
};

enum enumSmooth
{
	None,
	ThreePt,
	FivePt
};

class CMainFrame : public CFrameWnd
{
protected: // create from serialization only
	CMainFrame();
	DECLARE_DYNCREATE(CMainFrame)

// Attributes
protected:
	CSplitterWnd m_wndSplitter;
	long m_iStartedExternally; //Added Paul Walker 160507
public:

	IICSGP* GetICS();
	void SetTrendView(CTrendView* pView){m_pTrendView = pView;}
	void SetAverageView(CAverageView* pView){m_pAverageView = pView;}
	CTrendView* GetTrendView(){return m_pTrendView;}
	CAverageView* GetAverageView(){return m_pAverageView;}
	CInstStatusBar* GetInstStatusBar(){return &m_wndInstStatusBar;}
	CSplitterWnd* GetSplitter(){return &m_wndSplitter;}
	CInfoBar* GetInfoBar(){return &m_wndInfoBar;}
	CStatusBar* GetStatusBar(){return &m_wndStatusBar;}

	CAcquisitionTab* GetAcqTab();
	CAnalysisTab* GetAnalysisTab();
	CCalibrationTab* GetCalibrationTab();
	CInfoBarDlg* GetInfo();
	
	virtual int GetActiveGraphIndex(){return m_iActiveGraphIndex;}
	virtual void SetActiveGraphIndex(int iIdx){m_iActiveGraphIndex = iIdx;}
	virtual void SetAverageFromIndex(int);
	virtual void SetActivePane(int);
	virtual void StartTrendAcquisition();
	virtual void StopTrendAcquisition();
	virtual void StartAverageAcquisition();
	virtual void StopAverageAcquisition();
	virtual CString GetCurrentAcqPath(){return CurrentTrendPath;}
	virtual bool GetIsDataActive(){return m_bDataIsActive;}
	virtual bool GetIsAcqInProgress(){return m_bAcqInProgress;}
	virtual void SetIsAcqInProgress(bool bAcq){m_bAcqInProgress = bAcq;}

	virtual bool GetEnableAcquisition(){return m_bEnableAcq;}
	virtual void SetEnableAcquisition(bool m_bAcq){m_bEnableAcq = m_bAcq;}
	virtual void SetStatusBarText(int, CString);
	virtual bool IsZooming(){return m_bIsZooming;}
	virtual enumTools GetCurrentTool(){return m_CurrentTool;}
	virtual void SetCurrentTool(enumTools Tool){m_CurrentTool = Tool;}
	virtual enumSmooth GetCurrentSmooth(){return m_CurrentSmooth;}
	virtual void SetCurrentSmooth(enumSmooth Smooth){m_CurrentSmooth = Smooth;}

	virtual void StripAxisTextLabels(CString*);

	
	virtual long GetIsStartedExternally(){return m_iStartedExternally;} //Added Paul Walker 160507
    virtual void SetNotStartedExternally(){m_iStartedExternally = 0;} //Added Paul Walker 160507

// Operations
public:

	CString m_sCurrentCalUnits;
	CString m_sCurrentCalFileName;
	bool m_bSavable;
	bool m_bViewingFFT;

	
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMainFrame)
	public:
	virtual BOOL OnCreateClient(LPCREATESTRUCT lpcs, CCreateContext* pContext);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMainFrame();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:  // control bar embedded members
	CStatusBar  m_wndStatusBar;
	CToolBar    m_wndToolBar;
	CInstStatusBar m_wndInstStatusBar;
	CInfoBar m_wndInfoBar;
	IICSGP m_ICSObject;
	CTrendView* m_pTrendView;
	CAverageView* m_pAverageView;

	int m_iActiveGraphIndex;

	bool m_bEnableAcq;
	bool m_bDataIsActive;
	bool m_bAcqInProgress;
	bool m_bDataAcquiredByOpen;
	bool m_bIsZooming;
	

	enumTools m_CurrentTool;
	enumSmooth m_CurrentSmooth;

	CString CurrentTrendPath;
	CString CurrentAveragePath;

	LRESULT OnMyMessage( WPARAM wParam, LPARAM lParam );

// Generated message map functions
public:
	afx_msg void OnProperties();
	afx_msg void OnViewmodeMarker();
	afx_msg void OnViewmodeZoom();
protected:
	//{{AFX_MSG(CMainFrame)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnInststatusbar();
	afx_msg void OnUpdateInststatusbar(CCmdUI* pCmdUI);
	afx_msg void OnGraphAuto();
	afx_msg void OnGraphHorzin();
	afx_msg void OnGraphHorzout();
	afx_msg void OnGraphVertauto();
	afx_msg void OnGraphVertin();
	afx_msg void OnGraphVertout();
	afx_msg void OnFileOpen();
	afx_msg void OnFileNew();
	afx_msg void OnFileSave();
	afx_msg void OnInitMenuPopup(CMenu* pPopupMenu, UINT nIndex, BOOL bSysMenu);
	afx_msg void OnAverageMode();
	afx_msg void OnTrendMode();
	afx_msg void OnSmoothNone();
	afx_msg void OnSmooth3pt();
	afx_msg void OnSmooth5pt();
	afx_msg void OnViewInfobar();
	afx_msg void OnUpdateViewInfobar(CCmdUI* pCmdUI);
	afx_msg void OnClose();
	afx_msg void OnUpdateViewmodeMarker(CCmdUI* pCmdUI);
	afx_msg void OnUpdateViewmodeZoom(CCmdUI* pCmdUI);
	afx_msg void OnUpdateFileOpen(CCmdUI* pCmdUI);
	afx_msg void OnUpdateFileSave(CCmdUI* pCmdUI);
	afx_msg void OnStart();
	afx_msg void OnStop();
	afx_msg void OnFileSaveas();
	afx_msg void OnUpdateFileSaveas(CCmdUI* pCmdUI);
	afx_msg void OnViewFft();
	afx_msg void OnUpdateViewFft(CCmdUI* pCmdUI);
	afx_msg void OnTimer(UINT nIDEvent); //Added Paul Walker 160507
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAINFRM_H__27F5913A_C34F_11D1_90D0_0060089615C2__INCLUDED_)
