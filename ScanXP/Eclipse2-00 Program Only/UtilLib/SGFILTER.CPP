//S-G digital filter SGFilter.cpp
#include "stdafx.h"
#include "SGFilter.h"
#include "NumericExceptionEnable.h"


CSGFilter::CSGFilter(CVector<double>& yData)
: m_yData(yData),
  m_nMoment(0),
  m_nLeft(0),
  m_nRight(0)
{

}

CSGFilter::~CSGFilter()
{
	
}

void CSGFilter::SetYData()
{
	int nSize = m_yData.Size();
	// why this assert wont work in release when failed outside ATL?
	assert ( nSize >= 5 );
	m_ySGData.Resize(nSize,1);
	// set to the original data in case cannot smooth the data. 
	m_ySGData = m_yData;

	m_SGC.Resize((m_nLeft + m_nRight + 1),1);
}


void CSGFilter::SmoothBegin()
{
	int i,j,k,nSize;
	//m_nRight = 16;
	double dTmp = 0, y = 0;
	double coeff = 0;
	int nLeft = 0;

	for ( i=1; i<=m_nLeft; i++ )
	{
		nLeft		= i-1;
		nSize		= m_nRight +  nLeft + 1;
		dTmp = 0;
		savgol(m_SGC,nSize,nLeft,m_nRight,0,m_nMoment);
		//do the averaging
		for ( j = -nLeft; j <= m_nRight; ++j )
		{
			if ( j <= 0 )	k = 1 + abs(j);
			else			k =	nSize + 1 - j;
			coeff  = m_SGC.At(k);
#ifdef _DEBUG
			y		=  m_yData.At(j + i);
			dTmp	+= y * coeff;
#else
			dTmp	+= m_yData.At(j + i)*(coeff);
#endif
		}
		m_ySGData.At(i) = dTmp;
	}	
}

void CSGFilter::DoIt()
{
	try
	{
		SmoothBegin();
		SmoothEnd();
		Smooth();
	}

	catch (...)

	{

#ifdef _DEBUG

#ifdef _AV_ANALYSIS_DLL
		TRACE("Error encountered during data smoothing");
#endif

#endif

	}
}

void CSGFilter::SmoothEnd()
{
	int i,j,k,nSize;
	int nPoints = m_yData.Size();
	int nRight = 0;

	for ( i=nPoints; i>=nPoints - m_nRight; i-- )
	{
		nRight = nPoints - i;
		nSize = m_nLeft +  nRight + 1;
		savgol(m_SGC,nSize,m_nLeft,nRight,0,m_nMoment);
		//do the averaging
		for ( j = -m_nLeft; j <= nRight; j++ )
		{
			if ( j <= 0 )	k = 1 + abs(j);
			else			k =	nSize + 1 - j;

			m_ySGData.At(i) +=	(m_yData.At(j + i))*m_SGC.At(k);
		}
	}	
}

void CSGFilter::Smooth()
{
	int i,j,k,nSize;
	nSize		= m_nLeft + m_nRight + 1;

	double nTmp = 0, coeff = 0;

	int nPoints = m_yData.Size();
	
	savgol(m_SGC,nSize,m_nLeft,m_nRight,0,m_nMoment);

	for ( i=m_nLeft + 1; i<=nPoints - m_nRight - 1; ++i )
	{
		nTmp = 0;
		//do the averaging
		for ( j = -m_nLeft; j <= m_nRight; ++j )
		{
			if ( j <= 0 )	k = 1 + abs(j);
			else			k =	nSize + 1 - j;

			nTmp += (m_yData[j + i])*m_SGC[k];
			coeff = m_SGC[k];
		}
		m_ySGData[i] =	nTmp;
	}	
}

bool CSGFilter::SmoothAllDataPoints()
{
	bool bret = CalculateLeftRightPoints();

	if ( bret )
	{
		//Set data first
		SetYData();
		DoIt();
		bret = true;
	}
	return bret;
}

bool CSGFilter::CalculateLeftRightPoints()
{
	///////////////////////////////////////////////////////////////////////////////
	//
	// This routine calculates the left, right and moment based on
	// the number of data points available
	//
	// Minimum number of data points:
	//
	//		nLeft + nRight + 1
	//
	////////////////////////////////////////////////////////////////////////////////
	//

	int nPoints = m_yData.Size();

	if ( nPoints < 5 )
	{
		return false;
	}
	 else if ( nPoints >= 5 && nPoints < 33)
	{
		m_nLeft = 2;
		m_nRight = 2;
		m_nMoment = 2;
	}
	else
	{
		m_nLeft = 5;
		m_nRight = 5;
		m_nMoment = 3;
	}
	return true;
}


bool CSGFilter::SmoothAllDataPoints(int nLeft, int nRight, int m)
{
	int nDataPoints = this->m_yData.Size();
	bool bret = false;
	if ( nLeft + nRight + 1 >= nDataPoints || nLeft + nRight > 32)
	{
		// no enough data points to do the work, or try to include to many points
		return bret;
	}

	if ( nLeft >= 0 || nRight >= 0  ) 
	{
		m_nLeft		= nLeft;
		m_nRight	= nRight;
		m_nMoment	= m;

		//Set data first
		SetYData();
		DoIt();
		bret = true;
	}
	return bret;
}
void CSGFilter::savgol(CVector<double>& c, int np, int nl, int nr, int ld, int m)
{
	int imj,ipj,j,k,kk,mm;
	double d,fac,sum;
   
	//if (np < nl+nr+1 || nl < 0 || nr < 0 || ld > m || nl+nr < m)
	//nrerror("bad args in savgol");
	CVector<int> indx( m+1, 1 );
	CVector<double> b( m+1, 1 );
	CMatrix<double> a( m+1, m+1, 1);
	for (ipj=0;ipj<=(m << 1);ipj++) 
	{
		sum=(ipj ? 0.0 : 1.0);
		for (k=1;k<=nr;k++) sum += pow((double)k,(double)ipj);
		for (k=1;k<=nl;k++) sum += pow((double)-k,(double)ipj);
		mm=_MIN(ipj,2*m-ipj);
		for (imj = -mm;imj<=mm;imj+=2) a[1+(ipj+imj)/2][1+(ipj-imj)/2]=sum;

	}
	ludcmp(a,m+1,indx,&d);
	for (j=1;j<=m+1;j++) b[j]=0.0;
	b[ld+1]=1.0;
	lubksb(a,m+1,indx,b);
	for (kk=1;kk<=np;kk++) c[kk]=0.0;
	for (k = -nl;k<=nr;k++) {
		sum=b[1];
		fac=1.0;
		for (mm=1;mm<=m;mm++) sum += b[mm+1]*(fac *= k);
		kk=((np-k) % np)+1;
		c[kk]=sum;
	}
}

void CSGFilter::lubksb(CMatrix<double>& a, int n, CVector<int>& indx, CVector<double>& b)
{
	int i,ii=0,ip,j;
	double sum;
   
	for (i=1;i<=n;i++) {
		ip=indx[i];
		sum=b[ip];
		b[ip]=b[i];
		if (ii)
			for (j=ii;j<=i-1;j++) sum -= a[i][j]*b[j];
		else if (sum) ii=i;
		b[i]=sum;
	}
	for (i=n;i>=1;i--) {
		sum=b[i];
		for (j=i+1;j<=n;j++) sum -= a[i][j]*b[j];
		b[i]=sum/a[i][i];
	}
}

#define TINY 1.0e-20;
   
void CSGFilter::ludcmp(CMatrix<double>& a, int n, CVector<int>& indx, double *d)
{
	int i,imax = 0,j,k;
	double big,dum,sum,temp;
   
	CVector<double> vv(n,1);
	*d=1.0;
	for (i=1;i<=n;i++) {
		big=0.0;
		for (j=1;j<=n;j++)
			if ((temp=fabs(a[i][j])) > big) big=temp;
//		if (big == 0.0) nrerror("Singular matrix in routine ludcmp");
		vv[i]=1.0/big;
	}
	for (j=1;j<=n;j++) {
		for (i=1;i<j;i++) {
			sum=a[i][j];
			for (k=1;k<i;k++) sum -= a[i][k]*a[k][j];
			a[i][j]=sum;
		}
		big=0.0;
		for (i=j;i<=n;i++) {
			sum=a[i][j];
			for (k=1;k<j;k++)
				sum -= a[i][k]*a[k][j];

				a[i][j]=sum;

			if ( (dum=vv[i]*fabs(sum)) >= big) {
				big=dum;
				imax=i;
			}
		}
		if (j != imax) {
			for (k=1;k<=n;k++) {
				dum=a[imax][k];
				a[imax][k]=a[j][k];
				a[j][k]=dum;
			}
			*d = -(*d);
			vv[imax]=vv[j];
		}
		indx[j]=imax;
		if (a[j][j] == 0.0) a[j][j]=TINY;
		if (j != n) {
			dum=1.0/(a[j][j]);
			for (i=j+1;i<=n;i++) a[i][j] *= dum;
		}
	}
}
#undef TINY
