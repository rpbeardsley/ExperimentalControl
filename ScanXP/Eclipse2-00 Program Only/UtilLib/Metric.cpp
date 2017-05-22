#include "stdafx.h"
#include "Metric.h"
#include "AnalysisExceptionBase.h"

CMetric::CMetric()
:	m_bCanConvert(false),
	m_eUnitsType(UNITS_TYPE_UNDEFINED)
{

}

CMetric::CMetric
( 
 const CMetric & rhs
)
:	m_Values(rhs.m_Values),
	m_bCanConvert(rhs.m_bCanConvert),
	m_eUnitsType(rhs.m_eUnitsType)
	
{

}

CMetric & CMetric::operator=
( 
	const CMetric & rhs
)
{
	if ( this != &rhs )
	{	
		CopyMembers(rhs);
	}

	return *this;
}

void	CMetric::CopyMembers(const CMetric& rhs)
{
	m_Values				= rhs.m_Values;
	m_bCanConvert			= rhs.m_bCanConvert;
	m_eUnitsType			= rhs.m_eUnitsType;
}

CMetric::~CMetric()
{}

void CMetric::SetValues
(
	const CValues & values
)
{
	m_Values = values;
}

CValues & CMetric::GetValues()
{
	return m_Values;
}

const CValues & CMetric::GetValues() const
{
	return m_Values;
}


bool __stdcall nsCMetric::operator==
( 
	const CMetric & a, 
	const CMetric & b
)
{
	if( a.m_Values				== b.m_Values &&
		a.m_bCanConvert			== b.m_bCanConvert &&
		a.m_eUnitsType				== b.m_eUnitsType )
		return true;
	else
		return false;
}

bool __stdcall nsCMetric::operator!=
( 
	const CMetric & a, 
	const CMetric & b
)
{
	return ( !( a == b ));
}

const double CMetric::ConvertUnits(UINT nNewUnitsIndex, UINT nOldUnitsIndex)
{
	//it's the derived classes responsibility to ensure
	//that the two indices are in the range
	//Only derived class can overide m_bCanConvert 

	// when this is called, we have to be ready !
	const CVector<double>* pConversionFactors = this->GetConversionFactors();

	if ( !m_bCanConvert && pConversionFactors == 0) 
	{
		throw new CAnalysisExceptionBase("Failed to access units conversion factors. ");
	}

	const UINT nHigh = pConversionFactors->HighBounds();
	const UINT nLow  = pConversionFactors->LowBounds();
	//////////////////////////////////////////////////////////////////////////
	// Since all units index are enumerators, default to have low index
	// to zero. All derived classes should do the same
	//
	//
	assert(nLow == 0 );

	if (  nNewUnitsIndex <= nHigh		&&  
		  nNewUnitsIndex >= nLow		&& 
		  nOldUnitsIndex <= nHigh		&&  
		  nOldUnitsIndex >= nLow  ) 
	{
		if ( nNewUnitsIndex == nOldUnitsIndex ) return 1.0;
		else
		{
			//pay attention to the definition of the array m_dFactors
			//we asssume the return factor is the factor used in
			//multiplication to get the value in the new units.
			//the first element is the so called "standard unit"
			double d = pConversionFactors->At(nOldUnitsIndex) / pConversionFactors->At(nNewUnitsIndex);
			return  d;
		}
	}
	else
	{
		CString cs;
		cs.Format("Invalid index to the units. Old units index = %d, new units index = %d, and maximum value of index allowed = %d ", nOldUnitsIndex, nNewUnitsIndex, nHigh);
		throw new CAnalysisExceptionBase(cs);
	}
	
	return 0.0;	
}


CMetric::operator CValues()
{
	CValues& ReferenceToValues = m_Values;
	return ReferenceToValues;
}
