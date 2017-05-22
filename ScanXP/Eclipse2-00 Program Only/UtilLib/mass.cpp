// Mass.cpp : implementation file
//

#include "stdafx.h"
#include "Mass.h"

/////////////////////////////////////////////////////////////////////////////
// CMass


CVector<double> CMass::m_dFactors;
vector<CString> CMass::m_vVolumeUnitsString;
BOOL CMass::m_bMassUnitsReady = FALSE;

CMass::CMass()
{
	m_eUnitsType = UNITS_TYPE_MASS;
	m_eMassUnits = MASS_UNITS_g;

	PrepareConversions();

}

void CMass::CopyMembers(const CMass& rhs)
{
	m_eMassUnits = rhs.m_eMassUnits;
}

CMass::CMass(const CValues& value, eMASS_UNITS eUnits)
{
	//prefered way to construct object
	m_Values			= value;
	m_eMassUnits	= eUnits;

	PrepareConversions();

}

CMass::CMass(const CMass& rhs)
: 	CMetric(rhs)
{
	CopyMembers(rhs);
}

CMass& CMass::operator = ( const CMass& rhs )
{
	if ( this != &rhs ) {
		//do assignement here
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}

void CMass::FillConversionFactors()
{
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);

	m_dFactors[0]	= 1.0;			//
	m_dFactors[1]	= 1000.0;
	m_dFactors[2]	= 0.001;
	m_dFactors[3]	= 0.000001;


}

BOOL CMass::PrepareConversions()
{
	if ( this->m_bMassUnitsReady == FALSE || m_dFactors.Size() == 0)
	{

		FillConversionFactors();
		int nSize = static_cast<int>(MASS_UNITS_LAST);

		m_vVolumeUnitsString.resize(nSize);

		m_vVolumeUnitsString[static_cast<int>(MASS_UNITS_g)] = "g";
		m_vVolumeUnitsString[static_cast<int>(MASS_UNITS_Kg)] = ("Kg");
		m_vVolumeUnitsString[static_cast<int>(MASS_UNITS_mg)] = ("mg");
		m_vVolumeUnitsString[static_cast<int>(MASS_UNITS_ug)] = ("ug");
		

		this->m_bMassUnitsReady = TRUE;
		//
	}

	DeclareCanConvert();

	return TRUE;
}

void CMass::SetTo_g()
{
	double d = ConvertUnits(MASS_UNITS_g,m_eMassUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eMassUnits = MASS_UNITS_g;
	}
}

void CMass::SetTo_Kg()
{
	double d = ConvertUnits(MASS_UNITS_Kg,m_eMassUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eMassUnits = MASS_UNITS_Kg;
	}

}

void CMass::SetTo_mg()
{
	double d = ConvertUnits(MASS_UNITS_mg,m_eMassUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eMassUnits = MASS_UNITS_mg;
	}

}
void CMass::SetTo_ug()
{
	double d = ConvertUnits(MASS_UNITS_ug,m_eMassUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eMassUnits = MASS_UNITS_ug;
	}

}

CString CMass::GetUnitsString(eMASS_UNITS eUnits) const
{
	if ( eUnits > MASS_UNITS_UNDEFINED && eUnits < MASS_UNITS_LAST )
	{
		int nsize = m_vVolumeUnitsString.size();

		int iIndex = static_cast<int>(eUnits);

		if ( iIndex >= 0 && iIndex < nsize )
		{
			return this->m_vVolumeUnitsString[iIndex];
		}
	}

	return CString("");
}

CString CMass::GetCurrentUnitsString() const
{
	return GetUnitsString(this->m_eMassUnits);
}

const CVector<double>*	CMass::GetConversionFactors() const
{
	return &m_dFactors;
}
