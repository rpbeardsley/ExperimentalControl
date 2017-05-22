//marqplus.h
#ifndef _INC_MARQBASE_H
#define _INC_MARQBASE_H

#include "MarqResults.h"
class CNumericExceptionsEnable;
#include "vector.h"
#include "Matrix.h"

///////////////////////////////////////////////////////////////////////////////////
//
//		This is the class which implements Marquardt non-linear fitting. Reference:
//
//		Numerical Recipe, 2nd ed.
//
//
//		Derived class should handle which function to fit, the initial fit parameter  calculations, etc.
//
//
/////////////////////////////////////////////////////////////////////////////////////

class CMarqbase {

public:

	enum ROBUST_METHOD
	{
		LSQUARE,ABSDEV,ABSAREAS,PEARSON7
	}; 
	//
	//	ctors
	//
	CMarqbase();
	CMarqbase(const CVector<double>& xData,const CVector<double>& yData,const CVector<double>& Sigma);

protected:	
	// force to instantiate a derived class
	virtual ~CMarqbase();

public:
	// call this one to insert one data point at a time
	void PushBackDataPoint(double dX, double dY, double dSigma, bool bValidate = false);
	bool RemoveADataPoint(double  dX, double dY);
	// call this one to insert the data array
	void SetData(const CVector<double>& xData,const CVector<double>& yData,const CVector<double>& Sigma);

	void SetFitCtrlParameters(int   nMaxIterations,
							float  fChiSquarePrecision,
							float  fInitLamda,
							float  fLamdaMult,
							float  fTimeOut);	

	void SetInitialFitParameters(const CVector<double>& FitParameters);

	void SetFitParameterTags(const CVector<int>& tags);

	void SetRobustMethod(ROBUST_METHOD eRobustMethod_In);

	void SetTotalNumberOfPeaks(int nPeaks);

	void SetSigmaConfidenceLevel(double dLevel) {m_dChi2ConfidenceLevel = dLevel; }

	////when the chi-square is not converge, what's the criteria to accpet the fit anyway
	void SetAcceptedChiSquareNonConverge(double d) { if ( d > 0 ) m_dAcceptedChiSquareNonConverge = d;}
	double GetAcceptedChiSquareNonConverge() const { return m_dAcceptedChiSquareNonConverge;}
	void SetInterpolatedPoints(UINT n) { if ( n > 0 ) m_nIntPoints = n;}

	////////////////////////////////////////////////////////////////////////////////////////////
	//
	//	Do the fit and return the results
	//
	///////////////////////////////////////////////////////////////////////////////////////////
	//

	const CMarqResult Marqminimize() ;

	// get results
	void	OutputResults(CMarqResult* presults);

protected:
	//
	// Define the fit function interface
	//
	
	virtual void CalculateFitValues(double				xValue,
									CVector<double>&	aFitParam,
									double&				yValue,
									CVector<double>&	aDyOverDa) const = 0;

	virtual bool			ValidateData();
	virtual bool			ValidateDataPoint(double dX, double dY, double dSigma);
	// When both dEpsilonX == 0.0 and dEpsilonY == 0.0 this function is the same as RemoveADataPoint();
	virtual bool			RemoveAPointAllowTolerance(double  dX,double dY,  double dEpsilonX = 0.0, double dEpsilonY = 0.0);
	virtual bool			AreFitParametersValid();
	virtual void			Init();
	virtual bool			CalculateMisc();	
	const CMarqResult		OutputResults();
	void					GetResults(CMarqResult& MyResults);
	void					SetCanFit(bool b) { m_bCanFit = b;}

	CVector<double>		m_xData;
	CVector<double>		m_yData;
	CVector<double>		m_sigma;
	CVector<double>		m_aFitParam;
	CVector<double>		m_aFitParamUnc;
	CVector<double>		m_aBeta;
	CVector<int>		m_aFitParamTag;		// 0 for free parameter and 1 to hold the parameter as it is
	double				m_lamda,m_lamdaMult;
	ROBUST_METHOD		eRobustMethod;
	double				m_dReducedChiSquare;
	double				m_dChiSquarePrecision;
	int					m_nMaxMarqIter;		//Maximum number of Marquardt iterations	
	int					m_nData,m_nTotalParam,m_nFreeParam,m_nChisqConvged;	
	int					m_nMarqIterations, m_nPeaks;
	bool				m_bCanFit;
	double				m_dTimeOutPerPeak;
	double				m_dAcceptedChiSquareNonConverge; //when the chi-square is not converge, what's the criteria to accpet the fit anyway
	UINT				m_nIntPoints;	//how many points have been interpolated
	double				m_dChi2ConfidenceLevel;	// use how many sigma 

	CNumericExceptionsEnable* m_pMathExceptionEnable;
	//
	/////////////////////////////////////////////////////////////////////////
	//
	//	Core functions for marquardt fit
	//
	//////////////////////////////////////////////////////////////////////////
	//
	virtual void covsrt(CMatrix<double>&	tCovar,
				int							nTotalParam,
				CVector<int>   				aFitParamTag_In,
				int							nFreeParam);

	virtual	void CMarqbase::gaussj(
				CMatrix<double>&			tAlphaInCoVarianceOut,
				int							nFreeParam,
				CMatrix<double>&			tBetaInDeltaAOut,
				int							nBetaColHiBound);

	virtual void mrqcof(CVector<double>&	aFitParam_In,
				CMatrix<double>&			tAlpha_Out,
				CVector<double>&			aBeta_Out,
				double& 					dChiSquare_Out,
				ROBUST_METHOD				eRobustMethod);

	void		PreventOverUnderFlows(double&  d); //note that pass by reference

	//no copy and assign
	CMarqbase(const CMarqbase&);
	CMarqbase& operator = (const CMarqbase&);
};

#endif
