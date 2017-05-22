#if !defined(AFX_SHOWFFT_H__1592B4C1_B7FD_11D1_BBFE_0060089615C2__INCLUDED_)
#define AFX_SHOWFFT_H__1592B4C1_B7FD_11D1_BBFE_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "resource.h"
#include "GSX2.h"
#include "UtilLib/Complex.h"
#include "QuadFit.h"
#include "AverageView.h"

class CAverageView;

// ShowFFT.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CShowFFT dialog
#define RMSARRAYSIZE  500

class CShowFFT : public CDialog
{
// Construction
public:
	CShowFFT(CWnd* pParent = NULL, CGSX2* pSourceGraph = NULL);   // standard constructor
	~CShowFFT();

	virtual void Transfer2DtoFFT();

	typedef int(WINAPI* PFNCALCULATE)(int, double*, double*, int, int, char*, void*);
	virtual long GetUpPwrOfTwo(long lNumber);
	virtual CGSX2* GetGraph(){return &m_Graph;}
	virtual void Clear();//Clears out graph data and leaves dlg in user friendly state
	
// Dialog Data
	//{{AFX_DATA(CShowFFT)
	enum { IDD = IDD_SHOWFFT };
	BOOL	m_bLog;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CShowFFT)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual void PostNcDestroy();
	//}}AFX_VIRTUAL

// Implementation
protected:

	CAverageView* m_pParentView;
	CGSX2 m_Graph;
	CGSX2* m_pSourceGraph;
	TComplexArray* m_pCA;

	double m_dRMSArray[RMSARRAYSIZE];
	int m_iRMSIdx;
	
	// Generated message map functions
	//{{AFX_MSG(CShowFFT)
	virtual BOOL OnInitDialog();
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnAutoscale();
	afx_msg void OnLog();
	afx_msg void OnXIn();
	afx_msg void OnXOut();
	afx_msg void OnYIn();
	afx_msg void OnYOut();
	afx_msg void OnClose();
	afx_msg void OnDestroy();
	virtual void OnCancel();
	virtual void OnOK();
	//}}AFX_MSG

	afx_msg void OnGSXMouseMove(short Button, short Shift, long x, long y);
	afx_msg void OnGSXMouseUp(short Button, short Shift, long x, long y);

	DECLARE_MESSAGE_MAP()
	DECLARE_EVENTSINK_MAP() //For the ActiveX Graph Controls

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SHOWFFT_H__1592B4C1_B7FD_11D1_BBFE_0060089615C2__INCLUDED_)
