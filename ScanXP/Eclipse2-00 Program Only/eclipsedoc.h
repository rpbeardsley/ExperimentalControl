// EclipseDoc.h : interface of the CEclipseDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_ECLIPSEDOC_H__27F5913C_C34F_11D1_90D0_0060089615C2__INCLUDED_)
#define AFX_ECLIPSEDOC_H__27F5913C_C34F_11D1_90D0_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
#include "ICS.h"

class CEclipseDoc : public CDocument
{
protected: // create from serialization only
	CEclipseDoc();
	DECLARE_DYNCREATE(CEclipseDoc)

// Attributes
public:

	static HRESULT AnsiToUnicode(LPCSTR pszA, LPOLESTR* ppszW);

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEclipseDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CEclipseDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CEclipseDoc)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ECLIPSEDOC_H__27F5913C_C34F_11D1_90D0_0060089615C2__INCLUDED_)
