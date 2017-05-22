// Eclipse.h : main header file for the Eclipse application
//

#if !defined(AFX_ECLIPSE_H__27F59136_C34F_11D1_90D0_0060089615C2__INCLUDED_)
#define AFX_ECLIPSE_H__27F59136_C34F_11D1_90D0_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CEclipseApp:
// See Eclipse.cpp for the implementation of this class
//

#define AVERAGE	0
#define TREND	1

class CEclipseApp : public CWinApp
{
public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	CEclipseApp();

	virtual int GetMode(){return m_iMode;}
	virtual void SetMode(int iMode);

	virtual int GetLastMode();
	virtual void SetLastMode(int);

	virtual int GetLastRealTime();
	virtual void SetLastRealTime(int);


	virtual int GetCurrentViewProtocol();
	virtual void SetCurrentViewProtocol(int);

	virtual int GetCalState();
	virtual void SetCalState(int);

	virtual bool GetIsDSPPresent(){return m_bDSPPresent;}
	virtual void SetIsDSPPresent(bool bDSP){m_bDSPPresent = bDSP;}

	virtual bool GetIsInstrumentPresent(){return m_bInstrumentPresent;}
	virtual void SetIsInstrumentPresent(bool bInst){m_bInstrumentPresent = bInst;}

	virtual CString GetDataDir();
	virtual void SetDataDir(CString);
	virtual CString GetLastCalPath();
	virtual void SetLastCalPath(CString);
	virtual CString GetLastOpenPath();
	virtual void SetLastOpenPath(CString);

	virtual CString GetProt0CalPath();
	virtual void SetProt0CalPath(CString);
	virtual CString GetProt1CalPath();
	virtual void SetProt1CalPath(CString);
	virtual CString GetProt2CalPath();
	virtual void SetProt2CalPath(CString);
	virtual CString GetProt3CalPath();
	virtual void SetProt3CalPath(CString);
	virtual CString GetProt4CalPath();
	virtual void SetProt4CalPath(CString);
	virtual CString GetProt5CalPath();
	virtual void SetProt5CalPath(CString);
	virtual CString GetProt6CalPath();
	virtual void SetProt6CalPath(CString);
	virtual CString GetProt7CalPath();
	virtual void SetProt7CalPath(CString);

	virtual int GetProt0PPR();
	virtual void SetProt0PPR(int);
	virtual int GetProt1PPR();
	virtual void SetProt1PPR(int);
	virtual int GetProt2PPR();
	virtual void SetProt2PPR(int);
	virtual int GetProt3PPR();
	virtual void SetProt3PPR(int);
	virtual int GetProt4PPR();
	virtual void SetProt4PPR(int);
	virtual int GetProt5PPR();
	virtual void SetProt5PPR(int);
	virtual int GetProt6PPR();
	virtual void SetProt6PPR(int);
	virtual int GetProt7PPR();
	virtual void SetProt7PPR(int);

	virtual CString GetXAxisText(){return m_sXAxisText;}
	virtual void SetXAxisText(CString Text){m_sXAxisText = Text;}


	virtual CString GetAnalysisMeasurement1Name();
	virtual void SetAnalysisMeasurement1Name(CString);

	virtual CString GetAnalysisMeasurement2Name();
	virtual void SetAnalysisMeasurement2Name(CString);

	virtual CString GetAnalysisMeasurement3Name();
	virtual void SetAnalysisMeasurement3Name(CString);

	virtual CString GetAnalysisMeasurement4Name();
	virtual void SetAnalysisMeasurement4Name(CString);

	virtual void SetLastPropPageInitialize(CPropertyPage* pPage){m_ppLastGraphPageInitialized = pPage;}
	virtual CPropertyPage* GetLastPropPageInitialize(){return m_ppLastGraphPageInitialized;}

	virtual int GetIsMaxNumberUsed();
	virtual void SetIsMaxNumberUsed(int);
	virtual int GetIsMaxTimeUsed();
	virtual void SetIsMaxTimeUsed(int);

	virtual int GetMaxNumber();
	virtual void SetMaxNumber(int);
	virtual int GetMaxTime();
	virtual void SetMaxTime(int);


	//General propertypage data modification values
	virtual int GetIsApplyConst();
	virtual void SetIsApplyConst(int);
	virtual int GetConstOperator();
	virtual void SetConstOperator(int);
	virtual CString GetConstValue();
	virtual void SetConstValue(CString);

	virtual int GetIsCombineFile();
	virtual void SetIsCombineFile(int);
	virtual int GetFileOperator();
	virtual void SetFileOperator(int);
	virtual CString GetFilename();
	virtual void SetFilename(CString);
	virtual CString GetFilePath();
	virtual void SetFilePath(CString);

	virtual CString GetVersion();



protected:

	int m_iMode;
	int m_iRealTime;
	bool m_bDSPPresent;
	bool m_bInstrumentPresent;

	//Keep the XAxis text here so we can append the calibration chars to it to be displayed
	CString m_sXAxisText;

	CPropertyPage* m_ppLastGraphPageInitialized;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEclipseApp)
	public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CEclipseApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ECLIPSE_H__27F59136_C34F_11D1_90D0_0060089615C2__INCLUDED_)
