// TrendView.cpp : implementation file
//***************************************************************************************
//TrendView.cpp : implementation file
//
//	Functions: For details on functions in this file see TrendView.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "MainFrm.h"
#include "TrendView.h"
#include "GraphProperties.h"
#include "IO.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTrendView

IMPLEMENT_DYNCREATE(CTrendView, CView)

CTrendView::CTrendView()
{
	m_vaTrendXData.parray = NULL;
	m_vaTrendYData.parray = NULL;
	m_pHoverWnd = NULL;

	m_bAcqInProgress = false;
	m_iCurrentTrackView = 0;
}

CTrendView::~CTrendView()
{
	//Make sure the hover window is deleted
	if(m_pHoverWnd != NULL)
	{
		m_pHoverWnd->DestroyWindow();
		delete m_pHoverWnd;
		m_pHoverWnd = NULL;
	}

	FreeMeasurementDLLs();
}


BEGIN_MESSAGE_MAP(CTrendView, CView)
	//{{AFX_MSG_MAP(CTrendView)
	ON_WM_SIZE()
	ON_WM_TIMER()
	ON_COMMAND(IDM_COPYGRAPH, OnCopygraph)
	ON_WM_DESTROY()
	ON_WM_SETCURSOR()
	ON_WM_LBUTTONUP()
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
	ON_COMMAND(ID_RIGHT_GRAPH_PROPS, OnRightGraphProperties)
	ON_COMMAND(ID_VIEWMODE_MARKER, OnRightSetMarkerTool)
	ON_COMMAND(ID_VIEWMODE_ZOOM, OnRightSetZoomTool)
	ON_COMMAND(ID_RIGHT_SUM, OnRightSum)

	ON_COMMAND(IDM_VIEW_TRACK1, OnRightSetTrack1)
	ON_COMMAND(IDM_VIEW_TRACK2, OnRightSetTrack2)
	ON_COMMAND(IDM_VIEW_TRACK3, OnRightSetTrack3)
	ON_COMMAND(IDM_VIEW_TRACK4, OnRightSetTrack4)

	ON_COMMAND(IDR_RECALC_ALL, OnRightReCalcTrend)


END_MESSAGE_MAP()

BEGIN_EVENTSINK_MAP(CTrendView, CView)
    //{{AFX_EVENTSINK_MAP(CTrendView)
	ON_EVENT(CTrendView, IDC_GSXTREND, 1 /* GSXMouseDown */, OnGSXMouseDown, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CTrendView, IDC_GSXTREND, 2 /* GSXMouseUp */, OnGSXMouseUp, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CTrendView, IDC_GSXTREND, 3 /* GSXMouseMove */, OnGSXMouseMove, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CTrendView, IDC_GSXTREND, 4 /* GSXRepaint */, OnGSXRepaint, VTS_I4 VTS_I4 VTS_I4 VTS_I4 VTS_I4)
	ON_EVENT(CTrendView, IDC_GSXTREND, 5 /* GSXClick */, OnGSXClick, VTS_NONE)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTrendView drawing

void CTrendView::OnDraw(CDC* pDC)
{
	CDocument* pDoc = GetDocument();
	// TODO: add draw code here
}

/////////////////////////////////////////////////////////////////////////////
// CTrendView diagnostics

#ifdef _DEBUG
void CTrendView::AssertValid() const
{
	CView::AssertValid();
}

void CTrendView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CTrendView message handlers
bool CTrendView::CreateTrendGraph()
{
	CRect rect;

	GetClientRect(&rect);


	//Create graph object
	if(!m_Graph.Create(NULL,WS_VISIBLE | WS_CHILD, rect, this, IDC_GSXTREND, NULL, FALSE))

	{
		TRACE(_T("Could not create the GSX control"));
		return false;
	}
	ASSERT(m_Graph);

	m_Graph.SetBatchMode(TRUE);
	m_Graph.SetInternalMarker(TRUE);		//Enable Marker
	m_Graph.SetInternalZoom(TRUE);			//Enable Zooming
	m_Graph.SetInternalGain(FALSE);			//Turn of gain adjustment capability
	m_Graph.SetShowActiveGraph(TRUE);		//Enable "Active Graph"
	m_Graph.SetActiveGraph(TRUE);			//Make this graph Active
	m_Graph.SetNumberOfSeries(1);
	m_Graph.SetBatchMode(FALSE);

	return true;
}


BOOL CTrendView::Create(LPCTSTR lpszClassName, LPCTSTR lpszWindowName, DWORD dwStyle, const RECT& rect, CWnd* pParentWnd, UINT nID, CCreateContext* pContext) 
{
	
	BOOL bRet = CWnd::Create(lpszClassName, lpszWindowName, dwStyle, rect, pParentWnd, nID, pContext);

	if( CreateTrendGraph() )GraphSettings(false);

	return bRet;
}


void CTrendView::OnSize(UINT nType, int cx, int cy) 
{
	CView::OnSize(nType, cx, cy);
	
	if(m_Graph)m_Graph.Size(0,0,cx,cy);
	
}

void CTrendView::StartTrendAcquisition(CString FilePath)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	StopTrendAcquisition();

	m_bAcqInProgress = true;//Yep were running!

	//Set our realtime flag to the way it is when we start running
	m_bRealTime = ((CButton*)pWnd->GetAcqTab()->GetDlgItem(IDC_REALTIME))->GetCheck();

	try
	{
		pApp->SetCurrentViewProtocol( pWnd->GetICS()->GetProtocol() );
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
	}

	pWnd->GetAverageView()->GetSettings()->Initialize();
	pWnd->GetAverageView()->GetSettings()->LoadSettingsFromInstrument();

	CFile addSettings;

	CString TmpFilePath;
	TmpFilePath = pApp->GetDataDir();
	m_sCurrentFile = TmpFilePath;
	m_sCurrentFile += _T("\\__ICS__TMP.FFC");//needed for summing 
	TmpFilePath += _T("\\__ICS__TMP.FFT");

	//Sometimes an Acq was started while the last acq data is still being written
	//This loop will wait until the file is available then move on
	int iCnt = 0;
	while(!addSettings.Open(TmpFilePath, CFile::modeCreate | CFile::modeWrite))
	{
		::Sleep(50);
		TRACE("Waiting for the File to be available.\n");
		if(iCnt > 5000)break; //Just in case something really bad happens go ahead and break out...
	}

	CArchive ar(&addSettings, CArchive::store);
	pWnd->GetAverageView()->GetSettings()->Serialize(ar);
	ar.Close();

	addSettings.Close();

	try
	{
		pWnd->GetICS()->StartTrendAcquisition(FilePath, SETTINGS_SIZE, !m_bRealTime);

		LoadMeasurementDLLs();

		m_iNumberOfMeasurements = 0;
		m_iMeasurementIdx = 0;
		for(int n=0;n<20000;n++)BZERO( m_Measurements[n] );


		//Pick a used Track number to start
		if( m_iCurrentTrackView == 0 )
		{
			if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) )m_iCurrentTrackView = 4;
			if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) )m_iCurrentTrackView = 3;
			if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) )m_iCurrentTrackView = 2;
			if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) )m_iCurrentTrackView = 1;
		}
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
	}

	//Open the cal file that was selected for the 
	if(pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_bCalValid)
	{
		//Start using calibration
		pApp->SetCalState(1);
	}
	else
	{
		pApp->SetCalState(0);
	}

	m_bAdjustOnce = true;//force view to show a valid protocol's data

	
	SetTimer(TRENDACQUISITION, 300, NULL);
}
void CTrendView::StopTrendAcquisition() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	KillTimer(TRENDACQUISITION);
	try
	{
		pWnd->GetICS()->StopTrendAcquisition();
		FreeMeasurementDLLs();
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}

	m_bAcqInProgress = false;//Done.
}

void CTrendView::LoadMeasurementDLLs()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	FreeMeasurementDLLs();
	
	PFNGETNAME pfnGetName;

	int iCount = 0;

	CFileFind finder;  
	CString sDllPath;
	CString sAppPath;

	sAppPath = pApp->m_pszHelpFilePath;

	int iLen = sAppPath.GetLength();

	sAppPath = sAppPath.Left(iLen - 11);
	sAppPath += _T("\\Measurements\\Eclipse*.*");

	BOOL bWorking = finder.FindFile(sAppPath);

	HMODULE hTmpDll;

    while (bWorking)//Locate all "Eclipse measurement dlls"
    {      
		bWorking = finder.FindNextFile();

		sDllPath = finder.GetFilePath();

		TRACE1("Found %s\n", sDllPath);

        hTmpDll = AfxLoadLibrary(sDllPath);

		CString Name1 = pApp->GetProfileString(_T("Trend"), _T("Measurement1Name"), "");
		CString Name2 = pApp->GetProfileString(_T("Trend"), _T("Measurement2Name"), "");
		CString Name3 = pApp->GetProfileString(_T("Trend"), _T("Measurement3Name"), "");
		CString Name4 = pApp->GetProfileString(_T("Trend"), _T("Measurement4Name"), "");
	
		if(hTmpDll != NULL)
		{
			char Name[255];
			int iNumChars;

			pfnGetName = (PFNGETNAME)::GetProcAddress( hTmpDll, "_GetName@4" );

			if(pfnGetName)iNumChars = pfnGetName( Name );

			if(lstrcmp(Name, Name1) == 0)
			{
				TRACE1("%s installed.\n", Name);
				m_hMeasurement[0] = AfxLoadLibrary(sDllPath);//Since loading again just increments ref cnt
			}												  //should not cause speed decrease

			if(lstrcmp(Name, Name2) == 0)
			{
				TRACE1("%s installed.\n", Name);
				m_hMeasurement[1] = AfxLoadLibrary(sDllPath);
			}
			if(lstrcmp(Name, Name3) == 0)
			{
				TRACE1("%s installed.\n", Name);
				m_hMeasurement[2] = AfxLoadLibrary(sDllPath);
			}
			if(lstrcmp(Name, Name4) == 0)
			{
				TRACE1("%s installed.\n", Name);
				m_hMeasurement[3] = AfxLoadLibrary(sDllPath);
			}
			
			//This Free up the Tmp dll
			AfxFreeLibrary( hTmpDll );
		}
	}

	finder.Close();

}
void CTrendView::FreeMeasurementDLLs()
{
	for(int n=0;n<4;n++)
	{
		if( m_hMeasurement[n] != NULL )
		{
			AfxFreeLibrary( m_hMeasurement[n] );
			m_hMeasurement[n] = NULL;
		}
	}

}

void CTrendView::OnTimer(UINT nIDEvent) 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	HRESULT hr;

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

//	static BOOL bShowRealTime = FALSE;

	bool bStopped = false;

	switch(nIDEvent)
	{
		case TRENDHOVER:
		
		KillTimer(TRENDHOVER);

		if(m_pHoverWnd == NULL)
		{
			DisplayHoverWindow();
		}

		break;
		case TRENDACQUISITION:

			KillTimer(TRENDACQUISITION);

			try
			{
				if(!pWnd->GetICS()->GetActive())
				{
					pWnd->GetAcqTab()->OnAcqStop();
					bStopped = true;
				}
				else bStopped = false;

				VARIANT vaXTmpData;
				VARIANT vaYTmpData;

				VariantInit(&vaXTmpData);
				VariantInit(&vaYTmpData);
			
		
				if( pWnd->GetICS()->GetTrendDataFromInst(&vaXTmpData, &vaYTmpData, pApp->GetCurrentViewProtocol(), &m_lValidProtocolsFlag) )
				{
					TRACE("Got new Trend data.\n");			
					VariantClear(&m_vaTrendXData);
					VariantClear(&m_vaTrendYData);

					VariantInit(&m_vaTrendXData);
					VariantInit(&m_vaTrendYData); 

					VariantCopy(&m_vaTrendXData, &vaXTmpData);
					VariantCopy(&m_vaTrendYData, &vaYTmpData);

					VariantClear( &vaXTmpData );
					VariantClear( &vaYTmpData );

				/*	if(m_bAdjustOnce)
					{
						bShowRealTime = pApp->GetLastRealTime();
						m_bAdjustOnce = false;
					}*/
					//Turn on the "Data Processed" LED on Acquisition Tab
					
					pWnd->GetAcqTab()->GetLED1()->MomentaryOn();

					if(m_vaTrendXData.vt == (VT_ARRAY | VT_R8) )
					{
						if(m_bRealTime)
						{
							CreateTrendData();
						}
						else
						{
							m_Graph.SetAxisYText("Not Measured");

							m_iNumberOfMeasurements = m_vaTrendXData.parray->rgsabound->cElements;
							
							double* pXTrendData = NULL;

							hr = SafeArrayAccessData(m_vaTrendXData.parray, (void **)&pXTrendData);
							if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));
		
							//Store the time info
							for(int n=0;n<m_iNumberOfMeasurements;n++)
							{
								m_Measurements[n].fTrack1Time = (float)pXTrendData[n];
								m_Measurements[n].fTrack2Time = (float)pXTrendData[n];
								m_Measurements[n].fTrack3Time = (float)pXTrendData[n];
								m_Measurements[n].fTrack4Time = (float)pXTrendData[n];
							}

							hr = SafeArrayUnaccessData(m_vaTrendXData.parray);
							if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

			
							m_Graph.SetDataEx(&m_vaTrendXData, &m_vaTrendYData, 1, FALSE);
						}
					}
					
				}

			}
			catch(COleException* e)
			{
				TRACE("Ole Exception caught and data collection has been stopped.\n");
				e->Delete();
				bStopped = true;
				pWnd->GetAcqTab()->OnAcqStop();
			}

			if(!bStopped)
			{
				SetTimer(TRENDACQUISITION, 300, NULL);
			}
		

		break;
	}
	
	CView::OnTimer(nIDEvent);
}
void CTrendView::ReCalculateTrend()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	VARIANT vaAverageXData;
	VARIANT vaAverageYData;

	VariantInit(&vaAverageXData);
	VariantInit(&vaAverageYData);

	int iIndex = 1;
	int iNumChars;
	PFNCALCULATE pfnCalculate;
	PFNGETNAME pfnGetName;
	char szResult[256];
	HRESULT hr;
	m_iMeasurementIdx = 0;
	char szUnits[256];

	//Now that we are recalculating the file can be saved as a "realtime" trend file (contains Y axis info)
	m_bRealTime = TRUE;
	//It can now be re-saved 
	pWnd->m_bSavable = true;

	//Pick a used Track number to start

	switch( m_iCurrentTrackView )
	{
		case 1:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) )m_iCurrentTrackView = 0;
		break;
		case 2:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) )m_iCurrentTrackView = 0;
		break;
		case 3:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) )m_iCurrentTrackView = 0;
		break;
		case 4:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) )m_iCurrentTrackView = 0;
		break;
	}

	if( m_iCurrentTrackView == 0 )
	{
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) )m_iCurrentTrackView = 4;
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) )m_iCurrentTrackView = 3;
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) )m_iCurrentTrackView = 2;
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) )m_iCurrentTrackView = 1;
	}

	BeginWaitCursor();

	m_RecalcTrend.Create( IDD_RECALC_DLG, this );

	m_RecalcTrend.GetProgressBar()->SetRange(0, m_iNumberOfMeasurements);

	LoadMeasurementDLLs();
	CString szTmp;
	lstrcpy(szUnits, "s");


	for(int iIdx=0;iIdx<m_iNumberOfMeasurements;iIdx++)
	{
		try
		{
			if( pWnd->GetICS()->GetTrendRecord(&vaAverageXData, &vaAverageYData, iIdx, 
				pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_fSamplingInterval, 
				pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_fRecordLength,
				pWnd->GetAverageView()->GetSettings()->m_iProtocol, 
				pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_iRecordsPerSpectrum,
				pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_bEnhancer,
				FALSE, TRUE) )
			{

				double* pXData = NULL;
				double* pYData = NULL;

				//Set a pointer to access the X safearray data directly
				hr = SafeArrayAccessData(vaAverageXData.parray, (void **)&pXData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				//Set a pointer to access the Y safearray data directly
				hr = SafeArrayAccessData(vaAverageYData.parray, (void **)&pYData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));
			
				//Turn on the "Data Processed" LED on Acquisition Tab
				pWnd->GetAcqTab()->GetLED1()->MomentaryOn();

				int iNumPoints = vaAverageXData.parray->rgsabound->cElements;

				//Now make the appropiate measurements
				TRACE("Got data from ICS.\n");

				

				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) && m_hMeasurement[0] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[0], "_Calculate@28" );
					
					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement1Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement1End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);
				
					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[0], "_GetName@4" );
					if(pfnGetName)
						 pfnGetName( m_Measurements[iIdx].szTrack1Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[iIdx].szTrack1Unit, szTmp );
					m_Measurements[iIdx].fTrack1Result = (float)atof( szResult );
					m_Measurements[iIdx].bUseTrack1 = TRUE;
					m_Measurements[iIdx].fTrack1From = fStartTime;
					m_Measurements[iIdx].fTrack1To = fEndTime;

				}
				else
				{
					m_Measurements[iIdx].bUseTrack1 = FALSE;
					lstrcpy(m_Measurements[iIdx].szTrack1Name, pApp->GetProfileString(_T("Trend"), _T("Measurement1Name"), ""));
					m_Measurements[iIdx].fTrack1From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement1Start"), "0"));
					m_Measurements[iIdx].fTrack1To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement1End"), "0"));

				}

				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) && m_hMeasurement[1] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[1], "_Calculate@28" );

					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement2Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement2End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);
			
					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[1], "_GetName@4" );
					if(pfnGetName)
						pfnGetName( m_Measurements[iIdx].szTrack2Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[iIdx].szTrack2Unit, szTmp );
					m_Measurements[iIdx].fTrack2Result = (float)atof( szResult );
					m_Measurements[iIdx].bUseTrack2 = TRUE;
					m_Measurements[iIdx].fTrack2From = fStartTime;
					m_Measurements[iIdx].fTrack2To = fEndTime;

				}
				else
				{
					m_Measurements[iIdx].bUseTrack2 = FALSE;

					lstrcpy(m_Measurements[iIdx].szTrack2Name, pApp->GetProfileString(_T("Trend"), _T("Measurement2Name"), ""));
					m_Measurements[iIdx].fTrack2From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement2Start"), "0"));
					m_Measurements[iIdx].fTrack2To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement2End"), "0"));
				}

				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) && m_hMeasurement[2] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[2], "_Calculate@28" );

					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement3Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement3End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);

					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[2], "_GetName@4" );
					if(pfnGetName)
						pfnGetName( m_Measurements[iIdx].szTrack3Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[iIdx].szTrack3Unit, szTmp );
					m_Measurements[iIdx].fTrack3Result = (float)atof( szResult );
					m_Measurements[iIdx].bUseTrack3 = TRUE;
					m_Measurements[iIdx].fTrack3From = fStartTime;
					m_Measurements[iIdx].fTrack3To = fEndTime;

				}
				else
				{
					m_Measurements[iIdx].bUseTrack3 = FALSE;
					lstrcpy(m_Measurements[iIdx].szTrack3Name, pApp->GetProfileString(_T("Trend"), _T("Measurement3Name"), ""));
					m_Measurements[iIdx].fTrack3From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement3Start"), "0"));
					m_Measurements[iIdx].fTrack3To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement3End"), "0"));
				}


				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) && m_hMeasurement[3] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[3], "_Calculate@28" );

					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement4Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement4End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);

					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[3], "_GetName@4" );
					if(pfnGetName)
						pfnGetName( m_Measurements[iIdx].szTrack4Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[iIdx].szTrack4Unit, szTmp );
					m_Measurements[iIdx].fTrack4Result = (float)atof( szResult );
					m_Measurements[iIdx].bUseTrack4 = TRUE;
					m_Measurements[iIdx].fTrack4From = fStartTime;
					m_Measurements[iIdx].fTrack4To = fEndTime;

				}
				else
				{
					m_Measurements[iIdx].bUseTrack4 = FALSE;

					lstrcpy(m_Measurements[iIdx].szTrack4Name, pApp->GetProfileString(_T("Trend"), _T("Measurement4Name"), ""));
					m_Measurements[iIdx].fTrack4From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement4Start"), "0"));
					m_Measurements[iIdx].fTrack4To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement4End"), "0"));
				}
				//Unattach our direct pointers to the data
				hr = SafeArrayUnaccessData(vaAverageXData.parray);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

				hr = SafeArrayUnaccessData(vaAverageYData.parray);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));


				VariantClear(&vaAverageXData);
				VariantClear(&vaAverageYData);
			
				m_RecalcTrend.GetProgressBar()->SetPos( iIdx );

				m_iMeasurementIdx = iIdx+1;
	
				if(m_iCurrentTrackView > 0 && m_iCurrentTrackView < 5)DrawTrendData(m_iCurrentTrackView);
			}

		}
		catch(COleException* e)
		{
			TRACE("Ole Exception caught.\n");
			e->Delete();
		}
	}

	FreeMeasurementDLLs();

	m_RecalcTrend.DestroyWindow();

	EndWaitCursor();


}
void CTrendView::CreateTrendData()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	VARIANT vaAverageXData;
	VARIANT vaAverageYData;

	VariantInit(&vaAverageXData);
	VariantInit(&vaAverageYData);


	int iIndex = 1;
	int iNumChars;
	PFNCALCULATE pfnCalculate;
	PFNGETNAME pfnGetName;
	char szResult[256];
	char szUnits[256];
	CString szTmp;
	lstrcpy(szUnits, "s");
	HRESULT hr;

	//Pick a used Track number to start

	switch( m_iCurrentTrackView )
	{
		case 1:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) )m_iCurrentTrackView = 0;
		break;
		case 2:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) )m_iCurrentTrackView = 0;
		break;
		case 3:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) )m_iCurrentTrackView = 0;
		break;
		case 4:
			if( !pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) )m_iCurrentTrackView = 0;
		break;
	}

	if( m_iCurrentTrackView == 0 )
	{
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) )m_iCurrentTrackView = 4;
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) )m_iCurrentTrackView = 3;
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) )m_iCurrentTrackView = 2;
		if( pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) )m_iCurrentTrackView = 1;
	}

	try
	{
		if( pWnd->GetICS()->GetTrendData(&vaAverageXData, &vaAverageYData) )
		{

			if(vaAverageXData.vt == (VT_ARRAY | VT_R8))
			{
				double* pXData = NULL;
				double* pYData = NULL;

				double* pXTrendData = NULL;

				//Set a pointer to access the X safearray data directly
				hr = SafeArrayAccessData(vaAverageXData.parray, (void **)&pXData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				//Set a pointer to access the Y safearray data directly
				hr = SafeArrayAccessData(vaAverageYData.parray, (void **)&pYData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				hr = SafeArrayAccessData(m_vaTrendXData.parray, (void **)&pXTrendData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

			
				//Turn on the "Data Processed" LED on Acquisition Tab
				pWnd->GetAcqTab()->GetLED1()->MomentaryOn();

				int iNumPoints = vaAverageXData.parray->rgsabound->cElements;

				
				//Now make the appropiate measurements
				TRACE("Got data from ICS.\n");

				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0) && m_hMeasurement[0] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[0], "_Calculate@28" );
					
					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement1Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement1End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);
				
					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[0], "_GetName@4" );
					if(pfnGetName)
						 pfnGetName( m_Measurements[m_iMeasurementIdx].szTrack1Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack1Unit, szTmp );
					m_Measurements[m_iMeasurementIdx].fTrack1Result = (float)atof( szResult );
					m_Measurements[m_iMeasurementIdx].fTrack1Time = (float)pXTrendData[m_iMeasurementIdx];
					m_Measurements[m_iMeasurementIdx].bUseTrack1 = TRUE;
					m_Measurements[m_iMeasurementIdx].fTrack1From = fStartTime;
					m_Measurements[m_iMeasurementIdx].fTrack1To = fEndTime;
				}
				else
				{
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack1Unit, "");
					m_Measurements[m_iMeasurementIdx].bUseTrack1 = FALSE;
					m_Measurements[m_iMeasurementIdx].fTrack1Time = (float)pXTrendData[m_iMeasurementIdx];

					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack1Name, pApp->GetProfileString(_T("Trend"), _T("Measurement1Name"), ""));
					m_Measurements[m_iMeasurementIdx].fTrack1From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement1Start"), "0"));
					m_Measurements[m_iMeasurementIdx].fTrack1To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement1End"), "0"));
				}
			
				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0) && m_hMeasurement[1] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[1], "_Calculate@28" );

					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement2Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement2End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);
			
					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[1], "_GetName@4" );
					if(pfnGetName)
						pfnGetName( m_Measurements[m_iMeasurementIdx].szTrack2Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack2Unit, szTmp );
					m_Measurements[m_iMeasurementIdx].fTrack2Result = (float)atof( szResult );
					m_Measurements[m_iMeasurementIdx].fTrack2Time = (float)pXTrendData[m_iMeasurementIdx];
					m_Measurements[m_iMeasurementIdx].bUseTrack2 = TRUE;
					m_Measurements[m_iMeasurementIdx].fTrack2From = fStartTime;
					m_Measurements[m_iMeasurementIdx].fTrack2To = fEndTime;

				}
				else
				{
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack2Unit, "");
					m_Measurements[m_iMeasurementIdx].bUseTrack2 = FALSE;
					m_Measurements[m_iMeasurementIdx].fTrack2Time = (float)pXTrendData[m_iMeasurementIdx];

					lstrcpy( m_Measurements[m_iMeasurementIdx].szTrack2Name, pApp->GetProfileString(_T("Trend"), _T("Measurement2Name"), ""));
					m_Measurements[m_iMeasurementIdx].fTrack2From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement2Start"), "0"));
					m_Measurements[m_iMeasurementIdx].fTrack2To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement2End"), "0"));

				}

				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0) && m_hMeasurement[2] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[2], "_Calculate@28" );

					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement3Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement3End"), "0") );
		
					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}

					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);

					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[2], "_GetName@4" );
					if(pfnGetName)
						pfnGetName( m_Measurements[m_iMeasurementIdx].szTrack3Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack3Unit, szTmp );
					m_Measurements[m_iMeasurementIdx].fTrack3Result = (float)atof( szResult );
					m_Measurements[m_iMeasurementIdx].fTrack3Time = (float)pXTrendData[m_iMeasurementIdx];
					m_Measurements[m_iMeasurementIdx].bUseTrack3 = TRUE;
					m_Measurements[m_iMeasurementIdx].fTrack3From = fStartTime;
					m_Measurements[m_iMeasurementIdx].fTrack3To = fEndTime;

				}
				else
				{
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack3Unit, "");
					m_Measurements[m_iMeasurementIdx].bUseTrack3 = FALSE;
					m_Measurements[m_iMeasurementIdx].fTrack3Time = (float)pXTrendData[m_iMeasurementIdx];

					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack3Name, pApp->GetProfileString(_T("Trend"), _T("Measurement3Name"), ""));
					m_Measurements[m_iMeasurementIdx].fTrack3From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement3Start"), "0"));
					m_Measurements[m_iMeasurementIdx].fTrack3To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement3End"), "0"));

				}

				if(pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0) && m_hMeasurement[3] != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( m_hMeasurement[3], "_Calculate@28" );

					float fStartTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement4Start"), "0") );
					float fEndTime = (float)atof( pApp->GetProfileString(_T("Trend"), _T("Measurement4End"), "0") );

					if(fStartTime > fEndTime)
					{
						float fTmp = fStartTime;
						fStartTime = fEndTime;
						fEndTime = fTmp;
					}
					
					//Initialize the idx vars
					int iStartIdx = 0, iEndIdx = iNumPoints - 1;
					
					//Convert requested time region to array index for Calculate function.
					for(int n=0;n<iNumPoints-1;n++)
					{
						if(fStartTime >= pXData[n] && fStartTime <= pXData[n+1])iStartIdx = n;
						if(fEndTime >= pXData[n] && fEndTime < pXData[n+1])iEndIdx = n;
					}
					
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iStartIdx, iEndIdx, szResult, szUnits);

					pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[3], "_GetName@4" );
					if(pfnGetName)
						pfnGetName( m_Measurements[m_iMeasurementIdx].szTrack4Name );

					szTmp = szResult;
					szTmp = szTmp.Right( szTmp.GetLength() - szTmp.ReverseFind(' ') - 1 );
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack4Unit, szTmp );
					m_Measurements[m_iMeasurementIdx].fTrack4Result = (float)atof( szResult );
					m_Measurements[m_iMeasurementIdx].fTrack4Time = (float)pXTrendData[m_iMeasurementIdx];
					m_Measurements[m_iMeasurementIdx].bUseTrack4 = TRUE;
					m_Measurements[m_iMeasurementIdx].fTrack4From = fStartTime;
					m_Measurements[m_iMeasurementIdx].fTrack4To = fEndTime;

				}
				else
				{
					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack4Unit, "");
					m_Measurements[m_iMeasurementIdx].bUseTrack4 = FALSE;
					m_Measurements[m_iMeasurementIdx].fTrack4Time = (float)pXTrendData[m_iMeasurementIdx];

					lstrcpy(m_Measurements[m_iMeasurementIdx].szTrack4Name, pApp->GetProfileString(_T("Trend"), _T("Measurement4Name"), ""));
					m_Measurements[m_iMeasurementIdx].fTrack4From = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement4Start"), "0"));
					m_Measurements[m_iMeasurementIdx].fTrack4To = (float)atof(pApp->GetProfileString(_T("Trend"), _T("Measurement4End"), "0"));

				}

				//Unattach our direct pointers to the data
				hr = SafeArrayUnaccessData(vaAverageXData.parray);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

				hr = SafeArrayUnaccessData(vaAverageYData.parray);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

				hr = SafeArrayUnaccessData(m_vaTrendXData.parray);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

				VariantClear(&vaAverageXData);
				VariantClear(&vaAverageYData);
			
				m_iMeasurementIdx++;
				m_iNumberOfMeasurements++;

				if(m_iCurrentTrackView > 0 && m_iCurrentTrackView < 5)DrawTrendData(m_iCurrentTrackView);

				pWnd->GetICS()->ResumeTrend();
			}
		
		}

	}
	catch(COleException* e)
	{
		TRACE("Ole Exception caught.\n");
		e->Delete();
	}
	
}
void CTrendView::DrawTrendData(int iTrackNum)
{
	VARIANT vaTrackX;
	VARIANT vaTrackY;
	HRESULT hr;

	VariantInit( &vaTrackX );
	VariantInit( &vaTrackY );

	// Create SAFEARRAY that will contain the data
	SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array 
	SAFEARRAY FAR* psaYValues = NULL;
	SAFEARRAY FAR* psaXValues = NULL;

	// Set the bounds of the SafeArray
	// (Note: must be 1-based)
	sabOneDim[0].cElements = m_iMeasurementIdx;
	sabOneDim[0].lLbound = 1;
		
	// Create the actual SafeArray descriptors
	TRACE("Creating Safearray in ProcessTOFData (No DSP)\n");
	psaXValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if (psaXValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
	V_VT(&vaTrackX) = VT_ARRAY | VT_R8;
	V_ARRAY(&vaTrackX) = psaXValues;

	// Create the actual SafeArray descriptors
	psaYValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if(psaYValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");
	V_VT(&vaTrackY) = VT_ARRAY | VT_R8;
	V_ARRAY(&vaTrackY) = psaYValues;

	double *pdTmpYArray;
	double *pdTmpXArray;

	//Set a pointer to access the safearray data directly
	hr = SafeArrayAccessData(psaYValues, (void **)&pdTmpYArray);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	hr = SafeArrayAccessData(psaXValues, (void **)&pdTmpXArray);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	CString Text;
	int n;
	switch( m_iCurrentTrackView )
	{ 
		case 1:
			
			Text.Format("%s [%s]", m_Measurements[0].szTrack1Name, m_Measurements[0].szTrack1Unit);
			m_Graph.SetAxisYText( Text );
			for(n=0;n<m_iMeasurementIdx;n++)
			{
				pdTmpYArray[n] = m_Measurements[n].fTrack1Result;
				pdTmpXArray[n] = m_Measurements[n].fTrack1Time;
			}

		break;
		case 2:

			Text.Format("%s [%s]", m_Measurements[0].szTrack2Name, m_Measurements[0].szTrack2Unit);
			m_Graph.SetAxisYText( Text );
			for(n=0;n<m_iMeasurementIdx;n++)
			{
				pdTmpYArray[n] = m_Measurements[n].fTrack2Result;
				pdTmpXArray[n] = m_Measurements[n].fTrack2Time;
			}

		break;
		case 3:

			Text.Format("%s [%s]", m_Measurements[0].szTrack3Name, m_Measurements[0].szTrack3Unit);
			m_Graph.SetAxisYText( Text );
			for(n=0;n<m_iMeasurementIdx;n++)
			{
				pdTmpYArray[n] = m_Measurements[n].fTrack3Result;
				pdTmpXArray[n] = m_Measurements[n].fTrack3Time;
			}

		break;
		case 4:

			Text.Format("%s [%s]", m_Measurements[0].szTrack4Name, m_Measurements[0].szTrack4Unit);
			m_Graph.SetAxisYText( Text );
			for(n=0;n<m_iMeasurementIdx;n++)
			{
				pdTmpYArray[n] = m_Measurements[n].fTrack4Result;
				pdTmpXArray[n] = m_Measurements[n].fTrack4Time;
			}

		break;

	}
	hr = SafeArrayUnaccessData(psaYValues);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

	hr = SafeArrayUnaccessData(psaXValues);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

	//Graph the Trend Mode Track data here
	m_Graph.SetDataEx(&vaTrackX, &vaTrackY, 1, FALSE);

	VariantClear(&vaTrackX);
	VariantClear(&vaTrackY);
}

void CTrendView::DisplayHoverWindow()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CRect rRect;
	CPoint pPoint;
	long lPoint;
	double dataX;
	double dataY;

	m_Graph.GetWindowRect(&rRect);

	::GetCursorPos(&pPoint);

	//Make sure the cursor is over the graph
	if(rRect.PtInRect(pPoint)  && WindowFromPoint(pPoint)->GetParent()->GetSafeHwnd() == m_Graph.GetSafeHwnd() ) 
	{
		//Are we hovering over a data point?
		if( m_Graph.ScalePixelToDataIndex(m_lMousePointerX, m_lMousePointerY, 1, &lPoint, TRUE) )
		{
			dataY = m_Graph.GetYValueFromIndex(1, lPoint, TRUE);
			dataX = m_Graph.GetXValueFromIndex(1, lPoint, TRUE);

			m_pHoverWnd = new CDataHover();//Create a Hover Window
			m_pHoverWnd->Create();
		
			if( ::IsWindow(m_pHoverWnd->GetSafeHwnd()) )
			{
				//Move over 1 pixel so not on top of cursor
				pPoint.x += 1;
				CRect DrawRect;
				CString Text;

				DrawRect.SetRectEmpty();

				Text.Format("%s = %g\n%s = %g",m_Graph.GetAxisXText(), dataX, m_Graph.GetAxisYText(), dataY);

				//Calculate the size of the Hover window
				m_pHoverWnd->GetWindowSize(&DrawRect, Text);
								
				CRect rect;

				rect.left = pPoint.x;
				rect.top = pPoint.y - DrawRect.Height();
				rect.right = pPoint.x + DrawRect.Width() + 4;
				rect.bottom = pPoint.y;

				m_pHoverWnd->MoveWindow(rect,TRUE);
				m_pHoverWnd->ShowWindow(SW_SHOWNA);

			}
			else TRACE("Could not create hover window");
		}
	}
	
}
bool CTrendView::SaveTrendFile(CString Name, bool bNewData)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString TrendPath;

	if(bNewData)
	{

		//First store the "LC" part of file
		if( pWnd->GetICS()->SaveBasicTrendData(Name) )
		{
			TRACE("Basic part of Trend file has been saved");
		
			//Now we need to add the "Trend" part of the file (appended to the LC part)

			CString Tmp;

			Tmp = Name;
			Tmp.MakeUpper();
			if(Tmp.Find(".FFC") == -1)Name += ".FFC";//Add the .FFC extension if not already there

		
			TrendPath.Format(_T("%s\\%s"), pApp->GetDataDir(), Name);

			CFile fileSave( TrendPath, CFile::modeReadWrite );

			long lNumberOfLCStructs;
			if( fileSave.Read( &lNumberOfLCStructs, sizeof(long) ) == sizeof(long) )
			{
			
				fileSave.Write( &m_bRealTime, sizeof(BOOL) );

				fileSave.Seek(lNumberOfLCStructs * sizeof(LCInfoEx), CFile::current);

				//Are we in RealTime Trend Mode
				if( m_bRealTime )
				{
					//now save the number of Trend structures
					fileSave.Write( &m_iNumberOfMeasurements, sizeof(long) );
					
					//next write the trend structures
					fileSave.Write( m_Measurements, m_iNumberOfMeasurements * sizeof( CMeasurements ) );
				}
				else
				{
					fileSave.Write( &m_iNumberOfMeasurements, sizeof(long) );
				}

				fileSave.Close();
			}
		}
	}
	else
	{
		//This file has been opened, then possibly modified so just update the trend info (and realtime status)
	
		CString Tmp;

		Tmp = Name;
		Tmp.MakeUpper();
		if(Tmp.Find(".FFC") == -1)Name += ".FFC";//Add the .FFC extension if not already there
		
		TrendPath.Format(_T("%s\\%s"), pApp->GetDataDir(), Name);

		CFile fileSave( TrendPath, CFile::modeReadWrite );

		long lNumberOfLCStructs;
		if( fileSave.Read( &lNumberOfLCStructs, sizeof(long) ) == sizeof(long) )
		{
		
			fileSave.Write( &m_bRealTime, sizeof(BOOL) );

			fileSave.Seek(lNumberOfLCStructs * sizeof(LCInfoEx), CFile::current);

			//Are we in RealTime Trend Mode
			if( m_bRealTime )
			{

				//now save the number of Trend structures
				fileSave.Write( &m_iNumberOfMeasurements, sizeof(long) );
				
				//next write the trend structures
				fileSave.Write( m_Measurements, m_iNumberOfMeasurements * sizeof( CMeasurements ) );
			}
			else
			{
				//If not realtime mode set to -1
				int iNone = -1;
				fileSave.Write( &iNone, sizeof(long) );
			}

			fileSave.Close();
		}
	}

	return true;
}
bool CTrendView::RetrieveTrendFile(CString FilePath)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	m_sCurrentFile = FilePath;

	VariantClear(&m_vaTrendXData);
	VariantClear(&m_vaTrendYData);

	VariantInit(&m_vaTrendXData);
	VariantInit(&m_vaTrendYData);

	CFile OpenFile;
	CFileException e;

	CString ModFilePath;
	ModFilePath = FilePath;

	ModFilePath = ModFilePath.Left( ModFilePath.GetLength() - 3 );
	ModFilePath += _T("FFT");

	if( (_access( ModFilePath, 0 )) != -1 )
	{

		if( OpenFile.Open( ModFilePath, CFile::modeRead, &e ) )
		{
			try
			{
				//Load the current instrument settings into the "Current" Settings object in the 
				//Average view
				CArchive ar(&OpenFile, CArchive::load);
				pWnd->GetAverageView()->GetSettings()->Serialize(ar);
				ar.Close();
				
				OpenFile.Close();
			
			}
			catch(CFileException* e)
			{
				TRACE(_T("Error opening the settings part of the Stream file"));
				e->Delete();
				return false;
			}

		}
		CFile TrendFile;
		if( TrendFile.Open( FilePath, CFile::modeRead, &e) )
		{
			try
			{
				//Now jump over the LC part of file, then load trend data
				long lNumOfLCStructs;
				if( TrendFile.Read( &lNumOfLCStructs, sizeof(long)) == sizeof(long) )
				{
				
					TrendFile.Read( &m_bRealTime, sizeof(BOOL) );

				
					TrendFile.Seek(lNumOfLCStructs * sizeof(LCInfoEx), CFile::current);

					for(int n=0;n<20000;n++)BZERO( m_Measurements[n] );
						
					//Get the number of Trend structs
					if( TrendFile.Read( &m_iNumberOfMeasurements, sizeof(long)) == sizeof(long) )
					{
						//OK, read the Trend structs
						if(m_iNumberOfMeasurements > 0)
						{
							if( m_bRealTime )
							{
								TrendFile.Read( m_Measurements, m_iNumberOfMeasurements * sizeof( CMeasurements ) );
								TrendFile.Close();

								m_iMeasurementIdx = m_iNumberOfMeasurements;

								switch( m_iCurrentTrackView )
								{
									case 1:
										if( !m_Measurements[0].bUseTrack1 )m_iCurrentTrackView = 0;
									break;
									case 2:
										if( !m_Measurements[0].bUseTrack2 )m_iCurrentTrackView = 0;
									break;
									case 3:
										if( !m_Measurements[0].bUseTrack3 )m_iCurrentTrackView = 0;
									break;
									case 4:
										if( !m_Measurements[0].bUseTrack4 )m_iCurrentTrackView = 0;
									break;
								}

								if( m_iCurrentTrackView == 0 )
								{
									if( m_Measurements[0].bUseTrack4 )m_iCurrentTrackView = 4;
									if( m_Measurements[0].bUseTrack3 )m_iCurrentTrackView = 3;
									if( m_Measurements[0].bUseTrack2 )m_iCurrentTrackView = 2;
									if( m_Measurements[0].bUseTrack1 )m_iCurrentTrackView = 1;
								}

								pWnd->GetICS()->SetupTrendFileInfo(FilePath);

								//Update settings in the registry to mirror the opened trend file!
								pApp->WriteProfileInt(_T("Trend"), _T("UseTrack1"), m_Measurements[0].bUseTrack1 );
								pApp->WriteProfileInt(_T("Trend"), _T("UseTrack2"), m_Measurements[0].bUseTrack2 );
								pApp->WriteProfileInt(_T("Trend"), _T("UseTrack3"), m_Measurements[0].bUseTrack3 );
								pApp->WriteProfileInt(_T("Trend"), _T("UseTrack4"), m_Measurements[0].bUseTrack4 );

								pApp->WriteProfileString(_T("Trend"), _T("Measurement1Name"), m_Measurements[0].szTrack1Name );
								pApp->WriteProfileString(_T("Trend"), _T("Measurement2Name"), m_Measurements[0].szTrack2Name );
								pApp->WriteProfileString(_T("Trend"), _T("Measurement3Name"), m_Measurements[0].szTrack3Name );
								pApp->WriteProfileString(_T("Trend"), _T("Measurement4Name"), m_Measurements[0].szTrack4Name );
					
								CString szTmp;

								szTmp.Format(_T("%f"), m_Measurements[0].fTrack1From);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement1Start"), szTmp);
								szTmp.Format(_T("%f"), m_Measurements[0].fTrack1To);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement1End"), szTmp);

								szTmp.Format(_T("%f"), m_Measurements[0].fTrack2From);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement2Start"), szTmp);
								szTmp.Format(_T("%f"), m_Measurements[0].fTrack2To);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement2End"), szTmp);

								szTmp.Format(_T("%f"), m_Measurements[0].fTrack3From);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement3Start"), szTmp);
								szTmp.Format(_T("%f"), m_Measurements[0].fTrack3To);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement3End"), szTmp);

								szTmp.Format(_T("%f"), m_Measurements[0].fTrack4From);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement4Start"), szTmp);
								szTmp.Format(_T("%f"), m_Measurements[0].fTrack4To);
								pApp->WriteProfileString(_T("Trend"), _T("Measurement4End"), szTmp);



								DrawTrendData(1);
							}
							else
							{
								TrendFile.Close();

								//This is a non-RealTime mode file so just get 
								
								if( pWnd->GetICS()->GetBasicTrendData(&m_vaTrendXData, &m_vaTrendYData, m_sCurrentFile) )
								{

									m_Graph.SetAxisYText("Not Measured");

									m_iMeasurementIdx = m_iNumberOfMeasurements = m_vaTrendXData.parray->rgsabound->cElements;
								
									double* pXTrendData = NULL;

									HRESULT hr = SafeArrayAccessData(m_vaTrendXData.parray, (void **)&pXTrendData);
									if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));
				
									//Store the Trend info
									for(int n=0;n<m_iNumberOfMeasurements;n++)
									{
										m_Measurements[n].fTrack1Time = (float)pXTrendData[n];
										m_Measurements[n].fTrack2Time = (float)pXTrendData[n];
										m_Measurements[n].fTrack3Time = (float)pXTrendData[n];
										m_Measurements[n].fTrack4Time = (float)pXTrendData[n];

										m_Measurements[n].bUseTrack1 = false;
										m_Measurements[n].bUseTrack2 = false;
										m_Measurements[n].bUseTrack3 = false;
										m_Measurements[n].bUseTrack4 = false;

										m_Measurements[n].fTrack1Result = 0.0;
										m_Measurements[n].fTrack2Result = 0.0;
										m_Measurements[n].fTrack3Result = 0.0;
										m_Measurements[n].fTrack4Result = 0.0;

										lstrcpy(m_Measurements[n].szTrack1Name, _T("Track 1"));
										lstrcpy(m_Measurements[n].szTrack2Name, _T("Track 2"));
										lstrcpy(m_Measurements[n].szTrack3Name, _T("Track 3"));
										lstrcpy(m_Measurements[n].szTrack4Name, _T("Track 4"));
										
									}

									hr = SafeArrayUnaccessData(m_vaTrendXData.parray);
									if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));
							
									m_Graph.SetDataEx(&m_vaTrendXData, &m_vaTrendYData, 1, FALSE);
								}
							}
						}
					}
				}	

				
		
			}
			catch(COleException* e)
			{
				TRACE("Ole Exception occured.\n");
				e->ReportError();
				e->Delete();
				
			}
		}
	}else TRACE(_T("Could not open the .FFT (streaming) file to get the settings.\n"));



	return false;
}




//Messages from the Graph
void CTrendView::OnGSXMouseDown(short Button, short Shift, long x, long y)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);


	lClickXDown = x;
	lClickYDown = y;
	
}
void CTrendView::OnGSXMouseUp(short Button, short Shift, long x, long y)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	lClickX = x;
	lClickY = y;

	pWnd->SetActivePane(0);

	if(Button == 2)//Right Click
	{
		CPoint mPt;

		mPt.x=x;
		mPt.y=y;//Screen coordinates from the mouse location

		//Convert the screen coordinates to client 
		m_Graph.ClientToScreen(&mPt);

		CMenu menu;

		VERIFY(menu.LoadMenu(IDR_RIGHT_TREND));
		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup);

		if( m_Graph.GetStartMarkerPos() != m_Graph.GetEndMarkerPos() && !m_bAcqInProgress )//allow sumation
		{
			pPopup->EnableMenuItem(ID_RIGHT_SUM, MF_CHECKED);
		}

		if( pWnd->GetCurrentTool() == Zoom )
			pPopup->CheckMenuRadioItem( ID_VIEWMODE_ZOOM, ID_VIEWMODE_MARKER, ID_VIEWMODE_ZOOM, MF_BYCOMMAND ); 
		else
			pPopup->CheckMenuRadioItem( ID_VIEWMODE_ZOOM, ID_VIEWMODE_MARKER, ID_VIEWMODE_MARKER, MF_BYCOMMAND ); 

		//Can't recalculate if were already running
		if( !m_bAcqInProgress )pPopup->EnableMenuItem(IDR_RECALC_ALL, MF_ENABLED);

		if( m_Measurements[0].bUseTrack1 )
		{
			pPopup->EnableMenuItem(IDM_VIEW_TRACK1, MF_ENABLED);
			pPopup->ModifyMenu(0,MF_BYPOSITION | MF_STRING, IDM_VIEW_TRACK1, m_Measurements[0].szTrack1Name);
		}
		if( m_Measurements[0].bUseTrack2 )
		{
			pPopup->EnableMenuItem(IDM_VIEW_TRACK2, MF_ENABLED);
			pPopup->ModifyMenu(1,MF_BYPOSITION | MF_STRING, IDM_VIEW_TRACK2, m_Measurements[0].szTrack2Name);

		}
		if( m_Measurements[0].bUseTrack3 )
		{
			pPopup->EnableMenuItem(IDM_VIEW_TRACK3, MF_ENABLED);
			pPopup->ModifyMenu(2,MF_BYPOSITION | MF_STRING, IDM_VIEW_TRACK3, m_Measurements[0].szTrack3Name);

		}
		if( m_Measurements[0].bUseTrack4 )
		{
			pPopup->EnableMenuItem(IDM_VIEW_TRACK4, MF_ENABLED);
			pPopup->ModifyMenu(3,MF_BYPOSITION | MF_STRING, IDM_VIEW_TRACK4, m_Measurements[0].szTrack4Name);
		}

		pPopup->CheckMenuRadioItem( IDM_VIEW_TRACK1, IDM_VIEW_TRACK4, IDM_VIEW_TRACK1 + m_iCurrentTrackView - 1, MF_BYCOMMAND );



		pPopup->TrackPopupMenu(TPM_LEFTALIGN, mPt.x, mPt.y, this );
		menu.DestroyMenu();

		m_Graph.Invalidate(FALSE);
	}

}
void CTrendView::OnGSXMouseMove(short Button, short Shift, long x, long y)
{
	static double OldX,OldY;
	CString ValueInfo;

	KillTimer(TRENDHOVER);
	
	m_lMousePointerX = x;
	m_lMousePointerY = y;

	CMainFrame* pWnd=(CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	double dataX, dataY;

	if( m_Graph.ScalePixelToData(x,y,&dataX,&dataY) )
	{
		if(dataX != OldX || dataY !=OldY)
		{
			if(m_pHoverWnd != NULL)
			{
				m_pHoverWnd->DestroyWindow();
				delete m_pHoverWnd;
				m_pHoverWnd = NULL;
			}

			SetTimer(TRENDHOVER,1000,NULL);

			if(dataX != 1e308 || dataY != 1e308)
			{
				//Show mouse pointer data in status bar
				ValueInfo.Format(_T("X = %g, Y = %g"),dataX,dataY);
			}
			else ValueInfo = _T("");

			//Update XY information in the status bar
			pWnd->SetStatusBarText(1,ValueInfo);
			OldX = dataX;
			OldY = dataY;
			
		}
	}
	else 
	{
		ValueInfo = _T("");
		pWnd->SetStatusBarText(1,ValueInfo);
	}
}
void CTrendView::OnGSXRepaint(long Hdc, long Left, long Top, long Width, long Height)
{

}
void CTrendView::OnGSXClick()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	if(m_Graph.GetStartMarkerPos() == m_Graph.GetEndMarkerPos())
	{
		long Index = m_Graph.GetStartMarkerIndex(1);
		TRACE2("Marker index = %d, Marker Pos = %f.\n", Index, m_Graph.GetStartMarkerPos());
		
		
		if(Index > -1)
		{
			pWnd->SetAverageFromIndex(Index);
			pWnd->SetActivePane(0);
		}
		else TRACE("GetStartMarkerIndex returned a -1\n");
	}

}

void CTrendView::OnRightGraphProperties()
{
	
	CGraphProperties Graph(this,&m_Graph,false);//false indicates no overlay properties button

	Graph.DoModal();


	//Add the X Axis units to the trend graph always!
	CString Text;

	Text = m_Graph.GetAxisXText();

	Text += " [s]";
	m_Graph.SetAxisXText( Text );

}
void CTrendView::OnRightSetMarkerTool()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	pWnd->OnViewmodeMarker();
}
void CTrendView::OnRightSetZoomTool()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	pWnd->OnViewmodeZoom();
}
void CTrendView::OnPrint(CDC* pDC, CPrintInfo* pInfo) 
{

	CRect rect;
    m_Graph.GetClientRect(rect);

	//BLOCK: Set up scale mode
	{
        int  nPageWidth,  nPageHeight;
        int  nChartWidth, nChartHeight;
        long a,           b;

		pDC->SetMapMode(MM_ANISOTROPIC);

        nPageWidth   = pDC->GetDeviceCaps(HORZRES);
        nPageHeight  = pDC->GetDeviceCaps(VERTRES);
        nChartWidth  = rect.right  - rect.left;
        nChartHeight = rect.bottom - rect.top;

        a  = nPageHeight;
        a *= nChartWidth;
        b  = nPageWidth;
        b *= nChartHeight;

        //    PH/PW < GH/GW
        // or PH*GW < PW*GH 
        if(a < b)
		{
            // Fill vertically, center horizontally.
		    pDC->SetWindowExt(nChartHeight, nChartHeight);
		    pDC->SetViewportExt(nPageHeight, nPageHeight);
            pDC->LPtoDP(rect);
            nChartWidth = rect.right - rect.left;
            pDC->SetViewportOrg((nPageWidth - nChartWidth) / 2, 0);
        }
        else 
		{
            // Fill horizontally, center vertically.
		    pDC->SetWindowExt(nChartWidth, nChartWidth);
		    pDC->SetViewportExt(nPageWidth, nPageWidth);
            pDC->LPtoDP(rect);
            nChartHeight = rect.bottom - rect.top;
            pDC->SetViewportOrg(0, (nPageHeight - nChartHeight) / 2);
        }
	}

    m_Graph.GetClientRect(rect);
    ::LPtoDP(pDC->GetSafeHdc(), (POINT*)(&rect), 2);
    m_Graph.DrawToDC((long) pDC->GetSafeHdc(),rect.left, rect.top, (rect.right-rect.left), (rect.bottom-rect.top));

	
}

BOOL CTrendView::OnPreparePrinting(CPrintInfo* pInfo) 
{
		// default preparation
	return DoPreparePrinting(pInfo);
}

void CTrendView::OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo) 
{
	CView::OnBeginPrinting(pDC, pInfo);
}

void CTrendView::OnEndPrinting(CDC* pDC, CPrintInfo* pInfo) 
{
	CView::OnEndPrinting(pDC, pInfo);
}

void CTrendView::OnCopygraph() 
{
	m_Graph.CopyToClipboard();
	
}

//if bStore == true, transfer current graph settings to the registry, otherwise load them...
void CTrendView::GraphSettings(bool bStore)
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	ASSERT(m_Graph);

	if(bStore)//Write graph settings to registry
	{
		pApp->WriteProfileString(_T("Trend"), _T("Title Text"), m_Graph.GetTitleText() );
		pApp->WriteProfileInt(_T("Trend"), _T("Title Color"), m_Graph.GetTitleTextColor() );
		pApp->WriteProfileInt(_T("Trend"), _T("Grid"), m_Graph.GetGridState() );
		pApp->WriteProfileInt(_T("Trend"), _T("Grid Color"), m_Graph.GetGridColor() );
		pApp->WriteProfileInt(_T("Trend"), _T("Axis Color"), m_Graph.GetAxisColor() );
		pApp->WriteProfileInt(_T("Trend"), _T("Log Y Axis"), m_Graph.GetAxisYLog() );
		pApp->WriteProfileString(_T("Trend"), _T("X Axis Text"), m_Graph.GetAxisXText() );
		pApp->WriteProfileString(_T("Trend"), _T("Y Axis Text"), m_Graph.GetAxisYText() );
		pApp->WriteProfileInt(_T("Trend"), _T("Bkg Color"), m_Graph.GetPlotAreaColor() );

		CString Tmp; //Store the settings that are indexed by series
		for(int n=1;n<6;n++)
		{
			Tmp.Format("Symbol %d", n);
			pApp->WriteProfileInt(_T("Trend"), Tmp, m_Graph.GetDataSymbol(n) );
			Tmp.Format("Symbol Color %d", n);
			pApp->WriteProfileInt(_T("Trend"), Tmp, m_Graph.GetDataSymbolColor(n) );
			Tmp.Format("Symbol Size %d", n);
			pApp->WriteProfileInt(_T("Trend"), Tmp, m_Graph.GetDataSymbolSize(n) );
			Tmp.Format("Line %d", n);
			pApp->WriteProfileInt(_T("Trend"), Tmp, m_Graph.GetDataLine(n) );
			Tmp.Format("Line Color %d", n);
			pApp->WriteProfileInt(_T("Trend"), Tmp, m_Graph.GetDataLineColor(n) );
			Tmp.Format("Line Width %d", n);
			pApp->WriteProfileInt(_T("Trend"), Tmp, m_Graph.GetDataLineWidth(n) );	
		}

	

	}
	else
	{
		m_Graph.SetTitleText( pApp->GetProfileString(_T("Trend"), _T("Title Text")) );
		m_Graph.SetTitleTextColor( pApp->GetProfileInt(_T("Trend"), _T("Title Color"), 0) );
		m_Graph.SetGridState( pApp->GetProfileInt(_T("Trend"), _T("Grid"), 1) );
		m_Graph.SetGridColor( pApp->GetProfileInt(_T("Trend"), _T("Grid Color"), 0) );
		m_Graph.SetAxisColor( pApp->GetProfileInt(_T("Trend"), _T("Axis Color"), 0) );
		m_Graph.SetAxisYLog( pApp->GetProfileInt(_T("Trend"), _T("Log Y Axis"), 0) );
		m_Graph.SetAxisXText( pApp->GetProfileString(_T("Trend"), _T("X Axis Text")) );
		m_Graph.SetAxisYText( pApp->GetProfileString(_T("Trend"), _T("Y Axis Text")) );
		m_Graph.SetPlotAreaColor( pApp->GetProfileInt(_T("Trend"), _T("Bkg Color"), 0));
		m_Graph.SetChartAreaColor( pApp->GetProfileInt(_T("Trend"), _T("Bkg Color"), 0));


		CString Tmp;
		for(int n=1;n<6;n++)
		{
			Tmp.Format("Symbol %d", n);
			m_Graph.SetDataSymbol(n, pApp->GetProfileInt(_T("Trend"), Tmp, 0) );
			Tmp.Format("Symbol Color %d", n);
			m_Graph.SetDataSymbolColor(n, pApp->GetProfileInt(_T("Trend"), Tmp, 0) );
			Tmp.Format("Symbol Size %d", n);
			m_Graph.SetDataSymbolSize(n, pApp->GetProfileInt(_T("Trend"), Tmp, 2) );
			Tmp.Format("Line %d", n);
			m_Graph.SetDataLine(n, pApp->GetProfileInt(_T("Trend"), Tmp, 1) );
			Tmp.Format("Line Color %d", n);
			m_Graph.SetDataLineColor(n, pApp->GetProfileInt(_T("Trend"), Tmp, 0) );
			Tmp.Format("Line Width %d", n);
			m_Graph.SetDataLineWidth(n, pApp->GetProfileInt(_T("Trend"), Tmp, 1) );
		}
	}
}

void CTrendView::OnDestroy() 
{
	GraphSettings(true);//Save the current settings before leaving

	CView::OnDestroy();
	

	
}

BOOL CTrendView::OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message) 
{
	return CView::OnSetCursor(pWnd, nHitTest, message);
}



void CTrendView::OnLButtonUp(UINT nFlags, CPoint point) 
{
	
	CView::OnLButtonUp(nFlags, point);
}

void CTrendView::OnInitialUpdate() 
{
	CView::OnInitialUpdate();
}

void CTrendView::OnPaint() 
{
	CPaintDC dc(this); // device context for painting

	
	// Do not call CView::OnPaint() for painting messages
}

void CTrendView::CalcWindowRect(LPRECT lpClientRect, UINT nAdjustType) 
{
	
	CView::CalcWindowRect(lpClientRect, nAdjustType);
}



void CTrendView::OnRightSetTrack1()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_iCurrentTrackView != 1)
	{
		m_iCurrentTrackView = 1;
		DrawTrendData(1);
	}
}
void CTrendView::OnRightSetTrack2()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_iCurrentTrackView != 2)
	{
		m_iCurrentTrackView = 2;
		DrawTrendData(2);
	}	
}
void CTrendView::OnRightSetTrack3()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_iCurrentTrackView != 3)
	{
		m_iCurrentTrackView = 3;
		DrawTrendData(3);
	}	
}
void CTrendView::OnRightSetTrack4()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if(m_iCurrentTrackView != 4)
	{
		m_iCurrentTrackView = 4;
		DrawTrendData(4);
	}	
}
void CTrendView::OnRightReCalcTrend()
{
	ReCalculateTrend();
}
void CTrendView::OnRightSum()
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	HRESULT hr;

	long lStartIdx = m_Graph.GetStartMarkerIndex(1);
	long lEndIdx = m_Graph.GetEndMarkerIndex(1);
	ASSERT(lStartIdx != lEndIdx);

	long lTmp;
	if(lStartIdx > lEndIdx)
	{
		lTmp = lEndIdx;
		lEndIdx = lStartIdx;
		lStartIdx = lTmp;
	}
	TRACE2(_T("Summing Averages from index #%d to #%d\n"), lStartIdx, lEndIdx);

	if(pApp->GetCalState())
	{
		//If calibration is on turn if off for the summing process
		pWnd->GetAverageView()->OnRightCalibrationEnable();
	}

	//What we are going to do here is is create safearrays (using VARAINT*s from the AverageView) these
	//will be contain the "Uncompressed" number of points.  Get the max time used by the data to be 
	//summed.  Then divide up the X data in time 0 to max time retrieved from the data to be summed.
	//We now need to load in the first data set from the selected region, then loop through all points
	//in the "Uncompressed" array performing the averaging formula on each match (or close) point.

	VARIANT vaTmpX;
	VARIANT vaTmpY;

	if( (_access( m_sCurrentFile, 0 )) != -1 )
	{
		VariantClear(pWnd->GetAverageView()->GetAverageXData());
		VariantClear(pWnd->GetAverageView()->GetAverageYData());

		VariantInit(pWnd->GetAverageView()->GetAverageXData());
		VariantInit(pWnd->GetAverageView()->GetAverageYData());
		VariantInit(&vaTmpX);
		VariantInit(&vaTmpY);

		try
		{

			int iProtocol = pWnd->GetICS()->GetProtocolFromTrendIndex(m_sCurrentFile, lStartIdx);
			float fSampInt = pWnd->GetAverageView()->GetSettings()->ProtSettings[ iProtocol ].m_fSamplingInterval;
			float fRecLen = pWnd->GetAverageView()->GetSettings()->ProtSettings[ iProtocol ].m_fRecordLength;

			long lNumUnCompressPts = (long)(fRecLen / fSampInt) * 1000;

			// Create SAFEARRAY that will contain the data
			SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array 
			SAFEARRAY FAR* psaYValues = NULL;
			SAFEARRAY FAR* psaXValues = NULL;
		
			// Set the bounds of the SafeArray
			// (Note: must be 1-based)
			//Set cElements to the number of points that aren't -1
			sabOneDim[0].cElements = lNumUnCompressPts;
			sabOneDim[0].lLbound = 1;
				
			// Create the actual SafeArray descriptors
			psaYValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaYValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

			V_VT(pWnd->GetAverageView()->GetAverageYData()) = VT_ARRAY | VT_R8;

			// Place the safearray pointer in the VARIANT
			V_ARRAY(pWnd->GetAverageView()->GetAverageYData()) = psaYValues;

			// Create the actual SafeArray descriptors
			psaXValues = SafeArrayCreate(VT_R8, 1, sabOneDim);
			if (psaXValues == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

			V_VT(pWnd->GetAverageView()->GetAverageXData()) = VT_ARRAY | VT_R8;

			// Place the safearray pointer in the VARIANT
			V_ARRAY(pWnd->GetAverageView()->GetAverageXData()) = psaXValues;

			BeginWaitCursor();

			pWnd->GetStatusBar()->SetPaneText(0, _T("Summing data, please wait..."));

			//Ready to load in the 1st spectrum
			long lNumSumArrayPoints = 0;
			long lCount = 1;
			for(long n=lStartIdx;n < lEndIdx;n++)//loop the number selected indexes
			{
				double *pdUncompYArray;
				double *pdUncompXArray;
			
				//Set a pointer to access the safearray data directly
				hr = SafeArrayAccessData(psaYValues, (void **)&pdUncompYArray);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				hr = SafeArrayAccessData(psaXValues, (void **)&pdUncompXArray);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				//Initialize the Uncomp array
				for(long l=0;l<lNumUnCompressPts;l++)
				{
					pdUncompXArray[l] = (double)((double)l * fSampInt);
				}

				pWnd->GetICS()->SetupTrendFileInfo(m_sCurrentFile);

				//Get the first average spectrum
				if( pWnd->GetICS()->GetTrendRecord(&vaTmpX, &vaTmpY, n, fSampInt, fRecLen, iProtocol, 
					pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_iRecordsPerSpectrum,
					pWnd->GetAverageView()->GetSettings()->ProtSettings[ pWnd->GetAverageView()->GetSettings()->m_iProtocol ].m_bEnhancer,
					FALSE, TRUE) )
				{
					double *pdTmpYArray;
					double *pdTmpXArray;
				
					//Set a pointer to access the safearray data directly
					hr = SafeArrayAccessData(vaTmpY.parray, (void **)&pdTmpYArray);
					if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

					hr = SafeArrayAccessData(vaTmpX.parray, (void **)&pdTmpXArray);
					if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

					//Get the number of points in the array
					lNumSumArrayPoints = vaTmpX.parray->rgsabound->cElements;

					long lSumIdx = 0;
					if(lNumSumArrayPoints > 0)//Do we really have anything to sum?
					{
						for(long i=0;i < lNumUnCompressPts;i++)//Loop thru all uncompress posibilities
						{
							if(pdUncompXArray[i] == pdTmpXArray[lSumIdx])
							{
								if(n==lStartIdx)pdUncompYArray[i] = pdTmpYArray[lSumIdx];
								else
								{
									//Add this TmpYArray value to the UncompYValue
									pdUncompYArray[i] += ((pdTmpYArray[lSumIdx] - pdUncompYArray[i]) / lCount);
								}
								lSumIdx++;
								
							}
							else 
							{
								if(n==lStartIdx)pdUncompYArray[i] = pdTmpYArray[lSumIdx - 1];
								else
								{
									//Add this TmpyArray value to the UncompYValue
									pdUncompYArray[i] += ((pdTmpYArray[lSumIdx - 1] - pdUncompYArray[i]) / lCount);
							
								}
							}
						}

						lCount++;
					}

					//Turn on the "Data Processed" LED on Acquisition Tab
					pWnd->GetAcqTab()->GetLED1()->MomentaryOn();

					hr = SafeArrayUnaccessData(vaTmpY.parray);
					if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

					hr = SafeArrayUnaccessData(vaTmpX.parray);
					if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

					VariantClear(&vaTmpX);
					VariantClear(&vaTmpY);

					VariantInit(&vaTmpX);
					VariantInit(&vaTmpY);

					hr = SafeArrayUnaccessData(pWnd->GetAverageView()->GetAverageXData()->parray);
					if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

					hr = SafeArrayUnaccessData(pWnd->GetAverageView()->GetAverageYData()->parray);
					if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

					//Update the screen to show the data transformation
					pWnd->GetAverageView()->GetGraph()->SetDataEx( pWnd->GetAverageView()->GetAverageXData(), pWnd->GetAverageView()->GetAverageYData(), 1, FALSE);
				}
			}
		}
		catch(COleException* e)
		{
			TRACE("Ole Exception occured.\n");
			e->Delete();
			
		}		
		EndWaitCursor();

		pWnd->GetStatusBar()->SetPaneText(0, _T("Ready..."));
	}
}

