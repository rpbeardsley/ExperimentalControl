//class for implementing the Levenburg-Marquardt non-linear fitting
// MarqPlus.cpp
#include "stdafx.h"
#include <assert.h>
#include "math.h"
#include "marqbase.h"
#include "matrix.h"
#include "SchFitException.h"
#include "NumericExceptionEnable.h"
#include <time.h>


#define SWAP(a,b){ double temp=(a);(a)=(b);(b)=temp;}

CMarqbase::CMarqbase()
{
	Init();
}

CMarqbase::CMarqbase(const CVector<double>& xData,const CVector<double>& yData,const CVector<double>& Sigma)
:	m_xData(xData),
	m_yData(yData),
	m_sigma(Sigma)
{
	Init();
}

void CMarqbase::Init()
{
	m_lamda							= 0.001;
	m_lamdaMult						= 10;
	m_nMaxMarqIter					= 100;
	m_nChisqConvged					= 2;	
	eRobustMethod					= LSQUARE;
	m_dChiSquarePrecision			= 0.01;
	m_dReducedChiSquare				= 0;
	m_nData							= 0;
	m_nTotalParam					=0;
	m_nFreeParam					= 0;
	m_nMarqIterations				= 0;
	m_nPeaks						= 1;
	m_nIntPoints					= 0;
	m_bCanFit						= false;
	m_dTimeOutPerPeak				= 30.000;		//in seconds
	m_dAcceptedChiSquareNonConverge = 10.0;
	m_dChi2ConfidenceLevel			= 1.0; // use 1.96 for 95% confidence level

	m_pMathExceptionEnable = new CNumericExceptionsEnable(true);
}

CMarqbase::~CMarqbase()
{
	delete m_pMathExceptionEnable;
}

void CMarqbase::PushBackDataPoint(double dX, double dY, double dSigma, bool bValidate)
{
	bool bGoodData = true;
	if ( bValidate ) bGoodData =  ValidateDataPoint(dX, dY, dSigma);
	if ( bGoodData )
	{
		m_xData.Push_Back(dX);
		m_yData.Push_Back(dY);
		m_sigma.Push_Back(dSigma);
	}
}

bool CMarqbase::RemoveADataPoint(double  dX, double dY)
{
	bool bret = false;
	int n1 = m_xData.Find(dX);
	int n2 = m_yData.Find(dY);
	if ( n1 != -1 && n2 != -1 && n1 == n2 ) {	// if it's a valid data point
		m_xData.Remove(n1);
		m_yData.Remove(n1);
		m_sigma.Remove(n1);
		bret = true;
	}
	return bret;
}

bool CMarqbase::RemoveAPointAllowTolerance(double  dX, double dY, double dEpsilonX, double dEpsilonY)
{
	// Using the Find() method from the STL container requires exact match of the values, for example, to find a value of 0.001,
	// we have to have an element of 0.0010000 (how many significant digits we have ). Here, we used
	// an algorithm with tolerance to find it.  
	//
	// To find x only, set dEpsilonY = -1.0
	// To find y only, set dEpsilonX = -1.0;

	int n1 = -1, n2 = -1, nRemove = -1, i = 0, nsize = -1;
	bool bret = false;
	if ( dEpsilonX >= 0.0 ) {
		nsize = m_xData.Size();
		for ( i = 1; i <= nsize; i++ ) {
			if ( fabs(dX - m_xData[i]) <= dEpsilonX ) {
				n1 = i;
				break;
			}
		}
	}
	if ( dEpsilonY >= 0.0 ) {
		nsize = m_yData.Size();
		for ( i = 1; i <= nsize; i++ ) {
			if ( fabs(dY - m_yData[i]) <= dEpsilonY ) {
				n2 = i;
				break;
			}
		}
	}
	if ( dEpsilonX >= 0.0 && dEpsilonY >= 0.0 ) {
		// requires finding both elements
		if ( n1 == n2 && n1 > 0 )  nRemove = n1;
	} else if ( dEpsilonY < 0.0 ) {
		if ( n1 > 0 ) nRemove = n1;
	} else if ( dEpsilonX < 0.0 ) {
		if ( n2 > 0 ) nRemove = n2;
	}

	if ( nRemove > 0 ) {
		m_xData.Remove(nRemove);
		m_yData.Remove(nRemove);
		m_sigma.Remove(nRemove);
		bret = true;
	}
	return bret;
}

bool CMarqbase::ValidateDataPoint(double dX, double dY, double dSigma)
{
	// derived class should do more specific validations
	if ( dSigma <= 0 ) return false;
	else return true;
}

void CMarqbase::SetData(const CVector<double>& xData,const CVector<double>& yData,const CVector<double>& Sigma)
{
	m_xData = xData;
	m_yData = yData;
	m_sigma = Sigma;
	
	ValidateData();
}

bool CMarqbase::ValidateData()
{
	bool bret = false;

	int nsizex = m_xData.Size();
	int nsizey = m_yData.Size();
	int nsizes = m_sigma.Size();

	if ( nsizex == nsizey && nsizex == nsizes)
	{
		bret = true;
	}
	else
	{
		throw CSchFitException(CSchFitException::DATA_SIZE_MISMATCH);			
	}
	m_nData = nsizex;
	return bret;
}

void CMarqbase::SetInitialFitParameters(const CVector<double>& FitParameters)
{
	m_aFitParam = FitParameters;
}

void CMarqbase::SetFitParameterTags(const CVector<int>& tags)
{
	m_aFitParamTag = tags;
}

void CMarqbase::SetTotalNumberOfPeaks(int nPeaks)
{
	if ( nPeaks > 0 )
	{
		m_nPeaks = nPeaks;
	}
}

bool CMarqbase::CalculateMisc()
{
	m_nTotalParam	= m_aFitParam.Size();

	if ( m_nTotalParam != m_aFitParamTag.Size() )
	{
		throw CSchFitException(CSchFitException::DATA_SIZE_MISMATCH);				
	}
	if (  m_nPeaks > 0 )
	{
		//set the size for other arrays
		m_aFitParamUnc.Resize(m_nTotalParam,1);
		m_aBeta.Resize(m_nTotalParam,1);
		for ( int i=1; i<=m_nTotalParam;i++ )
		{
			m_aFitParamUnc[i] = 0.0;
		}

		m_aBeta			= m_aFitParam;
		//How many parameters to fit
		m_nFreeParam=0;

		for	(int j=1;j<=m_nTotalParam;j++)
		{
			if (m_aFitParamTag[j] == 1) m_nFreeParam++;
		}
	}
	else
	{
		throw CSchFitException(CSchFitException::DATA_SIZE_MISMATCH);				
	}
	return true;
}


bool CMarqbase::AreFitParametersValid()
{
	const int nLowBound = 1;	
	if ( m_bCanFit == false  || m_nData <= 0 || m_nTotalParam <=  0 || m_nFreeParam <= 2  ||
		m_aFitParam.LowBounds() != nLowBound || m_aFitParamTag.LowBounds() != nLowBound || m_xData.LowBounds() != nLowBound || 
		m_yData.LowBounds() != nLowBound || m_sigma.LowBounds() != nLowBound ) 
	{
		return false;
	}
	else 
	{
		return true;	
	}
}

void CMarqbase::SetFitCtrlParameters(int   nMaxIterations,
									float  fChiSquarePrecision,
									float  fInitLamda,
									float  fLamdaMult,
									float  fTimeOut)
{
	m_nMaxMarqIter			= nMaxIterations;
	m_dChiSquarePrecision	= fChiSquarePrecision;
	m_lamda					= fInitLamda;
	m_lamdaMult				= fLamdaMult;
	m_dTimeOutPerPeak		= fTimeOut;
}

void CMarqbase::SetRobustMethod(ROBUST_METHOD eRobustMethod_In)
{
	eRobustMethod = eRobustMethod_In;
}

void CMarqbase::GetResults(CMarqResult& MyFitResult)
{
	MyFitResult.SetFitParam(m_aFitParam);
	MyFitResult.SetFitParamUnc(m_aFitParamUnc);
	MyFitResult.SetReducedChiSquare(m_dReducedChiSquare);
	MyFitResult.SetMarqIterations(m_nMarqIterations);
	MyFitResult.SetLamda(m_lamda);
	MyFitResult.SetBeta(m_aBeta);
	MyFitResult.SetTotalParam(m_nTotalParam);
	MyFitResult.SetNPeaks(m_nPeaks);
	//
	double dStart = 0, dEnd = 0;

	if ( m_nData > 1 && m_nPeaks > 0)
	{
		const int nLow = 1;

		double dIntFactor = m_nIntPoints + 1;
		dStart = m_xData[nLow]/dIntFactor;

		MyFitResult.SetStartXValue(dStart);
		//since low index is 1; This gets called only if we can do fit where m_nData should be defined.
		dEnd = m_xData[m_nData]/dIntFactor;

		MyFitResult.SetEndXValue(dEnd);
		double y = 0;
		int nCounter = 0;

		for ( int i = nLow; i <= m_nData + nLow - 1; i++ )
		{
			if ( m_nIntPoints == 0 )
			{
				//No interpolation
				y += m_yData[i];
			}
			else
			{
				//There are interpolated data points. When nCounter == 0;
				//we are at the original data points, else we are not
				//The first one is special. Always include
				if ( i == nLow )
				{
					y += m_yData[i];
				}
				else
				{
					// skipe m_nIntPoints
					nCounter++;
					// test how many times have we skipped
					if ( nCounter > m_nIntPoints )
					{
						//we skipped enough times
						y += m_yData[i];
						//flag that we counted once
						nCounter = 0;
					}
				}
			}
		}
		MyFitResult.SetGrossCounts(y);
		MyFitResult.SetNParam(m_nTotalParam/m_nPeaks);
	}
}

const CMarqResult CMarqbase::OutputResults() 
{
	CMarqResult MyFitResult;
	GetResults(MyFitResult);
	//should we put the validation of fit results here?
	return MyFitResult;
}

void CMarqbase::OutputResults(CMarqResult* presults)
{
	if ( presults )
	{
		GetResults(*presults);
	}
}

const CMarqResult CMarqbase::Marqminimize()
						
{
	double			dPrevReducedChiSquare;
	double			dChiSquareAtMin;
	const double	epsilonChiSquare = m_dChiSquarePrecision/100;
	int				nChisqConvgCntr  = 0;	
	int				i,j,k,l;
	int				nNonConvergeCounter = 0;
	const int		nMaxNonConverge = 10;
	CMarqResult		FitResults;
	double			tmp = 0;
	time_t			starttime, endtime;

	if ( AreFitParametersValid() == false ) 
	{
		throw CSchFitException(CSchFitException::INPUT_PARAMETERS_INVALID);				
	}
	CMatrix <double> tAlpha				(m_nTotalParam,m_nTotalParam,1);
	CMatrix <double> tCoVariance		(m_nTotalParam,m_nTotalParam,1); 
	CMatrix <double> tInvertMatrix		(m_nTotalParam,m_nTotalParam,1); 
	CMatrix <double> tInvertMatrixAtMin	(m_nTotalParam,m_nTotalParam,1); 
	CVector <double> aFitParamTry		(m_nTotalParam,1);
	CVector <double> aFitParamAtMin		(m_nTotalParam,1);
	CVector <double> aBeta			(m_nTotalParam,1);
	CVector <double> aDeltaFitParam	(m_nTotalParam,1);
	CVector <double> aDeltaFitParamAtMin	(m_nTotalParam,1);
	CMatrix <double> aBetaOrDeltaFit(m_nFreeParam, 1,1);
	
		
	for (j=1;j<=m_nTotalParam;j++) aFitParamTry[j]=m_aFitParam[j];	//try fitting first with guess the values for the parameters

	mrqcof(aFitParamTry,tAlpha,aBeta,m_dReducedChiSquare, eRobustMethod);
	dPrevReducedChiSquare=m_dReducedChiSquare;										//this is the m_dChiSquare value for the guessed parameters. No fitting yet
	dChiSquareAtMin = m_dReducedChiSquare;

	//Initialize to zero in case aFitParamTry[] is the best
	for (j=1;j<=m_nFreeParam;j++)
	{
		for (k=1;k<=m_nFreeParam;k++) 
			tInvertMatrix[j][k] = 0.0;
	}
	
	/********************************************************************/ 
	/*				start of Marquardt iteration						*/
	/********************************************************************/
	//
	time(&starttime);

	for (i = 0; i <=m_nMaxMarqIter;i++)
	{
		//calculatethe Alpha, C metrix and Beta.
		for (j=1;j<=m_nFreeParam;j++)
		{
			for (k=1;k<=m_nFreeParam;k++) 
			{

				#ifdef _DEBUG
				tmp = tAlpha[j][k];
				tCoVariance[j][k] = tmp;
				#else
				tCoVariance[j][k]=tAlpha[j][k];
				#endif
			}

			tCoVariance[j][j]=tAlpha[j][j]*(1.0+m_lamda);
			#ifdef _DEBUG
			tmp = aBeta[j];
			aBetaOrDeltaFit[j][1] = tmp;
			#else
			aBetaOrDeltaFit[j][1]=aBeta[j];
			#endif
		}
		//	input Alpha Matrix (assinged to tCoVariance) and Beta.
		//	Solve for aDeltaFitParam. Assign it to aBetaOrDeltaFit[]. 
		//	The inverse matrix of Alpha
		//	is assigned to tCoVariance.
		gaussj(tCoVariance,m_nFreeParam,aBetaOrDeltaFit,1);

		//save the invert matrix into alpha
		for (j=1;j<=m_nFreeParam;j++)
		{
			for (k=1;k<=m_nFreeParam;k++) 
				tAlpha[j][k] = tCoVariance[j][k];
		}
		
		for (j=1;j<=m_nFreeParam;j++) aDeltaFitParam[j]=aBetaOrDeltaFit[j][1];

		//	implement a-min[] = c-cur[] + da[]. 
		for (j=0,l=1;l<=m_nTotalParam;l++)	
		{
			if (m_aFitParamTag[l]) 
			{

				#ifdef _DEBUG
				tmp = m_aFitParam[l]+aDeltaFitParam[++j];
				aFitParamTry[l] = tmp;
				#else
				aFitParamTry[l]=m_aFitParam[l]+aDeltaFitParam[++j];
				#endif
			}
		}

		//	given x,y,sig, fitted function and new aFitParamTry[], 
		//	calculate m_dChiSquare, beta and Alpha metrix 
		//	(use aDeltaFitParam for beta and tCoVariance for alpha)
		//	If m_dChiSquare OK, then tAlpha = tCoVariance
		//	and tBeta = aDeltaFitParam

		mrqcof(aFitParamTry,tCoVariance,aDeltaFitParam,m_dReducedChiSquare,eRobustMethod);		

		////////////////////////////////////////////////////////////////////////
		//  We found a better chi2
		//	Add epsilonChiSquare in case ChiSquare oscilating around minumum
		/////////////////////////////////////////////////////////////////////
		if (m_dReducedChiSquare < (dPrevReducedChiSquare+epsilonChiSquare))			
		{
			m_lamda *= 1/m_lamdaMult;			//	decrease m_lamda in the next try
			if (fabs(dPrevReducedChiSquare - m_dReducedChiSquare) < m_dChiSquarePrecision)
				nChisqConvgCntr++;

			dPrevReducedChiSquare = m_dReducedChiSquare;		//	keep new/current chisq value
			
			//	keep Alpha metrix and Beta for the next run
			for (j=1;j<=m_nFreeParam;j++) 
			{
				for (k=1;k<=m_nFreeParam;k++)
				{
					//save the invert matrix for the best chisqaures obtained so far
					tInvertMatrix[j][k] = tAlpha[j][k];
					//	keep the Alpha metrix (calculated from mrqcof() and Beta for the next run
					tAlpha[j][k]=tCoVariance[j][k];
				}
				aBeta[j]=aDeltaFitParam[j];
			}
			//Use those parameters for next run
			for (l=1;l<=m_nTotalParam;l++) m_aFitParam[l]=aFitParamTry[l];	
			///////////////////////////////////////////////////////////////////
			// We cashe the results at this "better" chi-square value to be used in case
			// the chi-square didn't get any better
			//////////////////////////////////////////////////////////////////////
			//best chi-square so far
			dChiSquareAtMin = m_dReducedChiSquare;

			if (  dChiSquareAtMin <= m_dAcceptedChiSquareNonConverge	)
			{
				// to be used by calculating uncertaities
				tInvertMatrixAtMin = tInvertMatrix;
				// the fitting parameter
				aFitParamAtMin = aFitParamTry;
				//this array will be saved in the marqresult object
				aDeltaFitParamAtMin = aDeltaFitParam;

			}
			else
			{
				//Don't bother to save/cashe the results
			}
		} 	
		else								//	worse m_dChiSquare than before
		{								
			m_lamda *= m_lamdaMult;			//	increase m_lamda 
			m_dReducedChiSquare=dPrevReducedChiSquare;		//	neglect new/current m_dChiSquare.
			nNonConvergeCounter++;
		}

		if (nChisqConvgCntr		>= m_nChisqConvged )
		{
			break;
		}
		if (nNonConvergeCounter >  nMaxNonConverge ) 
		{
			// In marquardt fit engine, the chi-square failed to converge.\n");
			// The minimum chi-square and current value are %f and %f .\n",dChiSquareAtMin,m_dReducedChiSquare);
			//
			///////////////////////////////////////////////////////////////////////
			//
			// When the chi-square value is not converged, the value itself could be a good
			// one (around 1.0). Found in one instance that although reported chi-square
			// value is small, the fitted curve is way off (that means, the outputed
			// fit parameters are not the one used to compute that chi-square! It's actually
			// the bad one! We can fix this problem by cashe all the calculated results for 
			// the minimum chi-squares found and return those, instead of throwing an exception
			//
			///////////////////////////////////////////////////////////////////////////////
			//
			if (  dChiSquareAtMin <= m_dAcceptedChiSquareNonConverge	)
			{
				// Use cashed value
				//best chi-square ever obtained
				m_dReducedChiSquare  = dChiSquareAtMin;
				tInvertMatrix = tInvertMatrixAtMin;
				// the fitting parameter
				m_aFitParam = aFitParamAtMin;
				// Saved as m_beta
				aDeltaFitParam = aDeltaFitParamAtMin;
				////////////////////////////////////////////////////////////
				// Somehow, the results are not reliable when not converged.
				// even though the chi-square value calculated is OK.
				// It's turned out that when too many tail points are included,
				// the chi2 value tends to not converge. So we can do the following:
				// 1.  Autodetect peak height and adjust the tails differently according to
				//		the height (done)
				// 2.  We can compare the area difference of the whole spectrum to that of the
				//     fitted one and discard the fit based on that.
				// 3.  In many instances, the problem fit has a very large width compared
				//     to the expected (may be the fit function has a bug there?) we can throw away
				//     the peak based on the width in the driver class
				/////////////////////////////////////////////////////////////
				//throw CSchFitException(CSchFitException::CHI_SQUARE_NOT_CONVERGED);	
			}
			else
			{
				//signal that it fails
				throw CSchFitException(CSchFitException::CHI_SQUARE_NOT_CONVERGED);	
			}
			//should we set the fit as failed? If not, the results will be outputed. Although
			//we can still use chi-square value to test/validate later
			break;
		}
		//
		// --------- check time out --------------------
		//
		time(&endtime);
		if ( difftime(endtime,starttime) > m_dTimeOutPerPeak ) 
		{
			#ifndef _DEBUG
				// only timeout in release mode.
				break;
			#endif
		}
		else starttime = endtime;
	}

	/********************************************************/
	/*				End of Marquardt	 					*/
	/********************************************************/

	m_nMarqIterations = i - 1;
	////////////////////////////////////////////////////////////////////////////////////////
	//	Calculate Uncertainties
	//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Important Reminder ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	//  The calculation so far is based on Equation (15.4.15) in Numerical Recipes. This euqation is derived for
	//  fitting of polynomial functions, where in the co-ariance matrix, only diagonal matrix exist. For more 
	//  general equations, Equation (15.6.7) should be used. It's worth to notice that the obsolute value of the
	//  chi-squares doesn't get into the calculation of the uncertainties at all, it's the confidence limits (or
	//  how far you are willing to tolerate the chi-square values from deviating from your minimized chi-squares
	//  which is used in the calculations (see table on page 697)
	//
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	covsrt(tInvertMatrix,m_nTotalParam,m_aFitParamTag,m_nFreeParam);

	for (k=1; k<=m_nTotalParam;k++)
	{
		tmp = tInvertMatrix[k][k];
		if ( tmp > 0 ) {
			m_aFitParamUnc[k] = sqrt(tmp);
		}
		else 
		{
			throw CSchFitException(CSchFitException::SQRT_NEGATIVE_VALUE);	
		}
	}
	m_aBeta = aDeltaFitParam;
	return OutputResults();;
}

void CMarqbase::mrqcof(CVector<double>&	aFitParam_In,
						CMatrix<double>&	tAlpha_Out,
						CVector<double>&	aBeta_Out,
						double& 			dChiSquare_Out,
						ROBUST_METHOD		eRobustMethod_In)
{
	//Evaluate the linearized fitting matrix alpha and vector beta.
	//Then calculate chi-square.

	int i,j,k,l,m;
	double yFit = 0;
	double wt,invSigma,invSigmaSqr,deltaY;
	CVector <double> dyOverda(m_nTotalParam,1);	
	double tmp = 0;
	////////////////////////////////////////////////////////////////////////////////////
	//
	//	The error of each data point will be : sigma * dChi2Confidence. If that
	//	factor is 1.96, we are at 95% confidence level
	//
	////////////////////////////////////////////////////////////////////////////////////
	const double dChi2Confidence = m_dChi2ConfidenceLevel;

	double dyda = 0.0;
	
	for (j=1;j<=m_nFreeParam;j++)
	{
		for (k=1;k<=j;k++) tAlpha_Out[j][k]=0.0;
		aBeta_Out[j]=0.0;
	}

	dChiSquare_Out=0.0;

	for (i=1;i<=m_nData;i++)
	{	
		CalculateFitValues(m_xData[i],aFitParam_In,yFit,dyOverda);
		invSigma	=	1.0/(m_sigma[i]);					//
		invSigmaSqr	=	1.0/(m_sigma[i]*m_sigma[i]);
		deltaY		=	m_yData[i]-yFit;						

		for (j=0,l=1;l<=m_nTotalParam;l++) 
		{
			if (m_aFitParamTag[l]) 
			{
				wt=dyOverda[l]*invSigmaSqr;
				
				//
				PreventOverUnderFlows(wt);

				for (j++,k=0,m=1;m<=l;m++)
				{
					if (m_aFitParamTag[m])
					{
						dyda = dyOverda[m];
						
						PreventOverUnderFlows(dyda);
						//tmp should not be zero so that matrix inversion will
						//be more reliable
						tmp = wt*dyda;

						tAlpha_Out[j][++k] +=  tmp;
					}
				}
				aBeta_Out[j] += deltaY*wt;
				
			}
		}
		//	select method of minimization for the residuals
		if				(eRobustMethod_In == LSQUARE) dChiSquare_Out	+=	deltaY*deltaY*invSigmaSqr;
		else if			(eRobustMethod_In == ABSDEV)  dChiSquare_Out	+=  fabs(deltaY*invSigma);
			//test area minimization
			else if		(eRobustMethod_In == ABSAREAS) dChiSquare_Out	+=	fabs(deltaY);
				else if (eRobustMethod_In == PEARSON7)dChiSquare_Out	+=	log(sqrt(1+3*deltaY*deltaY*invSigmaSqr));				
						else						   dChiSquare_Out	+=	deltaY*deltaY*invSigmaSqr;		//if no match, use least-square as default
	}
	//	Calculate reduced chi-square
	dChiSquare_Out /= (m_nData - m_nFreeParam + 1 );
	// take into account the confidence level. This factor does not work for Pearson 7 method in this way
	if				(eRobustMethod_In == LSQUARE) dChiSquare_Out	/=	dChi2Confidence * dChi2Confidence;
	else if			(eRobustMethod_In == ABSDEV)  dChiSquare_Out	/=  dChi2Confidence;
	else 		    { ; }										// nothing


	//	fill in the symmetric side

	for (j=2;j<=m_nFreeParam;j++)
	{
		for (k=1;k<j;k++)tAlpha_Out[k][j]=tAlpha_Out[j][k];
	}
}

void CMarqbase::covsrt
(
 CMatrix<double>& tCovar,
 int nTotalParam,
 CVector<int> aFitParamTag_In,
 int nFreeParam
)
{

	int i,j,k;
	for (i=nFreeParam+1;i<=nTotalParam;i++)
	{
		for (j=1;j<=i;j++) tCovar[i][j]=tCovar[j][i]=0.0;
	}

	k=nFreeParam;

	for (j=nTotalParam;j>=1;j--) 
	{
		if (aFitParamTag_In[j])
		{
			for (i=1;i<=nTotalParam;i++) SWAP(tCovar[i][k],tCovar[i][j])
			for (i=1;i<=nTotalParam;i++) SWAP(tCovar[k][i],tCovar[j][i])
			k--;
		}
	}
}

void CMarqbase::gaussj
(
 CMatrix<double>& tAlphaInCoVarianceOut,
 int nFreeParam,
 CMatrix<double>& tBetaInDeltaAOut,
 int nBetaColHiBound
)
{

	int i,icol=1,irow =1,j,k,l,ll;
	double big,dum,pivinv;
	//those arrays are used for bookkeeping on the pivoting
	CVector<int> indxc(nFreeParam,1);
	CVector<int> indxr(nFreeParam,1);
	CVector<int> ipiv(nFreeParam,1);

	for (j=1;j<=nFreeParam;j++) ipiv[j]=0;

/********* Start of the main loop over the columns to be reduced *******/

	for (i=1;i<=nFreeParam;i++) 
	{
		big=0.0;
	/******* Start of the outter loop for the search of a pivot element *******/
		for (j=1;j<=nFreeParam;j++)
		{
			if (ipiv[j] != 1)
			{
				for (k=1;k<=nFreeParam;k++) 
				{
					if (ipiv[k] == 0)
					{
						if (fabs(tAlphaInCoVarianceOut[j][k]) >= big) 
						{
							big=fabs(tAlphaInCoVarianceOut[j][k]);
							irow=j;
							icol=k;
						}
					} 
					else 
					{
						if (ipiv[k] > 1) 
						{
							throw CSchFitException(CSchFitException::UNKNOWN_SCHFIT_ERROR);	
						}
					}
				}
			}
		}

		++(ipiv[icol]);
		if (irow != icol) 
		{
			for (l=1;l<=nFreeParam;l++) SWAP(tAlphaInCoVarianceOut[irow][l],tAlphaInCoVarianceOut[icol][l])
			for (l=1;l<=nBetaColHiBound;l++) SWAP(tBetaInDeltaAOut[irow][l],tBetaInDeltaAOut[icol][l])
		}
		indxr[i]=irow;
		indxc[i]=icol;
		if ( tAlphaInCoVarianceOut[icol][icol] != 0 ) {
			pivinv=1.0/tAlphaInCoVarianceOut[icol][icol];
		} else {
			//catch by reference
			throw CSchFitException(CSchFitException::DIVIDE_BY_ZERO);
		}		
		tAlphaInCoVarianceOut[icol][icol]=1.0;

		for (l=1;l<=nFreeParam;l++) tAlphaInCoVarianceOut[icol][l] *= pivinv;
		for (l=1;l<=nBetaColHiBound;l++) tBetaInDeltaAOut[icol][l] *= pivinv;

		for (ll=1;ll<=nFreeParam;ll++)
		{
			if (ll != icol) 
			{
				dum=tAlphaInCoVarianceOut[ll][icol];
				tAlphaInCoVarianceOut[ll][icol]=0.0;
				for (l=1;l<=nFreeParam;l++) tAlphaInCoVarianceOut[ll][l] -= tAlphaInCoVarianceOut[icol][l]*dum;
				for (l=1;l<=nBetaColHiBound;l++) tBetaInDeltaAOut[ll][l] -= tBetaInDeltaAOut[icol][l]*dum;
			}
		}
	}

	for (l=nFreeParam;l>=1;l--) 
	{
		if (indxr[l] != indxc[l])
		{
			for (k=1;k<=nFreeParam;k++)
			{
				SWAP(tAlphaInCoVarianceOut[k][indxr[l]],tAlphaInCoVarianceOut[k][indxc[l]])
			}
		}
	}
}


void CMarqbase::PreventOverUnderFlows(double& d)
{
	const double dEpsilon = 1.0e-37;
	//take max of float type
	const double dMax = 1e+37;
	//take minmum of the float type
	const double dMin = -1e+37;

	if ( d > 0.0 )
	{
		if ( d > dMax ) d = dMax;						// big positive. For overflow
		else if ( d < dEpsilon ) d = dEpsilon;			// small postive. For underflow
	}
	else 
	{
		if ( d < dMin ) d = dMin;						// big negative. For overflow
		else if ( d > - dEpsilon ) d = -dEpsilon;		// small negaive. For underflow
	}
}


