//CQuadFit implementation file

#include "stdafx.h"
#include "QuadFit.h"
#include "Math.h"

// Fit a quadratic thru points (X1,Y1), (X2,Y2), (X3,Y3) to find (A,B,C) of Y = A*X*X + B*X + C

CQuadFit::CQuadFit(double dX1, double dY1, double dX2, double dY2, double dX3, double dY3, bool bPerformFit) 
{
	m_dX1 = dX1;
	m_dY1 = dY1;
	m_dX2 = dX2;
	m_dY2 = dY2;
	m_dX3 = dX3;
	m_dY3 = dY3;

	if( bPerformFit ) PerformFit();
}

bool CQuadFit::PerformFit()
{
	double a,b,c,d,e,f,g,h,i,Det,Tmp;
	double ainv,binv,cinv,dinv,einv,finv,ginv,hinv,iinv;
    // set up 3x3 matrix
	a = m_dX1 * m_dX1;         //(*  input matrix:   *)
	b = m_dX2 * m_dX2;         //(*   a   d   h      *)
	c = m_dX3 * m_dX3;         //(*   b   e   i      *)
	d = m_dX1;                 //(*   c   f   j      *)
	e = m_dX2;
	f = m_dX3;
	g = 1;
	h = 1;
	i = 1;
	Tmp = (a*e*i-a*h*f-b*d*i+b*g*f+c*d*h-c*g*e);

	if( fabs(Tmp) < 1.0e-20)
	{
		TRACE("PerformFit failed, cannot fit curve through points\n");
		return false;
	}

	Det = 1.0/Tmp;  // matrix determinant
	// now compute matrix inverse
	ainv = Det*(e*i-h*f);
	binv = Det*(-b*i+h*c);
	cinv = Det*(b*f-e*c);
	dinv = Det*(-d*i+g*f);
	einv = Det*(a*i-g*c);
	finv = Det*(-a*f+d*c);
	ginv = Det*(d*h-g*e);
	hinv = Det*(-a*h+g*b);
	iinv = Det*(a*e-d*b);
	// Solve for A,B,C coefficients from matrix inversion terms
	m_dA = ainv*m_dY1+dinv*m_dY2+ginv*m_dY3;
	m_dB = binv*m_dY1+einv*m_dY2+hinv*m_dY3;
	m_dC = cinv*m_dY1+finv*m_dY2+iinv*m_dY3;

	return true;
}