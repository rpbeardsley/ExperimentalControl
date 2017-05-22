#if !defined(AFX_AVERAGEVIEW_H__54B02C81_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
#define AFX_AVERAGEVIEW_H__54B02C81_D2E5_11D1_90F3_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// AverageView.h : header file
//
#include "GSX2.h"
#include "DataHover.h"
#include "Calibration.h"
#include "Settings.h"
#include "ShowFFT.h"

#define SETTINGS_SIZE 2952 //This is the padded size of CSettings object

class CShowFFT;

/////////////////////////////////////////////////////////////////////////////
// CAverageView view
enum enumVertScale
{
	Amplitude,
	Average_LSB,
	Average_mVolt
};

enum enumOperationMode
{
	eNone = -1,
	eAdd = 0,
	eSubtract,
	eMuliply,
	eDivide
};

class CAverageView : public CView
{
protected:
	CAverageView();           // protected constructor used by dynamic creation
	DECLARE_DYNCREATE(CAverageView)

// Attributes
public:
	virtual bool CreateGraph();

	virtual CGSX2* GetGraph(){return &m_Graph;}
	virtual bool RetrieveTrendAverageFile(CString,int);
	virtual bool RetrieveAverageActive(int);

	virtual bool OpenAverageFile(CString, int);
	virtual bool SaveAverageFile(CString);
	virtual bool SaveAsAverageFile(CString, CString);
	
	virtual void StopAverageAcquisition();
	virtual void StartAverageAcquisition(CString);
	virtual void DisplayHoverWindow();
	virtual void UpdateAnalysisInfo();
	virtual void GraphSettings(bool bStore);
	virtual void UpdateLabels();
	virtual bool CalibrateAverageXData();
	virtual void RemoveAllOverlays();
	virtual void LoadDataToBeCombined();

	CSettings* GetSettings(){return &m_CurrentAverageSettings;}
	enumVertScale* GetScale(){return &m_eScale;}
	void SetScale(enumVertScale eScale){m_eScale = eScale;}

	VARIANT* GetAverageXData(){return &m_vaAverageXData;}
	VARIANT* GetAverageYData(){return &m_vaAverageYData;}
	VARIANT* GetCalXData(){return &m_vaCalXData;}

	CShowFFT* GetFFTDlg(){return m_pShowFFTDlg;}
	virtual bool GetSynthData(VARIANT* vaXTmpData, VARIANT* vaYTmpData);

	afx_msg void OnRightCalibrationEnable();

	virtual int GetNumberOfAverages(){return m_iNumberOfAverages;}

	double m_dIdealFreq;

	void SendDataToExternalApp(long extWindowHandle); //Added by Paul Walker 160507

protected:

	CGSX2 m_Graph;
	CSettings m_CurrentAverageSettings;
	CDataHover* m_pHoverWnd;

	VARIANT m_vaAverageXData;
	VARIANT m_vaAverageYData;
	VARIANT m_vaCalXData;

	VARIANT m_vaExtra;

	long m_lMousePointerX;
	long m_lMousePointerY;

	bool m_bApplyCalOnce;
	bool m_bCanUpdate;
	enumVertScale m_eScale;

	CShowFFT* m_pShowFFTDlg;
	int m_iNumberOfAverages;
	


// Operations
public:



// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAverageView)
	public:
	virtual BOOL Create(LPCTSTR lpszClassName, LPCTSTR lpszWindowName, DWORD dwStyle, const RECT& rect, CWnd* pParentWnd, UINT nID, CCreateContext* pContext = NULL);
	protected:
	virtual void OnDraw(CDC* pDC);      // overridden to draw this view
	virtual void OnPrint(CDC* pDC, CPrintInfo* pInfo);
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~CAverageView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

	// Generated message map functions
protected:
	//{{AFX_MSG(CAverageView)
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnCopygraph();
	afx_msg void OnDestroy();
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
	afx_msg void OnViewFFT();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

	afx_msg void OnGSXMouseDown(short Button, short Shift, long x, long y);
	afx_msg void OnGSXMouseUp(short Button, short Shift, long x, long y);
	afx_msg void OnGSXMouseMove(short Button, short Shift, long x, long y);
	afx_msg void OnGSXRepaint(long Hdc, long Left, long Top, long Width, long Height);
	afx_msg void OnGSXClick();
	afx_msg void OnGSXUpdateComplete();

	afx_msg void OnRightGraphProperties();
	afx_msg void OnRightSetMarkerTool();
	afx_msg void OnRightSetZoomTool();
	afx_msg void OnAddOverlay();
	afx_msg void OnRemoveOverlay();
	afx_msg void OnModifyData();
	afx_msg void OnDataProps();
	

	DECLARE_EVENTSINK_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_AVERAGEVIEW_H__54B02C81_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
