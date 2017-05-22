#if !defined _DATAACQUISITION__H
#define _DATAACQUISITION__H

#include "MainFrm.h"
#include "FastFlightDoc.h"
#include "FastFlightView.h"

class CDataAcquisition : CObject
{
public:
	CDataAcquisition(IICS* pICS, CGSX* pTOFGSX);


private:

	IICS* m_pICS;
	CGSX* m_pTOFGSX;


	


};

#endif