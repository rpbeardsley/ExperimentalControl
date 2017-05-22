#if !defined(AFX_TRENDVIEW_H__54B02C82_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
#define AFX_TRENDVIEW_H__54B02C82_D2E5_11D1_90F3_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// TrendView.h : header file
//
#include "GSX2.h"
#include "DataHover.h"
#include "RecalcTrendDlg.h"
/////////////////////////////////////////////////////////////////////////////
// CTrendView view

#define C_PROTOCOL_0 0x80000000L
#define C_PROTOCOL_1 0x40000000L
#define C_PROTOCOL_2 0x20000000L
#define C_PROTOCOL_3 0x10000000L
#define C_PROTOCOL_4 0x08000000L
#define C_PROTOCOL_5 0x04000000L
#define C_PROTOCOL_6 0x02000000L
#define C_PROTOCOL_7 0x01000000L

#pragma pack(push,1) //Structure here just to get the sizeof it, actually used in the ICS program
struct LCInfoEx		 //Just need to know someoffsets for file manipulation
{
    LCInfoEx();
    int m_iProtocol;
	long m_lTime;	
	long m_lLength;
	__int64 m_lTotalIonCount;
	__int64 m_i64StartOffset;
    double m_dTimeMultiplier;
};
#pragma pack(pop)

class CMeasurements
{
public:
	BOOL bUseTrack1;
	BOOL bUseTrack2;
	BOOL bUseTrack3;
	BOOL bUseTrack4;

	char szTrack1Unit[16];
	char szTrack2Unit[16];
	char szTrack3Unit[16];
	char szTrack4Unit[16];

	char szTrack1Name[16];
	char szTrack2Name[16];
	char szTrack3Name[16];
	char szTrack4Name[16];

	float fTrack1From, fTrack1To;
	float fTrack2From, fTrack2To;
	float fTrack3From, fTrack3To;
	float fTrack4From, fTrack4To;

	float fTrack1Time;
	float fTrack2Time;
	float fTrack3Time;
	float fTrack4Time;

	float fTrack1Result;
	float fTrack2Result;
	float fTrack3Result;
	float fTrack4Result;
};

#define BZERO(buf) memset(&(buf),0,sizeof(buf))

class CTrendView : public CView
{
protected:
	CTrendView();           // protected constructor used by dynamic creation
	DECLARE_DYNCREATE(CTrendView)

// Attributes
public:
	virtual bool CreateTrendGraph();
	virtual CGSX2* GetGraph(){return &m_Graph;}
	virtual bool RetrieveTrendFile(CString);
	virtual VARIANT* GetTrendXData(){return &m_vaTrendXData;}
	virtual VARIANT* GetTrendYData(){return &m_vaTrendYData;}

	virtual void StartTrendAcquisition(CString);
	virtual void StopTrendAcquisition();
	virtual void DisplayHoverWindow();
	virtual void GraphSettings(bool bStore);

	virtual void CreateTrendData();
	virtual void LoadMeasurementDLLs();
	virtual void FreeMeasurementDLLs();
	virtual void DrawTrendData(int);
	virtual void ReCalculateTrend();
	virtual bool SaveTrendFile(CString, bool);

	int m_iCurrentTrackView;
	CMeasurements m_Measurements[20000];

protected:

	int m_iNumberOfMeasurements;
	int m_iMeasurementIdx;

	HMODULE	m_hMeasurement[4];

	//Functions that are exported from the "Eclipse" measurement DLLs
	typedef int(WINAPI* PFNGETNAME)(char*);
	typedef int(WINAPI* PFNGETVER)(char*);
	typedef int(WINAPI* PFNCALCULATE)(int, double*, double*, int, int, char*, void*);

	CRecalcTrendDlg m_RecalcTrend;
	CGSX2 m_Graph;
	CDataHover* m_pHoverWnd;
	VARIANT m_vaTrendXData;
	VARIANT m_vaTrendYData;

	long lClickX,lClickY;
	long lClickXDown, lClickYDown;

	long m_lMousePointerX;
	long m_lMousePointerY;

	long m_lValidProtocolsFlag;
	bool m_bAdjustOnce;
	CString m_sCurrentFile;

	bool m_bAcqInProgress;
	BOOL m_bRealTime;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTrendView)
	public:
	virtual BOOL Create(LPCTSTR lpszClassName, LPCTSTR lpszWindowName, DWORD dwStyle, const RECT& rect, CWnd* pParentWnd, UINT nID, CCreateContext* pContext = NULL);
	virtual void OnInitialUpdate();
	protected:
	virtual void OnDraw(CDC* pDC);      // overridden to draw this view
	virtual void OnPrint(CDC* pDC, CPrintInfo* pInfo);
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void CalcWindowRect(LPRECT lpClientRect, UINT nAdjustType = adjustBorder);
	//}}AFX_VIRTUAL

// Implementation
protected:
	virtual ~CTrendView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

	// Generated message map functions
protected:
	//{{AFX_MSG(CTrendView)
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnCopygraph();
	afx_msg void OnDestroy();
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnPaint();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

	afx_msg void OnGSXMouseDown(short Button, short Shift, long x, long y);
	afx_msg void OnGSXMouseUp(short Button, short Shift, long x, long y);
	afx_msg void OnGSXMouseMove(short Button, short Shift, long x, long y);
	afx_msg void OnGSXRepaint(long Hdc, long Left, long Top, long Width, long Height);
	afx_msg void OnGSXClick();

	afx_msg void OnRightGraphProperties();
	afx_msg void OnRightSetMarkerTool();
	afx_msg void OnRightSetZoomTool();
	afx_msg void OnRightSum();

	afx_msg void OnRightSetTrack1();
	afx_msg void OnRightSetTrack2();
	afx_msg void OnRightSetTrack3();
	afx_msg void OnRightSetTrack4();

	afx_msg void OnRightReCalcTrend();

	DECLARE_EVENTSINK_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRENDVIEW_H__54B02C82_D2E5_11D1_90F3_0060089615C2__INCLUDED_)
