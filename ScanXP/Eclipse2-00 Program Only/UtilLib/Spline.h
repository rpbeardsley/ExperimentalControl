#ifndef _SPLINE_H_
#define _SPLINE_H_

//safearray declaration
#include <oleauto.h>
#include "vector.h"

//////////////////////////////////////////////////////////////////////////////////////////////////
//	this class may be used in "Local" mode: instantiate an object
//	calculate the interpolated data, use the interpolated data 
//	but be careful if you want to store that data since the destructor will 
//	erase the interpolated data
////////////////////////////////////////////////////////////////////////////////////////////////////

class CSpline
{
public:

	CSpline(const CVector<double>& yData,UINT nIntPoints = 0,double dHeightScaleFactor = 1); // Pass the data array, how many points to interpolate between two real data points. 
	virtual ~CSpline();

	virtual BOOL	Calculate(); 	//Do all the calculations. After the call, the interpolated data will be available for retrieval by calling GetSplinedData()
	inline UINT		GetIntPoints() const { return m_nIntPoints;} //how many points to interpolate
	inline void		SetSplinedPoints(UINT nIntPoints) { m_nIntPoints = nIntPoints;}
	BOOL			GetSplinedData(SAFEARRAY** ppsa) const; // CALLEE allocate memory and CALLER free memory !!!
	BOOL			GetSplinedData(CVector<double>& SplinedData) const;//get data
	SAFEARRAY**		GetSplinedData();   // get a pointer to the splined safe array of this object
	void			SetFirstLastDerivatives(double d1, double d2 ) { m_dFirstDer = d1; m_dLastDer = d2 ;} //If not using natural boundary condition for end points
	inline void		SetHeightScaleFactor(double d) { m_dHeightScaleFactor *= d;}
	inline double	GetHeightScaleFactor() const { return m_dHeightScaleFactor;}

private:
	//note that x data will be generatad by this class
	CVector<double>			m_xData;
	const CVector<double>&	m_yData_in;				//y data by reference
	CVector<double>			m_yData;
	CVector<double>			m_dDerivatives;			//calculated	
	SAFEARRAY*				m_psaYSplinedData;		//interpolated data
	void					ValidateBounds(int iHigh, int iLow) const;
	void					CalculateDerivatives();	//operations (see NRC)
	BOOL					Interpolate();			//calculate all the interpolated data points
	void					CalculateY(double x, double* py);			//routine from NR
	void					CalculateX();			//Assign x value to the routine
	void					WriteIntData();//write interpolated data
	void					ScaleSpectrumHeight();

	UINT	m_nIntPoints;			//how many points to insert between, not inclusive
	BOOL	m_bFirstNatural;		//natural boundary condition
	BOOL	m_bLastNatural;			//natural boundary condition
	
	double	m_dFirstDer;			//used for non-natural boundary condition. derivatives of the first point
	double	m_dLastDer;
	double	m_dHeightScaleFactor;	//spectrum height multiplier
};



#endif
