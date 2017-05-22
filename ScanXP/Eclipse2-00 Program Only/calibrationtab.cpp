// CalibrationTab.cpp : implementation file
//***************************************************************************************
//CalibrationTab.cpp : implementation file
//
//	Functions: For details on functions in this file see CalibrationTab.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Mainfrm.h"
#include "Eclipse.h"
#include "CalibrationTab.h"
#include "CalibrationView.h"
#include "Calibration.h"
#include "AddCalItem.h"
#include "AverageView.h"
#include "IO.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCalibrationTab dialog


CCalibrationTab::CCalibrationTab(CWnd* pParent /*=NULL*/)
	: CDialog(CCalibrationTab::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCalibrationTab)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}
//Destructor
CCalibrationTab::~CCalibrationTab()
{

}

void CCalibrationTab::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCalibrationTab)
	DDX_Control(pDX, IDC_CALLIBRARY_LIST, m_CalLibList);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCalibrationTab, CDialog)
	//{{AFX_MSG_MAP(CCalibrationTab)
	ON_BN_CLICKED(IDC_CAL_VIEW, OnCalView)
	ON_BN_CLICKED(IDC_CALFILE_BROWSE, OnCalfileBrowse)
	ON_BN_CLICKED(IDC_ADD_CALVALUE, OnAddCalItem)
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDC_CAL_SAVE, OnCalSave)
	ON_BN_CLICKED(IDC_CAL_CLEAR, OnCalClear)
	ON_NOTIFY(NM_RCLICK, IDC_CALLIBRARY_LIST, OnRclickCallibraryList)
	ON_CBN_SELCHANGE(IDC_CAL_TYPE, OnSelchangeCalType)
	//}}AFX_MSG_MAP

	ON_COMMAND(IDM_DELETE, OnRightDelete)
	ON_COMMAND(IDM_UPDATE, OnRightUpdate)

END_MESSAGE_MAP()

	

/////////////////////////////////////////////////////////////////////////////
// CCalibrationTab message handlers

void CCalibrationTab::OnCalView() 
{
	CCalibrationView vw(this, &m_CalLibList, &m_Cal );
	vw.DoModal();
}

void CCalibrationTab::OnCalfileBrowse() 
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

	CFileDialog OpenFile(TRUE,_T("CAL"),_T("*.CAL"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_FILEMUSTEXIST | OFN_EXPLORER, szFilter ,this );

	//Change the window caption
	OpenFile.m_ofn.lpstrTitle=_T("Retrieve a Eclipse Calibration from disk");
	OpenFile.m_ofn.lpstrInitialDir = DirPath;

	//Start up the modal file dialog
	if(OpenFile.DoModal()==IDOK)
	{
		//Clean everything up
		OnCalClear();

		SetDlgItemText(IDC_CAL_FILE, OpenFile.GetFileTitle() );

		//Remember this as last cal path
		pApp->SetLastCalPath(OpenFile.GetPathName());

		//load the calibration file
		CFile CalFile(OpenFile.GetPathName(), CFile::modeRead );

		CArchive ar(&CalFile, CArchive::load);
		m_Cal.Serialize(ar);
		//ar.Flush();
		CalFile.Close();

		//Set units text
		SetDlgItemText(IDC_CAL_UNITS, m_Cal.GetUnitsText() );

		//Set calibration type
		CComboBox* pCalType = (CComboBox*)GetDlgItem(IDC_CAL_TYPE);
		ASSERT(pCalType);

		pCalType->SetCurSel( m_Cal.GetCalType() );


		if(m_Cal.GetNumOfValues() > 0 && m_Cal.GetNumOfValues() < 64)
		{
			for(int n=0;n < m_Cal.GetNumOfValues();n++)
			{
				CString NewValue;
				NewValue.Format("%f", m_Cal.GetMarkerInfo(n)->m_dCalValue);

				int idx = m_CalLibList.InsertItem(m_CalLibList.GetItemCount(), NewValue);//m_CalLibList.AddString( NewValue );
				
				NewValue.Format("%f", m_Cal.GetMarkerInfo(n)->m_dCentroidTime);
				m_CalLibList.SetItemText(idx, 1, NewValue);
				//Create a new caliteminfo class and fill it with current information then place it into the correct
				//list box item.  This will be used later to save to file and display in the "View".
				CMkrInfo* pMkr = new CMkrInfo;
				
				pMkr->m_dCalValue = m_Cal.GetMarkerInfo(n)->m_dCalValue;
				pMkr->m_dCentroidTime = m_Cal.GetMarkerInfo(n)->m_dCentroidTime;
				pMkr->m_dStartMkrTime = m_Cal.GetMarkerInfo(n)->m_dStartMkrTime;
				pMkr->m_dEndMkrTime =m_Cal.GetMarkerInfo(n)-> m_dEndMkrTime;

				m_CalLibList.SetItemData(idx, (DWORD)pMkr);

			}
		}

		int idx = m_CalLibList.GetItemCount();
		int iCalType = m_Cal.GetCalType();

		if(iCalType == 0 && idx >= 2)
		{
			//Calculate calibration so far
			OnCalApply();
		}
		else if(iCalType == 1 && idx >= 3)
		{
			OnCalApply();
		}
		else if(iCalType == 2 && idx >= 4)
		{
			OnCalApply();
		}

		EnableItems(TRUE);
	}

	UpdateBasedOnItems();
}

void CCalibrationTab::OnAddCalItem() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CString Tmp;
	CString NewValue;

	GetDlgItemText(IDC_MARKER_CENTROID, Tmp);

	CAddCalItem addCal(this, Tmp, &NewValue);

	int iCalType = ((CComboBox*)GetDlgItem(IDC_CAL_TYPE))->GetCurSel();

	if(addCal.DoModal() == IDOK)
	{
		
		int idx = m_CalLibList.InsertItem(m_CalLibList.GetItemCount(), NewValue);//m_CalLibList.AddString( NewValue );
		
		if(idx < 64)
		{
			Tmp.Format("%f", m_dCalCentroid);
			m_CalLibList.SetItemText(idx, 1, Tmp);
			//Create a new caliteminfo class and fill it with current information then place it into the correct
			//list box item.  This will be used later to save to file and display in the "View".
			CMkrInfo* pMkr = new CMkrInfo;
			
			pMkr->m_dCalValue = atof(NewValue);
			pMkr->m_dCentroidTime = m_dCalCentroid;
			pMkr->m_dStartMkrTime = m_dCalStartMarker;
			pMkr->m_dEndMkrTime = m_dCalEndMarker;

			m_CalLibList.SetItemData(idx, (DWORD)pMkr);

			if(pWnd->GetAverageView()->GetAverageXData()->vt == (VT_ARRAY | VT_R8) )
			{
				long ix = 1;
				SafeArrayGetElement(pWnd->GetAverageView()->GetAverageXData()->parray, &ix, &GetCalObject()->m_dOrgMinValue);
						
				ix = pWnd->GetAverageView()->GetAverageXData()->parray->rgsabound->cElements;
				SafeArrayGetElement(pWnd->GetAverageView()->GetAverageXData()->parray, &ix, &GetCalObject()->m_dOrgMaxValue);
			}

			if(iCalType == 0 && idx >= 2)
			{
				//Calculate calibration so far
				OnCalApply();
			}
			else if(iCalType == 1 && idx >= 3)
			{
				OnCalApply();
			}
			else if(iCalType == 2 && idx >= 4)
			{
				OnCalApply();
			}

			GetDlgItem(IDC_CAL_SAVE)->EnableWindow(TRUE);
		}
		else 
		{
			m_CalLibList.DeleteItem(idx);
			AfxMessageBox(_T("Maximum of 64 Calibration values has been reached."));
		}
	}

	UpdateBasedOnItems();

}

void CCalibrationTab::DeleteCalItem(int iItemToDelete)
{
	//if iItemToDelete is -1 then delete all items
	int iNumItems = m_CalLibList.GetItemCount();
	int iCalType = ((CComboBox*)GetDlgItem(IDC_CAL_TYPE))->GetCurSel();

	if(iItemToDelete == -1)
	{
		//Loop thru item list to delete the "Item data"
		//0-based array so subtract 1
		for(int n = iNumItems - 1;n >= 0;n--)
		{
			//Clean up
			delete (CMkrInfo*)m_CalLibList.GetItemData(n);
			m_CalLibList.DeleteItem(n);
		}
	}
	else
	{
		//Just delete the items chosen!
		int iSel, iSelectedItems = m_CalLibList.GetSelectedCount();

		CString Message;
		if(iSelectedItems < 1)return;

		if(iSelectedItems == 1)Message = _T("Are you sure you want to delete the selected record?");
		else Message.Format( _T("Are you sure you want to delete the %d selected records?"), iSelectedItems);

		if( AfxMessageBox(Message,MB_YESNO | MB_ICONQUESTION) == IDYES)
		{
			for(int n=0;n < iSelectedItems;n++)
			{
				iSel = m_CalLibList.GetNextItem( -1, LVNI_SELECTED );

				delete (CMkrInfo*)m_CalLibList.GetItemData(iSel);
				m_CalLibList.DeleteItem(iSel);
			}

			int idx = m_CalLibList.GetItemCount();

			if(iCalType == 0 && idx >= 2)
			{
				//Calculate calibration so far
				OnCalApply();
			}
			else if(iCalType == 1 && idx >= 3)
			{
				OnCalApply();
			}
			else if(iCalType == 2 && idx >= 4)
			{
				OnCalApply();
			}
		}
	}

	UpdateBasedOnItems();

}



void CCalibrationTab::OnDestroy() 
{
	//Make sure we have no items left hanging, before we leave
	DeleteCalItem(-1);

	CDialog::OnDestroy();
	
}

BOOL CCalibrationTab::OnInitDialog() 
{
	CDialog::OnInitDialog();

	m_CalLibList.InsertColumn(0,_T("Value"),LVCFMT_LEFT, 45 );
	m_CalLibList.InsertColumn(1,_T("Centroid"),LVCFMT_LEFT, 55 );
	
	//Set some initial values
	CComboBox* pCalType = (CComboBox*)GetDlgItem(IDC_CAL_TYPE);
	ASSERT(pCalType);

	pCalType->SetCurSel(1);

	CEdit* pUnits = (CEdit*)GetDlgItem(IDC_CAL_UNITS);
	ASSERT(pUnits);

	pUnits->LimitText(5);
	pUnits->SetWindowText(_T("user"));

	CEdit* pFile = (CEdit*)GetDlgItem(IDC_CAL_FILE);
	ASSERT(pFile);
	
	pFile->SetWindowText(_T("No file specified"));

	EnableItems(FALSE);


	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}



void CCalibrationTab::OnCalSave() 
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

	CFileDialog OpenFile(FALSE,_T("CAL"),_T("*.CAL"),OFN_HIDEREADONLY | OFN_PATHMUSTEXIST | 
								  OFN_EXPLORER, szFilter ,this );

	//Change the window caption
	OpenFile.m_ofn.lpstrTitle=_T("Save a Eclipse Calibration to disk");
	OpenFile.m_ofn.lpstrInitialDir = DirPath;

	//Start up the modal file dialog
	if(OpenFile.DoModal()==IDOK)
	{
		SetDlgItemText(IDC_CAL_FILE, OpenFile.GetFileTitle() );

		OnCalApply();//Make sure every thing is up-to-date before saving!

		//save the calibration file
		CFile CalFile(OpenFile.GetPathName(), CFile::modeCreate | CFile::modeWrite );
		CArchive ar(&CalFile, CArchive::store);
		m_Cal.Serialize(ar);
		ar.Flush();
		CalFile.Close();
	}	
}

void CCalibrationTab::OnCalClear() 
{
	//Clear out the calibration
	DeleteCalItem(-1);

	//Set some initial values
	CComboBox* pCalType = (CComboBox*)GetDlgItem(IDC_CAL_TYPE);
	ASSERT(pCalType);

	pCalType->SetCurSel(1);

	CEdit* pUnits = (CEdit*)GetDlgItem(IDC_CAL_UNITS);
	ASSERT(pUnits);

	pUnits->LimitText(5);
	pUnits->SetWindowText(_T("user"));

	CEdit* pFile = (CEdit*)GetDlgItem(IDC_CAL_FILE);
	ASSERT(pFile);
	
	pFile->SetWindowText(_T("No file specified"));

	EnableItems(TRUE);
	UpdateBasedOnItems();

	GetDlgItem(IDC_CAL_SAVE)->EnableWindow(FALSE);
}

void CCalibrationTab::OnCalApply() 
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString Text;

	ECalType eType;

	CComboBox* pCalType = (CComboBox*)GetDlgItem(IDC_CAL_TYPE);
	ASSERT(pCalType);

	eType = (ECalType)pCalType->GetCurSel();//Will need the Cal Type
	
	int iNumOfValues = m_CalLibList.GetItemCount(); //Number of calibration values

	CMkrInfo* pMkrInfo = new CMkrInfo[iNumOfValues];

	//Create an array of SMkrInfo structs using data from the listctrl
	for(int i=0;i < iNumOfValues;i++)
	{
		pMkrInfo[i].m_dCalValue = ((CMkrInfo*)m_CalLibList.GetItemData(i))->m_dCalValue;
		pMkrInfo[i].m_dCentroidTime = ((CMkrInfo*)m_CalLibList.GetItemData(i))->m_dCentroidTime;
		pMkrInfo[i].m_dStartMkrTime = ((CMkrInfo*)m_CalLibList.GetItemData(i))->m_dStartMkrTime;
		pMkrInfo[i].m_dEndMkrTime = ((CMkrInfo*)m_CalLibList.GetItemData(i))->m_dEndMkrTime;
	}

	m_Cal.Calibrate(eType, iNumOfValues, pMkrInfo);//Perform a calibration

	GetDlgItemText(IDC_CAL_UNITS, Text);
	m_Cal.SetUnitsText(Text);
	GetDlgItemText(IDC_CAL_FILE, Text);
	m_Cal.SetFileName(Text);

	delete []pMkrInfo;
	pMkrInfo = NULL;
}


void CCalibrationTab::OnRclickCallibraryList(NMHDR* pNMHDR, LRESULT* pResult) 
{
	if(m_CalLibList.GetSelectedCount() > 0)
	{
		CMenu menu;

		VERIFY(menu.LoadMenu(IDR_RIGHT_CAL));
		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup);

		CPoint mPt;

		::GetCursorPos(&mPt);

		pPopup->TrackPopupMenu(TPM_LEFTALIGN, mPt.x, mPt.y, this );
		menu.DestroyMenu();

	}		
	*pResult = 0;
}
void CCalibrationTab::OnRightDelete()
{
	DeleteCalItem(1);
}
void CCalibrationTab::OnRightUpdate()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);
	//What we want to happen here is using the current data with the current cal file loaded into
	//the tab, recalibrate. By this I mean, loop through all values in listctrl get the start and end
	//marker placement, set these, get the centroid and update it. Then send these values to calibrate
	//the new values should then be stored in the file when the Save is pressed!

	int iSel, iSelectedItems = m_CalLibList.GetSelectedCount();
	double dNetArea, dGrossArea, dCentroid;
	CString Tmp;

	if(iSelectedItems > 0)//any items selected?
	{
		CString Message;
	
		if(iSelectedItems == 1)Message = _T("Are you sure you want to update the selected centroids?");
		else Message.Format( _T("Are you sure you want to update the %d selected centroids?"), iSelectedItems);

		if( AfxMessageBox(Message,MB_YESNO | MB_ICONQUESTION) == IDYES)
		{
			for(int n=0;n<iSelectedItems;n++)
			{
				iSel = m_CalLibList.GetNextItem( -1, LVNI_SELECTED );

				CMkrInfo* pMkr = (CMkrInfo*)m_CalLibList.GetItemData(iSel);
				ASSERT(pMkr);

				pWnd->GetAverageView()->GetGraph()->SetStartMarkerPos( pMkr->m_dStartMkrTime );
				pWnd->GetAverageView()->GetGraph()->SetEndMarkerPos( pMkr->m_dEndMkrTime );

				pWnd->GetAverageView()->GetGraph()->GetAnalysisFromSelection(1, &dNetArea, &dGrossArea, &dCentroid);
				pWnd->GetAverageView()->GetGraph()->Invalidate();

				pMkr->m_dCentroidTime = dCentroid;
				m_Cal.GetMarkerInfo(iSel)->m_dCentroidTime = dCentroid;
				Tmp.Format("%f", dCentroid);
				m_CalLibList.SetItemText(iSel, 1, Tmp);
				
				m_CalLibList.SetItemState(iSel, 0, LVIS_SELECTED);
				
			}

			OnCalApply();
		}
	}


}
void CCalibrationTab::EnableItems(BOOL bEnable)
{
	if(bEnable)
	{
		
		GetDlgItem(IDC_CAL_VIEW)->EnableWindow(TRUE);
		GetDlgItem(IDC_CAL_FILE)->EnableWindow(TRUE);
		GetDlgItem(IDC_CALLIBRARY_LIST)->EnableWindow(TRUE);
		GetDlgItem(IDC_ADD_CALVALUE)->EnableWindow(TRUE);
		GetDlgItem(IDC_CAL_TYPE)->EnableWindow(TRUE);
		GetDlgItem(IDC_CAL_UNITS)->EnableWindow(TRUE);
		GetDlgItem(IDC_CAL_SAVE)->EnableWindow(TRUE);

		UpdateBasedOnItems();
	}
	else
	{

		GetDlgItem(IDC_CAL_VIEW)->EnableWindow(FALSE);
		GetDlgItem(IDC_CAL_FILE)->EnableWindow(FALSE);
		GetDlgItem(IDC_CALLIBRARY_LIST)->EnableWindow(FALSE);
		GetDlgItem(IDC_ADD_CALVALUE)->EnableWindow(FALSE);
		GetDlgItem(IDC_CAL_TYPE)->EnableWindow(FALSE);
		GetDlgItem(IDC_CAL_UNITS)->EnableWindow(FALSE);
		GetDlgItem(IDC_CAL_SAVE)->EnableWindow(FALSE);
	}

}


void CCalibrationTab::UpdateBasedOnItems()
{
	int iCalType = ((CComboBox*)GetDlgItem(IDC_CAL_TYPE))->GetCurSel();

	if(iCalType == 0)
	{
		if(m_CalLibList.GetItemCount() >= 3)
		{
			
			GetDlgItem(IDC_CAL_VIEW)->EnableWindow(TRUE);
		}
		else
		{
			
			GetDlgItem(IDC_CAL_VIEW)->EnableWindow(FALSE);
		}
	}
	else if(iCalType == 1)
	{
		if(m_CalLibList.GetItemCount() >= 4)
		{
			
			GetDlgItem(IDC_CAL_VIEW)->EnableWindow(TRUE);
		}
		else
		{
			
			GetDlgItem(IDC_CAL_VIEW)->EnableWindow(FALSE);
		}
	}
	else if(iCalType == 2)
	{
		if(m_CalLibList.GetItemCount() >= 5)
		{
			
			GetDlgItem(IDC_CAL_VIEW)->EnableWindow(TRUE);
		}
		else
		{
			
			GetDlgItem(IDC_CAL_VIEW)->EnableWindow(FALSE);
		}
	}

}

void CCalibrationTab::OnSelchangeCalType() 
{
	int idx = m_CalLibList.GetItemCount();
	int iCalType = ((CComboBox*)GetDlgItem(IDC_CAL_TYPE))->GetCurSel();

	if(iCalType == 0 && idx >= 2)
	{
		//Calculate calibration so far
		OnCalApply();
	}
	else if(iCalType == 1 && idx >= 3)
	{
		OnCalApply();
	}
	else if(iCalType == 2 && idx >= 4)
	{
		OnCalApply();
	}

	UpdateBasedOnItems();	
}
void CCalibrationTab::OnCancel()
{
	//Don't do anything
	return;
}
void CCalibrationTab::OnOK()
{
	//Don't do anything
	return;
}