#include "stdafx.h"
#include "Length.h"

void	CLengthUnitsTranslator::AssignConversionFactors()
{
	m_dFactors.Resize(6,0);
	m_dFactors[0]			= 1;
	m_dFactors[1]			= 0.01;				// 1 cm = 0.01 meter
	m_dFactors[2]			= 0.001;
	m_dFactors[3]			= 0.000001;
	m_dFactors[4]			= 0.000000001;
	m_dFactors[5]			= 0.0254;			// 1 inch = 2.54 cm
}

void    CLengthUnitsTranslator::AssignUnitsStrings()
{
	// Define the corresponding units string here, such as
	// m_UnitsString[0] = "Meter";
	m_UnitsStrings.Resize(6,0);
	m_UnitsStrings[0] = "m";
	m_UnitsStrings[1] = "cm";
	m_UnitsStrings[2] = "mm";
	m_UnitsStrings[3] = "um";		// we can use true greek letter for u here
	m_UnitsStrings[4] = "nm";
	m_UnitsStrings[5] = "in";
}

//
// CLength
//

CLength::CLength(const CValues& val, eLENGTH_UNITS_TYPE units)
{
	// Since it's enum, assume valid always
	m_iUnitsIndex = static_cast<int>(units); 
	m_Values = val;
}

CLength::CLength(const CValues& val, const CString& csUnits)
{
	// could fail to set the units and values if csUnits is not a valid one
	//  or the units strings are not defined in the translator class
	//  or the units strings are not defined in the translator classSetUnitsAndValues(val, csUnits);
}

CLength::CLength(const CLength& rhs)
: CUnitsTmpl<CLengthUnitsTranslator>(rhs)
{
}

CLength& CLength::operator = (const CLength& rhs)
{
	if ( this != &rhs ) {
		CUnitsTmpl<CLengthUnitsTranslator>::operator = (rhs);
	}
	return *this;
}

void	CLength::SetTo_m()
{
	ConvertToUnits(LENGTH_UNITS_m);
}

void	CLength::SetTo_cm()
{
	ConvertToUnits(LENGTH_UNITS_cm);
}

void	CLength::SetTo_mm()
{
	ConvertToUnits(LENGTH_UNITS_mm);
}

void	CLength::SetTo_um()
{
	ConvertToUnits(LENGTH_UNITS_um);
}

void	CLength::SetTo_nm()
{
	ConvertToUnits(LENGTH_UNITS_nm);
}

void    CLength::SetTo_inch()
{
	ConvertToUnits(LENGTH_UNITS_inch);
}

CLength::eLENGTH_UNITS_TYPE CLength::GetUnits() const
{
	if ( m_iUnitsIndex > LENGTH_UNITS_UNDEFINED && m_iUnitsIndex < LENGTH_UNITS_LAST )
	{
		return static_cast<eLENGTH_UNITS_TYPE>(m_iUnitsIndex);
	}
	return LENGTH_UNITS_UNDEFINED;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// CArea related classes

void	CAreaUnitsTranslator::AssignConversionFactors()
{
	m_dFactors.Resize(6,0);
	m_dFactors[0]			= 1;
	m_dFactors[1]			= 1.0e-4;
	m_dFactors[2]			= 1.0e-6;
	m_dFactors[3]			= 1.0e-12;
	m_dFactors[4]			= 1.0e-18;
	m_dFactors[5]			= 0.00006452;			
}

void    CAreaUnitsTranslator::AssignUnitsStrings()
{
	// Define the corresponding units string here, such as
	// m_UnitsString[0] = "Meter";
	m_UnitsStrings.Resize(6,0);
	m_UnitsStrings[0] = "m^2";
	m_UnitsStrings[1] = "cm^2";
	m_UnitsStrings[2] = "mm^2";
	m_UnitsStrings[3] = "um^2";		// we can use true greek letter for u here
	m_UnitsStrings[4] = "nm^2";
	m_UnitsStrings[5] = "in^2";
}

//
// CArea
//

CArea::CArea(const CValues& val, eAREA_UNITS_TYPE units)
{
	// Since it's enum, assume valid always
	m_iUnitsIndex = static_cast<int>(units); 
	m_Values = val;
}

CArea::CArea(const CValues& val, const CString& csUnits)
{
	// could fail to set the units and values if csUnits is not a valid one
	//  or the units strings are not defined in the translator class
	SetUnitsAndValues(val, csUnits);
}

CArea::CArea(const CArea& rhs)
: CUnitsTmpl<CAreaUnitsTranslator>(rhs)
{
}


CArea& CArea::operator = (const CArea& rhs)
{
	if ( this != &rhs ) {
		CUnitsTmpl<CAreaUnitsTranslator>::operator = (rhs);
	}
	return *this;
}

void	CArea::SetTo_sqr_m()
{
	ConvertToUnits(AREA_UNITS_sqr_m);
}

void	CArea::SetTo_sqr_cm()
{
	ConvertToUnits(AREA_UNITS_sqr_cm);
}

void	CArea::SetTo_sqr_mm()
{
	ConvertToUnits(AREA_UNITS_sqr_mm);
}

void	CArea::SetTo_sqr_um()
{
	ConvertToUnits(AREA_UNITS_sqr_um);
}

void	CArea::SetTo_sqr_nm()
{
	ConvertToUnits(AREA_UNITS_sqr_nm);
}

void    CArea::SetTo_sqr_inch()
{
	ConvertToUnits(AREA_UNITS_sqr_inch);
}

CArea::eAREA_UNITS_TYPE CArea::GetUnits() const
{
	if ( m_iUnitsIndex > AREA_UNITS_UNDEFINED && m_iUnitsIndex < AREA_UNITS_LAST )
	{
		return static_cast<eAREA_UNITS_TYPE>(m_iUnitsIndex);
	}
	return AREA_UNITS_UNDEFINED;
}

