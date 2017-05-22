
#include "stdafx.h"
#include "spectime.h"


BOOL CSpecTime::m_bTimeUnitsReady = FALSE;
CVector<double> CSpecTime::m_dFactors;

///////////////////////////////////////////////////
//CSpecTime class



CSpecTime::CSpecTime()
{
	m_eTimeUnits = TIME_UNITS_SEC;

	Init();

}

CSpecTime::CSpecTime(double dTime,eTIME_UNITS eUnits)
{
	CValues value(dTime,0);
	m_Values = (value);
	m_eTimeUnits = eUnits;

	Init();
}

CSpecTime::CSpecTime(CValues time,eTIME_UNITS eUnits)
{
	m_Values = time;
	m_eTimeUnits = eUnits;

	Init();	
}

void CSpecTime::Init()
{
	m_eUnitsType = UNITS_TYPE_TIME;

	PrepareConversions();

}

void CSpecTime::CopyMembers(const CSpecTime& rhs)
{
	m_eTimeUnits = rhs.m_eTimeUnits;
}

CSpecTime::CSpecTime(const CSpecTime& rhs)
: 	CMetric(rhs)
{
	CopyMembers(rhs);
}

CSpecTime& CSpecTime::operator = ( const CSpecTime& rhs ) 
{
	if ( this != &rhs ) {
		// 
		CopyMembers(rhs);
		// do  base assignment here
		CMetric::operator = (rhs);
	}
	return *this;
}

void CSpecTime::SetToSeconds()
{
	double d = ConvertUnits(TIME_UNITS_SEC,m_eTimeUnits);

	if ( d > 0.0 ) {

		m_Values *= d;

		m_eTimeUnits = TIME_UNITS_SEC;
	}
}

void CSpecTime::SetToMinutes()
{
	double d = ConvertUnits(TIME_UNITS_MIN,m_eTimeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eTimeUnits = TIME_UNITS_MIN;
	}

}

void CSpecTime::SetToHours()
{
	double d = ConvertUnits(TIME_UNITS_HR,m_eTimeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eTimeUnits = TIME_UNITS_HR;
	}

}

void CSpecTime::SetToDays()
{
	double d = ConvertUnits(TIME_UNITS_DAY,m_eTimeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eTimeUnits = TIME_UNITS_DAY;
	}
}


void CSpecTime::SetToYears()
{
	double d = ConvertUnits(TIME_UNITS_YEAR,m_eTimeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eTimeUnits = TIME_UNITS_YEAR;
	}

}

void CSpecTime::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);

	//the sequence is to convert from sec to min, sec to hr, etc.
	//"the "direction" of conversion is important here in how
	//to apply these numbers, that is, the conversion factor
	//should be * or / in math operation.
	m_dFactors[0] = 1.0;						// so-called standard units
	m_dFactors[1] = 60.0;						// note 1 minutes = 60 sec.
	m_dFactors[2] = 3600.0;						// hour
	m_dFactors[3] = 86400.0;					// day
	m_dFactors[4] = 31557600.0;					// 366.25 days


}


BOOL CSpecTime::PrepareConversions()
{
	/////////////////////////////////////////////////////////////////////////
	//
	//	the check:
	//
	//		m_dFactors.Size() == 0 
	//
	//	is added due to this: In CSpecRegion, there were three CSepcTime static
	//  ojbect. They were initialized first, m_bTimeUnitsReady was then set to 1.
	//	However, it looks to me that although the resize() function was called,
	//	the vector m_dFactors couldn't keep it's size - the array shrink to zero
	//  size after the program initialized all the globals. Then, when it was time
	//  for analysis, if we didn't check the size, the ended up with an empty 
	//  conversion factor vector !
	//
	//  This may make sense since we grow the array while only global objects are
	//  initialized or "allow to exist" ( my understanding ), so the program will 
	//  destroy the objects allocated (it did set the size to zero after doing that !)
	//
	//
	///////////////////////////////////////////////////////////////////////////////
	//

	if ( m_bTimeUnitsReady == FALSE || m_dFactors.Size() == 0 )
	{
		FillConversionFactors();

		m_bTimeUnitsReady = TRUE;
	}

	DeclareCanConvert();
	//
	return TRUE;
}


double CSpecTime::GetTimeDbl() const
{
	return m_Values.GetDblValue();
}

CValues CSpecTime::GetTime() const
{
	return m_Values;
}

const CVector<double>*	CSpecTime::GetConversionFactors() const
{
	return &m_dFactors;
}
