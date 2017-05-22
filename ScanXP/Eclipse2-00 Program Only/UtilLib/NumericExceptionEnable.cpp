
#include "NumericExceptionEnable.h"
#include <math.h>
#include <float.h>

#pragma warning(default:4035)

CNumericExceptionsEnable::CNumericExceptionsEnable(bool bEnable) {
    // check for any pending exceptions
    _asm { FWAIT }
	// get current exception mask
	m_npuOriginal = _control87(0,0);
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
CNumericExceptionsEnable::~CNumericExceptionsEnable() {
    _clear87();
	_control87(m_npuOriginal,_MCW_EM);
}
