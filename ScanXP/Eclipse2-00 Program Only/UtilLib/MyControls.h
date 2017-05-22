
#ifndef __MyControls_h
#define __MyControls_h

#ifndef _AFXDLL
#error MyControls classes require DLL version of MFC
#endif

#include "List.h"
#include "Notifier.h"

#define BEGIN_TEMPLATE_MESSAGE_MAP(tmpltargs, theClass, baseClass) \
    template<tmpltargs> const AFX_MSGMAP* PASCAL theClass::_GetBaseMessageMap() \
		{ return &baseClass::messageMap; } \
    template<tmpltargs>	const AFX_MSGMAP* theClass::GetMessageMap() const \
		{ return &theClass::messageMap; } \
    template<tmpltargs>	AFX_DATADEF const AFX_MSGMAP theClass::messageMap = \
	{ &theClass::_GetBaseMessageMap, &theClass::_messageEntries[0] }; \
    template<tmpltargs>	const AFX_MSGMAP_ENTRY theClass::_messageEntries[] = \
	{ \

//this function is to shift a control of a dialogbox. x and y are in pixels
void ShiftDlgItem(CWnd *pWnd, int x, int y);

extern UINT WM_INITUI;
class TAutoPopoutBitmapSelectorWindow;  // local class
//
// TShadowResources utility class for owner draw 3D items
//
class TShadowResources {
public:
    TShadowResources();
    ~TShadowResources();
    // *prc should specify the location and size of the 3D rect on entry,
    // on exit *prc specifies the interior of the rect to be completed by
    // the caller
    void DrawRect(HDC hdc,RECT* prc,bool bShowDown,bool bDefault,bool bFill);
    static HBRUSH hbrshBkg,hbrshTxt,hbrsh3DShadow,hbrsh3DHiLight,hbrsh3DDkShadow,hbrsh3DLight;
;
protected:
    static int iUsage;
};
//
// Enablers for all auto controls
//
struct TBaseEnabler {
    virtual ~TBaseEnabler() {} 
    enum TEnableCode { disable = false, enable = true, nochange = 2 };
    virtual TEnableCode ShouldBeEnabled() const = 0;
    virtual TBaseEnabler* Dup() const = 0;
    virtual CString GetDisabledText() const { return _T(""); }
};
struct TEnabler : TBaseEnabler {
    inline TEnabler(const TBaseEnabler& Aenab)
        : penab(Aenab.Dup()) {}
    virtual ~TEnabler() { delete penab; } 
    virtual TEnableCode ShouldBeEnabled() const { return penab->ShouldBeEnabled(); }
    virtual TBaseEnabler* Dup() const { return new TEnabler(*penab); }
    virtual CString GetDisabledText() const { return penab->GetDisabledText(); }
private:
    const TBaseEnabler* penab;
};
template<class T> 
struct TSimpleEnabler : TBaseEnabler {
    inline TSimpleEnabler(const T& At,T AtForEnable = (T)1)
        : t(At),tForEnable(AtForEnable) {}
    virtual TEnableCode ShouldBeEnabled() const { return TEnableCode(t == tForEnable); }
    virtual TBaseEnabler* Dup() const { return new TSimpleEnabler<T>(*this); };
private:
    const T& t;
    const T tForEnable;
};
struct TAndEnabler : TBaseEnabler {
    inline TAndEnabler(const TBaseEnabler& AEnabler1,const TBaseEnabler& AEnabler2) 
        : enab1(AEnabler1),enab2(AEnabler2) {}
    virtual TEnableCode ShouldBeEnabled() const 
        { return TEnableCode(enab1.ShouldBeEnabled() != disable && enab2.ShouldBeEnabled() != disable); }
    virtual CString GetDisabledText() const { return !enab1.GetDisabledText().IsEmpty() ? 
                                                      enab1.GetDisabledText() : enab2.GetDisabledText(); }
    virtual TBaseEnabler* Dup() const { return new TAndEnabler(enab1,enab2); };
private:
    TEnabler enab1;
    TEnabler enab2;
};
inline TAndEnabler operator&&(const TBaseEnabler& e1,const TBaseEnabler& e2) {
    return TAndEnabler(e1,e2);
}
/*  Commented out because it causes a INTERNAL COMPILER ERROR
template<class T>
inline TAndEnabler operator&&(const TBaseEnabler& e,const T& b) {
    return TAndEnabler(e,TSimpleEnabler<T>(b));
}
template<class T>
inline TAndEnabler operator&&(const T& b,const TBaseEnabler& e) {
    return TAndEnabler(TSimpleEnabler<T>(b),e);
}
*/

inline TAndEnabler operator&&(const TBaseEnabler& e,const BOOL& b) {
    return TAndEnabler(e,TSimpleEnabler<BOOL>(b));
}
inline TAndEnabler operator&&(const BOOL& b,const TBaseEnabler& e) {
    return TAndEnabler(TSimpleEnabler<BOOL>(b),e);
}
inline TAndEnabler operator&&(const TBaseEnabler& e,const bool& b) {
    return TAndEnabler(e,TSimpleEnabler<bool>(b));
}
inline TAndEnabler operator&&(const bool& b,const TBaseEnabler& e) {
    return TAndEnabler(TSimpleEnabler<bool>(b),e);
}

//
// TAutoControlBase
//
//  This is the base class for all controls that handle there own
//  data structures.  
//  
//  The default ctor is best used with window controls that are created 
//  on the fly via the object's Create function. If the default ctor is 
//  used and the control is later subclassed as opposed to created, 
//  then the object's InitUI function must eventually be called by the 
//  user to allow the control to reflect the initial data state. The 
//  function should be invoked immediatedly after the control is 
//  subclassed.  NOTE 1: The user is responsible for deleting the object
//  when the default ctor is used.  NOTE 2: Attaching a TAutoControlBase 
//  derivation to an already existant control will not work -- Subclass 
//  the control instead.
//
//  It is preferable to use the second ctor when a valid window control  
//  exists before the object is created.  In this instance, the ctor 
//  automatically subclasses the control and post an initialization 
//  message to itself so the virtual InitUI function will be called. The
//  object will automatically delete itself when the window control is 
//  destroyed when the second ctor is used.
//
class TAutoControlBase : public CWnd {
public:
    TAutoControlBase(const TBaseEnabler& AEnabler = dftEnabler);
    TAutoControlBase(UINT nID,CWnd* pParent,const TBaseEnabler& AEnabler = dftEnabler);
    virtual ~TAutoControlBase();
    virtual void InitUI();
    virtual void ForceDataSync();
    virtual bool Changed() const = 0;   
    static const UINT WM_AUTOCONTROLLOOSINGFOCUS;
    static inline HWND WhoIsGettingFocus() { return hwndGettingFocus; }
    static inline void DeclareMajorChange() { bMajorChange = true; }
    struct TDftEnabler : TBaseEnabler {
        virtual TEnableCode ShouldBeEnabled() const { return nochange; }
        virtual TBaseEnabler* Dup() const { return new TDftEnabler(*this); };
    };
    static const TDftEnabler dftEnabler;
protected:
    BOOL PreTranslateMessage(MSG* pMsg);
 	virtual void PostNcDestroy();
    afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
    afx_msg void OnKillFocus(CWnd*);
    afx_msg void OnSetFocus(CWnd*);
    bool bAutoDelete;
    bool bInitialized;
    TEnabler enab;
    static HWND hwndGettingFocus;   // indicates the wnd that is getting focus, and the auto control that has it
    DECLARE_MESSAGE_MAP()
private:
    afx_msg LRESULT OnInitUI(WPARAM WParam, LPARAM LParam); // override InitUI -- don't steal the message
    static bool bMajorChange;
};
//
// TAutoButton
//
class TAutoButton : public TAutoControlBase {
public:
    inline TAutoButton(const TBaseEnabler& AEnabler = dftEnabler)
        : TAutoControlBase(AEnabler) {}
    inline TAutoButton(UINT nID,CWnd* pParent,const TBaseEnabler& AEnabler = dftEnabler)
        : TAutoControlBase(nID,pParent,AEnabler) {}
    virtual bool Changed() const { return false; }
};
//
// TAutoRadioButton
//
class TAutoRadioButton : public TAutoControlBase {
    friend class TStaticForAutoRadioButton;
public:
    TAutoRadioButton(int* pi,int iActive,int iSizeOf,
                     const TBaseEnabler& AEnabler = dftEnabler,UINT nIDBuddyStatic = 0);
    TAutoRadioButton(UINT nID,CWnd* pParent,int* pi,int iActive,int iSizeOf,
                     const TBaseEnabler& AEnabler = dftEnabler,UINT nIDBuddyStatic = 0);
    virtual void InitUI();
    virtual bool Changed() const;   
protected:
    virtual void BNClicked();
    bool SameData(const int* pi1,const int* pi2) const;
    void CopyData(int* piDest,const int* piSrc) const;
    int* const pi;
    int iOriginal;
    int iActive;
    const int iSizeOf;
    const UINT nIDBuddyStatic;
    afx_msg BOOL OnBNClicked();
    afx_msg void OnSetFocus(CWnd*);
    afx_msg void OnKillFocus(CWnd*);
   	DECLARE_MESSAGE_MAP()
};
//
// TAutoRadioButtonWithBitmap -- Provided for compatibility. TAutoRadioButton's and TAutoCheckBox'es can
// now be used as is with buddy statics. This class additionally creates the buddy static given the static
// ID and the bitmap ID.
//
class TAutoRadioButtonWithBitmap : public TAutoRadioButton {
public:
    TAutoRadioButtonWithBitmap(int* pi,int iActive,int iSizeOf,
                               UINT nIDStaticDest,UINT nIDBitmap,const TBaseEnabler& AEnabler = dftEnabler);
    TAutoRadioButtonWithBitmap(UINT nID,CWnd* pParent,int* pi,int iActive,int iSizeOf,
                               UINT nIDStaticDest,UINT nIDBitmap,const TBaseEnabler& AEnabler = dftEnabler);
    virtual void InitUI();
protected:
    const UINT nIDBitmap;
   	DECLARE_MESSAGE_MAP()
};
//
// TAutoCheckBox
//
class TAutoCheckBox : public TAutoRadioButton {
public:
    TAutoCheckBox(int* pi,int iActive,int iInActive,int iSizeOf,
                  const TBaseEnabler& AEnabler = dftEnabler,UINT nIDBuddyStatic = 0);
    TAutoCheckBox(UINT nID,CWnd* pParent,
                  int* pi,int iActive,int iInActive,int iSizeOf,
                  const TBaseEnabler& AEnabler = dftEnabler,UINT nIDBuddyStatic = 0);
    virtual void InitUI();
protected:
    virtual void BNClicked();
    int iInActive;
   	DECLARE_MESSAGE_MAP()
};
//
// TAutoboolCheckBox
//
class TAutoboolCheckBox : public TAutoCheckBox {
public:
    TAutoboolCheckBox(bool* pb,bool bActive = true,const TBaseEnabler& AEnabler = dftEnabler);
    TAutoboolCheckBox(UINT nID,CWnd* pParent,bool* pb,bool bActive = true,const TBaseEnabler& AEnabler = dftEnabler);
};
//
// TAutoBOOLCheckBox
//
class TAutoBOOLCheckBox : public TAutoCheckBox {
public:
    TAutoBOOLCheckBox(BOOL* pb,BOOL bActive = TRUE,const TBaseEnabler& AEnabler = dftEnabler);
    TAutoBOOLCheckBox(UINT nID,CWnd* pParent,BOOL* pb,BOOL bActive = TRUE,const TBaseEnabler& AEnabler = dftEnabler);
};
//
// TAutoEditBox
//
class TAutoEditBox : public TAutoControlBase {
    friend class TAutoComboBoxBase;
public:
    TAutoEditBox(UINT uMaxChars = 0,const TBaseEnabler& AEnabler = dftEnabler);
    TAutoEditBox(UINT nID,CWnd* pParent,UINT uMaxChars = 0,const TBaseEnabler& AEnabler = dftEnabler);
    virtual void InitUI();              // load edit box with data
    virtual void ForceDataSync();
    virtual void ForceDataSync(bool bEvenIfSameText);
    inline void DeclareEdited() { strInitText.Empty(); }
    // Enablers
    struct TDftEnabler : TBaseEnabler {
        virtual CString GetDisabledText() const { return _T(""); }
        virtual TEnableCode ShouldBeEnabled() const { return nochange; }
        virtual TBaseEnabler* Dup() const { return new TDftEnabler(*this); }
    };
    struct TFancyEnabler : TDftEnabler {
        inline TFancyEnabler(CString AstrDisabled) : strDisabled(AstrDisabled) {} 
        virtual CString GetDisabledText() const { return strDisabled; }
        virtual TBaseEnabler* Dup() const { return new TFancyEnabler(*this); }
    private:
        CString strDisabled;
    };
    static const TDftEnabler dftEnabler;
protected:
    virtual CString DataToText(const void* pd,HWND hwndFocus) const = 0;
    virtual const void* TextToData(const char*,HWND hwndFocus) const = 0;
    virtual const void* GetData() const = 0;
    virtual void SetData(const void* pv) = 0;
    CString strInitText;    // this is what we set the EB text to (needed to check for user changes)
    afx_msg void OnEnable(BOOL bEnabled);
    afx_msg void OnKillFocus(CWnd* pNewWnd);
    afx_msg void OnSetFocus(CWnd* pOldWnd);
    afx_msg void OnLButtonDown( UINT, CPoint );
   	DECLARE_MESSAGE_MAP()
    const UINT uMaxChars;
};
//
// TEditBoxTextTranslatorTmplt
//
template<class T>
struct TEditBoxTextTranslatorTmplt {
    virtual ~TEditBoxTextTranslatorTmplt() {}
    virtual CString ToString(const T&,HWND hwndFocus) const = 0;
    virtual const T& FromString(const char*,HWND hwndFocus) const = 0;
    virtual bool IsValidChar(char c) const { return true; }
    virtual TEditBoxTextTranslatorTmplt<T>* Dup() const = 0;
};
//
// TAutoEditBoxTmplt
//
template<class T>
class TAutoEditBoxTmplt : public TAutoEditBox {
public:
    typedef TAutoEditBoxTmplt<T> TBase;
    typedef TEditBoxTextTranslatorTmplt<T> TTranslator;
    inline TAutoEditBoxTmplt(T* pt,UINT uMaxChars,const TTranslator& ATranslator,const TBaseEnabler& AEnabler) 
        : TAutoEditBox(uMaxChars,AEnabler),ptLive(pt),tOriginal(*pt),pTranslator(ATranslator.Dup()) {}
    inline TAutoEditBoxTmplt(UINT nID,CWnd* pParent,
                             T* pt,UINT uMaxChars,const TTranslator& ATranslator,const TBaseEnabler& AEnabler) 
        : TAutoEditBox(nID,pParent,uMaxChars,AEnabler),ptLive(pt),tOriginal(*pt),pTranslator(ATranslator.Dup()) {}
    ~TAutoEditBoxTmplt() { delete pTranslator; }
    virtual bool Changed() const { return *ptLive != tOriginal; }
protected:
    virtual CString DataToText(const void* pv,HWND hwndFocus) const 
        { return pTranslator->ToString(*static_cast<const T*>(pv),hwndFocus); }
    virtual const void* TextToData(const char* psz,HWND hwndFocus) const 
        { return static_cast<const void*>(&pTranslator->FromString(psz,hwndFocus)); }
    virtual const void* GetData() const 
        { return ptLive; }
    virtual void SetData(const void* pv) 
        { *ptLive = *static_cast<const T*>(pv); }
    afx_msg void OnChar(UINT nChar,UINT nRepCnt,UINT nFlags) 
        { if (pTranslator->IsValidChar(static_cast<char>(nChar))) TAutoEditBox::OnChar(nChar,nRepCnt,nFlags); }
   	DECLARE_MESSAGE_MAP()
    T* ptLive;
    T tOriginal;
    TTranslator* const pTranslator;
};
BEGIN_TEMPLATE_MESSAGE_MAP(class T,TAutoEditBoxTmplt<T>,TAutoEditBox)
    ON_WM_CHAR()
END_MESSAGE_MAP()
//
// TAutoMemoEditBox
//
class TAutoMemoEditBox : public TAutoEditBoxTmplt<CString> {
public:
    inline TAutoMemoEditBox(CString* pstr,UINT uMaxChars = 0,
                            const TTranslator& ATranslator = dftTrans,const TBaseEnabler& AEnabler = dftEnabler) 
        : TBase(pstr,uMaxChars,ATranslator,AEnabler) {}
    inline TAutoMemoEditBox(UINT nID,CWnd* pParent,
                            CString* pstr,UINT uMaxChars = 0,
                            const TTranslator& ATranslator = dftTrans,const TBaseEnabler& AEnabler = dftEnabler)
        : TBase(nID,pParent,pstr,uMaxChars,ATranslator,AEnabler) {}
    struct TDftTranslator : /*TTranslator*/ TEditBoxTextTranslatorTmplt<CString> {
        virtual CString ToString(const CString& str,HWND hwndFocus) const;
        virtual const CString& FromString(const char* psz,HWND hwndFocus) const;
        virtual TTranslator* Dup() const { return new TDftTranslator(*this); }
    };
    static const TDftTranslator dftTrans;
    DECLARE_MESSAGE_MAP()
};
//
// TAutoTextEditBox
//
class TAutoTextEditBox : public TAutoEditBox {
public:
    inline TAutoTextEditBox(char* Apsz,UINT AuMaxChars,const TBaseEnabler& AEnabler = dftEnabler) 
        : TAutoEditBox(AuMaxChars,AEnabler),psz(Apsz),pszOriginal(strdup(Apsz)) { }
    inline TAutoTextEditBox(UINT nID,CWnd* pParent,char* Apsz,UINT AuMaxChars,const TBaseEnabler& AEnabler = dftEnabler) 
        : TAutoEditBox(nID,pParent,AuMaxChars,AEnabler),psz(Apsz),pszOriginal(strdup(Apsz)) { }
    virtual ~TAutoTextEditBox() { free(pszOriginal); }
    virtual bool Changed() const;   
protected:
    virtual CString DataToText(const void* pd,HWND hwndFocus) const;
    virtual const void* TextToData(const char*,HWND hwndFocus) const;
    virtual const void* GetData() const;
    virtual void SetData(const void *pv);
    char* psz;
    char* const pszOriginal;
};
//
// TAutoDoubleEditBox
//
class TAutoDoubleEditBox : public TAutoEditBoxTmplt<double> {
public:
    inline TAutoDoubleEditBox(double* pd,const TTranslator& ATranslator = dftTrans,const TBaseEnabler& AEnabler = dftEnabler)
        : TBase(pd,25,ATranslator,AEnabler) {}
    inline TAutoDoubleEditBox(UINT nID,CWnd* pParent,
                              double* pd,const TTranslator& ATranslator = dftTrans,const TBaseEnabler& AEnabler = dftEnabler)
        : TBase(nID,pParent,pd,25,ATranslator,AEnabler) {}
    // Translators
    struct TDftTranslator : /*TTranslator*/ TEditBoxTextTranslatorTmplt<double> {
        virtual CString ToString(const double& d,HWND hwndFocus) const;
        virtual const double& FromString(const char* psz,HWND hwndFocus) const;
        virtual bool IsValidChar(char c) const;
        virtual TTranslator* Dup() const { return new TDftTranslator(*this); }
    };
    struct TFormattedTranslator : /*TTranslator*/ TEditBoxTextTranslatorTmplt<double> {
        inline TFormattedTranslator(double AdMin,double AdMax,bool AbZeroMeansNA,const char* ApszFormat)
            : dMin(AdMin),dMax(AdMax),bZeroMeansNA(AbZeroMeansNA),strFormat(ApszFormat) {}
        virtual CString ToString(const double& d,HWND hwndFocus) const;
        virtual const double& FromString(const char* psz,HWND hwndFocus) const;
        virtual bool IsValidChar(char c) const;
        virtual TTranslator* Dup() const { return new TFormattedTranslator(*this); }
    private:
        CString strFormat;
        double dMin;
        double dMax;
        bool bZeroMeansNA;
    };
    struct TPercentTranslator : /*TTranslator*/ TEditBoxTextTranslatorTmplt<double> {
        inline TPercentTranslator(bool AbZeroMeansNA,const char* ApszFormat)
            : bZeroMeansNA(AbZeroMeansNA),strFormat(ApszFormat) {}
        virtual CString ToString(const double& d,HWND hwndFocus) const;
        virtual const double& FromString(const char* psz,HWND hwndFocus) const;
        virtual bool IsValidChar(char c) const;
        virtual TTranslator* Dup() const { return new TPercentTranslator(*this); }
    private:
        CString strFormat;
        bool bZeroMeansNA;
    };
    static const TDftTranslator dftTrans;
protected:
   	DECLARE_MESSAGE_MAP()
};
//
// TAutoDWORDEditBox
//
class TAutoDWORDEditBox : public TAutoEditBoxTmplt<DWORD> {
public:
    TAutoDWORDEditBox(DWORD* pdw,const TTranslator& ATranslator = dftTrans,const TBaseEnabler& AEnabler = dftEnabler)
        : TBase(pdw,25,ATranslator,AEnabler) {}
    TAutoDWORDEditBox(UINT nID,CWnd* pParent,
                      DWORD* pdw,const TTranslator& ATranslator = dftTrans,const TBaseEnabler& AEnabler = dftEnabler)
        : TBase(nID,pParent,pdw,25,ATranslator,AEnabler) {}
    // Translators
    struct TDftTranslator : /*TTranslator*/ TEditBoxTextTranslatorTmplt<DWORD> {
        virtual CString ToString(const DWORD& d,HWND hwndFocus) const;
        virtual const DWORD& FromString(const char* psz,HWND hwndFocus) const;
        virtual bool IsValidChar(char c) const;
        virtual TTranslator* Dup() const { return new TDftTranslator(*this); }
    };
    struct TFancyTranslator : public TDftTranslator {
        inline TFancyTranslator(DWORD AdwMin,DWORD AdwMax,bool* ApbBlank = NULL)
            : dwMin(AdwMin),dwMax(AdwMax),pbBlank(ApbBlank) {}
        virtual CString ToString(const DWORD& d,HWND hwndFocus) const;
        virtual const DWORD& FromString(const char* psz,HWND hwndFocus) const;
        virtual TTranslator* Dup() const { return new TFancyTranslator(*this); }
    private:
        const DWORD dwMin;
        const DWORD dwMax;
        bool* const pbBlank;
    };
    static const TDftTranslator dftTrans;
protected:
   	DECLARE_MESSAGE_MAP()
};
//
// TAutoListBox
//
class TAutoListBox : public TAutoControlBase {
public:
    TAutoListBox(UINT uMaxChars,bool bMatchOnStringsNotItems,const TBaseEnabler& AEnabler = dftEnabler);
    TAutoListBox(UINT uID,CWnd* pParent,
                 UINT uMaxChars,bool bMatchOnStringsNotItems,const TBaseEnabler& AEnabler = dftEnabler);
    virtual void LoadListBox() = 0;      // invoked by InitUI to Add Strings to box
    void AddString(const char*);         // utility function for InitUI
    void AddString(const char*,LPARAM);
    bool GetSelString(CString*);
    bool GetSelItem(LPARAM*);
    const UINT uMaxChars;
    const bool bMatchOnStringsNotItems;
    virtual void InitUI();
protected:
    virtual CString DataToText(const void* pd) const;   // override this pair for match on str's, 
    virtual const void* TextToData(const char*) const;  // default assumes data is ptrs to strings
    virtual LPARAM DataToItem(const void* pd) const;    // override this pair for match on items
    virtual const void* ItemToData(LPARAM) const;       // no need to override if item is data!
    virtual const void* GetData() const = 0;
    virtual void SetData(const void* pv) = 0;
    int FindString(const char*) const;
    int FindItem(LPARAM) const;
    void SetControlMsg();     // determines value of add string msg from wnd class
    UINT uAddStringMsg;       // value when object is attached to a real control  
    UINT uClearStringsMsg;
    UINT uSetCurSelMsg;
    UINT uGetCurSelMsg;
    UINT uGetStringMsg;
    UINT uFindStringMsg;
    UINT uSetItemDataMsg;
    UINT uGetItemDataMsg;
    UINT uGetCountMsg;
    bool bComboBox;
    afx_msg BOOL OnSelChange();
	DECLARE_MESSAGE_MAP()
};
//
// TAutoIntListBox
//
class TAutoIntListBox : public TAutoListBox {
// user must override LoadListBox() function calling AddString with LPARAM.
// Other default functionality is probably appropriate.
public:
    TAutoIntListBox(UINT nID,CWnd*,int* pi,const TBaseEnabler& AEnabler = dftEnabler);
protected:
    int* const pi;
    const int iOriginal;
    virtual bool Changed() const;
    virtual const void* GetData() const;
    virtual void SetData(const void* pv);
    DECLARE_MESSAGE_MAP()
};
//
// NEW IMPLEMENTATIONS SHOULD ATTEMPT TO USE THE TUnitsTableTmplt INSTEAD
// OF THE TAutoUnitsListBox!!!!!
//
// TAutoUnitsListBox 
//  default implementation allows for standard engineering prefixes (u,m,k,M,etc) on a specified base unit
//
struct SMultiplier {    // helper struct to define multipliers and equivilent strings
    char* psz;
    double dMultiplier;
};
class TAutoUnitsListBox : public TAutoListBox {
public:
    TAutoUnitsListBox(double* pdMultiplier,TAutoEditBox* peb,
                      const char* pszUnits,UINT uMaxChars, // pszUnits might be "V" for example
                      int iMinExp,int iMaxExp,const TBaseEnabler& AEnabler = dftEnabler);
    TAutoUnitsListBox(int nID,CWnd*,
                      double* pdMultiplier,TAutoEditBox* peb,
                      const char* pszUnits,UINT uMaxChars,
                      int iMinExp,int iMaxExp,const TBaseEnabler& AEnabler = dftEnabler);
    virtual ~TAutoUnitsListBox();
protected:
    virtual const SMultiplier* GetMultiplier(int iIndex) const;
    const CString strUnits;
    TAutoEditBox* const peb;
    double* const pdMultiplier;
    // Overridden functions
    virtual bool Changed() const;
    virtual LPARAM DataToItem(const void* pd) const;
    virtual const void* ItemToData(LPARAM) const;
    virtual const void* GetData() const;
    virtual void SetData(const void* pv);
    virtual void LoadListBox();
    afx_msg void OnKillFocus(CWnd* pNewWnd);
    afx_msg BOOL OnSelChange();
    DECLARE_MESSAGE_MAP()
private:
    mutable SMultiplier* pmul;
    const iMinExp;
    const iMaxExp;
};
//
// TAutoNumberWithUnitsEditBoxTmplt
//
//**********
// TUnitsTranslator support template 
//   -- declared outside TAutoNumberWithUnitsEditBoxTmplt to prevent "minor browser errors"
template<class T>
struct TUnitsTranslator : /*TTranslator*/ TEditBoxTextTranslatorTmplt<T> {
    TUnitsTranslator(const TEditBoxTextTranslatorTmplt<T>/*TTranslator*/& ARealTranslator,const T* AptMultiplier)
        : pRealTranslator(ARealTranslator.Dup()),ptMultiplier(AptMultiplier) { } 
    ~TUnitsTranslator() { delete pRealTranslator; }
    virtual CString ToString(const T& t,HWND hwndFocus) const;
    virtual const T& FromString(const char* psz,HWND hwndFocus) const; 
    virtual bool IsValidChar(char c) const { return pRealTranslator->IsValidChar(c); }
    virtual TEditBoxTextTranslatorTmplt<T>/*TTranslator*/* Dup() const { return new TUnitsTranslator<T>(*pRealTranslator,ptMultiplier); }
private:
    TEditBoxTextTranslatorTmplt<T>/*TTranslator*/* const pRealTranslator;
    const T* const ptMultiplier;
};
//**********
// TUnits support template 
//   -- declared outside TAutoNumberWithUnitsEditBoxTmplt to prevent "minor browser errors"
template<class T> 
struct TUnitsTableTmplt {
    virtual T MultiplierFromIndex(int) const = 0;
    virtual CString UnitsFromIndex(int) const = 0;
    virtual int GetNumUnits() const = 0;
    virtual TUnitsTableTmplt<T>* Dup() const = 0;
    virtual ~TUnitsTableTmplt() {}
    CString UnitsFromMultiplier(double) const;
};

//***********
template<class T>
class TAutoNumberWithUnitsEditBoxTmplt : public TAutoEditBoxTmplt<T> {
public:
    // ctors with units table
    inline TAutoNumberWithUnitsEditBoxTmplt(int iListBoxID,T* pt,T* AptMultiplier,
                                            const TTranslator& ATranslator,
                                            const TBaseEnabler& AEnabler,
                                            const TUnitsTableTmplt<T>& AUnitsTable)
        : TBase(pt,25,TUnitsTranslator<T>(ATranslator,AptMultiplier),AEnabler),
          ptMultiplier(AptMultiplier),plbUnits(0),iUnitListBoxID(iListBoxID),pUnitsTable(AUnitsTable.Dup()) {}
    inline TAutoNumberWithUnitsEditBoxTmplt(int iID,CWnd* pParent,
                                            int iListBoxID,T* pt,T* AptMultiplier,
                                            const TTranslator& ATranslator,
                                            const TBaseEnabler& AEnabler,
                                            const TUnitsTableTmplt<T>& AUnitsTable)
        : TBase(iID,pParent,pt,25,TUnitsTranslator<T>(ATranslator,AptMultiplier),AEnabler),
                ptMultiplier(AptMultiplier),plbUnits(0),iUnitListBoxID(iListBoxID),pUnitsTable(AUnitsTable.Dup()) {}

    // ctors without units table
    inline TAutoNumberWithUnitsEditBoxTmplt(int iListBoxID,T* pt,T* AptMultiplier,
                                            const TTranslator& ATranslator,
                                            const TBaseEnabler& AEnabler)
        : TBase(pt,25,TUnitsTranslator<T>(ATranslator,AptMultiplier),AEnabler),
          ptMultiplier(AptMultiplier),plbUnits(0),iUnitListBoxID(iListBoxID),pUnitsTable(0) {}
    inline TAutoNumberWithUnitsEditBoxTmplt(int iID,CWnd* pParent,
                                            int iListBoxID,T* pt,T* AptMultiplier,
                                            const TTranslator& ATranslator,
                                            const TBaseEnabler& AEnabler)
        : TBase(iID,pParent,pt,25,TUnitsTranslator<T>(ATranslator,AptMultiplier),AEnabler),
                ptMultiplier(AptMultiplier),plbUnits(0),iUnitListBoxID(iListBoxID),pUnitsTable(0) {}

    virtual ~TAutoNumberWithUnitsEditBoxTmplt() { delete pUnitsTable; }
    virtual void InitUI();
    TUnitsTableTmplt<T>* const pUnitsTable;
protected:
    T* const ptMultiplier;
    const int iUnitListBoxID;
    TAutoListBox* plbUnits;
    // must override this function if units table not provided
    virtual TAutoListBox* CreateUnitsListBox(int iID,CWnd* pParent);
    afx_msg void OnKillFocus(CWnd* pNewWnd);
    afx_msg void OnSetFocus(CWnd* pOldWnd);
   	DECLARE_MESSAGE_MAP()
};
//**********
// TBuddyUnitsListBox support template
template<class T>
class TBuddyUnitsListBoxTmplt : public TAutoListBox {
public:
    inline TBuddyUnitsListBoxTmplt(int iID,CWnd* pParent,
                                   T* AptMultiplier,
                                   TAutoNumberWithUnitsEditBoxTmplt<T>* Apeb,
                                   const TBaseEnabler& AEnabler)
        : TAutoListBox(iID,pParent,100,false,AEnabler),ptMultiplier(AptMultiplier),peb(Apeb) {}
protected:
    TAutoNumberWithUnitsEditBoxTmplt<T>* const peb;
    T* const ptMultiplier;
    T tInitMultiplier;
    // Overridden functions
    virtual void InitUI();
    virtual bool Changed() const { return false; }
    virtual LPARAM DataToItem(const void* pd) const;
    virtual const void* ItemToData(LPARAM) const;
    virtual const void* GetData() const { return ptMultiplier; }
    virtual void SetData(const void* pv) { *ptMultiplier = *static_cast<const T*>(pv); }
    virtual void LoadListBox();
    afx_msg void OnKillFocus(CWnd* pNewWnd);
    afx_msg void OnSetFocus(CWnd* pOldWnd);
    afx_msg BOOL OnSelChange();
    DECLARE_MESSAGE_MAP()
};
#include "MyControlsTmplt.h"
//
// TAutoDoubleWithEngUnitsEditBox 
//
class TAutoDoubleWithEngUnitsEditBox : public TAutoNumberWithUnitsEditBoxTmplt<double> {
public:
    inline TAutoDoubleWithEngUnitsEditBox(int iListBoxID,double* pd,double* ApdMultiplier,const char* pszUnits,
                                          const TTranslator& ATranslator = TAutoDoubleEditBox::dftTrans,
                                          const TBaseEnabler& AEnabler = dftEnabler)
        : TAutoNumberWithUnitsEditBoxTmplt<double>(iListBoxID,pd,ApdMultiplier,
                                                   ATranslator,AEnabler,TUnitsTable(pszUnits)) {}
    inline TAutoDoubleWithEngUnitsEditBox(int iID,CWnd* pParent,
                                          int iListBoxID,double* pd,double* ApdMultiplier,const char* pszUnits,
                                          const TTranslator& ATranslator = TAutoDoubleEditBox::dftTrans,
                                          const TBaseEnabler& AEnabler = dftEnabler)
        : TAutoNumberWithUnitsEditBoxTmplt<double>(iID,pParent,
                                                   iListBoxID,pd,ApdMultiplier,
                                                   ATranslator,AEnabler,TUnitsTable(pszUnits)) {}
    // public TTranslators
    //
    typedef TAutoDoubleEditBox::TFormattedTranslator TFormattedTranslator;
    // public TUnitsTable
    //
    struct TUnitsTable : public TUnitsTableTmplt<double> {
        inline TUnitsTable(const char* pszUnits,int AiMinExp = -15,int AiMaxExp = 12) 
            : strUnits(pszUnits),iMinExp(AiMinExp),iMaxExp(AiMaxExp) {
            ASSERT((iMaxExp/3)*3 == iMaxExp);    // ensure multiples of three
            ASSERT((iMinExp/3)*3 == iMinExp);
            ASSERT(iMaxExp <= 12);              // ensure valid range
            ASSERT(iMinExp >= -15);
        }
        virtual double MultiplierFromIndex(int) const;
        virtual CString UnitsFromIndex(int) const;
        virtual int GetNumUnits() const;
        virtual TUnitsTableTmplt<double>* Dup() const { return new TUnitsTable(*this); }
    private:
        const CString strUnits;
        const int iMinExp;
        const int iMaxExp;
    };
protected:
   	DECLARE_MESSAGE_MAP()
};
//
// TBitmapButton
//
// controls should be owner draw pushbuttons
class TBitmapButton : public TAutoControlBase {
public:
    TBitmapButton(UINT nIDBitmap,const TBaseEnabler& AEnabler = dftEnabler);
    TBitmapButton(UINT nID,CWnd* pParent,UINT nIDBitmap,const TBaseEnabler& AEnabler = dftEnabler);
    virtual ~TBitmapButton();
    virtual void InitUI();
    virtual bool Changed() const;
    void SetBitmap(UINT AnIDBitmap);
protected:
    UINT nIDBitmap;
    bool bDefault;
    CBitmap bmpSrc;
    TShadowResources sr;
    afx_msg void DrawItem(LPDRAWITEMSTRUCT);    
    afx_msg UINT OnGetDlgCode();
    afx_msg void OnEnable(BOOL);
    afx_msg LRESULT OnSetStyle(WPARAM wParam,LPARAM lParam);
    DECLARE_MESSAGE_MAP();
};
//
// T3DBitmapStatic
//
// controls should be frame rect static's (WM_PAINT msg is intercepted)
class T3DBitmapStatic : public TAutoControlBase {
public:
    T3DBitmapStatic(UINT nID,CWnd* pParent,UINT nIDInitialBitmap);
    T3DBitmapStatic(UINT nIDInitialBitmap);
    virtual ~T3DBitmapStatic();
    virtual void InitUI();
    virtual bool Changed() const;
    virtual void SetBitmap(UINT);
protected:
    UINT nIDBitmap;
    HBITMAP hbmpSrc;
    HDC hdcSrc;
    HGDIOBJ hbmpOldSrc;
    TShadowResources sr;
    afx_msg void OnPaint();
    DECLARE_MESSAGE_MAP();
};
//
// TAutoPopoutBitmapSelector
//
class TAutoPopoutBitmapSelector : public TBitmapButton {
friend class TAutoPopoutBitmapSelectorWindow;
public:
    TAutoPopoutBitmapSelector(int* pi,UINT nIDStatic,
                              const UINT* pStaticBitmaps,const UINT* pSelectionBitmaps,
                              int iBitmapsWide,int iBitmapsHigh,int iNumBitmaps,
                              const TBaseEnabler& AEnabler = dftEnabler);
    TAutoPopoutBitmapSelector(UINT nID,CWnd* pParent,
                              int* pi,UINT nIDStatic,
                              const UINT* pStaticBitmaps,const UINT* pSelectionBitmaps,
                              int iBitmapsWide,int iBitmapsHigh,int iNumBitmaps,
                              const TBaseEnabler& AEnabler = dftEnabler);
    virtual ~TAutoPopoutBitmapSelector();
private:
    TAutoPopoutBitmapSelectorWindow* pPopoutWnd;
    T3DBitmapStatic* pStatic;
    bool bDontEatClicked;
    static const UINT uWindowGoneMsg;
    virtual BOOL PreTranslateMessage(MSG* pMsg);
    afx_msg BOOL OnBNClicked();
    afx_msg LPARAM OnSelectionWindowGone(WPARAM,LPARAM);
    afx_msg void OnKillFocus(CWnd*);
    afx_msg UINT OnGetDlgCode();
    afx_msg void OnKeyDown(UINT nChar,UINT nRepCnt,UINT nFlags);
    afx_msg void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
    const UINT* pStaticBitmaps;
    const UINT* pSelectionBitmaps;
    const int iBitmapsWide;
    const int iBitmapsHigh;
    const int iNumBitmaps;
    const UINT nIDStatic;
    int* const pi;
    DECLARE_MESSAGE_MAP()
};
//***************************************
//
// TStaticForAutoRadioButton
//
class TStaticForAutoRadioButton : public TAutoControlBase {
public:
    TStaticForAutoRadioButton(UINT nID,CWnd* pParent,
                              TAutoRadioButton* pButton,UINT nIDBitmap);
    virtual ~TStaticForAutoRadioButton();
    virtual void InitUI();
    virtual bool Changed() const;
protected:
    void BuildBitmap();
    virtual void DrawOnBitmap(HDC);
    TAutoRadioButton* const pButton;
    const UINT nIDBitmap;
    HBITMAP hbmpSrc;
    HDC hdcSrc;
    bool PointOnUs(CPoint);
    afx_msg void OnPaint();
    afx_msg void OnLButtonDown(UINT,CPoint);
    afx_msg void OnLButtonUp(UINT,CPoint);
    afx_msg void OnMouseMove(UINT,CPoint);
    afx_msg UINT OnNcHitTest(CPoint);
    DECLARE_MESSAGE_MAP();
};
//
// TFancyStatic (does subscripts and superscripts)
//  encode ~s for subscript text
//         ~S for superscript text
//         ~n to go to normal text (default)
//
class TFancyStatic : public TStaticForAutoRadioButton {
public:
    TFancyStatic(UINT nID,CWnd* pParent,TAutoRadioButton* pBuddyButton = 0);
    virtual ~TFancyStatic();
    int GetTextPixelWidth() const;
protected:
    virtual void DrawOnBitmap(HDC);
    CString strCode;
    struct TTextPiece {
        RECT rc;
        char cDraw; // n=>normal, s=>subscript, S=>superscript
        CString str;
    };
    TList<TTextPiece*> lstptp;
    void ClearList();
    afx_msg void OnPaint();
    DECLARE_MESSAGE_MAP();
};

//*******************************************************
//
// TMyDialogExtraStuff
//
class TMyDialogExtraStuff {
    int iNumEditBoxes;
    TAutoEditBox* peb[20];
    bool bSubDialogsCreated;

	TList<CWnd*> lstwndSubDialogs;
	
    RECT rcSubDialogs;
    int iIDInsertAfter;
    HWND hwndLastInserted;
    bool bLastToBottom;
    void DestroySubDialogs();
    static const UINT WM_DIALOGEVENT;
	protected:
    TMyDialogExtraStuff();
    ~TMyDialogExtraStuff();
    void AddEditBox(TAutoEditBox* pebNew);
    void ForceEditBoxSync();
    void AddSubDialogs(CWnd* pParent,const TList<CWnd*>* plstwnd,int iIDInsertAfter,const RECT* prc);
    void AppendSubDialogToBottom(CWnd* pParent,CWnd* pSubDialog);
    void UpdateSubDialogsData();
    void CreateSubDialogs(CWnd* pParent);
    void CreateBottomSubDialog(CWnd* pParent);
    int MyBetterOnToolHitTest(const CWnd* pwnd,CPoint point, TOOLINFO* pTI) const;
    void ExtraStuffOnToolTipNeedText(NMHDR* pNMHDR,LRESULT* pResult );

};

//
// TMyDialog
//
//  Adds support for TAutoEditBoxes and virtual DoModeless
//
class TMyDialog : public CDialog, public TMyDialogExtraStuff {
public:
    TMyDialog();
    TMyDialog(UINT nIDTemplate,CWnd* pParentWnd = NULL);
    virtual void DoModeless(CWnd* pParent = NULL);
    void SetResourceID(int id);
    inline void AddSubDialogs(const TList<CWnd*>* plstwnd,int iIDInsertAfter = 0,const RECT* prc = 0) 
        { TMyDialogExtraStuff::AddSubDialogs(this,plstwnd,iIDInsertAfter,prc); }
    inline void AppendSubDialogToBottom(CWnd* pSubDialog) 
        { TMyDialogExtraStuff::AppendSubDialogToBottom(this,pSubDialog); }
    virtual void InitUI();
	
	//Overwrite to route command messages to parent dialog  //Gary Qui
	//virtual BOOL OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo);

    TNotifier notifier;
protected:
    void DoDataExchange(CDataExchange* pDX);
    virtual BOOL OnInitDialog();
    afx_msg LRESULT OnAutoControlLoosingFocus(WPARAM,LPARAM);
    afx_msg LRESULT OnDialogEvent(WPARAM,LPARAM);
    afx_msg void OnToolTipNeedText(NMHDR* pNMHDR,LRESULT* pResult );
    virtual int OnToolHitTest(CPoint point, TOOLINFO* pTI) const;
    virtual void OnCancel();
    virtual void OnOK();
    virtual void PostNcDestroy();
private:
    afx_msg LRESULT OnInitUI(WPARAM,LPARAM);    // override InitUI -- don't steal the message
    bool bModeless;
    afx_msg LRESULT OnAddEditBox(WPARAM wParam,LPARAM lParam);
   	DECLARE_MESSAGE_MAP()
};
//
// TMyPropertyPage
//
//  Adds support for TAutoEditBoxes and subdialog insertion
//
class TMyPropertyPage : public CPropertyPage, public TMyDialogExtraStuff {
public:
    TMyPropertyPage(UINT nIDTemplate,UINT nIDCaption = 0);
    inline void AddSubDialogs(const TList<CWnd*>* plstwnd,int iIDInsertAfter = 0,const RECT* prc = 0) 
        { TMyDialogExtraStuff::AddSubDialogs(this,plstwnd,iIDInsertAfter,prc); }
    inline void AppendSubDialogToBottom(CWnd* pSubDialog) 
        { TMyDialogExtraStuff::AppendSubDialogToBottom(this,pSubDialog); }
    virtual void InitUI();
    TNotifier notifier;
protected:
    virtual void DoDataExchange(CDataExchange* pDX);
    virtual BOOL OnInitDialog();
    virtual int OnToolHitTest(CPoint point, TOOLINFO* pTI) const;
    afx_msg LRESULT OnAutoControlLoosingFocus(WPARAM,LPARAM);
    afx_msg LRESULT OnDialogEvent(WPARAM,LPARAM);
    afx_msg void OnToolTipNeedText(NMHDR* pNMHDR,LRESULT* pResult );
private:
    afx_msg LRESULT OnInitUI(WPARAM,LPARAM);    // override InitUI -- don't steal the message
    afx_msg LRESULT OnAddEditBox(WPARAM wParam,LPARAM lParam);
   	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////
#endif
