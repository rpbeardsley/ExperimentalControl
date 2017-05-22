//***************************************************************************************
//AnalysisTab.cpp : implementation file
//
//	Functions: For details on functions in this file see AnalysisTab.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "AnalysisTab.h"
#include "MainFrm.h"
#include "AverageView.h"

#include <winbase.h>



#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAnalysisTab dialog


CAnalysisTab::CAnalysisTab(CWnd* pParent /*=NULL*/)
	: CDialog(CAnalysisTab::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAnalysisTab)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	m_bInitialized = false;
	for(int n=0;n<20;n++)m_hMeasurement[n] = NULL;
}


void CAnalysisTab::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAnalysisTab)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAnalysisTab, CDialog)
	//{{AFX_MSG_MAP(CAnalysisTab)
	ON_WM_DESTROY()
	ON_CBN_SELCHANGE(IDC_MEASURE_1, OnSelchangeMeasure1)
	ON_CBN_SELCHANGE(IDC_MEASURE_2, OnSelchangeMeasure2)
	ON_CBN_SELCHANGE(IDC_MEASURE_3, OnSelchangeMeasure3)
	ON_CBN_SELCHANGE(IDC_MEASURE_4, OnSelchangeMeasure4)
	ON_WM_SHOWWINDOW()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAnalysisTab message handlers


BOOL CAnalysisTab::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	//Get pointers to our combo boxes
	CComboBox* pCB1 = (CComboBox*)GetDlgItem(IDC_MEASURE_1);
	CComboBox* pCB2 = (CComboBox*)GetDlgItem(IDC_MEASURE_2);
	CComboBox* pCB3 = (CComboBox*)GetDlgItem(IDC_MEASURE_3);
	CComboBox* pCB4 = (CComboBox*)GetDlgItem(IDC_MEASURE_4);

	PFNGETNAME pfnGetName;

	m_bInitialized = true;//Only save the info if the dialog has been seen

	int iCount = 0;

	CFileFind finder;  
	CString sDllPath;
	CString sAppPath;

	sAppPath = pApp->m_pszHelpFilePath;

	int iLen = sAppPath.GetLength();

	sAppPath = sAppPath.Left(iLen - 11);
	sAppPath += _T("\\Measurements\\Eclipse*.*");

	pCB1->AddString( "None" );
	pCB2->AddString( "None" );
	pCB3->AddString( "None" );
	pCB4->AddString( "None" );

	BOOL bWorking = finder.FindFile(sAppPath);

    while (bWorking)//Locate all "Eclipse measurement dlls"
    {      
		bWorking = finder.FindNextFile();

		sDllPath = finder.GetFilePath();

		TRACE1("Found %s\n", sDllPath);

        m_hMeasurement[iCount] = AfxLoadLibrary(sDllPath);
	
		if(m_hMeasurement[iCount] != NULL)
		{
			TRACE(_T("Measurement is Available\n"));

			char Name[255];
			int iNumChars;

			pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[iCount], "_GetName@4" );

			if(pfnGetName)iNumChars = pfnGetName( Name );

			int iPos = pCB1->AddString( Name );
			pCB1->SetItemData(iPos, (ULONG)m_hMeasurement[iCount]);//Remember the dll

			iPos = pCB2->AddString( Name );
			pCB2->SetItemData(iPos, (ULONG)m_hMeasurement[iCount]);

			iPos = pCB3->AddString( Name );
			pCB3->SetItemData(iPos, (ULONG)m_hMeasurement[iCount]);

			iPos = pCB4->AddString( Name );
			pCB4->SetItemData(iPos, (ULONG)m_hMeasurement[iCount]);

			iCount++; //Increment, but don't go over 20 (for now)!
		}
	}

	finder.Close();

	//Set to last stored positions
	pCB1->SelectString( -1, pApp->GetAnalysisMeasurement1Name() );
	pCB2->SelectString( -1, pApp->GetAnalysisMeasurement2Name() );
	pCB3->SelectString( -1, pApp->GetAnalysisMeasurement3Name() );
	pCB4->SelectString( -1, pApp->GetAnalysisMeasurement4Name() );


	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
void CAnalysisTab::OnMeasurements()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CAverageView* pView = pWnd->GetAverageView();
	ASSERT( pView );

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	HMODULE HModule;

	//Loop thru the active measurements, calling there Calculates and placing result in static
	char szResult[255];
	int iNumChars, iNumPoints;
	long iMkrXMinPos, iMkrXMaxPos;
	HRESULT hr;
	bool bMarker = false;

	double* pXData = NULL;
	double* pYData = NULL;
	char sUnits[256];

	//Get pointers to our combo boxes
	CComboBox* pCB1 = (CComboBox*)GetDlgItem(IDC_MEASURE_1);
	CComboBox* pCB2 = (CComboBox*)GetDlgItem(IDC_MEASURE_2);
	CComboBox* pCB3 = (CComboBox*)GetDlgItem(IDC_MEASURE_3);
	CComboBox* pCB4 = (CComboBox*)GetDlgItem(IDC_MEASURE_4);

	if( pApp->GetCalState() )
	{
		//Set a pointer to access the Calibrated X safearray data directly
		hr = SafeArrayAccessData(pView->GetCalXData()->parray, (void **)&pXData);
		if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

		lstrcpy(sUnits, pView->GetSettings()->ProtSettings[ pView->GetSettings()->m_iProtocol ].m_sUnits );
	}
	else
	{
		//Set a pointer to access the X safearray data directly
		hr = SafeArrayAccessData(pView->GetAverageXData()->parray, (void **)&pXData);
		if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

		lstrcpy(sUnits, "s");
	}

	//Set a pointer to access the Y safearray data directly
	hr = SafeArrayAccessData(pView->GetAverageYData()->parray, (void **)&pYData);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	int iPos;
	PFNCALCULATE pfnCalculate;

	if( pView->GetAverageXData()->vt == (VT_ARRAY | VT_R8) && pView->GetAverageYData()->vt == (VT_ARRAY | VT_R8) )
	{
		iNumPoints = pView->GetAverageXData()->parray->rgsabound->cElements;

		iMkrXMinPos = min( pView->GetGraph()->GetStartMarkerIndex( 1 ), pView->GetGraph()->GetEndMarkerIndex( 1 ));
		iMkrXMaxPos = max( pView->GetGraph()->GetStartMarkerIndex( 1 ), pView->GetGraph()->GetEndMarkerIndex( 1 ));


		//If the marker is not selecting a region, perform calc using visible screen area
		if( iMkrXMinPos == iMkrXMaxPos || iMkrXMinPos >= iNumPoints || iMkrXMaxPos >= iNumPoints)
		{
			double dMin = pView->GetGraph()->GetAxisXMin();
			double dMax = pView->GetGraph()->GetAxisXMax();

			if(dMin < 0) dMin = 0; //set some limits

			for(int n=0;n<iNumPoints;n++)
			{
				if(dMin >= pXData[n] && dMin < pXData[n+1])iMkrXMinPos = n;
				if(dMax >= pXData[n] && dMax < pXData[n+1])
				{
					iMkrXMaxPos = n;
					break; //We're done!
				}
				else 
					if( dMax == pXData[n] )
					{
						iMkrXMaxPos = n;
						break;
					}
			}
		}
		else bMarker = true;

		if( iNumPoints > 0 )
		{
			//Calculate measurement #1
		iPos = pCB1->GetCurSel();
			if( iPos != 0 )
			{
				//Get pointer to correct dll, then call calculate function
				HModule = (HMODULE)pCB1->GetItemData(iPos);

				if(bMarker)strcpy(szResult, "Marker");//Indicate to the dll that the marker was used to set region
				else strcpy(szResult, "");

				if(HModule != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( HModule, "_Calculate@28" );
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iMkrXMinPos, iMkrXMaxPos, szResult, sUnits);
				}
			}
			else lstrcpy(szResult, "");
			SetDlgItemText(IDC_MEASURE_RESULT_1, szResult);

			//Calculate measurement #2
			iPos = pCB2->GetCurSel();
			if( iPos != 0 )
			{
				//Get pointer to correct dll, then call calculate function
				HModule = (HMODULE)pCB2->GetItemData(iPos);

				if(bMarker)strcpy(szResult, "Marker");//Indicate to the dll that the marker was used to set region
				else strcpy(szResult, "");

				if(HModule != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( HModule, "_Calculate@28" );
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iMkrXMinPos, iMkrXMaxPos, szResult, sUnits);
				}
			}
			else lstrcpy(szResult, "");
			SetDlgItemText(IDC_MEASURE_RESULT_2, szResult);

			//Calculate measurement #3
			iPos = pCB3->GetCurSel();
			if( iPos != 0 )
			{
				//Get pointer to correct dll, then call calculate function
				HModule = (HMODULE)pCB3->GetItemData(iPos);

			//	if(bMarker)strcpy(szResult, "Marker");//Indicate to the dll that the marker was used to set region
			//	else strcpy(szResult, "");

				if(HModule != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( HModule, "_Calculate@28" );
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iMkrXMinPos, iMkrXMaxPos, szResult, sUnits);
				}
			}
			else lstrcpy(szResult, "");
			SetDlgItemText(IDC_MEASURE_RESULT_3, szResult);

			//Calculate measurement #4
			iPos = pCB4->GetCurSel();
			if( iPos != 0 )
			{
				//Get pointer to correct dll, then call calculate function
				HModule = (HMODULE)pCB4->GetItemData(iPos);

				if(bMarker)strcpy(szResult, "Marker");//Indicate to the dll that the marker was used to set region
				else strcpy(szResult, "");

				if(HModule != NULL)
				{
					pfnCalculate = (PFNCALCULATE)::GetProcAddress( HModule, "_Calculate@28" );
					if(pfnCalculate)iNumChars = pfnCalculate( iNumPoints, pXData, pYData, iMkrXMinPos, iMkrXMaxPos, szResult, sUnits);
				}
			}
			else lstrcpy(szResult, "");
			SetDlgItemText(IDC_MEASURE_RESULT_4, szResult);


		}
		else
		{
			SetDlgItemText(IDC_MEASURE_RESULT_1, "");
			SetDlgItemText(IDC_MEASURE_RESULT_2, "");
			SetDlgItemText(IDC_MEASURE_RESULT_3, "");
			SetDlgItemText(IDC_MEASURE_RESULT_4, "");
		}
	}//Valid safearrays


	//Unattach our direct pointers to the data
	if( pApp->GetCalState() )
	{
		hr = SafeArrayUnaccessData(pView->GetCalXData()->parray);
		if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));
	}
	else
	{
		hr = SafeArrayUnaccessData(pView->GetAverageXData()->parray);
		if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData of Average X failed.\n"));
	}

	hr = SafeArrayUnaccessData(pView->GetAverageYData()->parray);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData of Average Y failed.\n"));
}

void CAnalysisTab::OnDestroy() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);
	CString strName;

	if(m_bInitialized)
	{
		//Get pointers to our combo boxes
		CComboBox* pCB1 = (CComboBox*)GetDlgItem(IDC_MEASURE_1);
		CComboBox* pCB2 = (CComboBox*)GetDlgItem(IDC_MEASURE_2);
		CComboBox* pCB3 = (CComboBox*)GetDlgItem(IDC_MEASURE_3);
		CComboBox* pCB4 = (CComboBox*)GetDlgItem(IDC_MEASURE_4);

		//Store positions
		pCB1->GetLBText( pCB1->GetCurSel(), strName);
		if(!strName.IsEmpty())pApp->SetAnalysisMeasurement1Name( strName );

		pCB2->GetLBText( pCB2->GetCurSel(), strName);
		if(!strName.IsEmpty())pApp->SetAnalysisMeasurement2Name( strName );

		pCB3->GetLBText( pCB3->GetCurSel(), strName);
		if(!strName.IsEmpty())pApp->SetAnalysisMeasurement3Name( strName );

		pCB4->GetLBText( pCB4->GetCurSel(), strName);
		if(!strName.IsEmpty())pApp->SetAnalysisMeasurement4Name( strName );
	}

	//Make sure there are not any measurements left hanging around
	for(int n=0;n<20;n++)
		if(m_hMeasurement[n] != NULL)AfxFreeLibrary(m_hMeasurement[n]);

	CDialog::OnDestroy();

}

CString CAnalysisTab::GetMeasurementVersions(int iIdx)
{
	//Returns Empty string if iIdx is not a valid measurement dll

	//This is called from the about box to show list of installed measurements

	CString sRet("");
	char szVersion[255];
	char szName[255];
	PFNGETVER pfnGetVer;
	PFNGETNAME pfnGetName;
	int iNumChars;

	if(m_hMeasurement[iIdx] != NULL)
	{
		pfnGetName = (PFNGETNAME)::GetProcAddress( m_hMeasurement[iIdx], "_GetName@4" );
		if(pfnGetName)iNumChars = pfnGetName( szName );

		pfnGetVer = (PFNGETVER)::GetProcAddress( m_hMeasurement[iIdx], "_GetVer@4" );
		if(pfnGetVer)iNumChars = pfnGetVer( szVersion );

		sRet.Format(_T("%s, %s"), szName, szVersion );
	}


	return sRet;
}

void CAnalysisTab::OnSelchangeMeasure1() 
{
	OnMeasurements();
	
}

void CAnalysisTab::OnSelchangeMeasure2() 
{
	OnMeasurements();
	
}

void CAnalysisTab::OnSelchangeMeasure3() 
{
	OnMeasurements();
	
}

void CAnalysisTab::OnSelchangeMeasure4() 
{
	OnMeasurements();
	
}

void CAnalysisTab::OnShowWindow(BOOL bShow, UINT nStatus) 
{
	CDialog::OnShowWindow(bShow, nStatus);
	
	if(bShow)OnMeasurements();//When the tab is shown update the measurements
	
}
void CAnalysisTab::OnCancel()
{
	//Don't do anything
	return;
}
void CAnalysisTab::OnOK()
{
	//Don't do anything
	return;
}