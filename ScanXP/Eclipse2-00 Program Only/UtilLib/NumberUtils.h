#ifndef __NumberUtils_h
#define __NumberUtils_h

#include <math.h>

double DivideByZero();

double Sq(double dx);

inline double Min(double d0,double d1) 
    { return (d0<d1)?d0:d1; }
inline int Min(int i0,int i1)
    { return (i0<i1)?i0:i1; }
inline DWORD Min(DWORD dw0,DWORD dw1)
    { return (dw0<dw1)?dw0:dw1; }

inline double Max(double d0,double d1) 
    { return (d0>d1)?d0:d1; }
inline int Max(int i0,int i1) 
    { return (i0>i1)?i0:i1; }
inline DWORD Max(DWORD dw0,DWORD dw1) 
    { return (dw0>dw1)?dw0:dw1; }

inline double MinAbs(double d0,double d1) 
    { return (fabs(d0)<fabs(d1))?d0:d1; }
inline double MaxAbs(double d0,double d1) 
    { return (fabs(d0)>fabs(d1))?d0:d1; }


int ShiftLeftN(int* piShiftThis,int iHowManyTimes);

bool IsBetween(double dTest,double dEndPoint1,double dEndPoint2);

#ifndef _EMBEDDED

CString IntegralSecondsNotation(double dSeconds,double dTimeUnits);

CString EngineeringNotation(double d,int iSigDigits,bool bSmallMeansZero);

#endif // not _EMBEDDED

double RoundToNearest(double d,double dResulution);

int RoundToNearestInt(double d);
// this version of the function can always rounds 1/2's in the positive direction
int __stdcall RoundToNearestInt(int iNumerator,int iDenominator);

double Nan();
double PInf();
double NInf();
bool IsPInf(double var);
bool IsNInf(double var);

inline double Sign(double d) { return (d >= 0.0) ? 1.0 : -1.0; }

inline int Bound(int i,int lo,int hi) { return Min(Max(i,lo),hi); }
inline double Bound(double d,double lo,double hi) { return Min(Max(d,lo),hi); }

inline double Interpolate(double dx0,double dy0,double dx1,double dy1,double dxToFindyAt) {
    return dy0 + (dy1 - dy0)/(dx1 - dx0) * (dxToFindyAt - dx0);
}

//This function will find the max WORD in a array of WORD
//All comparisons are unsigned compare
WORD FindMaxWord(WORD* pw, int count);
WORD FindMinWord(WORD* pw, int count);

//#pragma optimize("",off )
//#pragma warning(disable:4035)   // no return value 
// value comes from numeric recipies sec 20.6
inline double Pi() { return 3.141592653589793238462643; }
//inline double Pi() { __asm fldpi }    // causes optimizer crash
//#pragma warning(default:4035)
//#pragma optimize("",on )

//inline double Pi() { 
//    register double m1; 
//    __asm fldpi; 
//    __asm fstp m1 
//    return m1; 
//} 

#pragma warning(disable:4035)   // no return value 
inline DWORD LogBase2OfDWORD(DWORD dwN) { __asm bsr eax,dwN }
#pragma warning(default:4035)

class TNumericExeceptionsEnable {
public:
    TNumericExeceptionsEnable(bool bEnable);
    ~TNumericExeceptionsEnable();
protected:
    UINT npuOriginal;
    
};

void __AnyFunctionCall();   // support for echem try definition (see EchemPackageAPI.h)

void LineFitForEvenlySpacedPoints(double *pdSlope,double *pdIntercept,
                                  const double *pdValues,int iNumPoints,
                                  const double* pdErrors = 0,
                                  double* pdSlopeError = 0,double* pdInterceptError = 0,
                                  double* pdChiSquare = 0);

#ifndef _EMBEDDED
// <EL9>+
// Support for converting floating point numbers (floats or doubles) between US
// English notation and other locales. US English uses the '.' for decimals in
// floting point numbers and other locales may use anything (frequently ',').
void LocalFloatResetLocale(void);
void USFloatToLocal(char *szFloatString);
void LocalFloatToUS(char *szFloatString);
// <EL9>-
#endif // end if not _EMBEDDED

#endif
