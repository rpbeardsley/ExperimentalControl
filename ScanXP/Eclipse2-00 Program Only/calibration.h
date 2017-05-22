#if !defined(AFX_CCALIBRATION_H__E9F88354_E80B_11D1_912F_0060089615C2__INCLUDED_)
#define AFX_CCALIBRATION_H__E9F88354_E80B_11D1_912F_0060089615C2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000
// CCalMath.h : header file
//

#include <math.h>

static double at,bt,ct;
static double maxarg1,maxarg2;

#define MAXCOEFS    5
#define SPREAD      (0.20) /*(0.020)*/

#define PYTHAG(a,b) ((at=fabs(a)) > (bt=fabs(b)) ? \
                    (ct=bt/at,at*sqrt(1.0+ct*ct)) : \
                    (bt ? (ct=at/bt,bt*sqrt(1.0+ct*ct)): 0.0))
#define MAX(a,b)    (maxarg1=(a),maxarg2=(b),(maxarg1) > (maxarg2) ?\
                    (maxarg1) : (maxarg2))
#define SIGN(a,b)   ((b) >= 0.0 ? fabs(a) : -fabs(a))

#define MAX_TT          64          /* Maximum number of points       */

enum ECalType
{
	Linear = 0,
	Quadratic = 1,
	Cubic = 2
};

class CMkrInfo : public CObject
{
protected:

	DECLARE_SERIAL(CMkrInfo)
	
public:

	
	virtual void Serialize(CArchive& ar);

	double m_dStartMkrTime;
	double m_dEndMkrTime;
	double m_dCentroidTime;
	double m_dCalValue;
};

class CCalibration : public CCmdTarget
{
protected:

	DECLARE_SERIAL(CCalibration)

public:	

	//Allow to "Calibrate" from the constructor if desired
	CCalibration(ECalType eType = Linear, int iNumPoints = 0, CMkrInfo* psMkrInfo = NULL);

	//Allow the Chi-Square to be retrieved
	virtual double GetChiSquare(){return m_dChiSquare;}

	//This method applies the "Current" calibration to the provided data (must be array of doubles)
	virtual bool Apply(VARIANT* pvaData);

	//This method performs the fit, produces the coefficients and Chi-Square
	virtual void Calibrate(ECalType eType, int iNumPoints, CMkrInfo* psMkrInfo);
	
	virtual void Calibrate(ECalType eType, double dCoef1, double dCoef2, double dCoef3, double dCoef4);

	virtual void SetUnitsText(CString str){m_sUnits = str;}
	virtual CString GetUnitsText(){return m_sUnits;}

	virtual void SetFileName(CString str){m_sFileName = str;}
	virtual CString GetFileName(){return m_sFileName;}

	virtual void SetFilePath(CString str){m_sFilePath = str;}
	virtual CString GetFilePath(){return m_sFilePath;}

	virtual int GetNumOfValues(){return m_iNumPoints;}
	virtual CMkrInfo* GetMarkerInfo(int idx){return &m_Mkr[idx];}
	virtual ECalType GetCalType(){return m_eType;}

	virtual double GetCoef1(){return m_dCoef1;}
	virtual double GetCoef2(){return m_dCoef2;}
	virtual double GetCoef3(){return m_dCoef3;}
	virtual double GetCoef4(){return m_dCoef4;}

	double m_dOrgMinValue;
	double m_dOrgMaxValue;



private:

	double PolyFit(int, int, double*, double*, double*);

	static void  svdfit( double *x, double *y,
                     double *sig, int ndata, double *a,
                     int ma, double u[MAX_TT+1][MAXCOEFS+1],
                     double v[MAXCOEFS+1][MAXCOEFS+1], double *w,
                     double *chisq, void (*funcs)(double,double *,int));

	static void svdcmp( double u[MAX_TT+1][MAXCOEFS+1], int m, int n,
                     double w[MAXCOEFS+1],
                     double v[MAXCOEFS+1][MAXCOEFS+1] );

	static void svbksb( double u[MAX_TT+1][MAXCOEFS+1], double w[MAXCOEFS+1],
                     double v[MAXCOEFS+1][MAXCOEFS+1], int m, int n,
                     double b[MAX_TT+1], double a[MAXCOEFS+1] );

	static void fpoly( double x, double *p, int np );		

	ECalType m_eType;
	int m_iNumPoints;		//Number of valid m_Mkr structs
	CMkrInfo m_Mkr[64];
	
	double m_dCoefs[4];		//Results of calibration are placed here
	double m_dCoef1;
	double m_dCoef2;
	double m_dCoef3;
	double m_dCoef4;
	double m_dChiSquare;

	CString m_sUnits;
	CString m_sFileName;
	CString m_sFilePath;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCalibration)
	public:
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
protected:
	

	// Generated message map functions
	//{{AFX_MSG(CCalibration)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};
////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CCALIBRATION_H__E9F88354_E80B_11D1_912F_0060089615C2__INCLUDED_)

