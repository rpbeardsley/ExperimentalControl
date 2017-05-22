#if !defined(AFX_TRENDSETUP_H__797F0D92_63A4_11D2_A0C7_0060089615C2__INCLUDED_)
#define AFX_TRENDSETUP_H__797F0D92_63A4_11D2_A0C7_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// TrendSetup.h : header file
//
#include "FloatEdit.h"
/////////////////////////////////////////////////////////////////////////////
// CTrendSetup dialog

class CTrendSettings
{
protected:

	BOOL bTrackUsed;
	char strTrackName[256];
	double dTrackFrom;
	double dTrackTo;
};


class CTrendSetup : public CDialog
{
// Construction
public:
	CTrendSetup(CWnd* pParent = NULL);   // standard constructor

	virtual void LoadCurrentSettings();

// Dialog Data
	//{{AFX_DATA(CTrendSetup)
	enum { IDD = IDD_TREND_SETUP };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA
	//Functions that are exported from the "Eclipse" measurement DLLs
	typedef int(WINAPI* PFNGETNAME)(char*);
	typedef int(WINAPI* PFNGETVER)(char*);
	typedef int(WINAPI* PFNCALCULATE)(int, double*, double*, int, int, char*, void*);

	virtual void Apply();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTrendSetup)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	CFloatEdit m_ETrack1From;
	CFloatEdit m_ETrack1To;

	CFloatEdit m_ETrack2From;
	CFloatEdit m_ETrack2To;

	CFloatEdit m_ETrack3From;
	CFloatEdit m_ETrack3To;

	CFloatEdit m_ETrack4From;
	CFloatEdit m_ETrack4To;

	CTrendSettings TrendSettings[4];

	// Generated message map functions
	//{{AFX_MSG(CTrendSetup)
	afx_msg void OnTrackEnable();
	afx_msg void OnTrackEnable2();
	afx_msg void OnTrackEnable3();
	afx_msg void OnTrackEnable4();
	virtual BOOL OnInitDialog();
	afx_msg void OnUpdate();
	virtual void OnOK();
	afx_msg void OnUpdate2();
	afx_msg void OnUpdate3();
	afx_msg void OnUpdate4();
	afx_msg void OnSetRegion();
	afx_msg void OnSetRegion2();
	afx_msg void OnSetRegion3();
	afx_msg void OnSetRegion4();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRENDSETUP_H__797F0D92_63A4_11D2_A0C7_0060089615C2__INCLUDED_)
