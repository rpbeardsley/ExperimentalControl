#ifndef __Statistics_h
#define __Statistics_h
#include <afxtempl.h>
#include "complex.h"

// System for determining if complex data from analyzer has converged
class TStatPointNode : public CObject {
public:
    TStatPointNode(const TComplex *pcValue, DWORD dwTimeStamp);
    const TComplex cValue;
    const DWORD dwTimeStamp;
};

class TStatPoint {
public:
    TStatPoint(int nMaxEntryCount);
    TStatPoint::~TStatPoint();
    bool Average(TComplex *pcValue);
    bool GetBest(TComplex *pcValue, double dMagErrLim, double dPhaseErrLim);
    int GetCount(void);
    void AddValue(TComplex *pcValue, DWORD dwTimeStamp = ::GetTickCount());
    void Clear(void);

private:
    const int nMaxEntryCount;
    CTypedPtrList<CObList,TStatPointNode *> lstValues;
};
#endif
