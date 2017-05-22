#if !defined(AFX_SAVEAS_H__3B5F2452_0EB6_11D2_A09A_0060089615C2__INCLUDED_)
#define AFX_SAVEAS_H__3B5F2452_0EB6_11D2_A09A_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// SaveAs.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSaveAs dialog

class CSaveAs : public CFileDialog
{
	DECLARE_DYNAMIC(CSaveAs)

public:
	CSaveAs(BOOL bOpenFileDialog, // TRUE for FileOpen, FALSE for FileSaveAs
		LPCTSTR lpszDefExt = NULL,
		LPCTSTR lpszFileName = NULL,
		DWORD dwFlags = OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,
		LPCTSTR lpszFilter = NULL,
		CWnd* pParentWnd = NULL, CString* pCalPath = NULL);

	virtual void OnInitDone();

protected:

	CString* m_pCalPath;
	CString m_sCalName;

	//{{AFX_MSG(CSaveAs)
	virtual BOOL OnInitDialog();
	afx_msg void OnSaveasBrowse();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};
	

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SAVEAS_H__3B5F2452_0EB6_11D2_A09A_0060089615C2__INCLUDED_)
