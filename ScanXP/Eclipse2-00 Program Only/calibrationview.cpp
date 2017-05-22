// CalibrationView.cpp : implementation file
//***************************************************************************************
//CalibrationView.cpp : implementation file
//
//	Functions: For details on functions in this file see CalibrationView.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************

#include "stdafx.h"
#include "Eclipse.h"
#include "Mainfrm.h"
#include "AverageView.h"
#include "CalibrationView.h"
#include "CalibrationTab.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCalibrationView dialog


CCalibrationView::CCalibrationView(CWnd* pParent, CListCtrl* pCalList, CCalibration *pCal)
	: CDialog(CCalibrationView::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCalibrationView)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT

	ASSERT(pCalList);
	ASSERT(pCal);
	m_pCal = pCal;
	m_pCalList = pCalList;
}


void CCalibrationView::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCalibrationView)
	DDX_Control(pDX, IDC_CAL_LIST, m_CalList);
	DDX_Control(pDX, IDC_GSX_CTRL, m_CalGraph);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCalibrationView, CDialog)
	//{{AFX_MSG_MAP(CCalibrationView)
	ON_NOTIFY(NM_CLICK, IDC_CAL_LIST, OnClickCalList)
	ON_NOTIFY(LVN_ITEMCHANGED, IDC_CAL_LIST, OnItemchangedCalList)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

BEGIN_EVENTSINK_MAP(CCalibrationView, CDialog)
    //{{AFX_EVENTSINK_MAP(CCalibrationView)
	ON_EVENT(CCalibrationView, IDC_GSX_CTRL, 5 /* GSXClick */, OnGSXClickGsxCtrl, VTS_NONE)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCalibrationView message handlers

BOOL CCalibrationView::OnInitDialog() 
{
	CDialog::OnInitDialog();

//--------------------------------------- Initilize the graph control
	m_CalGraph.SetBatchMode(TRUE);	//Dont update the control!
	m_CalGraph.SetScrollBar(FALSE);			
	m_CalGraph.SetInternalMarker(TRUE);	
	m_CalGraph.SetInternalZoom(FALSE);		
	m_CalGraph.SetShowActiveGraph(FALSE);
	m_CalGraph.SetActiveGraph(FALSE);		
	m_CalGraph.SetNumberOfSeries(1);
	m_CalGraph.SetActiveTool(0);
	m_CalGraph.SetTitleText("");
	m_CalGraph.SetAxisXText("");
	m_CalGraph.SetAxisYText("");
	m_CalGraph.SetBatchMode(FALSE);
//-------------------------------------------------------------------

//-------------------------------------- Draw the data 
	VARIANT vaXData;
	VARIANT vaYData;

	m_CalGraph.SetNumberOfSeries(2);

	//Setup series #1 (points)
	VariantInit(&vaXData);
	VariantInit(&vaYData);

	m_CalGraph.SetDataLine(1,1); 
	m_CalGraph.SetDataSymbol(1, 1);
	m_CalGraph.SetDataSymbolSize(1, 7);
	m_CalGraph.SetDataSymbolColor(1, 2);
	GetValueData(&vaXData, &vaYData);
	m_CalGraph.SetDataEx(&vaXData, &vaYData, 1, FALSE);

	VariantClear(&vaXData);
	VariantClear(&vaYData);

	//Setup series #2 (curve)
	VariantInit(&vaXData);
	VariantInit(&vaYData);

	m_CalGraph.SetDataLine(2,2);
	m_CalGraph.SetDataSymbol(2, 0);
	m_CalGraph.SetDataLineColor(2,9);

	GetCurveData(&vaXData, &vaYData);
	m_pCal->Apply(&vaYData);
	m_CalGraph.SetDataEx(&vaXData, &vaYData, 2, FALSE);

	VariantClear(&vaXData);
	VariantClear(&vaYData);
//----------------------------------------------------------

//-------------------------------------- Initialize the list control with data from the 
	m_CalList.InsertColumn(0,_T("Cal Value"),LVCFMT_LEFT, 70 );
	m_CalList.InsertColumn(1,_T("Centroid[ns]"),LVCFMT_LEFT, 80 );
	m_CalList.InsertColumn(2,_T("Start Marker[ns]"),LVCFMT_LEFT, 90 );
	m_CalList.InsertColumn(3,_T("End Marker[ns]"),LVCFMT_LEFT, 90 );

	int iNumItems = m_pCalList->GetItemCount();
	int iItem;
	CString Text;

	if(iNumItems > 0)//If we have items to display
	{
		for(int n=0;n < iNumItems;n++)
		{
			//Get the text from the CalTab list box for this
			Text = m_pCalList->GetItemText(n, 0);

			//Insert the item/text in the appropiate position
		    iItem = m_CalList.InsertItem(n, Text);
				    
			//Insert the columns of info for this item

			//Centroid
			Text.Format("%.3f",((CMkrInfo*)m_pCalList->GetItemData(n))->m_dCentroidTime);
			m_CalList.SetItemText(iItem, 1, Text);

			//Start Marker
			Text.Format("%5g",((CMkrInfo*)m_pCalList->GetItemData(n))->m_dStartMkrTime);
			m_CalList.SetItemText(iItem, 2, Text);

			//End Marker
			Text.Format("%5g",((CMkrInfo*)m_pCalList->GetItemData(n))->m_dEndMkrTime);
			m_CalList.SetItemText(iItem, 3, Text);
		}
	}
//-------------------------------------------------------------------------------------


	//Show the Chi-Sqr results
	Text.Format("Reduced Chi-Square = %f", m_pCal->GetChiSquare() );
	SetDlgItemText( IDC_CAL_MESSAGE, Text);


	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
void CCalibrationView::GetValueData(VARIANT* pXData, VARIANT* pYData)
{
	HRESULT hr;

	int iNumItems = m_pCalList->GetItemCount();

	// Create SAFEARRAY that will contain the data
	SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array 
	SAFEARRAY FAR* psaX = NULL;
	SAFEARRAY FAR* psaY = NULL;
	
	// Set the bounds of the SafeArray
	// (Note: must be 1-based)
	sabOneDim[0].cElements = iNumItems;
	sabOneDim[0].lLbound = 1;
			
	psaX = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if(psaX == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

	psaY = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if(psaY == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

	V_VT(pXData) = VT_ARRAY | VT_R8;
	V_VT(pYData) = VT_ARRAY | VT_R8;

	// Place the safearray pointer in the VARIANT
	V_ARRAY(pXData) = psaX;
	V_ARRAY(pYData) = psaY;

	double *pTmpXArray;
	double *pTmpYArray;
	
	//Set a pointer to access the safearray data directly
	hr = SafeArrayAccessData(psaX, (void **)&pTmpXArray);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	hr = SafeArrayAccessData(psaY, (void **)&pTmpYArray);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	for(int n=0;n < iNumItems;n++)
	{
		pTmpXArray[n] = ((CMkrInfo*)m_pCalList->GetItemData(n))->m_dCentroidTime;
		pTmpYArray[n] = ((CMkrInfo*)m_pCalList->GetItemData(n))->m_dCalValue;
	}

	hr = SafeArrayUnaccessData(psaX);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

	hr = SafeArrayUnaccessData(psaY);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

}
void CCalibrationView::GetCurveData(VARIANT* pXData, VARIANT* pYData)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	HRESULT hr;

	long lNumDataPoints = 1000;

	// Create SAFEARRAY that will contain the data
	SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array 
	SAFEARRAY FAR* psaX = NULL;
	SAFEARRAY FAR* psaY = NULL;
	
	// Set the bounds of the SafeArray
	// (Note: must be 1-based)
	sabOneDim[0].cElements = lNumDataPoints;
	sabOneDim[0].lLbound = 1;
			
	psaX = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if(psaX == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

	psaY = SafeArrayCreate(VT_R8, 1, sabOneDim);
	if(psaY == NULL)AfxThrowOleDispatchException(1004, "Out of Memory");

	V_VT(pXData) = VT_ARRAY | VT_R8;
	V_VT(pYData) = VT_ARRAY | VT_R8;

	// Place the safearray pointer in the VARIANT
	V_ARRAY(pXData) = psaX;
	V_ARRAY(pYData) = psaY;

	double *pTmpXArray;
	double *pTmpYArray;
	
	//Set a pointer to access the safearray data directly
	hr = SafeArrayAccessData(psaX, (void **)&pTmpXArray);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	hr = SafeArrayAccessData(psaY, (void **)&pTmpYArray);
	if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

	long lSteps = (long)(m_pCal->m_dOrgMaxValue - m_pCal->m_dOrgMinValue) / 1000;
	long lCnt = 0;
	for(long n = 0;n < 1000;n++)
	{
		pTmpXArray[n] = lCnt;
		pTmpYArray[n] = lCnt;

		lCnt+=lSteps;
	}

	hr = SafeArrayUnaccessData(psaX);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

	hr = SafeArrayUnaccessData(psaY);
	if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

}
void CCalibrationView::OnClickCalList(NMHDR* pNMHDR, LRESULT* pResult) 
{
	if(m_CalList.GetSelectedCount() == 1)
	{
		//Find the selected item
		int iSelectedItem = m_CalList.GetNextItem( -1, LVNI_SELECTED ); 

		double dCalValue = atof( m_CalList.GetItemText(iSelectedItem,1) );
		//Set marker to selected value
		m_CalGraph.SetStartMarkerPos( dCalValue );
		m_CalGraph.SetEndMarkerPos( dCalValue );

		m_CalGraph.Invalidate();
	}	
	
	*pResult = 0;
}



void CCalibrationView::OnGSXClickGsxCtrl() 
{
	CString Text;
	double dPos = m_CalGraph.GetStartMarkerPos();
	double dCompVal;

	int iItemCount = m_CalList.GetItemCount();

	if(iItemCount > 0)
	{
		for(int n=0;n<iItemCount;n++)
		{
			dCompVal = ((CMkrInfo*)m_pCalList->GetItemData(n))->m_dCentroidTime;
		
			//Do we have a match?
			if(dCompVal == dPos)
			{
				//Set selection
				UINT State = m_CalList.GetItemState(n, LVIS_SELECTED);
				State = LVIS_SELECTED;
				m_CalList.SetItemState(n, State, LVIS_SELECTED);
				
				break;
			}
		
		}

		m_CalList.SetFocus();

	}
	
}

void CCalibrationView::OnItemchangedCalList(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_LISTVIEW* pNMListView = (NM_LISTVIEW*)pNMHDR;

		if(m_CalList.GetSelectedCount() == 1)
		{
			//Find the selected item
			int iSelectedItem = m_CalList.GetNextItem( -1, LVNI_SELECTED ); 

			if(iSelectedItem == pNMListView->iItem)
			{
				double dCalValue = atof( m_CalList.GetItemText(iSelectedItem,1) );
				//Set marker to selected value
				m_CalGraph.SetStartMarkerPos( dCalValue );
				m_CalGraph.SetEndMarkerPos( dCalValue );

				m_CalGraph.Invalidate();
			}
		}		
	*pResult = 0;
}


