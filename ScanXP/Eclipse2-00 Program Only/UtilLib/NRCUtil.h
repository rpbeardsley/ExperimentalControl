#pragma once

/////////////////////////////////////////////////////////////
// symbols defined in NRC routines
//
//
#include <math.h>

namespace nsNRC
{

const int NR_END = 1;		//from numerical recipes
//precision from NRC. 
const double EPS = 3.0e-7;
//floating point minimum, not for double
const double FPMIN = 1.0e-30;
//exp(85) gives upper limit for floating point values
const double dMaxExpArg = 85.19;
//max min together
const double dMaxMinExpValue = 1.0e+37;
#define  MATHPI  3.141592653589793
#define  PISQRT  sqrt(MATHPI)
const   int ITMAX = 500;

static double sqrarg;
#define SQR(a) ((sqrarg=(a)) == 0.0 ? 0.0 : sqrarg*sqrarg)

inline  double fMyExp(double x) {
	//to prevent overflow or underflow
	if ( x >= dMaxExpArg ) return		 dMaxMinExpValue;
	else if ( x <= -dMaxExpArg ) return  1.0/dMaxMinExpValue;
	else return exp(x);
}

};








