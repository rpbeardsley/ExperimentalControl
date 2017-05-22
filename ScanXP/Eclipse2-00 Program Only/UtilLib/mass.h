#if !defined(AFX_MASS_H__87AD2278_148A_11D4_B48E_0020182AB864__INCLUDED_)
#define AFX_MASS_H__87AD2278_148A_11D4_B48E_0020182AB864__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Mass.h : header file
//
#include "metric.h"

// ---------- CMass ---------------

class CMass: public CMetric
{
public:
	// 4 elements now
	enum { m_nNumberOfUnits = 4 };
	enum eMASS_UNITS {
		MASS_UNITS_UNDEFINED = -1,
		MASS_UNITS_g,
		MASS_UNITS_Kg,
		MASS_UNITS_mg,
		MASS_UNITS_ug,
		MASS_UNITS_LAST
	};
	CMass();
	virtual ~CMass() {};
	//construct activity by (value,uncertainty, units) 
	CMass(const CValues& value, eMASS_UNITS eUnits);

	CMass(const CMass& rhs);
	CMass& operator = (const CMass& rhs);
	//units conversion function
	void SetTo_g();
	void SetTo_Kg();
	void SetTo_mg();
	void SetTo_ug();

	CString			GetUnitsString(eMASS_UNITS eUnits) const;
	CString			GetCurrentUnitsString() const;

private:
	const CVector<double>*	GetConversionFactors() const;
	void FillConversionFactors();
	eMASS_UNITS m_eMassUnits;
	void CopyMembers(const CMass& rhs);
	//
	static CVector<double> m_dFactors;
	static vector<CString> m_vVolumeUnitsString;
	//
	BOOL PrepareConversions();

	static BOOL			   m_bMassUnitsReady;


};

#endif