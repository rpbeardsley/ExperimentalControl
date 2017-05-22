//{{AFX_INCLUDES()
#include "gsx2.h"
//}}AFX_INCLUDES
#if !defined(AFX_CALIBRATIONVIEW_H__7C9058A1_06C5_11D2_A086_0060089615C2__INCLUDED_)
#define AFX_CALIBRATIONVIEW_H__7C9058A1_06C5_11D2_A086_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// CalibrationView.h : header file
//
#include "Calibration.h"

/////////////////////////////////////////////////////////////////////////////
// CCalibrationView dialog

class CCalibrationView : public CDialog
{
// Construction
public:
	CCalibrationView(CWnd* pParent = NULL, CListCtrl* pCalList = NULL, CCalibration* pCal = NULL);
	void GetValueData(VARIANT*, VARIANT*);
	void GetCurveData(VARIANT*, VARIANT*);

// Dialog Data
	//{{AFX_DATA(CCalibrationView)
	enum { IDD = IDD_CAL_VIEW };
	CListCtrl	m_CalList;
	CGSX2	m_CalGraph;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCalibrationView)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	CListCtrl* m_pCalList;
	CCalibration* m_pCal;
	double* m_pdCoefs;
	int m_iNumOfCoefs;
	double m_dNonCalibMinX;
	double m_dNonCalibMaxX;

	// Generated message map functions
	//{{AFX_MSG(CCalibrationView)
	virtual BOOL OnInitDialog();
	afx_msg void OnClickCalList(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnGSXClickGsxCtrl();
	afx_msg void OnItemchangedCalList(NMHDR* pNMHDR, LRESULT* pResult);
	DECLARE_EVENTSINK_MAP()
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CALIBRATIONVIEW_H__7C9058A1_06C5_11D2_A086_0060089615C2__INCLUDED_)
