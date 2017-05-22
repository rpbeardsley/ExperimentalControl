#ifndef __INC_VALUES_H
#define __INC_VALUES_H
//
/////////////////////////////////////////////////////////////////////////
// This class is an abstraction of any quantities with a value and an
// uncertainty with it. It handles how to propogate errors in mathematical calculations
// involving typical operators, such as +, -, /, *, exp,sqrt and x^n. More can be added 
// as needed.
///////////////////////////////////////////////////////////////////////////
//
namespace nsCValues
{

class CValues
{
public:
	//constructors
	CValues ();
	CValues ( const double value, const double uncertainty);
	CValues( const CValues & a);
	virtual ~CValues () { };
	//value manipulations. Only getters. Setters could lead to
	//error  in uncertainty proporgation and should be avoided.
	double GetDblValue() const { return m_dValue;}				//the value part
	double GetDblUncertainty() const { return m_dUncertainty;}	//the uncertainty in the value
	
	//Binary Operator Functions:
	// "+" operator
	friend CValues operator+( const CValues &, const CValues & );
	friend CValues operator+( const double, const CValues & );
	friend CValues operator+( const CValues &, const double );

	// "-" operator
	friend CValues operator-( const CValues &, const CValues & );
	friend CValues operator-( const double, const CValues & );
	friend CValues operator-( const CValues &, const double );

	// "*" operator
	friend CValues operator*( const CValues &, const CValues & );
	friend CValues operator*( const double, const CValues & );
	friend CValues operator*( const CValues &, const double );

	// "/" operator
	friend CValues operator/( const CValues &, const CValues & );
	friend CValues operator/( const double, const CValues & );
	friend CValues operator/( const CValues &, const double );

	// comparison operator
	friend bool __stdcall operator==( const CValues &, const CValues & );
	friend bool __stdcall operator!=( const CValues &, const CValues & );
	friend bool __stdcall operator<( const CValues &, const CValues & );
	friend bool __stdcall operator>( const CValues &, const CValues & );

	//math.h funtions
	friend CValues pow( const CValues &, const int );
	friend CValues exp( const CValues & );
	friend CValues sqrt(const CValues & );
	friend CValues log( const CValues & );

	//assignment operator
	CValues & operator =( const CValues & );

	// compound assignment operators
	// "+="
	CValues & operator+=( const CValues & );
	CValues & operator+=( const double );

	// "-="
	CValues & operator-=( const CValues & );
	CValues & operator-=( const double );

	// "*="
	CValues & operator*=( const CValues & );
	CValues & operator*=( const double );

	// "/="
	CValues & operator/=( const CValues & );
	CValues & operator/=( const double );

	CValues operator+();
	CValues operator-();
	
	//converts counts to CValue type accroding to Poisson statistics
	void CountingError( const double );
	
	//Implementation. Don't even use protected access
private:
	
	double m_dValue;
	double m_dUncertainty;
	friend double AdditionUncertainty( const double, const double );
	friend double MultiplicationUncertainty( const CValues &, const CValues & );
	friend double DivisionUncertainty( const CValues &, const CValues & );
};

};

using namespace nsCValues;


#endif  //__INC_VALUES_H