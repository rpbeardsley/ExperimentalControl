//***************************************************************************************
//Eclipse.cpp : implementation file
//
//	Functions: For details on functions in this file see Eclipse.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"

#include "MainFrm.h"
#include "EclipseDoc.h"
#include "AverageView.h"
#include "TrendView.h"
#include "Splash.h"
#include "process.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEclipseApp

BEGIN_MESSAGE_MAP(CEclipseApp, CWinApp)
	//{{AFX_MSG_MAP(CEclipseApp)
	ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
	ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)
	// Standard print setup command
	ON_COMMAND(ID_FILE_PRINT_SETUP, CWinApp::OnFilePrintSetup)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CEclipseApp construction

CEclipseApp::CEclipseApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CEclipseApp object

CEclipseApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CEclipseApp initialization

BOOL CEclipseApp::InitInstance()
{
	// CG: The following block was added by the Splash Screen component.
/*\
	{
\
		CCommandLineInfo cmdInfo;
\
		ParseCommandLine(cmdInfo);
\

\
		CSplashWnd::EnableSplashScreen(cmdInfo.m_bShowSplash);
\
	}*/
	AfxEnableControlContainer();

	// Initialize OLE libraries
	if (!AfxOleInit())
	{
		AfxMessageBox("Could not start initialize OLE");
		return FALSE;
	}

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	// Change the registry key under which our settings are stored.
	// You should modify this string to be something appropriate
	// such as the name of your company or organization.
	SetRegistryKey(_T("SIGNAL RECOVERY"));

	LoadStdProfileSettings();  // Load standard INI file options (including MRU)

	m_nCmdShow = SW_SHOWMAXIMIZED;

	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views.

	CSingleDocTemplate* pDocAverageTemplate;
	pDocAverageTemplate = new CSingleDocTemplate(
		IDR_MAINFRAME,
		RUNTIME_CLASS(CEclipseDoc),
		RUNTIME_CLASS(CMainFrame),       // main SDI Average frame window
		RUNTIME_CLASS(CAverageView));
	AddDocTemplate(pDocAverageTemplate);

	CSingleDocTemplate* pDocTrendTemplate;
	pDocTrendTemplate = new CSingleDocTemplate(
		IDR_TRENDVIEW,
		RUNTIME_CLASS(CEclipseDoc),
		RUNTIME_CLASS(CMainFrame),       // main SDI Trend frame window
		RUNTIME_CLASS(CTrendView));
	AddDocTemplate(pDocTrendTemplate);

	// Parse command line for standard shell commands, DDE, file open
	CCommandLineInfo cmdInfo;
	ParseCommandLine(cmdInfo);

	// Dispatch commands specified on the command line
	if (!ProcessShellCommand(cmdInfo))
		return FALSE;
// determine OS
	OSVERSIONINFO osvi;
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
	GetVersionEx (&osvi);

	// determine windows system folder
	TCHAR  infoBuf[MAX_PATH];
	UINT uSize = MAX_PATH; 
	
	GetSystemDirectory(infoBuf,uSize);
	CString sSysDirectory = infoBuf;
	CString sDrvDirectory = sSysDirectory + "\\drivers";
	
	if (osvi.dwPlatformId >= 2)
	{
		//NT 3.51 or later. This code tested only on XP
		// now check if windriver is registered
	
		HKEY hKey = HKEY_LOCAL_MACHINE;
		HKEY hkResult;
		LPTSTR lpClass = "";
		LPCTSTR lpRootKey = LPCTSTR("SYSTEM\\CurrentControlSet\\Control\\Class\\{C671678C-82C1-43F3-D700-0049433E9A4B}\\0000");
		DWORD dwDisposition;

		//first check if key exists. If it does dwDisposition = REG_OPENED_EXISTING_KEY
		RegCreateKeyEx(hKey,lpRootKey,0,lpClass,REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,NULL,&hkResult,&dwDisposition);

		if (dwDisposition == REG_CREATED_NEW_KEY)
		// key did not exist - proceed to register
		{
			RegDeleteKey(hKey,lpRootKey);
			RegCloseKey(hKey);
			CString sArgs = "/c " + sDrvDirectory + "\\wdreg.exe -inf " + sDrvDirectory + "\\windrvr6.inf install";	
			char *cmdvar;
			cmdvar = getenv("COMSPEC");
			int nProgStatus = 0;
			nProgStatus = _spawnl(_P_WAIT, cmdvar, sArgs, NULL);
			if (nProgStatus != 0)
			{
				AfxMessageBox(CString("Could not register Windriver6.\n\rPlease contact SIGNAL RECOVERY for assistance."), MB_OK|MB_ICONEXCLAMATION , NULL);
				return FALSE;
			}
		}
	}
	else
	{
		//ME or earlier. This code tested only on 98SE
		// now check if windriver is registered
	
		HKEY hKey = HKEY_LOCAL_MACHINE;
		HKEY hkResult;
		LPTSTR lpClass = "";
		LPCTSTR lpRootKey = LPCTSTR("SYSTEM\\CurrentControlSet\\Services\\Class\\JUNGO\\0000");
		DWORD dwDisposition;

		//first check if key exists. If it does dwDisposition = REG_OPENED_EXISTING_KEY
		RegCreateKeyEx(hKey,lpRootKey,0,lpClass,REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,NULL,&hkResult,&dwDisposition);

		if (dwDisposition == REG_CREATED_NEW_KEY)
		// key did not exist - proceed to register
		{
			RegDeleteKey(hKey,lpRootKey);
			RegCloseKey(hKey);
			char *cmdvar;
			cmdvar = getenv("COMSPEC");
			char *args[1];
			int nProgStatus = 0;
			args[0] = "command.com";
			CString sArgs = "/c " + sDrvDirectory + "\\wdreg16.exe -inf " + sDrvDirectory + "\\windrvr6.inf install";
			nProgStatus = _spawnl(_P_WAIT, cmdvar, args[0], sArgs, NULL);
			switch(nProgStatus)
			{
				case 0:
					AfxMessageBox(CString("Windriver6 installation completed.\n\rPlease re-start the Eclipse or ICS program to continue."), MB_OK|MB_ICONEXCLAMATION , NULL);
					return FALSE;
					break;			
			
				case 2:
					AfxMessageBox(CString("Windriver6 installation completed.\n\rPlease reboot computer to complete setup."), MB_OK|MB_ICONEXCLAMATION , NULL);
					return FALSE;
					break;			
			
				default:
					AfxMessageBox(CString("Could not register Windriver6.\n\rPlease contact SIGNAL RECOVERY for assistance."), MB_OK|MB_ICONEXCLAMATION , NULL);
					return FALSE;
			}
			
		}
	}
	// The one and only window has been initialized, so show and update it.
	m_pMainWnd->ShowWindow(SW_SHOW);
	m_pMainWnd->UpdateWindow();

	CMainFrame* pWnd = (CMainFrame*)m_pMainWnd;
	ASSERT(pWnd);

	//Get pointers to the 2 views so they can be accessed later...
	pWnd->SetActiveView((CView*)pWnd->GetSplitter()->GetPane(0,0));
	pWnd->SetTrendView( ((CTrendView*)pWnd->GetActiveView()) );

	pWnd->SetActiveView((CView*)pWnd->GetSplitter()->GetPane(1,0));
	pWnd->SetAverageView( ((CAverageView*)pWnd->GetActiveView()) );

	SetMode( GetLastMode() );

	m_iRealTime = GetLastRealTime();

	m_ppLastGraphPageInitialized = NULL;

	return TRUE;
}
int CEclipseApp::ExitInstance() 
{
	//Remember so when started next time, the proper mode is used
	SetLastMode(m_iMode);
	
	return CWinApp::ExitInstance();
}


CString CEclipseApp::GetDataDir()
{
	return (GetProfileString(_T("Settings"),_T("DataDir"),"\0"));
}
void CEclipseApp::SetDataDir(CString Data)
{
	WriteProfileString(_T("Settings"),_T("DataDir"),Data);
}

CString CEclipseApp::GetLastCalPath()
{
	return (GetProfileString(_T("Settings"),_T("LastCalPath"),"\0"));
}
void CEclipseApp::SetLastCalPath(CString Data)
{
	WriteProfileString(_T("Settings"),_T("LastCalPath"),Data);
}

CString CEclipseApp::GetLastOpenPath()
{
	return (GetProfileString(_T("Settings"),_T("LastOpenPath"),"\0"));
}
void CEclipseApp::SetLastOpenPath(CString Data)
{
	WriteProfileString(_T("Settings"),_T("LastOpenPath"),Data);
}


//Per protocol calibration file paths --------------------------------------------------------
CString CEclipseApp::GetProt0CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot0CalPath"), "\0"));
}
void CEclipseApp::SetProt0CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot0CalPath"), Path);
}

CString CEclipseApp::GetProt1CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot1CalPath"), "\0"));
}
void CEclipseApp::SetProt1CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot1CalPath"), Path);
}

CString CEclipseApp::GetProt2CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot2CalPath"), "\0"));
}
void CEclipseApp::SetProt2CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot2CalPath"), Path);
}

CString CEclipseApp::GetProt3CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot3CalPath"), "\0"));
}
void CEclipseApp::SetProt3CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot3CalPath"), Path);
}

CString CEclipseApp::GetProt4CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot4CalPath"), "\0"));
}
void CEclipseApp::SetProt4CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot4CalPath"), Path);
}

CString CEclipseApp::GetProt5CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot5CalPath"), "\0"));
}
void CEclipseApp::SetProt5CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot5CalPath"), Path);
}

CString CEclipseApp::GetProt6CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot6CalPath"), "\0"));
}
void CEclipseApp::SetProt6CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot6CalPath"), Path);
}

CString CEclipseApp::GetProt7CalPath()
{
	return (GetProfileString(_T("Settings"), _T("Prot7CalPath"), "\0"));
}
void CEclipseApp::SetProt7CalPath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("Prot7CalPath"), Path);
}


int CEclipseApp::GetCalState()
{
	return GetProfileInt(_T("Settings"), _T("CalState"), 0);
}

void CEclipseApp::SetCalState(int iState)
{
	WriteProfileInt( _T("Settings"), _T("CalState"), iState );	
}


int CEclipseApp::GetLastMode()
{
	return GetProfileInt(_T("Settings"), _T("LastMode"), 0);
}

void CEclipseApp::SetLastMode(int iMode)
{
	WriteProfileInt( _T("Settings"), _T("LastMode"), iMode );	
}

int CEclipseApp::GetLastRealTime()
{
	return GetProfileInt(_T("Settings"), _T("RealTime"), 0);
}

void CEclipseApp::SetLastRealTime(int iRealTime)
{
	WriteProfileInt( _T("Settings"), _T("RealTime"), iRealTime );	
}



int CEclipseApp::GetCurrentViewProtocol()
{
	return GetProfileInt(_T("Settings"), _T("CurrentViewProtocol"), 0);
}

void CEclipseApp::SetCurrentViewProtocol(int iProtocol)
{
	WriteProfileInt( _T("Settings"), _T("CurrentViewProtocol"), iProtocol );	
}

CString CEclipseApp::GetFilename()
{
	return (GetProfileString(_T("Settings"), _T("FileName"), "\0"));
}
void CEclipseApp::SetFilename(CString Name)
{
	WriteProfileString(_T("Settings"), _T("FileName"), Name );
}

CString CEclipseApp::GetFilePath()
{
	return (GetProfileString(_T("Settings"), _T("FilePath"), "\0"));
}
void CEclipseApp::SetFilePath(CString Path)
{
	WriteProfileString(_T("Settings"), _T("FilePath"), Path );
}



int CEclipseApp::GetFileOperator()
{
	return GetProfileInt(_T("Settings"), _T("FileOper"), 0);
}

void CEclipseApp::SetFileOperator(int iOper)
{
	WriteProfileInt( _T("Settings"), _T("FileOper"), iOper );	
}


int CEclipseApp::GetIsCombineFile()
{
	return GetProfileInt(_T("Settings"), _T("CombineFile"), 0);
}

void CEclipseApp::SetIsCombineFile(int iCombine)
{
	WriteProfileInt( _T("Settings"), _T("CombineFile"), iCombine );	
}



CString CEclipseApp::GetConstValue()
{
	return (GetProfileString(_T("Settings"), _T("ConstValue"), "\0"));
}
void CEclipseApp::SetConstValue(CString Value)
{
	WriteProfileString(_T("Settings"), _T("ConstValue"), Value );
}

int CEclipseApp::GetConstOperator()
{
	return GetProfileInt(_T("Settings"), _T("ConstOper"), 0);
}

void CEclipseApp::SetConstOperator(int iOper)
{
	WriteProfileInt( _T("Settings"), _T("ConstOper"), iOper );	
}

int CEclipseApp::GetIsApplyConst()
{
	return GetProfileInt(_T("Settings"), _T("ApplyConst"), 0);
}

void CEclipseApp::SetIsApplyConst(int iApply)
{
	WriteProfileInt( _T("Settings"), _T("ApplyConst"), iApply );	
}



CString CEclipseApp::GetAnalysisMeasurement1Name()
{
	return GetProfileString(_T("Settings"), _T("AnaMeasurement1Name"), "None");
}

void CEclipseApp::SetAnalysisMeasurement1Name(CString strName)
{
	WriteProfileString( _T("Settings"), _T("AnaMeasurement1Name"), strName );	
}

CString CEclipseApp::GetAnalysisMeasurement2Name()
{
	return GetProfileString(_T("Settings"), _T("AnaMeasurement2Name"), "None");
}

void CEclipseApp::SetAnalysisMeasurement2Name(CString strName)
{
	WriteProfileString( _T("Settings"), _T("AnaMeasurement2Name"), strName );	
}

CString CEclipseApp::GetAnalysisMeasurement3Name()
{
	return GetProfileString(_T("Settings"), _T("AnaMeasurement3Name"), "None");
}

void CEclipseApp::SetAnalysisMeasurement3Name(CString strName)
{
	WriteProfileString( _T("Settings"), _T("AnaMeasurement3Name"), strName );	
}

CString CEclipseApp::GetAnalysisMeasurement4Name()
{
	return GetProfileString(_T("Settings"), _T("AnaMeasurement4Name"), "None");
}

void CEclipseApp::SetAnalysisMeasurement4Name(CString strName)
{
	WriteProfileString( _T("Settings"), _T("AnaMeasurement4Name"), strName );	
}


int CEclipseApp::GetProt0PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot0PPR"), 0);
}

void CEclipseApp::SetProt0PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot0PPR"), iPPR );	
}
int CEclipseApp::GetProt1PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot1PPR"), 0);
}

void CEclipseApp::SetProt1PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot1PPR"), iPPR );	
}
int CEclipseApp::GetProt2PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot2PPR"), 0);
}
void CEclipseApp::SetProt2PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot2PPR"), iPPR );	
}

void CEclipseApp::SetProt3PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot3PPR"), iPPR );	
}
int CEclipseApp::GetProt3PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot3PPR"), 0);
}

void CEclipseApp::SetProt4PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot4PPR"), iPPR );	
}
int CEclipseApp::GetProt4PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot4PPR"), 0);
}

void CEclipseApp::SetProt5PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot5PPR"), iPPR );	
}
int CEclipseApp::GetProt5PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot5PPR"), 0);
}

void CEclipseApp::SetProt6PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot6PPR"), iPPR );	
}
int CEclipseApp::GetProt6PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot6PPR"), 0);
}

void CEclipseApp::SetProt7PPR(int iPPR)
{
	WriteProfileInt( _T("Settings"), _T("Prot7PPR"), iPPR );	
}
int CEclipseApp::GetProt7PPR()
{
	return GetProfileInt(_T("Settings"), _T("Prot7PPR"), 0);
}

//Remember the "preset" settings
//First the ... do we use this variable
int CEclipseApp::GetIsMaxTimeUsed()
{
	return GetProfileInt(_T("Settings"), _T("UseMaxTime"), 0);
}

void CEclipseApp::SetIsMaxTimeUsed(int iUse)
{
	WriteProfileInt( _T("Settings"), _T("UseMaxTime"), iUse );	
}

int CEclipseApp::GetIsMaxNumberUsed()
{
	return GetProfileInt(_T("Settings"), _T("UseMaxNumber"), 0);
}

void CEclipseApp::SetIsMaxNumberUsed(int iUse)
{
	WriteProfileInt( _T("Settings"), _T("UseMaxNumber"), iUse );	
}
//Next the ... whats the value
int CEclipseApp::GetMaxNumber()
{
	return GetProfileInt(_T("Settings"), _T("MaxNumber"), 0);
}

void CEclipseApp::SetMaxNumber(int iNum)
{
	WriteProfileInt( _T("Settings"), _T("MaxNumber"), iNum );	
}

int CEclipseApp::GetMaxTime()
{
	return GetProfileInt(_T("Settings"), _T("MaxTime"), 0);
}

void CEclipseApp::SetMaxTime(int iTime)
{
	WriteProfileInt( _T("Settings"), _T("MaxTime"), iTime );	
}


void CEclipseApp::SetMode(int iMode)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	m_iMode = iMode;

	//First get rid of any overlay information
	pWnd->GetAverageView()->RemoveAllOverlays();

	//Clear out the main series' of data
	pWnd->GetTrendView()->GetGraph()->ClearData(1);
	pWnd->GetAverageView()->GetGraph()->ClearData(1);

	//Clear out the FFT window if it is up
	if(pWnd->m_bViewingFFT)
	{
		pWnd->GetAverageView()->GetFFTDlg()->Clear();
	}


	//Make all changes to User interface here (except Menus)
	if(m_iMode == TREND)
	{
		pWnd->m_bSavable = false;
		
		//Make mode changes to the Acquisition Tab
		ASSERT(pWnd->GetAcqTab());
		((CButton*)pWnd->GetAcqTab()->GetDlgItem(IDC_MODE_AVERAGE))->SetCheck(FALSE);
		((CButton*)pWnd->GetAcqTab()->GetDlgItem(IDC_MODE_TREND))->SetCheck(TRUE);
		
		//Adjust the Splitter
		pWnd->GetSplitter()->SetRowInfo( 0, 180, 0 );
		pWnd->GetSplitter()->RecalcLayout();

		// activate the input view
		pWnd->SetActiveView((CView*)pWnd->GetSplitter()->GetPane(0,0));

		if(!GetIsInstrumentPresent())
		{
			ASSERT(pWnd->GetInfo());
			pWnd->GetInfo()->GetDlgItem(IDC_INFO_DATADIR)->EnableWindow(FALSE);
			pWnd->GetInfo()->GetDlgItem(IDC_INFO_BROWSE)->EnableWindow(FALSE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_ACQ_START)->EnableWindow(FALSE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_ACQ_STOP)->EnableWindow(FALSE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_INST_PROPS)->EnableWindow(FALSE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_REALTIME)->EnableWindow(FALSE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_DISPLAY)->EnableWindow(FALSE);

		}
		else
		{
			ASSERT(pWnd->GetInfo());
			pWnd->GetInfo()->GetDlgItem(IDC_INFO_DATADIR)->EnableWindow(TRUE);
			pWnd->GetInfo()->GetDlgItem(IDC_INFO_BROWSE)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_ACQ_START)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_ACQ_STOP)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_INST_PROPS)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_REALTIME)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_DISPLAY)->EnableWindow(TRUE);
		}
	}
	else //Average Only mode
	{
		pWnd->m_bSavable = false;

		//Make mode changes to the Acquisition Tab
		ASSERT(pWnd->GetAcqTab());
		((CButton*)pWnd->GetAcqTab()->GetDlgItem(IDC_MODE_TREND))->SetCheck(FALSE);
		((CButton*)pWnd->GetAcqTab()->GetDlgItem(IDC_MODE_AVERAGE))->SetCheck(TRUE);

		//Adjust the Splitter
		pWnd->GetSplitter()->SetRowInfo( 0, 0, 0 );
		pWnd->GetSplitter()->RecalcLayout();

		// activate the input view
		pWnd->SetActiveView((CView*)pWnd->GetSplitter()->GetPane(1,0));
		
		ASSERT(pWnd->GetInfo());
		pWnd->GetInfo()->GetDlgItem(IDC_INFO_DATADIR)->EnableWindow(FALSE);
		pWnd->GetInfo()->GetDlgItem(IDC_INFO_BROWSE)->EnableWindow(FALSE);
		pWnd->GetAcqTab()->GetDlgItem(IDC_REALTIME)->EnableWindow(FALSE);
		pWnd->GetAcqTab()->GetDlgItem(IDC_DISPLAY)->EnableWindow(FALSE);

		if(GetIsInstrumentPresent())
		{
			pWnd->GetAcqTab()->GetDlgItem(IDC_ACQ_START)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_ACQ_STOP)->EnableWindow(TRUE);
			pWnd->GetAcqTab()->GetDlgItem(IDC_INST_PROPS)->EnableWindow(TRUE);
			
		}
		
	}

}

CString CEclipseApp::GetVersion()
{
    CString str;
    DWORD dwVerHnd;             // not used but required
    DWORD dwVerInfoSize;        // retrieved size of VS_VERSION_INFO struct
    unsigned uVersionLen;       // returned length of requested string
    char *pVersion;             // returned pointer to requested string
    char szFullPath[_MAX_PATH];

	char szDefVer[]={"0.00"};
	char szDefAppName[]={"Eclipse"};

	CString AppPath = m_pszHelpFilePath;

	int iIdx = AppPath.ReverseFind('.');

	AppPath = AppPath.Left(iIdx);

	AppPath += ".EXE";

	strcpy(szFullPath, AppPath);

	str = szDefVer;
    
    dwVerInfoSize = ::GetFileVersionInfoSize(szFullPath, &dwVerHnd);
    if(dwVerInfoSize) 
	{
        char *pcVerInfo = new char[dwVerInfoSize];

        ::GetFileVersionInfo(szFullPath, dwVerHnd, dwVerInfoSize, pcVerInfo);
        // The magic number below represents the language and character set that
        // match the string values for which we are looking.040904E4 is a common
        // because it means: US English, Windows MultiLingual characterset.
        // 040904B0 is common since VC++ 5 uses it by default:
        //
        // 04------        = SUBLANG_ENGLISH_USA
        // --09----        = LANG_ENGLISH
        // ----04E4 = 1252 = Codepage for Windows Multilingual
        // ----04B0 = ???? = Codepage for Unicode (defult in VC++ 5)
 
        uVersionLen = 0;                // in case VerQueryValue() fails
        VerQueryValue(pcVerInfo, "\\StringFileInfo\\040904B0\\FileVersion", (void **)&pVersion, &uVersionLen);

        // If we couldn't find the FileVersion in Unicode try the Multilngual version
        if((pVersion == NULL) || (uVersionLen <= 0))
		    VerQueryValue(pcVerInfo, "\\StringFileInfo\\040904E4\\FileVersion", (void **)&pVersion, &uVersionLen);
            
        if((pVersion != NULL) && (uVersionLen > 0))str = pVersion;
    
        delete pcVerInfo;
    }

    return str;
}









/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

// App command to run the dialog
void CEclipseApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}
BOOL CAboutDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString tmp;

	tmp.Format(_T("Eclipse Application Version %s"), pApp->GetVersion());
	SetDlgItemText(IDC_FASTFLIGHT_VER, tmp);

	//Get version info from Active GSX
	tmp.Format(_T("GSX Version %1.2f"), pWnd->GetAverageView()->GetGraph()->GetVersion());

	//Display version		 
	SetDlgItemText(IDC_GSXVERSION, tmp);

	try
	{
		tmp.Format(_T("ICS Version %1.2f"), pWnd->GetICS()->GetICSVersion());
		SetDlgItemText(IDC_ICSVERSION, tmp);

		tmp.Format(_T("%s"), pWnd->GetICS()->GetInstVersion());
		SetDlgItemText(IDC_FIRMWARE_VERSION, tmp);
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}

	int iIdx = 0;
	CString sMeasureVerString;

	sMeasureVerString = pWnd->GetAnalysisTab()->GetMeasurementVersions( iIdx );

	CListBox* pList = (CListBox*)GetDlgItem(IDC_LIST_MEASURMENTS);
	ASSERT(pList);

	while( !sMeasureVerString.IsEmpty() )
	{
		
		pList->AddString( sMeasureVerString );

		iIdx++; 
		sMeasureVerString = pWnd->GetAnalysisTab()->GetMeasurementVersions( iIdx );
	}
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
/////////////////////////////////////////////////////////////////////////////
// CEclipseApp commands



BOOL CEclipseApp::PreTranslateMessage(MSG* pMsg)
{
	// CG: The following lines were added by the Splash Screen component.
	if (CSplashWnd::PreTranslateAppMessage(pMsg))
		return TRUE;

	return CWinApp::PreTranslateMessage(pMsg);
}
