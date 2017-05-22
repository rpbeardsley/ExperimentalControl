
#include "stdafx.h"
#include "Complex.h"
#include <math.h>

TComplex Ln(const TComplex& c) {
    double dRadius = c.GetRadius();
    double dAngle = c.GetAngle();
    return TComplex(log(dRadius),dAngle);
}

TComplex Exp(const TComplex& c) {
    return exp(c.GetReal()) * Uoo(c.GetImag());
}

TComplex Pow(const TComplex& cMantissa,double dPower) {
    return Exp(Ln(cMantissa)*dPower);
}