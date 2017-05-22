/***************************************************************
	Implementation file for CSchFitException class
***************************************************************/
#include "SchFitException.h"
#include <assert.h>
#include "stdafx.h"


char  CSchFitException::m_pszDIVIDE_BY_ZERO[MAX_SCHFIT_STRING]				= "Divide by zero";
char  CSchFitException::m_pszDATA_SIZE_MISMATCH[MAX_SCHFIT_STRING]			= "Array sizes are not the same or zero.";
char  CSchFitException::m_pszARRAY_LOW_BOUNDS[MAX_SCHFIT_STRING]			= "Problem with array low bound index";
char  CSchFitException::m_pszARRAY_HIGH_BOUNDS[MAX_SCHFIT_STRING]			= "Problem with array high bound index";
char  CSchFitException::m_pszUNKNOWN_ANALYSIS_ERROR [MAX_SCHFIT_STRING]		= "Unknow analysis error type";
char  CSchFitException::m_pszMEMORY_ALLOCATION_FAILED[MAX_SCHFIT_STRING] 	= "Cannot allocate memory";
char  CSchFitException::m_pszANALYSIS_ENGINE_ERROR[MAX_SCHFIT_STRING]  		= "Analysis error encounted. ";
char  CSchFitException::m_pszSQRT_NEGATIVE_VALUE [MAX_SCHFIT_STRING]		= "Negative operand in square-root operation. ";
char  CSchFitException::m_pszUNKNOWN_SCHFIT_ERROR[MAX_SCHFIT_STRING]		= "Unknown peak serach and fit error";
char  CSchFitException::m_pszINPUT_PARAMETERS_INVALID[MAX_SCHFIT_STRING]	= "Input parameters invalid";
char  CSchFitException::m_pszCHI_SQUARE_NOT_CONVERGED[MAX_SCHFIT_STRING]	= "The chi-square value not converged.";
char  CSchFitException::m_pszFIT_FUNCTION_INVALID[MAX_SCHFIT_STRING]		= "Fit function invalid.";

CSchFitException::CSchFitException(const SchFitErrorTypes errorType)//,const UINT errorID)
{
	m_errorType = errorType;
	m_pszDescription = FindErrorString();
}

CSchFitException::CSchFitException(const CSchFitException& ex)
{
	memcpy(this,&ex,sizeof(CSchFitException));
}

/***************************************************************
	ReportError: Displays a message box with the error for
	this exception
***************************************************************/ 
void CSchFitException::ReportError()
{
	::MessageBox(::GetActiveWindow(),m_pszDescription,"Exception in peak serach and fit engine", MB_OK);
}

//void  CSchFitException::GetErrorMessage(char* pszErrorMsg)
//{
	//csErrorMsg = ErrorMsgString();
//}

char* CSchFitException::FindErrorString()			
{
	char* psz = 0;
	switch (m_errorType)
	{
		case DIVIDE_BY_ZERO:
			psz  = m_pszDIVIDE_BY_ZERO;
			break;
		case SQRT_NEGATIVE_VALUE:
			psz = m_pszSQRT_NEGATIVE_VALUE;
			break;
		case DATA_SIZE_MISMATCH:
			psz = m_pszDATA_SIZE_MISMATCH;
			break;
		case ARRAY_LOW_BOUNDS:
			psz = m_pszARRAY_LOW_BOUNDS;
			break;
		case ARRAY_HIGH_BOUNDS:
			psz = m_pszARRAY_HIGH_BOUNDS;
			break;
		case UNKNOWN_SCHFIT_ERROR:
			psz = m_pszUNKNOWN_SCHFIT_ERROR;
			break;
		case MEMORY_ALLOCATION_FAILED:
			psz = m_pszMEMORY_ALLOCATION_FAILED;
			break;
		case INPUT_PARAMETERS_INVALID:
			psz = m_pszINPUT_PARAMETERS_INVALID;
			break;
		case CHI_SQUARE_NOT_CONVERGED:
			psz = m_pszCHI_SQUARE_NOT_CONVERGED;
			break;
		default:
			assert(false);
	}
	return psz;
}


