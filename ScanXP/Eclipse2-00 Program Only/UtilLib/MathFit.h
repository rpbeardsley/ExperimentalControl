#ifndef __INC__MATHFIT_H
#define __INC__MATHFIT_H

class CNumericExceptionsEnable;

class CMathFit
{
public:

	CMathFit();
	virtual ~CMathFit();
	////////////////////////////////////////////////////////////////////
	// Exact line fit fits the data with a straight line of the form
	// y = a + bx.  
	//
	/////////////////////////////////////////////////////////////////////

	int FitLine	( int			nNumberPoints, 
				 const double 	Xdata[], 
				 const double 	Ydata[],
				 const double 	Sigma[],
				 double			*pdChiSquared,
				 double 		*pdSlope,
				 double			*pdSlopeUnc,
				 double			*pdOffset,
				 double			*pdOffsetUnc,
				 double			*pGoodnessOfFit = 0,
				 double			*pdLinearCoeff = 0);

	////////////////////////////////////////////////////////////////////
	// LineFit fits the data with a straight line of the form
	// y = a + bx. On returns, 
	//
	// a = dFittedCoeffs[1];
	// b = dFittedCoeffs[2];
	//
	//
	/////////////////////////////////////////////////////////////////////
	//
	int LineFit	   ( int	nNumberPoints, 
				   const double 	Xdata[], 
				   const double 	Ydata[],
				   const double 	Sigma[],
				   double 	*pdChiSquared,
				   double 	FittedCoeffs[],
				   double	Uncertainties[],
				   double   *pdGoodnessOfFit = 0,
				   double   *pdLinearCoeff = 0);

	//////////////////////////////////////////////////////////////////////////
	//
	// This version of line fit uses the more general approach
	// to do the fit, ie, treating line fit as a polynomial fit. 
	// It's not the recommended method. Use above LineFit() instead.
	//

	int LinearFit( int		nNumberPoints, 
				   double 	dXdata[], 
				   double 	dYdata[],
				   double 	dSigma[],
				   double 	*dChiSquared,
				   double 	dFittedCoeffs[],
				   double	dUncertainties[] );

	int QuadraticFit( int		nNumberPoints, 
					  double 	dXdata[], 
					  double 	dYdata[],
					  double 	dSigma[],
					  double 	*dChiSquared,
					  double 	dFittedCoeffs[],
					  double	dUncertainties[],
					  bool		bAV4_Method = true);

	int ExponentialFit(	int 	nPoints, 
						double 	dXdata[], 
						double 	dYdata[],
						double 	dSigma[],
						double 	*dChiSquared,
						double 	dFittedCoeffs[],
						double	dUncertainties[] );
	/////////////////////////////////////////////////////////////////////////////
	//
	//	Fit 1.0/ ( a + bx );
	//
	//////////////////////////////////////////////////////////////////////////////
	//
	int InverseLinearFit( int		nNumberPoints, 
						double 	dXdata[], 
						double 	dYdata[],
						double 	dSigma[],
						double 	*dChiSquared,
						double 	dFittedCoeffs[],
						double	dUncertainties[] );

private:
	/////////////////////////////////////////////////////////////////////////////
	// Fits straight line y = a + bx
	//
	void fit(const  double x[], const double y[], int ndata, const  double sig[], int mwt, double *a,
		double *b, double *siga, double *sigb, double *chi2, double *q,double* r);
	////////////////////////////////////////////////////////////////////////////
	// helper function for fit ( line fit)
	double gammq(double a, double x);
	////////////////////////////////////////////////////////////
	// Please note that gser() and gcf() defined here are more 
	// general that the one defined in ATL module
	// "MarqFitFunctions.h". The latter is a special case
	// of the former 
	//
	void gser(double *gamser, double a, double x, double *gln);
	void gcf(double *gammcf, double a, double x, double *gln);
	double fMyExp(double x);
	double gammln(double xx);


	friend void Polynomial( double x, double p[], int nOrder );
	double Pythag( double a, double b );
	void Svdcmp( double **a, int m, int n, double w[], double **v );
	void Svdvar( double **v, int ma, double w[], double **cvm );
	
	void Svbksb( double **u, double w[], double **v, int m,
				 int n,		 double b[], 
				 double x[] );

	void Svdfit( double x[], double y[], double sig[], int ndata, 
				 double a[], int ma, double **u, double **v, 
				 double w[], double *chisq, 
				 void (*funcs)(double, double [], int));

	int *nVector(int nl, int nh);
	double *dVector(int nl, int nh);
	double **dMatrix(int nrl, int nrh, int ncl, int nch);
	void free_nVector(int *v);
	void free_dVector(double *v);
	void free_dMatrix(double **m, int nrl, int ncl );

	
	int QuadraticFit_3Pts(double	*ExEnergy, 
						double		*ExChn,
						double		*CalSlope, 
						double		*CalInt, 
						double		*CalShape );
	

	CNumericExceptionsEnable*	m_pMathExceptionsEnable;

};




#endif
