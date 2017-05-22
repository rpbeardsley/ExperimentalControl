
#include "stdafx.h"
#include "OhmEditBox.h"

class TOhmUnitsListBox : public TAutoUnitsListBox {
public:
    TOhmUnitsListBox(int nID,CWnd* pParent,
                     double* pdMultiplier,TOhmEditBox* peb,int iMinExp,int iMaxExp,const TBaseEnabler& AEnabler);
    ~TOhmUnitsListBox();
    virtual void InitUI();
protected:
    HFONT hfontSymbol;
    int iItemHeight;
	afx_msg void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
    DECLARE_MESSAGE_MAP()
};

TAutoListBox* TOhmEditBox::CreateUnitsListBox(int iID,CWnd* pParent) {
    return new TOhmUnitsListBox(iUnitListBoxID,GetParent(),ptMultiplier,this,iMinExp,iMaxExp,enab);
}

BEGIN_MESSAGE_MAP(TOhmEditBox,TAutoNumberWithUnitsEditBoxTmplt<double>)
END_MESSAGE_MAP()

TOhmUnitsListBox::TOhmUnitsListBox(int nID,CWnd* pParent,
                                   double* pdMultiplier,TOhmEditBox* peb,int iMinExp,int iMaxExp,const TBaseEnabler& AEnabler)
: TAutoUnitsListBox(nID,pParent,pdMultiplier,peb,"W",20,iMinExp,iMaxExp,AEnabler) {
    hfontSymbol = NULL;
}

TOhmUnitsListBox::~TOhmUnitsListBox() {
    if (hfontSymbol) ::DeleteObject(hfontSymbol);
}

void TOhmUnitsListBox::InitUI() {
    TAutoUnitsListBox::InitUI();
}

BEGIN_MESSAGE_MAP(TOhmUnitsListBox,TAutoUnitsListBox)
    ON_WM_DRAWITEM_REFLECT()
END_MESSAGE_MAP()

#pragma warning(disable:4800)
void TOhmUnitsListBox::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) {
    RECT* prc = &lpDrawItemStruct -> rcItem;
    HDC hdc = lpDrawItemStruct -> hDC;
    bool bSel = (bool)(lpDrawItemStruct -> itemState & ODS_SELECTED);
    bool bDisabled = (bool)(lpDrawItemStruct -> itemState & ODS_DISABLED);

    if (!hfontSymbol) {
        HFONT hfont = (HFONT)SendMessage(WM_GETFONT,0,0);
        HGDIOBJ hOldFont = ::SelectObject(hdc,hfont);
        TEXTMETRIC tm;
        ::GetTextMetrics(hdc,&tm);
        ::SelectObject(hdc,hOldFont);
        iItemHeight = 2 + tm.tmHeight + tm.tmExternalLeading;
        SendMessage(CB_SETITEMHEIGHT,(WPARAM)(-1),(LPARAM)iItemHeight); // selected box height
        SendMessage(CB_SETITEMHEIGHT,(WPARAM)(0),(LPARAM)iItemHeight);  // item heights

        LOGFONT lf;
        ::ZeroMemory(&lf,sizeof(LOGFONT));
        int iPixPerInch = GetDeviceCaps(hdc,LOGPIXELSY);
        lf.lfHeight = -tm.tmHeight;
        strcpy(lf.lfFaceName,_T("Symbol"));
        lf.lfCharSet = DEFAULT_CHARSET;
        hfontSymbol = CreateFontIndirect(&lf);
    }

    COLORREF crBkg = ::GetSysColor(bDisabled ? COLOR_BTNFACE :
                                               (bSel ? COLOR_HIGHLIGHT : COLOR_WINDOW));
    COLORREF crOldBkg = ::SetBkColor(hdc,crBkg);
    COLORREF crOldText = 
        ::SetTextColor(hdc,::GetSysColor(bDisabled ? COLOR_GRAYTEXT :
                                                     (bSel ? COLOR_HIGHLIGHTTEXT : 
                                                             COLOR_WINDOWTEXT)));
    ::FillRect(hdc,prc,(HBRUSH)(1 + (bDisabled ? COLOR_BTNFACE : 
                                                 (bSel ? COLOR_HIGHLIGHT : 
                                                         COLOR_WINDOW))));
    RECT rcText = *prc;
    rcText.left += 2;
    CString str;
    SendMessage(CB_GETLBTEXT,(WPARAM)(lpDrawItemStruct->itemID),
                (LPARAM)(str.GetBuffer(uMaxChars)));
    str.ReleaseBuffer();
    if (!str.IsEmpty()) {
        UINT uOldTextAlign = ::SetTextAlign(hdc,TA_BASELINE | TA_LEFT | TA_UPDATECP);
        TEXTMETRIC tm;
        ::GetTextMetrics(hdc,&tm);
        ::MoveToEx(hdc,
                   lpDrawItemStruct -> rcItem.left,
                   lpDrawItemStruct -> rcItem.top + tm.tmAscent,NULL);
        ::TextOut(hdc,0,0,str,str.GetLength()-1);
        str = str.Right(1);
        HGDIOBJ hfontOld = ::SelectObject(hdc,hfontSymbol);
        ::TextOut(hdc,0,0,str,str.GetLength());
        ::SelectObject(hdc,hfontOld);
        ::SetTextAlign(hdc,uOldTextAlign);
    }
    if (lpDrawItemStruct -> itemState & ODS_FOCUS) ::DrawFocusRect(hdc,prc);
    // dc MUST be restored to original state!!
    ::SetBkColor(hdc,crOldBkg);
    ::SetTextColor(hdc,crOldText);
}
#pragma warning(default:4800)


