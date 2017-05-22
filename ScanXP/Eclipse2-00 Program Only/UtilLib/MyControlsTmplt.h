#include <math.h>

template<class T>
CString TUnitsTableTmplt<T>::UnitsFromMultiplier(double d) const {
    for (int i = 0; i < GetNumUnits(); i++) {
        double dDiff = d - MultiplierFromIndex(i);
        if (fabs(dDiff/d) <= 1e-3) return UnitsFromIndex(i);
	}
    return _T("");
}

template<class T>
CString TUnitsTranslator<T>::ToString(const T& t,HWND hwndFocus) const {
    return pRealTranslator->ToString(t / *ptMultiplier,hwndFocus); 
}
template<class T>
const T& TUnitsTranslator<T>::FromString(const char* psz,HWND hwndFocus) const {
    static T t;
    t = pRealTranslator->FromString(psz,hwndFocus) * *ptMultiplier;
    return t;
}
template<class T>
void TAutoNumberWithUnitsEditBoxTmplt<T>::InitUI() {
    TBase::InitUI();
    if (plbUnits == NULL) plbUnits = CreateUnitsListBox(iUnitListBoxID,GetParent());
    else plbUnits->InitUI();
}
template<class T>
TAutoListBox* TAutoNumberWithUnitsEditBoxTmplt<T>::CreateUnitsListBox(int iID,CWnd* pParent) {
    ASSERT(pUnitsTable);    // must provide a units table unless this function is overridden
    return new TBuddyUnitsListBoxTmplt<T>(iID,pParent,ptMultiplier,this,enab);
}
BEGIN_TEMPLATE_MESSAGE_MAP(class T,TAutoNumberWithUnitsEditBoxTmplt<T>,TBase)
    ON_WM_KILLFOCUS()
    ON_WM_SETFOCUS()
END_MESSAGE_MAP()
template<class T>
void TAutoNumberWithUnitsEditBoxTmplt<T>::OnKillFocus(CWnd* pNewWnd) {
    if (bInitialized && pNewWnd != plbUnits) 
        TAutoEditBox::OnKillFocus(pNewWnd);
    else
        TAutoControlBase::OnKillFocus(pNewWnd);
}
template<class T>
void TAutoNumberWithUnitsEditBoxTmplt<T>::OnSetFocus(CWnd* pOldWnd) {
    if (bInitialized && pOldWnd != plbUnits) 
        TAutoEditBox::OnSetFocus(pOldWnd);
    else
        TAutoControlBase::OnKillFocus(pOldWnd);
}

template<class T>
void TBuddyUnitsListBoxTmplt<T>::InitUI() {
    TAutoListBox::InitUI();
    tInitMultiplier = *ptMultiplier;
}
template<class T>
LPARAM TBuddyUnitsListBoxTmplt<T>::DataToItem(const void* pv) const {
    const T& tMultiplierToFind = *static_cast<const T*>(pv);
    for (int i = 0; i < peb->pUnitsTable->GetNumUnits(); i++) {
        double dDiff = tMultiplierToFind - peb->pUnitsTable->MultiplierFromIndex(i);
        if (fabs(dDiff/tMultiplierToFind) <= 1e-3) return i;
    }
    ASSERT(0);  // not found!!! 
    #ifdef _DEBUG
    // step thru this code to find out why we got a not found
    for (i = 0; i < peb->pUnitsTable->GetNumUnits(); i++) {
        double dDiff = tMultiplierToFind - peb->pUnitsTable->MultiplierFromIndex(i);
        if (fabs(dDiff/tMultiplierToFind) <= 1e-3) return i;
    }
    #endif
    return 0;
}
template<class T>
const void* TBuddyUnitsListBoxTmplt<T>::ItemToData(LPARAM lp) const {
    static T t;
    t = peb->pUnitsTable->MultiplierFromIndex(lp);
    return &t;
}
template<class T>
void TBuddyUnitsListBoxTmplt<T>::LoadListBox() {
    for (int i = 0; i < peb->pUnitsTable->GetNumUnits(); i++) AddString(peb->pUnitsTable->UnitsFromIndex(i),i);
}
BEGIN_TEMPLATE_MESSAGE_MAP(class T,TBuddyUnitsListBoxTmplt<T>,TAutoListBox)
    ON_WM_KILLFOCUS()
    ON_CONTROL_REFLECT_EX(LBN_SELCHANGE,OnSelChange) // Note that LBN_SELCHANGE = CBN_SELCHANGE
    ON_WM_SETFOCUS()
END_MESSAGE_MAP()
template<class T>
void TBuddyUnitsListBoxTmplt<T>::OnKillFocus(CWnd* pNewWnd) {
    hwndGettingFocus = *pNewWnd;        // go ahead and do this early for ForceDataSync
    if (bInitialized && pNewWnd != peb)
        peb->ForceDataSync();
    TAutoListBox::OnKillFocus(pNewWnd);
}
template<class T>
void TBuddyUnitsListBoxTmplt<T>::OnSetFocus(CWnd* pOldWnd) {
    TAutoListBox::OnSetFocus(pOldWnd);
    if (bInitialized && pOldWnd != peb) 
        peb->ForceDataSync();
}
template<class T>
BOOL TBuddyUnitsListBoxTmplt<T>::OnSelChange() {
    TAutoListBox::OnSelChange();
    if (tInitMultiplier != *ptMultiplier) peb->DeclareEdited();
    return FALSE;
}
