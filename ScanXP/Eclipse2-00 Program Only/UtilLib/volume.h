#ifndef AFX_VOLUME_H__87AD2278_148A_11D4_B48E_0020182AB864__INCLUDED_
#define AFX_VOLUME_H__87AD2278_148A_11D4_B48E_0020182AB864__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Volume.h : header file
//
#include "metric.h"

// ---------- CVolume ---------------

class CVolume: public CMetric
{
public:
	//7 defined
	enum { m_nNumberOfUnits = 7 };
	enum eVOLUME_UNITS {
		VOLUME_UNITS_UNDEFINED = -1,
		VOLUME_UNITS_l,					//litre
		VOLUME_UNITS_ml,				//milli
		VOLUME_UNITS_ul,				//micro
		VOLUME_UNITS_m3,				//cubic meter
		VOLUME_UNITS_cm3,				//cubic centimeter
		VOLUME_UNITS_ft3,				//cubic foot
		VOLUME_UNITS_in3,				//cubic inch
		VOLUME_UNITS_LAST
	};
	CVolume();
	virtual ~CVolume() {};
	CVolume(const CVolume& rhs);
	CVolume& operator = (const CVolume& rhs);

	CVolume(const CValues& value, eVOLUME_UNITS eUnits);
	CVolume(const CValues& value, CString& strUnits);

	void			SetTo_l();
	void			SetTo_ml();
	void			SetTo_ul();
	void			SetTo_m3();
	void			SetTo_cm3();
	void			SetTo_ft3();
	void			SetTo_in3();

	CString			GetUnitsString(eVOLUME_UNITS eUnits) const;
	CString			GetCurrentUnitsString() const;

private:

	const CVector<double>*	GetConversionFactors() const;
	void					FillConversionFactors();

	eVOLUME_UNITS m_eVolumeUnits;
	void CopyMembers(const CVolume& rhs);

	static CVector<double> m_dFactors;
	//
	BOOL PrepareConversions();
	//
	// we only need one such definition. So be static
	//
	static vector<CString> m_vVolumeUnitsString;
	static BOOL			   m_bVolumeUnitsReady;

};

#endif