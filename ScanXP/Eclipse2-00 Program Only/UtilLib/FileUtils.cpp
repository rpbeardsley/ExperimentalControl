
#include "stdafx.h"
#include "FileUtils.h"

TFileException::TFileException(const char* pszReason,const char* pszFile)
: strReason(pszReason),strFile(pszFile),CException(TRUE) {
}

BOOL TFileException::GetErrorMessage(LPTSTR lpszError,UINT nMaxError,PUINT pnHelpContext) {
	if (pnHelpContext != NULL) *pnHelpContext = 0;
    if (nMaxError > 0) {
        CString str = _T("File error on ") + strFile + _T(" - ") + strReason;
        strncpy(lpszError,str,nMaxError);
        lpszError[nMaxError-1] = 0;
    }
	return TRUE;
}
