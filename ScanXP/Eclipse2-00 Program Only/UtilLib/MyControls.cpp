
#include "stdafx.h"

#include "MyControls.h"
#include "math.h"
#include "float.h"

#ifndef __UtilLibResource_h
#define __UtilLibResource_h
#include "UtilLibResource.h"
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

UINT WM_INITUI = ::RegisterWindowMessage("EGGINC_WM_INITUI");
static UINT WM_ADDEDITBOX = ::RegisterWindowMessage("EGGINC_WM_ADDEDITBOX");

//Globla functions
void ShiftDlgItem(CWnd *pWnd, int x, int y)
{
	CRect rc; 
	pWnd->GetWindowRect(rc); 
	pWnd->GetParent()->ScreenToClient(rc); //convert to parent client area
	rc.OffsetRect (x, y); //Move left or upper 
	pWnd->MoveWindow(rc); 
}

//***************************************************************************
//
// T3DResources Implementation
//
//***********
//
// initializers
//
int TShadowResources::iUsage = 0;
HBRUSH TShadowResources::hbrshBkg;
HBRUSH TShadowResources::hbrshTxt;
HBRUSH TShadowResources::hbrsh3DShadow;
HBRUSH TShadowResources::hbrsh3DDkShadow;
HBRUSH TShadowResources::hbrsh3DHiLight;
HBRUSH TShadowResources::hbrsh3DLight;
///
// ctor
//
TShadowResources::TShadowResources() {
//    TRACE("iUsage = %i\n",iUsage);
    if (iUsage == 0) {
        hbrshBkg        = ::CreateSolidBrush(GetSysColor(COLOR_3DFACE));
        hbrshTxt        = ::CreateSolidBrush(GetSysColor(COLOR_BTNTEXT));
        hbrsh3DShadow   = ::CreateSolidBrush(GetSysColor(COLOR_3DSHADOW)); 
        hbrsh3DDkShadow = ::CreateSolidBrush(GetSysColor(COLOR_3DDKSHADOW));
        hbrsh3DHiLight  = ::CreateSolidBrush(GetSysColor(COLOR_3DHILIGHT));
        hbrsh3DLight    = ::CreateSolidBrush(GetSysColor(COLOR_3DLIGHT));
    }
    iUsage++;
}
//
// dtor
//
TShadowResources::~TShadowResources() {
    iUsage--;
    if (iUsage == 0) {
        ::DeleteObject(hbrshBkg);
        ::DeleteObject(hbrshTxt);
        ::DeleteObject(hbrsh3DShadow);
        ::DeleteObject(hbrsh3DDkShadow);
        ::DeleteObject(hbrsh3DHiLight);
        ::DeleteObject(hbrsh3DLight);
    }
}
//
// DrawRect
//
void TShadowResources::DrawRect(HDC hdc,RECT* prc,bool bShowDown,bool bDefault,bool bFill) {
    RECT rc = *prc;
    if (bDefault && !bShowDown) {
        ::FillRect(hdc,&rc,hbrsh3DDkShadow);
        ::InflateRect(&rc,-1,-1);
    }

/*  BRUSHES ARE USED INSTEAD OF PENS BECAUSE WITH PENS.....
    THE BOTTOM LINE ON THE INNER RECT GETS
    SCOOTED LEFT ONE PIXEL WHEN DRAWING ON A BITMAP, WITH FULL HARDWARE 
    ACCELERATION -- HOWEVER, IT SEEMS TO WORK FINE WHEN DRAWING DIRECTLY
    TO THE SCREEN OR WITH MINIMAL HARDWARE ACCELERATION???? THE METHOD 
    USING BRUSHES INSTEAD OF PENS IS MORE RELIABLE..... 
    PART OF THIS MAY BE DUE TO THE FACT THAT SOLID PENS CREATED FROM THE 
    GetSysColor SPECIFIED COLOR MAY NOT BE SELECTABLE INTO THE DC SINCE 
    THESE COLORS MAY BE DITHERED...
*/
    // brushes for outer edge
    HBRUSH hbrsh1,hbrsh2 = hbrsh3DDkShadow;
    if (bShowDown && bDefault)
        hbrsh1 = hbrsh2;
    else
        hbrsh1 = hbrsh3DHiLight;  
    RECT rcLine;
    for (int i = 0; i < 2; i++) {
        if (bShowDown) {
            rcLine.left = rc.right-1; rcLine.top = rc.top;
            rcLine.right = rc.right; rcLine.bottom = rc.bottom-1;
            ::FillRect(hdc,&rcLine,hbrsh1);

            rcLine.left = rc.left+1; rcLine.top = rc.bottom-1;
            rcLine.right = rc.right; rcLine.bottom = rc.bottom;
            ::FillRect(hdc,&rcLine,hbrsh1);

            rcLine.left = rc.left; rcLine.top = rc.top+1;
            rcLine.right = rc.left+1; rcLine.bottom = rc.bottom;
            ::FillRect(hdc,&rcLine,hbrsh2);
            
            rcLine.left = rc.left; rcLine.top = rc.top;
            rcLine.right = rc.right; rcLine.bottom = rc.top+1;
            ::FillRect(hdc,&rcLine,hbrsh2);
        } else {
            rcLine.left = rc.left; rcLine.top = rc.top+1;
            rcLine.right = rc.left+1; rcLine.bottom = rc.bottom;
            ::FillRect(hdc,&rcLine,hbrsh1);
            
            rcLine.top = rc.top;
            rcLine.right = rc.right-1; rcLine.bottom = rc.top+1;
            ::FillRect(hdc,&rcLine,hbrsh1);
    
            rcLine.left = rc.right-1;
            rcLine.right = rc.right; rcLine.bottom = rc.bottom-1;
            ::FillRect(hdc,&rcLine,hbrsh2);

            rcLine.left = rc.left; rcLine.top = rc.bottom-1;
            rcLine.right = rc.right; rcLine.bottom = rc.bottom;
            ::FillRect(hdc,&rcLine,hbrsh2);
        }
        // brushes for inner edge
        hbrsh2 = hbrsh3DShadow;
        if (bShowDown && bDefault)
            hbrsh1 = hbrsh2;
        else
            hbrsh1 = hbrsh3DLight;        
        ::InflateRect(&rc,-1,-1);
    }

    // do upper corner if down, lower if up in face color to
    // compensate for bitmap shifting
    if (bShowDown) {
        rcLine.left = rc.left; rcLine.top = rc.top+1;
        rcLine.right = rc.left+1; rcLine.bottom = rc.bottom;
        ::FillRect(hdc,&rcLine,hbrshBkg);
        rcLine.left = rc.left; rcLine.top = rc.top;
        rcLine.right = rc.right; rcLine.bottom = rc.top+1;
        ::FillRect(hdc,&rcLine,hbrshBkg);
        rc.left++;      // shift face rect toward lower corner
        rc.top++;
    } else {
        rcLine.left = rc.left; rcLine.top = rc.bottom-1;
        rcLine.right = rc.right-1; rcLine.bottom = rc.bottom;
        ::FillRect(hdc,&rcLine,hbrshBkg);
        rcLine.left = rc.right-1; rcLine.top = rc.top;
        rcLine.right = rc.right; rcLine.bottom = rc.bottom;
        ::FillRect(hdc,&rcLine,hbrshBkg);
        rc.right--;     // shift face rect toward upper corner
        rc.bottom--;
    }
    if (bFill) ::FillRect(hdc,&rc,hbrshBkg);
    *prc = rc;
}

//***************************************
//
// MODULE PRIVATE CLASS DECLARATIONS
//
//***************************************

//***************************************
//
// TAutoPopoutBitmapSelectorWindow 
//
class TAutoPopoutBitmapSelectorWindow : public CWnd {
public:
    TAutoPopoutBitmapSelectorWindow(TAutoPopoutBitmapSelector*);
    ~TAutoPopoutBitmapSelectorWindow();
    inline int GetSelection() const { return iSelection; }
private:
    virtual void PostNcDestroy();
    afx_msg void OnNcDestroy();
    afx_msg void OnCaptureChanged(CWnd*);
    afx_msg void OnLButtonUp(UINT,CPoint);
    afx_msg void OnMouseMove(UINT,CPoint);
    afx_msg void OnKeyDown(UINT nChar,UINT nRepCnt,UINT nFlags);
    afx_msg void OnPaint();
    TAutoPopoutBitmapSelector* const pButton;
    bool bIgnoreCaptureChange;
    int iSelection;
    int iBitmapWidth;
    int iBitmapHeight;
    const int iCols;
    const int iRows;
    const int iNumBitmaps;
    CBitmap* pbitmaps;
    DECLARE_MESSAGE_MAP()
};

//***************************************************************************
//
// TAutoControlBase Implementation
//
//***********
const TAutoControlBase::TDftEnabler TAutoControlBase::dftEnabler;
const UINT TAutoControlBase::WM_AUTOCONTROLLOOSINGFOCUS = ::RegisterWindowMessage("EGGINC_WM_AUTOCONTROLLOOSINGFOCUS");
HWND TAutoControlBase::hwndGettingFocus = 0;
bool TAutoControlBase::bMajorChange;
//
// ctors
//
TAutoControlBase::TAutoControlBase(const TBaseEnabler& AEnabler) 
: CWnd(),enab(AEnabler) {
    bAutoDelete = false;
    bInitialized = false;
}

TAutoControlBase::TAutoControlBase(UINT nID,CWnd* pParent,const TBaseEnabler& AEnabler) 
: CWnd(),enab(AEnabler) {
    ASSERT(pParent != NULL);                    // parent better be valid
    ASSERT(pParent -> GetDlgItem(nID) != NULL); // control ID better be valid
    SubclassDlgItem(nID,pParent);
    PostMessage(WM_INITUI,0,0);
    bAutoDelete = true;
    bInitialized = false;
}

TAutoControlBase::~TAutoControlBase() {
}
//
// New Functions
//
void TAutoControlBase::InitUI() {
    bInitialized = true;
    if (enab.ShouldBeEnabled() != TEnabler::nochange)
        EnableWindow(enab.ShouldBeEnabled());
}
void TAutoControlBase::ForceDataSync() {
    // Derived classes might override if data sync is not inherent
}
//
// Overridden Functions
//
void TAutoControlBase::PostNcDestroy() {
    if (bAutoDelete) delete this;
}
BOOL TAutoControlBase::PreTranslateMessage(MSG* pMsg) {
    if (pMsg->message == WM_KEYDOWN && pMsg->wParam == VK_RETURN) {
        ASSERT(pMsg->hwnd == *this);
        int iDlgCode = SendMessage(WM_GETDLGCODE,0,0);
        if ((iDlgCode & DLGC_WANTALLKEYS) == 0) {
            HWND hwndDlg = ::GetParent(*this);
            int idDefBtn = LOWORD(::SendMessage(hwndDlg,DM_GETDEFID,0,0));
            HWND hwndDftBtn = 0;
            for (HWND parent = hwndDlg; parent; ) {
                if (hwndDftBtn = ::GetDlgItem(parent,idDefBtn)) break;
                parent = (::GetWindowLong(parent,GWL_STYLE) & WS_CHILD) ? ::GetParent(parent) : 0; 
            }
            if (hwndDftBtn) {
                bMajorChange = false;       // declare no major change -- yet
                ::SetFocus(hwndDftBtn);     // focus change might trigger a major change
                return (BOOL)bMajorChange;  // eat key if so
            }
        }
    }
    return FALSE; // don't eat message
}

//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoControlBase,CWnd)
    ON_REGISTERED_MESSAGE(WM_INITUI,OnInitUI)
    ON_WM_CREATE()
    ON_WM_KILLFOCUS()
    ON_WM_SETFOCUS()
END_MESSAGE_MAP()

LRESULT TAutoControlBase::OnInitUI(WPARAM,LPARAM) {
    InitUI();
    return 0;
}

int TAutoControlBase::OnCreate(LPCREATESTRUCT lpCreateStruct) {
   	if (CWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
    InitUI();
    return 0;
}

void TAutoControlBase::OnKillFocus(CWnd* pwndNewFocus) {
    hwndGettingFocus = *pwndNewFocus;
    ::SendMessage(::GetParent(*this),WM_AUTOCONTROLLOOSINGFOCUS,(WPARAM)((HWND)(*this)),(LPARAM)hwndGettingFocus);
    CWnd::OnKillFocus(pwndNewFocus);
}

void TAutoControlBase::OnSetFocus(CWnd* pwndOldFocus) {
    hwndGettingFocus = *this;
    CWnd::OnSetFocus(pwndOldFocus);
}
//***************************************************************************
//
// TAutoRadioButton Implementation
//
//***********
//
// ctors
//
TAutoRadioButton::TAutoRadioButton(int* Api,int AiActive,int AiSizeOf,
                                   const TBaseEnabler& AEnabler,UINT AnIDBuddyStatic)
: TAutoControlBase(AEnabler),pi(Api),iSizeOf(AiSizeOf),nIDBuddyStatic(AnIDBuddyStatic) {
    ASSERT(iSizeOf <= sizeof(int));
    CopyData(&iOriginal,pi);
    CopyData(&iActive,&AiActive);
}
TAutoRadioButton::TAutoRadioButton(UINT nID,CWnd* pParent,int* Api,int AiActive,int AiSizeOf,
                                   const TBaseEnabler& AEnabler,UINT AnIDBuddyStatic)
: TAutoControlBase(nID,pParent,AEnabler),pi(Api),iSizeOf(AiSizeOf),nIDBuddyStatic(AnIDBuddyStatic) {
    ASSERT(iSizeOf <= sizeof(int));
    CopyData(&iOriginal,pi);
    CopyData(&iActive,&AiActive);
}
//
// New TAutoRadioButton functionality
//
bool TAutoRadioButton::SameData(const int* pi1,const int* pi2) const {
    switch (iSizeOf) {
        case sizeof(BYTE):  return *((BYTE*)pi1) == *((BYTE*)pi2);
        case sizeof(WORD):  return *((WORD*)pi1) == *((WORD*)pi2);
        case sizeof(DWORD): return *((DWORD*)pi1) == *((DWORD*)pi2);
     }
     return false; // make the compiler happy
}
void TAutoRadioButton::CopyData(int* piDest,const int* piSrc) const {
     switch (iSizeOf) {
        case sizeof(BYTE):  *((BYTE*)piDest) = *((BYTE*)piSrc);   break;
        case sizeof(WORD):  *((WORD*)piDest) = *((WORD*)piSrc);   break;
        case sizeof(DWORD): *((DWORD*)piDest) = *((DWORD*)piSrc); break;
     }
}
//
// Overridden Functions
//
void TAutoRadioButton::InitUI() {
    TAutoControlBase::InitUI();
    SendMessage(BM_SETCHECK,SameData(&iActive,pi),0);
}
bool TAutoRadioButton::Changed() const {
    return !SameData(pi,&iOriginal);
}
void TAutoRadioButton::BNClicked() {
    if (SendMessage(BM_GETCHECK,0,0) == BST_CHECKED) {
        CopyData(pi,&iActive);    
	}
	//Special case for Radio buttons. Need to do this.
	GetParent()->SendMessage(WM_AUTOCONTROLLOOSINGFOCUS, 1, 1);
}
//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoRadioButton,TAutoControlBase)
    ON_CONTROL_REFLECT_EX(BN_CLICKED,OnBNClicked)
    ON_WM_SETFOCUS()
    ON_WM_KILLFOCUS()
END_MESSAGE_MAP()

void TAutoRadioButton::OnSetFocus(CWnd* pwndOldFocus) {
    TAutoControlBase::OnSetFocus(pwndOldFocus);
    HWND hwnd = ::GetDlgItem(::GetParent(*this),nIDBuddyStatic);
    if (hwnd) ::SendMessage(hwnd,WM_INITUI,0,0);
}
void TAutoRadioButton::OnKillFocus(CWnd* pwndNewFocus) {
    TAutoControlBase::OnKillFocus(pwndNewFocus);
    HWND hwnd = ::GetDlgItem(::GetParent(*this),nIDBuddyStatic);
    if (hwnd) ::SendMessage(hwnd,WM_INITUI,0,0);
}
BOOL TAutoRadioButton::OnBNClicked() {
    BNClicked();
    return FALSE;
}
//***************************************************************************
//
// TAutoRadioButtonWithBitmap Implementation
//
//*************
//
// ctors
//
TAutoRadioButtonWithBitmap::TAutoRadioButtonWithBitmap(int* pi,int iActive,int iSizeOf,
                                                       UINT AnIDStaticDest,UINT AnIDBitmap,
                                                       const TBaseEnabler& AEnabler) 
: TAutoRadioButton(pi,iActive,iSizeOf,AEnabler,AnIDStaticDest),
  nIDBitmap(AnIDBitmap) {
}
TAutoRadioButtonWithBitmap::TAutoRadioButtonWithBitmap(UINT nID,CWnd* pParent,
                                                       int* pi,int iActive,int iSizeOf,
                                                       UINT AnIDStaticDest,UINT AnIDBitmap,
                                                       const TBaseEnabler& AEnabler)
: TAutoRadioButton(nID,pParent,pi,iActive,iSizeOf,AEnabler,AnIDStaticDest),
  nIDBitmap(AnIDBitmap) {
}

void TAutoRadioButtonWithBitmap::InitUI() {
    if (!bInitialized) 
        new TStaticForAutoRadioButton(nIDBuddyStatic,GetParent(),this,nIDBitmap);
    TAutoRadioButton::InitUI();
}
//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoRadioButtonWithBitmap,TAutoRadioButton)
END_MESSAGE_MAP()

//***************************************************************************
//
// TAutoCheckBox Implementation
//
//***********
//
// ctors
//
TAutoCheckBox::TAutoCheckBox(int* Api,int AiActive,int AiInActive,int AiSizeOf,
                             const TBaseEnabler& AEnabler,UINT nIDBuddyStatic)
: TAutoRadioButton(Api,AiActive,AiSizeOf,AEnabler,nIDBuddyStatic) {
    CopyData(&iInActive,&AiInActive); 
}
TAutoCheckBox::TAutoCheckBox(UINT nID,CWnd* pParent,
                             int* Api,int AiActive,int AiInActive,int AiSizeOf,
                             const TBaseEnabler& AEnabler,UINT nIDBuddyStatic)
: TAutoRadioButton(nID,pParent,Api,AiActive,AiSizeOf,AEnabler,nIDBuddyStatic) {
    CopyData(&iInActive,&AiInActive); 
}
//
// Overridden Functions
//
void TAutoCheckBox::InitUI() {
    TAutoControlBase::InitUI();
    SendMessage(BM_SETCHECK,SameData(pi,&iActive),0);
}
void TAutoCheckBox::BNClicked() {
    CopyData(pi,(SendMessage(BM_GETCHECK,0,0) == BST_CHECKED) ? &iActive : &iInActive);
}
//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoCheckBox,TAutoRadioButton)
END_MESSAGE_MAP()
    
//***************************************************************************
//
// TAutoboolCheckBox Implementation
//
//***********
//
// ctors
//
TAutoboolCheckBox::TAutoboolCheckBox(bool* pb,bool bActive,const TBaseEnabler& AEnabler)
: TAutoCheckBox((int*)pb,(int)bActive,(int)(!bActive),sizeof(bool),AEnabler) {
}
TAutoboolCheckBox::TAutoboolCheckBox(UINT nID,CWnd* pParent,bool* pb,bool bActive,const TBaseEnabler& AEnabler)
: TAutoCheckBox(nID,pParent,(int*)pb,(int)bActive,(int)(!bActive),sizeof(bool),AEnabler) {
}
//***************************************************************************
//
// TAutoBOOLCheckBox Implementation
//
//***********
//
// ctors
//
TAutoBOOLCheckBox::TAutoBOOLCheckBox(BOOL* pb,BOOL bActive,const TBaseEnabler& AEnabler)
: TAutoCheckBox((int*)pb,(int)bActive,(int)(!bActive),sizeof(BOOL),AEnabler) {
}
TAutoBOOLCheckBox::TAutoBOOLCheckBox(UINT nID,CWnd* pParent,BOOL* pb,BOOL bActive,const TBaseEnabler& AEnabler)
: TAutoCheckBox(nID,pParent,(int*)pb,(int)bActive,(int)(!bActive),sizeof(BOOL),AEnabler) {
}
//***************************************************************************
//
// TAutoEditBox Implementation
//
//***********
const TAutoEditBox::TDftEnabler TAutoEditBox::dftEnabler;
//
// ctors
//
TAutoEditBox::TAutoEditBox(UINT AuMaxChars,const TBaseEnabler& AEnabler) 
: TAutoControlBase(AEnabler), uMaxChars(AuMaxChars) {
}
TAutoEditBox::TAutoEditBox(UINT nID,CWnd* pParent,UINT AuMaxChars,const TBaseEnabler& AEnabler) 
: TAutoControlBase(nID,pParent,AEnabler), uMaxChars(AuMaxChars) {
}
//
// Overridden Functions
//
// InitUI -- puts formated data in the box
//
void TAutoEditBox::InitUI() {
    int iStart;
    int iStop;
    SendMessage(EM_GETSEL,(WPARAM)(&iStart),(LPARAM)(&iStop));
    CString strText;
    GetWindowText(strText);
    bool bAllSelected = (iStart == 0) && (iStop == strText.GetLength());

    if (!bInitialized) ::SendMessage(*GetParent(),WM_ADDEDITBOX,0,(LPARAM)this);
    TAutoControlBase::InitUI();
    if (uMaxChars > 0) SendMessage(EM_SETLIMITTEXT,uMaxChars,0);
//    const TEnabler* pEnabler = (TEnabler*)(this->pEnabler);
    if (IsWindowEnabled() || enab.GetDisabledText().IsEmpty()) {
        strInitText = DataToText(GetData(),hwndGettingFocus);
        SetWindowText(strInitText);
    } else {
        SetWindowText(enab.GetDisabledText());
        strInitText.Empty();
    }
    if (bAllSelected && IsWindowEnabled()) SendMessage(EM_SETSEL,0,-1);    // reselect all (got undone by initui)
}
void TAutoEditBox::ForceDataSync() {
    ForceDataSync(false);
}
void TAutoEditBox::ForceDataSync(bool bEvenIfSameText) {
    if (!IsWindowEnabled()) return;
    CString str;
    GetWindowText(str);
    if (strInitText != str || bEvenIfSameText) 
        SetData(TextToData(str,hwndGettingFocus));
    strInitText = DataToText(GetData(),hwndGettingFocus);
    SetWindowText(strInitText);
}
//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoEditBox,TAutoControlBase)
    ON_WM_KILLFOCUS()
    ON_WM_SETFOCUS()
    ON_WM_ENABLE()
    ON_WM_LBUTTONDOWN()
END_MESSAGE_MAP()

void TAutoEditBox::OnKillFocus(CWnd* pNewWnd) {
    hwndGettingFocus = *pNewWnd;        // go ahead and do this early for ForceDataSync
    if (bInitialized) ForceDataSync();  // update data from user entered text
    InitUI();   // load box with "no focus" format
    TAutoControlBase::OnKillFocus(pNewWnd); // let parent know we are loosing focus
}
void TAutoEditBox::OnSetFocus(CWnd* pOldWnd) {
    InitUI();   // load box with "has focus" format
    TAutoControlBase::OnSetFocus(pOldWnd);
}
void TAutoEditBox::OnEnable(BOOL bEnabled) {
    InitUI();   // load box with real or disabled text
    CWnd::OnEnable(bEnabled);
}
void TAutoEditBox::OnLButtonDown(UINT uFlags,CPoint point) {
    // If we don't already have focus, we are about to get it. We need to load the box with 
    // the "has focus" format so the button down code can set the anchor point correctly.
    if (::GetFocus() != *this) ::SetFocus(*this);
    TAutoControlBase::OnLButtonDown(uFlags,point);
}
//***************************************************************************
//
// TAutoMemoEditBox Implementation
//
const TAutoMemoEditBox::TDftTranslator TAutoMemoEditBox::dftTrans;
BEGIN_MESSAGE_MAP(TAutoMemoEditBox,TBase)
END_MESSAGE_MAP()
const CString& TAutoMemoEditBox::TDftTranslator::FromString(const char* psz,HWND) const {
    static CString str;
    str = psz;
    return str;
}
CString TAutoMemoEditBox::TDftTranslator::ToString(const CString& strIn,HWND) const {
    CString str = strIn;
    str.TrimLeft();
    str.TrimRight();
    return str;
}
//***************************************************************************
//
// TAutoTextEditBox Implementation
//
//***********
//
// ctors
//
//
// Overridden Functions
//
const void* TAutoTextEditBox::GetData() const {
    return psz;
}
void TAutoTextEditBox::SetData(const void* pv) {
    strcpy(psz,(const char*)pv);
}
CString TAutoTextEditBox::DataToText(const void* pv,HWND) const {
    CString strRet = (const char*)pv;
    return strRet;
}
const void* TAutoTextEditBox::TextToData(const char* pszLoc,HWND) const {
    static CString str;
    str = pszLoc;
    str.TrimLeft();
    str.TrimRight();
    return (const char*)str;
}
#pragma warning(disable:4800) // int to bool warning
bool TAutoTextEditBox::Changed() const {
    return (bool)(strcmp(psz,pszOriginal));
}
#pragma warning(default:4800)

//***************************************************************************
//
// TAutoDoubleEditBox Implementation
//
const TAutoDoubleEditBox::TDftTranslator TAutoDoubleEditBox::dftTrans;
BEGIN_MESSAGE_MAP(TAutoDoubleEditBox,TBase)
END_MESSAGE_MAP()
// Default Translator
//
const double& TAutoDoubleEditBox::TDftTranslator::FromString(const char* psz,HWND) const {
    static double d;
    d = atof(psz);
    return d;
}
CString TAutoDoubleEditBox::TDftTranslator::ToString(const double& dIn,HWND) const {
    CString strRet;
    strRet.Format("%#0.3g",dIn);
    return strRet;
}
bool TAutoDoubleEditBox::TDftTranslator::IsValidChar(char c) const {
    return isdigit(c) || c == VK_BACK || c == '.' || toupper(c) == 'E' || c == '-';
}
// Formatted Translator
//
const double& TAutoDoubleEditBox::TFormattedTranslator::FromString(const char* psz,HWND) const {
    static double d;
    double dOld = d = atof(psz);
    if (d < dMin) d = dMin;
    if (d > dMax) d = dMax;
    if (d != dOld && (dOld == 0.0 || fabs((d - dOld) / dOld) > 0.05)) 
        TAutoControlBase::DeclareMajorChange();
    return d;
}
CString TAutoDoubleEditBox::TFormattedTranslator::ToString(const double& dIn,HWND) const {
    CString strRet;
    if (strFormat.IsEmpty())
        strRet.Format("%#0.3g",dIn);
    else 
        strRet.Format(strFormat,dIn);
    if (bZeroMeansNA && fabs(dIn) < 1E-30) strRet = "NA";
    return strRet;
}
bool TAutoDoubleEditBox::TFormattedTranslator::IsValidChar(char c) const {
    return isdigit(c) || c == VK_BACK || c == '.' || toupper(c) == 'E' ||
           (dMin < 0.0 && c == '-') || 
           (bZeroMeansNA && (toupper(c) == 'N' || toupper(c) == 'A') );
}
// Percent Translator
//
const double& TAutoDoubleEditBox::TPercentTranslator::FromString(const char* psz,HWND) const {
    static double d;
    double dOld = d = atof(psz);
    if (d < 0.0) d = 0.0;
    if (d != dOld && (dOld == 0.0 || fabs((d - dOld) / dOld) > 0.05)) 
        TAutoControlBase::DeclareMajorChange();
    d /= 100.0;
    return d;
}
CString TAutoDoubleEditBox::TPercentTranslator::ToString(const double& dIn,HWND) const {
    CString strRet;
    if (strFormat.IsEmpty())
        strRet.Format("%#0.3g",dIn*100.0);
    else 
        strRet.Format(strFormat,dIn*100.0);
    return strRet;
}
bool TAutoDoubleEditBox::TPercentTranslator::IsValidChar(char c) const {
    return isdigit(c) || c == VK_BACK || c == '.' || toupper(c) == 'E' ||
           (bZeroMeansNA && (toupper(c) == 'N' || toupper(c) == 'A') );
}

//***************************************************************************
//
// TAutoDoubleWithEngUnitsEditBox
//
double TAutoDoubleWithEngUnitsEditBox::TUnitsTable::MultiplierFromIndex(int iIndex) const {
    return pow(10.0,double(3*iIndex + iMinExp) );
}
CString TAutoDoubleWithEngUnitsEditBox::TUnitsTable::UnitsFromIndex(int iIndex) const {
    static const char szPrefix[] = _T("fpn\xB5m kMGT");
    static char sz[] = "x";
    sz[0] = szPrefix[iIndex + iMinExp/3 + 5];
    CString strPrefix = sz;
    return (strPrefix == _T(" ")) ? strUnits : (strPrefix+strUnits);
}
int TAutoDoubleWithEngUnitsEditBox::TUnitsTable::GetNumUnits() const {
    return iMaxExp/3 - iMinExp/3 + 1;
}
BEGIN_MESSAGE_MAP(TAutoDoubleWithEngUnitsEditBox,TAutoNumberWithUnitsEditBoxTmplt<double>)
END_MESSAGE_MAP()

//***************************************************************************
//
// TAutoDWORDEditBox Implementation
//
const TAutoDWORDEditBox::TDftTranslator TAutoDWORDEditBox::dftTrans;
BEGIN_MESSAGE_MAP(TAutoDWORDEditBox,TBase)
END_MESSAGE_MAP()
// Default Translator
//
const DWORD& TAutoDWORDEditBox::TDftTranslator::FromString(const char* psz,HWND) const {
    static DWORD dw;
    dw = strtoul(psz,0,10);
    return dw;
}
CString TAutoDWORDEditBox::TDftTranslator::ToString(const DWORD& dw,HWND) const {
    CString strRet;
    ultoa(dw,strRet.GetBuffer(50),10);
    strRet.ReleaseBuffer();
    return strRet;
}
bool TAutoDWORDEditBox::TDftTranslator::IsValidChar(char c) const {
    return isdigit(c) || c == VK_BACK;
}
// Fancy Translator
//
const DWORD& TAutoDWORDEditBox::TFancyTranslator::FromString(const char* psz,HWND hwndFocus) const {
    static DWORD dw;
    DWORD dwOld = dw = TDftTranslator::FromString(psz,hwndFocus);
    if (dw < dwMin) dw = dwMin;
    if (dw > dwMax) dw = dwMax;
    if (dw != dwOld && (dwOld == 0 || fabs(double(dw - dwOld) / double(dwOld)) > 0.05)) 
        TAutoControlBase::DeclareMajorChange();
    if (pbBlank) *pbBlank = (psz[0] == 0);
    return dw;
}
CString TAutoDWORDEditBox::TFancyTranslator::ToString(const DWORD& dwIn,HWND hwndFocus) const {
    // if we were empty, stay empty -- otherwise convert normally
    if (pbBlank && (*pbBlank)) 
        return _T("");
    else                                    
        return TDftTranslator::ToString(dwIn,hwndFocus);
}

//***************************************************************************
//
// TAutoListBox Implementation
//
//***********
//
// ctors
//
TAutoListBox::TAutoListBox(UINT AuMaxChars,bool AbMatchOnStringsNotItems,const TBaseEnabler& AEnabler) 
: TAutoControlBase(AEnabler), uMaxChars(AuMaxChars),bMatchOnStringsNotItems(AbMatchOnStringsNotItems) {
    uAddStringMsg = uClearStringsMsg = uFindStringMsg = uSetCurSelMsg = uGetStringMsg = 0;
    uGetItemDataMsg = uSetItemDataMsg = uGetCountMsg = 0;
}
TAutoListBox::TAutoListBox(UINT nID,CWnd* pParent,
                           UINT AuMaxChars,bool AbMatchOnStringsNotItems,const TBaseEnabler& AEnabler) 
: TAutoControlBase(nID,pParent,AEnabler), uMaxChars(AuMaxChars),
  bMatchOnStringsNotItems(AbMatchOnStringsNotItems) {
    uAddStringMsg = uClearStringsMsg = uFindStringMsg = uSetCurSelMsg = uGetStringMsg = 0;
    uGetItemDataMsg = uSetItemDataMsg = uGetCountMsg = 0;
}
//
// Functions new to TAutoListBox
//
void TAutoListBox::AddString(const char* psz) {
    ASSERT(uAddStringMsg);
    ASSERT(strlen(psz) <= uMaxChars);
    SendMessage(uAddStringMsg,0,(LPARAM) psz);
}

void TAutoListBox::AddString(const char* psz,LPARAM lp) {
    ASSERT(uAddStringMsg);
    int iIndex = SendMessage(uAddStringMsg,0,(LPARAM) psz);
    SendMessage(uSetItemDataMsg,iIndex,lp);
}

int TAutoListBox::FindString(const char* psz) const {
    int iIndex = -2;
    CString strCompare;
    do {
        iIndex++;
        // get index of first string that matches (case insensitive)
        iIndex = ::SendMessage(*this,uFindStringMsg,(WPARAM)(iIndex),(LPARAM)psz);
        if (iIndex == LB_ERR || iIndex == CB_ERR) return -1;
        // get string at that index
        ::SendMessage(*this,uGetStringMsg,(WPARAM)(iIndex),
                      (LPARAM)(strCompare.GetBuffer(uMaxChars)));
        strCompare.ReleaseBuffer();
    } while (strCompare != psz);
    return iIndex;
}

int TAutoListBox::FindItem(LPARAM lp) const {
    ASSERT(uGetCountMsg);
    int iCount = ::SendMessage(*this,uGetCountMsg,0,0);
    for (int i = 0; i < iCount; i++) 
        if (::SendMessage(*this,uGetItemDataMsg,i,0) == lp) return i;
    return -1;
}

void TAutoListBox::SetControlMsg() {
    char szClass[20];
    ::GetClassName(*this,szClass,sizeof(szClass));
    if (stricmp(szClass,"LISTBOX") == 0) {
        uAddStringMsg = LB_ADDSTRING;
        uClearStringsMsg = LB_RESETCONTENT;
        uFindStringMsg = LB_FINDSTRINGEXACT;
        uSetCurSelMsg = LB_SETCURSEL;
        uGetCurSelMsg = LB_GETCURSEL;
        uGetStringMsg = LB_GETTEXT;
        uSetItemDataMsg = LB_SETITEMDATA;
        uGetItemDataMsg = LB_GETITEMDATA;
        uGetCountMsg = LB_GETCOUNT;
        bComboBox = false;
    }
    else if (stricmp(szClass,"COMBOBOX") == 0) {
        uAddStringMsg = CB_ADDSTRING;
        uClearStringsMsg = CB_RESETCONTENT;
        uFindStringMsg = CB_FINDSTRINGEXACT;
        uSetCurSelMsg = CB_SETCURSEL;
        uGetCurSelMsg = CB_GETCURSEL;
        uGetStringMsg = CB_GETLBTEXT;
        uSetItemDataMsg = CB_SETITEMDATA;
        uGetItemDataMsg = CB_GETITEMDATA;
        uGetCountMsg = CB_GETCOUNT;
        bComboBox = true;
    }
}

bool TAutoListBox::GetSelString(CString* pstr) {
    ASSERT(uAddStringMsg); // bComboBox must already be validated
    char* psz = pstr -> GetBuffer(uMaxChars+1);
    bool bRet = false;
    if (bComboBox) {
        bRet = true;    // WM_GETTEXT can't break!!
        SendMessage(WM_GETTEXT,uMaxChars,(LPARAM)psz);
    } else {
        LRESULT r = SendMessage(LB_GETCURSEL,0,0);
        if (r != LB_ERR)
            bRet = (SendMessage(LB_GETTEXT,r,(LPARAM)psz) != LB_ERR);
    } 
    pstr -> ReleaseBuffer();
    return bRet;
}
bool TAutoListBox::GetSelItem(LPARAM* plparam) {
    ASSERT(uGetCurSelMsg);
    LRESULT r = SendMessage(uGetCurSelMsg,0,0);
    bool bRet = (r != -1);
    if (bRet) *plparam = ::SendMessage(*this,uGetItemDataMsg,r,0);
    return bRet;
}
CString TAutoListBox::DataToText(const void* p) const {
    return (const char*)p;
}
const void* TAutoListBox::TextToData(const char* psz) const {
    return psz;
}
LPARAM TAutoListBox::DataToItem(const void* pd) const {
    return *((LPARAM*)pd);
}
const void* TAutoListBox::ItemToData(LPARAM lp) const {
    static LPARAM lpStatic;
    lpStatic = lp;
    return &lpStatic;
}
//
// Overridden Functions
//
void TAutoListBox::InitUI() {
    TAutoControlBase::InitUI();
    SetControlMsg();
    SendMessage(uClearStringsMsg,0,0);
    SendMessage(WM_SETREDRAW,FALSE,0);
    LoadListBox();
    SendMessage(WM_SETREDRAW,TRUE,0);
    if (bMatchOnStringsNotItems)
        SendMessage(uSetCurSelMsg,FindString(DataToText(GetData())),0);
    else
        SendMessage(uSetCurSelMsg,FindItem(DataToItem(GetData())),0);
}
//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoListBox,TAutoControlBase)
    ON_CONTROL_REFLECT_EX(LBN_SELCHANGE,OnSelChange) // Note that LBN_SELCHANGE = CBN_SELCHANGE
END_MESSAGE_MAP()

BOOL TAutoListBox::OnSelChange() {
    if (bMatchOnStringsNotItems) {
        CString str;
        GetSelString(&str);
        SetData(TextToData(str));
    } else {
        LPARAM lp;
        GetSelItem(&lp);
        SetData(ItemToData(lp));
    }
    return FALSE;
}

//**************************
//
// TAutoIntListBox
//
TAutoIntListBox::TAutoIntListBox(UINT nID,CWnd* pParent,int* Api,const TBaseEnabler& AEnabler)
: TAutoListBox(nID,pParent,0,false,AEnabler),pi(Api),iOriginal(*Api) {
}
bool TAutoIntListBox::Changed() const {
    return *pi != iOriginal;
}
const void* TAutoIntListBox::GetData() const {
    return pi;
}
void TAutoIntListBox::SetData(const void* pv) {
    int* pi = (int*)pv;
    *(this->pi) = *pi;
}
BEGIN_MESSAGE_MAP(TAutoIntListBox,TAutoListBox)
END_MESSAGE_MAP()

//**************************
//
// TAutoUnitsListBox
//
//*******
//
// ctors
//
TAutoUnitsListBox::TAutoUnitsListBox(double* ApdMultiplier,TAutoEditBox* Apeb,
                                     const char* pszUnits,UINT uMaxChars,
                                     int AiMinExp,int AiMaxExp,const TBaseEnabler& AEnabler)
: TAutoListBox(uMaxChars,false,AEnabler),strUnits(pszUnits),
  pdMultiplier(ApdMultiplier),peb(Apeb),pmul(NULL),iMinExp(AiMinExp),iMaxExp(AiMaxExp) {
}
TAutoUnitsListBox::TAutoUnitsListBox(int iID,CWnd* pParent,
                                     double* ApdMultiplier,TAutoEditBox* Apeb,
                                     const char* pszUnits,UINT uMaxChars,
                                     int AiMinExp,int AiMaxExp,const TBaseEnabler& AEnabler)
: TAutoListBox(iID,pParent,uMaxChars,false,AEnabler),strUnits(pszUnits),
  pdMultiplier(ApdMultiplier),peb(Apeb),pmul(NULL),iMinExp(AiMinExp),iMaxExp(AiMaxExp) {
}
TAutoUnitsListBox::~TAutoUnitsListBox() {
    if (pmul) {
        SMultiplier* pmulLoc = pmul;
        while (pmulLoc->psz) {
            delete [] pmulLoc->psz;
            pmulLoc++;
        }
        delete [] pmul;
    }
}
//
// Overrides
//
bool TAutoUnitsListBox::Changed() const {
    return false;   // changing units doesn't change the value
}
LPARAM TAutoUnitsListBox::DataToItem(const void* pd) const {
    double dFindThis = *((double*)pd);
    double dLowestDif = DBL_MAX;
    int iLowestDif;
    for (int i = 0; GetMultiplier(i) != NULL; i++)
        if (fabs(GetMultiplier(i) -> dMultiplier - dFindThis) < dLowestDif) {
            dLowestDif = fabs(GetMultiplier(i) -> dMultiplier - dFindThis);
            iLowestDif = i;
        }
    return iLowestDif;
}
const void* TAutoUnitsListBox::ItemToData(LPARAM lp) const {
    static double d;
    d = GetMultiplier(lp)->dMultiplier;
    return &d;
}
const void* TAutoUnitsListBox::GetData() const {
    return pdMultiplier;   
}
void TAutoUnitsListBox::SetData(const void* pv) {
    *pdMultiplier = *((double*)pv);
}
void TAutoUnitsListBox::LoadListBox() {
    for (int i = 0; GetMultiplier(i) != NULL; i++)
        AddString(GetMultiplier(i) -> psz,i);
}
const SMultiplier* TAutoUnitsListBox::GetMultiplier(int iIndex) const {
    const int iNumMul = iMaxExp/3 - iMinExp/3 + 1;
    if (pmul == NULL) {
        static const char szPrefix[] = _T("fpn\xB5m kMGT");
        ASSERT((iMaxExp/3)*3 == iMaxExp);    // ensure multiples of three
        ASSERT((iMinExp/3)*3 == iMinExp);
        ASSERT(iMaxExp <= 12);              // ensure valid range
        ASSERT(iMinExp >= -15);
        pmul = new SMultiplier[iNumMul+1];
        SMultiplier* pmulLoc = pmul;
        for (int i = iMinExp/3 + 5; i <= iMaxExp/3 + 5; i++,pmulLoc++) {
            pmulLoc->psz = new char[uMaxChars];
            pmulLoc->psz[0] = szPrefix[i];
            pmulLoc->psz[1] = 0;
            strcat(pmulLoc->psz,strUnits);
            pmulLoc->dMultiplier = pow(10.0,(double)(3*(i-5)));
        }
        pmulLoc->psz = NULL;
    }
    if (iIndex >= iNumMul) return NULL;
    return &pmul[iIndex];
}
//
// Message Response Functions
//
BEGIN_MESSAGE_MAP(TAutoUnitsListBox,TAutoListBox)
    ON_WM_KILLFOCUS()
    ON_CONTROL_REFLECT_EX(LBN_SELCHANGE,OnSelChange) // Note that LBN_SELCHANGE = CBN_SELCHANGE
END_MESSAGE_MAP()

void TAutoUnitsListBox::OnKillFocus(CWnd* pNewWnd) {
    if (bInitialized && pNewWnd != peb)
        peb -> ForceDataSync();
    TAutoListBox::OnKillFocus(pNewWnd);
}
BOOL TAutoUnitsListBox::OnSelChange() {
    TAutoListBox::OnSelChange();
    peb->DeclareEdited();
    return FALSE;
}


//***************************************
//
// TAutoPopoutBitmapSelector
//
const UINT TAutoPopoutBitmapSelector::uWindowGoneMsg = 
    ::RegisterWindowMessage(_T("AutoPopoutBitmapSelectorWindowGoneMsg"));

TAutoPopoutBitmapSelector::TAutoPopoutBitmapSelector(int* Api,UINT AnIDStatic,
                                                     const UINT* ApStaticBitmaps,const UINT* ApSelectionBitmaps,
                                                     int AiBitmapsWide,int AiBitmapsHigh,int AiNumBitmaps,
                                                     const TBaseEnabler& AEnabler)
: TBitmapButton(IDB_ARROWDOWN,AEnabler),
  pi(Api),nIDStatic(AnIDStatic),
  pStaticBitmaps(ApStaticBitmaps),pSelectionBitmaps(ApSelectionBitmaps),
  iBitmapsHigh(AiBitmapsHigh),iBitmapsWide(AiBitmapsWide),iNumBitmaps(AiNumBitmaps),pPopoutWnd(0) {
    pStatic = new T3DBitmapStatic(ApStaticBitmaps[*pi]);
    bDontEatClicked = false;
}
TAutoPopoutBitmapSelector::TAutoPopoutBitmapSelector(UINT nID,CWnd* pParent,
                                                     int* Api,UINT AnIDStatic,
                                                     const UINT* ApStaticBitmaps,const UINT* ApSelectionBitmaps,
                                                     int AiBitmapsWide,int AiBitmapsHigh,int AiNumBitmaps,
                                                     const TBaseEnabler& AEnabler)
: TBitmapButton(nID,pParent,IDB_ARROWDOWN,AEnabler),
  pi(Api),nIDStatic(AnIDStatic),
  pStaticBitmaps(ApStaticBitmaps),pSelectionBitmaps(ApSelectionBitmaps),
  iBitmapsHigh(AiBitmapsHigh),iBitmapsWide(AiBitmapsWide),iNumBitmaps(AiNumBitmaps),pPopoutWnd(0) {
    pStatic = new T3DBitmapStatic(nIDStatic,pParent,ApStaticBitmaps[*pi]);
    // ensure static doesn't draw over top of bitmap button if the two overlap
    ::SetWindowLong(*pStatic,GWL_STYLE,::GetWindowLong(*pStatic,GWL_STYLE) | WS_CLIPSIBLINGS);
    bDontEatClicked = false;
}
TAutoPopoutBitmapSelector::~TAutoPopoutBitmapSelector() {
    if (!bAutoDelete) delete pStatic;
}

// since we don't have a DLGC_WANTESCAPE or DLGC_WANTRETURN, we have to cheat
BOOL TAutoPopoutBitmapSelector::PreTranslateMessage(MSG* pMsg) {
	if (!pPopoutWnd || pMsg->message != WM_KEYDOWN) return FALSE;
    switch (pMsg->wParam) {
        case VK_RETURN: *pi = pPopoutWnd->GetSelection();
        case VK_ESCAPE: ::DestroyWindow(*pPopoutWnd);
            return TRUE;
        default:
            return FALSE;
    }
}
BEGIN_MESSAGE_MAP(TAutoPopoutBitmapSelector,TBitmapButton)
    ON_REGISTERED_MESSAGE(uWindowGoneMsg,OnSelectionWindowGone)
    ON_CONTROL_REFLECT_EX(BN_CLICKED,OnBNClicked)
    ON_WM_KILLFOCUS()
    ON_WM_GETDLGCODE()
    ON_WM_KEYDOWN()
    ON_WM_DRAWITEM_REFLECT()
END_MESSAGE_MAP()

BOOL TAutoPopoutBitmapSelector::OnBNClicked() {
    if (bDontEatClicked) {
        bDontEatClicked = false;
        return FALSE;
    }
    if (!pPopoutWnd) {
        pPopoutWnd = new TAutoPopoutBitmapSelectorWindow(this);
        InvalidateRect(NULL,false); // validate focus state
    }
    return TRUE; // eat
}

LPARAM TAutoPopoutBitmapSelector::OnSelectionWindowGone(WPARAM wp,LPARAM) {
    // notify the parent of new selection
    pPopoutWnd = 0;
    InvalidateRect(NULL,FALSE); // validate focus state
    pStatic->SetBitmap(pStaticBitmaps[*pi]);
    int iID = ::GetDlgCtrlID(*this);
    bDontEatClicked = true;
    ::SendMessage(*GetParent(),WM_COMMAND,MAKEWPARAM(iID,BN_CLICKED),(LPARAM)((HWND)(*this)));
    return 0;
}

void TAutoPopoutBitmapSelector::OnKillFocus(CWnd* pwnd) {
    if (pPopoutWnd) ::DestroyWindow(*pPopoutWnd);
    TAutoControlBase::OnKillFocus(pwnd);
}

UINT TAutoPopoutBitmapSelector::OnGetDlgCode() {
    UINT u = CWnd::OnGetDlgCode();
    u |= DLGC_WANTARROWS;
    return u;
}

void TAutoPopoutBitmapSelector::OnKeyDown(UINT nChar,UINT nRepCnt,UINT nFlags) {
    if (pPopoutWnd) {
        if (nChar == VK_F4 || nChar == VK_ESCAPE)
            ::DestroyWindow(*pPopoutWnd);
        else if (nChar == VK_DOWN || nChar == VK_UP || 
            nChar == VK_LEFT || nChar == VK_RIGHT) {
            // pass char to popout
            const MSG* pmsg = GetCurrentMessage();
            pPopoutWnd->SendMessage(pmsg->message,pmsg->wParam,pmsg->lParam);// pass char to popout
        }
    } else if (nChar == VK_DOWN || nChar == VK_F4) OnBNClicked();
    CWnd::OnKeyDown(nChar,nRepCnt,nFlags);
}
void TAutoPopoutBitmapSelector::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) {
    if (pPopoutWnd) lpDrawItemStruct->itemState &= ~ODS_FOCUS;
    TBitmapButton::DrawItem(lpDrawItemStruct);
}
//***************************************
//
// TBitmapButton
//
//***********
//
// ctor
//
TBitmapButton::TBitmapButton(UINT AnIDBitmap,const TBaseEnabler& AEnabler) 
: TAutoControlBase(AEnabler),nIDBitmap(AnIDBitmap) {
    bDefault = false;
}
TBitmapButton::TBitmapButton(UINT nID,CWnd* pParent,UINT AnIDBitmap,const TBaseEnabler& AEnabler) 
: TAutoControlBase(nID,pParent,AEnabler),nIDBitmap(AnIDBitmap) {
    bDefault = false;
}

TBitmapButton::~TBitmapButton() {
}

void TBitmapButton::InitUI() {
    InvalidateRect(NULL,FALSE);
    if (!bInitialized) 
        if (bmpSrc.m_hObject == 0) bmpSrc.LoadBitmap(nIDBitmap);
    TAutoControlBase::InitUI();
}

bool TBitmapButton::Changed() const {
    return false;
}

void TBitmapButton::SetBitmap(UINT AnIDBitmap) {
    if (bInitialized && nIDBitmap != AnIDBitmap) {
        bmpSrc.DeleteObject();
        bmpSrc.LoadBitmap(AnIDBitmap);
    }
    nIDBitmap = AnIDBitmap;
    ::InvalidateRect(*this,0,false);
}

BEGIN_MESSAGE_MAP(TBitmapButton,TAutoControlBase)
    ON_WM_DRAWITEM_REFLECT()
    ON_WM_GETDLGCODE()
    ON_MESSAGE(BM_SETSTYLE,OnSetStyle)
    ON_WM_ENABLE()
END_MESSAGE_MAP()

void TBitmapButton::OnEnable(BOOL bEnable) {
    if (!bEnable && bDefault) {
        bDefault = false;
        InvalidateRect(NULL,false);
    }
    TAutoControlBase::OnEnable(bEnable);
}

LRESULT TBitmapButton::OnSetStyle(WPARAM wParam,LPARAM lParam) {
    bDefault = (LOWORD(wParam) == BS_DEFPUSHBUTTON);
    if (lParam) InvalidateRect(NULL,false);
    return 0;
}

UINT TBitmapButton::OnGetDlgCode() {
    return bDefault ? DLGC_DEFPUSHBUTTON : DLGC_UNDEFPUSHBUTTON;
}

#pragma warning(disable: 4800)
void TBitmapButton::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) {
//    TRACE("DrawItem\n");
    if (!bInitialized) bmpSrc.LoadBitmap(nIDBitmap);
    RECT* prc = &lpDrawItemStruct -> rcItem;
    HDC hdc = lpDrawItemStruct -> hDC;
    bool bSel = (bool)(lpDrawItemStruct -> itemState & ODS_SELECTED);
    bool bDisabled = (bool)(lpDrawItemStruct -> itemState & ODS_DISABLED);
    bool bFocus = (bool)(lpDrawItemStruct -> itemState & ODS_FOCUS);

    // Create a memory dc/bitmap for the whole button area
    RECT rcClient;
    GetClientRect(&rcClient);
    HDC hdcTmp = ::CreateCompatibleDC(hdc);
    HBITMAP hbmpTmp = ::CreateCompatibleBitmap(hdc,rcClient.right,rcClient.bottom);
    HGDIOBJ hbmpTmpOld = ::SelectObject(hdcTmp,hbmpTmp);
    // Create a memory dc/bitmap to hold the source image
    HDC hdcSrc = ::CreateCompatibleDC(hdc);
    HGDIOBJ hbmpSrcOld = ::SelectObject(hdcSrc,bmpSrc);
    BITMAP bmpInfo;
    bmpInfo.bmBits = NULL;
    ::GetObject(bmpSrc,sizeof(BITMAP),&bmpInfo);
    // Draw the button on the tmp dc
    RECT rc = rcClient;
    sr.DrawRect(hdcTmp,&rc,bSel,bDefault,true);

//    ::BitBlt(hdc,0,0,rcClient.right,rcClient.bottom,hdcTmp,0,0,SRCCOPY);

//    RECT rcX = rcClient;
//    sr.DrawRect(hdc,&rcX,bSel,bDefault,true);

    int iWidth = min(bmpInfo.bmWidth,rc.right-rc.left);
    int iHeight = min(bmpInfo.bmHeight,rc.bottom-rc.top);
    int iXDst = (rc.right + rc.left - iWidth) / 2;
    int iYDst = (rc.top + rc.bottom - iHeight) / 2;
    HGDIOBJ hbrshTmpOld = ::SelectObject(hdcTmp,sr.hbrshTxt);
    if (bDisabled) {
        // offset image in 3DHiLight color to source black
        ::SelectObject(hdcTmp,sr.hbrsh3DHiLight);
        ::BitBlt(hdcTmp,iXDst+1,iYDst+1,iWidth,iHeight,hdcSrc,0,0,0x00B8074A);
        ::SelectObject(hdcTmp,sr.hbrsh3DShadow);
//        ::BitBlt(hdc,0,0,rcClient.right,rcClient.bottom,hdcTmp,0,0,SRCCOPY);
    }
    // text (or 3DShadow) color to source black
    ::BitBlt(hdcTmp,iXDst,iYDst,iWidth,iHeight,hdcSrc,0,0,0x00B8074A);
//    ::BitBlt(hdc,0,0,rcClient.right,rcClient.bottom,hdcTmp,0,0,SRCCOPY);
    if (bFocus) ::DrawFocusRect(hdcTmp,&rc);
//    ::BitBlt(hdc,0,0,rcClient.right,rcClient.bottom,hdcTmp,0,0,SRCCOPY);
    // Clean up source image stuff
    ::SelectObject(hdcSrc,hbmpSrcOld);
    ::DeleteDC(hdcSrc);
    // Finally move temp bitmap to display
    ::BitBlt(hdc,0,0,rcClient.right,rcClient.bottom,hdcTmp,0,0,SRCCOPY);
    // Clean up the temp DC
    ::DeleteObject(::SelectObject(hdcTmp,hbmpTmpOld));
    ::SelectObject(hdcTmp,hbrshTmpOld);
    ::DeleteDC(hdcTmp);
}
#pragma warning(default: 4800)
//***************************************
//
// T3DBitmapStatic
//
//***********
//
// ctor
//
T3DBitmapStatic::T3DBitmapStatic(UINT nID,CWnd* pParent,UINT AnIDBitmap) 
: TAutoControlBase(nID,pParent),
  nIDBitmap(AnIDBitmap),hbmpSrc(NULL),hdcSrc(NULL) {
}
T3DBitmapStatic::T3DBitmapStatic(UINT AnIDBitmap) 
: TAutoControlBase(),nIDBitmap(AnIDBitmap),hbmpSrc(NULL),hdcSrc(NULL) {
}

T3DBitmapStatic::~T3DBitmapStatic() {
    if (hdcSrc) {
        ::SelectObject(hdcSrc,hbmpOldSrc);
        ::DeleteDC(hdcSrc);
    }
    if (hbmpSrc) ::DeleteObject(hbmpSrc);
}

void T3DBitmapStatic::InitUI() {
    SetBitmap(nIDBitmap);
    TAutoControlBase::InitUI();
}

void T3DBitmapStatic::SetBitmap(UINT AuIDBitmap) {
    if (bInitialized && nIDBitmap == AuIDBitmap) return;
    nIDBitmap = AuIDBitmap;
    // create and load a dc for the resource bitmap
    HDC hdcRaw = ::CreateCompatibleDC(NULL);
    CBitmap bmpRaw;
    bmpRaw.LoadBitmap(nIDBitmap);
    HGDIOBJ hbmpOldRaw = ::SelectObject(hdcRaw,bmpRaw);
    // we're gonna need the client rect
    CRect rc;
    ::GetClientRect(*this,&rc);
    // create a dc and bitmap for the data member
    if (!hdcSrc) {
        hdcSrc = ::CreateCompatibleDC(NULL);
        if (!hbmpSrc) {
            HDC hdcColor = ::GetDC(NULL);
            if (!hbmpSrc) hbmpSrc = ::CreateCompatibleBitmap(hdcColor,rc.right,rc.bottom);
            ::ReleaseDC(NULL,hdcColor);
        }
        hbmpOldSrc = ::SelectObject(hdcSrc,hbmpSrc);
    }
    // merge the raw bitmap into the member dc
    sr.DrawRect(hdcSrc,&rc,true,false,true);
    HBRUSH hbrshTxt = ::CreateSolidBrush(::GetSysColor(COLOR_WINDOWTEXT));
    HGDIOBJ hbrshOld = ::SelectObject(hdcSrc,hbrshTxt);
    BITMAP bmpInfo; bmpInfo.bmBits = NULL;
    bmpRaw.GetBitmap(&bmpInfo);
    ::BitBlt(hdcSrc,(rc.right - bmpInfo.bmWidth) / 2,(rc.bottom - bmpInfo.bmHeight) / 2,
             bmpInfo.bmWidth,bmpInfo.bmHeight,hdcRaw,0,0,0x00B8074A);
    ::SelectObject(hdcSrc,hbrshOld);
    ::DeleteObject(hbrshTxt);
    // clean up the raw dc
    ::SelectObject(hdcRaw,hbmpOldRaw);
    ::DeleteDC(hdcRaw);
    InvalidateRect(NULL,FALSE);
}

BEGIN_MESSAGE_MAP(T3DBitmapStatic,TAutoControlBase)
    ON_WM_PAINT()
END_MESSAGE_MAP()

void T3DBitmapStatic::OnPaint() {
    CPaintDC dc(this);
    RECT rc;
    GetClientRect(&rc);
    ::BitBlt(dc,0,0,rc.right,rc.bottom,hdcSrc,0,0,SRCCOPY);
}

bool T3DBitmapStatic::Changed() const {
    return false;
}
//***************************************
//
// TStaticForAutoRadioButton
//
TStaticForAutoRadioButton::
    TStaticForAutoRadioButton(UINT nID,CWnd* pParent,
                              TAutoRadioButton* ApButton,UINT AnIDBitmap) 
: TAutoControlBase(nID,pParent),pButton(ApButton),
  nIDBitmap(AnIDBitmap),hbmpSrc(NULL),hdcSrc(NULL) {
}

TStaticForAutoRadioButton::
    ~TStaticForAutoRadioButton() {
    if (hdcSrc) ::DeleteDC(hdcSrc);
    if (hbmpSrc) ::DeleteObject(hbmpSrc);
}

void TStaticForAutoRadioButton::InitUI() {
    InvalidateRect(NULL,FALSE); // force a repaint
    if (!bInitialized) BuildBitmap();
    TAutoControlBase::InitUI();
}

void TStaticForAutoRadioButton::BuildBitmap() {
    if (hdcSrc) ::DeleteDC(hdcSrc);
    if (hbmpSrc) ::DeleteObject(hbmpSrc);
    CRect rcClient; ::GetClientRect(*this,&rcClient);
    // create and load a dc for the resource bitmap
    CDC dcRaw; dcRaw.CreateCompatibleDC(NULL);
    CBitmap bmpRaw;
    if (nIDBitmap) 
        bmpRaw.LoadBitmap(nIDBitmap);
    else 
        bmpRaw.CreateCompatibleBitmap(&dcRaw,rcClient.right,rcClient.bottom);
    HGDIOBJ hOldRawBmp = ::SelectObject(dcRaw,bmpRaw);
    DrawOnBitmap(dcRaw);
    // create a dc and bitmap for the data member
    hdcSrc = ::CreateCompatibleDC(NULL);
    HDC hdcColor = ::GetDC(NULL);
    hbmpSrc = ::CreateCompatibleBitmap(hdcColor,rcClient.right,rcClient.bottom);
    ::ReleaseDC(NULL,hdcColor);
    ::SelectObject(hdcSrc,hbmpSrc);
    // merge the raw bitmap into the member dc
    ::FillRect(hdcSrc,&rcClient,(HBRUSH)(COLOR_3DFACE + 1));
    HBRUSH hbrsh = ::CreateSolidBrush(::GetSysColor(COLOR_WINDOWTEXT));
    HGDIOBJ hbrshOld = ::SelectObject(hdcSrc,hbrsh);
    BITMAP bmpInfo;
    bmpInfo.bmBits = NULL;
    GetObject(bmpRaw,sizeof(BITMAP),&bmpInfo);
    ::BitBlt(hdcSrc,(rcClient.right - bmpInfo.bmWidth) / 2,(rcClient.bottom - bmpInfo.bmHeight) / 2,
             bmpInfo.bmWidth,bmpInfo.bmHeight,dcRaw,0,0,0x00B8074A);
    ::DeleteObject(::SelectObject(hdcSrc,hbrshOld));
    ::SelectObject(dcRaw,hOldRawBmp);
}

void TStaticForAutoRadioButton::DrawOnBitmap(HDC hdc) {
}

bool TStaticForAutoRadioButton::Changed() const {
    return false;
}

bool TStaticForAutoRadioButton::PointOnUs(CPoint point) {
    ASSERT(pButton);
    CRect rc;
    ::GetClientRect(*this,&rc);
    if (rc.PtInRect(point)) return true;
    ::GetWindowRect(*pButton,&rc);
    ::MapWindowPoints(NULL,*this,(POINT*)(&rc),2);
    if (rc.PtInRect(point)) return true;
    return false;
}

BEGIN_MESSAGE_MAP(TStaticForAutoRadioButton,TAutoControlBase)
    ON_WM_PAINT()
    ON_WM_LBUTTONDOWN()
    ON_WM_LBUTTONUP()
    ON_WM_MOUSEMOVE()
    ON_WM_NCHITTEST()
END_MESSAGE_MAP()

void TStaticForAutoRadioButton::OnPaint() {
    CPaintDC dc(this);
    RECT rc;
    GetClientRect(&rc);
    ::BitBlt(dc,0,0,rc.right,rc.bottom,hdcSrc,0,0,SRCCOPY);
    if (pButton && ::GetFocus() == (HWND)(*pButton))
        ::DrawFocusRect(dc,&rc);
}

void TStaticForAutoRadioButton::OnLButtonDown(UINT nFlags, CPoint) {
    if (!pButton) return;
    ::SetFocus(*pButton);
    ::SendMessage(*pButton,BM_SETSTATE,1,0);    // make it look down
    ::SetCapture(*this);
}

void TStaticForAutoRadioButton::OnLButtonUp(UINT nFlags, CPoint point) {
    if (!pButton) return;
    ::SendMessage(*pButton,BM_SETSTATE,0,0);    // make it look up
    if (PointOnUs(point)) {
        // if we are our buddy is a radio button, uncheck all other buttons and check our button
        if ((pButton->GetStyle() & 0xf) == BS_RADIOBUTTON ||
            (pButton->GetStyle() & 0xf) == BS_AUTORADIOBUTTON) {
            HWND hwndOtherButton = *pButton;
            do {
                hwndOtherButton = ::GetNextDlgGroupItem(::GetParent(*this),hwndOtherButton,FALSE);
                ::SendMessage(hwndOtherButton,BM_SETCHECK,BST_UNCHECKED,0);
            } while (hwndOtherButton != (HWND)(*pButton));
            ::SendMessage(*pButton,BM_SETCHECK,BST_CHECKED,0);
        } else {    // else our buddy is a check box so just toggle his check
            bool bChecked = (::SendMessage(*pButton,BM_GETCHECK,0,0) == BST_CHECKED);
            ::SendMessage(*pButton,BM_SETCHECK,bChecked ? BST_UNCHECKED : BST_CHECKED,0);
        }
        // make auto radio button think it got clicked
        pButton->BNClicked();
        // send WM_COMMAND message to parent as if the user clicked the button
        ::SendMessage(::GetParent(*this),WM_COMMAND,
                      MAKEWPARAM(::GetWindowLong(*pButton,GWL_ID),BN_CLICKED),
                      (LPARAM)((HWND)(*pButton)));
    }
    ::ReleaseCapture();
}

void TStaticForAutoRadioButton::OnMouseMove(UINT /*nFlags*/,CPoint point) {
    if (!pButton) return;
    if (::GetCapture() != (HWND)(*this)) return;
    // note point is relative to our client upper left
    ::SendMessage(*pButton,BM_SETSTATE,PointOnUs(point),0);
}

UINT TStaticForAutoRadioButton::OnNcHitTest(CPoint) {
    // we are all client
    return HTCLIENT;
}
//***************************************
//
// TFancyStatic
//
TFancyStatic::TFancyStatic(UINT nID,CWnd* pParent,TAutoRadioButton* pBuddyButton) 
: TStaticForAutoRadioButton(nID,pParent,pBuddyButton,0) {
}
TFancyStatic::~TFancyStatic() {
    ClearList();
}
void TFancyStatic::ClearList() {
    if (!lstptp.IsEmpty()) {
        TPOSITION pos = lstptp.GetHeadPosition();
        while (pos) delete lstptp.GetNext(pos);
    }
    lstptp.RemoveAll();        
}
int TFancyStatic::GetTextPixelWidth() const {
    CString strAllText; GetWindowText(strAllText);
    strAllText.Replace(_T("~n"),_T(""));
    strAllText.Replace(_T("~s"),_T(""));
    strAllText.Replace(_T("~S"),_T(""));
    HDC hdc = ::GetDC(0);
    HGDIOBJ hOldFont = ::SelectObject(hdc,(HGDIOBJ)::SendMessage(*this,WM_GETFONT,0,0));
    SIZE sz;
    ::GetTextExtentPoint32(hdc,strAllText,strAllText.GetLength(),&sz);
    ::SelectObject(hdc,hOldFont);
    ::ReleaseDC(0,hdc);
    return sz.cx;
}
void TFancyStatic::DrawOnBitmap(HDC hdc) {
    ClearList();
    HFONT hfontNormal = *GetFont();
    HGDIOBJ hfontOld = ::SelectObject(hdc,hfontNormal);
    RECT rcClient;
    GetClientRect(&rcClient);
    ::FillRect(hdc,&rcClient,(HBRUSH)::GetStockObject(WHITE_BRUSH));
    if (!strCode.IsEmpty()) {               // save lots of work for empty code strings
        // first separate the sections and find out how to draw them
        char* psz = strdup(strCode);        // get a copy we can muck with
        TTextPiece* ptp = new TTextPiece;   // allocate first piece struct
        ptp->cDraw = 'n';                   // default text is normal
        const char* pszStart = psz;         // start at the beginning
        char* pszTilde;                     // VC++5.0 won't let us declare this in the while statement!
        while (pszTilde = strchr(pszStart,'~')) {
            *pszTilde = 0;              // zero terminate section at ~
            if (*pszStart) {            // if we found a valid text section (won't be if code starts w/ ~)
                ptp->str = pszStart;    // copy section to piece struct
                lstptp.AddTail(ptp);    // declare new piece found
                ptp = new TTextPiece;   // create a new one to fill in
            }
            ptp->cDraw = pszTilde[1];   // get how to draw
            pszStart = &pszTilde[2];    // set starting location of next section
        }
        ptp->str = pszStart;    // add last section
        lstptp.AddTail(ptp);
        free(psz);
        // now size and position each section
        bool bRight2Left = ((GetStyle() & SS_RIGHT) != 0);
        TEXTMETRIC tm;
        ::GetTextMetrics(hdc,&tm);
        TPOSITION pos = bRight2Left ? lstptp.GetTailPosition() : lstptp.GetHeadPosition();
        int iXOffset = 0;
        while (pos) {
            TTextPiece* ptp = bRight2Left ? lstptp.GetPrev(pos) : lstptp.GetNext(pos);
            ptp->rc.top = ptp->rc.left = 0;
            ::DrawText(hdc,ptp->str,-1,&ptp->rc,DT_SINGLELINE | DT_CALCRECT);
            iXOffset += ptp->rc.right;
            int iYOffset;
            switch (ptp->cDraw) {
                case 'n': iYOffset = 0; break;
                case 's': iYOffset = tm.tmHeight/2-1; break;
                case 'S': iYOffset = -(tm.tmHeight/2-1); break;
                default: ASSERT(0);
            }
            ::OffsetRect(&ptp->rc,bRight2Left ? (rcClient.right-iXOffset) : (iXOffset - ptp->rc.right),iYOffset);
        }
    }
    if (!lstptp.IsEmpty()) {
        TPOSITION pos = lstptp.GetHeadPosition();
        while (pos) {
            TTextPiece* ptp = lstptp.GetNext(pos);
            ::DrawText(hdc,ptp->str,-1,&ptp->rc,DT_SINGLELINE);
        }
    }
    ::SelectObject(hdc,hfontOld);
}
BEGIN_MESSAGE_MAP(TFancyStatic,TStaticForAutoRadioButton)
    ON_WM_PAINT()
END_MESSAGE_MAP()

void TFancyStatic::OnPaint() {
    CString str; GetWindowText(str);
    if (str != strCode) {
        strCode = str;
        BuildBitmap();
    }
    TStaticForAutoRadioButton::OnPaint();
}
//*******************************************************
//
// TMyDialogExtraStuff
//
const UINT TMyDialogExtraStuff::WM_DIALOGEVENT = ::RegisterWindowMessage("EGGINC_WM_DIALOGEVENT");
//
// ctor
//
TMyDialogExtraStuff::TMyDialogExtraStuff() {
    iNumEditBoxes = 0;
    bSubDialogsCreated = false;
}
TMyDialogExtraStuff::~TMyDialogExtraStuff() {
    if (!bSubDialogsCreated) DestroySubDialogs();
}

//TMyDialogExtraStuff::SubDlg
void TMyDialogExtraStuff::DestroySubDialogs() {
    if (!lstwndSubDialogs.IsEmpty()) {
        TPOSITION pos = lstwndSubDialogs.GetHeadPosition();
        while (pos) {
            CWnd* p = lstwndSubDialogs.GetNext(pos);
            if (bSubDialogsCreated)
                p->DestroyWindow();
            else
                delete p;
        }
        lstwndSubDialogs.RemoveAll();
    }
    bSubDialogsCreated = false;
    bLastToBottom = false;
}
void TMyDialogExtraStuff::AddSubDialogs(CWnd* pParent,const TList<CWnd*>* plstwnd,int AiIDInsertAfter,const RECT* prc) {
    DestroySubDialogs();
    lstwndSubDialogs = *plstwnd;
    iIDInsertAfter = AiIDInsertAfter;
    if (prc == 0) 
        ::SetRectEmpty(&rcSubDialogs);
    else 
        rcSubDialogs = *prc;
    if (pParent->GetSafeHwnd()) CreateSubDialogs(pParent);
}
void TMyDialogExtraStuff::AppendSubDialogToBottom(CWnd* pParent,CWnd* pSubDialog) {
    ASSERT(!bLastToBottom);     // only ONE bottom sub dialog please
    bLastToBottom = true;
    lstwndSubDialogs.AddTail(pSubDialog);
    if (bSubDialogsCreated) CreateBottomSubDialog(pParent);
}
void TMyDialogExtraStuff::AddEditBox(TAutoEditBox* pebNew) {
    ASSERT(iNumEditBoxes != 20);
    peb[iNumEditBoxes++] = pebNew;
}
void TMyDialogExtraStuff::ForceEditBoxSync() {
    // if auto edit box has focus when default button is activated,
    // then the edit box hasn't lost focus yet and data is not yet
    // synchronized... so we do it manually
    for (int i = 0; i < iNumEditBoxes; i++) peb[i]->ForceDataSync();
}
void TMyDialogExtraStuff::UpdateSubDialogsData() {
    if (!lstwndSubDialogs.IsEmpty()) {
        TPOSITION pos = lstwndSubDialogs.GetHeadPosition();
        while (pos) {
            CWnd* pwnd = lstwndSubDialogs.GetNext(pos);
            if (!pwnd->UpdateData(TRUE)) 
                AfxThrowUserException();
        }
    }
}
void TMyDialogExtraStuff::CreateSubDialogs(CWnd* pParent) {
    ASSERT(!bSubDialogsCreated);
    ASSERT(pParent->GetSafeHwnd());
    bSubDialogsCreated = true;
    // now really insert the subdialogs
    if (!lstwndSubDialogs.IsEmpty()) {
        if (::IsRectEmpty(&rcSubDialogs))
            pParent->GetClientRect(&rcSubDialogs);
        int iRowTop = rcSubDialogs.top; // top position of all sub-dialogs on the current row
        int iRowBottom = iRowTop;       // bottom position highest sub-dialog on the current row
        int iRowLeft = rcSubDialogs.left;
        const int iTotalWidth = rcSubDialogs.right - rcSubDialogs.left;
        TPOSITION pos = lstwndSubDialogs.GetHeadPosition();
        while (pos) {
            CWnd* pwnd = lstwndSubDialogs.GetNext(pos);
            if (!pos && bLastToBottom) break;
            RECT rc;
            pwnd->GetWindowRect(&rc);
            ::OffsetRect(&rc,-rc.left,-rc.top);             // normalize to top left = (0,0) 
            if (rc.right + iRowLeft > rcSubDialogs.right) { // if we don't have room on current row
                iRowTop = iRowBottom;
                iRowLeft = rcSubDialogs.left;
            }
            if (iRowLeft == rcSubDialogs.left &&
                rc.right > iTotalWidth / 2) {
                ::OffsetRect(&rc,(iTotalWidth - rc.right) / 2,0);
            } 
            ::OffsetRect(&rc,iRowLeft,iRowTop);         // shift subdialog position
            iRowLeft = rc.right;                        // move next left side to current right side
            iRowBottom = max(iRowBottom,rc.bottom);     // move bottom down if necessary
            pwnd->MoveWindow(&rc,FALSE);
        }
        HWND hwndInsertAfter = ::GetDlgItem(*pParent,iIDInsertAfter);
        // loop again to set the parent and show
        // this goes in reverse order so tab order will work out ?????
        pos = lstwndSubDialogs.GetTailPosition();
        if (bLastToBottom) lstwndSubDialogs.GetPrev(pos);
        hwndLastInserted = hwndInsertAfter;
        while (pos) {
            CWnd* pwnd = lstwndSubDialogs.GetPrev(pos);
            pwnd->SetParent(pParent);
            if (hwndInsertAfter) ::SetWindowPos(*pwnd,hwndInsertAfter,0,0,0,0,
                                               SWP_NOACTIVATE | SWP_NOMOVE | SWP_NOSIZE);
            pwnd->ShowWindow(SW_SHOW);
            hwndLastInserted = *pwnd;
        }
        if (bLastToBottom) CreateBottomSubDialog(pParent);
        // loop to relay dialog events where we can
        pos = lstwndSubDialogs.GetTailPosition();
        while (pos) {
            CWnd* pwnd = lstwndSubDialogs.GetPrev(pos);
            TMyDialog* pdlg = dynamic_cast<TMyDialog*>(pwnd);
            if (pdlg) pdlg->notifier.Notify(*pParent,WM_DIALOGEVENT);
        }
    }
}
void TMyDialogExtraStuff::CreateBottomSubDialog(CWnd* pParent) {
    CWnd* pwnd = lstwndSubDialogs.GetTail();
    RECT rc;
    pwnd->GetWindowRect(&rc);
    ::OffsetRect(&rc,-rc.left,-rc.top);  // normalize to top left = (0,0) 
    const int iTotalWidth = rcSubDialogs.right - rcSubDialogs.left;
    if (rc.right > iTotalWidth / 2) {    // horizontal center if greater than half width of parent
        ::OffsetRect(&rc,(iTotalWidth - rc.right) / 2,0);
    } 
    int iRowTop = rcSubDialogs.bottom - rc.bottom;
    ::OffsetRect(&rc,0,iRowTop);         // shift subdialog position
    pwnd->MoveWindow(&rc,FALSE);
    pwnd->SetParent(pParent);
    if (hwndLastInserted) ::SetWindowPos(*pwnd,hwndLastInserted,0,0,0,0,
                                         SWP_NOACTIVATE | SWP_NOMOVE | SWP_NOSIZE);
    pwnd->ShowWindow(SW_SHOW);
}

int TMyDialogExtraStuff::MyBetterOnToolHitTest(const CWnd* pwnd,CPoint point, TOOLINFO* pTI) const {
    // The stock MFC CWnd::OnToolHitTest function won't always work for buttons inside a group box. This is because
    // its check loop will exit if it sees the point of interest is within the group box before it sees the point of 
    // interest is within the button. It doesn't bother to see if the child window is transparent! To fix this, we
    // have to override the OnToolHitTest function (which thank goodness, is declared virtual).
    // The code below is mostly a combination of MFC source for the _AfxChildWindowFromPoint and CWnd::OnToolHitTest.
    // The original call to the offending _AfxChildWindowFromPoint function is replaced with a modified version of 
    // its source which handles transparent windows correctly.
    //  
	// check child windows
	::ClientToScreen(*pwnd, &point);
    HWND hwndTheChild = 0;  // assume won't be found
	HWND hWndChild = ::GetWindow(*pwnd, GW_CHILD);
	for (; hWndChild != NULL; hWndChild = ::GetWindow(hWndChild, GW_HWNDNEXT))
	{
		if (((UINT)(WORD)::GetDlgCtrlID(hWndChild)) != (WORD)-1 &&  // BFS: probably a check for a static with ID = -1
			(::GetWindowLong(hWndChild, GWL_STYLE) & WS_VISIBLE))
		{
            // see if point window is transparent first!
            if (SendMessage(hWndChild,WM_NCHITTEST,0,
                MAKELONG(point.x,point.y)) == HTTRANSPARENT) continue;

			// see if point hits the child window
			CRect rect;
			::GetWindowRect(hWndChild, rect);
			if (rect.PtInRect(point)) {
                hwndTheChild = hWndChild;
                break;
            }
		}
	}
    // find child window which hits the point
    // (don't use WindowFromPoint, because it ignores disabled windows)
    // HWND hWndChild = _AfxChildWindowFromPoint(m_hWnd, point);
    if (hwndTheChild != NULL)
    {
        // return positive hit if control ID isn't -1
        int nHit = ((UINT)(WORD)::GetDlgCtrlID(hwndTheChild));

        // hits against child windows always center the tip
        if (pTI != NULL && pTI->cbSize >= 0x28/*sizeof(/*AfxOldTOOLINFO)*/)   // BFS: hope this works (can't see AfxOldTOOLINFO)
        {
            // setup the TOOLINFO structure
            pTI->hwnd = *pwnd;
            pTI->uId = (UINT)hwndTheChild;
            pTI->uFlags |= TTF_IDISHWND;
            pTI->lpszText = LPSTR_TEXTCALLBACK;

            // set TTF_NOTBUTTON and TTF_CENTERTIP if it isn't a button
            if (!(::SendMessage(hwndTheChild, WM_GETDLGCODE, 0, 0) & DLGC_BUTTON))
                pTI->uFlags |= TTF_NOTBUTTON|TTF_CENTERTIP;
        }
        return nHit;
    }
    return -1;  // not found
}
void TMyDialogExtraStuff::ExtraStuffOnToolTipNeedText(NMHDR* pNMHDR,LRESULT* pResult ) {
    TOOLTIPTEXT *pTTT = (TOOLTIPTEXT*)pNMHDR;    
    int nID = pNMHDR->idFrom;
    if (pTTT->uFlags & TTF_IDISHWND) nID = ::GetDlgCtrlID((HWND)nID);
    CString str;
    str.LoadString(nID);
    strcpy(pTTT->szText,str);
}
//*******************************************************
//
// TMyDialog
//
// ctor
//

#pragma warning(disable:4355) // this ptr used in initializer list
TMyDialog::TMyDialog(UINT nIDTemplate,CWnd* pParentWnd)
: CDialog(nIDTemplate,pParentWnd),notifier((LPARAM)this) {
    bModeless = false;
}
TMyDialog::TMyDialog()
: notifier((LPARAM)this) {
    bModeless = false;
}
#pragma warning(default:4355)
//
// New TMyDialog functionality
//
void TMyDialog::SetResourceID(int id) {
	m_lpszTemplateName = MAKEINTRESOURCE(id);
	m_nIDHelp = id;
}
void TMyDialog::DoModeless(CWnd* pParent) {
    ASSERT(m_lpszTemplateName != NULL);
    bModeless = true;
    Create(m_lpszTemplateName,pParent ? pParent : m_pParentWnd);
}
//
// Overrides
//
void TMyDialog::DoDataExchange(CDataExchange* pDX) {
    CDialog::DoDataExchange(pDX);
    if (pDX -> m_bSaveAndValidate) {
        ForceEditBoxSync();
        UpdateSubDialogsData();
    }
}
BOOL TMyDialog::OnInitDialog() {
    CDialog::OnInitDialog();
    CreateSubDialogs(this);
    return TRUE;
}
void TMyDialog::PostNcDestroy() {
    if (bModeless) delete this;
    else CDialog::PostNcDestroy();
}
void TMyDialog::InitUI() {
    SendMessageToDescendants(WM_INITUI,0,0,FALSE,TRUE);
}
int TMyDialog::OnToolHitTest(CPoint point, TOOLINFO* pTI) const {
    return MyBetterOnToolHitTest(this,point,pTI);
//    return CDialog::OnToolHitTest(point,pTI);
}
BEGIN_MESSAGE_MAP(TMyDialog,CDialog)
    ON_REGISTERED_MESSAGE(WM_ADDEDITBOX,OnAddEditBox)
    ON_REGISTERED_MESSAGE(WM_INITUI,OnInitUI)
    ON_REGISTERED_MESSAGE(TAutoControlBase::WM_AUTOCONTROLLOOSINGFOCUS,OnAutoControlLoosingFocus)
    ON_REGISTERED_MESSAGE(TMyDialogExtraStuff::WM_DIALOGEVENT,OnDialogEvent)
    ON_NOTIFY(TTN_NEEDTEXT,0,OnToolTipNeedText)
END_MESSAGE_MAP()

LRESULT TMyDialog::OnAddEditBox(WPARAM wParam,LPARAM lParam) {
    TAutoEditBox* p = (TAutoEditBox*)lParam;
    AddEditBox(p);
    return 0;
}
LRESULT TMyDialog::OnInitUI(WPARAM,LPARAM) {
    InitUI();
    return 0;
}
LRESULT TMyDialog::OnAutoControlLoosingFocus(WPARAM wp,LPARAM lp) {
    ::SendMessage(::GetParent(*this),TAutoControlBase::WM_AUTOCONTROLLOOSINGFOCUS,wp,lp);
    return 0;
}
LRESULT TMyDialog::OnDialogEvent(WPARAM wp,LPARAM lp) {
    notifier.DeclareEvent(wp);
    return 0;
}
void TMyDialog::OnCancel() {
    if (!bModeless) CDialog::OnCancel();
}
void TMyDialog::OnOK() {
    if (!bModeless) CDialog::OnOK();
}
void TMyDialog::OnToolTipNeedText(NMHDR* pNMHDR,LRESULT* pResult ) {
    ExtraStuffOnToolTipNeedText(pNMHDR,pResult);
}
//BOOL TMyDialog::OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo) 
//{
//	// Gary added this function to route the command message to parent dialog
//	//if the command message is not handled by this dialog
//	BOOL bRet =  CDialog::OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
//	if(!bRet){
//		CWnd* pParent = GetParent();
//		if(pParent){
//			return pParent->OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
//		}
//	}
//
//	return bRet;
//}

//*******************************************************
//
// TMyPropertyPage
//
// ctor
//
#pragma warning(disable:4355) // this ptr used in initializer list
TMyPropertyPage::TMyPropertyPage(UINT nIDTemplate,UINT nIDCaption)
: CPropertyPage(nIDTemplate,nIDCaption),notifier((LPARAM)this) {
}
#pragma warning(default:4355)
//
// Overrides
//
void TMyPropertyPage::DoDataExchange(CDataExchange* pDX) {
    CPropertyPage::DoDataExchange(pDX);
    if (pDX->m_bSaveAndValidate) {
        ForceEditBoxSync();         // in case focus hasn't moved off edit control yet
        UpdateSubDialogsData();
    }
}

BOOL TMyPropertyPage::OnInitDialog() {
    CPropertyPage::OnInitDialog();
    CreateSubDialogs(this);
    return TRUE;
}
void TMyPropertyPage::InitUI() {
    SendMessageToDescendants(WM_INITUI,0,0,FALSE,TRUE);
}
int TMyPropertyPage::OnToolHitTest(CPoint point, TOOLINFO* pTI) const {
    return MyBetterOnToolHitTest(this,point,pTI);
}
BEGIN_MESSAGE_MAP(TMyPropertyPage,CPropertyPage)
    ON_REGISTERED_MESSAGE(WM_ADDEDITBOX,OnAddEditBox)
    ON_REGISTERED_MESSAGE(WM_INITUI,OnInitUI)
    ON_REGISTERED_MESSAGE(TAutoControlBase::WM_AUTOCONTROLLOOSINGFOCUS,OnAutoControlLoosingFocus)
    ON_REGISTERED_MESSAGE(TMyDialogExtraStuff::WM_DIALOGEVENT,OnDialogEvent)
    ON_NOTIFY(TTN_NEEDTEXT,0,OnToolTipNeedText)
END_MESSAGE_MAP()

LRESULT TMyPropertyPage::OnAddEditBox(WPARAM wParam,LPARAM lParam) {
    TAutoEditBox* p = (TAutoEditBox*)lParam;
    AddEditBox(p);
    return 0;
}
LRESULT TMyPropertyPage::OnInitUI(WPARAM,LPARAM) {
    InitUI();
    return 0;
}
LRESULT TMyPropertyPage::OnAutoControlLoosingFocus(WPARAM wp,LPARAM lp) {
    ::SendMessage(::GetParent(*this),TAutoControlBase::WM_AUTOCONTROLLOOSINGFOCUS,wp,lp);
    return 0;
}
LRESULT TMyPropertyPage::OnDialogEvent(WPARAM wp,LPARAM lp) {
    notifier.DeclareEvent(wp);
    return 0;
}
void TMyPropertyPage::OnToolTipNeedText(NMHDR* pNMHDR,LRESULT* pResult ) {
    ExtraStuffOnToolTipNeedText(pNMHDR,pResult);
}
//***************************************
//
// MODULE PRIVATE CLASS IMPLEMENTATIONS
//
//***************************************
//
// TAutoPopoutBitmapSelectorWindow
//
TAutoPopoutBitmapSelectorWindow::TAutoPopoutBitmapSelectorWindow(TAutoPopoutBitmapSelector* ApButton)
: pButton(ApButton),bIgnoreCaptureChange(false),
  iCols(ApButton->iBitmapsWide),iRows(ApButton->iBitmapsHigh),
  iNumBitmaps(ApButton->iNumBitmaps) {
    pbitmaps = new CBitmap[iNumBitmaps];
    for (int iBitmap = 0; iBitmap < iNumBitmaps; iBitmap++) 
        pbitmaps[iBitmap].LoadBitmap(pButton->pSelectionBitmaps[iBitmap]);
	BITMAP bm; bm.bmBits = NULL;
	pbitmaps[0].GetBitmap(&bm);
    iBitmapWidth = bm.bmWidth;
    iBitmapHeight = bm.bmHeight;
    iSelection = *pButton->pi;

    int iWindowWidth = 1+iCols*(iBitmapWidth+1);
    int iWindowHeight = 1+iRows*(iBitmapHeight+1);
    HWND hwndActive = ::GetActiveWindow();
    RECT rcButton;
    pButton->GetWindowRect(&rcButton);
    POINT ptOrigin; 
    ptOrigin.x = rcButton.left-iWindowWidth; 
    ptOrigin.y = rcButton.top;
    CString strWndClass = ::AfxRegisterWndClass(0,AfxGetApp()->LoadStandardCursor(IDC_ARROW),
                                                (HBRUSH)::GetStockObject(BLACK_BRUSH));
	CreateEx(0,strWndClass,NULL,WS_POPUP,
             ptOrigin.x,ptOrigin.y,iWindowWidth,iWindowHeight,hwndActive,0,0);
    ::ShowWindow(*this,SW_SHOWNOACTIVATE);
    ::SetCapture(*this);
}
TAutoPopoutBitmapSelectorWindow::~TAutoPopoutBitmapSelectorWindow() {
    delete [] pbitmaps;
}
void TAutoPopoutBitmapSelectorWindow::PostNcDestroy() {
	delete this;
}
BEGIN_MESSAGE_MAP(TAutoPopoutBitmapSelectorWindow,CWnd)
    ON_WM_KEYDOWN()
    ON_WM_LBUTTONUP()
    ON_WM_MOUSEMOVE()
    ON_WM_CAPTURECHANGED()
    ON_WM_NCDESTROY()
    ON_WM_PAINT()
END_MESSAGE_MAP()

void TAutoPopoutBitmapSelectorWindow::OnNcDestroy() {
    bIgnoreCaptureChange = true;
    if (::GetCapture() == *this) ::ReleaseCapture();
    pButton->SendMessage(TAutoPopoutBitmapSelector::uWindowGoneMsg,0,0);
    CWnd::OnNcDestroy();
}
void TAutoPopoutBitmapSelectorWindow::OnKeyDown(UINT nChar,UINT nRepCnt,UINT nFlags) {
    int iRow = iSelection / iCols;
    int iCol = iSelection % iCols;
    switch (nChar) {
        case VK_UP:    iRow--; break;
        case VK_DOWN:  iRow++; break;
        case VK_LEFT:  iCol--; break;
        case VK_RIGHT: iCol++; break;
        default: ;
    }
    iRow = max(0,iRow); iRow = min(iRows-1,iRow);
    iCol = max(0,iCol); iCol = min(iCols-1,iCol);
    iSelection = iRow * iCols + iCol;
    iSelection = min(iSelection,iNumBitmaps-1);
    InvalidateRect(NULL,FALSE);
}

void TAutoPopoutBitmapSelectorWindow::OnLButtonUp( UINT, CPoint ) {
    *pButton->pi = iSelection;
    ::DestroyWindow(*this);
}
void TAutoPopoutBitmapSelectorWindow::OnMouseMove(UINT,CPoint pt) {
    int iNewSelection = -1;
    for (int iRow = 0; iRow < iRows; iRow++)
        for (int iCol = 0; iCol < iCols; iCol++) {
            int iBitmap = (iRow*iCols)+iCol;
            if (iBitmap == iNumBitmaps) break;
            RECT rcBmp;
            rcBmp.left = 1+iCol*(iBitmapWidth+1);
            rcBmp.right = rcBmp.left+iBitmapWidth;
            rcBmp.top = 1+iRow*(iBitmapHeight+1);
            rcBmp.bottom = rcBmp.top+iBitmapHeight;
            if (::PtInRect(&rcBmp,pt)) 
                if (iSelection != iBitmap) {
                    iSelection = iBitmap;
                    InvalidateRect(NULL,FALSE);
                }
    }
    
}
void TAutoPopoutBitmapSelectorWindow::OnCaptureChanged(CWnd*) {
    if (!bIgnoreCaptureChange) ::DestroyWindow(*this);
}
void TAutoPopoutBitmapSelectorWindow::OnPaint() {
    CPaintDC dcPaint(this);
    // Create a memory dc/bitmap for the whole window area
    RECT rcClient;
    GetClientRect(&rcClient);
    HDC hdcTmp = ::CreateCompatibleDC(dcPaint);
    HBITMAP hbmpTmp = ::CreateCompatibleBitmap(dcPaint,rcClient.right,rcClient.bottom);
    HGDIOBJ hbmpTmpOld = ::SelectObject(hdcTmp,hbmpTmp);

    ::FillRect(hdcTmp,&rcClient,(HBRUSH)(COLOR_WINDOWTEXT+1));

    // Create a memory dc/bitmap to hold the source image
    HDC hdcSrc = ::CreateCompatibleDC(dcPaint);
    for (int iRow = 0; iRow < iRows; iRow++)
        for (int iCol = 0; iCol < iCols; iCol++) {
            int iBitmap = (iRow*iCols)+iCol;
            if (iBitmap == iNumBitmaps) break;
            bool bSel = (iSelection == iBitmap);
            // decide on colors to use
            COLORREF crBkg = ::GetSysColor(bSel ? COLOR_HIGHLIGHT : COLOR_WINDOW);
            HBRUSH hbrshBkg = ::CreateSolidBrush(crBkg);
            COLORREF crText = ::GetSysColor(bSel ? COLOR_HIGHLIGHTTEXT : COLOR_WINDOWTEXT);
            HBRUSH hbrshText = ::CreateSolidBrush(crText);
            // Create a memory dc/bitmap to hold the source image
            HGDIOBJ hbmpSrcOld = ::SelectObject(hdcSrc,pbitmaps[iBitmap]);
            // figure out where to put the bitmap
            RECT rcBmp;
            rcBmp.left = 1+iCol*(iBitmapWidth+1);
            rcBmp.right = rcBmp.left+iBitmapWidth;
            rcBmp.top = 1+iRow*(iBitmapHeight+1);
            rcBmp.bottom = rcBmp.top+iBitmapHeight;
            // fill the background
            ::FillRect(hdcTmp,&rcBmp,hbrshBkg);
            HGDIOBJ hbrshTmpOld = ::SelectObject(hdcTmp,hbrshText);
            // text color to source black
            ::BitBlt(hdcTmp,rcBmp.left,rcBmp.top,iBitmapWidth,iBitmapHeight,hdcSrc,0,0,0x00B8074A);
            if (bSel) ::DrawFocusRect(hdcTmp,&rcBmp);
            ::SelectObject(hdcTmp,hbrshTmpOld);
            ::DeleteObject(hbrshBkg);
            ::DeleteObject(hbrshText);
            // Clean up source image stuff
            ::SelectObject(hdcSrc,hbmpSrcOld);
        }
    // kill the source DC
    ::DeleteDC(hdcSrc);
    // Finally move temp bitmap to display
    ::BitBlt(dcPaint,0,0,rcClient.right,rcClient.bottom,hdcTmp,0,0,SRCCOPY);
    // Clean up the temp DC
    ::SelectObject(hdcTmp,hbmpTmpOld);
    ::DeleteDC(hdcTmp);
} // end OnPaint()


