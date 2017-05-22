#if !defined(AFX_SELECTEDPROPERTIES_H__CAFE6772_DD46_11D1_9113_0060089615C2__INCLUDED_)
#define AFX_SELECTEDPROPERTIES_H__CAFE6772_DD46_11D1_9113_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// SelectedProperties.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectedProperties dialog

class CSelectedProperties : public CDialog
{
// Construction
public:
	CSelectedProperties(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectedProperties)
	enum { IDD = IDD_SELECTED_PROPS };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectedProperties)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectedProperties)
	virtual BOOL OnInitDialog();
	afx_msg void OnCopy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTEDPROPERTIES_H__CAFE6772_DD46_11D1_9113_0060089615C2__INCLUDED_)
