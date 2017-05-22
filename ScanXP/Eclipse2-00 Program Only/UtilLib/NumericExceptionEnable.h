#ifndef _NUMERIC_EXCEPTION_ENABLE_H
#define _NUMERIC_EXCEPTION_ENABLE_H

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	NumericExceptionsEnable.h
//
//	This class is the same as TNumericExceptionEnable class defined in NumberUtils.h in PowerSuite software.
//  It's been extracted from that file since some symbols used in that file are not defined under
//  ATL project settings.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CNumericExceptionsEnable {
public:
			CNumericExceptionsEnable(bool bEnable);
   virtual ~CNumericExceptionsEnable();
protected:
    unsigned int  m_npuOriginal;
    
};


#endif
