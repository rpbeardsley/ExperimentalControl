#pragma once

#include <math.h>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
//	CUnitsDimension is a template class for tracking the dimension of units. It's based on the fact that all 
//	dimemsions are combination of expoents of either mass, length or time (dimension M, L or  T). To get the dimension 
//	for velocity, eg, we have L/T, and we can write the dimension as ( 0,1,-1). 
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

namespace nsUnits {

template <int M, int L, int T >
class Units {

	
public:
	Units() : m_dValue(10.0) { }

	Units& operator = ( const Units<M,L,T> & rhs ) { return *this;}	
	friend Units<M,L,T> operator + ( Units<M,L,T>, Units<M,L,T> )
	{
		Units<M,L,T> units;
		return units;
	};
	friend Units<M,L,T> operator - ( Units<M,L,T>, Units<M,L,T> )
	{
		Units<M,L,T> units;
		return units;
	};

//	template <int M1, int L1, int T1, int M2, int L2, int  T2>
//	friend	Units<M1+M2,L1+L2,T1+T2> operator * (  Units<M1,L1,T1>, Units<M2,L2,T2> );
//	{
		// 
//		Units<<M1+M2,L1+L2,T1+T2> units;
//		return units;
//	};

	template <int M1, int L1, int T1, int M2, int L2, int  T2>
	friend	Units<M1+M2,L1+L2,T1+T2> operator * (   Units<M1,L1,T1>, Units<M2,L2,T2> ) ;

private:
		double m_dValue;
};

typedef Units<1,0,0> TMass;
typedef Units<0,1,0> TLength;
typedef Units<0,2,0> TArea;
typedef Units<0,0,1> TTime;
typedef Units<0,1,1> TVelocity;
typedef Units<0,1,2> TAcc;
typedef Units<0,2,1> tFlux;
typedef Units<1,0,1> tMassFlow;

//	{
//		// 
//		Units<<M1+M2,L1+L2,T1+T2> units;
//		return units;
//	};

	template <int M, int L, int T>
		Units<2*M,2*L,2*T> operator * (   Units<M,L,T>, Units<M,L,T> ) ;
//	{
//		// 
///		Units<2*M,2*L,2*T> units;
//		return units;
//	};

	template <int M1, int L1, int T1, int M2, int L2, int  T2>
		Units<M1-M2,L1-L2,T1-T2> operator / (   Units<M1,L1,T1>, Units<M2,L2,T2> ) 
	{
		// 
		Units<<M1-M2,L1-L2,T1-T2> units;
		return units;
	};

};

using namespace nsUnits;



namespace  nsCUnitsDimension {







template <float fM, float fL, float fT >
class CUnitsDimension {

public:

	CUnitsDimension() {};
	virtual ~CUnitsDimension() { };
	//
	// assignment
	//
	CUnitsDimension<fM,fL,fT>&
		operator = (const CUnitsDimension<fM, fL, fT>& rhs) {
		// This operator is for sytax checking and the return value is irrelevant
		// since we just try to ensure both sides have the dimensions
		return *this;
	}
	//
	// copy ctor
	//
	CUnitsDimension(const CUnitsDimension<fM, fL, fT>& rhs) {}
	//
	// Is the quantity a scaler
	//
	bool IsDimensionLess() const { 
		return ( abs( fM ) < eps  &&  abs (fL) < eps  && abs(fT) < eps );
	}
	//
	// Assert 
	//
	void AssertIsScaler() {
		if ( !IsDimensionLess() ) ::MessageBox(::GetDesktopWindow(),"The quantity is NOT a scaler value");
	}

	CUnitsDimension<fM,fL,fT>
	friend operator + (CUnitsDimension<fM,fL,fT>,  CUnitsDimension<fM, fL, fT> ) {
		CUnitsDimension<fM, fL, fT> dummy; return dummy; 
	}

//	template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
//		friend CUnitsDimension<fM1+fM2,fL1+fL2,fT1+fT2>
//		operator * ( const CUnitsDimension<fM1, fL1, fT1>&, const CUnitsDimension<fM2, fL2, fT2> &) { }

	// to prevent round-off errors
	static double eps;


};		// end of class


template <float fM, float fL, float fT >
double CUnitsDimension<fM,fL,fT>::  eps = 0.001;




//
// operators defined as non-member functions 
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//	The following declaration lead to an INTERNAL COMPILER ERROR !!! Why ?
//
//	template <float fM1, float fL1, float fT1>
//	CUnitsDimension<fM1,fL1,fT1>
//		operator + ( CUnitsDimension<fM1, fL1, fT1>);
//
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//template <float fM1, float fL1, float fT1> 
//	operator + (CUnitsDimension<fM1,fL1,fT1>,  CUnitsDimension<fM1, fL1, fT1> );

//template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
//	operator + ( const CUnitsDimension<fM1, fL1, fT1>&, const CUnitsDimension<fM2, fL2, fT2> &);

template <float fM1, float fL1, float fT1> 
	operator - (CUnitsDimension<fM1,fL1,fT1>,  CUnitsDimension<fM1, fL1, fT1> );

//
// The divide operator
//

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	CUnitsDimension<fM1 - fM2,fL1 - fL2,fT1 - fT2>
		operator / ( const CUnitsDimension<fM1, fL1, fT1>&, const CUnitsDimension<fM2, fL2, fT2> &);
//
// The inversion operator
//
//template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
//	CUnitsDimension<fM1,fL1,fT1>
//	operator / ( const nsCValues::CValues &, const CUnitsDimension<fM2, fL2, fT2> &);

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	CUnitsDimension<fM1,fL1,fT1>
	operator / ( double d, const CUnitsDimension<fM2, fL2, fT2> &);


//
// comparison operator
//
template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	bool __stdcall operator== ( const CUnitsDimension<fM1, fL1, fT1>& , const  CUnitsDimension<fM2, fL2, fT2>&);

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
	bool __stdcall operator != ( const CUnitsDimension<fM1, fL1, fT1>& , const  CUnitsDimension<fM2, fL2, fT2>&);

//
// sqrt operation
//
template <float fM, float fL, float fT >
CUnitsDimension<0.5 * fM,0.5 * fL/2, 0.5 * fT>
	sqrt(const CUnitsDimension<fM, fL, fT>& rhs);
			
//
// raised to the power of n
//
template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
CUnitsDimension<fM1, fL1, fT1>
pow( const CUnitsDimension<fM2, fL2, fT2>&, int n); 	

template <float fM1, float fL1, float fT1,float fM2, float fL2, float fT2>
void	AssertSameDims( const CUnitsDimension<fM1, fL1, fT1>& , const  CUnitsDimension<fM2, fL2, fT2>&);





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Type defs for common dimensions
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
typedef CUnitsDimension<0.0,	0.0,	0.0>	CDimScaler;
typedef CUnitsDimension<1.0,	0.0,	0.0>	CDimMass;
typedef CUnitsDimension<0.0,	1.0,	0.0>	CDimLength;
typedef CUnitsDimension<0.0,	0.0,	1.0>	CDimTime;
typedef CUnitsDimension<0.0,	0.0,	-1.0>	CDimCountRate;
typedef CUnitsDimension<0.0,	0.0,	-1.0>	CDimActivity;
typedef CUnitsDimension<0.0,	2.0,	0.0>	CDimArea;





};		// end of namespace

using namespace nsCUnitsDimension;




