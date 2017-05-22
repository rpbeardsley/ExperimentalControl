//***************************************************************************************
//Settings.cpp : implementation file
//
//	Functions: For details on functions in this file see Settings.h
//
//		       DATE		 BY					REASON FOR REVISION
//	Original:  7/12/98   Bradley Allen
//
//	Revisions:
//***************************************************************************************


#include "stdafx.h"
#include <IO.h>
#include "Settings.h"
#include "Eclipse.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSettings

IMPLEMENT_SERIAL(CSettings, CCmdTarget, 1)
IMPLEMENT_SERIAL(CProtocolSettings, CObject, 1)

void CProtocolSettings::Serialize(CArchive& ar) 
{

	if (ar.IsStoring())
	{	// storing code

		int iLength;

		iLength = m_sFileName.GetLength();
		if(iLength < 255)
		{
			//Pad with " "'s to force the CString a fixed length
			for(int n=iLength;n <= 255;n++)
			{
				m_sFileName += _T(" ");
			}
		}

		iLength = m_sUnits.GetLength();
		if(iLength < 5)
		{
			//Pad with " "'s to force the CString a fixed length
			for(int n=iLength;n <= 5;n++)
			{
				m_sUnits += _T(" ");
			}
		}

		ar << m_fRecordLength << m_iRecordsPerSpectrum << m_fSamplingInterval << m_fTimeOffset << m_fVerticalOffset
		   << m_fEOSDeadTime << m_bEnhancer << m_bCompressionActive << m_iSensitivity << m_fMinThreshold
		   << m_iBkgSamplingInterval << m_iAdjacentBkg << m_iMaxPeakWidth << m_iMinPeakWidth << m_fRingingProtection
		   << m_iCalType << m_dCoef1 << m_dCoef2 << m_dCoef3 << m_dCoef4 << m_sFileName << m_sUnits << m_bCalValid;
	}
	else
	{	// loading code
		ar >> m_fRecordLength >> m_iRecordsPerSpectrum >> m_fSamplingInterval >> m_fTimeOffset >> m_fVerticalOffset
		   >> m_fEOSDeadTime >> m_bEnhancer >> m_bCompressionActive >> m_iSensitivity >> m_fMinThreshold
		   >> m_iBkgSamplingInterval >> m_iAdjacentBkg >> m_iMaxPeakWidth >> m_iMinPeakWidth >> m_fRingingProtection
		   >> m_iCalType >> m_dCoef1 >> m_dCoef2 >> m_dCoef3 >> m_dCoef4 >> m_sFileName >> m_sUnits >> m_bCalValid;

		//Now remove the padding!
		m_sUnits.TrimRight();
		m_sFileName.TrimRight();
	}
}


CSettings::CSettings()
{
	Initialize();
}

CSettings::~CSettings()
{
}


BEGIN_MESSAGE_MAP(CSettings, CCmdTarget)
	//{{AFX_MSG_MAP(CSettings)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSettings message handlers

void CSettings::Serialize(CArchive& ar) 
{
	if(!ar.IsStoring())Initialize();//clear out any hanging out

	for(int n=0;n<8;n++)ProtSettings[n].Serialize( ar );    // Call Serialize on embedded member.

	if (ar.IsStoring())
	{	// storing code
		ar << m_fVersion << m_iMaxAcqTime << m_iAveragesPerTrend << m_iProtocol
		   << m_bRapidProtocol << m_bTriggerEnablePolarity;
	}
	else
	{	// loading code
		ar >> m_fVersion >> m_iMaxAcqTime >> m_iAveragesPerTrend >> m_iProtocol
		   >> m_bRapidProtocol >> m_bTriggerEnablePolarity;
	}
}
void CSettings::Initialize()
{
	m_iMaxAcqTime = -1;
	m_iAveragesPerTrend = -1;
	m_iProtocol = -1;
	m_bRapidProtocol = 0;
	m_bTriggerEnablePolarity = 0;

	for(int n=0;n<8;n++)
	{
		ProtSettings[n].m_fRecordLength = (float)-1;
		ProtSettings[n].m_iRecordsPerSpectrum = -1;
		ProtSettings[n].m_fSamplingInterval = (float)-1;
		ProtSettings[n].m_fTimeOffset = (float)-1;
		ProtSettings[n].m_fVerticalOffset = (float)-1;
		ProtSettings[n].m_fEOSDeadTime = (float)-1;
		ProtSettings[n].m_bEnhancer = FALSE;
		ProtSettings[n].m_bCompressionActive = FALSE;
		ProtSettings[n].m_iSensitivity = -1;
		ProtSettings[n].m_fMinThreshold = (float)-1;
		ProtSettings[n].m_iBkgSamplingInterval = -1;
		ProtSettings[n].m_iAdjacentBkg = -1;
		ProtSettings[n].m_iMinPeakWidth = -1;
		ProtSettings[n].m_iMaxPeakWidth = -1;
		ProtSettings[n].m_fRingingProtection = (float)-1;
		ProtSettings[n].m_bCalValid = FALSE;
		ProtSettings[n].m_iCalType = -1;
		ProtSettings[n].m_dCoef1 = (double)-1;
		ProtSettings[n].m_dCoef2 = (double)-1;
		ProtSettings[n].m_dCoef3 = (double)-1;
		ProtSettings[n].m_dCoef4 = (double)-1;
		ProtSettings[n].m_sFileName = _T("");
		ProtSettings[n].m_sUnits = _T("");
	}

}
void CSettings::LoadSettingsFromInstrument()
{
	CMainFrame* pWnd = (CMainFrame*)AfxGetMainWnd();
	ASSERT(pWnd);

	CEclipseApp* pApp = (CEclipseApp*)AfxGetApp();
	ASSERT(pApp);

	CString Values;
	CString Tmp;
	int iStart = 0;
	int iEnd = 0;

	try
	{
		//m_iMaxAcqTime = pWnd->GetICS()->GetTimePreset();	
		//m_iAveragesPerTrend = pWnd->GetICS()->GetSpectrumPreset();
		//Instead of using the preset settings in instrument get them from the registry
		if(pApp->GetIsMaxTimeUsed())
			m_iMaxAcqTime = pApp->GetMaxTime();
		else
			m_iMaxAcqTime = 0;

		if(pApp->GetIsMaxNumberUsed())
			m_iAveragesPerTrend = pApp->GetMaxNumber();
		else
			m_iAveragesPerTrend = 0;

		m_iProtocol = pWnd->GetICS()->GetProtocol();
		m_bRapidProtocol = pWnd->GetICS()->GetRps();
		m_bTriggerEnablePolarity = pWnd->GetICS()->GetTriggerPolarity();

		//Get the protocol based settings
		for(int n=0;n<8;n++)
		{
			//load up the calibration file names here

			CString str = pWnd->GetICS()->GetAverageConfig(n);
			Values = str;

			iEnd = Values.Find(" ");//Get the Record Length field
			Tmp = Values.Left(iEnd);
			Values = Values.Right(Values.GetLength() - (iEnd + 1));
			ProtSettings[n].m_fRecordLength = (float)atof(Tmp);

			iEnd = Values.Find(" ");//Get the Records Per Spectrum field
			Tmp = Values.Left(iEnd);
			Values = Values.Right(Values.GetLength() - (iEnd + 1));
			ProtSettings[n].m_iRecordsPerSpectrum = atoi(Tmp);
			
			iEnd = Values.Find(" ");//Get the Sampling Interval field
			Tmp = Values.Left(iEnd);
			Values = Values.Right(Values.GetLength() - (iEnd + 1));
			ProtSettings[n].m_fSamplingInterval = (float)atof(Tmp);

			iEnd = Values.Find(" ");//Get the Time offset field
			Tmp = Values.Left(iEnd);
			Values = Values.Right(Values.GetLength() - (iEnd + 1));
			ProtSettings[n].m_fTimeOffset = (float)atof(Tmp);

			iEnd = Values.Find(" ");//Get the Vertical offset field
			Tmp = Values.Left(iEnd);
			Values = Values.Right(Values.GetLength() - (iEnd + 1));
			ProtSettings[n].m_fVerticalOffset = (float)atof(Tmp);
		
			iEnd = Values.Find(" ");//Get the EOS Deadtime field
			Tmp = Values.Left(iEnd);
			Values = Values.Right(Values.GetLength() - (iEnd + 1));
			ProtSettings[n].m_fEOSDeadTime = (float)atof(Tmp);
			
			Tmp = Values;//Get the Enhancer field
			ProtSettings[n].m_bEnhancer = (BOOL)atoi(Tmp);


			//Store the calibration information for this protocol

			CString Path;
			CFileException e;

			switch(n)
			{
				case 0:	Path = pApp->GetProt0CalPath(); break;
				case 1:	Path = pApp->GetProt1CalPath(); break;
				case 2:	Path = pApp->GetProt2CalPath(); break;
				case 3:	Path = pApp->GetProt3CalPath(); break;
				case 4:	Path = pApp->GetProt4CalPath(); break;
				case 5:	Path = pApp->GetProt5CalPath(); break;
				case 6:	Path = pApp->GetProt6CalPath(); break;
				case 7:	Path = pApp->GetProt7CalPath(); break;
			}

			ProtSettings[n].m_bCalValid = FALSE;

			if(_access(Path, 0) != -1)//Good cal file so store its data
			{
				CFile CalFile;

				if( CalFile.Open(Path, CFile::modeRead, &e ) )
				{
					CCalibration ca;

					//Load cal info into Calibration object
					CArchive arL(&CalFile, CArchive::load);
					ca.Serialize(arL);
					arL.Close();

					ProtSettings[n].m_bCalValid = TRUE;
					ProtSettings[n].m_iCalType = (int)ca.GetCalType();
					ProtSettings[n].m_dCoef1 = ca.GetCoef1();
					ProtSettings[n].m_dCoef2 = ca.GetCoef2();
					ProtSettings[n].m_dCoef3 = ca.GetCoef3();
					ProtSettings[n].m_dCoef4 = ca.GetCoef4();
					ProtSettings[n].m_sFileName = ca.GetFileName();
					ProtSettings[n].m_sUnits = ca.GetUnitsText();
				}
			} 
		}
	}
	catch(COleException* e)
	{
		TRACE("Ole Exception occured.\n");
		e->Delete();
		
	}
}
