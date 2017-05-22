// Machine generated IDispatch wrapper class(es) created with ClassWizard

#include "stdafx.h"
#include "ics.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif



/////////////////////////////////////////////////////////////////////////////
// IICSGP properties

long IICSGP::GetTimePreset()
{
	long result;
	GetProperty(0x1, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetTimePreset(long propVal)
{
	SetProperty(0x1, VT_I4, propVal);
}

BOOL IICSGP::GetRps()
{
	BOOL result;
	GetProperty(0x2, VT_BOOL, (void*)&result);
	return result;
}

void IICSGP::SetRps(BOOL propVal)
{
	SetProperty(0x2, VT_BOOL, propVal);
}

short IICSGP::GetProtocol()
{
	short result;
	GetProperty(0x3, VT_I2, (void*)&result);
	return result;
}

void IICSGP::SetProtocol(short propVal)
{
	SetProperty(0x3, VT_I2, propVal);
}

long IICSGP::GetSpectrumPreset()
{
	long result;
	GetProperty(0x4, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetSpectrumPreset(long propVal)
{
	SetProperty(0x4, VT_I4, propVal);
}

long IICSGP::GetRecord()
{
	long result;
	GetProperty(0x5, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetRecord(long propVal)
{
	SetProperty(0x5, VT_I4, propVal);
}

long IICSGP::GetRecords()
{
	long result;
	GetProperty(0x6, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetRecords(long propVal)
{
	SetProperty(0x6, VT_I4, propVal);
}

long IICSGP::GetRecordsStored()
{
	long result;
	GetProperty(0x7, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetRecordsStored(long propVal)
{
	SetProperty(0x7, VT_I4, propVal);
}

long IICSGP::GetDataLength()
{
	long result;
	GetProperty(0x8, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetDataLength(long propVal)
{
	SetProperty(0x8, VT_I4, propVal);
}

BOOL IICSGP::GetActive()
{
	BOOL result;
	GetProperty(0x9, VT_BOOL, (void*)&result);
	return result;
}

void IICSGP::SetActive(BOOL propVal)
{
	SetProperty(0x9, VT_BOOL, propVal);
}

long IICSGP::GetTimeElapsed()
{
	long result;
	GetProperty(0xa, VT_I4, (void*)&result);
	return result;
}

void IICSGP::SetTimeElapsed(long propVal)
{
	SetProperty(0xa, VT_I4, propVal);
}

BOOL IICSGP::GetIsDSPPresent()
{
	BOOL result;
	GetProperty(0xb, VT_BOOL, (void*)&result);
	return result;
}

void IICSGP::SetIsDSPPresent(BOOL propVal)
{
	SetProperty(0xb, VT_BOOL, propVal);
}

BOOL IICSGP::GetTriggerPolarity()
{
	BOOL result;
	GetProperty(0xc, VT_BOOL, (void*)&result);
	return result;
}

void IICSGP::SetTriggerPolarity(BOOL propVal)
{
	SetProperty(0xc, VT_BOOL, propVal);
}

/////////////////////////////////////////////////////////////////////////////
// IICSGP operations

BOOL IICSGP::GetDataFromInst(VARIANT* pvaXData, VARIANT* pvaYData)
{
	BOOL result;
	static BYTE parms[] =
		VTS_PVARIANT VTS_PVARIANT;
	InvokeHelper(0xd, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		pvaXData, pvaYData);
	return result;
}

void IICSGP::StopAverageAcquisition()
{
	InvokeHelper(0xe, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
}

void IICSGP::Reset()
{
	InvokeHelper(0xf, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
}

float IICSGP::GetRecordLength(short Protocol)
{
	float result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x23, DISPATCH_PROPERTYGET, VT_R4, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetRecordLength(short Protocol, float newValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_R4;
	InvokeHelper(0x23, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, newValue);
}

float IICSGP::GetTimeOffset(short Protocol)
{
	float result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x24, DISPATCH_PROPERTYGET, VT_R4, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetTimeOffset(short Protocol, float newValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_R4;
	InvokeHelper(0x24, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, newValue);
}

float IICSGP::GetSamplingInterval(short Protocol)
{
	float result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x25, DISPATCH_PROPERTYGET, VT_R4, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetSamplingInterval(short Protocol, float newValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_R4;
	InvokeHelper(0x25, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, newValue);
}

float IICSGP::GetOffset(short Protocol)
{
	float result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x26, DISPATCH_PROPERTYGET, VT_R4, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetOffset(short Protocol, float newValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_R4;
	InvokeHelper(0x26, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, newValue);
}

long IICSGP::GetScansAveraged(short Protocol)
{
	long result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x27, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetScansAveraged(short Protocol, long nNewValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_I4;
	InvokeHelper(0x27, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, nNewValue);
}

float IICSGP::GetDeadTime(short Protocol)
{
	float result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x28, DISPATCH_PROPERTYGET, VT_R4, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetDeadTime(short Protocol, float newValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_R4;
	InvokeHelper(0x28, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, newValue);
}

float IICSGP::GetICSVersion()
{
	float result;
	InvokeHelper(0x10, DISPATCH_METHOD, VT_R4, (void*)&result, NULL);
	return result;
}

void IICSGP::ResetHotLink()
{
	InvokeHelper(0x11, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
}

BOOL IICSGP::GetEnhancer(short Protocol)
{
	BOOL result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x29, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, parms,
		Protocol);
	return result;
}

void IICSGP::SetEnhancer(short Protocol, BOOL bNewValue)
{
	static BYTE parms[] =
		VTS_I2 VTS_BOOL;
	InvokeHelper(0x29, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms,
		 Protocol, bNewValue);
}

CString IICSGP::GetInstVersion()
{
	CString result;
	InvokeHelper(0x12, DISPATCH_METHOD, VT_BSTR, (void*)&result, NULL);
	return result;
}

void IICSGP::SaveTrendDataFile(LPCTSTR Name)
{
	static BYTE parms[] =
		VTS_BSTR;
	InvokeHelper(0x13, DISPATCH_METHOD, VT_EMPTY, NULL, parms,
		 Name);
}

BOOL IICSGP::IsInstPresent()
{
	BOOL result;
	InvokeHelper(0x14, DISPATCH_METHOD, VT_BOOL, (void*)&result, NULL);
	return result;
}

CString IICSGP::GetAverageConfig(short Protocol)
{
	CString result;
	static BYTE parms[] =
		VTS_I2;
	InvokeHelper(0x15, DISPATCH_METHOD, VT_BSTR, (void*)&result, parms,
		Protocol);
	return result;
}

BOOL IICSGP::GetRawData(VARIANT* pvData, long lLength, long lTimeout)
{
	BOOL result;
	static BYTE parms[] =
		VTS_PVARIANT VTS_I4 VTS_I4;
	InvokeHelper(0x16, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		pvData, lLength, lTimeout);
	return result;
}

CString IICSGP::Direct(LPCTSTR szCommand)
{
	CString result;
	static BYTE parms[] =
		VTS_BSTR;
	InvokeHelper(0x17, DISPATCH_METHOD, VT_BSTR, (void*)&result, parms,
		szCommand);
	return result;
}

void IICSGP::StartAverageAcquisition(const VARIANT& vaExtraData, long ExtraDataOperator, double Constant, long ConstantOperator)
{
	static BYTE parms[] =
		VTS_VARIANT VTS_I4 VTS_R8 VTS_I4;
	InvokeHelper(0x18, DISPATCH_METHOD, VT_EMPTY, NULL, parms,
		 &vaExtraData, ExtraDataOperator, Constant, ConstantOperator);
}

void IICSGP::StopTrendAcquisition()
{
	InvokeHelper(0x19, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
}

BOOL IICSGP::GetTrendDataFromInst(VARIANT* vaXData, VARIANT* vaYData, short Protocol, long* plValidProtocols)
{
	BOOL result;
	static BYTE parms[] =
		VTS_PVARIANT VTS_PVARIANT VTS_I2 VTS_PI4;
	InvokeHelper(0x1a, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		vaXData, vaYData, Protocol, plValidProtocols);
	return result;
}

void IICSGP::ResumeTrend()
{
	InvokeHelper(0x1b, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
}

BOOL IICSGP::GetTrendData(VARIANT* vaXData, VARIANT* vaYData)
{
	BOOL result;
	static BYTE parms[] =
		VTS_PVARIANT VTS_PVARIANT;
	InvokeHelper(0x1c, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		vaXData, vaYData);
	return result;
}

void IICSGP::StartTrendAcquisition(LPCTSTR FilePath, long lOffset, BOOL bDiskPriority)
{
	static BYTE parms[] =
		VTS_BSTR VTS_I4 VTS_BOOL;
	InvokeHelper(0x1d, DISPATCH_METHOD, VT_EMPTY, NULL, parms,
		 FilePath, lOffset, bDiskPriority);
}

BOOL IICSGP::SaveBasicTrendData(LPCTSTR Name)
{
	BOOL result;
	static BYTE parms[] =
		VTS_BSTR;
	InvokeHelper(0x1e, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		Name);
	return result;
}

void IICSGP::SetupTrendFileInfo(LPCTSTR FilePath)
{
	static BYTE parms[] =
		VTS_BSTR;
	InvokeHelper(0x1f, DISPATCH_METHOD, VT_EMPTY, NULL, parms,
		 FilePath);
}

BOOL IICSGP::GetTrendRecord(VARIANT* vaXData, VARIANT* vaYData, long lIndex, float fSmpInterval, float fRecordLength, short sProtocol, long lAveraged, long bEnhancer, BOOL bSuspend, BOOL bLoadBasicTrend)
{
	BOOL result;
	static BYTE parms[] =
		VTS_PVARIANT VTS_PVARIANT VTS_I4 VTS_R4 VTS_R4 VTS_I2 VTS_I4 VTS_I4 VTS_BOOL VTS_BOOL;
	InvokeHelper(0x20, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		vaXData, vaYData, lIndex, fSmpInterval, fRecordLength, sProtocol, lAveraged, bEnhancer, bSuspend, bLoadBasicTrend);
	return result;
}

long IICSGP::GetProtocolFromTrendIndex(LPCTSTR FilePath, long lIndex)
{
	long result;
	static BYTE parms[] =
		VTS_BSTR VTS_I4;
	InvokeHelper(0x21, DISPATCH_METHOD, VT_I4, (void*)&result, parms,
		FilePath, lIndex);
	return result;
}

BOOL IICSGP::GetBasicTrendData(VARIANT* vaXData, VARIANT* vaYData, LPCTSTR FilePath)
{
	BOOL result;
	static BYTE parms[] =
		VTS_PVARIANT VTS_PVARIANT VTS_BSTR;
	InvokeHelper(0x22, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms,
		vaXData, vaYData, FilePath);
	return result;
}
