#pragma once

#include "vector.h"
#include "Metric.h"

class CUnitsTranslatorBase {

public:

	////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Derived class should do the following:
	//
	// 1.   Create an array of conversions factors with dimension iUnits
	//
	// 2.   If texts for the inits are needed, create an array of CString objects
	//      with dimension iUnitsStrings = iUnits. else, pass iUnitsString = 0 and
	//      a null pointer
	// 3.   Declare an units translator type, such as
				
	//			class CActivityUhnitsTransltor : public CUnitsTranslatorBase 
	// 4.   Define the conversion factors and the units texts by implement the two pure virtual functions
	//      
	//      AssignConversionFactors()
	//		AssignUnitsStrings()
	// 
	// 5.   See the template class CUnitsTmpl for next step
	//
	///////////////////////////////////////////////////////////////////////////////////////////////////////////


	CUnitsTranslatorBase()	{ };

	virtual				~CUnitsTranslatorBase() { };
	virtual int			GetNoOfUnits() {return m_dFactors.Size();}
	virtual bool		Validate() {return false;}
	virtual bool        GetHasText() const { return m_UnitsStrings.Size() != 0 ;}
	virtual CString		GetUnitsText(int iIndex) const 
	{
		if ( iIndex >= 0 && GetHasText() && iIndex < m_UnitsStrings.Size()  ) return m_UnitsStrings[iIndex];
		else return "None";
	}
	const CVector<double>*	GetConversionFactors() const {return &m_dFactors;}
	// returns -1 if csUnits is not a valid unit string else return the index to the string
	virtual int         FindUnits(const CString& csUnits)  { return m_UnitsStrings.Find(csUnits);}
		
protected:

	CVector<double>		m_dFactors;
	CVector<CString>	m_UnitsStrings;
	// The translator class should be a singleton
	virtual void		AssignConversionFactors() = 0;
	virtual void		AssignUnitsStrings() = 0;

private:

	// no copy and assign of this class, it's going to be a single instance per units type
	CUnitsTranslatorBase(const CUnitsTranslatorBase& rhs);
	CUnitsTranslatorBase& operator = ( const CUnitsTranslatorBase& rhs);
};

//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// This template class is designed for:
//
//	1.	It will be used to declare a units type by:
//		
//			class CActivityUnits : pulic CUnitsImpl<CActivityUnitsTranslator>
//
//		For the definition of the units translator, see comments in its declaration
//
//  2.	It knows that the translstor should ba static member and when to call the translator function
//		AssignConverisonfactors() and AssignUnitsStrings()
//
//  3.	It further defines how to convert units
//
//  Note: The functionlalities defined in CMetric could have been put here as well
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

template <class TTranslator> 

class CUnitsTmpl : public CMetric
{
public:
	CString					GetUnitsText() const;
	// overwrite the one in CMetric
	const CVector<double>*	GetConversionFactors() const {return m_UnitsTranslator.GetConversionFactors();}

protected:

	CUnitsTmpl() : m_iUnitsIndex(-1) {
		// call to construct the translator
		PrepareConversions();
	};

	CUnitsTmpl(const CUnitsTmpl<TTranslator>& rhs);
	CUnitsTmpl<TTranslator>& operator = ( const CUnitsTmpl<TTranslator>& rhs);

	virtual ~CUnitsTmpl() { };

	static bool				m_bReady;
	static TTranslator		m_UnitsTranslator;
	virtual bool			PrepareConversions();
	void					Copy(const CUnitsTmpl& rhs);
	// If the conversion is successfull, returns true else returns false
	bool					ConvertToUnits(int iNewUnitsIndex);
	bool					IsValidIndex(int iIndex) const;
	int						m_iUnitsIndex;
	// Set the units given a string representing the units, may fail if the string is not defined in the translator
	bool					SetUnitsAndValues(const CValues& val, const CString& csUnits);

private:
	// overwrite the one in CMetric which should be absolete once all the classes have been implemented in the new way
	void					FillConversionFactors() { };

};

template  <class TTranslator> TTranslator CUnitsTmpl<TTranslator>::m_UnitsTranslator;
template <class TTranslator>  bool CUnitsTmpl<TTranslator>::m_bReady = false;


template <class TTranslator> 
CUnitsTmpl<TTranslator>::CUnitsTmpl(const CUnitsTmpl& rhs)
: CMetric(rhs)
{
	Copy(rhs);
}


template <class TTranslator>
CUnitsTmpl<TTranslator>& CUnitsTmpl<TTranslator>::operator = (const CUnitsTmpl<TTranslator>& rhs)
{
	if ( this != &rhs ) {
		Copy(rhs);
		CMetric::operator = ( rhs);
	}
	return *this;
}

template <class TTranslator>
void CUnitsTmpl<TTranslator>::Copy(const CUnitsTmpl<TTranslator>& rhs)
{
	m_iUnitsIndex = rhs.m_iUnitsIndex;
	// The translator should not be copied
}

template <class TTranslator>
bool CUnitsTmpl<TTranslator>::PrepareConversions()
{
	if ( !m_bReady  || m_UnitsTranslator.GetNoOfUnits() == 0  )
	{
		// 
		m_UnitsTranslator.AssignConversionFactors();
		m_UnitsTranslator.AssignUnitsStrings();
		m_bReady = true;
	}
	DeclareCanConvert();
	return true;
}

template <class TTranslator>

bool CUnitsTmpl<TTranslator>::IsValidIndex(int iIndex) const
{
	// note that it's a zero based index
	return ( iIndex >= 0 && iIndex < m_UnitsTranslator.GetNoOfUnits() );
}

template <class TTranslator>
bool CUnitsTmpl<TTranslator>::ConvertToUnits(int iNewUnitsIndex)
{
	bool bret = false;
	// zero based index

	if ( iNewUnitsIndex != m_iUnitsIndex &&	IsValidIndex(iNewUnitsIndex) )
	{
		// get the conversion factor
		double d = ConvertUnits(iNewUnitsIndex, m_iUnitsIndex);
		if ( d > 0.0 ) {
			m_Values *= d;
			m_iUnitsIndex = iNewUnitsIndex;
			bret = true;
		}
	}
	return bret;
}

template <class TTranslator>

CString CUnitsTmpl<TTranslator>::GetUnitsText() const
{
	return m_UnitsTranslator.GetUnitsText(m_iUnitsIndex);
}

template <class TTranslator>
bool CUnitsTmpl<TTranslator>::SetUnitsAndValues(const CValues& val, const CString& csUnits)
{
	int iIndex = m_UnitsTranslator.FindUnits(csUnits);
	if ( iIndex >= 0 && iIndex < m_UnitsTranslator.GetNoOfUnits() ) {
		m_iUnitsIndex = iIndex;
		m_Values = val;
		return true;
	} else {
		// we could throw an exception here. 
		TRACE("The units (%s) is not defined. Please check the units translator class. \n", csUnits);
	}
	return false;
}