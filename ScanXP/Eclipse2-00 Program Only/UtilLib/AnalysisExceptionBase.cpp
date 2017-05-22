/***************************************************************
	Implementation file for CAnalysisExceptionBase class
***********************\\****************************************/
#include "stdafx.h"
#include "AnalysisExceptionBase.h"
#include <assert.h>


CAnalysisExceptionBase::CAnalysisExceptionBase(const CString& csDescription)
{
	m_csDescription	= csDescription;
}
/***************************************************************
	ReportError: Send error message to event logger
***************************************************************/ 
void CAnalysisExceptionBase::ReportError(int iJobSpecID)
{
//	AVMessageError(m_csDescription,iJobSpecID);
}

void  CAnalysisExceptionBase::GetErrorMessage(CString& csErrorMsg)
{
	csErrorMsg = m_csDescription;
}

BOOL CAnalysisExceptionBase::GetErrorMessage( LPTSTR lpszError, UINT nMaxError)
{
	UINT nLen = m_csDescription.GetLength();
	UINT nMax = __max(nLen, nMaxError) - 1;
	strncpy(lpszError,this->m_csDescription,nMax);
	return TRUE;
}

CAnalysisExceptionBase::CAnalysisExceptionBase(const CAnalysisExceptionBase& ex)
{
	m_csDescription = ex.m_csDescription;
}
