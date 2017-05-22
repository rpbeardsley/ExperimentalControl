
#include "stdafx.h"
#include "NumberUtils.h"
#include "math.h"
#include "float.h"


#pragma warning(disable:4723 4756)   // potential divide by zero, overflow
double DivideByZero() {
    double dVal = 1.0;
    dVal /= 0.0;    // force floating point exception if enabled!
    return dVal;    // if not enabled, return Nan
}
#pragma warning(default:4723 4756)   // potential divide by zero

static union { DWORD dw[2]; double d; } nan = { 0x00000000,0x7FF80000 };
static union { DWORD dw[2]; double d; } pinf = { 0x00000000,0x7FF00000 };
static union { DWORD dw[2]; double d; } ninf = { 0x00000000,0xFFF00000 };

double Nan() {
    return nan.d;
}

double PInf() {
    return pinf.d;
}

//Is Positive infinity? //Gary Added this
bool IsPInf(double dVal){
	return (dVal == pinf.d);
}

double NInf() {
    return ninf.d;
}

//Is Negative infinity? //Gary Added this
bool IsNInf(double dVal){
	return (dVal == ninf.d);
}

double Sq(double dx) {
    return dx*dx;
}

bool IsBetween(double dTest,double dEndPoint1,double dEndPoint2) {
    if (dEndPoint1 < dEndPoint2)
        return dTest >= dEndPoint1 && dTest <= dEndPoint2;
    else
        return dTest >= dEndPoint2 && dTest <= dEndPoint1;
}
namespace {
    #pragma warning(disable:4035)   // no return value
    int __stdcall ShiftLeftNGuts(int* piShiftThis,int iHowManyTimes) {
        __asm {
                MOV     CL,BYTE PTR iHowManyTimes
                MOV     EDX,piShiftThis
                MOV     EBX,[EDX]
                XOR     EAX,EAX
                SHLD    EAX,EBX,CL
                SHL     EBX,CL
                MOV     [EDX],EBX
        }
    }
    #pragma warning(default:4035)
}
int ShiftLeftN(int* piShiftThis,int iHowManyTimes) {
    if (iHowManyTimes < 32) 
        return ShiftLeftNGuts(piShiftThis,iHowManyTimes);
    else {
        int iRet = *piShiftThis << (iHowManyTimes - 32);
        *piShiftThis = 0;
        return iRet;
    }
}

#ifndef _EMBEDDED // {

CString IntegralSecondsNotation(double dSeconds,double dTimeUnits) {
    const char* pszUnits = 0;
    double dMul = 1.0;
    if (dTimeUnits == 60.0) {
        pszUnits = _T("min"); dMul = dTimeUnits;
    } else if (dTimeUnits == 3600.0) {
        pszUnits = _T("hr"); dMul = dTimeUnits;
    } else if (dTimeUnits == 86400.0) {
        pszUnits = _T("days"); dMul = dTimeUnits;
    }
    CString strRet;
    if (dMul == 1.0)
        strRet.Format(_T("%0.0f sec"),dSeconds);
    else
        strRet.Format(_T("%0.1f %s"),dSeconds/dMul,pszUnits);
    return strRet;
}

CString EngineeringNotation(double d,int iSigDigits,bool bSmallMeansZero) {
    const char szPrefixBig[] = _T("kMGT");
    const char szPrefixSml[] = _T("m\xB5npf");
    CString strRet;
    if (bSmallMeansZero && // if not supposed to show E notation for small stuff
        fabs(d) < 1.0E-15) // and this is really small stuff
        d = 0.0;           // then declare exactly zero
    if (fabs(d) < 1.0E-50) {  // if damn small don't even rely on scientific notation
        strRet.Format(_T("% #0.*f "),iSigDigits-1,0.0); // format a real zero
        return strRet;
    } else {
        double dExpDiv3,dSignificand;
        dExpDiv3 = floor(log10(fabs(d)) / 3.0);
        dSignificand = d / pow(10.0,dExpDiv3 * 3.0);
        // find out if rounding for significant digits will cause a 
        // bump to the next prefix (ie 999.8 with 3 sig digits specified)
        if (fabs(dSignificand) >= (1000.0 - pow(10.0,3.0 - iSigDigits) / 2.0)) {
            dExpDiv3++;
            dSignificand /= 1000.0;
        }
        if (dExpDiv3 > 4.0 || dExpDiv3 < -5.0) {
            strRet.Format(_T("% #0.*g  "),iSigDigits,d);
        } else {
            strRet.Format(_T("% #0.*g "),iSigDigits,dSignificand);
            int iExpDiv3 = (int)dExpDiv3;
            if (iExpDiv3 > 0) strRet += szPrefixBig[iExpDiv3 - 1];
            if (iExpDiv3 < 0) strRet += szPrefixSml[-iExpDiv3 - 1];
            if (iExpDiv3 == 0) strRet += _T(" ");
        }
    }
    return strRet;
}

#endif // } _EMBEDED

double RoundToNearest(double d,double dResulution) {
    return _copysign(dResulution * floor(fabs(d) / dResulution + 0.5),d);
}

int RoundToNearestInt(double d) {
    return (int)(d + _copysign(0.5,d));
}

#pragma warning(disable:4035)   // no return value
int __stdcall RoundToNearestInt(int n,int d) {
    // see powerscan "Cool Integer Dividing" paper for details
    __asm {
        // sign extend n into edx:eax
            mov     eax,n
            cdq
        // do the intel style divide (eax gets q, edx gets r)
            idiv    d
        // get 2*abs(r) into ebx   
            mov     ebx,edx
            add     ebx,ebx
            jns     posr
            neg     ebx
posr:
        // get abs(d) into ecx
            mov     ecx,d
            test    ecx,ecx
            jns     posd
            neg     ecx
posd:
        // check for like or different signs in d and r
            xor     edx,d
            js      difsgn
        // signs are alike
            cmp     ebx,ecx     // 2*abs(r) >= abs(d)
            jl      outahere    // no? then we're done
            inc     eax         // yes? then bump quotient up
            jmp     outahere
difsgn: // signs are different
            cmp     ebx,ecx     // 2*abs(r) > abs(d)
            jle     outahere    // no? then we're done
            dec     eax         // yes? then bump quotient down
outahere:
    }
}
#pragma warning(default:4035)

TNumericExeceptionsEnable::TNumericExeceptionsEnable(bool bEnable) {
    // check for any pending exceptions
    _asm { FWAIT }
	// get current exception mask
	npuOriginal = _control87(0,0);
	// clear any pending exceptions in case somebody down
	// the line depends on them not being there
    _clear87();
    if (bEnable) {
	    // enable all numeric exceptions
        _control87(~(_EM_INVALID | _EM_DENORMAL | _EM_ZERODIVIDE |
                     _EM_OVERFLOW | _EM_UNDERFLOW),_MCW_EM);
    } else {
	    // disable all numeric exceptions
        _control87(_EM_INVALID | _EM_DENORMAL | _EM_ZERODIVIDE |
                   _EM_OVERFLOW | _EM_UNDERFLOW | _EM_INEXACT,_MCW_EM);
    }
}
TNumericExeceptionsEnable::~TNumericExeceptionsEnable() {
    _clear87();
	_control87(npuOriginal,_MCW_EM);
}

void __AnyFunctionCall() {}   // support for echem try definition (see EchemPackageAPI.h)

void LineFitForEvenlySpacedPoints(double *pdSlope,double *pdIntercept,
                                  const double *pdValues,int iNumPoints,const double* pdErrors,
                                  double* pdSlopeError,double* pdInterceptError,double* pdChiSquare) {
    double dS,dSx,dSy,dSxx,dSxy,dSyy;
    dS = dSx = dSy = dSxx = dSxy = dSyy = 0.0;
    for (int i = 0; i < iNumPoints; i++) {
        double dErrSqRecip = pdErrors ? (1.0 / pdErrors[i] / pdErrors[i]) : 1.0;
        dS += dErrSqRecip;
        dSx += dErrSqRecip * double(i);
        dSy += dErrSqRecip * pdValues[i];
        dSxx += dErrSqRecip * double(i) * double(i);
        dSxy += dErrSqRecip * double(i) * pdValues[i];
        if (pdChiSquare) dSyy += dErrSqRecip * pdValues[i] * pdValues[i];
    }
    double dDel = dS*dSxx - dSx*dSx;
    double dSlope = (pdSlope || pdChiSquare) ? ((dS*dSxy - dSx*dSy) / dDel) : 0;
    double dIntercept = (pdIntercept || pdChiSquare) ? ((dSxx*dSy - dSx*dSxy) / dDel) : 0;
    if (pdSlope) *pdSlope = dSlope;
    if (pdIntercept) *pdIntercept = dIntercept;
    if (pdSlopeError) *pdSlopeError = sqrt(dSxx/dDel);
    if (pdInterceptError) *pdInterceptError = sqrt(dS/dDel);
    if (pdChiSquare) *pdChiSquare = dSyy + dSlope*dSlope*dSxx + double(iNumPoints)*dIntercept*dIntercept 
                                        - 2.0*dSlope*dSxy - 2.0*dIntercept*dSy + 2.0*dSlope*dIntercept*dSx;
}

#ifndef _EMBEDDED // {
// <EL9>+
// Support for converting floating point numbers (floats or doubles) between US
// English notation and other locales. US English uses the '.' for decimals in
// floting point numbers and other locales may use anything (frequently ',').
// Since these functions all convert strings to strings we don't care if the number
// is a float or double. These functions only work with simple numeric values,
// not currency nor numbers that use group seperators (i.e. 1,000.00).
static char cLocalDecimal = '\0';   // char currently used for decimal by scanf() and sprintf()

// This function determines the local decimal character. No action is taken if we
// already know what the local decimal character is.
static void CheckLocalDecimal(void) {
    char szTemp[8];
    int nIdx;

    if(cLocalDecimal == '\0') {     // if local decimal char unknown
        sprintf(szTemp, "%.1f", 1.0);
        for(nIdx = 0; szTemp[nIdx] != '\0'; nIdx++) {
            if(szTemp[nIdx] == '1') {
                cLocalDecimal = szTemp[nIdx+1];
                break;
            }
        }
    }
}

// resets the local decimal char point. Use if someone changes the locale.
void LocalFloatResetLocale(void) {
    cLocalDecimal = '\0';
}

// converts a NULL terminated narrow character string representation of a floating
// point number (without group separators) from US locale to current locale.
void USFloatToLocal(char *szFloatString) {
    if(cLocalDecimal != '.') {          // nothing to do if local decimal is US decimal
        CheckLocalDecimal();
        if(cLocalDecimal != '\0') {
            int nIdx;
            for(nIdx = 0; szFloatString[nIdx] != '\0'; nIdx++) {
                if(szFloatString[nIdx] == '.') szFloatString[nIdx] = cLocalDecimal;
            }
        }
    }
}

// converts a NULL terminated narrow character string representation of a floating
// point number (without group separators) from current locale to US locale.
void LocalFloatToUS(char *szFloatString) {
    if(cLocalDecimal != '.') {          // nothing to do if local decimal is US decimal
        CheckLocalDecimal();
        if(cLocalDecimal != '\0') {
            int nIdx;
            for(nIdx = 0; szFloatString[nIdx] != '\0'; nIdx++) {
                if(szFloatString[nIdx] == cLocalDecimal) szFloatString[nIdx] = '.';
            }
        }
    }
}

WORD FindMaxWord(WORD* pw, int count)
{
	WORD wVar = 0x0000; //Min val of WORD
	for(int i = 0; i < count; i++){
		if(wVar < pw[i]){
			wVar = pw[i];
		}
	}
	return wVar;	
}

//This function will find the min WORD in a array of WORD
//All comparisons are unsigned compare
WORD FindMinWord(WORD* pw, int count)
{
	WORD wVar = 0xFFFF; //Max of WORD
	for(int i = 0; i < count; i++){
		if(wVar > pw[i]){
			wVar = pw[i];
		}
	}
	return wVar;	
}

// <EL9>-

#endif // } not _EMBEDDED
