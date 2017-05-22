#pragma once

#include "UnitsTemplate.h"
#include "DimTemplate.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	IMPORTANT REMINDER: By John Guo, Sept. 27, 2001
//
//		The CLength class below uses a better implementation to define a units class than those defined before
//  (see CActiivty, CCountRate, etc.). Later units classes should always be defined this way, instead of the old
//  way.
//
//	To define a new units class, simply follow the following steps:
//
//	1.	Define a translator clas for the units. See comments on the translator for details
// 
//  2.  Devise a scheme to keep track of the units index. Defining an enerated type is a prefered way
//
//	3.  If using enumerated type, make sure that the No of types defined is the same as the conversion
//		factors defined in the translator
//	4.  
////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

class CLengthUnitsTranslator : public CUnitsTranslatorBase
{
public:
	virtual void	AssignConversionFactors();
	virtual void    AssignUnitsStrings();

};

class CLength : public CUnitsTmpl<CLengthUnitsTranslator>
{
public:

	enum eLENGTH_UNITS_TYPE {
		LENGTH_UNITS_UNDEFINED = -1,
		LENGTH_UNITS_m = 0,
		LENGTH_UNITS_cm = 1,
		LENGTH_UNITS_mm = 2,
		LENGTH_UNITS_um = 3,
		LENGTH_UNITS_nm = 4,
		LENGTH_UNITS_inch = 5,
		LENGTH_UNITS_LAST
	};

	CLength() { }
	CLength(const CValues& val, eLENGTH_UNITS_TYPE units);
	CLength(const CValues& val, const CString& csUnits);

	CLength(const CLength& rhs);
	CLength& operator = (const CLength& rhs);

	void	SetTo_m();
	void	SetTo_cm();
	void	SetTo_mm();
	void	SetTo_um();
	void	SetTo_nm();
	void    SetTo_inch();

	eLENGTH_UNITS_TYPE GetUnits() const;

protected:

	CDimLength	m_DimLength;

};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CArea and related class
//
class CAreaUnitsTranslator : public CUnitsTranslatorBase
{
public:
	virtual void	AssignConversionFactors();
	virtual void    AssignUnitsStrings();

};

class CArea : public CUnitsTmpl<CAreaUnitsTranslator>
{
public:

	enum eAREA_UNITS_TYPE {
		AREA_UNITS_UNDEFINED = -1,
		AREA_UNITS_sqr_m = 0,
		AREA_UNITS_sqr_cm = 1,
		AREA_UNITS_sqr_mm = 2,
		AREA_UNITS_sqr_um = 3,
		AREA_UNITS_sqr_nm = 4,
		AREA_UNITS_sqr_inch = 5,
		AREA_UNITS_LAST
	};
	CArea() { };
	CArea(const CValues& val, eAREA_UNITS_TYPE units);
	CArea(const CValues& val, const CString& csUnits);

	CArea(const CArea& rhs);
	CArea& operator = (const CArea& rhs);

	void	SetTo_sqr_m();
	void	SetTo_sqr_cm();
	void	SetTo_sqr_mm();
	void	SetTo_sqr_um();
	void	SetTo_sqr_nm();
	void    SetTo_sqr_inch();

	eAREA_UNITS_TYPE GetUnits() const;

};

