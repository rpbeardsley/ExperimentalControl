#if !defined(AFX_INSTRUMENTOPERATIONS_H__91A053BA_A869_11D1_9095_0060089615C2__INCLUDED_)
#define AFX_INSTRUMENTOPERATIONS_H__91A053BA_A869_11D1_9095_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// InstrumentOperations.h : header file
//
#include <winbase.h>
#include "Settings.h"
#include "ICSDlg.h"
#include "ThreadUtils.h"

#define BZERO(buf) memset(&(buf),0,sizeof(buf))

#pragma pack(push,1)
struct LCInfo 
{
	int m_iProtocol;
	long m_lTime;	
	long m_lLength;
	__int64 m_lTotalIonCount;
	__int64 m_i64StartOffset;
};
#pragma pack(pop)

enum enumType
{
	eDword,
	eLCInfo
};
enum enumAcqMode
{
	eTOFMode = 0,
	eCTOFMode,
	eGPAverageMode,
	eGPTrendModeDiskPriority,
	eGPTrendModeDisplayPriority
};

class CBuffer : public CObject
{
	public:

		CBuffer(UINT bufSize, enumType Type);
		virtual ~CBuffer();

		virtual DWORD* Lock(){::EnterCriticalSection(&cs);TRACE1("Locked by %d.\n", *AfxGetThread() );return m_pArray;}
		virtual const DWORD* Lock()const{::EnterCriticalSection(&cs);return m_pArray;} 
	
		virtual LCInfo* LockStruct(){::EnterCriticalSection(&cs);TRACE1("LockStruct by %d.\n", *AfxGetThread() );return m_pLCInfo;}
		virtual const LCInfo* LockStruct()const{::EnterCriticalSection(&cs);return m_pLCInfo;} 

		virtual void UnLock(){::LeaveCriticalSection(&cs);TRACE1("UnLocked by %d.\n", *AfxGetThread() );}

	protected:

		mutable CRITICAL_SECTION cs;
		DWORD* m_pArray;
		LCInfo* m_pLCInfo;
		enumType m_Type;
};

class CCollectData : public CObject
{
public:

	CCollectData();
	virtual ~CCollectData();

	CBuffer* m_pSmallBuffer1;
	CBuffer* m_pSmallBuffer2;
	CBuffer* m_pLargeBuffer;
	CBuffer* m_pLargeBuffer2;
	CBuffer* m_pLCBuffer;

	ULONG m_lBlocksize;
	HANDLE m_hInstrument;
	CString m_szLCFilePath;
	CString m_szTOFFilePath;
	long m_lCTOFFileStartOffset;
	
	bool m_bIsCollecting;
	bool m_bBufferReady;
	bool m_bIsDSPPresent;
	long m_lAcqMode;

	bool m_bGetNewBuffer;
	bool m_bFillingTOFBuffer;

	long m_lLCCnt;
	__int64 m_i64TotalOffset;
	long m_lFrameLength;
	long m_lLoc;
	long m_lOff;
	long m_lHeader;

	short m_sCurrentProtocol;
	float m_fCurrentSamplingInterval;
	float m_fCurrentRecordLength;
	double m_dScansAveraged;
	double m_dInstOffset;
	double m_dConstValue;
	long m_lConstOper;
	VARIANT m_vaExtraData;
	long m_lExtraDataOper;
	HANDLE m_hDataReadyEvent;
	long m_lNumBytesTransferred;

	//TOF Only
	int m_iTOFProtocol;
	long m_lTOFTime;
	long m_lTOFStartOffset;
	BYTE* m_pBufferPointer;
	__int64 m_i64TIC;

	//Hard Drive space check
	__int64 m_i64SpaceAvailable;

	CWinThread* m_pThread;
	VARIANT m_vaXData;
	VARIANT m_vaYData;
	CICSDlg* m_pWnd;
protected:

	
};


#pragma pack(push,1)
struct TTriple {
	BYTE byLo;
	BYTE byMid;
	BYTE byHi;
};
#pragma pack(pop)

/////////////////////////////////////////////////////////////////////////////
// CInstrumentOperations command target

class CInstrumentOperations : public CCmdTarget
{
	DECLARE_DYNCREATE(CInstrumentOperations)

	CInstrumentOperations();           // protected constructor used by dynamic creation
	virtual ~CInstrumentOperations();

// Attributes
public:

// Operations
public:
	
	virtual void Reset();
	virtual void StartAcquisition(CString, BOOL, long);
	virtual void StopAcquisition();
	virtual CString SendCommand(CString);

	virtual bool UnCompress(PUCHAR pcInput,int nInLen, long *pnOutput,int nOutLen, bool bInterpolate);
	virtual void Interpolate(long *nBuffer,int nNumPoints);
	virtual long GetProtocolFromIndex(CString, long);

	virtual double CalcOffset(unsigned long ulNumAves);

	
	// Send a Message to the AMCC and wait for the Add-On to retrieve it
	LONG  SendMessageAndWait(HANDLE, ULONG, ULONG, ULONG, ULONG, ULONG);
	//Acquisition Thread Proc
	static UINT TransferData(LPVOID);
	static void ProcessTOFData(CCollectData*);

	virtual CCollectData* GetDataParams(){return &m_Data;}

	//Second Attempt
	virtual bool GetLCFromInst(VARIANT FAR*, VARIANT FAR*, short, long*);
	virtual bool GetLCFromFile(VARIANT FAR*, VARIANT FAR*, short, long*);
	virtual bool GetCTOFFromFile(VARIANT FAR*, VARIANT FAR* , long, float, float, short);
	virtual bool GetCTOFActiveTOF(VARIANT FAR*, VARIANT FAR* , long, float, float, short);
	virtual bool GetTOFFromInst(VARIANT FAR*, VARIANT FAR*);
	virtual bool GetRawFromInst(VARIANT FAR* vArray, long lNumBytes, long lTimeOut);
	virtual bool MakeCFile(CString,long);

	//General purpose instrument specific functions
	virtual void StartAverageAcquisition(const VARIANT FAR&, long, double, long);
	virtual void StopAverageAcquisition();
	virtual void StartTrendAcquisition(LPCTSTR, long, BOOL);
	virtual void StopTrendAcquisition();
	virtual bool GetAverageFromInst(VARIANT FAR*, VARIANT FAR*);
	virtual bool GetTrendDataDisplay(VARIANT FAR*, VARIANT FAR*);
	virtual BOOL TrendRecordData(VARIANT FAR*, VARIANT FAR* , long, float, float, short, long, BOOL, BOOL);
	virtual void ResumeTrendAcquisition();
	virtual int LoadBasicTrendData();
	virtual BOOL GetBasicTrendData(VARIANT FAR*, VARIANT FAR*, LPCTSTR);

	
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInstrumentOperations)
	//}}AFX_VIRTUAL

// Implementation

protected:

	CCollectData m_Data;

	float m_fBinWidth;
	long m_lLastNumPoints;
	long m_lLastProtocolRequested;

	ULARGE_INTEGER m_BytesAvailToCaller;
	ULARGE_INTEGER m_BytesTotal;
	ULARGE_INTEGER m_BytesTotalAvail;

	HINSTANCE m_hKernel32;
	typedef BOOL(WINAPI* PFNCANCELIO)(HANDLE);
	typedef BOOL(WINAPI* PFNGETDISKFREE)(LPCTSTR, PULARGE_INTEGER, PULARGE_INTEGER, PULARGE_INTEGER);

	PFNCANCELIO m_pfnCancelIO;
	PFNGETDISKFREE m_pfnGetDiskFree;

	//Functions that are exported from the "Eclipse" measurement DLLs
	typedef int(WINAPI* PFNGETNAME)(char*);
	typedef int(WINAPI* PFNGETVER)(char*);
	typedef int(WINAPI* PFNCALCULATE)(int, double*, double*, int, int, char*, void*);

//	HMODULE	m_hMeasurements[4];

//	TrendSetup m_trendSetup[4];

	// Generated message map functions
	//{{AFX_MSG(CInstrumentOperations)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INSTRUMENTOPERATIONS_H__91A053BA_A869_11D1_9095_0060089615C2__INCLUDED_)
