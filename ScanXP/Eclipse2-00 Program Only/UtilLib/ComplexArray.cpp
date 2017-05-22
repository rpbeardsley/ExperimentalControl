
#include "stdafx.h"
#include "Complex.h"
#include "NumberUtils.h"
#include "math.h"


TBaseComplexArray::TBaseComplexArray(DWORD dwNumPoints,bool bInit) 
 : dwN(dwNumPoints),pc(new TComplex[dwNumPoints]) {
    if (bInit) Zero();
}
TBaseComplexArray::TBaseComplexArray(const TBaseComplexArray& Src) 
 : dwN(Src.GetNumPoints()),pc(new TComplex[Src.GetNumPoints()]) {
    *this = Src;
}
TBaseComplexArray::~TBaseComplexArray() {
    delete [] pc;
}
TBaseComplexArray& TBaseComplexArray::operator=(const TBaseComplexArray& Src) {
    ASSERT(GetNumPoints() == Src.GetNumPoints());
    TComplex* pcLoc = pc;
    for (DWORD dwRow = 0; dwRow < dwN; dwRow++,pcLoc++) *pcLoc = Src[dwRow];
    return *this;
}
TBaseComplexArray& TBaseComplexArray::operator*=(double d) {
    TComplex* pcLoc = pc;           
    for (DWORD dwRow = 0; dwRow < dwN; dwRow++,pcLoc++) *pcLoc *= d;
    return *this;
}
TBaseComplexArray& TBaseComplexArray::operator/=(double d) {
    TComplex* pcLoc = pc;           
    for (DWORD dwRow = 0; dwRow < dwN; dwRow++,pcLoc++) *pcLoc /= d;
    return *this;
}
TBaseComplexArray& TBaseComplexArray::operator*=(const TComplex& c) {
    TComplex* pcLoc = pc;           
    for (DWORD dwRow = 0; dwRow < dwN; dwRow++,pcLoc++) *pcLoc *= c;
    return *this;
}
void TBaseComplexArray::Zero() {
    TComplex* pcLoc = pc;           
    for (DWORD dwRow = 0; dwRow < dwN; dwRow++,pcLoc++) 
        pcLoc->GetReal() = pcLoc->GetImag() = 0.0;
}
double TBaseComplexArray::SumSquareMagnitude() const {
    double dSum = 0.0;
    for (DWORD dw = 0; dw < dwN; dw++) dSum += pc[dw].GetRadius2();
    return dSum;
}
double TBaseComplexArray::MaxMagnitude() const {
    double dMax2 = 0.0;
    for (DWORD dw = 0; dw < dwN; dw++) {
        double dMag2Here = pc[dw].GetRadius2();
        if (dMag2Here > dMax2) dMax2 = dMag2Here;
    }
    return sqrt(dMax2);
}

TUnitVectorTable::TUnitVectorTable(double dPointsPerRevolution,DWORD dwTotalPoints) 
: TBaseComplexArray(dwTotalPoints,false) {
    TComplex* pcLoc = pc;           
    for (DWORD dw = 0; dw < dwN; dw++,pcLoc++) 
        pc[dw].FromPolar(1.0,dw * 2.0*Pi() / dPointsPerRevolution);
}

TComplexArray::TComplexArray(DWORD dwNumPoints,bool bInit) 
 : TBaseComplexArray(dwNumPoints,bInit),uvt(-((double)dwNumPoints),dwNumPoints/2) {
    ASSERT(dwNumPoints == (DWORD)(1 << LogBase2OfDWORD(dwNumPoints)));  // verify caller specified exact power of 2
}
TComplexArray::TComplexArray(const TComplexArray& Src) 
 : TBaseComplexArray(Src),uvt(-((double)(Src.GetNumPoints())),Src.GetNumPoints()/2) {
}
TComplexArray& TComplexArray::operator=(const TBaseComplexArray& Src) {
    return (TComplexArray&)(TBaseComplexArray::operator=(Src));
}
void TComplexArray::TimeShiftSpectralDensity(double dPoints) {
    // note that running the for loop to dwN and removing the 
    // Conj assignment will only work for integer values of dPoints.
    for (DWORD dw = 1; dw < dwN/2; dw++) {
        double dRadians = 2.0 * Pi() * (double)dw * dPoints / dwN;
        TComplex cShift(cos(dRadians),sin(dRadians));
        pc[dw] *= cShift;
        pc[dwN-dw] = Conj(pc[dw]);
    }
}
void TComplexArray::DoFourierTransform() {
    DoFFTFirstTwoColumns(false);    // do first two specially optimized columns
    DoFFTColumnLoop(4,false);       // do remaining generic columns
    *this /= (double) dwN;
}
void TComplexArray::DoInverseFourierTransform() {
    DoFFTFirstTwoColumns(true);     // do first two specially optimized columns
    DoFFTColumnLoop(4,true);        // do remaining generic columns
}
void TComplexArray::LoadAsFourierTransformFromReals(const int iRealsOnly[])  {
    DoFFTLoadFromRealsAndFirstColumn(iRealsOnly,false); // load in reversed order, and run first column
    DoFFTFromRealsSecondColumn(false);                  // run second column as special case
    DoFFTColumnLoop(4,false);                           // Do remaining columns
    *this /= (double) dwN;
}

void TComplexArray::LoadAsInverseFourierTransformFromReals(const int iRealsOnly[])  {
    DoFFTLoadFromRealsAndFirstColumn(iRealsOnly,true); // load in reversed order, and run first column
    DoFFTFromRealsSecondColumn(true);                  // run second column as special case
    DoFFTColumnLoop(4,true);       // Do remaining columns
}

void TComplexArray::LoadAsFourierTransformFromReals(const double dRealsOnly[])  {
    DoFFTLoadFromRealsAndFirstColumn(dRealsOnly,false); // load in reversed order, and run first column
    DoFFTFromRealsSecondColumn(false);                  // run second column as special case
    DoFFTColumnLoop(4,false);                           // Do remaining columns
    *this /= (double) dwN;
}

void TComplexArray::LoadAsInverseFourierTransformFromReals(const double dRealsOnly[])  {
    DoFFTLoadFromRealsAndFirstColumn(dRealsOnly,true); // load in reversed order, and run first column
    DoFFTFromRealsSecondColumn(true);                  // run second column as special case
    DoFFTColumnLoop(4,true);       // Do remaining columns
}

void TComplexArray::DoFFTFirstTwoColumns(bool bInverse) {
    // since source and dest arrays are the same, we have to reverse the array up front
    for (DWORD dwStraight = 0; dwStraight < dwN; dwStraight++) {
        DWORD dwReversed = BitReverse(dwStraight);
        if (dwStraight >= dwReversed) continue;     // only swap values once, perhaps not at all
        // swap values at straight and reverse indexes
        TComplex cTemp = pc[dwStraight];    // save original straight
        pc[dwStraight] = pc[dwReversed];    // set value at straight index to value at reversed index
        pc[dwReversed] = cTemp;             // vice/versa to complete the swap
    }
    // do first column of butterflies as a special case since only the only multiplication is by one
    for (DWORD dwRow = 0; dwRow < dwN; dwRow+=2) {
        TComplex* pcUpper = &pc[dwRow];
        TComplex* pcLower = &pc[dwRow+1];
        TComplex cTemp = *pcLower;      // save original lower
        *pcLower = *pcUpper - cTemp;    // new lower is upper minus old lower     
        *pcUpper = *pcUpper + cTemp;    // new upper is old upper plus old lower
    }
    // second column of butterflies is also special because everything that comes in is real and all Wk is
    // either one or j.
    TComplex* pcLoc = pc;
    for (dwRow = 0; dwRow < dwN; dwRow+=4) {
        // do first/third row butterfly
        TComplex cLower = pcLoc[2];     // save lower
        pcLoc[2] = pcLoc[0] - cLower;   // new lower is upper minus old lower
        pcLoc[0] = pcLoc[0] + cLower;   // new upper is old upper plus old lower
        // do second/fouth row butterfly
        pcLoc++;
        TComplex cLowerX(-pcLoc[2].GetImag(),pcLoc[2].GetReal());   // get lower times j
        if (!bInverse) 
            cLowerX *= -1.0;     // might need times -j
        pcLoc[2] = pcLoc[0] - cLowerX;
        pcLoc[0] = pcLoc[0] + cLowerX;
        // bump up to next butterfly group
        pcLoc = &pcLoc[3];
    }
}

void TComplexArray::DoFFTLoadFromRealsAndFirstColumn(const double dRealsOnly[],bool bInverse) {
    // do first column of butterflies as a special case since only reals are involved
    ::ZeroMemory(pc,dwN * sizeof(TComplex));    // zero out whole array so we don't have to set imag to zero
    TComplex* pcLoc = pc;
    for (DWORD dwRow = 0; dwRow < dwN; dwRow+=2) {
        double dUpperReal = dRealsOnly[BitReverse(dwRow)];
        double dLowerReal = dRealsOnly[BitReverse(dwRow+1)];
        pcLoc->GetReal() = dUpperReal + dLowerReal;
        pcLoc++;
        pcLoc->GetReal() = dUpperReal - dLowerReal;
        pcLoc++;
    }
}

void TComplexArray::DoFFTLoadFromRealsAndFirstColumn(const int iRealsOnly[],bool bInverse) {
    // do first column of butterflies as a special case since only reals are involved
    ::ZeroMemory(pc,dwN * sizeof(TComplex));    // zero out whole array so we don't have to set imag to zero
    TComplex* pcLoc = pc;
    for (DWORD dwRow = 0; dwRow < dwN; dwRow+=2) {
        int iUpperReal = iRealsOnly[BitReverse(dwRow)];
        int iLowerReal = iRealsOnly[BitReverse(dwRow+1)];
        pcLoc->GetReal() = (double)(iUpperReal + iLowerReal);
        pcLoc++;
        pcLoc->GetReal() = (double)(iUpperReal - iLowerReal);
        pcLoc++;
    }
}
void TComplexArray::DoFFTFromRealsSecondColumn(bool bInverse) {
    // second column of butterflies is also special because everything that comes in is real and all Wk is
    // either one or j.
    TComplex* pcLoc = pc;
    for (DWORD dwRow = 0; dwRow < dwN; dwRow+=4) {
        // do first/third row butterfly
        double dTemp = pcLoc[2].GetReal();                  // save lower
        pcLoc[2].GetReal() = pcLoc[0].GetReal() - dTemp;    // new lower is upper minus old lower
        pcLoc[0].GetReal() = pcLoc[0].GetReal() + dTemp;    // new upper is old upper plus old lower
        // do second/fouth row butterfly
        pcLoc++;
        if (bInverse) {
            pcLoc[2].GetImag() = -pcLoc[2].GetReal();
            pcLoc[0].GetImag() = pcLoc[2].GetReal();
        } else {
            pcLoc[2].GetImag() = pcLoc[2].GetReal();
            pcLoc[0].GetImag() = -pcLoc[2].GetReal();
        }
        pcLoc[2].GetReal() = pcLoc[0].GetReal();
        // bump up to next butterfly group
        pcLoc = &pcLoc[3];
    }
}

// loop for each column. Column numbers go 1,2,4,8,16.....
void TComplexArray::DoFFTColumnLoop(DWORD dwColumn,bool bInverse) {
    // figure initial bump of multiplier angle indexes
    DWORD dwAngleBump = BitReverse(dwColumn);
    while (dwColumn < dwN) {   
        // set up loop for each butterfly in the column 
        DWORD dwRow = 0;                // start with first row
        DWORD dwAngleIndex = 0;         // start with zero angle
        while (dwRow < dwN) {   // while we have a row to do
            TComplex* pcUpper = &pc[dwRow];             // upper side of butterfly
            TComplex* pcLower = &pcUpper[dwColumn];     // lower side of butterfly
            TComplex cWk = uvt[dwAngleIndex];           // get current angle offset
            if (bInverse) cWk.GetImag() = -cWk.GetImag();   // use conjugate if inverse transform
            TComplex cTemp = (*pcLower * cWk);  // apply angle offset to lower
            *pcLower = *pcUpper - cTemp;        // calc new lower
            *pcUpper = *pcUpper + cTemp;        // calc new upper
            dwRow++;                    // assume next row needs processing    
            if (dwRow & dwColumn) {     // if we need to bump to next group
                dwRow += dwColumn;      // index first row in next group
                dwAngleIndex = 0;       // back to zero angle for start of next group
            } // end if we bumped a group
            else dwAngleIndex += dwAngleBump;
        } // end while we have a row to convert
        dwAngleBump >>= 1;  // next column means get more steps on angle means half as many angles
        dwColumn <<= 1;
    } // end for each column
}
/*
void TComplexArray::InitializeFFTAngleConstants() {
    if (pcWk) return;
    // allocate array for angle contants. These constants are exp(-j*2*pi*k/N) where k is the bin of 
    // interest. There of dwNumPoints/2 angles. Divide by two because remaining half is just minus
    // the first half, and we don't bother to calculate it.
    DWORD dwNumAngles = dwN/2;
    pcWk = new TComplex[dwNumAngles];
    // Find the incremental angle.
    TComplex cDelAngle;
    cDelAngle.FromPolar(1.0,-2.0*Pi()/dwN);
    // now calculate the array of angles by raising the incremental angle to increasing powers.
    // Note that this may be error prone because any error originally in cDelAngle will be 
    // taken to the same power as the angle itself.
    TComplex cAngle(1.0,0.0);
    for (DWORD dw = 0; dw < dwNumAngles; dw++) {
        pcWk[dw] = cAngle;
        cAngle *= cDelAngle;
    }
    #ifdef _DEBUG
    // figure how much error accumulated -- might need to do the FromPolar on each point.....
    TComplex cTemp;
    cTemp.FromPolar(1.0,-2.0*Pi()*(dwNumAngles-1)/dwN);
    cTemp-=pcWk[dwNumAngles-1];
    TRACE("Final FFT Angle Error is (%0.4g,%0.4g)\n",cTemp.GetReal(),cTemp.GetImag());
    #endif
}
*/
#pragma warning(disable:4035)
DWORD TComplexArray::BitReverse(DWORD dw) const {
    DWORD dwN = this->dwN;
    __asm {
            bsf     ecx,dwN         // number of bits in index for a point
            mov     ebx,dw          // source word
            mov     eax,0           // init return value
BitLoop:    shr     ebx,1           // pull the low bit from the source
            rcl     eax,1           // stuff it in the bottom of the dest
            loop    BitLoop         // do it till we pulled and stuffed them all 
            mov     dwN,eax         // get answer on stack so compilier will be happy
    }
    return dwN;     // get answer off stack into eax where it already is, so we can return it
}
#pragma warning(default:4035)

