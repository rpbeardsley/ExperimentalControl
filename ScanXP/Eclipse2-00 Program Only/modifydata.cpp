// ModifyData.cpp : implementation file
//

#include "stdafx.h"
#include "Eclipse.h"
#include "ModifyData.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CModifyData dialog


CModifyData::CModifyData(CWnd* pParent, bool bSaveSettings)
	: CDialog(CModifyData::IDD, pParent)
{
	//{{AFX_DATA_INIT(CModifyData)
	//}}AFX_DATA_INIT
	m_bSaveSettings = bSaveSettings;
}


void CModifyData::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CModifyData)
	DDX_Control(pDX, IDC_FILE_OPERATOR, m_FileOperator);
	DDX_Control(pDX, IDC_APPLY_OPERATOR, m_ApplyOperator);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CModifyData, CDialog)
	//{{AFX_MSG_MAP(CModifyData)
	ON_BN_CLICKED(IDC_FILE_COMBINE, OnFileCombine)
	ON_BN_CLICKED(IDC_APPLY_CONSTANT, OnApplyConstant)
	ON_BN_CLICKED(IDC_FILE_BROWSE, OnFileBrowse)
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDC_APPLY_OPERATOR, OnApplyOperator)
	ON_BN_CLICKED(IDC_FILE_OPERATOR, OnFileOperator)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CModifyData message handlers

BOOL CModifyData::OnInitDialog() 
{
	CDialog::OnInitDialog();
	

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	m_ConstValue.SubclassDlgItem(IDC_CONST_VALUE, this);

	m_iConstOperator = pApp->GetConstOperator();
	m_iFileOperator = pApp->GetFileOperator();
	UpdateImages();

	//Update the Data Modification controls
	((CButton*)GetDlgItem(IDC_APPLY_CONSTANT))->SetCheck( pApp->GetIsApplyConst() );
	if( !pApp->GetConstValue().IsEmpty() )SetDlgItemText(IDC_CONST_VALUE, pApp->GetConstValue() );

	((CButton*)GetDlgItem(IDC_FILE_COMBINE))->SetCheck( pApp->GetIsCombineFile() );
	if( !pApp->GetFilename().IsEmpty() )SetDlgItemText(IDC_FILE_NAME, pApp->GetFilename() );
	m_Filename = pApp->GetFilename();
	m_FilePath = pApp->GetFilePath();

	OnFileCombine();
	OnApplyConstant();
	

	UpdateData();
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CModifyData::OnFileCombine() 
{
	if( ((CButton*)GetDlgItem(IDC_FILE_COMBINE))->GetCheck() )EnableFileProps(true);
	else EnableFileProps(false);	
}

void CModifyData::OnApplyConstant() 
{
	if( ((CButton*)GetDlgItem(IDC_APPLY_CONSTANT))->GetCheck() )EnableConstProps(true);
	else EnableConstProps(false);
	
}
void CModifyData::EnableFileProps(bool bEnable)
{
		GetDlgItem(IDC_FILE_OPERATOR)->EnableWindow(bEnable);
		GetDlgItem(IDC_FILE_BROWSE)->EnableWindow(bEnable);
		GetDlgItem(IDC_FILE_NAME)->EnableWindow(bEnable);
}
void CModifyData::EnableConstProps(bool bEnable)
{
		GetDlgItem(IDC_APPLY_OPERATOR)->EnableWindow(bEnable);
		GetDlgItem(IDC_CONST_VALUE)->EnableWindow(bEnable);

}

void CModifyData::OnFileBrowse() 
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
}

void CModifyData::OnOK() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	//Save the current data modification settings
	CString tmp;

	if(m_bSaveSettings)
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
	
	CDialog::OnOK();
}

void CModifyData::OnDestroy() 
{

	CDialog::OnDestroy();
}

void CModifyData::UpdateImages()
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

void CModifyData::OnApplyOperator() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	if( m_iConstOperator < 3)m_iConstOperator++; else m_iConstOperator = 0;
	UpdateImages();
}	

void CModifyData::OnFileOperator() 
{
	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);
	//Don't allow divide for now...
	if( m_iFileOperator < 2)m_iFileOperator++; else m_iFileOperator = 0;
	UpdateImages();	
}
