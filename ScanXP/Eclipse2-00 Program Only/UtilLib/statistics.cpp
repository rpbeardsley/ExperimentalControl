#include "stdafx.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif
#include <math.h>
#include "Statistics.h"

//*************************************************************************************
//
// TStatPoint Implementation
//
TStatPointNode::TStatPointNode(const TComplex *pcValue, DWORD AdwTimeStamp)
: cValue(*pcValue), dwTimeStamp(AdwTimeStamp) {
}

TStatPoint::TStatPoint(int AnMaxEntryCount)
: nMaxEntryCount(AnMaxEntryCount) {
    ASSERT(nMaxEntryCount > 0);
}

TStatPoint::~TStatPoint() {
    Clear();
}

bool TStatPoint::Average(TComplex *pcValue) {
    POSITION Pos;
    TStatPointNode *pTRANode;
    TComplex cSum(0.0,0.0);
    int nCount = lstValues.GetCount();

    if(nCount > 0) {
        for(Pos = lstValues.GetHeadPosition(); Pos != NULL;) {
            pTRANode = lstValues.GetNext(Pos);
            cSum += pTRANode->cValue;
        }

        cSum /= nCount;
        *pcValue = cSum;

    } else {
        *pcValue = TComplex(0.0,0.0);
    }

    // Return true if we have a full list
    return (bool)(nCount >= nMaxEntryCount);
}

bool TStatPoint::GetBest(TComplex *pcValue, double dMagErrLim, double dPhaseErrLim) {
    POSITION Pos;
    TStatPointNode *pTRANode;
    int nCount = lstValues.GetCount();
    bool bRet = false;
    TComplex cAverage(0.0,0.0);
    double dMagErr, dPhaseErr;

    if(nCount > 1) {
        Pos = lstValues.GetTailPosition();
        if(Pos != NULL) {
            pTRANode = lstValues.GetAt(Pos);
            *pcValue = pTRANode->cValue;

            Average(&cAverage);         // compare the average point to the last point
            dMagErr = fabs(cAverage.GetRadius() - pcValue->GetRadius());
            dMagErr /= pcValue->GetRadius(); // convert mag error to relative error
            dPhaseErr = fabs(cAverage.GetAngle() - pcValue->GetAngle());
            TRACE("MagErr=%.4G, PhaseErr=%.4G\n", dMagErr, dPhaseErr);

            // Return true if we have a full list and we meet our limits
            if(nCount >= nMaxEntryCount) {
                bRet = (bool)((dMagErr < dMagErrLim) && (dPhaseErr < dPhaseErrLim));
            }

        } else {
            *pcValue = TComplex(0.0,0.0);
        }

    } else {
        *pcValue = TComplex(0.0,0.0);
    }
    return bRet;
}

void TStatPoint::AddValue(TComplex *pcValue, DWORD dwTimeStamp) {
    lstValues.AddTail(new TStatPointNode(pcValue, dwTimeStamp));
    if(lstValues.GetCount() > nMaxEntryCount) {
        delete lstValues.GetHead();
        lstValues.RemoveHead();
    }
}

void TStatPoint::Clear(void) {
    POSITION Pos, TRANodePos;
    TStatPointNode *pTRANode;

    for(Pos = lstValues.GetHeadPosition(); Pos != NULL;) {
        TRANodePos = Pos;
        pTRANode = lstValues.GetNext(Pos);
        lstValues.RemoveAt(TRANodePos);
        delete pTRANode;
    }
}

int TStatPoint::GetCount(void) {
    return lstValues.GetCount();
}
