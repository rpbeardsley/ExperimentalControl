//CWindowData implementation file

#include "stdafx.h"
#include "WindowData.h"
#include "math.h"

CBaseWindowData::CBaseWindowData(double* pData, int iNumPoints, bool bCopyData)
{
	m_pData = NULL;
	m_bCopyData = bCopyData;
	m_iNumPoints = iNumPoints;

	SetData(pData, m_iNumPoints);
}
CBaseWindowData::~CBaseWindowData()
{
	if(m_bCopyData)
	{
		//We must delete our data
		delete m_pData;
		m_pData = NULL;
	}
}

void CBaseWindowData::SetData(double* pData, int iNumPoints)
{

	if( iNumPoints > 0 )
	{
		if( m_pData != NULL)
		{
			delete m_pData;
			m_pData = NULL;
		}

		if(m_bCopyData)
		{
			//Store / Modify our own data
			m_pData = new double[iNumPoints];
			memcpy(m_pData, pData, iNumPoints);
		}
		else
		{
			//Modify the incoming data
			m_pData = pData;

		}
	}
}

// Parzen window derivation

CParzenWindow::CParzenWindow(double* pData, int iNumPoints, bool bCopyData)	
							 :CBaseWindowData(pData, iNumPoints, bCopyData)
{


}
CParzenWindow::~CParzenWindow()
{

}
bool CParzenWindow::Calculate()
{
	ASSERT( m_pData != NULL && m_iNumPoints > 0 );

	if( m_pData == NULL && m_iNumPoints < 1 )
	{
		TRACE("Data not set (double array or number of points).\n");
		return false;
	}

	double dAverage=0;
	for(int n=0;n<m_iNumPoints; n++)
	{
		dAverage+=m_pData[n];
	}

	dAverage /= m_iNumPoints;

	for(n=0; n<m_iNumPoints; n++)
	{
		double dTop = n - ((m_iNumPoints - 1) * (double)0.5);
		double dBottom = (m_iNumPoints + 1) * (double)0.5;

		double dWait = ((double)1.0 - fabs(  dTop / dBottom ) );
		m_pData[n] -= dAverage;
		m_pData[n] *= dWait;
	}

	return true;
}

// Hanning window derivation

CHanningWindow::CHanningWindow(double* pData, int iNumPoints, bool bCopyData)	
							 :CBaseWindowData(pData, iNumPoints, bCopyData)
{


}
CHanningWindow::~CHanningWindow()
{

}
bool CHanningWindow::Calculate()
{
	ASSERT( m_pData != NULL && m_iNumPoints > 1 );

	if( m_pData == NULL && m_iNumPoints < 2 )
	{
		TRACE("Data not set (double array or number of points).\n");
		return false;
	}

	const double cdPI = 3.1415926535897932;

	double dMul(2.0 * cdPI / (double)(m_iNumPoints - 1));
	//double dSum = 0;
	double dScale = (double)m_iNumPoints / (double)(m_iNumPoints - 1);

	for(int n=0;n<m_iNumPoints;n++)
	{
		m_pData[n] *= dScale * (1.0 - cos( (double)n * dMul));
		//dSum += dScale * (1.0 - cos( (double)n * dMul));
	}

	return true;
}