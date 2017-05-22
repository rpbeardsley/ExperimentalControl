#ifndef __INC_SPECTIME_H
#define __INC_SPECTIME_H

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// spectime.h : header file
//
#include "metric.h"
//----------- For real and live time of spectra ------------
//
// although time in spectrscopy has no uncertainty with it, use
// CMetric as base class so that it's at the same class level
// as other similiar clases

class CSpecTime: public nsCMetric::CMetric
{
public:

	enum { m_nNumberOfUnits = 5 };

	enum eTIME_UNITS {
		TIME_UNITS_SEC = 0,
		TIME_UNITS_MIN,
		TIME_UNITS_HR,
		TIME_UNITS_DAY,
		TIME_UNITS_YEAR,
	};

	CSpecTime();
	//allow implicit conversion
	CSpecTime(double dTime, eTIME_UNITS eUnits);
	CSpecTime(CValues times, eTIME_UNITS eUnits);

	void Init();
	//allow conversion from CSpecTime to a double
	//operator double () const;

	CSpecTime(const CSpecTime& rhs);

	CSpecTime& operator = (const CSpecTime& rhs);

	virtual ~CSpecTime() {};

	eTIME_UNITS GetTimeUnits() const { return m_eTimeUnits;}

	//get time in "normal" sense
	double		GetTimeDbl() const;
	CValues     GetTime() const;
	void		SetToSeconds();
	void		SetToMinutes();
	void		SetToHours();
	void		SetToDays();
	void		SetToYears();

private:

	eTIME_UNITS m_eTimeUnits;
	//overide
	void FillConversionFactors();
	const CVector<double>*	GetConversionFactors() const;
	void CopyMembers(const CSpecTime& rhs);
	//
	BOOL PrepareConversions();

	static CVector<double> m_dFactors;

	static BOOL			   m_bTimeUnitsReady;

};


#endif
