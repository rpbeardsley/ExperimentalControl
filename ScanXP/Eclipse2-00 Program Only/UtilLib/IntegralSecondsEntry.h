#ifndef __IntegralSecondsEntry_h
#define __IntegralSecondsEntry_h

#include "MyControls.h"

struct TIntegralSecondsEntryTranslator : TAutoDoubleEditBox::TDftTranslator {
    inline TIntegralSecondsEntryTranslator(CWnd* Apwnd,int Aideb,int Aidcb,double* ApdMultiplier)
        : pdMultiplier(ApdMultiplier),pwnd(Apwnd),ideb(Aideb),idcb(Aidcb) { }
    virtual CString ToString(const double& d,HWND hwndFocus) const;
    virtual const double& FromString(const char* psz,HWND hwndFocus) const;
    virtual TAutoDoubleEditBox::TTranslator* Dup() const { return new TIntegralSecondsEntryTranslator(*this); }
private:
    const double* const pdMultiplier;
    const CWnd* const pwnd;
    const int ideb;
    const int idcb;
    typedef TAutoDoubleEditBox::TDftTranslator TBase;
};
struct TIntegralSecondsEntryUnitsTable : TUnitsTableTmplt<double> {
    virtual double MultiplierFromIndex(int) const;
    virtual CString UnitsFromIndex(int) const;
    virtual int GetNumUnits() const { return 4; }
    virtual TUnitsTableTmplt<double>* Dup() const { return new TIntegralSecondsEntryUnitsTable(*this); }
};

inline TAutoNumberWithUnitsEditBoxTmplt<double>* 
    CreateIntegralSecondsEntry(CWnd* pParent,int ideb,int idcb,double *pdSec,double *pdUnits,
                               const TBaseEnabler& enab) {
    return new TAutoNumberWithUnitsEditBoxTmplt<double>(ideb,pParent,idcb,pdSec,pdUnits,
                                                        TIntegralSecondsEntryTranslator(pParent,ideb,idcb,pdUnits),
                                                        enab,TIntegralSecondsEntryUnitsTable());
}

#endif