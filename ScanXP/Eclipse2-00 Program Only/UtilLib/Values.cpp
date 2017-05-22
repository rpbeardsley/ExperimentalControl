#include "stdafx.h"
#include "math.h"
#include "Values.h"


using namespace nsCValues;

CValues::CValues (const double value, const double uncertainty)
: m_dValue(value), m_dUncertainty(uncertainty)
{}
 
CValues::CValues()
: m_dValue(0.0), m_dUncertainty(0.0)
{}

CValues::CValues ( const CValues & a )
:m_dValue( a.m_dValue ), m_dUncertainty( a.m_dUncertainty )
{}

// a plus sign won't change anything
CValues CValues::operator+()
{
	return *this;
}
//negate
CValues CValues::operator-()
{
	m_dValue = - m_dValue;
	m_dUncertainty = m_dUncertainty;
	return *this;	
}

//Definitions of compound-assignment operator member functions
CValues & CValues::operator+= (	const CValues & a )
{
	m_dValue += a.m_dValue;
	m_dUncertainty = AdditionUncertainty( m_dUncertainty, a.m_dUncertainty );
	return *this;
}

CValues & CValues::operator+= ( const double a )
{
	//Addition of a constant does not change the uncertainty 
	m_dValue += a;
	return *this;
}

CValues & CValues::operator-= ( const CValues & a )
{
	m_dValue -= a.m_dValue;
	m_dUncertainty = AdditionUncertainty( m_dUncertainty, a.m_dUncertainty );
	return *this;
}

CValues & CValues::operator-= (	const double a  )
{
	//Subtraction of a constant does not change the uncertainty 
	m_dValue -= a;
	return *this;
}

CValues & CValues::operator*= ( const double a )
{
	m_dValue *= a;
	m_dUncertainty *= fabs(a);
	return *this;
}

CValues & CValues::operator*= ( const CValues & a )
{
	//Make sure to calculate the value after the uncertainty
	m_dUncertainty = MultiplicationUncertainty( *this, a );
	m_dValue *= a.m_dValue;
	return *this;
}


CValues & CValues::operator/= ( const double a  )
{
	m_dValue /= a;
	m_dUncertainty = fabs(m_dValue / a);
	return *this;
}

CValues & CValues ::operator/= ( const CValues & a )
{
	//Make sure to calculate the value after the uncertainty
	m_dUncertainty = DivisionUncertainty( *this, a );
	m_dValue /= a.m_dValue;
	return *this;
}

CValues & CValues ::operator = (  const CValues & a )
{
	if ( this == &a )
		return *this;

	m_dValue = a.m_dValue;
	m_dUncertainty = a.m_dUncertainty;

	return *this;
}
	
//converts counts to CValue type
void CValues::CountingError( const double a)
{
	m_dValue = a;
	m_dUncertainty = ::sqrt(a);
}

CValues nsCValues::operator+ ( 	const CValues & a, 	const CValues & b)
{
	return CValues( a.m_dValue + b.m_dValue, 
		AdditionUncertainty( a.m_dUncertainty, b.m_dUncertainty ));
}

CValues nsCValues::operator+ ( 	const double a,	const CValues & b )
{
	return CValues( a + b.m_dValue, b.m_dUncertainty );
}

CValues nsCValues::operator+ ( 	const CValues & a, 	const double b )
{
	return CValues( a.m_dValue + b, a.m_dUncertainty );
}

CValues nsCValues::operator- (  const CValues & a, 	const CValues & b )
{
	return CValues( a.m_dValue - b.m_dValue, 
		AdditionUncertainty( a.m_dUncertainty, b.m_dUncertainty ));
}

CValues nsCValues::operator- ( 	const double a,	const CValues & b )
{
	return CValues( a - b.m_dValue, b.m_dUncertainty );
}

CValues nsCValues::operator- ( 	const CValues & a, 	const double b )
{
	return CValues( a.m_dValue - b, a.m_dUncertainty );
}

CValues nsCValues::operator* ( 	const CValues & a, 	const CValues & b )
{
	return CValues( a.m_dValue * b.m_dValue, MultiplicationUncertainty( a, b ));
}

CValues nsCValues::operator* ( 	const CValues & a, 	const double b )
{
	return CValues( a.m_dValue * b, fabs(a.m_dUncertainty * b) );
}

CValues nsCValues::operator* ( 	const double a, 	const CValues & b )
{
	return CValues( a * b.m_dValue, fabs(a * b.m_dUncertainty) );
}

CValues nsCValues::operator/ ( 	const CValues & a, 	const CValues & b )
{
	return CValues( a.m_dValue / b.m_dValue, DivisionUncertainty( a, b ));
}

CValues nsCValues::operator/ ( 	const double a, const CValues & b )
{
	double uncertainty = ( a / ( b.m_dValue * b.m_dValue )) * b.m_dUncertainty;
	return CValues( a / b.m_dValue, fabs(uncertainty) );
}

CValues nsCValues::operator/ ( 	const CValues & a, 	const double b )
{
	double uncertainty = a.m_dUncertainty / b;
	return CValues( a.m_dValue / b, fabs(uncertainty) );
}

bool __stdcall nsCValues::operator== (  const CValues & a,  const CValues & b )
{
	if (( a.m_dValue == b.m_dValue ) && ( a.m_dUncertainty == b.m_dUncertainty ))
		return true;
	else
		return false;
}

bool __stdcall nsCValues::operator!= (  const CValues & a,  const CValues & b )
{
	return !( a == b);
}

bool __stdcall nsCValues::operator< (  const CValues & a,  const CValues & b )
{
	if ( a.m_dValue < b.m_dValue ) 
		return true;
	else
		return false;
}

bool __stdcall nsCValues::operator> (  const CValues & a,  const CValues & b )
{
	return !( a < b);
}

//math.h function overrides
CValues nsCValues::pow (  const CValues & a,  const int n )
{
	double value = ::pow( a.m_dValue, n );
	double uncertainty = abs(n) * (::pow)( a.m_dValue, n - 1 ) * a.m_dUncertainty ;
	return CValues( value, uncertainty );
}

CValues nsCValues::exp (  const CValues & a )
{
	double value = ::exp( a.m_dValue );
	double uncertainty = value * a.m_dUncertainty;
	return CValues( value, uncertainty );
}

CValues nsCValues::log (const CValues & a )
{
	CValues results;
	if ( a.m_dValue > 0 )
	{
		double value = ::log( a.m_dValue );
		double uncertainty = a.m_dUncertainty / a.m_dValue;
		results =  CValues( value, uncertainty );
	}
	return results;
}

CValues nsCValues::sqrt (const CValues& a )
{
	CValues results;
	if ( a.m_dValue > 0.0 )
	{
		double value = ::sqrt(a.m_dValue);
		double uncertainty = 0.5*a.m_dUncertainty/value;
		results = CValues(value,uncertainty);
	}
	return results;
}

//private methods
double nsCValues::AdditionUncertainty (  const double a,  const double b  )
{
	return ( ::sqrt(( a * a ) + ( b * b ))) ;
}

double nsCValues::MultiplicationUncertainty (  const CValues & a,  	const CValues & b  )
{
	double theProductA = b.m_dValue * b.m_dValue * 
		a.m_dUncertainty * a.m_dUncertainty;
	double theProductB = a.m_dValue * a.m_dValue * 
		b.m_dUncertainty * b.m_dUncertainty;

	return ( ::sqrt( theProductA + theProductB ));
}

double nsCValues::DivisionUncertainty (  const CValues & a, const CValues & b )
{
	double theQuotient = 1 / ( b.m_dValue * b.m_dValue );
	double theProduct = (( a.m_dValue * a.m_dValue * b.m_dUncertainty * b.m_dUncertainty ) / ( b.m_dValue * b.m_dValue ));
	return ( ::sqrt( theQuotient * (( a.m_dUncertainty * a.m_dUncertainty ) + theProduct )));
}


