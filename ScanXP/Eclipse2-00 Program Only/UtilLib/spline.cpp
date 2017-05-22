#include "stdafx.h"
#include "Spline.h"
#include "assert.h"
#include "AnalysisExceptionBase.h"
#include "NumericExceptionEnable.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

const char szDivideByZero[] = "Divide by zero.";
const char szArrayBounds[]  = "Error in CVector array bounds.";
const char szMemFailed[]    = "Memory allocation failed.";

CSpline::CSpline(const CVector<double>& yData,UINT nIntPoints,double dHeightScaleFactor)
:	m_yData_in(yData),
	m_nIntPoints (nIntPoints),
	m_dHeightScaleFactor(dHeightScaleFactor)
{
	///////////////////////////////////////////////////////////////////////
	// Enable numerical exceptions for the life time of this object. 
	// It's expected that this object will be local in scope (destroyed
	// after the data has been splined.
	////////////////////////////////////////////////////////////////////////
	CNumericExceptionsEnable ex(true);
	assert (m_nIntPoints <= 8 );		//not likely to insert more than 8 data points between
	//
	int nlow = m_yData_in.LowBounds();
	int nhigh = m_yData_in.HighBounds();
	int nsize = nhigh - nlow + 1;
	ValidateBounds(nhigh,nlow);
	m_bFirstNatural			= TRUE;
	m_bLastNatural			= TRUE;
	m_dFirstDer				= 0.0;
	m_dLastDer				= 0.0;
	m_psaYSplinedData		= NULL;
	m_xData.Resize(nsize,nlow);
	m_yData.Resize(nsize,nlow);
	m_dDerivatives.Resize(nsize,nlow);
	//Even if scale factor is 1, this call has to be made here.
	ScaleSpectrumHeight();
}

void CSpline::ValidateBounds(int iHigh, int iLow) const
{
	if ( iHigh <= iLow + 1  || iHigh < 2 ||  iLow != 1 ) {		// Mar. 4, 2002 John: force nlow == 1 
		TRACE("Invalid  data array for cubic spline. Low = %d and High = %d",iLow,iHigh);
		throw  new CAnalysisExceptionBase(szDivideByZero);
	}
}

CSpline::~CSpline()
{
	if ( m_psaYSplinedData ) SafeArrayDestroy( m_psaYSplinedData); 
}

BOOL CSpline::Calculate()
{
	BOOL b = FALSE;
	try
	{
		//assume data in channels. We have to calcuate x first. See the function for details.
		CalculateX();
		//calculate derivatives needed to further spline calculations
		CalculateDerivatives();
		//calculate Spline data based on nIntPoints between any two existing points
		//after those calculations, the splined data can be retrieved
		 b = Interpolate();
#ifdef _DEBUG
		WriteIntData();
#endif
	} catch (...) {
		TRACE("Exception in cubic spline. Floating point exception or array out of bounds.\n");
	}
	return  b;
}
void CSpline::CalculateDerivatives()
{
	int i,k;
	double p,qn,sig,un;
	int n = m_yData.Size();
	int nhigh = m_yData.HighBounds();
	int nlow = m_yData.LowBounds();
	ValidateBounds(nhigh,nlow);

	CVector<double> u(n,1);		// low == 1 leads to size = high bound
	
	if (m_bFirstNatural )
		m_dDerivatives[1]=u[1]=0.0;
	else {
		m_dDerivatives[1] = -0.5;
		u[1]=(3.0/(m_xData[2]-m_xData[1]))*((m_yData[2]-m_yData[1])/(m_xData[2]-m_xData[1])-m_dFirstDer);
	}
	for (i=2;i<=n-1;i++) {
		sig=(m_xData[i]-m_xData[i-1])/(m_xData[i+1]-m_xData[i-1]);
		p=sig*m_dDerivatives[i-1]+2.0;
		if (p == 0.0) {
			CAnalysisExceptionBase* pe = new CAnalysisExceptionBase(szDivideByZero);
			throw pe;
		}
		m_dDerivatives[i]=(sig-1.0)/p;
		u[i]=(m_yData[i+1]-m_yData[i])/(m_xData[i+1]-m_xData[i]) - (m_yData[i]-m_yData[i-1])/(m_xData[i]-m_xData[i-1]);
		u[i]=(6.0*u[i]/(m_xData[i+1]-m_xData[i-1])-sig*u[i-1])/p;
	}
	if (m_bLastNatural)
		qn=un=0.0;
	else {
		qn=0.5;
		un=(3.0/(m_xData[n]-m_xData[n-1]))*(m_dLastDer-(m_yData[n]-m_yData[n-1])/(m_xData[n]-m_xData[n-1]));
	}
	m_dDerivatives[n]=(un-qn*u[n-1])/(qn*m_dDerivatives[n-1]+1.0);
	for (k=n-1;k>=1;k--)
		m_dDerivatives[k]=m_dDerivatives[k]*m_dDerivatives[k+1]+u[k];
}


void CSpline::CalculateY(double x, double *y)
{
	int klo,khi,k;
	double h,b,a;
	*y = 0.0;
	int n = m_yData.Size();		// array bounds should have been checked before (in ctor, etc.)
	if ( n < 2 ) return;

	klo=1;					// hardcoded 1 based index
	khi=n;					// nsize == nhigh
	// assume x array in in asending order to find. Then this while loop shouldn't
	// looping forever
	while (khi-klo > 1) {					// 
		k=(khi+klo) >> 1;					// try the middle point 
		if (m_xData[k] > x) khi=k;			// x is between klow and k
		else klo=k;							// x is between k and khi
	}										// when the loop ends, we should have khi - klo == 1
	// validate khi and klo found above
	if ( khi > n || klo < 1 ) {
		throw new CAnalysisExceptionBase(szArrayBounds);
		return;
	}
	h=m_xData[khi]-m_xData[klo];
	if (h == 0.0) {							// since x array is in asending order, this should not happen
		CAnalysisExceptionBase* pe = new CAnalysisExceptionBase(szDivideByZero);
		throw pe;
	}
	a=(m_xData[khi]-x)/h;
	b=(x-m_xData[klo])/h;
	*y=a*m_yData[klo]+b*m_yData[khi]+((a*a*a-a)*m_dDerivatives[klo]+(b*b*b-b)*m_dDerivatives[khi])*(h*h)/6.0;
}

//callee release 
BOOL CSpline::GetSplinedData(SAFEARRAY** ppsa) const	//watch out for object life time
{
	BOOL bret = FALSE;

	if ( ppsa && m_psaYSplinedData )
	{
		*ppsa = NULL;
		SAFEARRAYBOUND sabnd;
		long llow = 0, lhigh = 0;
		SafeArrayGetLBound(m_psaYSplinedData,1,&llow);
		SafeArrayGetUBound(m_psaYSplinedData,1,&lhigh);

		ValidateBounds(lhigh,llow);

		sabnd.cElements = lhigh - llow + 1;
		sabnd.lLbound   = llow;
		HRESULT hr;
		//use r8
		*ppsa = SafeArrayCreate(VT_R8,1,&sabnd);
		hr = SafeArrayCopy(m_psaYSplinedData,ppsa);

		if ( !FAILED(hr) )bret = TRUE;
		else {
			throw new CAnalysisExceptionBase(szMemFailed);
		}
	}
	return bret;
}

BOOL CSpline::GetSplinedData(CVector<double>& SplinedData) const
{
	long llow = 0, lhigh = 0;
	SafeArrayGetLBound(m_psaYSplinedData,1,&llow);
	SafeArrayGetUBound(m_psaYSplinedData,1,&lhigh);
	ValidateBounds(lhigh,llow);
	int nsize = lhigh - llow + 1;
	SplinedData.Resize(nsize,1); // 1 based

	double * py = 0;
	HRESULT hr;
	int iIndex = 0;

	hr = SafeArrayAccessData(m_psaYSplinedData,(void**)&py);
	if ( FAILED(hr) ) {
		CAnalysisExceptionBase* pe = new CAnalysisExceptionBase(szMemFailed);
		throw pe;
	}
	// 
	for ( int i = 1; i <= nsize; i++ )
	{
		if ( iIndex <= nsize )		// iIndex is zero based
		{
			// safe array index should be valid
			SplinedData[i] = py[iIndex];
			iIndex++;
		}
	}

	hr = SafeArrayUnaccessData(m_psaYSplinedData);
	if ( FAILED(hr) ) {
		CAnalysisExceptionBase* pe = new CAnalysisExceptionBase(szMemFailed);
		throw pe;
	}

	return TRUE;
}


SAFEARRAY**  CSpline::GetSplinedData()
{
	return &m_psaYSplinedData;
}

BOOL CSpline::Interpolate()
{
	BOOL bret = FALSE;
	const UINT nlow = m_yData.LowBounds();
	const UINT nhigh = m_yData.HighBounds();
	ValidateBounds(nhigh,nlow);
	
	SAFEARRAYBOUND sabnd;
	sabnd.lLbound = 1;			//	hardcoded low bound, 1 based
	
	long lElements = (nhigh - nlow + 1)*(m_nIntPoints+1);
	sabnd.cElements = lElements;
	ASSERT(NULL == m_psaYSplinedData);
	m_psaYSplinedData = SafeArrayCreate(VT_R8,1,&sabnd); //double data type

	if ( m_psaYSplinedData ) 
	{
		double * py = 0;
		double x = 0, y = 0;
		HRESULT hr;
		hr = SafeArrayAccessData(m_psaYSplinedData,(void**)&py);
		if ( FAILED(hr) ) {
			CAnalysisExceptionBase* pe = new CAnalysisExceptionBase(szMemFailed) ;
			throw pe;
		}
		UINT  i = 0, j = 0, k = 0,nCounter = 0, nMarker = 0;
		// For the first data point, no interpolation of the data. So
		// they will have the value of m_yData[nlow]
		//
		//j index matches lLbound;
		for ( j=1; j <= m_nIntPoints; j++ ) 
		{
			//0 based index for direct access
			py[j-1] = m_yData[nlow];
			
		}
		//nCounter counts how may data points have been defined for the safe array and serves as
		//a counter to verify operations below
		nCounter = m_nIntPoints;

		for ( i = nlow; i <= nhigh; i++ )
		{
			//this expression matches that in CalculatX(). It is this express which determines where to
			//put the original data points in our interpolated array. If m_nIntPOints = 1, they are at:
			//No. 2,4,6, if m_nInitPoints = 2, at 3,6,9,...
			//We fill the data belong to original data first
			nMarker = (i - nlow + 1 ) *  (m_nIntPoints + 1);
			// 
			// mark the position in the interpolated array and starts with the position of
			// the i-th original data point (and we are going to interpolate between data points
			// at i and i-1 (see below)
			// 
			//nMarker = k;			// 
			y = m_yData[i];			// get the original data points
			py[nMarker - 1] = y;			// Original data. index to py is zero based !!!! 
			nCounter++;				// 
			//
			//interpolated data. If we double the data points, then the interpolated data are
			//No. 1,3,5 ..., original data points are  No. 2,4,6,....
			//however, for py array, the index is zero based. So the py index is 1 off
			//
			if ( i > nlow ) {	//no extrapolation for the first data point. It's done above!

				for ( j = 1; j <= m_nIntPoints; j++ ){
					/////////////////////////////////////////////////////////////////
					// Minus sign for j ! we are trying to interpolate data between
					// i-1 and i (not i and i + 1 ) !!!
					//
					///////////////////////////////////////////////////////////////////
					k = nMarker - j ; // if m_nIntPoints = 1, k points to 1,3,5 ...				
					//
					// note that we have to use 1 based notion to denote x value since the original
					// NRC routine assumes all the arrays are 1 based. But to direct access safe array 
					// we have to use zero index
					//
					x = (double)k;
					CalculateY(x,&y);
					//
					//y pin to 0.0 for counting experiment
					if ( y < 0.0 ) y = 0.0;

					if (  k > lElements ) {			// == is OK since it's 1 based index
						throw new CAnalysisExceptionBase(szArrayBounds);
					}

					py[k - 1] = y;		//note that index start from 0. 
					nCounter++;
				}
			}
			// Do we realy splined data?
			bret = TRUE;
		}

		hr = SafeArrayUnaccessData(m_psaYSplinedData);

		if ( FAILED(hr)  || nCounter != lElements) {
			throw  new CAnalysisExceptionBase(szMemFailed) ;	// if we get here, we ran over array boundary somewhere
		}
	}	
	return bret;
}

void CSpline::CalculateX()
{
	int nlow = m_yData.LowBounds();
	int nhigh = m_yData.HighBounds();
	ValidateBounds(nhigh,nlow);

	//If we have 512 channels, we end up with (m_nIntPoints + 1 ) * 512 channels
	//note that m_nIntPoints is how many points to insert between
	ASSERT (m_nIntPoints <= 8 );		//not likely to insert more than 8 data points between
	//
	int nsize = nhigh - nlow + 1;
	m_xData.Resize(nsize,nlow);		// nlow == 1
	//note that there are m_nIntPoints  low points to be extroplated, not interpolated

	for ( int i=nlow; i<= nhigh; i++)	{
		//
		///////////////////////////////////////////////////////////////////////////////////////
		//
		// Please note that if m_nIntPoints = 1, they original data points are
		// at x = 2, 4, 6, ..., and if m_nIntPoints = 2, x = 3, 6, 9, .... So in effect here
		// we have place the corresponding y data points at the location of the interpolated
		// x position along the x -axis
		//
		///////////////////////////////////////////////////////////////////////////////////////
		//
		m_xData[i] = (i - nlow + 1 ) *  (m_nIntPoints + 1) ;
	}
}

void CSpline::WriteIntData()
{
	//
	char fname[16] = _T("spline.out");
	FILE* pFile;
	if ( (pFile = fopen(fname,"w")) == NULL ) {
			assert(false);
			exit (0);
		}
	int nCol = 2;
	fprintf(pFile,"%d\n",nCol);
	double  x = 0, y = 0;
	double *py = 0;

	SafeArrayAccessData(m_psaYSplinedData,(void **)&py);

	long  llow,lhigh;
	SafeArrayGetUBound(m_psaYSplinedData,1,&lhigh);
	SafeArrayGetLBound(m_psaYSplinedData,1,&llow);

	for ( long i=llow; i <= lhigh; i++ )
	{
		x = i;
		//array is zero based !
		y = py[i - llow];
		fprintf(pFile,"%6.0f\t%10.3f\n",x,y);
	}
	fclose(pFile);
	SafeArrayUnaccessData(m_psaYSplinedData);
}

void CSpline::ScaleSpectrumHeight()
{
	//typically, use a multiplier to enhance the spectrum height before
	//applying cubic spline to the data set
	int nhigh = m_yData_in.HighBounds();
	int nlow  = m_yData_in.LowBounds();
	ValidateBounds(nhigh,nlow);		// assume nlow == 1
	double y = 0;
	for ( int i = nlow; i <= nhigh; i++ )
	{
		m_yData[i]  = m_yData_in[i] * m_dHeightScaleFactor;
	}
}