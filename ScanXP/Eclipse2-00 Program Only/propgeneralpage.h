#if !defined(AFX_PROPGENERALPAGE_H__2862DF54_B79A_11D1_90A9_0060089615C2__INCLUDED_)
#define AFX_PROPGENERALPAGE_H__2862DF54_B79A_11D1_90A9_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// PropGeneralPage.h : header file
//
#include "FloatEdit.h"

/////////////////////////////////////////////////////////////////////////////
// CPropGeneralPage dialog

class CPropGeneralPage : public CPropertyPage
{
	DECLARE_DYNCREATE(CPropGeneralPage)

// Construction
public:
	CPropGeneralPage();
	~CPropGeneralPage();

	virtual void EnableFileProps(bool);
	virtual void EnableConstProps(bool);
	virtual void UpdateImages();
	virtual void UpdateFromInst();

// Dialog Data
	//{{AFX_DATA(CPropGeneralPage)
	enum { IDD = IDD_GENERAL };
	CButton	m_FileOperator;
	CButton	m_ApplyOperator;
	long	m_lPresetTime;
	long	m_lPresetSpectrum;
	BOOL	m_bRPS;
	int		m_TriggerPolarityGroup;
	//}}AFX_DATA

protected:
	CFloatEdit m_ConstValue;
	CFont* m_pSymbolFont;
	CString m_FilePath;
	CString m_Filename;
	int m_iConstOperator;
	int m_iFileOperator;

// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(CPropGeneralPage)
	public:
	virtual BOOL OnApply();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CPropGeneralPage)
	afx_msg void OnChangePresetTime();
	virtual BOOL OnInitDialog();
	afx_msg void OnChangeSpectrumPreset();
	afx_msg void OnRps();
	afx_msg void OnChangeProtocol();
	afx_msg void OnNegativepolarity();
	afx_msg void OnPositivepolarity();
	afx_msg void OnSelchangeProtocol();
	afx_msg void OnFileCombine();
	afx_msg void OnApplyConstant();
	afx_msg void OnFileBrowse();
	afx_msg void OnApplyOperator();
	afx_msg void OnFileOperator();
	afx_msg void OnUpdateConstValue();
	afx_msg void OnMaxNumber();
	afx_msg void OnMaxTime();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PROPGENERALPAGE_H__2862DF54_B79A_11D1_90A9_0060089615C2__INCLUDED_)
