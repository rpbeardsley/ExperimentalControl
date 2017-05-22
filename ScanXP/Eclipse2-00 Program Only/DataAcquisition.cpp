//Data Acquisition object

#include "stdafx.h"
#include "DataAcquisition.h"


CDataAcquisition::CDataAcquisition(IICS *pICS, CGSX *pAverageGSX)
{

	ASSERT(pICS);    //Make sure we have a pointer to the Instrument Control Server
	ASSERT(pTOFGSX); //Make sure we have a pointer to the TOF Graph

	m_pICS = pICS;
	m_pAverageGSX = pAverageGSX;


}
