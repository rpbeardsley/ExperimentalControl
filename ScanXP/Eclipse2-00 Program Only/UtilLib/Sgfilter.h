// SGFilter.h : interface of the CMFCPeakSearchView class
//
/////////////////////////////////////////////////////////////////////////////
#ifndef __INC_SGFILTER_H
#define __INC_SGFILTER_H

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "matrix.h"
#include <math.h>

class CNumericExceptionsEnable;

//
//	This class use digitial filter to smooth the data (S-G method)
//
class CSGFilter
{
public:

	CSGFilter(CVector<double>& yData);
	virtual ~CSGFilter();
	bool SmoothAllDataPoints(int nLeft, int nRight, int m);
	bool SmoothAllDataPoints();
	CVector<double> GetFilteredData() { return m_ySGData;}

private:

	void savgol(CVector<double>& c, int np, int nl, int nr, int ld, int m);
	void lubksb(CMatrix<double>& a, int n, CVector<int>& indx, CVector<double>& b);
	void ludcmp(CMatrix<double>& a, int n, CVector<int>& indx, double *d);
	void SetYData();
	void DoIt();
	void Smooth();
	void SmoothBegin();
	void SmoothEnd();

	CSGFilter(const CSGFilter&);
	CSGFilter& operator =(const CSGFilter&);
	
	CVector<double>&	m_yData;
	CVector<double>		m_ySGData;
	int					m_nMoment;
	int					m_nLeft;
	int					m_nRight;
	CVector<double>		m_SGC;

	bool				CalculateLeftRightPoints();

	//CNumericExceptionsEnable* m_pExceptionEnable;
};


#endif