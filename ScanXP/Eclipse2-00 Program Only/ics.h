// Machine generated IDispatch wrapper class(es) created with ClassWizard
/////////////////////////////////////////////////////////////////////////////
// IICSGP wrapper class
#if !defined __ICS_H
#define __ICS_H

class IICSGP : public COleDispatchDriver
{
public:
	IICSGP() {}		// Calls COleDispatchDriver default constructor
	IICSGP(LPDISPATCH pDispatch) : COleDispatchDriver(pDispatch) {}
	IICSGP(const IICSGP& dispatchSrc) : COleDispatchDriver(dispatchSrc) {}

// Attributes
public:
	long GetTimePreset();
	void SetTimePreset(long);
	BOOL GetRps();
	void SetRps(BOOL);
	short GetProtocol();
	void SetProtocol(short);
	long GetSpectrumPreset();
	void SetSpectrumPreset(long);
	long GetRecord();
	void SetRecord(long);
	long GetRecords();
	void SetRecords(long);
	long GetRecordsStored();
	void SetRecordsStored(long);
	long GetDataLength();
	void SetDataLength(long);
	BOOL GetActive();
	void SetActive(BOOL);
	long GetTimeElapsed();
	void SetTimeElapsed(long);
	BOOL GetIsDSPPresent();
	void SetIsDSPPresent(BOOL);
	BOOL GetTriggerPolarity();
	void SetTriggerPolarity(BOOL);

// Operations
public:
	BOOL GetDataFromInst(VARIANT* pvaXData, VARIANT* pvaYData);
	void StopAverageAcquisition();
	void Reset();
	float GetRecordLength(short Protocol);
	void SetRecordLength(short Protocol, float newValue);
	float GetTimeOffset(short Protocol);
	void SetTimeOffset(short Protocol, float newValue);
	float GetSamplingInterval(short Protocol);
	void SetSamplingInterval(short Protocol, float newValue);
	float GetOffset(short Protocol);
	void SetOffset(short Protocol, float newValue);
	long GetScansAveraged(short Protocol);
	void SetScansAveraged(short Protocol, long nNewValue);
	float GetDeadTime(short Protocol);
	void SetDeadTime(short Protocol, float newValue);
	float GetICSVersion();
	void ResetHotLink();
	BOOL GetEnhancer(short Protocol);
	void SetEnhancer(short Protocol, BOOL bNewValue);
	CString GetInstVersion();
	void SaveTrendDataFile(LPCTSTR Name);
	BOOL IsInstPresent();
	CString GetAverageConfig(short Protocol);
	BOOL GetRawData(VARIANT* pvData, long lLength, long lTimeout);
	CString Direct(LPCTSTR szCommand);
	void StartAverageAcquisition(const VARIANT& vaExtraData, long ExtraDataOperator, double Constant, long ConstantOperator);
	void StopTrendAcquisition();
	BOOL GetTrendDataFromInst(VARIANT* vaXData, VARIANT* vaYData, short Protocol, long* plValidProtocols);
	void ResumeTrend();
	BOOL GetTrendData(VARIANT* vaXData, VARIANT* vaYData);
	void StartTrendAcquisition(LPCTSTR FilePath, long lOffset, BOOL bDiskPriority);
	BOOL SaveBasicTrendData(LPCTSTR Name);
	void SetupTrendFileInfo(LPCTSTR FilePath);
	BOOL GetTrendRecord(VARIANT* vaXData, VARIANT* vaYData, long lIndex, float fSmpInterval, float fRecordLength, short sProtocol, long lAveraged, long bEnhancer, BOOL bSuspend, BOOL bLoadBasicTrend);
	long GetProtocolFromTrendIndex(LPCTSTR FilePath, long lIndex);
	BOOL GetBasicTrendData(VARIANT* vaXData, VARIANT* vaYData, LPCTSTR FilePath);
};
#endif