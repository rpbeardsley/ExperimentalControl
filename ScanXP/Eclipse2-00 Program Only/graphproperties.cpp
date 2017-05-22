//***************************************************************************************
//GraphProperties.cpp : implementation file
//
//	Functions: For details on functions in this file see GraphProperties.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "MainFrm.h"
#include "GraphProperties.h"
#include "OverlayProps.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CGraphProperties dialog


CGraphProperties::CGraphProperties(CWnd* pParent, CGSX2* pGraph, bool bAverage)
	: CDialog(CGraphProperties::IDD, pParent)
{
	//{{AFX_DATA_INIT(CGraphProperties)
	m_bSymbols = FALSE;
	m_XAxisText = _T("");
	m_YAxisText = _T("");
	//}}AFX_DATA_INIT

	ASSERT(pGraph);
	m_pGraph = pGraph;
	m_bAverage = bAverage;
}


void CGraphProperties::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CGraphProperties)
	DDX_Control(pDX, IDC_SYMBOLS_SIZE, m_SymbolSizeSB);
	DDX_Check(pDX, IDC_SYMBOLS, m_bSymbols);
	DDX_Text(pDX, IDC_AXIS_XTEXT, m_XAxisText);
	DDV_MaxChars(pDX, m_XAxisText, 50);
	DDX_Text(pDX, IDC_AXIS_YTEXT, m_YAxisText);
	DDV_MaxChars(pDX, m_YAxisText, 50);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CGraphProperties, CDialog)
	//{{AFX_MSG_MAP(CGraphProperties)
	ON_BN_CLICKED(IDC_SYMBOLS, OnSymbols)
	ON_CBN_SELCHANGE(IDC_SYMBOLS_COLOR, OnSelchangeSymbolsColor)
	ON_CBN_SELCHANGE(IDC_SYMBOLS_TYPE, OnSelchangeSymbolsType)
	ON_WM_HSCROLL()
	ON_BN_CLICKED(IDC_LINES, OnLines)
	ON_CBN_SELCHANGE(IDC_LINES_COLOR, OnSelchangeLinesColor)
	ON_CBN_SELCHANGE(IDC_LINES_WIDTH, OnSelchangeLinesWidth)
	ON_BN_CLICKED(IDC_GRID, OnGrid)
	ON_CBN_SELCHANGE(IDC_GRID_COLOR, OnSelchangeGridColor)
	ON_CBN_SELCHANGE(IDC_AXIS_COLOR, OnSelchangeAxisColor)
	ON_BN_CLICKED(IDC_AXIS_LOG, OnAxisLog)
	ON_EN_UPDATE(IDC_AXIS_XTEXT, OnUpdateAxisXtext)
	ON_EN_UPDATE(IDC_AXIS_YTEXT, OnUpdateAxisYtext)
	ON_BN_CLICKED(IDC_OVERLAY_PROPS_BUTTON, OnOverlayPropsButton)
	ON_CBN_SELCHANGE(IDC_BKG_COLOR, OnSelchangeBkgColor)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGraphProperties message handlers
BOOL CGraphProperties::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);
	
	ASSERT(m_pGraph);

	//Initialize Symbol info  -----------------------------------------------------------------------
	bool bShowSymbol;
	
	if(m_pGraph->GetDataSymbol(1) == 0)bShowSymbol = false;
	else bShowSymbol = true;

	((CComboBox*)GetDlgItem(IDC_SYMBOLS_COLOR))->SetCurSel( m_pGraph->GetDataSymbolColor(1) );
	((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->SetCurSel( m_pGraph->GetDataSymbol(1) - 1 );

	//Set up the Symbol size scroll Bar
	m_SymbolSizeSB.SetScrollRange(2,42,TRUE);
	m_SymbolSizeSB.SetScrollPos( m_pGraph->GetDataSymbolSize(1), TRUE);

	if( bShowSymbol )
	{
		((CButton*)GetDlgItem(IDC_SYMBOLS))->SetCheck( TRUE );
	
		GetDlgItem(IDC_SYMBOLS_COLOR)->EnableWindow(TRUE);
		GetDlgItem(IDC_SYMBOLS_SIZE)->EnableWindow(TRUE);
		GetDlgItem(IDC_SYMBOLS_TYPE)->EnableWindow(TRUE);

	}
	else 
	{
		((CButton*)GetDlgItem(IDC_SYMBOLS))->SetCheck( FALSE );
		((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->SetCurSel( 0 );
		GetDlgItem(IDC_SYMBOLS_COLOR)->EnableWindow(FALSE);
		GetDlgItem(IDC_SYMBOLS_SIZE)->EnableWindow(FALSE);
		GetDlgItem(IDC_SYMBOLS_TYPE)->EnableWindow(FALSE);
	}

	//Initialize Line info  -----------------------------------------------------------------------
	bool bShowLine;

	if(m_pGraph->GetDataLine(1) == 1)bShowLine = false;
	else bShowLine = true;

	((CComboBox*)GetDlgItem(IDC_LINES_COLOR))->SetCurSel( m_pGraph->GetDataLineColor(1) );
	((CComboBox*)GetDlgItem(IDC_LINES_WIDTH))->SetCurSel( m_pGraph->GetDataLineWidth(1) - 1);

	if( bShowLine )
	{
		((CButton*)GetDlgItem(IDC_LINES))->SetCheck( TRUE );
		GetDlgItem(IDC_LINES_COLOR)->EnableWindow(TRUE);
		GetDlgItem(IDC_LINES_WIDTH)->EnableWindow(TRUE);
	}
	else
	{
		((CButton*)GetDlgItem(IDC_LINES))->SetCheck( FALSE );
		GetDlgItem(IDC_LINES_COLOR)->EnableWindow(FALSE);
		GetDlgItem(IDC_LINES_WIDTH)->EnableWindow(FALSE);
	}

	//Initialize Grid info  -----------------------------------------------------------------------
	((CComboBox*)GetDlgItem(IDC_GRID_COLOR))->SetCurSel( m_pGraph->GetGridColor() );
	if( m_pGraph->GetGridState() )
	{
		((CButton*)GetDlgItem(IDC_GRID))->SetCheck( TRUE );
		GetDlgItem(IDC_GRID_COLOR)->EnableWindow(TRUE);
	}
	else
	{
		((CButton*)GetDlgItem(IDC_GRID))->SetCheck( FALSE );
		GetDlgItem(IDC_GRID_COLOR)->EnableWindow(FALSE);
	}

	//Initialize Axis info  -----------------------------------------------------------------------
	((CComboBox*)GetDlgItem(IDC_AXIS_COLOR))->SetCurSel( m_pGraph->GetAxisColor() );
	((CButton*)GetDlgItem(IDC_AXIS_LOG))->SetCheck( m_pGraph->GetAxisYLog() );

	CString XText;
	XText = m_pGraph->GetAxisXText();
	pWnd->StripAxisTextLabels( &XText );

	SetDlgItemText(IDC_AXIS_XTEXT, XText );
	if(m_bAverage)
	{
		GetDlgItem(IDC_AXIS_YTEXT)->EnableWindow(FALSE);
	}
	else
		SetDlgItemText(IDC_AXIS_YTEXT, m_pGraph->GetAxisYText() );

	//Initialize the Misc info
	((CComboBox*)GetDlgItem(IDC_BKG_COLOR))->SetCurSel( m_pGraph->GetPlotAreaColor() );

	//Hide the overlay and Y Scale buttons if not the Average Graph
	if(!m_bAverage)
	{
		GetDlgItem(IDC_OVERLAY_PROPS_BUTTON)->ShowWindow(SW_HIDE);
	}
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}


//---------------------------------------  START Symbol Settings ---------------------------------------------

void CGraphProperties::OnSymbols() 
{
	ASSERT(m_pGraph);

	BOOL bCheck = ((CButton*)GetDlgItem(IDC_SYMBOLS))->GetCheck();

	if(bCheck)
	{
		GetDlgItem(IDC_SYMBOLS_COLOR)->EnableWindow(TRUE);
		GetDlgItem(IDC_SYMBOLS_SIZE)->EnableWindow(TRUE);
		GetDlgItem(IDC_SYMBOLS_TYPE)->EnableWindow(TRUE);
		m_pGraph->SetDataSymbol(1, ((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->GetCurSel() + 1);
	}
	else
	{
		GetDlgItem(IDC_SYMBOLS_COLOR)->EnableWindow(FALSE);
		GetDlgItem(IDC_SYMBOLS_SIZE)->EnableWindow(FALSE);
		GetDlgItem(IDC_SYMBOLS_TYPE)->EnableWindow(FALSE);
		m_pGraph->SetDataSymbol(1, 0);
	}
	
}
void CGraphProperties::OnSelchangeSymbolsColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataSymbolColor(1, ((CComboBox*)GetDlgItem(IDC_SYMBOLS_COLOR))->GetCurSel());
}

void CGraphProperties::OnSelchangeSymbolsType() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataSymbol(1, ((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->GetCurSel() + 1);	
}

void CGraphProperties::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	long Pos;

	ASSERT(m_pGraph);

	switch(nSBCode)
	{
		case SB_THUMBTRACK:
	
			m_pGraph->SetDataSymbolSize(1, nPos);
			pScrollBar->SetScrollPos(nPos,true);

		break;
		case SB_LINELEFT:

			Pos = m_pGraph->GetDataSymbolSize(1);
			if(Pos > 2)Pos--;

			m_pGraph->SetDataSymbolSize(1, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
		case SB_LINERIGHT:

			Pos = m_pGraph->GetDataSymbolSize(1);
			if(Pos < 42)Pos++;

			m_pGraph->SetDataSymbolSize(1, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
		case SB_PAGELEFT:

			Pos = m_pGraph->GetDataSymbolSize(1);
			if(Pos > 7)Pos -= 5;
			else Pos = 2;
			
			m_pGraph->SetDataSymbolSize(1, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
		case SB_PAGERIGHT:

			Pos = m_pGraph->GetDataSymbolSize(1);
			if(Pos < 37)Pos += 5;
			else Pos = 42;

			m_pGraph->SetDataSymbolSize(1, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
	}	
	
	CDialog::OnHScroll(nSBCode, nPos, pScrollBar);
}
//---------------------------------------  END Symbol Settings ---------------------------------------------


//---------------------------------------  START Line Settings ---------------------------------------------
void CGraphProperties::OnLines() 
{
	ASSERT(m_pGraph);

	BOOL bCheck = ((CButton*)GetDlgItem(IDC_LINES))->GetCheck();

	if(bCheck)
	{
		GetDlgItem(IDC_LINES_COLOR)->EnableWindow(TRUE);
		GetDlgItem(IDC_LINES_WIDTH)->EnableWindow(TRUE);
		m_pGraph->SetDataLine(1, 2);
	}
	else
	{
		GetDlgItem(IDC_LINES_COLOR)->EnableWindow(FALSE);
		GetDlgItem(IDC_LINES_WIDTH)->EnableWindow(FALSE);
		m_pGraph->SetDataLine(1, 1);
	
	}
}

void CGraphProperties::OnSelchangeLinesColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataLineColor(1, ((CComboBox*)GetDlgItem(IDC_LINES_COLOR))->GetCurSel());
	
}

void CGraphProperties::OnSelchangeLinesWidth() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataLineWidth(1, ((CComboBox*)GetDlgItem(IDC_LINES_WIDTH))->GetCurSel() + 1);
	
}
//---------------------------------------  END Line Settings ---------------------------------------------

//---------------------------------------  START Grid Settings ---------------------------------------------
void CGraphProperties::OnGrid() 
{
	ASSERT(m_pGraph);

	BOOL bCheck = ((CButton*)GetDlgItem(IDC_GRID))->GetCheck();

	if(bCheck)
	{
		GetDlgItem(IDC_GRID_COLOR)->EnableWindow(TRUE);
		m_pGraph->SetGridState(TRUE);
	}
	else
	{
		GetDlgItem(IDC_GRID_COLOR)->EnableWindow(FALSE);
		m_pGraph->SetGridState(FALSE);
	
	}
}

void CGraphProperties::OnSelchangeGridColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetGridColor( ((CComboBox*)GetDlgItem(IDC_GRID_COLOR))->GetCurSel() );
	
}
//---------------------------------------  END GridSettings ---------------------------------------------

//---------------------------------------  START Axis Settings ---------------------------------------------
void CGraphProperties::OnSelchangeAxisColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetAxisColor( ((CComboBox*)GetDlgItem(IDC_AXIS_COLOR))->GetCurSel() );
}

void CGraphProperties::OnAxisLog() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetAxisYLog( ((CButton*)GetDlgItem(IDC_AXIS_LOG))->GetCheck() );
}

void CGraphProperties::OnUpdateAxisXtext() 
{
	ASSERT(m_pGraph);
	ASSERT(GetDlgItem(IDC_AXIS_XTEXT));

	CString Text;

	GetDlgItem(IDC_AXIS_XTEXT)->GetWindowText( Text );

	m_pGraph->SetAxisXText( Text );	


}

void CGraphProperties::OnUpdateAxisYtext() 
{
	ASSERT(m_pGraph);
	ASSERT(GetDlgItem(IDC_AXIS_YTEXT));

	CString Text;

	GetDlgItem(IDC_AXIS_YTEXT)->GetWindowText( Text );
	m_pGraph->SetAxisYText( Text );	
}
//---------------------------------------  END Axis Settings ---------------------------------------------

//---------------------------------------  Start Misc Settings ---------------------------------------------

void CGraphProperties::OnSelchangeBkgColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetPlotAreaColor( ((CComboBox*)GetDlgItem(IDC_BKG_COLOR))->GetCurSel() );
	m_pGraph->SetChartAreaColor( ((CComboBox*)GetDlgItem(IDC_BKG_COLOR))->GetCurSel() );	
}

void CGraphProperties::OnOverlayPropsButton() 
{
	COverlayProps overlay(this, m_pGraph);

	overlay.DoModal();
	
}

//---------------------------------------  END Misc Settings ---------------------------------------------





