#include "stdafx.h"
#include "DimTemplate.h"

// CDimTemplate.cpp
//
//	This file implements some non-member function of the class
//	
static const double  EPS = 0.001;

template <float fM1, float fL1, float fT1> 
	operator - (CUnitsDimension<fM1,fL1,fT1>,  CUnitsDimension<fM1, fL1, fT1> )
{

}

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
void	AssertSameDims( const CUnitsDimension<fM1, fL1, fT1>& rhs , const CUnitsDimension<fM2, fL2, fT2>&)
{
}


template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	CUnitsDimension<fM1 - fM2,fL1 - fL2,fT1 - fT2>
	nsCUnitsDimension::operator / ( const CUnitsDimension<fM1, fL1, fT1>&, const CUnitsDimension<fM2, fL2, fT2> &)
{
	// Watch for round-off errors in cases like: radius = sqrt(Area/3.14159), where the dimension for
	// length might not end up to 1.0000 exact?

}

//template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
//	CUnitsDimension<fM1,fL1,fT1>
//	nsCUnitsDimension::operator / ( const nsCValues::CValues &, const CUnitsDimension<fM2, fL2, fT2> &)
//{
//	// operations such as frenquency = 1.0 / Period
//	if ( fM2 == 0 ) fM1 = 0.0
//		else fM1 = 1.0/fM2;
//	if ( fL2 == 0 ) fL1 = 0.0
//		else fL1 = 1.0/fL2;
//	if ( fT2 == 0 ) fT1 = 0.0
//		else fT1 = 1.0/fT2;
//}//

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	CUnitsDimension<fM1,fL1,fT1>
	nsCUnitsDimension::operator / ( double d, const CUnitsDimension<fM2, fL2, fT2> &)
{
	// operations such as frenquency = 1.0 / Period
	if ( fM2 == 0 ) fM1 = 0.0
		else fM1 = 1.0/fM2;
	if ( fL2 == 0 ) fL1 = 0.0
		else fL1 = 1.0/fL2;
	if ( fT2 == 0 ) fT1 = 0.0
		else fT1 = 1.0/fT2;
}

	template <int M1, int L1, int T1, int M2, int L2, int  T2>
		Units<M1+M2,L1+L2,T1+T2> nsUnits::operator * (   Units<M1,L1,T1>, Units<M2,L2,T2> ) 
	{
		// 
		Units<<M1+M2,L1+L2,T1+T2> units;
		return units;
	};

//	template <int M, int L, int T>
//		Units<2*M,2*L,2*T> nsUnits::operator * (   Units<M,L,T>, Units<M,L,T> ) 
//	{
//		// 
//		Units<2*M,2*L,2*T> units;
//		return units;
///	};

/*
template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	CUnitsDimension<fM1+fM2,fL1+fL2,fT1+fT2>
		nsCUnitsDimension::operator * ( const CUnitsDimension<fM1, fL1, fT1>&, const CUnitsDimension<fM2, fL2, fT2> &)
{
	// Watch for round-off errors in cases like: radius = sqrt(Area/3.14159), where the dimension for
	// length might not end up to 1.0000 exact?

}

  */


template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	bool __stdcall nsCUnitsDimension::operator== ( const CUnitsDimension<fM1, fL1, fT1>& , const  CUnitsDimension<fM2, fL2, fT2>&)
{
	return ( abs(fM1 - fM2) < EPS && abs(fL1 - dL2 ) < EPS && abs(fT1 - fT2) < EPS ) ); 
}

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	bool __stdcall nsCUnitsDimension::operator != ( const CUnitsDimension<fM1, fL1, fT1>& , const  CUnitsDimension<fM2, fL2, fT2>&)
{
	return !nsCUnitsDimension::operator == ( const CUnitsDimension<fM1, fL1, fT1>& , const  CUnitsDimension<fM2, fL2, fT2>&);
}

//
// sqrt operation
//
template <float fM, float fL, float fT >
CUnitsDimension<0.5 * fM,0.5 * fL/2, 0.5 * fT>
nsCUnitsDimension::sqrt(const CUnitsDimension<fM, fL, fT>& rhs)
{

}
		
//
// raised to the power of n
//
template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
CUnitsDimension<fM1, fL1, fT1>
nsCUnitsDimension::pow( const CUnitsDimension<fM2, fL2, fT2>&, int n)
{
	fM1 = fM2 * n; 
	fL1 = fL2 * n; 
	fT1 = fT2 * n; 
}
	
