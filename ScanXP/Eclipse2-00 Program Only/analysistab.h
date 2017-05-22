#if !defined(AFX_ANALYSISTAB_H__E9F88354_E80B_11D1_912F_0060089615C2__INCLUDED_)
#define AFX_ANALYSISTAB_H__E9F88354_E80B_11D1_912F_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// AnalysisTab.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CAnalysisTab dialog



class CAnalysisTab : public CDialog
{
// Construction
public:
	CAnalysisTab(CWnd* pParent = NULL);   // standard constructor

	void OnMeasurements();
	CString GetMeasurementVersions(int);

	//Functions that are exported from the "Eclipse" measurement DLLs
	typedef int(WINAPI* PFNGETNAME)(char*);
	typedef int(WINAPI* PFNGETVER)(char*);
	typedef int(WINAPI* PFNCALCULATE)(int, double*, double*, int, int, char*, void*);

	HMODULE	m_hMeasurement[20];

// Dialog Data
	//{{AFX_DATA(CAnalysisTab)
	enum { IDD = IDD_ANATAB };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAnalysisTab)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	bool m_bInitialized;

	// Generated message map functions
	//{{AFX_MSG(CAnalysisTab)
	virtual BOOL OnInitDialog();
	afx_msg void OnDestroy();
	afx_msg void OnSelchangeMeasure1();
	afx_msg void OnSelchangeMeasure2();
	afx_msg void OnSelchangeMeasure3();
	afx_msg void OnSelchangeMeasure4();
	afx_msg void OnShowWindow(BOOL bShow, UINT nStatus);
	//}}AFX_MSG

	virtual void OnOK();
	virtual void OnCancel();

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ANALYSISTAB_H__E9F88354_E80B_11D1_912F_0060089615C2__INCLUDED_)
