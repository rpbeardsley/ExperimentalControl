#ifndef __INC__METRIC_H
#define __INC__METRIC_H

#include "stdafx.h"
#include "Values.h"
#include "vector.h"

namespace nsCMetric
{
	/////////////////////////////////////////////////////////////////////////////////
	//
	//	This class for any type of objects which care to have a value, an
	//	associated uncertainty and an units with it. Examples of such quanties includes
	//	activities, etc. 
	//
	/////////////////////////////////////////////////////////////////////////////////

class CMetric
{
public:

	enum eUNITS_TYPE {
		UNITS_TYPE_UNDEFINED,
		UNITS_TYPE_ACTIVITY,
		UNITS_TYPE_MASS,
		UNITS_TYPE_VOLUME,
		UNITS_TYPE_TIME,
		UNITS_TYPE_PRESSURE,
		UNITS_TYPE_COUNTRATE,
		UNITS_TYPE_Current,
		UNITS_TYPE_Potential,
		UNITS_TYPE_RESISTOR,
		UNITS_TYPE_PR,
		UNITS_TYPE_CR,
		UNITS_TYPE_LAST
	};

	CMetric();
	CMetric( const CMetric & );
	virtual ~CMetric();

	CMetric & operator=( const CMetric & );

	void				SetValues( const CValues & );
	CValues &			GetValues();
	//read only access
	const CValues &		GetValues() const;

	//use type conversion ooperator. It simplifies operations involving CMetric derived
	// quantities, such as Activity = CountRate/Efficiency
	operator CValues();

	friend bool __stdcall operator==( const CMetric &, const CMetric & );
	friend bool __stdcall operator!=( const CMetric &, const CMetric & );

protected:
	
	eUNITS_TYPE				m_eUnitsType;
	CValues					m_Values;
	bool					m_bCanConvert;

	///////////////////////////////////////////////////////////////////////////////
	//	
	//	We could put stuff below to the base class CUnits and then have			
	//  derived classes such as CActivityUnits, CMassUnits, etc. It sounds more 
	//  logical, but those derived classes cannot handle how to
	//  actually change the quantity given a new units since m_Values 
	//	is at this level.
	//
	///////////////////////////////////////////////////////////////////////////////
	//
	//for units conversions only. can only have meaningful implementation
	//in derived classes
	//
	//conversion between units of the same type, such as Time.

	//
	virtual const CVector<double>*	GetConversionFactors() const = 0;
	virtual void					FillConversionFactors() = 0;
	
	//This is an abstract index to some units which are to be defined
	//in the derived classes.

	const double					ConvertUnits(UINT nNewUnitsIndex, UINT nOldUnitsIndex);
	void							DeclareCanConvert(){ m_bCanConvert = true;}
	bool  							GetCanConvert(){ return m_bCanConvert;}

	
private:

	void							CopyMembers(const CMetric& rhs);


};

};	//End of namespace

using namespace nsCMetric;


#endif