#include "stdafx.h"

#include "Complex.h"
#include <math.h>
#include <float.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//
// ctors
//
TComplex::TComplex() {
}

TComplex::TComplex(bool bInit) {
	if (bInit) dRe = dIm = 0.0;
}

TComplex::TComplex(double AdRe) {
    dRe = AdRe;
    dIm = 0.0;
}

TComplex::TComplex(double AdRe,double AdIm) {
	dRe = AdRe;
	dIm = AdIm;
}

//
// Alternate polar initialization function
//
void TComplex::FromPolar(double dRadius,double dAngle) {
    dRe = dRadius * cos(dAngle);
    dIm = dRadius * sin(dAngle);
}

//
// misc operators
//
//TComplex& TComplex::operator=(const TComplex& cFrom) {
//    dRe = cFrom.dRe;
//    dIm = cFrom.dIm;
//    return *this;
//}

TComplex& TComplex::operator=(double d) {
    dRe = d;
    dIm = 0.0;
    return *this;
}

TComplex& TComplex::operator+=(const TComplex& cFrom) {
    dRe += cFrom.dRe;
    dIm += cFrom.dIm;
    return *this;
}

TComplex& TComplex::operator-=(const TComplex& cFrom) {
    dRe -= cFrom.dRe;
    dIm -= cFrom.dIm;
    return *this;
}

TComplex& TComplex::operator*=(const TComplex& cFrom) {
//    FromPolar(GetRadius()*cFrom.GetRadius(),GetAngle()+cFrom.GetAngle());
    *this = *this * cFrom;
    return *this;
}

TComplex& TComplex::operator/=(const TComplex& cFrom) {
    *this = *this / cFrom;
//    FromPolar(GetRadius()/cFrom.GetRadius(),GetAngle()-cFrom.GetAngle());
    return *this;
}

TComplex& TComplex::operator*=(double d) {
    dRe *= d;
    dIm *= d;
    return *this;
}

TComplex& TComplex::operator/=(double d) {
    dRe /= d;
    dIm /= d;
    return *this;
}

bool TComplex::operator==(const TComplex& c) const {
    return dRe == c.dRe && dIm == c.dIm;
}

//
// info extraction funtions
//
double TComplex::GetRadius() const {
    return _hypot(dRe,dIm);
}

double TComplex::GetRadius2() const {
    return dRe*dRe+dIm*dIm;
}

double TComplex::GetAngle() const {
    return atan2(dIm,dRe);
}

bool TComplex::IsFinite() const {
    return _finite(dIm) && _finite(dRe);
}
TComplex operator+(const TComplex& c1,const TComplex& c2) {
    return TComplex(c1.GetReal()+c2.GetReal(),c1.GetImag()+c2.GetImag());
}
TComplex operator-(const TComplex& c1,const TComplex& c2) {
    return TComplex(c1.GetReal()-c2.GetReal(),c1.GetImag()-c2.GetImag());
}
TComplex operator*(const TComplex& c1,const TComplex& c2) {
    return TComplex(c1.GetReal() * c2.GetReal() - c1.GetImag() * c2.GetImag(),
                    c1.GetImag() * c2.GetReal() + c1.GetReal() * c2.GetImag());
}
TComplex operator/(const TComplex& c1,const TComplex& c2) {
    TComplex c(c1.GetReal() * c2.GetReal() + c1.GetImag() * c2.GetImag(),
               c1.GetImag() * c2.GetReal() - c1.GetReal() * c2.GetImag());
    c /= c2.GetRadius2();
    return c;
}
TComplex operator-(const TComplex& c1) {
    return TComplex(-c1.GetReal(),-c1.GetImag());
}
double Dot(const TComplex& c1,const TComplex& c2) {
    return c1.GetX() * c2.GetX() + c1.GetY() * c2.GetY();
}
TComplex Conj(const TComplex& c) {
    return TComplex(c.GetReal(),-c.GetImag());
}
TComplex Heading(const TComplex& c) {
    return c/c.GetRadius();
}
TComplex Uoo(double dAngle) {
    TComplex cRet;
    cRet.FromPolar(1.0,dAngle);
    return cRet;
}
