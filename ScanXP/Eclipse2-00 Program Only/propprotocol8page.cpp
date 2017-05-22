//***************************************************************************************
//PropProtocol8Page.cpp : implementation file
//
//	Functions: For details on functions in this file see PropProtocol8Page.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "MainFrm.h"
#include "PropProtocol8Page.h"
#include "CompAdvanced.h"
#include "ProtocolAdvanced.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define PROTOCOL 7

/////////////////////////////////////////////////////////////////////////////
// CPropProtocol8Page property page

IMPLEMENT_DYNCREATE(CPropProtocol8Page, CPropertyPage)

CPropProtocol8Page::CPropProtocol8Page() : CPropertyPage(CPropProtocol8Page::IDD)
{
	//{{AFX_DATA_INIT(CPropProtocol8Page)
	m_fRecordLength = 10.0f;
	m_fOffset = 0.0f;
	m_lRecordPreset = 0;
	m_fTriggerDelay = 0.0f;
	m_fNoiseLevel = 0.0f;
	//}}AFX_DATA_INIT
}

CPropProtocol8Page::~CPropProtocol8Page()
{
}

void CPropProtocol8Page::DoDataExchange(CDataExchange* pDX)
{

	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPropProtocol8Page)
	DDX_Text(pDX, IDC_RECORDLENGTH, m_fRecordLength);
	DDX_Text(pDX, IDC_OFFSET, m_fOffset);
	DDV_MinMaxFloat(pDX, m_fOffset, -0.4f, 0.4f);
	DDX_Text(pDX, IDC_RECORDPRESET, m_lRecordPreset);
	DDX_Text(pDX, IDC_TRIGGERDELAY, m_fTriggerDelay);
	//Hidden for Eclipse
	//DDX_Text(pDX, IDC_NTHRESH_LEVEL, m_fNoiseLevel);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPropProtocol8Page, CPropertyPage)
	//{{AFX_MSG_MAP(CPropProtocol8Page)
	ON_BN_CLICKED(IDC_ADVANCED, OnAdvanced)
	ON_BN_CLICKED(IDC_PROTCOL_ADVANCED, OnProtcolAdvanced)
	ON_BN_CLICKED(IDC_COMPRESSION, OnCompression)
	ON_BN_CLICKED(IDC_AUTONOISE, OnAutonoise)
	ON_BN_CLICKED(IDC_CAL_BROWSE, OnCalBrowse)
	ON_EN_CHANGE(IDC_CAL_PATH, OnChangeCalPath)
	ON_EN_UPDATE(IDC_RECORDLENGTH, OnUpdateRecordlength)
	ON_EN_UPDATE(IDC_TRIGGERDELAY, OnUpdateTriggerdelay)
	ON_EN_UPDATE(IDC_OFFSET, OnUpdateOffset)
	ON_EN_UPDATE(IDC_RECORDPRESET, OnUpdateRecordpreset)
	ON_CBN_SELCHANGE(IDC_PERIOD, OnSelchangePeriod)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPropProtocol8Page message handlers
void CPropProtocol8Page::UpdateFromInst()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	try
	{
		CString Str;

		Str.Format(_T("%f"), pWnd->GetICS()->GetRecordLength(PROTOCOL) );
		SetDlgItemText(IDC_RECORDLENGTH, Str);

		Str.Format(_T("%f"), pWnd->GetICS()->GetOffset(PROTOCOL) );
		SetDlgItemText(IDC_OFFSET, Str);

		Str.Format(_T("%f"), pWnd->GetICS()->GetSamplingInterval(PROTOCOL) );
		float fPeriod = pWnd->GetICS()->GetSamplingInterval(PROTOCOL);
		if(fPeriod == 0.5)((CComboBox*)GetDlgItem(IDC_PERIOD))->SetCurSel(0);
		else if(fPeriod == 1.0)((CComboBox*)GetDlgItem(IDC_PERIOD))->SetCurSel(1);
		else if(fPeriod == 2.0)((CComboBox*)GetDlgItem(IDC_PERIOD))->SetCurSel(2);

		Str.Format(_T("%d"), pWnd->GetICS()->GetScansAveraged(PROTOCOL) );
		SetDlgItemText(IDC_RECORDPRESET, Str);

		Str.Format(_T("%f"), pWnd->GetICS()->GetTimeOffset(PROTOCOL) );
		SetDlgItemText(IDC_TRIGGERDELAY, Str);

		SetDlgItemText(IDC_CAL_PATH, pApp->GetProt7CalPath() );
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}
	UpdateData();
}

BOOL CPropProtocol8Page::OnInitDialog() 
{
	CPropertyPage::OnInitDialog();
	
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	pApp->SetLastPropPageInitialize(this);

	m_RecordLength.SubclassDlgItem(IDC_RECORDLENGTH, this);
	m_TimeOffset.SubclassDlgItem(IDC_TRIGGERDELAY, this);
	m_VertOffset.SubclassDlgItem(IDC_OFFSET, this);
	m_MinThresh.SubclassDlgItem(IDC_NTHRESH_LEVEL, this);

	UpdateFromInst();
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CPropProtocol8Page::OnAdvanced() 
{
	CCompAdvanced adv(this, PROTOCOL);
	adv.DoModal();
}

void CPropProtocol8Page::OnProtcolAdvanced() 
{
	CProtocolAdvanced adv(this, PROTOCOL);
	if(adv.DoModal() == IDOK)SetModified();
}

void CPropProtocol8Page::OnCompression() 
{

	SetModified();	
}

void CPropProtocol8Page::OnAutonoise() 
{
	if( ((CButton*)GetDlgItem(IDC_AUTONOISE))->GetCheck() )
	{
		GetDlgItem(IDC_NTHRESHMULT)->EnableWindow(TRUE);
	}
	else GetDlgItem(IDC_NTHRESHMULT)->EnableWindow(FALSE);

	SetModified();		
}

void CPropProtocol8Page::OnOK() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	UpdateData();

	bool bRestart = false;

	//Stop the instrument...make changes...then restart (all only if currently running)
	if(pWnd->GetIsAcqInProgress()  && pApp->GetLastPropPageInitialize() == this)
	{
		pWnd->GetAcqTab()->OnAcqStop();
		bRestart = true;
	}

	try
	{

		if( ((CComboBox*)GetDlgItem(IDC_PERIOD))->GetCurSel() == 0)
			pWnd->GetICS()->SetSamplingInterval(PROTOCOL, 0.5);
		else
			if( ((CComboBox*)GetDlgItem(IDC_PERIOD))->GetCurSel() == 1)
				pWnd->GetICS()->SetSamplingInterval(PROTOCOL, 1.0);
			else
				if( ((CComboBox*)GetDlgItem(IDC_PERIOD))->GetCurSel() == 2)
					pWnd->GetICS()->SetSamplingInterval(PROTOCOL, 2.0);

		pWnd->GetICS()->SetRecordLength(PROTOCOL, m_fRecordLength);
		pWnd->GetICS()->SetOffset(PROTOCOL, m_fOffset);
		pWnd->GetICS()->SetScansAveraged(PROTOCOL, m_lRecordPreset);
		pWnd->GetICS()->SetTimeOffset(PROTOCOL, m_fTriggerDelay);

	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}	

	UpdateFromInst();
	if(bRestart)
	{
		pWnd->GetAcqTab()->OnAcqStart();
		pWnd->GetTrendView()->GetGraph()->SetDefaultAxis();
		pWnd->GetAverageView()->GetGraph()->SetDefaultAxis();

		//If the FFT View is up we need to AutoScale its graph also
		if(pWnd->m_bViewingFFT)
		{
			if(pWnd->GetAverageView()->GetFFTDlg())
			{
				pWnd->GetAverageView()->GetFFTDlg()->GetGraph()->SetDefaultAxis();
			}
		}
	}

	CPropertyPage::OnOK();
}

void CPropProtocol8Page::OnCalBrowse() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastCalPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);

	static char BASED_CODE szFilter[] = "Calibration Files (*.CAL)|All Files (*.*)|*.*||";

	CFileDialog OpenFile(TRUE,NULL,_T("*.CAL"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_FILEMUSTEXIST | OFN_EXPLORER, szFilter ,this );

	//Change the window caption
	OpenFile.m_ofn.lpstrTitle=_T("Set a Eclipse Calibration file for Protocol #7");
	OpenFile.m_ofn.lpstrInitialDir = DirPath;

	//Start up the modal file dialog
	if(OpenFile.DoModal()==IDOK)
	{
		SetDlgItemText(IDC_CAL_PATH, OpenFile.GetPathName() );
		pApp->SetProt7CalPath( OpenFile.GetPathName() );
	}
	
}

void CPropProtocol8Page::OnChangeCalPath() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString Text;

	GetDlgItemText(IDC_CAL_PATH, Text);

	pApp->SetProt7CalPath( Text );
	SetModified();
}

void CPropProtocol8Page::OnUpdateRecordlength() 
{
	SetModified();
}

void CPropProtocol8Page::OnUpdateTriggerdelay() 
{
	SetModified();
}

void CPropProtocol8Page::OnUpdateOffset() 
{
	SetModified();
}

void CPropProtocol8Page::OnUpdateRecordpreset() 
{
	SetModified();
}

void CPropProtocol8Page::OnSelchangePeriod() 
{
	SetModified();
}
