#if !defined(AFX_CALIBRATIONTAB_H__54B02C84_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
#define AFX_CALIBRATIONTAB_H__54B02C84_D2E5_11D1_90F3_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// CalibrationTab.h : header file
//
#include "Calibration.h"

/////////////////////////////////////////////////////////////////////////////
// CCalibrationTab dialog

class CCalibrationTab : public CDialog
{
// Construction
public:
	CCalibrationTab(CWnd* pParent = NULL);   // standard constructor
	~CCalibrationTab();

	CCalibration* GetCalObject(){return &m_Cal;}

	virtual void SetCalCentroid(double dVal){m_dCalCentroid = dVal;}
	virtual void SetCalStartMarker(double dVal){m_dCalStartMarker = dVal;}
	virtual void SetCalEndMarker(double dVal){m_dCalEndMarker = dVal;}

	virtual void DeleteCalItem(int iItemToDelete);

	virtual void EnableItems(BOOL);
	virtual void UpdateBasedOnItems();
	virtual void OnCalApply();

// Dialog Data
	//{{AFX_DATA(CCalibrationTab)
	enum { IDD = IDD_CALTAB };
	CListCtrl	m_CalLibList;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCalibrationTab)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	double m_dCalCentroid;
	double m_dCalStartMarker;
	double m_dCalEndMarker;

	CCalibration m_Cal;

	// Generated message map functions
	//{{AFX_MSG(CCalibrationTab)
	afx_msg void OnCalView();
	afx_msg void OnCalfileBrowse();
	afx_msg void OnAddCalItem();
	afx_msg void OnDestroy();
	virtual BOOL OnInitDialog();
	afx_msg void OnCalSave();
	afx_msg void OnCalClear();
	afx_msg void OnRclickCallibraryList(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnSelchangeCalType();
	//}}AFX_MSG

	virtual void OnOK();
	virtual void OnCancel();

	afx_msg void OnRightDelete();
	afx_msg void OnRightUpdate();

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CALIBRATIONTAB_H__54B02C84_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
