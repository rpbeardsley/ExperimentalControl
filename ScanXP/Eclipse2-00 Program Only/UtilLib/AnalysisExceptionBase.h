/***************************************************************
	Header file for CAnalysisExceptionBase class
***************************************************************/

#pragma once

class CAnalysisExceptionBase : public CException
{
	public:
		CAnalysisExceptionBase() { };
		CAnalysisExceptionBase(const CString& csDescription);
		//needed in myfitfunctions.cpp, otherwise, cannot throw there
		CAnalysisExceptionBase(const CAnalysisExceptionBase& ex);

		virtual ~CAnalysisExceptionBase() {};

		virtual void  GetErrorMessage(CString& csErrorMsg);
		virtual CString GetErrorMessage() const { return m_csDescription;}
		virtual BOOL GetErrorMessage( LPTSTR lpszError, UINT nMaxError);

		virtual void ReportError(int iJobSpecID = 0);


protected:

		CString					m_csDescription;
	
};


