//***************************************************************************************
//CalibrationTab.cpp : implementation file
//
//	Functions: For details on functions in this file see CalibrationTab.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include "Calibration.h"
#include "Eclipse.h"
#include "MainFrm.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

IMPLEMENT_SERIAL(CCalibration, CCmdTarget, 1)
IMPLEMENT_SERIAL(CMkrInfo, CObject, 1)

//implementation for CMkrInfo class
void CMkrInfo::Serialize(CArchive& ar) 
{
	if (ar.IsStoring())
	{	// storing code
		ar << m_dStartMkrTime << m_dEndMkrTime << m_dCentroidTime << m_dCalValue;
	}
	else
	{	// loading code
		ar >> m_dStartMkrTime >> m_dEndMkrTime >> m_dCentroidTime >> m_dCalValue;
	}
}

BEGIN_MESSAGE_MAP(CCalibration, CCmdTarget)
	//{{AFX_MSG_MAP(CCalibration)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

CCalibration::CCalibration(ECalType eType, int iNumPoints, CMkrInfo* psMkrInfo)
{
	if(eType >= Linear && eType <= Cubic)
	{
		if(iNumPoints > 2)
		{
			if(psMkrInfo != NULL)
			{
				Calibrate(eType, iNumPoints, psMkrInfo);
			}
		}
	}
}

void CCalibration::Calibrate(ECalType eType, int iNumPoints, CMkrInfo* psMkrInfo)
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	if(iNumPoints > 2 && iNumPoints < 65)
	{
	
		m_eType = eType;
		m_iNumPoints = iNumPoints;

		double* pTimes = new double[ m_iNumPoints ];
		double* pValues = new double[ m_iNumPoints ];

		for(int n=0;n < iNumPoints;n++)
		{
			//Transfer info to calibration object
			m_Mkr[n].m_dStartMkrTime = psMkrInfo[n].m_dStartMkrTime;
			m_Mkr[n].m_dEndMkrTime = psMkrInfo[n].m_dEndMkrTime;
			pTimes[n] = m_Mkr[n].m_dCentroidTime = psMkrInfo[n].m_dCentroidTime;
			pValues[n] = m_Mkr[n].m_dCalValue = psMkrInfo[n].m_dCalValue;
		}

		ASSERT(m_eType >= Linear && m_eType <= Cubic);
		ASSERT(pTimes);
		ASSERT(pValues);

		//Call the PolyFit functions (this func provides the coefficients and ChiSquare for us)
		m_dChiSquare = PolyFit( m_eType + 2, m_iNumPoints, pTimes, pValues, &m_dCoefs[0]);

		//Store the coefs for serialization
		m_dCoef1 = m_dCoefs[0];
		m_dCoef2 = m_dCoefs[1];
		m_dCoef3 = m_dCoefs[2];
		m_dCoef4 = m_dCoefs[3];

		delete []pTimes;
		delete []pValues;
	}
	else TRACE(_T("Calibration::Initialize called with invalid number of points to calibrate.\n"));
}
void CCalibration::Calibrate(ECalType eType, double dCoef1, double dCoef2, double dCoef3, double dCoef4)
{
	m_eType = eType;
	m_dCoefs[0] = dCoef1;
	m_dCoefs[1] = dCoef2;
	m_dCoefs[2] = dCoef3;
	m_dCoefs[3] = dCoef4;
}

bool CCalibration::Apply(VARIANT* pvaData)
{
	if(pvaData->vt == (VT_ARRAY | VT_R8) )//Make sure we have an array of doubles
	{
		long lNumPoints = pvaData->parray->rgsabound->cElements;

		if(lNumPoints < 2)
		{
			TRACE(_T("Not enough points to apply calibration.\n"));
			return false;
		}

		double* pData = NULL;
	
		if( FAILED(SafeArrayAccessData(pvaData->parray, (void **)&pData)) )
		{
			TRACE(_T("SafeArrayAccessData failed in CCalibration::Apply\n."));
			return false;
		}
		
		__int64 i64Pt;

		switch(m_eType)
		{
			case Linear:

				for(i64Pt=0;i64Pt<lNumPoints;i64Pt++)
				{
					if(i64Pt == 0)m_dOrgMinValue = pData[i64Pt];
					if(i64Pt == lNumPoints - 1)m_dOrgMaxValue = pData[i64Pt];

					pData[i64Pt] = m_dCoefs[0] + (m_dCoefs[1] * pData[i64Pt]);
				}

			break;

			case Quadratic:

				for(i64Pt=0;i64Pt<lNumPoints;i64Pt++)
				{
					if(i64Pt == 0)m_dOrgMinValue = pData[i64Pt];
					if(i64Pt == lNumPoints - 1)m_dOrgMaxValue = pData[i64Pt];

					pData[i64Pt] = m_dCoefs[0] + pData[i64Pt] * (m_dCoefs[1] + pData[i64Pt] * (m_dCoefs[2]));
				}

			break;

			case Cubic:

				for(i64Pt=0;i64Pt<lNumPoints;i64Pt++)
				{
					if(i64Pt == 0)m_dOrgMinValue = pData[i64Pt];
					if(i64Pt == lNumPoints - 1)m_dOrgMaxValue = pData[i64Pt];

					pData[i64Pt] = m_dCoefs[0] + pData[i64Pt] * (m_dCoefs[1] + pData[i64Pt] * (m_dCoefs[2] + pData[i64Pt] * (m_dCoefs[3])));
				}

			break;
			
			default:

				//Unattach our direct pointers to the data
				if( FAILED(SafeArrayUnaccessData(pvaData->parray)) )
				{
					TRACE(_T("SafeArrayUnaccessData failed in CCalibration::Apply\n"));
				}
				return false;

			break;
		}
		
	
		//Unattach our direct pointers to the data
		if( FAILED(SafeArrayUnaccessData(pvaData->parray)) )
		{
			TRACE(_T("SafeArrayUnaccessData failed in CCalibration::Apply\n"));
			return false;
		}
	}
	else 
	{
		TRACE("VARIANT passed to Apply does not contain an array of doubles.\n");
		return false;
	}


	return true;
}


/*
 * ---------------------------------------------------------------------
 * PolyFit - Execute polynomial fit.
 *
 * Purpose:
 *
 *      This function generates a list of coefficients using the
 *      polynomial fitting routines.
 *
 * Calling Convention:
 *
 *      double PolyFit( nCoefs, nPts, dTimes, dValues, dCoefs )
 *              int      nCoefs;
 *              int      iPts;
 *              double   *dTimes;
 *              double   *dValues;
 *              double   *dCoefs;
 *
 *      nCoefs  =INP=   Number of coefficients to generate.
 *      nPts    =INP=   Number of points in dTimes[] and dValues[].
 *      dTimes  =INP=   X-coordinates (Time).
 *      dValues =INP=   Y-coordinates (Calibrated value).
 *      dCoefs  =OUT=   Resulting coefficients.
 *
 * Returns:
 *		
 *      Chi-Squared fit value.
 *
 * ---------------------------------------------------------------------
 */
double CCalibration::PolyFit( int nCoefs, int nPts, double *dTimes, double *dValues, double *dCoefs )
{
    int    i, j;
    double x[MAX_TT+1], y[MAX_TT+1], sig[MAX_TT+1];
    double v[MAXCOEFS+1][MAXCOEFS+1];
    double u[MAX_TT+1][MAXCOEFS+1];
    double a[MAXCOEFS+1], w[MAXCOEFS+1];
    double YCalc, chisq;


    /*
     * -----------------------------------------------------------------
     * Load x and y arrays with ordered pairs. x[0] and y[0] are not
     * used (this code is just transliterated FORTRAN).
     * -----------------------------------------------------------------
     */
    for ( i = 1; i <= MAX_TT && i <= nPts; i++ )
    {
        x[i] = dTimes[i-1];
        y[i] = dValues[i-1];

        if ( y[i] != 0.0 )
        {
            sig[i] = y[i] * SPREAD;
        }
        else
        {
            sig[i] = SPREAD;
        }
    }

    svdfit( x, y, sig, nPts, a, nCoefs, u, v, w, &chisq, fpoly );

    chisq /= nPts;

    for( i = 1; i <= nCoefs; i++ )
    {
        dCoefs[i - 1] = a[i];
    }

    for ( i = 0; i < nPts; i++ )
    {
        YCalc = dCoefs[ nCoefs - 1 ];
        for ( j = nCoefs - 2; j >= 0; j-- )
        {
            YCalc = YCalc * dTimes[i] + dCoefs[j];
        }

    }

	//m_Cal.dChiSquare = chisq;

    return( chisq );
}



/*
 * ---------------------------------------------------------------------
 * Numerical Recipes Code:
 * ---------------------------------------------------------------------
 */
void  CCalibration::svdfit( double *x, double *y, double *sig, int ndata, double *a,
        int ma, double u[MAX_TT+1][MAXCOEFS+1],
        double v[MAXCOEFS+1][MAXCOEFS+1], double *w, double *chisq,
        void (*funcs)(double,double *,int))
{
    int j,i;
    double tmp,sum,b[MAX_TT+1],afunc[MAXCOEFS+1];


    /*
     * -----------------------------------------------------------------
     * Accumulate coefficients of the fitting matrix
     * -----------------------------------------------------------------
     */
    for ( i = 1; i <= ndata; i++ )
    {
        (*funcs)(x[i], afunc, ma);
        tmp = 1.0 / sig[i];

        for ( j = 1; j <= ma; j++ )
        {
            u[i][j]=afunc[j]*tmp;
        }

        b[i] = y[i]*tmp;
    }

    /*
     * -----------------------------------------------------------------
     * Decompose matrix U into U * W * TRANSPOSE(V)
     * -----------------------------------------------------------------
     */
    svdcmp( u, ndata, ma, w, v );


    /*
     * -----------------------------------------------------------------
     * Solve the remaining equations to produce a fit
     * -----------------------------------------------------------------
     */
    svbksb( u, w, v, ndata, ma, b, a );


    /*
     * -----------------------------------------------------------------
     * Evaluate chi-square
     * -----------------------------------------------------------------
     */
    *chisq = 0.0;

    for ( i = 1; i <= ndata; i++ )
    {
        (*funcs)(x[i], afunc, ma);
        for ( sum = 0.0, j = 1; j <= ma; j++ )
        {
            sum += a[j] * afunc[j];
        }
        *chisq += (tmp = (y[i] - sum) / sig[i], tmp * tmp );
    }

    return;
}



void CCalibration::svdcmp( double a[MAX_TT+1][MAXCOEFS+1], int m, int n,
             double w[MAXCOEFS+1], double v[MAXCOEFS+1][MAXCOEFS+1])
{
    int flag,i,its,j,jj,k,l,nm;
    double c,f,h,s,x,y,z;
    double anorm=0.0,g=0.0,scale=0.0;
    double rv1[MAXCOEFS+1];

    if ( m < n )
    {
        return;
    }
    for ( i = 1; i <= n; i++ )
    {
        l = i + 1;
        rv1[i] = scale * g;
        g = s = scale = 0.0;

        if (i <= m)
        {
            for ( k = i; k <= m; k++ )
                scale += fabs(a[k][i]);

            if ( scale )
            {
                for ( k = i; k <= m; k++ )
                {
                    a[k][i] /= scale;
                    s += a[k][i] * a[k][i];
                }
                f = a[i][i];
                g = -SIGN(sqrt(s), f);
                h = f * g - s;
                a[i][i] = f - g;

                if ( i != n )
                {
                    for ( j = l; j <= n; j++ )
                    {
                        for ( s = 0.0, k = i; k <= m; k++ )
                            s += a[k][i] * a[k][j];

                        f = s / h;
                        for ( k = i; k <= m; k++ )
                            a[k][j] += f * a[k][i];
                    }
                }
                for ( k = i; k <= m; k++ )
                    a[k][i] *= scale;

            }
        }

        w[i] = scale * g;
        g = s = scale = 0.0;
        if ( i <= m && i != n )
        {
            for ( k = l; k <= n; k++ )
                scale += fabs(a[i][k]);

            if ( scale )
            {
                for ( k = l; k <= n; k++ )
                {
                    a[i][k] /= scale;
                    s += a[i][k] * a[i][k];
                }
                f = a[i][l];
                g = -SIGN(sqrt(s), f);
                h = f * g - s;
                a[i][l] = f - g;

                for ( k = l; k <= n; k++ )
                    rv1[k] = a[i][k] / h;

                if ( i != m )
                {
                    for ( j = l; j <= m; j++ )
                    {
                        for ( s = 0.0, k = l; k <=n ;k++ )
                            s += a[j][k] * a[i][k];

                        for ( k = l; k <= n; k++ )
                            a[j][k] += s * rv1[k];
                    }
                }
                for ( k = l; k <= n; k++ )
                    a[i][k] *= scale;
            }
        }
        anorm = MAX(anorm, (fabs(w[i]) + fabs(rv1[i])));
    }

    for ( i = n; i >= 1; i-- )
    {
        if ( i < n )
        {
            if ( g )
            {
                for ( j = l; j <= n; j++ )
                    v[j][i] = (a[i][j] / a[i][l]) / g;

                for ( j = l; j <=n ;j++ )
                {
                    for ( s = 0.0, k = l; k <=n ;k++ )
                        s += a[i][k] * v[k][j];
                    for ( k = l; k <= n; k++ )
                        v[k][j] += s * v[k][i];
                }
            }
            for ( j = l; j <= n; j++ )
                v[i][j] = v[j][i] = 0.0;
        }
        v[i][i] = 1.0;
        g = rv1[i];
        l = i;
    }
    for ( i = n; i >= 1; i-- )
    {
        l = i + 1;
        g = w[i];
        if ( i < n )
            for ( j = l; j <= n; j++ )
                a[i][j] = 0.0;

        if ( g )
        {
            g = 1.0 / g;
            if ( i != n )
            {
                for ( j = l; j <= n; j++ )
                {
                    for ( s = 0.0, k = l; k <= m; k++ )
                        s += a[k][i] * a[k][j];
                    f = (s / a[i][i]) * g;
                    for ( k = i; k <= m; k++ )
                        a[k][j] += f * a[k][i];
                }
            }
            for ( j = i; j <= m; j++ )
                a[j][i] *= g;
        }
        else
        {
            for ( j = i; j <= m; j++ )
                a[j][i] = 0.0;
        }
        ++a[i][i];
    }

    for ( k = n; k >= 1; k-- )
    {
        for ( its = 1; its <=30; its++ )
        {
            flag = 1;
            for ( l = k; l >= 1; l-- )
            {
                nm = l - 1;

                if (((fabs(rv1[l])+anorm) / anorm - 1.0) < 1.0e-23)
                {
                    flag = 0;
                    break;
                }
                if ( fabs(w[nm]) + anorm == anorm )
                     break;
            }
            if ( flag )
            {
                c = 0.0;
                s = 1.0;
                for ( i = l; i <= k; i++ )
                {
                    f = s * rv1[i];
                    if ( fabs(f) + anorm != anorm )
                    {
                        g = w[i];
                        h = PYTHAG(f,g);
                        w[i] = h;
                        h = 1.0 / h;
                        c = g * h;
                        s = (-f * h);
                        for ( j = 1; j <= m; j++ )
                        {
                            y = a[j][nm];
                            z = a[j][i];
                            a[j][nm] = y * c + z * s;
                            a[j][i] = z * c - y * s;
                        }
                    }
                }
            }
            z = w[k];
            if ( l == k )
            {
                if ( z < 0.0 )
                {
                    w[k] = -z;
                    for ( j = 1; j <= n; j++ )
                        v[j][k] = (-v[j][k]);
                }
                break;
            }
            if ( its == 30 )
            {
                return;
            }

            x = w[l];
            nm = k - 1;
            y = w[nm];
            g = rv1[nm];
            h = rv1[k];
            f = ((y - z) * (y + z) + (g - h) * (g + h)) / (2.0 * h * y);
            g = PYTHAG(f,1.0);
            f = ((x - z) * (x + z) + h * ((y / (f + SIGN(g,f))) - h)) / x;
            c = s = 1.0;
            for ( j = l; j <= nm; j++ )
            {
                i = j + 1;
                g = rv1[i];
                y = w[i];
                h = s * g;
                g = c * g;
                z = PYTHAG(f, h);
                rv1[j] = z;
                c = f / z;
                s = h / z;
                f = x * c + g * s;
                g = g * c - x * s;
                h = y * s;
                y = y * c;
                for ( jj = 1; jj <= n; jj++ )
                {
                    x = v[jj][j];
                    z = v[jj][i];
                    v[jj][j] = x * c + z * s;
                    v[jj][i] = z * c - x * s;
                }
                z = PYTHAG(f, h);
                w[j] = z;
                if ( z )
                {
                    z = 1.0 / z;
                    c = f * z;
                    s = h * z;
                }
                f = (c * g) + (s * y);
                x = (c * y) - (s * g);
                for ( jj = 1; jj <= m; jj++ )
                {
                    y = a[jj][j];
                    z = a[jj][i];
                    a[jj][j] = y * c + z * s;
                    a[jj][i] = z * c - y * s;
                }
            }
            rv1[l] = 0.0;
            rv1[k] = f;
            w[k] = x;
        }
    }
}


void CCalibration::svbksb(double u[MAX_TT+1][MAXCOEFS+1], double w[MAXCOEFS+1],
						  double v[MAXCOEFS+1][MAXCOEFS+1], int m, int n, double b[MAX_TT+1],
					      double x[MAXCOEFS+1])
{
    int jj,j,i;
    double s, tmp[MAXCOEFS+1];

    for ( j = 1; j <=n ;j++ )
    {
        s = 0.0;
        if ( w[j] )
        {
            for ( i = 1; i <= m; i++ )
                s += u[i][j] * b[i];

            s /= w[j];
        }
        tmp[j] = s;
    }
    for ( j = 1; j <= n; j++ )
    {
        s = 0.0;
        for ( jj=1; jj <= n; jj++ )
            s += v[j][jj] * tmp[jj];

        x[j] = s;
    }
}

void CCalibration::fpoly(double x,double p[],int np)
{
   int j;

   p[1] = 1.0;
   for ( j = 2; j <= np; j++ )
       p[j] = p[j-1] * x;
}


void CCalibration::Serialize(CArchive& ar) 
{

	if (ar.IsStoring())
	{	// storing code

		int iLength;

		iLength = m_sUnits.GetLength();
		if(iLength < 5)
		{
			//Pad with " "'s to force the CString a fixed length
			for(int n=iLength;n <= 5;n++)
			{
				m_sUnits += _T(" ");
			}
		}

		iLength = m_sFileName.GetLength();

		if(iLength < 255)
		{
			//Pad with " "'s to force the CString a fixed length
			for(int n=iLength;n <= 255;n++)
			{
				m_sFileName += _T(" ");
			}
		}

		iLength = m_sFilePath.GetLength();

		if(iLength < 1024)
		{
			//Pad with " "'s to force the CString a fixed length
			for(int n=iLength;n <= 1024;n++)
			{
				m_sFileName += _T(" ");
			}
		}

		WORD wType = (WORD)m_eType;
		ar << wType << m_iNumPoints << m_dCoef1 << m_dCoef2 << m_dCoef3 << m_dCoef4 << m_sUnits << m_sFileName
		   << m_dOrgMinValue << m_dOrgMaxValue;
	}
	else
	{	// loading code
		WORD wType;
		ar >> wType >> m_iNumPoints >> m_dCoef1 >> m_dCoef2 >> m_dCoef3 >> m_dCoef4 >> m_sUnits >> m_sFileName
		   >> m_dOrgMinValue >> m_dOrgMaxValue;
		m_eType = (ECalType)wType;

		//Now remove the padding!
		m_sUnits.TrimRight();
		m_sFileName.TrimRight();
		m_sFilePath.TrimRight();
	}

	//Now store/load the Marker info
	for(int n=0;n < 64;n++)
	{
		m_Mkr[n].Serialize( ar );

	}
}
