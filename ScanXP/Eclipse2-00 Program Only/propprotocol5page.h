#if !defined(AFX_PropProtocol5Page_H__2862DF55_B79A_11D1_90A9_0060089615C2__INCLUDED_)
#define AFX_PropProtocol5Page_H__2862DF55_B79A_11D1_90A9_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// PropProtocol5Page.h : header file
//
#include "CompAdvanced.h"
#include "FloatEdit.h"

/////////////////////////////////////////////////////////////////////////////
// CPropProtocol5Page dialog

class CPropProtocol5Page : public CPropertyPage
{
	DECLARE_DYNCREATE(CPropProtocol5Page)

// Construction
public:
	CPropProtocol5Page();
	~CPropProtocol5Page();

	virtual void UpdateFromInst();

// Dialog Data
	//{{AFX_DATA(CPropProtocol5Page)
	enum { IDD = IDD_PROTOCOL5 };
	float	m_fRecordLength;
	float	m_fOffset;
	long	m_lRecordPreset;
	float	m_fTriggerDelay;
	float	m_fNoiseLevel;
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(CPropProtocol5Page)
	public:
	virtual void OnOK();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	CFloatEdit m_RecordLength;
	CFloatEdit m_TimeOffset;
	CFloatEdit m_VertOffset;
	CFloatEdit m_MinThresh;

	// Generated message map functions
	//{{AFX_MSG(CPropProtocol5Page)
	virtual BOOL OnInitDialog();
	afx_msg void OnAdvanced();
	afx_msg void OnProtcolAdvanced();
	afx_msg void OnCompression();
	afx_msg void OnAutonoise();
	afx_msg void OnCalBrowse();
	afx_msg void OnChangeCalPath();
	afx_msg void OnUpdateRecordlength();
	afx_msg void OnUpdateTriggerdelay();
	afx_msg void OnUpdateOffset();
	afx_msg void OnUpdateRecordpreset();
	afx_msg void OnSelchangePeriod();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PropProtocol5Page_H__2862DF55_B79A_11D1_90A9_0060089615C2__INCLUDED_)
