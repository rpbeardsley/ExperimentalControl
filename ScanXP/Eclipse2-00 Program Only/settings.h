#if !defined(AFX_SETTINGS_H__DAA54FB4_DC3E_11D1_9111_0060089615C2__INCLUDED_)
#define AFX_SETTINGS_H__DAA54FB4_DC3E_11D1_9111_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// Settings.h : header file
//

class CProtocolSettings : public CObject
{
protected:
	DECLARE_SERIAL(CProtocolSettings)

public:

	//Settings for Protocol
	float m_fRecordLength;
	int   m_iRecordsPerSpectrum;
	float m_fSamplingInterval;
	float m_fTimeOffset;
	float m_fVerticalOffset;
	float m_fEOSDeadTime;
	BOOL  m_bEnhancer;

	//Compression Settings
	BOOL  m_bCompressionActive;
	int   m_iSensitivity;
	float m_fMinThreshold;
	int   m_iBkgSamplingInterval;
	int   m_iAdjacentBkg;
	int   m_iMaxPeakWidth;
	int   m_iMinPeakWidth;
	float m_fRingingProtection;

	//Calibration Settings
	BOOL m_bCalValid;
	CString m_sFileName;
	CString m_sUnits;
	int m_iCalType;
	double m_dCoef1;
	double m_dCoef2;
	double m_dCoef3;
	double m_dCoef4;

	virtual void Serialize(CArchive& ar);
};



/////////////////////////////////////////////////////////////////////////////
// CSettings command target

class CSettings : public CCmdTarget
{
	DECLARE_SERIAL(CSettings)

public:

	CSettings();           // protected constructor used by dynamic creation
	virtual ~CSettings();

// Attributes
public:

// Operations
public:

	virtual void LoadSettingsFromInstrument();
	virtual void Initialize();

	float m_fVersion;

	//General Settings
	int  m_iMaxAcqTime;
	int  m_iAveragesPerTrend;
	int  m_iProtocol;
	BOOL m_bRapidProtocol;
	BOOL m_bTriggerEnablePolarity;

	CProtocolSettings ProtSettings[8];


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSettings)
	public:
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
protected:
	

	// Generated message map functions
	//{{AFX_MSG(CSettings)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SETTINGS_H__DAA54FB4_DC3E_11D1_9111_0060089615C2__INCLUDED_)
