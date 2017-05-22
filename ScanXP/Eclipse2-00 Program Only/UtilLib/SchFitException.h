/***************************************************************
	Header file for CSchFitException class
***************************************************************/
#ifndef __INC_SCHFITEXCEPTION
#define __INC_SCHFITEXCEPTION

class CSchFitException // : public CException
{
	public:

		enum SchFitErrorTypes
		{
			DIVIDE_BY_ZERO,
			SQRT_NEGATIVE_VALUE,
			DATA_SIZE_MISMATCH,
			ARRAY_LOW_BOUNDS,
			ARRAY_HIGH_BOUNDS,
			UNKNOWN_SCHFIT_ERROR,
			MEMORY_ALLOCATION_FAILED,
			INPUT_PARAMETERS_INVALID,
			FIT_FUNCTION_INVALID,
			CHI_SQUARE_NOT_CONVERGED
		} ;
		
		CSchFitException(const SchFitErrorTypes errorType);
		//compiler didn't complain about missing of this one
		CSchFitException(const CSchFitException& ex);

		virtual ~CSchFitException() {};

		virtual void ReportError();
		// get pointer to the satic local string about the description
		// don't delete the string
		char* GetExceptionDescription() const { return m_pszDescription;}
		int   GetLengthOfDescription() const { return MAX_SCHFIT_STRING;}

private:
	enum { MAX_SCHFIT_STRING = 128 };
	//find the error string according to the error type
	char*   FindErrorString();

	SchFitErrorTypes		m_errorType;
	char* 					m_pszDescription;

    static char  m_pszDIVIDE_BY_ZERO[MAX_SCHFIT_STRING];     
    static char  m_pszDATA_SIZE_MISMATCH[MAX_SCHFIT_STRING];
    static char  m_pszARRAY_LOW_BOUNDS[MAX_SCHFIT_STRING];   
    static char  m_pszARRAY_HIGH_BOUNDS[MAX_SCHFIT_STRING];  
    static char  m_pszUNKNOWN_ANALYSIS_ERROR[MAX_SCHFIT_STRING];
    static char  m_pszMEMORY_ALLOCATION_FAILED[MAX_SCHFIT_STRING]; 
    static char  m_pszANALYSIS_ENGINE_ERROR[MAX_SCHFIT_STRING]; 
    static char  m_pszSQRT_NEGATIVE_VALUE[MAX_SCHFIT_STRING]; 
	static char  m_pszUNKNOWN_SCHFIT_ERROR[MAX_SCHFIT_STRING];
	static char  m_pszINPUT_PARAMETERS_INVALID[MAX_SCHFIT_STRING];
	static char  m_pszCHI_SQUARE_NOT_CONVERGED[MAX_SCHFIT_STRING];
	static char  m_pszFIT_FUNCTION_INVALID[MAX_SCHFIT_STRING];
    
};


#endif