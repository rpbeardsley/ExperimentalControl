// EChemUnits.cpp : implementation file
//

#include "stdafx.h"
#include "EChemUnits.h"

/////////////////////////////////////////////////////////////////////////////
// CCurrent
CVector<double> CCurrent::m_dFactors;
BOOL CCurrent::m_bCurrentUnitsReady = FALSE;

CCurrent::CCurrent()
{
	m_eUnitsType = UNITS_TYPE_Current;
	m_eCurrentUnits = CURRENT_UNITS_A;
	PrepareConversions();
}

CCurrent::CCurrent(const CValues& value, eCURRENT_UNITS eUnits)
{
	//prefered way to construct object
	m_Values			= value;
	m_eCurrentUnits	= eUnits;
	PrepareConversions();
}

CCurrent::CCurrent(const CValues& value)
{
	//prefered way to construct object
	m_Values			= value;
	m_eCurrentUnits = CURRENT_UNITS_A;
	PrepareConversions();
}

void CCurrent::CopyMembers(const CCurrent& rhs)
{
	//do assignement here
	m_eCurrentUnits = rhs.m_eCurrentUnits;
}

CCurrent::CCurrent(const CCurrent& rhs)
: 	CMetric(rhs)
{
	CopyMembers(rhs);
}

CCurrent& CCurrent::operator = (const CCurrent& rhs)
{
	if ( this != &rhs ) {
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}	

void CCurrent::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);
	//
	m_dFactors[0]	= 1.0;				//
	m_dFactors[1]	= 0.001;
	m_dFactors[2]	= 0.000001;
	m_dFactors[3]	= 0.000000001;
}

void CCurrent::SetTo_A()
{
	double d = ConvertUnits(CURRENT_UNITS_A,m_eCurrentUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eCurrentUnits = CURRENT_UNITS_A;
	}
}
void CCurrent::SetTo_mA()
{
	double d = ConvertUnits(CURRENT_UNITS_mA,m_eCurrentUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eCurrentUnits = CURRENT_UNITS_mA;
	}
}

void CCurrent::SetTo_uA()
{
	double d = ConvertUnits(CURRENT_UNITS_uA,m_eCurrentUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eCurrentUnits = CURRENT_UNITS_uA;
	}
}

void CCurrent::SetTo_nA()
{
	double d = ConvertUnits(CURRENT_UNITS_nA,m_eCurrentUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eCurrentUnits = CURRENT_UNITS_nA;
	}
}


BOOL CCurrent::PrepareConversions()
{
	if ( m_bCurrentUnitsReady == FALSE || m_dFactors.Size() == 0) {
		FillConversionFactors();
		// so won't get call again. Otherwise, 
		m_bCurrentUnitsReady = TRUE;
	}
	//Now we can convert units
	DeclareCanConvert();
	return TRUE;
}

const CVector<double>*	CCurrent::GetConversionFactors() const
{
	return &m_dFactors;
}

/////////////////////////////////////////////////////////////////////////////
// CPotential
//
CVector<double> CPotential::m_dFactors;
BOOL CPotential::m_bPotentialUnitsReady = FALSE;

CPotential::CPotential()
{
	m_eUnitsType = UNITS_TYPE_Potential;
	m_ePotentialUnits = POTENTIAL_UNITS_V;
	PrepareConversions();
}

CPotential::CPotential(const CValues& value, ePOTENTIAL_UNITS eUnits)
{
	//prefered way to construct object
	m_Values			= value;
	m_ePotentialUnits	= eUnits;
	PrepareConversions();
}

CPotential::CPotential(const CValues& value)
{
	//prefered way to construct object
	m_Values			= value;
	m_ePotentialUnits = POTENTIAL_UNITS_V;
	PrepareConversions();
}


void CPotential::CopyMembers(const CPotential& rhs)
{
	//do assignement here
	m_ePotentialUnits = rhs.m_ePotentialUnits;
}

CPotential::CPotential(const CPotential& rhs)
: 	CMetric(rhs)
{
	CopyMembers(rhs);
}

CPotential& CPotential::operator = (const CPotential& rhs)
{
	if ( this != &rhs ) {
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}	

void CPotential::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);
	//
	m_dFactors[0]	= 1.0;				//
	m_dFactors[1]	= 0.001;
	m_dFactors[2]	= 0.000001;
	m_dFactors[3]	= 0.000000001;
}

void CPotential::SetTo_V()
{
	double d = ConvertUnits(POTENTIAL_UNITS_V,m_ePotentialUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePotentialUnits = POTENTIAL_UNITS_V;
	}
}
void CPotential::SetTo_mV()
{
	double d = ConvertUnits(POTENTIAL_UNITS_mV,m_ePotentialUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePotentialUnits = POTENTIAL_UNITS_mV;
	}
}

void CPotential::SetTo_uV()
{
	double d = ConvertUnits(POTENTIAL_UNITS_uV,m_ePotentialUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePotentialUnits = POTENTIAL_UNITS_uV;
	}
}

void CPotential::SetTo_nV()
{
	double d = ConvertUnits(POTENTIAL_UNITS_nV,m_ePotentialUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePotentialUnits = POTENTIAL_UNITS_nV;
	}
}


BOOL CPotential::PrepareConversions()
{
	if ( m_bPotentialUnitsReady == FALSE || m_dFactors.Size() == 0) {
		FillConversionFactors();
		// so won't get call again. Otherwise, 
		m_bPotentialUnitsReady = TRUE;
	}
	//Now we can convert units
	DeclareCanConvert();
	return TRUE;
}

const CVector<double>*	CPotential::GetConversionFactors() const
{
	return &m_dFactors;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CResistor
CVector<double> CResistor::m_dFactors;
BOOL CResistor::m_bResistorUnitsReady = FALSE;

CResistor::CResistor()
{
	m_eUnitsType = UNITS_TYPE_RESISTOR;
	m_eResistorUnits = RESISTOR_UNITS_Ohm;
	PrepareConversions();
}

CResistor::CResistor(const CValues& values)
{
	m_Values = values;
	m_eResistorUnits = RESISTOR_UNITS_Ohm;
	PrepareConversions();
}

CResistor::CResistor(const CResistor& rhs)
: CMetric ( rhs )
{
	CopyMembers(rhs);
}

CResistor& CResistor::operator = (const CResistor& rhs)
{
	if ( this != &rhs ) {
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}

void CResistor::SetTo_Ohm()
{
	double d = ConvertUnits(RESISTOR_UNITS_Ohm,m_eResistorUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eResistorUnits = RESISTOR_UNITS_Ohm;
	}

}

void CResistor::SetTo_kOhm()
{
	double d = ConvertUnits(RESISTOR_UNITS_kOhm,m_eResistorUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eResistorUnits = RESISTOR_UNITS_kOhm;
	}

}
void CResistor::SetTo_MOhm()
{
	double d = ConvertUnits(RESISTOR_UNITS_MOhm,m_eResistorUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eResistorUnits = RESISTOR_UNITS_MOhm;
	}

}

const CVector<double>*	CResistor::GetConversionFactors() const
{
	return &m_dFactors;
}

void CResistor::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);
	//
	m_dFactors[0]	= 1.0;				//
	m_dFactors[1]	= 1000.0;
	m_dFactors[2]	= 1000000.0;
}

void CResistor::CopyMembers(const  CResistor& rhs)
{
	m_eResistorUnits = rhs.m_eResistorUnits;
}

BOOL CResistor::PrepareConversions()
{
	if ( m_bResistorUnitsReady == FALSE || m_dFactors.Size() == 0) {
		FillConversionFactors();
		// so won't get call again. Otherwise, 
		m_bResistorUnitsReady = TRUE;
	}
	//Now we can convert units
	DeclareCanConvert();
	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CPolarizationResistance::
//
CVector<double> CPolarizationResistance::m_dFactors;
BOOL CPolarizationResistance::m_bPRUnitsReady = FALSE;

CPolarizationResistance::CPolarizationResistance()
{
	m_eUnitsType = UNITS_TYPE_Current;
	m_ePRUnits = PR_UNITS_Ohm_per_cm2;
	PrepareConversions();
}

CPolarizationResistance::CPolarizationResistance(const CValues& rhs)
{
	//prefered way to construct object
	m_Values			= rhs;
	m_ePRUnits			= PR_UNITS_Ohm_per_cm2;
	PrepareConversions();
}


CPolarizationResistance::CPolarizationResistance(const CPolarizationResistance& rhs)
: 	CMetric(rhs)
{
		CopyMembers(rhs);
}

CPolarizationResistance& CPolarizationResistance::operator = ( const CPolarizationResistance& rhs)
{
	if ( this != &rhs ) {
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}

void CPolarizationResistance::SetTo_Ohm_per_cm2()
{
	double d = ConvertUnits(PR_UNITS_Ohm_per_cm2,m_ePRUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePRUnits = PR_UNITS_Ohm_per_cm2;
	}

}
void CPolarizationResistance::SetTo_kOhm_per_cm2()
{
	double d = ConvertUnits(PR_UNITS_kOhm_per_cm2,m_ePRUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePRUnits = PR_UNITS_kOhm_per_cm2;
	}

}

void CPolarizationResistance::SetTo_MOhm_per_cm2()
{
	double d = ConvertUnits(PR_UNITS_MOhm_per_cm2,m_ePRUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_ePRUnits = PR_UNITS_MOhm_per_cm2;
	}

}

const CVector<double>*	CPolarizationResistance::GetConversionFactors() const
{
	return &m_dFactors;
}
void CPolarizationResistance::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);
	//
	m_dFactors[0]	= 1.0;				//
	m_dFactors[1]	= 1000.0;
	m_dFactors[2]	= 1000000.0;
}

void CPolarizationResistance::CopyMembers(const  CPolarizationResistance& rhs)
{
	//do assignement here
	m_ePRUnits = rhs.m_ePRUnits;

}

BOOL CPolarizationResistance::PrepareConversions()
{
	if ( m_bPRUnitsReady == FALSE || m_dFactors.Size() == 0) {
		FillConversionFactors();
		// so won't get call again. Otherwise, 
		m_bPRUnitsReady = TRUE;
	}
	//Now we can convert units
	DeclareCanConvert();
	return TRUE;

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
CVector<double> CCorrosionRate::m_dFactors;
BOOL CCorrosionRate::m_bCorrosionRateUnitsReady = FALSE;

CCorrosionRate::CCorrosionRate()
{
	m_eUnitsType = UNITS_TYPE_CR;
	m_eCRUnits = CR_UNITS_mpy;
	PrepareConversions();
}


CCorrosionRate::CCorrosionRate(const CValues& rhs)
{
	//prefered way to construct object
	m_Values			= rhs;
	m_eCRUnits = CR_UNITS_mpy;
	PrepareConversions();
}


CCorrosionRate::CCorrosionRate(const CCorrosionRate& rhs)
: CMetric(rhs)
{
	CopyMembers(rhs);
}
CCorrosionRate& CCorrosionRate::operator = ( const CCorrosionRate& rhs)
{
	if ( this != &rhs ) {
		CopyMembers(rhs);
		CMetric::operator = (rhs);
	}
	return *this;
}

void	CCorrosionRate::SetTo_mpy()
{
	double d = ConvertUnits(CR_UNITS_mpy,m_eCRUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eCRUnits = CR_UNITS_mpy;
	}

}

void	CCorrosionRate::SetTo_mmpy()
{
	double d = ConvertUnits(CR_UNITS_mmpy,m_eCRUnits);
	if ( d > 0.0 ) {
		m_Values *= d;
		m_eCRUnits = CR_UNITS_mmpy;
	}

}

const CVector<double>*	CCorrosionRate::GetConversionFactors() const
{
	return &m_dFactors;
}
void	CCorrosionRate::FillConversionFactors()
{
	//conversion factors for units
	UINT nLow = 0;
	m_dFactors.Resize(m_nNumberOfUnits,nLow);
	//
	m_dFactors[0]	= 1.0;				//
	m_dFactors[1]	= 39.37;			// 1 mmm = (1/25.4)(inch) * 1000
}

void CCorrosionRate::CopyMembers(const  CCorrosionRate& rhs)
{
	//do assignement here
	m_eCRUnits = rhs.m_eCRUnits;
}

BOOL CCorrosionRate::PrepareConversions()
{
	if ( m_bCorrosionRateUnitsReady == FALSE || m_dFactors.Size() == 0) {
		FillConversionFactors();
		// so won't get call again. Otherwise, 
		m_bCorrosionRateUnitsReady = TRUE;
	}
	//Now we can convert units
	DeclareCanConvert();
	return TRUE;

}

