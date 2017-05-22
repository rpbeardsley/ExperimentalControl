#include "stdafx.h"
#include "IntegralSecondsEntry.h"
#include "NumberUtils.h"
#include <math.h>

CString TIntegralSecondsEntryTranslator::ToString(const double& dSignificand,HWND hwndFocus) const {
    HWND hwndEB = ::GetDlgItem(*pwnd,ideb);
    HWND hwndCB = ::GetDlgItem(*pwnd,idcb);
    bool bFocusGoingAway = (hwndFocus != hwndEB && hwndFocus != hwndCB);
    int iDPsToShow = bFocusGoingAway ? Min(3,::RoundToNearestInt(floor(log10(*pdMultiplier)))) : 3;
    CString strRet;
    strRet.Format("%0.*f",iDPsToShow,dSignificand);
    return strRet;
}

const double& TIntegralSecondsEntryTranslator::FromString(const char* psz,HWND hwndFocus) const {
    static double dSignificand;
    dSignificand = TBase::FromString(psz,hwndFocus);
    HWND hwndEB = ::GetDlgItem(*pwnd,ideb);
    HWND hwndCB = ::GetDlgItem(*pwnd,idcb);
    bool bFocusGoingAway = (hwndFocus != hwndEB && hwndFocus != hwndCB);
    double dSignificantDPs = bFocusGoingAway ? Min(3.0,floor(log10(*pdMultiplier))) : 3.0;
    dSignificand = ::RoundToNearest(dSignificand,pow(10.0,-dSignificantDPs));
    return dSignificand;
}

double TIntegralSecondsEntryUnitsTable::MultiplierFromIndex(int i) const {
    static const double d[] = { 1.0, 60.0, 3600.0, 86400.0 };
    ASSERT(i < 4);
    return d[i];
}
CString TIntegralSecondsEntryUnitsTable::UnitsFromIndex(int i) const {
    const char* const psz[] = { _T("sec"),_T("min"),_T("hr"),_T("days") };
    ASSERT(i < 4);
    return psz[i];
}
