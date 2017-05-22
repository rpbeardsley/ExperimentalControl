
#ifndef __FileUtils_h
#define __FileUtils_h

class TFileException : public CException {
public:
    TFileException(const char* pszReason,const char* pszFile);
    virtual BOOL GetErrorMessage(LPTSTR lpszError,UINT nMaxError,PUINT pnHelpContext = NULL);
    const CString strFile;
    const CString strReason;
};

#endif
