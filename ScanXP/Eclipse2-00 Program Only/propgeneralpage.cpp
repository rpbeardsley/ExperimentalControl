//***************************************************************************************
//PropGeneralPage.cpp : implementation file
//
//	Functions: For details on functions in this file see PropGeneralPage.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************

#include "stdafx.h"
#include "Eclipse.h"
#include "MainFrm.h"
#include "PropGeneralPage.h"
#include "PropSheet.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPropGeneralPage property page

IMPLEMENT_DYNCREATE(CPropGeneralPage, CPropertyPage)

CPropGeneralPage::CPropGeneralPage() : CPropertyPage(CPropGeneralPage::IDD)
{
	//{{AFX_DATA_INIT(CPropGeneralPage)
	m_lPresetTime = 1;
	m_lPresetSpectrum = 1;
	m_bRPS = FALSE;
	m_TriggerPolarityGroup = -1;
	//}}AFX_DATA_INIT

	m_pSymbolFont = NULL;
}

CPropGeneralPage::~CPropGeneralPage()
{
	delete m_pSymbolFont;
	m_pSymbolFont = NULL;
}

void CPropGeneralPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPropGeneralPage)
	DDX_Control(pDX, IDC_FILE_OPERATOR, m_FileOperator);
	DDX_Control(pDX, IDC_APPLY_OPERATOR, m_ApplyOperator);
	DDX_Text(pDX, IDC_PRESETTIME, m_lPresetTime);
	DDV_MinMaxLong(pDX, m_lPresetTime, 1, 65535);
	DDX_Text(pDX, IDC_SPECTRUMPRESET, m_lPresetSpectrum);
	DDV_MinMaxLong(pDX, m_lPresetSpectrum, 1, 32767);
	DDX_Radio(pDX, IDC_POSITIVEPOLARITY, m_TriggerPolarityGroup);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPropGeneralPage, CPropertyPage)
	//{{AFX_MSG_MAP(CPropGeneralPage)
	ON_EN_CHANGE(IDC_PRESETTIME, OnChangePresetTime)
	ON_EN_CHANGE(IDC_SPECTRUMPRESET, OnChangeSpectrumPreset)
	ON_BN_CLICKED(IDC_RPS, OnRps)
	ON_EN_CHANGE(IDC_PROTOCOL, OnChangeProtocol)
	ON_BN_CLICKED(IDC_NEGATIVEPOLARITY, OnNegativepolarity)
	ON_BN_CLICKED(IDC_POSITIVEPOLARITY, OnPositivepolarity)
	ON_CBN_SELCHANGE(IDC_PROTOCOL, OnSelchangeProtocol)
	ON_BN_CLICKED(IDC_FILE_COMBINE, OnFileCombine)
	ON_BN_CLICKED(IDC_APPLY_CONSTANT, OnApplyConstant)
	ON_BN_CLICKED(IDC_FILE_BROWSE, OnFileBrowse)
	ON_BN_CLICKED(IDC_APPLY_OPERATOR, OnApplyOperator)
	ON_BN_CLICKED(IDC_FILE_OPERATOR, OnFileOperator)
	ON_EN_UPDATE(IDC_CONST_VALUE, OnUpdateConstValue)
	ON_BN_CLICKED(IDC_MAX_NUMBER, OnMaxNumber)
	ON_BN_CLICKED(IDC_MAX_TIME, OnMaxTime)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CPropGeneralPage::UpdateFromInst()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	try
	{
		if( pWnd->GetICS()->GetTriggerPolarity() )
		{
			m_TriggerPolarityGroup = 0;
			((CButton*)GetDlgItem(IDC_POSITIVEPOLARITY))->SetCheck(TRUE);
		}
		else 
		{
			m_TriggerPolarityGroup = 1;
			((CButton*)GetDlgItem(IDC_NEGATIVEPOLARITY))->SetCheck(TRUE);
		}
		
		CString Str;

	/*	Str.Format(_T("%d"), pWnd->GetICS()->GetTimePreset() );
		SetDlgItemText(IDC_PRESETTIME, Str);

		Str.Format(_T("%d"), pWnd->GetICS()->GetSpectrumPreset() );
		SetDlgItemText(IDC_SPECTRUMPRESET, Str);*/

		Str.Format(_T("%d"), pWnd->GetICS()->GetProtocol() );
		SetDlgItemText(IDC_PROTOCOL, Str);

		int iSel = pWnd->GetICS()->GetProtocol();
		((CComboBox*)GetDlgItem(IDC_PROTOCOL))->SetCurSel(iSel);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}

	if(pApp->GetMode() != TREND)
	{

		//Update the Data Modification controls
		m_iConstOperator = pApp->GetConstOperator();
		m_iFileOperator = pApp->GetFileOperator();
		UpdateImages();

		((CButton*)GetDlgItem(IDC_APPLY_CONSTANT))->SetCheck( pApp->GetIsApplyConst() );
		SetDlgItemText(IDC_CONST_VALUE, pApp->GetConstValue() );

		((CButton*)GetDlgItem(IDC_FILE_COMBINE))->SetCheck( pApp->GetIsCombineFile() );
		SetDlgItemText(IDC_FILE_NAME, pApp->GetFilename() );
		m_Filename = pApp->GetFilename();
		m_FilePath = pApp->GetFilePath();

		OnFileCombine();
		OnApplyConstant();
	}


	UpdateData();


}
BOOL CPropGeneralPage::OnInitDialog() 
{
	CPropertyPage::OnInitDialog();

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	m_ConstValue.SubclassDlgItem(IDC_CONST_VALUE, this);

	pApp->SetLastPropPageInitialize(this);

	if( pApp->GetIsMaxTimeUsed() )
	{
		((CButton*)GetDlgItem(IDC_MAX_TIME))->SetCheck( TRUE );
		GetDlgItem(IDC_PRESETTIME)->EnableWindow(TRUE);
	}
	else
	{
		((CButton*)GetDlgItem(IDC_MAX_TIME))->SetCheck( FALSE );
		GetDlgItem(IDC_PRESETTIME)->EnableWindow(FALSE);

	}
	if( pApp->GetIsMaxNumberUsed() )
	{
		((CButton*)GetDlgItem(IDC_MAX_NUMBER))->SetCheck( TRUE );
		GetDlgItem(IDC_SPECTRUMPRESET)->EnableWindow(TRUE);
	}
	else
	{
		((CButton*)GetDlgItem(IDC_MAX_NUMBER))->SetCheck( FALSE );
		GetDlgItem(IDC_SPECTRUMPRESET)->EnableWindow(FALSE);
	}

	m_lPresetSpectrum = pApp->GetMaxNumber();
	UpdateData(FALSE);
	m_lPresetTime = pApp->GetMaxTime();
	UpdateData(FALSE);

	//If we are in Trend mode we cant apply a constant, so disable
	if(pApp->GetMode() == TREND)
	{
		((CButton*)GetDlgItem(IDC_APPLY_CONSTANT))->SetCheck( FALSE );
		((CButton*)GetDlgItem(IDC_FILE_COMBINE))->SetCheck( FALSE );

		OnFileCombine();
		OnApplyConstant();

		GetDlgItem(IDC_APPLY_CONSTANT)->EnableWindow(FALSE);
		GetDlgItem(IDC_FILE_COMBINE)->EnableWindow(FALSE);
	}

	UpdateFromInst();
	UpdateData(FALSE);
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

BOOL CPropGeneralPage::OnApply() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	TRACE("Apply called from General props\n");

	UpdateData();
	bool bRestart = false;

	pApp->SetIsMaxTimeUsed( ((CButton*)GetDlgItem(IDC_MAX_TIME))->GetCheck()  );
	pApp->SetIsMaxNumberUsed( ((CButton*)GetDlgItem(IDC_MAX_NUMBER))->GetCheck()  );
	pApp->SetMaxNumber( m_lPresetSpectrum );
	pApp->SetMaxTime( m_lPresetTime );

	if(pWnd->GetIsAcqInProgress() && pApp->GetLastPropPageInitialize() == this)
	{
		bRestart = true;
		pWnd->GetAcqTab()->OnAcqStop();
	}
	
	try
	{
		//Always set up the instrument to run constantly, we are now going to do the 
		//Presets ourselves
		pWnd->GetICS()->SetTimePreset(0);
		pWnd->GetICS()->SetSpectrumPreset(0);
		
		pWnd->GetICS()->SetProtocol( ((CComboBox*)GetDlgItem(IDC_PROTOCOL))->GetCurSel() );

		if(m_TriggerPolarityGroup == 0)
			pWnd->GetICS()->SetTriggerPolarity(TRUE);
		else
			pWnd->GetICS()->SetTriggerPolarity(FALSE);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}

	//Save the current data modification settings
	CString tmp;

	if(pApp->GetMode() != TREND)
	{
		pApp->SetIsApplyConst( ((CButton*)GetDlgItem(IDC_APPLY_CONSTANT))->GetCheck() );
		pApp->SetConstOperator( m_iConstOperator );
		GetDlgItemText(IDC_CONST_VALUE, tmp); 
		pApp->SetConstValue( tmp );
		
		pApp->SetIsCombineFile( ((CButton*)GetDlgItem(IDC_FILE_COMBINE))->GetCheck() );
		pApp->SetFileOperator( m_iFileOperator );
		pApp->SetFilename( m_Filename );
		pApp->SetFilePath( m_FilePath );
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

	return CPropertyPage::OnApply();
}

/////////////////////////////////////////////////////////////////////////////
// CPropGeneralPage message handlers

void CPropGeneralPage::OnChangePresetTime() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CPropertyPage::OnInitDialog()
	// function to send the EM_SETEVENTMASK message to the control
	// with the ENM_CHANGE flag ORed into the lParam mask.
	
	SetModified();
	
}



void CPropGeneralPage::OnChangeSpectrumPreset() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CPropertyPage::OnInitDialog()
	// function to send the EM_SETEVENTMASK message to the control
	// with the ENM_CHANGE flag ORed into the lParam mask.
	
	SetModified();
	
}

void CPropGeneralPage::OnRps() 
{
	SetModified();
	
}

void CPropGeneralPage::OnChangeProtocol() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CPropertyPage::OnInitDialog()
	// function to send the EM_SETEVENTMASK message to the control
	// with the ENM_CHANGE flag ORed into the lParam mask.
	
	SetModified();
	
}




void CPropGeneralPage::OnNegativepolarity() 
{
	// TODO: Add your control notification handler code here
	SetModified();	
}

void CPropGeneralPage::OnPositivepolarity() 
{
	// TODO: Add your control notification handler code here
	SetModified();	
}

void CPropGeneralPage::OnSelchangeProtocol() 
{
	// TODO: Add your control notification handler code here
	SetModified();	
}

void CPropGeneralPage::OnFileCombine() 
{

	if( ((CButton*)GetDlgItem(IDC_FILE_COMBINE))->GetCheck() )EnableFileProps(true);
	else EnableFileProps(false);
	SetModified();
}

void CPropGeneralPage::OnApplyConstant() 
{
	if( ((CButton*)GetDlgItem(IDC_APPLY_CONSTANT))->GetCheck() )EnableConstProps(true);
	else EnableConstProps(false);
	SetModified();
		
	
}

void CPropGeneralPage::EnableFileProps(bool bEnable)
{
	GetDlgItem(IDC_FILE_OPERATOR)->EnableWindow(bEnable);
	GetDlgItem(IDC_FILE_BROWSE)->EnableWindow(bEnable);
	GetDlgItem(IDC_FILE_NAME)->EnableWindow(bEnable);
	SetModified();
}
void CPropGeneralPage::EnableConstProps(bool bEnable)
{
	GetDlgItem(IDC_APPLY_OPERATOR)->EnableWindow(bEnable);
	GetDlgItem(IDC_CONST_VALUE)->EnableWindow(bEnable);
	SetModified();
}

void CPropGeneralPage::OnFileBrowse() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	char InitDir[_MAX_DIR]; 
    char InitName[_MAX_FNAME];
    char InitExt[_MAX_EXT];
    char InitDrive[_MAX_DRIVE];

	_splitpath( pApp->GetLastOpenPath() , InitDrive ,InitDir, InitName, InitExt);

	CString DirPath,Title;
	DirPath.Format(_T("%s%s"),InitDrive,InitDir);
	DirPath = DirPath.Left(DirPath.GetLength() - 1);
	Title.Format(_T("%s%s"),InitName,InitExt);

	CFileDialog OpenFile(TRUE,NULL,_T("*.FLT"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
					     OFN_FILEMUSTEXIST | OFN_EXPLORER,_T("Eclipse (*.FLT)"),this );

	//Change the window caption
	OpenFile.m_ofn.lpstrTitle=_T("Choose a file");
	OpenFile.m_ofn.lpstrInitialDir = DirPath;

	//Start up the modal file dialog
	if(OpenFile.DoModal()==IDOK)
	{
		m_FilePath = OpenFile.GetPathName();
		m_Filename = OpenFile.GetFileName();
		
		//update the "Filename" edit control
		SetDlgItemText(IDC_FILE_NAME, m_Filename);
	}	
	SetModified();
}
void CPropGeneralPage::UpdateImages()
{

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	switch( m_iConstOperator )
	{
		HANDLE Icon;

		case 0:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_ADD), IMAGE_ICON, 0, 0, 0);
			m_ApplyOperator.SetIcon( (HICON)Icon );
		break;
		case 1:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_SUBTRACT), IMAGE_ICON, 0, 0, 0);
			m_ApplyOperator.SetIcon( (HICON)Icon );
		break;
		case 2:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_MULTIPLY), IMAGE_ICON, 0, 0, 0);
			m_ApplyOperator.SetIcon( (HICON)Icon );
		break;
		case 3:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_DIVIDE), IMAGE_ICON, 0, 0, 0);
			m_ApplyOperator.SetIcon( (HICON)Icon );
		break;
	}

	switch( m_iFileOperator )
	{
		HANDLE Icon;

		case 0:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_ADD), IMAGE_ICON, 0, 0, 0);
			m_FileOperator.SetIcon( (HICON)Icon );
		break;
		case 1:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_SUBTRACT), IMAGE_ICON, 0, 0, 0);
			m_FileOperator.SetIcon( (HICON)Icon );
		break;
		case 2:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_MULTIPLY), IMAGE_ICON, 0, 0, 0);
			m_FileOperator.SetIcon( (HICON)Icon );
		break;
		case 3:
			Icon = ::LoadImage( AfxGetResourceHandle(), MAKEINTRESOURCE(IDI_DIVIDE), IMAGE_ICON, 0, 0, 0);
			m_FileOperator.SetIcon( (HICON)Icon );
		break;
	}
}
void CPropGeneralPage::OnApplyOperator() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if( m_iConstOperator < 3)m_iConstOperator++; else m_iConstOperator = 0;
	UpdateImages();	
	SetModified();
}

void CPropGeneralPage::OnFileOperator() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);
	//Don't allow divide for now...
	if( m_iFileOperator < 2)m_iFileOperator++; else m_iFileOperator = 0;
	UpdateImages();	
	SetModified();
}

void CPropGeneralPage::OnUpdateConstValue() 
{

	SetModified();
	
}

void CPropGeneralPage::OnMaxNumber() 
{
	if( ((CButton*)GetDlgItem(IDC_MAX_NUMBER))->GetCheck() )
		GetDlgItem(IDC_SPECTRUMPRESET)->EnableWindow(TRUE);
	else 
		GetDlgItem(IDC_SPECTRUMPRESET)->EnableWindow(FALSE);

	SetModified();	
}

void CPropGeneralPage::OnMaxTime() 
{
	if( ((CButton*)GetDlgItem(IDC_MAX_TIME))->GetCheck() )
		GetDlgItem(IDC_PRESETTIME)->EnableWindow(TRUE);
	else 
		GetDlgItem(IDC_PRESETTIME)->EnableWindow(FALSE);

	SetModified();	
}
