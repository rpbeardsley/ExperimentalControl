// Volume.cpp : implementation file
//

#include "stdafx.h"
#include "Volume.h"

/////////////////////////////////////////////////////////////////////////////
// CVolume
CVector<double> CVolume::m_dFactors;
vector<CString> CVolume::m_vVolumeUnitsString;
BOOL CVolume::m_bVolumeUnitsReady = FALSE;




CVolume::CVolume()
{
	m_eUnitsType = UNITS_TYPE_VOLUME;
	m_eVolumeUnits = VOLUME_UNITS_l;
	PrepareConversions();
}

CVolume::CVolume(const CValues& value, eVOLUME_UNITS eUnits)
{
	//prefered way to construct object
	m_Values			= value;
	m_eVolumeUnits	= eUnits;
	PrepareConversions();
}


void CVolume::CopyMembers(const CVolume& rhs)
{
	//do assignement here
	m_eVolumeUnits = rhs.m_eVolumeUnits;
}

CVolume::CVolume(const CVolume& rhs)
: 	CMetric(rhs)
{
	CopyMembers(rhs);
}

CVolume& CVolume::operator = (const CVolume& rhs)
{
	if ( this != &rhs ) {
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}	

void CVolume::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);
	//
	m_dFactors[0]	= 1.0;				//
	m_dFactors[1]	= 0.001;
	m_dFactors[2]	= 0.000001;
	m_dFactors[3]	= 1000;
	m_dFactors[4]	= 0.001;
	m_dFactors[5]	= 28.32;
	m_dFactors[6]	= 0.01639;
	//Now we can convert units


}

void CVolume::SetTo_l()
{
	double d = ConvertUnits(VOLUME_UNITS_l,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_l;
	}
}
void CVolume::SetTo_ml()
{
	double d = ConvertUnits(VOLUME_UNITS_ml,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_ml;
	}
}

void CVolume::SetTo_ul()
{
	double d = ConvertUnits(VOLUME_UNITS_ul,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_ul;
	}
}

void CVolume::SetTo_m3()
{
	double d = ConvertUnits(VOLUME_UNITS_m3,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_m3;
	}
}

void CVolume::SetTo_cm3()
{
	double d = ConvertUnits(VOLUME_UNITS_cm3,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_cm3;
	}
}

void CVolume::SetTo_ft3()
{
	double d = ConvertUnits(VOLUME_UNITS_ft3,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_ft3;
	}
}

void CVolume::SetTo_in3()
{
	double d = ConvertUnits(VOLUME_UNITS_in3,m_eVolumeUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eVolumeUnits = VOLUME_UNITS_in3;
	}
}

BOOL CVolume::PrepareConversions()
{
	if ( m_bVolumeUnitsReady == FALSE || m_dFactors.Size() == 0)
	{

		FillConversionFactors();
		// vector is zero based. So don't subtract 1 

		int nSize = static_cast<int>(VOLUME_UNITS_LAST);

		m_vVolumeUnitsString.resize(nSize);

		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_in3)] = "in^3";
		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_ft3)] = ("ft^3");
		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_cm3)] = ("cm^3");
		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_m3)] = ("m^3");
		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_ul)] = ("uL");
		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_ml)] = ("mL");
		m_vVolumeUnitsString[static_cast<int>(VOLUME_UNITS_l)] = ("L");

		// so won't get call again. Otherwise, 

		m_bVolumeUnitsReady = TRUE;
	}


	//Now we can convert units
	//

	DeclareCanConvert();

	return TRUE;
}

CString CVolume::GetUnitsString(eVOLUME_UNITS eUnits) const
{
	if ( eUnits > VOLUME_UNITS_UNDEFINED && eUnits < VOLUME_UNITS_LAST )
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

CString CVolume::GetCurrentUnitsString() const
{
	return GetUnitsString(m_eVolumeUnits);
}

const CVector<double>*	CVolume::GetConversionFactors() const
{
	return &m_dFactors;
}
