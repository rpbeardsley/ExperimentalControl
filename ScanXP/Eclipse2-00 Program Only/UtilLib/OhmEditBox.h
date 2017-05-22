
#ifndef __OhmEditBox_h
#define __OhmEditBox_h

#include "MyControls.h"

// Combo box should be drop list and fixed owner draw with has strings

class TOhmEditBox : public TAutoNumberWithUnitsEditBoxTmplt<double> {
public:
    inline TOhmEditBox(int iID,CWnd* pParent,
                       int iListBoxID,double* pd,double* pdMultiplier,
                       const TTranslator& ATranslator = TAutoDoubleEditBox::dftTrans,
                       const TBaseEnabler& AEnabler = dftEnabler,int AiMinExp = -15,int AiMaxExp = 12)
    : TAutoNumberWithUnitsEditBoxTmplt<double>(iID,pParent,iListBoxID,pd,pdMultiplier,ATranslator,AEnabler),
      iMinExp(AiMinExp),iMaxExp(AiMaxExp) { }
    typedef TAutoDoubleEditBox::TFormattedTranslator TFormattedTranslator;
protected:
    const int iMinExp;
    const int iMaxExp;
    virtual TAutoListBox* CreateUnitsListBox(int iID,CWnd* pParent);
    DECLARE_MESSAGE_MAP()
};
#endif

