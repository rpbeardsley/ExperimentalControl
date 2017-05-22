//{{AFX_INCLUDES()
#include "indicators.h"
//}}AFX_INCLUDES
#if !defined(AFX_ACQUISITIONTAB_H__54B02C83_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
#define AFX_ACQUISITIONTAB_H__54B02C83_D2E5_11D1_90F3_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// AcquisitionTab.h : header file
//
#include "ShowFFT.h"

/////////////////////////////////////////////////////////////////////////////
// CAcquisitionTab dialog

class CAcquisitionTab : public CDialog
{
// Construction
public:
	CAcquisitionTab(CWnd* pParent = NULL);   // standard constructor

	virtual void OnAcqStart();
	virtual void OnAcqStop();
	CIndicators* GetLED1(){return &m_LED1;}
	CIndicators* GetLED2(){return &m_LED2;}

	afx_msg void OnModeTrend();
	afx_msg void OnModeAverage();

// Dialog Data
	//{{AFX_DATA(CAcquisitionTab)
	enum { IDD = IDD_ACQTAB };
	CIndicators	m_LED1;
	CIndicators	m_LED2;
	int		m_ModeGroup;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAcquisitionTab)
	public:
	virtual BOOL DestroyWindow();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CAcquisitionTab)
	afx_msg void OnInstProps();
	virtual BOOL OnInitDialog();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnDestroy();
	afx_msg void OnClose();
	afx_msg void OnRealtime();
	//}}AFX_MSG

	virtual void OnOK();
	virtual void OnCancel();

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ACQUISITIONTAB_H__54B02C83_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
