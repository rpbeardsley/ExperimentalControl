// ShowFFT.cpp : implementation file
//

#include "stdafx.h"
#include "Eclipse.h"
#include "ShowFFT.h"
#include "MainFrm.h"
#include "QuadFit.h"
#include "WindowData.h"
#include "UtilLib\NumberUtils.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#pragma warning(disable:4035) //No return value
inline DWORD MyLogBase2OfDWORD(DWORD dwN){ __asm bsr eax, dwN }
#pragma warning(default:4035)

#define LEFT_OFFSET   10
#define RIGHT_OFFSET  10
#define TOP_OFFSET    75
#define BOTTOM_OFFSET 10


/////////////////////////////////////////////////////////////////////////////
// CShowFFT dialog


CShowFFT::CShowFFT(CWnd* pParent, CGSX2* pSourceGraph)
	: CDialog(CShowFFT::IDD, pParent)
{
	//{{AFX_DATA_INIT(CShowFFT)
	m_bLog = FALSE;
	//}}AFX_DATA_INIT

	m_pParentView = ((CAverageView*)pParent);
	m_pSourceGraph = pSourceGraph;
	m_pCA = NULL;
	m_iRMSIdx = 0;

	((CMainFrame*)AfxGetMainWnd())->m_bViewingFFT = true;

}
CShowFFT::~CShowFFT()
{
	

	delete m_pCA;
	m_pCA = NULL;
}
void CShowFFT::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CShowFFT)
	DDX_Check(pDX, IDC_LOG, m_bLog);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CShowFFT, CDialog)
	//{{AFX_MSG_MAP(CShowFFT)
	ON_WM_SIZE()
	ON_BN_CLICKED(IDC_AUTOSCALE, OnAutoscale)
	ON_BN_CLICKED(IDC_LOG, OnLog)
	ON_BN_CLICKED(IDC_X_IN, OnXIn)
	ON_BN_CLICKED(IDC_X_OUT, OnXOut)
	ON_BN_CLICKED(IDC_Y_IN, OnYIn)
	ON_BN_CLICKED(IDC_Y_OUT, OnYOut)
	ON_WM_CLOSE()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

BEGIN_EVENTSINK_MAP(CShowFFT, CDialog)
    //{{AFX_EVENTSINK_MAP(CShowFFT)
	ON_EVENT(CShowFFT, IDC_FFTGRAPH, 2 /* GSXMouseUp */, OnGSXMouseUp, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	ON_EVENT(CShowFFT, IDC_FFTGRAPH, 3 /* GSXMouseMove */, OnGSXMouseMove, VTS_I2 VTS_I2 VTS_I4 VTS_I4)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()




/////////////////////////////////////////////////////////////////////////////
// CShowFFT message handlers

BOOL CShowFFT::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CRect rect;

	rect.SetRectEmpty();
  
	//Create graph object
	if(!m_Graph.Create(NULL,WS_VISIBLE | WS_CHILD, rect, this, IDC_FFTGRAPH, NULL, FALSE))
	{
		TRACE(_T("Could not create the GSX control"));
		return FALSE;
	}
	
	m_Graph.SetBatchMode(TRUE);
	m_Graph.SetScrollBar(FALSE);		//Disable Scroll bar
	m_Graph.SetInternalMarker(FALSE);	//Disable Marker
	m_Graph.SetInternalZoom(TRUE);		//Enable the Zoom
	m_Graph.SetInternalGain(FALSE);		//Disable the gain adjustment 
	m_Graph.SetShowActiveGraph(FALSE);	//Disable "Active Graph"
	m_Graph.SetActiveGraph(FALSE);		//This graph is not Active
	m_Graph.SetNumberOfSeries(1);
	m_Graph.SetAxisXText( "kHz" );
	m_Graph.SetAxisYText("mVolts");
	m_Graph.SetAxisYLog(TRUE);

	m_Graph.SetPlotAreaColor(15);
	m_Graph.SetBatchMode(FALSE);

	m_Graph.SetDataSymbol(1, 3);
	m_Graph.SetDataSymbolSize(1, 3);
	m_Graph.SetDataSymbolColor(1,12);

	rect.SetRect(0,0,100,100);
	GetClientRect(&rect);
	rect.left+=LEFT_OFFSET;
	rect.top+=TOP_OFFSET;
	rect.right-=RIGHT_OFFSET;
	rect.bottom-=BOTTOM_OFFSET;
	m_Graph.MoveWindow(rect);

	((CButton*)GetDlgItem(IDC_LOG))->SetCheck(TRUE);

	Transfer2DtoFFT();
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CShowFFT::OnSize(UINT nType, int cx, int cy) 
{
	CDialog::OnSize(nType, cx, cy);


	CRect rect;

	if(::IsWindow(m_Graph))
	{
		GetClientRect(&rect);

		rect.left+=LEFT_OFFSET;
		rect.top+=TOP_OFFSET;
		rect.right-=RIGHT_OFFSET;
		rect.bottom-=BOTTOM_OFFSET;
	
		m_Graph.MoveWindow(rect);
	}
}


void CShowFFT::Transfer2DtoFFT()
{
	HRESULT hr;

	//If either the 2D or FFT object does not exist for this Index just return
	if(m_pSourceGraph == NULL || !::IsWindow(m_Graph))
	{
		TRACE("Could not Transfer properties from 2D to FFT Graph\n");
		return;
	}

	if( m_pParentView->GetAverageYData()->vt == (VT_ARRAY | VT_R8))
	{
		int iNumPoints = m_pParentView->GetAverageYData()->parray->rgsabound->cElements;

		//Do we have a selection up...if so get the range and Perform fft only on those points
		int iSelectStart = m_pParentView->GetGraph()->GetStartMarkerIndex(1);
		int iSelectEnd = m_pParentView->GetGraph()->GetEndMarkerIndex(1);

		if( iSelectStart > iSelectEnd )//Reverse direction if needed
		{
			int iTmp = iSelectStart;
			iSelectStart = iSelectEnd;
			iSelectEnd = iTmp;
		}
			
		int iSelectSpan =  iSelectEnd - iSelectStart;

		//make sure we have correct number of points and selection is within range
		if(iSelectSpan >= 8 && iSelectSpan < iNumPoints && iSelectStart <= iNumPoints && iSelectEnd <= iNumPoints)
		{
			
			int iFFTArraySize = GetUpPwrOfTwo( iSelectSpan );//Get the best Power of 2 value for number of points
			
			if(iFFTArraySize > 32768)iFFTArraySize = 32768;

			int iFFTHalfArraySize = iFFTArraySize / 2;
			
			if( m_pCA == NULL )
			{
				m_pCA = new TComplexArray( iFFTArraySize );
			}
			else
			{
				if( (int)m_pCA->GetNumPoints() != iFFTArraySize )
				{
					delete m_pCA;
					m_pCA = NULL;

					m_pCA = new TComplexArray( iFFTArraySize );
				}

			}

				VARIANT vaFFT;
				VARIANT vaX;

				VariantInit(&vaFFT);
				VariantInit(&vaX);

				// Create SAFEARRAY that will contain the data to be transfered to Olectra
				SAFEARRAYBOUND sabOneDim[1]; // one-dimensional array
				SAFEARRAY FAR* psaFFT = NULL;
				SAFEARRAY FAR* psaX = NULL;
				
				double* pYData;
				double* pFFTData;
				double* pXData;

				// Set the bounds of the SafeArray
				// (Note: must be 1-based for Olectra)
				sabOneDim[0].cElements = iFFTHalfArraySize;//Only show half of the FFT 
				sabOneDim[0].lLbound = 1;
			
				// Create the actual SafeArray descriptors
				psaFFT = SafeArrayCreate(VT_R8, 1, sabOneDim);
				if (psaFFT == NULL)
					AfxThrowOleDispatchException(1004, "Out of Memory");

				V_VT(&vaFFT) = VT_ARRAY | VT_R8;

				// Place the safearray pointer in the VARIANT
				V_ARRAY(&vaFFT) = psaFFT;

				psaX = SafeArrayCreate(VT_R8, 1, sabOneDim);
				if (psaX == NULL)
					AfxThrowOleDispatchException(1004, "Out of Memory");

				V_VT(&vaX) = VT_ARRAY | VT_R8;

				// Place the safearray pointer in the VARIANT
				V_ARRAY(&vaX) = psaX;

				hr = SafeArrayAccessData(psaX, (void **)&pXData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				hr = SafeArrayAccessData(psaFFT, (void **)&pFFTData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				hr = SafeArrayAccessData(m_pParentView->GetAverageYData()->parray, (void **)&pYData);
				if(FAILED(hr))TRACE(_T("SafeArrayAccessData failed\n."));

				double dBlockSize = ceil( (double)iSelectSpan / (double)iFFTArraySize );

				int iBlockCnt = iSelectStart;
				double dTotalPerBlock = 0;
				double dValidData = iSelectSpan / dBlockSize;//Only deal with full blocks!
				double* pdAverageY = new double[iFFTArraySize];

				//Compress the time data array to the FFT data array
				for(int iIdx=0;iIdx < iFFTArraySize;iIdx++)
				{
					if(iIdx < dValidData)
					{
						//Store the average of all points in the block
						for(int n=0;n<dBlockSize;n++)
						{
							dTotalPerBlock += ( pYData[iBlockCnt++] );
						}

						pdAverageY[iIdx] = pYData[iBlockCnt-1];
						//Reset total per block for averaging
						dTotalPerBlock = 0.0;
					}
					else pdAverageY[iIdx] = 0.0;//if we need to pad, pad with 0...This will drop out of the FFT function
				}

				//Now we must get the DC component 
				double dComp=0;
				
				for(iIdx = 0;iIdx < dValidData;iIdx++)
				{
					dComp += pdAverageY[iIdx];
				}

				dComp /= dValidData;//Average DC content

				//Remove the DC component
				for(iIdx = 0;iIdx < dValidData;iIdx++)
				{
					pdAverageY[iIdx] -= dComp;
				}


				//Perform windowing function
				CHanningWindow hw(pdAverageY, (int)dValidData, false);
				hw.Calculate();
				
				
				//Apply gain to valid data to account for padded data and restore DC
				double dFactor = iFFTArraySize / dValidData;//Corrects for padding

				for(iIdx = 0;iIdx < iFFTArraySize;iIdx++)
				{
					if( iIdx < dValidData )
					{
						pdAverageY[iIdx] = pdAverageY[iIdx] * dFactor + dComp;
					}
					else
					{
						//Just add DC
						pdAverageY[iIdx] += dComp;
					}
				}
			
				//Actually perform the FFT ... Finally!
				m_pCA->LoadAsFourierTransformFromReals( pdAverageY );


				//Get the span in time
				double dX1, dX2;
				long ix = 2;
				SafeArrayGetElement(m_pParentView->GetAverageXData()->parray, &ix, &dX1);
				ix = 3;
				SafeArrayGetElement(m_pParentView->GetAverageXData()->parray, &ix, &dX2);

				double dXSpan = (iFFTArraySize * dBlockSize) * (dX2 - dX1) * .000001;

							
				int iMaxPointIdx;
				double dSum=0;

								
				//Now load the safearray
				pFFTData[0] = (*m_pCA)[0].GetMagnitude();
				pXData[0] = 0.0;
				double dMaxPointValue = pFFTData[0];
				iMaxPointIdx = 0;

			
				for(int n=1;n < iFFTHalfArraySize;n++)
				{
					TComplex c = (*m_pCA)[n];
								   //Factor of 2 accounts for the folded data
					pFFTData[n] = (2 * c.GetMagnitude());

					pXData[n] = (double)n / dXSpan;
				}

				//Use these values to determine the area currently being viewed.  Then find the largest
				//peak in the viewed area and display its info.
				double dMinViewedArea = m_Graph.GetAxisXMin();
				double dMaxViewedArea = m_Graph.GetAxisXMax();

				bool bInit = true;

				for(n=0;n < iFFTHalfArraySize;n++)
				{
					if(pXData[n] >= dMinViewedArea)
					{
						if(bInit)
						{
							dMaxPointValue = pFFTData[n];//only load this value once
							iMaxPointIdx = n;
							bInit = false;
						}
					}

					if(pFFTData[n] > dMaxPointValue && pXData[n] <= dMaxViewedArea)
					{
						dMaxPointValue = pFFTData[n];
						iMaxPointIdx = n;
					}
					
				}
				
				double /*dX1*/dY1, /*dX2*/ dY2, dX3, dY3;
				
				if( iMaxPointIdx > 0 )
				{
					dX1 = pXData[iMaxPointIdx - 1];
					dY1 = pFFTData[iMaxPointIdx - 1];
				}
				else
				{
					dX1 = -pXData[1];
					dY1 = pFFTData[1];
				}

				dX2 = pXData[iMaxPointIdx];
				dY2 = pFFTData[iMaxPointIdx];

				if( iMaxPointIdx + 1 < iFFTHalfArraySize )
				{
					dX3 = pXData[iMaxPointIdx + 1];
					dY3 = pFFTData[iMaxPointIdx + 1];
				}
				else
				{
					dX3 = 2 * dX2 - dX1;
					dY3 = dY1;
				}

			
				CQuadFit qf(dX1,dY1,dX2,dY2,dX3,dY3,true);

				double dA = qf.GetA();
				double dB = qf.GetB();
				double dC = qf.GetC();

				double dXPeak = -dB / (2.0 * dA);
								
				dMaxPointValue = dC - dB * dB / (4.0 * dA);
						
				CString Text;
				CString FreqText;
				FreqText = EngineeringNotation(dXPeak * 1e3, 5, false);
			
				Text.Format("Points = %d,    FFT Size = %d,    Peak = %.3f mV @ %sHz",  iSelectSpan, iFFTArraySize, dMaxPointValue, FreqText);
				SetDlgItemText(IDC_DEBUGINFO, Text);
				
				hr = SafeArrayUnaccessData(m_pParentView->GetAverageYData()->parray);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));
			
				//Transfer the data to GSX
				m_Graph.SetDataEx(&vaX, &vaFFT, 1, FALSE);
			
				hr = SafeArrayUnaccessData(psaFFT);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

				hr = SafeArrayUnaccessData(psaX);
				if(FAILED(hr))TRACE(_T("SafeArrayUnaccessData failed.\n"));

				

				delete pdAverageY;
				pdAverageY = NULL;

				VariantClear(&vaFFT);
				VariantClear(&vaX);
			
		
		}
		else m_Graph.ClearData(1);
	}
}

void CShowFFT::PostNcDestroy() 
{
	TRACE("Deleting CShowFFT Dlg.\n");

	CDialog::PostNcDestroy();
	delete this;
}

void CShowFFT::OnAutoscale() 
{
	m_Graph.SetDefaultAxis();
	Transfer2DtoFFT();
}


void CShowFFT::OnGSXMouseMove(short Button, short Shift, long x, long y)
{
	double dX,dY;
	static int iLastX = -1, iLastY = -1;

	if( iLastX != x || iLastY != y )
	{
		//Update Mouse pointer info
		m_Graph.ScalePixelToData(x,y,&dX,&dY);
		CString Text;

		CString EngText;
		EngText = EngineeringNotation(dX * 1e3, 5, false);
		Text.Format(_T("X: %sHz"), EngText);
		SetDlgItemText(IDC_MOUSE_XAXIS, Text);

		EngText = EngineeringNotation(dY * 1e-3, 5, false);
		Text.Format(_T("Y: %sV"), EngText);
		SetDlgItemText(IDC_MOUSE_YAXIS, Text);
		
		iLastX = x, iLastY = y;
	}
}



void CShowFFT::OnLog() 
{
	UpdateData();

	if(m_bLog)m_Graph.SetAxisYLog(TRUE);
	else m_Graph.SetAxisYLog(FALSE);

	Transfer2DtoFFT();
}



void CShowFFT::OnXIn() 
{
	m_Graph.ZoomXAxisIn();
	Transfer2DtoFFT();
	
}

void CShowFFT::OnXOut() 
{
	m_Graph.ZoomXAxisOut();
	Transfer2DtoFFT();
	
}

void CShowFFT::OnYIn() 
{
	m_Graph.ZoomYAxisIn();
	Transfer2DtoFFT();
	
}

void CShowFFT::OnYOut() 
{
	m_Graph.ZoomYAxisOut();
	Transfer2DtoFFT();
	
}

long CShowFFT::GetUpPwrOfTwo(long lNumber)
{
	//Returns a value that is the next power of 2 above  the input number
	long i = 1 << MyLogBase2OfDWORD( lNumber );
	if(i < lNumber)i = i << 1;

	return i;
}


void CShowFFT::OnGSXMouseUp(short Button, short Shift, long x, long y)
{
	Transfer2DtoFFT();
}

void CShowFFT::OnClose() 
{
	((CMainFrame*)AfxGetMainWnd())->m_bViewingFFT = false;

	CDialog::OnClose();
	DestroyWindow();
}

void CShowFFT::OnDestroy() 
{

	CDialog::OnDestroy();


}


void CShowFFT::OnCancel() 
{
	((CMainFrame*)AfxGetMainWnd())->m_bViewingFFT = false;

	CDialog::OnCancel();
	DestroyWindow();
}

void CShowFFT::Clear()
{
	m_Graph.ClearData(1);
	SetDlgItemText(IDC_DEBUGINFO  ,_T(""));
	SetDlgItemText(IDC_MOUSE_XAXIS  ,_T(""));
	SetDlgItemText(IDC_MOUSE_YAXIS  ,_T(""));
}

void CShowFFT::OnOK()
{
	//We don't want the dlg going away when the user hits enter so just return!
	return;
}