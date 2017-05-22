//MarqResults.h
#ifndef _INC_MARQRESULTS_H
#define _INC_MARQRESULTS_H

#include "vector.h"
//
// Hold the fitting results obtained from the fit engine
//
namespace nsCMarqResult {

class CMarqResult
{
public:

	CMarqResult();
	CMarqResult(const CMarqResult& lhs);

	virtual ~CMarqResult();

	void SetFitParam(CVector<double>& aFitParam);
	void SetFitParamUnc(CVector<double>& aFitParamUnc);
	void SetReducedChiSquare(double& dValue) {m_dReducedChiSquare = dValue;}
	void SetLamda(double& dValue) {m_lamda = dValue;}
	void SetTotalParam(int nValue) { m_nTotalParam = nValue;}
	void SetMarqIterations(int nValue) { m_nMarqIterations = nValue;}
	void SetBeta(CVector<double>& aBeta);
	void SetNPeaks(int nValue) { m_nPeaks = nValue;}
	void SetNParam(int nValue) { m_nParam = nValue;}

	const CVector<double> GetFitParam() const;
	const CVector<double> GetFitParamUnc();
	const CVector<double> GetBeta() const { return m_aBeta;}
	const double GetReducedChiSquare() const {return m_dReducedChiSquare;}
	const double GetLamda() const {return m_lamda;}
	const int GetTotalParam() const { return m_nTotalParam;}
	const int GetNPeaks() const { return m_nPeaks;}
	const int GetNParam() const { return m_nParam;}
	const int GetMarqIterations() const { return m_nMarqIterations;}
	void	  SetFittedArea(CVector<double>& area);
	CVector<double> GetFittedArea() const; 
	const CVector<double>* AccessFittedArea() const;
	CMarqResult& operator = ( const CMarqResult & lhs );
	friend bool  operator < (const CMarqResult& lhs, const CMarqResult& rhs);
	friend bool  operator > (const CMarqResult& lhs, const CMarqResult& rhs);
	friend bool  operator == (const CMarqResult& lhs, const CMarqResult& rhs);
	friend bool  operator != (const CMarqResult& lhs, const CMarqResult& rhs);

	void SetFitFailed(bool b) { m_bFitFailed = b; }
	bool GetFitFailed() const { return m_bFitFailed;}
	void SetStartXValue(double d) { m_dStartXValue = d;}
	double GetStartXValue() const { return m_dStartXValue;}
	void SetEndXValue(double d) { m_dEndXValue = d;}
	double GetEndXValue() const { return m_dEndXValue;}
	void SetGrossCounts(double d) { if ( d > 0 ) m_dGrossCounts = d;}
	double GetGrossCounts() const {  return m_dGrossCounts;}

protected:

	enum { MAXCHARSIZE = 256 };
	CVector<double>		m_aFitParam;
	CVector<double>		m_aFitParamUnc;
	CVector<double>		m_aBeta;
	int					m_nTotalParam;
	int					m_nPeaks;
	int					m_nParam;
	int					m_nMarqIterations;
	double				m_dReducedChiSquare;
	double				m_lamda;
	bool				m_bFitFailed;
	double				m_dStartXValue;
	double				m_dEndXValue;
	double				m_dGrossCounts;
//	char				m_pszReasonOfFailure[MAXCHARSIZE];
	//
	CVector<double>		m_aFittedArea;
	//
	void				CopyMember(const CMarqResult& lhs);

};

#ifndef _DEBUG
inline const CVector<double> CMarqResult::GetFitParamUnc()
{
	return m_aFitParamUnc;
}

inline const CVector<double> CMarqResult::GetFitParam() const 
{
	return m_aFitParam;
}

#endif

};		//end of namespace

using namespace nsCMarqResult;

#endif