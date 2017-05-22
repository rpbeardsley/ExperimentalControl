#if !defined(AFX_INSTSTATUSBARDLG_H__27F59146_C34F_11D1_90D0_0060089615C2__INCLUDED_)
#define AFX_INSTSTATUSBARDLG_H__27F59146_C34F_11D1_90D0_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// InstStatusBarDlg.h : header file
//
#include "resource.h"
#include "AcquisitionTab.h"
#include "CalibrationTab.h"
#include "AnalysisTab.h"

/////////////////////////////////////////////////////////////////////////////
// CInstStatusBarDlg dialog

class CInstStatusBarDlg : public CDialog
{
// Construction
public:
	CInstStatusBarDlg(CWnd* pParent = NULL);   // standard constructor

	virtual CAcquisitionTab* GetAcqTab(){return &m_AcqTab;}
	virtual CAnalysisTab* GetAnaTab(){return &m_AnaTab;}
	virtual CCalibrationTab* GetCalibrationTab(){return &m_CalTab;}

// Dialog Data
	//{{AFX_DATA(CInstStatusBarDlg)
	enum { IDD = IDD_INSTSTATUSBAR };
	CTabCtrl	m_StatusTab;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInstStatusBarDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	TC_ITEM m_tcAcqItem;
	TC_ITEM m_tcCalItem;
	TC_ITEM m_tcAnaItem;

	CAcquisitionTab m_AcqTab;
	CCalibrationTab m_CalTab;
	CAnalysisTab m_AnaTab;
	// Generated message map functions
	//{{AFX_MSG(CInstStatusBarDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSelchangeStatustab(NMHDR* pNMHDR, LRESULT* pResult);
	//}}AFX_MSG

	virtual void OnOK();
	virtual void OnCancel();

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INSTSTATUSBARDLG_H__27F59146_C34F_11D1_90D0_0060089615C2__INCLUDED_)
