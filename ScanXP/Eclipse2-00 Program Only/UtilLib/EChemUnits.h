#ifndef _ECHEM_UNITS_H
#define _ECHEM_UNITS_H
// This file defines several units so that units conversion and error propagations can be 
#include "Metric.h"
class CCurrent : public CMetric
{
public:
	enum { m_nNumberOfUnits = 4 };
	enum eCURRENT_UNITS {
		CURRENT_UNITS_A,
		CURRENT_UNITS_mA,
		CURRENT_UNITS_uA,
		CURRENT_UNITS_nA
	};
	CCurrent();
	CCurrent(const CValues& values);
	CCurrent(const CValues& values,eCURRENT_UNITS units);
	virtual ~CCurrent() { };
	CCurrent(const CCurrent& rhs);
	CCurrent& operator = (const CCurrent& rhs);
	void	SetTo_A();
	void	SetTo_mA();
	void	SetTo_uA();
	void	SetTo_nA();
private:
	const CVector<double>*	GetConversionFactors() const;
	void					FillConversionFactors();
	eCURRENT_UNITS			m_eCurrentUnits;
	void CopyMembers(const  CCurrent& rhs);
	static CVector<double>  m_dFactors;
	static BOOL				m_bCurrentUnitsReady;
	BOOL					PrepareConversions();
};

class CPotential : public CMetric
{
public:
	enum { m_nNumberOfUnits = 4 };
	enum ePOTENTIAL_UNITS {
		POTENTIAL_UNITS_V,
		POTENTIAL_UNITS_mV,
		POTENTIAL_UNITS_uV,
		POTENTIAL_UNITS_nV
	};
	CPotential();
	CPotential(const CValues& values);
	CPotential(const CValues& values,ePOTENTIAL_UNITS units);
	virtual ~CPotential() { };
	CPotential(const CPotential& rhs);
	CPotential& operator = (const CPotential& rhs);
	void	SetTo_V();
	void	SetTo_mV();
	void	SetTo_uV();
	void	SetTo_nV();
private:
	const CVector<double>*	GetConversionFactors() const;
	void					FillConversionFactors();
	ePOTENTIAL_UNITS		m_ePotentialUnits;
	void CopyMembers(const  CPotential& rhs);
	static CVector<double>  m_dFactors;
	static BOOL				m_bPotentialUnitsReady;
	BOOL					PrepareConversions();
};

class CResistor : public CMetric
{
public:
	enum { m_nNumberOfUnits = 3 };
	enum eRESISTOR_UNITS {
		RESISTOR_UNITS_Ohm,
		RESISTOR_UNITS_kOhm,
		RESISTOR_UNITS_MOhm
	};

	CResistor();
	CResistor(const CValues& values);
	virtual ~CResistor() { };

	CResistor(const CResistor& rhs);
	CResistor& operator = (const CResistor& rhs);

	void	SetTo_Ohm();
	void	SetTo_kOhm();
	void	SetTo_MOhm();
private:
	const CVector<double>*	GetConversionFactors() const;
	void					FillConversionFactors();
	eRESISTOR_UNITS			m_eResistorUnits;
	void CopyMembers(const  CResistor& rhs);
	static CVector<double>  m_dFactors;
	static BOOL				m_bResistorUnitsReady;
	BOOL					PrepareConversions();
};

class CPolarizationResistance : public CMetric
{
public:
	enum { m_nNumberOfUnits = 3 };
	enum ePR_UNITS {
		PR_UNITS_Ohm_per_cm2,
		PR_UNITS_kOhm_per_cm2,
		PR_UNITS_MOhm_per_cm2
	};
	CPolarizationResistance();
	CPolarizationResistance(const CValues& rhs);
	virtual ~CPolarizationResistance() { };

	CPolarizationResistance(const CPolarizationResistance& rhs);
	CPolarizationResistance& operator = ( const CPolarizationResistance& rhs);

	void SetTo_Ohm_per_cm2();
	void SetTo_kOhm_per_cm2();
	void SetTo_MOhm_per_cm2();
private:
	const CVector<double>*	GetConversionFactors() const;
	void					FillConversionFactors();
	ePR_UNITS				m_ePRUnits;
	void CopyMembers(const  CPolarizationResistance& rhs);
	static CVector<double>  m_dFactors;
	static BOOL				m_bPRUnitsReady;
	BOOL					PrepareConversions();
};

class CCorrosionRate : public CMetric
{
public:
	enum { m_nNumberOfUnits = 2 };
	enum eCORROSION_RATE_UNITS {
		CR_UNITS_mpy = 0,
		CR_UNITS_mmpy = 1
	};

	CCorrosionRate();
	CCorrosionRate(const CValues& rhs);
	virtual ~CCorrosionRate() { };
	CCorrosionRate(const CCorrosionRate& rhs);
	CCorrosionRate& operator = ( const CCorrosionRate& rhs);

	void	SetTo_mpy();
	void	SetTo_mmpy();
private:
	const CVector<double>*	GetConversionFactors() const;
	void					FillConversionFactors();
	eCORROSION_RATE_UNITS	m_eCRUnits;
	void CopyMembers(const  CCorrosionRate& rhs);
	static CVector<double>  m_dFactors;
	static BOOL				m_bCorrosionRateUnitsReady;
	BOOL					PrepareConversions();
};

#endif