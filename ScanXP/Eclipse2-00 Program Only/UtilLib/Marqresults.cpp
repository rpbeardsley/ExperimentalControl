#include "MarqResults.h"


CMarqResult::CMarqResult()
{	
	m_nTotalParam = 0;
	m_dReducedChiSquare = 0;
	m_nMarqIterations	= 0;
	m_bFitFailed		= false;
	m_dStartXValue		= 0.0;
	m_dEndXValue		= 0.0;
	m_dGrossCounts		= 0.0;

}

void CMarqResult::SetFitParam(CVector<double>& aFitParam)
{
	m_aFitParam = aFitParam;
}

void CMarqResult::SetFitParamUnc(CVector<double>& aFitParamUnc)

{
	m_aFitParamUnc = aFitParamUnc;
}

void CMarqResult::SetBeta(CVector<double>& aBeta)
{
	m_aBeta = aBeta;
}

bool   nsCMarqResult::operator < (const CMarqResult& lhs, const CMarqResult& rhs ) 
{
	CVector<double> a = lhs.GetFitParam();
	CVector<double> b = rhs.GetFitParam();

	if ( a.Size() < 3 || b.Size() < 3 || a.Size() != b.Size() ) return false;
	//center of the first fitted peak
	return  ( a[2] < b[2] ) ;
}


bool  nsCMarqResult::operator> (const CMarqResult& lhs, const CMarqResult& rhs ) 
{
	CVector<double> a = lhs.GetFitParam();
	CVector<double> b = rhs.GetFitParam();

	if ( a.Size() < 3 || b.Size() < 3 || a.Size() != b.Size() ) return false;
	//center of the first fitted peak
	return  ( a[2] > b[2] ) ;

//	return ( !(lhs < rhs) );
		
}


CMarqResult& CMarqResult::operator = ( const CMarqResult & lhs )
{
	if ( this == &lhs ) 
	;
	else
	{
		CopyMember(lhs);
	}
	return *this;
}

void CMarqResult::CopyMember(const CMarqResult& lhs)
{
	m_aFitParam			= lhs.m_aFitParam;
	m_aFitParamUnc		= lhs.m_aFitParamUnc;
	m_aBeta				= lhs.m_aBeta;
	m_nTotalParam		= lhs.m_nTotalParam;
	m_nPeaks			= lhs.m_nPeaks;
	m_nParam			= lhs.m_nParam;
	m_nMarqIterations	= lhs.m_nMarqIterations;
	m_dReducedChiSquare = lhs.m_dReducedChiSquare;
	m_lamda				= lhs.m_lamda;
	m_aFittedArea		= lhs.m_aFittedArea;
	m_bFitFailed		= lhs.m_bFitFailed;
	m_dGrossCounts		= lhs.m_dGrossCounts;
	m_dStartXValue		= lhs.m_dStartXValue;
	m_dEndXValue		= lhs.m_dEndXValue;

}
CMarqResult::CMarqResult(const CMarqResult& lhs)
{
	CopyMember(lhs);
}

bool   nsCMarqResult::operator== (const CMarqResult& lhs, const CMarqResult& rhs ) 
{
	CVector<double> a = lhs.GetFitParam();
	CVector<double> b = rhs.GetFitParam();

	if ( a.Size() < 3 || b.Size() < 3 || a.Size() != b.Size() ) return false;

	bool bEq = true;

	for ( int i=1; i<= a.Size(); ++i )
	{
		if ( a[i] != b[i] )
		{
			bEq = false;
			break;
		}
	}
	return bEq;
}

bool   nsCMarqResult::operator != (const CMarqResult& lhs, const CMarqResult& rhs)
{
	
	CVector<double> a = lhs.GetFitParam();
	CVector<double> b = rhs.GetFitParam();

	if ( a.Size() < 3 || b.Size() < 3 || a.Size() != b.Size() ) return true;

	bool bEq = false;

	for ( int i=1; i<= a.Size(); ++i )
	{
		if ( a[i] != b[i] )
		{
			bEq = true;
			break;
		}
	}
	return bEq;

//	return ( !(lhs == rhs) ) ;
}


CMarqResult::~CMarqResult()
{

}

void CMarqResult::SetFittedArea(CVector<double>& area)
{
	m_aFittedArea = area;
}

CVector<double> CMarqResult::GetFittedArea() const
{
	//return by value
	return m_aFittedArea;
}

const CVector<double>* CMarqResult::AccessFittedArea() const
{
	return &m_aFittedArea;
}

#ifdef _DEBUG
const CVector<double> CMarqResult::GetFitParamUnc()
{
	int nhigh = m_aFitParamUnc.HighBounds();
	int nlow  = m_aFitParamUnc.LowBounds();
	double tmp = 0;
	for ( int i = nlow; i <= nhigh; i++ )
	{
		tmp = m_aFitParamUnc[i];
	}

	return m_aFitParamUnc;
}

const CVector<double> CMarqResult::GetFitParam() const 
{
	int nhigh = m_aFitParamUnc.HighBounds();
	int nlow  = m_aFitParamUnc.LowBounds();
	double tmp = 0;
	for ( int i = nlow; i <= nhigh; i++ )
	{
		tmp = m_aFitParam[i];
	}

	return m_aFitParam;
}

#endif
