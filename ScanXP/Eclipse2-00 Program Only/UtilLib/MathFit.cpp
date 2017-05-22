/////////////////////////////////////////////////////////////////////
//
// CMathFit.cpp
//
// This class is designed to be used under both MFC and C-run-time enviroment
// So pay attention to the the predefined symbols
//
// ie,
//
//	_ATLSHCFIT_DLL, etc.
//
//
//////////////////////////////////////////////////////////////////////////

#ifndef _ATLSHCFIT_DLL
#include "stdafx.h"
#endif
#include "math.h"
//#include "AnalysisExceptionBase.h"
#include "mathfit.h"
#include "stdlib.h"
#include "NumericExceptionEnable.h"

#ifdef _ATLSHCFIT_DLL
#include "SchFitException.h"
#else
#include "stdafx.h"
#include "AnalysisExceptionBase.h"
#endif


#include "NRCUtil.h"

using namespace nsNRC;

/******************************************************************************
*	Fits a linear equation y = a0 + a1x. Returns the fitted coefficients and
*	uncertainties as well. Note that all vectors have the starting indice of 1
******************************************************************************/
CMathFit::CMathFit()
{
	

}
CMathFit::~CMathFit()
{
	
}

int CMathFit::FitLine( int			nNumberPoints, 
					 const double 	Xdata[], 
					 const double 	Ydata[],
					 const double 	Sigma[],
					 double			*pdChiSquared,
					 double 		*pdSlope,
					 double			*pdSlopeUnc,
					 double			*pdOffset,
					 double			*pdOffsetUnc,
					 double			*pdGoodnessOfFit,
					 double			*pdLinearCorrelation)
{
	//////////////////////////////////////////////////////////
	// For the coefficient, we try to follow the same convention as
	// in LinearFit, that ie,  
	// y = a + bx
	//
	// dFittedCoeffs[1] = a;	dUncertainties[1] = delta a
	// dFittedCoeffs[2] = b;	dUncertainties[2] = delta b
	//
	//////////////////////////////////////////////////////////////////////////////
	//
	//
	double FittedCoeffs[3], Uncertainties[3];
	
	int iret = LineFit(nNumberPoints,Xdata,Ydata,Sigma,pdChiSquared,FittedCoeffs,Uncertainties,pdGoodnessOfFit,pdLinearCorrelation);

	*pdSlope		= FittedCoeffs[2];
	*pdOffset		= FittedCoeffs[1];
	*pdSlopeUnc		= Uncertainties[2];
	*pdOffsetUnc	= Uncertainties[1];

	return iret;
}


int CMathFit::LineFit
(
	 int		nNumberPoints, 
	 const double 	Xdata[], 
	 const double 	Ydata[],
	 const double 	Sigma[],
	 double 	*pdChiSquared,
	 double 	FittedCoeffs[],
	 double		Uncertainties[] ,
	 double*	pdGoodnessOfFit,
	 double*    pdLinearCoeff)
{
	//////////////////////////////////////////////////////////
	// For the coefficient, we try to follow the same convention as
	// in LinearFit, that ie,  
	// y = a + bx
	//
	// dFittedCoeffs[1] = a;	dUncertainties[1] = delta a
	// dFittedCoeffs[2] = b;	dUncertainties[2] = delta b
	//
	//////////////////////////////////////////////////////////////////////////////
	//
	//
	int	mwt = 1;						// default to having uncertainties in energies
	if ( Sigma ) {
		// auto-detect whether we have valid uncertainties in energy or not
		for ( int i=1; i<= nNumberPoints; i++ )	{
			if ( Sigma[i] <= 0.0 ) {
				mwt = 0;				// only if we have one zero in the uncertainty, then forget all other uncertainties
				break;
			}
		}
	} else {
		mwt = 0;
	}

	CNumericExceptionsEnable ex(true);
	double dGoodnessOfFit = 0, dLinearCoeff = 0.0;
	//
	// do the fit now
	//
	fit(Xdata,Ydata,nNumberPoints,Sigma,mwt,&FittedCoeffs[1],&FittedCoeffs[2],
		&Uncertainties[1],&Uncertainties[2],pdChiSquared,&dGoodnessOfFit,&dLinearCoeff);

	if ( pdGoodnessOfFit ) *pdGoodnessOfFit = dGoodnessOfFit;
	if ( pdLinearCoeff   ) *pdLinearCoeff   = dLinearCoeff;

	return 1;
}

void CMathFit::fit(const double x[], const double y[], int ndata, const double sig[], int mwt, double *a,
		double *b, double *siga, double *sigb, double *chi2, double *q,double* r)
{
//	double gammq(double a, double x);
	int i;
	double wt,t,sxoss,sx=0.0,sy=0.0,st2=0.0,ss,sigdat;
	double sxx = 0, sxy = 0, syy = 0;

	*b=0.0;
	if (mwt) {
		ss=0.0;
		for (i=1;i<=ndata;i++) {
			wt	=1.0/SQR(sig[i]);
			ss	+= wt;
			sx	+= x[i]*wt;
			sy	+= y[i]*wt;
			sxx += x[i]*x[i]*wt;
			syy += y[i]*y[i]*wt;
			sxy += x[i]*y[i]*wt;
		}
	} else {
		for (i=1;i<=ndata;i++) {
			sx += x[i];
			sy += y[i];
			sxx += x[i]*x[i];
			syy += y[i]*y[i];
			sxy += x[i]*y[i];
		}
		ss=ndata;
	}
	sxoss=sx/ss;
	if (mwt) {
		for (i=1;i<=ndata;i++) {
			t=(x[i]-sxoss)/sig[i];
			st2 += t*t;
			*b += t*y[i]/sig[i];
		}
	} else {
		for (i=1;i<=ndata;i++) {
			t=x[i]-sxoss;
			st2 += t*t;
			*b += t*y[i];
		}
	}
	*b /= st2;
	*a=(sy-sx*(*b))/ss;
	*siga=sqrt((1.0+sx*sx/(ss*st2))/ss);
	*sigb=sqrt(1.0/st2);
	*chi2=0.0;
	*q=1.0;
	if (mwt == 0) {
		for (i=1;i<=ndata;i++)
			*chi2 += SQR(y[i]-(*a)-(*b)*x[i]);
		sigdat=sqrt((*chi2)/(ndata-2));
		*siga *= sigdat;
		*sigb *= sigdat;
	} else {
		for (i=1;i<=ndata;i++)
			*chi2 += SQR((y[i]-(*a)-(*b)*x[i])/sig[i]);
		if (ndata>2) 
		{
			////////////////////////////////////////////////////////////////
			// disalbe this for now
			*q = 1.0;
			//*q=gammq(0.5*(ndata-2),0.5*(*chi2));
		}
	}

	*r = ( ss * sxy - sx * sy ) / sqrt( ss * sxx - sx * sx ) / sqrt ( ss * syy - sy * sy );
}

double CMathFit::gammq(double a, double x)
{
//	void gcf(double *gammcf, double a, double x, double *gln);
//	void gser(double *gamser, double a, double x, double *gln);
//	void nrerror(char error_text[]);
	double gamser,gammcf,gln;
   
	if (x < 0.0 || a <= 0.0)
	{
#ifndef _ATLSHCFIT_DLL
		throw new CAnalysisExceptionBase("Error in line fit routines");
#endif
	}

	if (x < (a+1.0)) {
		gser(&gamser,a,x,&gln);
		return 1.0-gamser;
	} else {
		gcf(&gammcf,a,x,&gln);
		return gammcf;
	}
}

//helper function to calculate error functions
void CMathFit::gser(double *gamser, double a, double x, double *gln)
{

//	void nrerror(char error_text[]);
	int n;
	double sum,del,ap;

	*gln=gammln(a);
	if (x <= 0.0) {
		if (x < 0.0) 
		{
#ifndef _ATLSHCFIT_DLL
		throw new CAnalysisExceptionBase("Error in line fit routines");
#endif

		}
		*gamser=0.0;
		return;
	} else {
		ap=a;
		del=sum=1.0/a;
		for (n=1;n<=ITMAX;n++) {
			++ap;
			del *= x/ap;
			sum += del;
			if (fabs(del) < fabs(sum)*EPS) {
				*gamser=sum*exp(-x+a*log(x)-(*gln));
				return;
			}
		}

//		TRACE("a too large, ITMAX too small in routine gser");

		return;
	}
}

double CMathFit::gammln(double xx)
{
	double x,y,tmp,ser;
	static double cof[6]={76.18009172947146,-86.50532032941677,
		24.01409824083091,-1.231739572450155,
		0.1208650973866179e-2,-0.5395239384953e-5};
	int j;

	y=x=xx;
	tmp=x+5.5;
	tmp -= (x+0.5)*log(tmp);
	ser=1.000000000190015;
	for (j=0;j<=5;j++) ser += cof[j]/++y;
	return -tmp+log(2.5066282746310005*ser/x);
}

double CMathFit::fMyExp(double x)
{
	//to prevent overflow or underflow
	if ( x >= dMaxExpArg ) return		 dMaxMinExpValue;
	else if ( x <= -dMaxExpArg ) return  1.0/dMaxMinExpValue;
	else return exp(x);
}


void CMathFit::gcf(double *gammcf, double a, double x, double *gln)
{
//	double gammln(double xx);
//	void nrerror(char error_text[]);
	int i;
	double an,b,c,d,del,h;

	*gln=gammln(a);
	b=x+1.0-a;
	c=1.0/FPMIN;
	d=1.0/b;
	h=d;
	for (i=1;i<=ITMAX;i++) {
		an = -i*(i-a);
		b += 2.0;
		d=an*d+b;
		if (fabs(d) < FPMIN) d=FPMIN;
		c=b+an/c;
		if (fabs(c) < FPMIN) c=FPMIN;
		d=1.0/d;
		del=d*c;
		h *= del;
		if (fabs(del-1.0) < EPS) break;
	}
	
	if (i > ITMAX) 
	{
#ifndef _ATLSHCFIT_DLL
		throw new CAnalysisExceptionBase("Error in line fit routines");
#endif

	}
	
	*gammcf=exp(-x+a*log(x)-(*gln))*h;
}


int CMathFit::LinearFit
( 
	int 		nPoints, 
	double 	dXdata[], 
	double 	dYdata[],
	double 	dSigma[],
	double 	*dChiSquared,
	double 	dFittedCoeffs[],
	double	dUncertainties[]
)
{
	CNumericExceptionsEnable ex(true);


	const int nTerms = 2;	//2 terms in expression

	//Allocate some temporary storage for fitting routines
	double *w = dVector( 1, nTerms );
	double **cvm = dMatrix( 1, nTerms, 1, nTerms );
	double **u = dMatrix( 1, nPoints, 1, nTerms );
	double **v = dMatrix( 1, nTerms, 1, nTerms );


	//Fitting is done here
	Svdfit( dXdata , dYdata, dSigma, nPoints, dFittedCoeffs, nTerms,
			  u, v, w, dChiSquared, Polynomial);

	//Uncertainties in coefficients are determined here
	Svdvar( v, nTerms, w, cvm);

	//Put uncertainties into an array to be passed back to caller
	for (int i = 1; i <= nTerms; i++)
	{
		if( cvm[i][i] >= 0 ) dUncertainties[i] = sqrt(cvm[i][i]);
	}

	//calculate reduced chi square
	//nu = nPoints - fit parameters + 1 by definition
	*dChiSquared /= ( nPoints - nTerms + 1 );
	
	//Deallocate memory here
	free_dMatrix( v, 1, 1 );
	free_dMatrix( u, 1, 1 );
	free_dMatrix( cvm, 1, 1 );
	free_dVector(w);

	return 0;
}

/******************************************************************************
*	Fits a quadratic equation y = a0 + a1x + a2x^2
*
*	All vectors have the starting indice of 1
******************************************************************************/
int CMathFit::QuadraticFit
( 
	int 	nPoints, 
	double 	dXdata[], 
	double 	dYdata[],
	double 	dSigma[],
	double 	*dChiSquared,
	double 	dFittedCoeffs[],
	double	dUncertainties[],
	bool	bAV4_Method
)
{
	const int nTerms = 3;	//3 terms in a quadratic expression

	if ( bAV4_Method )
	{
		//////////////////////////////////////////////////////////
		// try to solve the equation 
		double *ExChn		= new double[nTerms];
		double *ExEnergy	= new double[nTerms];

		//////////////////////////////////////////////////////
		// the low index of the original data starts from 1
		// but 
		ExChn[0]		= dXdata[1];
		ExEnergy[0]		= dYdata[1];

		ExChn[2]		= dXdata[nPoints];
		ExEnergy[2]		= dYdata[nPoints];

		int iMiddlePoint = ( 1 + nPoints)/2;

		ExChn[1]		= dXdata[iMiddlePoint];
		ExEnergy[1]		= dYdata[iMiddlePoint];

		// we don't calculate uncertainties
		for ( int i=1; i<= nTerms; i++ ) dUncertainties[i] = 0.0;
		// exact fit, chi-square is zero
		*dChiSquared = 0;

		QuadraticFit_3Pts(ExEnergy,ExChn,&dFittedCoeffs[2],&dFittedCoeffs[1],&dFittedCoeffs[3]);

		delete ExChn;
		delete ExEnergy;
		ExChn = 0;
		ExEnergy = 0;

		return 1;

	}
	else
	{

		//Allocate some temporary storage for fitting routines
		double *w = dVector( 1, nTerms );
		double **cvm = dMatrix( 1, nTerms, 1, nTerms );
		double **u = dMatrix( 1, nPoints, 1, nTerms );
		double **v = dMatrix( 1, nTerms, 1, nTerms );

		//Fitting is done here
		Svdfit( dXdata , dYdata, dSigma, nPoints, dFittedCoeffs, nTerms,
				  u, v, w, dChiSquared, Polynomial);

		//Uncertainties in coefficients are determined here
		Svdvar( v, nTerms, w, cvm);

		//Put uncertainties into an array to be passed back to caller
		for (int i = 1; i <= nTerms; i++)
			dUncertainties[i] = sqrt(cvm[i][i]);

		//Deallocate memory here
		free_dMatrix( v, 1, 1 );
		free_dMatrix( u, 1, 1 );
		free_dMatrix( cvm, 1, 1 );
		free_dVector(w);

	}

	return 1;
}

///////////////////////////////////////////////////////////////////
// 
// This is the routine rused by Alpha Vision 4.0. 
// For all non-linear fit, using Quadratic fit above may not result in
// the "right" set of coefficients, since the results are not unique.
// In AV4.0, for only three data points, the following routine provides
// statisfactory results
//
// Note that the array index starts from zeros
//
int CMathFit::QuadraticFit_3Pts(
double	*ExEnergy, 
double	*ExChn,
double	*CalSlope, 
double *CalInt, 
double *CalShape )
{
    double d0, d1, d2, d3, d4;

    *CalSlope = 1.0;
    *CalInt   = 0.0;
    *CalShape = 0.0;

		 /*
         * -------------------------------------------------------------
         * Three point calibration.  Shape, slope and intercept are
         * all non-zero.
         * -------------------------------------------------------------
         */
        if ( (d0 = ExChn[0] * ExChn[0] - ExChn[1] * ExChn[1]) == 0.0 )
        {
            return 0;
        }

        d1 = (ExEnergy[0] - ExEnergy[1]) / d0;
        d2 = (ExChn[0] - ExChn[1]) / d0;

        if ( (d0 = (ExChn[0] * ExChn[0] - ExChn[2] * ExChn[2])) == 0.0 )
        {
            return 0;
        }

        d3 = (ExEnergy[0] - ExEnergy[2]) / d0;
        d4 = (ExChn[0] - ExChn[2]) / d0;

        if ( d2 == d4 )
        {
            return 0;
        }

        *CalSlope = (d1 - d3) / (d2 - d4 );
        *CalShape = d1 - *CalSlope * d2;
        *CalInt   = ExEnergy[0] - *CalShape * ExChn[0] * ExChn[0] -
                    *CalSlope * ExChn[0];

		return 1;
}

 
/******************************************************************************
*	Fits an inverse linear equation y = 1.0 / (a0 + a1x)
*
*	All vectors have the starting indice of 1
******************************************************************************/
int CMathFit::InverseLinearFit
( 
	int 	nPoints, 
	double 	dXdata[], 
	double 	dYdata[],
	double 	dSigma[],
	double 	*dChiSquared,
	double 	dFittedCoeffs[],
	double	dUncertainties[]
)
{
	const int nTerms = 2;	//2 terms in a quadratic expression

	//Allocate some temporary storage for fitting routines
	double *w = dVector( 1, nTerms );
	double *dInverseYData = dVector( 1, nPoints );
	double *dScaledSigma = dVector( 1, nPoints );
	double **cvm = dMatrix( 1, nTerms, 1, nTerms );
	double **u = dMatrix( 1, nPoints, 1, nTerms );
	double **v = dMatrix( 1, nTerms, 1, nTerms );

	//Take th inverse of the data
	for (int i = 1; i <= nPoints; i++)
	{
		dInverseYData[i] = 1.0 / dYdata[i];
		dScaledSigma[i] = -dSigma[i] / (dYdata[i] * dYdata[i]);
	}
	
	//Fitting is done here
	Svdfit( dXdata , dInverseYData, dScaledSigma, nPoints, dFittedCoeffs, nTerms,
			  u, v, w, dChiSquared, Polynomial);

	//Uncertainties in coefficients are determined here
	Svdvar( v, nTerms, w, cvm);

	//Put uncertainties into an array to be passed back to caller
	for (i = 1; i <= nTerms; i++)
		dUncertainties[i] = sqrt(cvm[i][i]);

	double df = 0.0;
	double dDiff = 0.0;
	double dChi2 = 0.0;
	for( i = 1; i <= nPoints; i++ )
	{
		df = 1.0 /(dFittedCoeffs[1] + ( dFittedCoeffs[2] * dXdata[i]));
		dDiff = dYdata[i]-df;
		dChi2 += (1/(dSigma[i] * dSigma[i])) * (dDiff * dDiff);
	}
	//calculate reduced chi square
	//nu = nPoints - fit parameters + 1 by definition
	*dChiSquared = dChi2 / ( nPoints - nTerms + 1 );

	//Deallocate memory here
	free_dMatrix( v, 1, 1 );
	free_dMatrix( u, 1, 1 );
	free_dMatrix( cvm, 1, 1 );
	free_dVector(w);
	free_dVector( dInverseYData );
	free_dVector( dScaledSigma );

	return 0;
}


/******************************************************************************
*	Fits an exponential equation y = a0*exp(a1x)
*
*	All vectors have the starting indice of 1
******************************************************************************/

int CMathFit::ExponentialFit
( 
	int 	nPoints, 
	double 	dXdata[], 
	double 	dYdata[],
	double 	dSigma[],
	double 	*dChiSquared,
	double 	dFittedCoeffs[],
	double	dUncertainties[]
)
{
	const int nTerms = 2;	//2 terms in a exponetial expression

	//Allocate some temporary storage for fitting routines
	double *w = dVector( 1, nTerms );
	double *dLogYdata = dVector( 1, nPoints );
	double *dScaledSigma = dVector( 1, nPoints );
	double **cvm = dMatrix( 1, nTerms, 1, nTerms );
	double **u = dMatrix( 1, nPoints, 1, nTerms );
	double **v = dMatrix( 1, nTerms, 1, nTerms );

	//Take ln of y and sigma values and don't do in place since don't want to change
	//original data values 
	for ( int i = 1; i <= nPoints; i++ )
	{
		dLogYdata[i] = log(dYdata[i]); 
		dScaledSigma[i] = dSigma[i] / dYdata[i];
	}

	//Fitting is done here
	Svdfit( dXdata , dLogYdata, dScaledSigma, nPoints, dFittedCoeffs, nTerms,
			  u, v, w, dChiSquared, Polynomial);

	//Transform y intercept; i.e. y intercept = exp(dFittedCoeffs(1))
	dFittedCoeffs[1] = exp(dFittedCoeffs[1]);

	//Uncertainties in coefficients are determined here
	Svdvar( v, nTerms, w, cvm);

	//Put uncertainties into an array to be passed back to caller
	//Note the exponential scaling
	dUncertainties[1] = sqrt(cvm[1][1]) * dFittedCoeffs[1];
	dUncertainties[2] = sqrt(cvm[2][2]);
	double dChi2 = 0.0;
	double df = 0.0;
	double dDiff = 0.0;
	for( i = 1; i <= nPoints; i++ )
	{
		df = dFittedCoeffs[1] * exp( dFittedCoeffs[2] * dXdata[i]);
		dDiff = dYdata[i]-df;
		dChi2 += (1/(dSigma[i] * dSigma[i])) * (dDiff * dDiff);
	}
	//calculate reduced chi square
	//nu = nPoints - fit parameters + 1 by definition
	*dChiSquared = dChi2 / ( nPoints - nTerms + 1 );

	//Deallocate memory here
	free_dMatrix( v, 1, 1 );
	free_dMatrix( u, 1, 1 );
	free_dMatrix( cvm, 1, 1 );
	free_dVector(dLogYdata);
	free_dVector(dScaledSigma);
	free_dVector(w);

	return 0;
}

double CMathFit::Pythag
(
	double a, 
	double b
)
{
	double absa=fabs(a);
	double absb=fabs(b);
	double dPythag = 0.0;
	
	if( absb == 0.0 )
		dPythag = 0.0;
	else if (absa > absb) 
		dPythag = absa * sqrt(1.0+((absb/absa) * (absb/absa)));
	else 
		dPythag = absb * sqrt(1.0+((absa/absb) * (absa/absb)));

	return dPythag;
}

#define SIGN( a, b ) ( (b) > 0.0 ? fabs(a) : -fabs(a) )

static double maxarg1, maxarg2;
#define DMAX( a, b ) ( maxarg1 = (a), maxarg2 = (b), (maxarg1) > (maxarg2) ?\
							(maxarg1) : (maxarg2))

static int iminarg1, iminarg2;
#define IMIN(a, b) ( iminarg1 = (a), iminarg2 = (b), (iminarg1) < (iminarg2) ?\
							(iminarg1) : (iminarg2))

void CMathFit::Svdcmp
(
	double **a, 
	int m, 
	int n, 
	double w[], 
	double **v
)
{
	int flag,i,its,j,jj,k;
	int l = 0,nm = 0;
	double anorm,c,f,g,h,s,scale,x,y,z,*rv1;

	rv1=dVector(1,n);
	g=scale=anorm=0.0;
	for (i=1;i<=n;i++) {
		l=i+1;
		rv1[i]=scale*g;
		g=s=scale=0.0;
		if (i <= m) {
			for (k=i;k<=m;k++) scale += fabs(a[k][i]);
			if (scale) {
				for (k=i;k<=m;k++) {
					a[k][i] /= scale;
					s += a[k][i]*a[k][i];
				}
				f=a[i][i];
				g = -SIGN(sqrt(s),f);
				h=f*g-s;
				a[i][i]=f-g;
				for (j=l;j<=n;j++) {
					for (s=0.0,k=i;k<=m;k++) s += a[k][i]*a[k][j];
					f=s/h;
					for (k=i;k<=m;k++) a[k][j] += f*a[k][i];
				}
				for (k=i;k<=m;k++) a[k][i] *= scale;
			}
		}
		w[i]=scale *g;
		g=s=scale=0.0;
		if (i <= m && i != n) {
			for (k=l;k<=n;k++) scale += fabs(a[i][k]);
			if (scale) {
				for (k=l;k<=n;k++) {
					a[i][k] /= scale;
					s += a[i][k]*a[i][k];
				}
				f=a[i][l];
				g = -SIGN(sqrt(s),f);
				h=f*g-s;
				a[i][l]=f-g;
				for (k=l;k<=n;k++) rv1[k]=a[i][k]/h;
				for (j=l;j<=m;j++) {
					for (s=0.0,k=l;k<=n;k++) s += a[j][k]*a[i][k];
					for (k=l;k<=n;k++) a[j][k] += s*rv1[k];
				}
				for (k=l;k<=n;k++) a[i][k] *= scale;
			}
		}
		anorm=DMAX(anorm,(fabs(w[i])+fabs(rv1[i])));
	}
	for (i=n;i>=1;i--) {
		if (i < n) {
			if (g) {
				for (j=l;j<=n;j++)
					v[j][i]=(a[i][j]/a[i][l])/g;
				for (j=l;j<=n;j++) {
					for (s=0.0,k=l;k<=n;k++) s += a[i][k]*v[k][j];
					for (k=l;k<=n;k++) v[k][j] += s*v[k][i];
				}
			}
			for (j=l;j<=n;j++) v[i][j]=v[j][i]=0.0;
		}
		v[i][i]=1.0;
		g=rv1[i];
		l=i;
	}
	for (i=IMIN(m,n);i>=1;i--) {
		l=i+1;
		g=w[i];
		for (j=l;j<=n;j++) a[i][j]=0.0;
		if (g) {
			g=1.0/g;
			for (j=l;j<=n;j++) {
				for (s=0.0,k=l;k<=m;k++) s += a[k][i]*a[k][j];
				f=(s/a[i][i])*g;
				for (k=i;k<=m;k++) a[k][j] += f*a[k][i];
			}
			for (j=i;j<=m;j++) a[j][i] *= g;
		} else for (j=i;j<=m;j++) a[j][i]=0.0;
		++a[i][i];
	}
	for (k=n;k>=1;k--) {
		for (its=1;its<=30;its++) {
			flag=1;
			for (l=k;l>=1;l--) {
				nm=l-1;
				if ((double)(fabs(rv1[l])+anorm) == anorm) {
					flag=0;
					break;
				}
				if ((double)(fabs(w[nm])+anorm) == anorm) break;
			}
			if (flag) {
				c=0.0;
				s=1.0;
				for (i=l;i<=k;i++) {
					f=s*rv1[i];
					rv1[i]=c*rv1[i];
					if ((double)(fabs(f)+anorm) == anorm) break;
					g=w[i];
					h=Pythag(f,g);
					w[i]=h;
					h=1.0/h;
					c=g*h;
					s = -f*h;
					for (j=1;j<=m;j++) {
						y=a[j][nm];
						z=a[j][i];
						a[j][nm]=y*c+z*s;
						a[j][i]=z*c-y*s;
					}
				}
			}
			z=w[k];
			if (l == k) {
				if (z < 0.0) {
					w[k] = -z;
					for (j=1;j<=n;j++) v[j][k] = -v[j][k];
				}
				break;
			}
			if ( its == 30 )
			{
//				CAnalysisExceptionBase* e = 
//				new CAnalysisExceptionBase( 
//					CAnalysisExceptionBase::MEMORY_ALLOCATION_FAILED,
//					_T("Singular Value Decomposition"));
//				free_dVector(rv1);
//				throw e;
			}
			x=w[l];
			nm=k-1;
			y=w[nm];
			g=rv1[nm];
			h=rv1[k];
			f=((y-z)*(y+z)+(g-h)*(g+h))/(2.0*h*y);
			g=Pythag(f,1.0);
			f=((x-z)*(x+z)+h*((y/(f+SIGN(g,f)))-h))/x;
			c=s=1.0;
			for (j=l;j<=nm;j++) {
				i=j+1;
				g=rv1[i];
				y=w[i];
				h=s*g;
				g=c*g;
				z=Pythag(f,h);
				rv1[j]=z;
				c=f/z;
				s=h/z;
				f=x*c+g*s;
				g = g*c-x*s;
				h=y*s;
				y *= c;
				for (jj=1;jj<=n;jj++) {
					x=v[jj][j];
					z=v[jj][i];
					v[jj][j]=x*c+z*s;
					v[jj][i]=z*c-x*s;
				}
				z=Pythag(f,h);
				w[j]=z;
				if (z) {
					z=1.0/z;
					c=f*z;
					s=h*z;
				}
				f=c*g+s*y;
				x=c*y-s*g;
				for (jj=1;jj<=m;jj++) {
					y=a[jj][j];
					z=a[jj][i];
					a[jj][j]=y*c+z*s;
					a[jj][i]=z*c-y*s;
				}
			}
			rv1[l]=0.0;
			rv1[k]=f;
			w[k]=x;
		}
	}
	free_dVector(rv1);
}

void CMathFit::Svdvar
(
	double **v, 
	int ma, 
	double w[], 
	double **cvm
)
{
	int k,j,i;
	double sum,*wti;

	wti=dVector(1,ma);
	for (i=1;i<=ma;i++) {
		wti[i]=0.0;
		if (w[i]) wti[i]=1.0/(w[i]*w[i]);
	}
	for (i=1;i<=ma;i++) {
		for (j=1;j<=i;j++) {
			for (sum=0.0,k=1;k<=ma;k++) sum += v[i][k]*v[j][k]*wti[k];
			cvm[j][i]=cvm[i][j]=sum;
		}
	}
	free_dVector(wti);
}

void CMathFit::Svbksb
(
	double **u, 
	double w[], 
	double **v, 
	int m, 
	int n, 
	double b[], 
	double x[]
)
{
	int jj,j,i;
	double s,*tmp;

	tmp=dVector(1,n);
	for (j=1;j<=n;j++) {
		s=0.0;
		if (w[j]) {
			for (i=1;i<=m;i++) s += u[i][j]*b[i];
			s /= w[j];
		}
		tmp[j]=s;
	}
	for (j=1;j<=n;j++) {
		s=0.0;
		for (jj=1;jj<=n;jj++) s += v[j][jj]*tmp[jj];
		x[j]=s;
	}
	free_dVector(tmp);
}


void CMathFit::Svdfit
(
	double x[], 
	double y[], 
	double sig[], 
	int ndata, 
	double a[], 
	int ma,
	double **u, 
	double **v, 
	double w[], 
	double *chisq,
	void (*funcs)(double, double [], int)
)
{
	const double TOL = 1.0e-5;
	int j,i;
	double wmax,tmp,thresh,sum,*b,*afunc;

	b=dVector(1,ndata);
	afunc=dVector(1,ma);
	for (i=1;i<=ndata;i++) {
		(*funcs)(x[i],afunc,ma);
		tmp=1.0/sig[i];
		for (j=1;j<=ma;j++) u[i][j]=afunc[j]*tmp;
		b[i]=y[i]*tmp;
	}
	Svdcmp(u,ndata,ma,w,v);
	wmax=0.0;
	for (j=1;j<=ma;j++)
		if (w[j] > wmax) wmax=w[j];
	thresh=TOL*wmax;
	for (j=1;j<=ma;j++)
		if (w[j] < thresh) w[j]=0.0;
	Svbksb(u,w,v,ndata,ma,b,a);
	*chisq=0.0;
	for (i=1;i<=ndata;i++) {
		(*funcs)(x[i],afunc,ma);
		for (sum=0.0,j=1;j<=ma;j++) sum += a[j]*afunc[j];
		*chisq += (tmp=(y[i]-sum)/sig[i],tmp*tmp);
	}
	free_dVector(afunc);
	free_dVector(b);
}

int * CMathFit::nVector(int nl, int nh)
/* allocate an int vector with subscript range v[nl..nh] */
{
	int *v;

	v = new int[nh-nl+1+NR_END];
	if (!v) 
	{
//		CAnalysisExceptionBase* e = 
//			new CAnalysisExceptionBase( 
//				CAnalysisExceptionBase::MEMORY_ALLOCATION_FAILED,
//				_T("nVector Allocation"));
//		throw e;
	}
	return v-nl+NR_END;
}

double * CMathFit::dVector(int nl, int nh)
/* allocate a double vector with subscript range v[nl..nh] */
{
	double *v;

	v = new double[nh-nl+1+NR_END];
	if (!v) 
	{
//		CAnalysisExceptionBase* e = 
//		new CAnalysisExceptionBase( 
//			CAnalysisExceptionBase::MEMORY_ALLOCATION_FAILED,
//			_T("dVector Allocation"));
//		throw e;
	}
	return v-nl+NR_END;
}

double** CMathFit::dMatrix(int nrl, int nrh, int ncl, int nch)
/* allocate a double matrix with subscript range m[nrl..nrh][ncl..nch] */
{
	int i;
	int nrow=nrh-nrl+1;
	int ncol=nch-ncl+1;

	/* allocate pointers to rows */
	double **m = new( double(*[nrow+NR_END] ));
	if (!m) 
	{
//		CAnalysisExceptionBase* e = 
//		new CAnalysisExceptionBase( 
//			CAnalysisExceptionBase::MEMORY_ALLOCATION_FAILED,
//			_T("dMatrix Allocation"));
//		throw e;
	}
	m += NR_END;
	m -= nrl;

	/* allocate rows and set pointers to them */
	m[nrl] = new double[ nrow*ncol+NR_END ];
	if (!m[nrl]) 
	{
//		CAnalysisExceptionBase* e = 
//		new CAnalysisExceptionBase( 
//			CAnalysisExceptionBase::MEMORY_ALLOCATION_FAILED,
//			_T("dMatrix Allocation"));
//		throw e;
	}
	m[nrl] += NR_END;
	m[nrl] -= ncl;

	for(i = nrl + 1; i <= nrh; i++) 
		m[i]=m[i-1]+ncol;

	/* return pointer to array of pointers to rows */
	return m;
}
void CMathFit::free_nVector(int *v)
/* free an int vector allocated with nVector() */
{
	delete []v;
}

void CMathFit::free_dVector(double *v)
/* free a double dVector allocated with dvector() */
{
	delete []v;
}

void CMathFit::free_dMatrix(double **m, int nrl, int ncl )
/* free a float matrix allocated by matrix() */
{
	delete (m[nrl]+ncl-NR_END);
	delete [] m;
	
}


/******************************************************************************
*
*	Builds an a polynomial of order nTerms using recursive relations:
*							p[1] = x
*							p[i] = p[i-1] * x
*
******************************************************************************/ 
void Polynomial
(
	double x, 
	double p[], 
	int nTerms
)
{
	p[1] = 1.0;
	for ( int i = 2; i <= nTerms; i++) 
		p[i] =p[i-1] * x;
}


