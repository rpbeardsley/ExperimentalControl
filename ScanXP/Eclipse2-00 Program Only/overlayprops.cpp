//***************************************************************************************
//OverlayProps.cpp : implementation file
//
//	Functions: For details on functions in this file see OverlayProps.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Eclipse.h"
#include "OverlayProps.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// COverlayProps dialog


COverlayProps::COverlayProps(CWnd* pParent, CGSX2* pGraph)
	: CDialog(COverlayProps::IDD, pParent)
{
	//{{AFX_DATA_INIT(COverlayProps)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	m_iSelectedOverlay = 2;
	m_pGraph = pGraph;
	ASSERT(m_pGraph);
}


void COverlayProps::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(COverlayProps)
	DDX_Control(pDX, IDC_SYMBOLS_SIZE, m_SymbolSizeSB);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(COverlayProps, CDialog)
	//{{AFX_MSG_MAP(COverlayProps)
	ON_BN_CLICKED(IDC_LINES, OnLines)
	ON_BN_CLICKED(IDC_SYMBOLS, OnSymbols)
	ON_CBN_SELCHANGE(IDC_OVERLAY_NUMBER, OnSelchangeOverlayNumber)
	ON_CBN_SELCHANGE(IDC_LINES_COLOR, OnSelchangeLinesColor)
	ON_CBN_SELCHANGE(IDC_LINES_WIDTH, OnSelchangeLinesWidth)
	ON_CBN_SELCHANGE(IDC_SYMBOLS_COLOR, OnSelchangeSymbolsColor)
	ON_CBN_SELCHANGE(IDC_SYMBOLS_TYPE, OnSelchangeSymbolsType)
	ON_WM_HSCROLL()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// COverlayProps message handlers

BOOL COverlayProps::OnInitDialog() 
{
	CDialog::OnInitDialog();

	((CComboBox*)GetDlgItem(IDC_OVERLAY_NUMBER))->SetCurSel(m_iSelectedOverlay - 2);
	
	LoadSelectedProperties();
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
void COverlayProps::LoadSelectedProperties()
{
	bool bShowSymbol;
	
	if(m_pGraph->GetDataSymbol(m_iSelectedOverlay) == 0)bShowSymbol = false;
	else bShowSymbol = true;

	((CComboBox*)GetDlgItem(IDC_SYMBOLS_COLOR))->SetCurSel( m_pGraph->GetDataSymbolColor(m_iSelectedOverlay) );
	((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->SetCurSel( m_pGraph->GetDataSymbol(m_iSelectedOverlay) - 1 );

	//Set up the Symbol size scroll Bar
	m_SymbolSizeSB.SetScrollRange(2,42,TRUE);
	m_SymbolSizeSB.SetScrollPos( m_pGraph->GetDataSymbolSize(m_iSelectedOverlay), TRUE);

	if( bShowSymbol )
	{
		((CButton*)GetDlgItem(IDC_SYMBOLS))->SetCheck( TRUE );
	
		EnableSymbolProps(true);

	}
	else 
	{
		((CButton*)GetDlgItem(IDC_SYMBOLS))->SetCheck( FALSE );
		((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->SetCurSel( 0 );
		EnableSymbolProps(false);
	}
	
	((CComboBox*)GetDlgItem(IDC_LINES_COLOR))->SetCurSel( m_pGraph->GetDataLineColor(m_iSelectedOverlay) );
	((CComboBox*)GetDlgItem(IDC_LINES_WIDTH))->SetCurSel( m_pGraph->GetDataLineWidth(m_iSelectedOverlay) - 1);

	if(m_pGraph->GetDataLine(m_iSelectedOverlay) == 2)
	{
		((CButton*)GetDlgItem(IDC_LINES))->SetCheck( TRUE );
		EnableLineProps(true);
	}
	else
	{
		((CButton*)GetDlgItem(IDC_LINES))->SetCheck( FALSE );
		EnableLineProps(false);
	}
}
void COverlayProps::EnableSymbolProps(bool bEnable)
{
	if(bEnable)
	{
		GetDlgItem(IDC_SYMBOLS_COLOR)->EnableWindow(TRUE);
		GetDlgItem(IDC_SYMBOLS_TYPE)->EnableWindow(TRUE);
		GetDlgItem(IDC_SYMBOLS_SIZE)->EnableWindow(TRUE);
	}
	else
	{
		GetDlgItem(IDC_SYMBOLS_COLOR)->EnableWindow(FALSE);
		GetDlgItem(IDC_SYMBOLS_TYPE)->EnableWindow(FALSE);
		GetDlgItem(IDC_SYMBOLS_SIZE)->EnableWindow(FALSE);
	}
}
void COverlayProps::EnableLineProps(bool bEnable)
{
	if(bEnable)
	{
		GetDlgItem(IDC_LINES_COLOR)->EnableWindow(TRUE);
		GetDlgItem(IDC_LINES_WIDTH)->EnableWindow(TRUE);
	}
	else
	{
		GetDlgItem(IDC_LINES_COLOR)->EnableWindow(FALSE);
		GetDlgItem(IDC_LINES_WIDTH)->EnableWindow(FALSE);
	}
}

void COverlayProps::OnLines() 
{
	ASSERT(m_pGraph);

	if( ((CButton*)GetDlgItem(IDC_LINES))->GetCheck() )
	{
		m_pGraph->SetDataLine(m_iSelectedOverlay,  2);
		EnableLineProps(true);
	}
	else
	{
		m_pGraph->SetDataLine(m_iSelectedOverlay,  1);
		EnableLineProps(false);
	}
	
}

void COverlayProps::OnSymbols() 
{
	ASSERT(m_pGraph);

	BOOL bCheck = ((CButton*)GetDlgItem(IDC_SYMBOLS))->GetCheck();

	if(bCheck)
	{
		EnableSymbolProps(true);
		m_pGraph->SetDataSymbol(m_iSelectedOverlay, ((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->GetCurSel() + 1);
	}
	else
	{
		EnableSymbolProps(false);
		m_pGraph->SetDataSymbol(m_iSelectedOverlay, 0);
	}	
}

void COverlayProps::OnSelchangeOverlayNumber() 
{
	m_iSelectedOverlay = ((CComboBox*)GetDlgItem(IDC_OVERLAY_NUMBER))->GetCurSel() + 2;
	LoadSelectedProperties();	
}

void COverlayProps::OnSelchangeLinesColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataLineColor(m_iSelectedOverlay, ((CComboBox*)GetDlgItem(IDC_LINES_COLOR))->GetCurSel());

}

void COverlayProps::OnSelchangeLinesWidth() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataLineWidth(m_iSelectedOverlay, ((CComboBox*)GetDlgItem(IDC_LINES_WIDTH))->GetCurSel() + 1);
	
}

void COverlayProps::OnSelchangeSymbolsColor() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataSymbolColor(m_iSelectedOverlay, ((CComboBox*)GetDlgItem(IDC_SYMBOLS_COLOR))->GetCurSel());	
	
}

void COverlayProps::OnSelchangeSymbolsType() 
{
	ASSERT(m_pGraph);
	m_pGraph->SetDataSymbol(m_iSelectedOverlay, ((CComboBox*)GetDlgItem(IDC_SYMBOLS_TYPE))->GetCurSel() + 1);	
}

void COverlayProps::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
long Pos;

	ASSERT(m_pGraph);

	switch(nSBCode)
	{
		case SB_THUMBTRACK:
	
			m_pGraph->SetDataSymbolSize(m_iSelectedOverlay, nPos);
			pScrollBar->SetScrollPos(nPos,true);

		break;
		case SB_LINELEFT:

			Pos = m_pGraph->GetDataSymbolSize(m_iSelectedOverlay);
			if(Pos > 2)Pos--;

			m_pGraph->SetDataSymbolSize(m_iSelectedOverlay, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
		case SB_LINERIGHT:

			Pos = m_pGraph->GetDataSymbolSize(m_iSelectedOverlay);
			if(Pos < 42)Pos++;

			m_pGraph->SetDataSymbolSize(m_iSelectedOverlay, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
		case SB_PAGELEFT:

			Pos = m_pGraph->GetDataSymbolSize(m_iSelectedOverlay);
			if(Pos > 7)Pos -= 5;
			else Pos = 2;
			
			m_pGraph->SetDataSymbolSize(m_iSelectedOverlay, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
		case SB_PAGERIGHT:

			Pos = m_pGraph->GetDataSymbolSize(m_iSelectedOverlay);
			if(Pos < 37)Pos += 5;
			else Pos = 42;

			m_pGraph->SetDataSymbolSize(m_iSelectedOverlay, Pos);
			pScrollBar->SetScrollPos(Pos,true);

		break;
	}		
	CDialog::OnHScroll(nSBCode, nPos, pScrollBar);
}
