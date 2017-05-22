// TrendSetup.cpp : implementation file
//

#include "stdafx.h"
#include "eclipse.h"
#include "TrendSetup.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTrendSetup dialog


CTrendSetup::CTrendSetup(CWnd* pParent /*=NULL*/)
	: CDialog(CTrendSetup::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTrendSetup)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CTrendSetup::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTrendSetup)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CTrendSetup, CDialog)
	//{{AFX_MSG_MAP(CTrendSetup)
	ON_BN_CLICKED(IDC_TRACK_ENABLE, OnTrackEnable)
	ON_BN_CLICKED(IDC_TRACK_ENABLE2, OnTrackEnable2)
	ON_BN_CLICKED(IDC_TRACK_ENABLE3, OnTrackEnable3)
	ON_BN_CLICKED(IDC_TRACK_ENABLE4, OnTrackEnable4)
	ON_BN_CLICKED(IDC_UPDATE, OnUpdate)
	ON_BN_CLICKED(IDC_UPDATE2, OnUpdate2)
	ON_BN_CLICKED(IDC_UPDATE3, OnUpdate3)
	ON_BN_CLICKED(IDC_UPDATE4, OnUpdate4)
	ON_BN_CLICKED(IDC_SET_REGION, OnSetRegion)
	ON_BN_CLICKED(IDC_SET_REGION2, OnSetRegion2)
	ON_BN_CLICKED(IDC_SET_REGION3, OnSetRegion3)
	ON_BN_CLICKED(IDC_SET_REGION4, OnSetRegion4)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTrendSetup message handlers

void CTrendSetup::OnTrackEnable() 
{
	BOOL bEnable = ((CButton*)GetDlgItem(IDC_TRACK_ENABLE))->GetCheck();

	GetDlgItem(IDC_MEASUREMENTS)->EnableWindow(bEnable);
	GetDlgItem(IDC_START_SPAN)->EnableWindow(bEnable);
	GetDlgItem(IDC_SPAN_END)->EnableWindow(bEnable);
	GetDlgItem(IDC_UPDATE)->EnableWindow(bEnable);
	GetDlgItem(IDC_SET_REGION)->EnableWindow(bEnable);
	
}

void CTrendSetup::OnTrackEnable2() 
{
	BOOL bEnable = ((CButton*)GetDlgItem(IDC_TRACK_ENABLE2))->GetCheck();

	GetDlgItem(IDC_MEASUREMENTS2)->EnableWindow(bEnable);
	GetDlgItem(IDC_START_SPAN2)->EnableWindow(bEnable);
	GetDlgItem(IDC_SPAN_END2)->EnableWindow(bEnable);
	GetDlgItem(IDC_UPDATE2)->EnableWindow(bEnable);
	GetDlgItem(IDC_SET_REGION2)->EnableWindow(bEnable);
	
}

void CTrendSetup::OnTrackEnable3() 
{
	BOOL bEnable = ((CButton*)GetDlgItem(IDC_TRACK_ENABLE3))->GetCheck();

	GetDlgItem(IDC_MEASUREMENTS3)->EnableWindow(bEnable);
	GetDlgItem(IDC_START_SPAN3)->EnableWindow(bEnable);
	GetDlgItem(IDC_SPAN_END3)->EnableWindow(bEnable);
	GetDlgItem(IDC_UPDATE3)->EnableWindow(bEnable);	
	GetDlgItem(IDC_SET_REGION3)->EnableWindow(bEnable);

}

void CTrendSetup::OnTrackEnable4() 
{
	BOOL bEnable = ((CButton*)GetDlgItem(IDC_TRACK_ENABLE4))->GetCheck();

	GetDlgItem(IDC_MEASUREMENTS4)->EnableWindow(bEnable);
	GetDlgItem(IDC_START_SPAN4)->EnableWindow(bEnable);
	GetDlgItem(IDC_SPAN_END4)->EnableWindow(bEnable);
	GetDlgItem(IDC_UPDATE4)->EnableWindow(bEnable);
	GetDlgItem(IDC_SET_REGION4)->EnableWindow(bEnable);

}

BOOL CTrendSetup::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	//Subclass the edit controls to allow floating point numbers only!
	m_ETrack1From.SubclassDlgItem(IDC_START_SPAN, this);
	m_ETrack1To.SubclassDlgItem(IDC_SPAN_END, this);
	m_ETrack2From.SubclassDlgItem(IDC_START_SPAN2, this);
	m_ETrack2To.SubclassDlgItem(IDC_SPAN_END2, this);
	m_ETrack3From.SubclassDlgItem(IDC_START_SPAN3, this);
	m_ETrack3To.SubclassDlgItem(IDC_SPAN_END3, this);
	m_ETrack4From.SubclassDlgItem(IDC_START_SPAN4, this);
	m_ETrack4To.SubclassDlgItem(IDC_SPAN_END4, this);

	PFNGETNAME pfnGetName;

	int iCount = 0;

	CFileFind finder;  
	CString sDllPath;
	CString sAppPath;

	sAppPath = pApp->m_pszHelpFilePath;

	int iLen = sAppPath.GetLength();

	sAppPath = sAppPath.Left(iLen - 11);
	sAppPath += _T("\\Measurements\\Eclipse*.*");

	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS))->AddString( "None" );
	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS2))->AddString( "None" );
	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS3))->AddString( "None" );
	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS4))->AddString( "None" );

	BOOL bWorking = finder.FindFile(sAppPath);

    while (bWorking)//Locate all "Eclipse measurement dlls"
    {      
		bWorking = finder.FindNextFile();

		sDllPath = finder.GetFilePath();

		TRACE1("Found %s\n", sDllPath);

        HMODULE hMeasurement = AfxLoadLibrary(sDllPath);
	
		if(hMeasurement != NULL)
		{
			TRACE(_T("Measurement is Available\n"));

			char Name[255];
			int iNumChars;

			pfnGetName = (PFNGETNAME)::GetProcAddress( hMeasurement, "_GetName@4" );

			if(pfnGetName)
				iNumChars = pfnGetName( Name );

			((CComboBox*)GetDlgItem(IDC_MEASUREMENTS))->AddString( Name );
			((CComboBox*)GetDlgItem(IDC_MEASUREMENTS2))->AddString( Name );
			((CComboBox*)GetDlgItem(IDC_MEASUREMENTS3))->AddString( Name );
			((CComboBox*)GetDlgItem(IDC_MEASUREMENTS4))->AddString( Name );
	
			AfxFreeLibrary( hMeasurement );
		}
	}

	finder.Close();

	//Set to last stored positions
	LoadCurrentSettings();

	OnTrackEnable(); 
	OnTrackEnable2(); 
	OnTrackEnable3(); 
	OnTrackEnable4(); 

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}



void CTrendSetup::LoadCurrentSettings()
{

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString Text;

	//Write current settings to registry
	((CButton*)GetDlgItem(IDC_TRACK_ENABLE))->SetCheck( pApp->GetProfileInt(_T("Trend"), _T("UseTrack1"), 0 ));

	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS))->SetCurSel( 
		((CComboBox*)GetDlgItem(IDC_MEASUREMENTS))->SelectString(-1, pApp->GetProfileString(_T("Trend"), _T("Measurement1Name"), "None" )));

	SetDlgItemText(IDC_START_SPAN, 	pApp->GetProfileString(_T("Trend"), _T("Measurement1Start"), _T("")) );
	SetDlgItemText(IDC_SPAN_END, 	pApp->GetProfileString(_T("Trend"), _T("Measurement1End"), _T("")) );


	((CButton*)GetDlgItem(IDC_TRACK_ENABLE2))->SetCheck( pApp->GetProfileInt(_T("Trend"), _T("UseTrack2"), 0 ));

	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS2))->SetCurSel( 
		((CComboBox*)GetDlgItem(IDC_MEASUREMENTS2))->SelectString(-1, pApp->GetProfileString(_T("Trend"), _T("Measurement2Name"), "None" )));


	SetDlgItemText(IDC_START_SPAN2, pApp->GetProfileString(_T("Trend"), _T("Measurement2Start"), _T("")) );
	SetDlgItemText(IDC_SPAN_END2, 	pApp->GetProfileString(_T("Trend"), _T("Measurement2End"), _T("")) );



	((CButton*)GetDlgItem(IDC_TRACK_ENABLE3))->SetCheck( pApp->GetProfileInt(_T("Trend"), _T("UseTrack3"), 0 ));

	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS3))->SetCurSel( 
		((CComboBox*)GetDlgItem(IDC_MEASUREMENTS3))->SelectString(-1, pApp->GetProfileString(_T("Trend"), _T("Measurement3Name"), "None" )));


	SetDlgItemText(IDC_START_SPAN3, pApp->GetProfileString(_T("Trend"), _T("Measurement3Start"), _T("")) );
	SetDlgItemText(IDC_SPAN_END3, 	pApp->GetProfileString(_T("Trend"), _T("Measurement3End"), _T("")) );



	((CButton*)GetDlgItem(IDC_TRACK_ENABLE4))->SetCheck( pApp->GetProfileInt(_T("Trend"), _T("UseTrack4"), 0 ));

	((CComboBox*)GetDlgItem(IDC_MEASUREMENTS4))->SetCurSel( 
		((CComboBox*)GetDlgItem(IDC_MEASUREMENTS4))->SelectString(-1, pApp->GetProfileString(_T("Trend"), _T("Measurement4Name"), "None" )));


	SetDlgItemText(IDC_START_SPAN4, pApp->GetProfileString(_T("Trend"), _T("Measurement4Start"), _T("")) );
	SetDlgItemText(IDC_SPAN_END4, 	pApp->GetProfileString(_T("Trend"), _T("Measurement4End"), _T("")) );

}

void CTrendSetup::OnOK() 
{
	Apply();

	CDialog::OnOK();
}

void CTrendSetup::Apply() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString Text;

	//Write current settings to registry
	pApp->WriteProfileInt(_T("Trend"), _T("UseTrack1"), ((CButton*)GetDlgItem(IDC_TRACK_ENABLE))->GetCheck() );

	GetDlgItemText(IDC_START_SPAN, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement1Start"), Text); 

	GetDlgItemText(IDC_SPAN_END, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement1End"), Text); 

	GetDlgItemText(IDC_MEASUREMENTS, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement1Name"), Text); 

	if(Text == "None")
	{
		//If user set this track to "On" and "None" as measurement, Turn if Off
		pApp->WriteProfileInt(_T("Trend"), _T("UseTrack1"), FALSE );
	}


//---------------

	pApp->WriteProfileInt(_T("Trend"), _T("UseTrack2"), ((CButton*)GetDlgItem(IDC_TRACK_ENABLE2))->GetCheck() );

	GetDlgItemText(IDC_START_SPAN2, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement2Start"), Text); 

	GetDlgItemText(IDC_SPAN_END2, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement2End"), Text); 
	
	GetDlgItemText(IDC_MEASUREMENTS2, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement2Name"), Text); 

	if(Text == "None")
	{
		//If user set this track to "On" and "None" as measurement, Turn if Off
		pApp->WriteProfileInt(_T("Trend"), _T("UseTrack2"), FALSE );
	}


//---------------

	pApp->WriteProfileInt(_T("Trend"), _T("UseTrack3"), ((CButton*)GetDlgItem(IDC_TRACK_ENABLE3))->GetCheck() );

	GetDlgItemText(IDC_START_SPAN3, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement3Start"), Text); 

	GetDlgItemText(IDC_SPAN_END3, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement3End"), Text); 

	GetDlgItemText(IDC_MEASUREMENTS3, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement3Name"), Text); 

	if(Text == "None")
	{
		//If user set this track to "On" and "None" as measurement, Turn if Off
		pApp->WriteProfileInt(_T("Trend"), _T("UseTrack3"), FALSE );
	}


//---------------

	pApp->WriteProfileInt(_T("Trend"), _T("UseTrack4"), ((CButton*)GetDlgItem(IDC_TRACK_ENABLE4))->GetCheck() );
	
	GetDlgItemText(IDC_START_SPAN4, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement4Start"), Text); 

	GetDlgItemText(IDC_SPAN_END4, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement4End"), Text); 

	GetDlgItemText(IDC_MEASUREMENTS4, Text);
	pApp->WriteProfileString(_T("Trend"), _T("Measurement4Name"), Text); 

	if(Text == "None")
	{
		//If user set this track to "On" and "None" as measurement, Turn if Off
		pApp->WriteProfileInt(_T("Trend"), _T("UseTrack4"), FALSE );
	}

//---------------
	
}

void CTrendSetup::OnUpdate() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax;

	double dTMin = pWnd->GetAverageView()->GetGraph()->GetStartMarkerPos();
	double dTMax = pWnd->GetAverageView()->GetGraph()->GetEndMarkerPos();

	if(dTMin != dTMax)
	{
		dMin = __min(dTMin, dTMax);
		dMax = __max(dTMin, dTMax);
	}
	else
	{
		dMin = pWnd->GetAverageView()->GetGraph()->GetAxisXMin();
		dMax = pWnd->GetAverageView()->GetGraph()->GetAxisXMax();
	}

	if(dMin != 1e308 && dMax != 1e308)
	{
		Text.Format("%f", dMin);
		SetDlgItemText(IDC_START_SPAN, Text);

		Text.Format("%f", dMax);
		SetDlgItemText(IDC_SPAN_END, Text);
	}

	
}
void CTrendSetup::OnUpdate2() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax;

	double dTMin = pWnd->GetAverageView()->GetGraph()->GetStartMarkerPos();
	double dTMax = pWnd->GetAverageView()->GetGraph()->GetEndMarkerPos();

	if(dTMin != dTMax)
	{
		dMin = __min(dTMin, dTMax);
		dMax = __max(dTMin, dTMax);
	}
	else
	{
		dMin = pWnd->GetAverageView()->GetGraph()->GetAxisXMin();
		dMax = pWnd->GetAverageView()->GetGraph()->GetAxisXMax();
	}

	if(dMin != 1e308 && dMax != 1e308)
	{
		Text.Format("%f", dMin);
		SetDlgItemText(IDC_START_SPAN2, Text);

		Text.Format("%f", dMax);
		SetDlgItemText(IDC_SPAN_END2, Text);
	}
}

void CTrendSetup::OnUpdate3() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax;

	double dTMin = pWnd->GetAverageView()->GetGraph()->GetStartMarkerPos();
	double dTMax = pWnd->GetAverageView()->GetGraph()->GetEndMarkerPos();

	if(dTMin != dTMax)
	{
		dMin = __min(dTMin, dTMax);
		dMax = __max(dTMin, dTMax);
	}
	else
	{
		dMin = pWnd->GetAverageView()->GetGraph()->GetAxisXMin();
		dMax = pWnd->GetAverageView()->GetGraph()->GetAxisXMax();
	}

	if(dMin != 1e308 && dMax != 1e308)
	{

		Text.Format("%f", dMin);
		SetDlgItemText(IDC_START_SPAN3, Text);

		Text.Format("%f", dMax);
		SetDlgItemText(IDC_SPAN_END3, Text);	
	}
}

void CTrendSetup::OnUpdate4() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax;

	double dTMin = pWnd->GetAverageView()->GetGraph()->GetStartMarkerPos();
	double dTMax = pWnd->GetAverageView()->GetGraph()->GetEndMarkerPos();

	if(dTMin != dTMax)
	{
		dMin = __min(dTMin, dTMax);
		dMax = __max(dTMin, dTMax);
	}
	else
	{
		dMin = pWnd->GetAverageView()->GetGraph()->GetAxisXMin();
		dMax = pWnd->GetAverageView()->GetGraph()->GetAxisXMax();

	}

	if(dMin != 1e308 && dMax != 1e308)
	{
		Text.Format("%f", dMin);
		SetDlgItemText(IDC_START_SPAN4, Text);

		Text.Format("%f", dMax);
		SetDlgItemText(IDC_SPAN_END4, Text);	
	}
}

void CTrendSetup::OnSetRegion() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax, dTMin, dTMax;

	GetDlgItemText(IDC_START_SPAN, Text);

	dTMin = atof( Text );

	GetDlgItemText(IDC_SPAN_END, Text);

	dTMax = atof( Text );

	dMin = __min(dTMin, dTMax);
	dMax = __max(dTMin, dTMax);

	pWnd->GetAverageView()->GetGraph()->SetStartMarkerPos(dMin);
	pWnd->GetAverageView()->GetGraph()->SetEndMarkerPos(dMax);


	pWnd->GetAverageView()->GetGraph()->ReDraw();
}

void CTrendSetup::OnSetRegion2() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax, dTMin, dTMax;

	GetDlgItemText(IDC_START_SPAN2, Text);

	dTMin = atof( Text );

	GetDlgItemText(IDC_SPAN_END2, Text);

	dTMax = atof( Text );

	dMin = __min(dTMin, dTMax);
	dMax = __max(dTMin, dTMax);

	pWnd->GetAverageView()->GetGraph()->SetStartMarkerPos(dMin);
	pWnd->GetAverageView()->GetGraph()->SetEndMarkerPos(dMax);


	pWnd->GetAverageView()->GetGraph()->ReDraw();	
}

void CTrendSetup::OnSetRegion3() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax, dTMin, dTMax;

	GetDlgItemText(IDC_START_SPAN3, Text);

	dTMin = atof( Text );

	GetDlgItemText(IDC_SPAN_END3, Text);

	dTMax = atof( Text );

	dMin = __min(dTMin, dTMax);
	dMax = __max(dTMin, dTMax);

	pWnd->GetAverageView()->GetGraph()->SetStartMarkerPos(dMin);
	pWnd->GetAverageView()->GetGraph()->SetEndMarkerPos(dMax);


	pWnd->GetAverageView()->GetGraph()->ReDraw();	
}

void CTrendSetup::OnSetRegion4() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Text;
	double dMin, dMax, dTMin, dTMax;

	GetDlgItemText(IDC_START_SPAN4, Text);

	dTMin = atof( Text );

	GetDlgItemText(IDC_SPAN_END4, Text);

	dTMax = atof( Text );

	dMin = __min(dTMin, dTMax);
	dMax = __max(dTMin, dTMax);

	pWnd->GetAverageView()->GetGraph()->SetStartMarkerPos(dMin);
	pWnd->GetAverageView()->GetGraph()->SetEndMarkerPos(dMax);


	pWnd->GetAverageView()->GetGraph()->ReDraw();	
}
