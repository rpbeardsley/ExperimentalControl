//CQuadFit Header

#if !defined _QUADFIT__H
#define _QUADFIT__H


class CQuadFit : public CObject
{
public:

	CQuadFit(double dX1 = 0.0, double dY1 = 0.0, double dX2 = 0.0, double dY2 = 0.0, double dX3 = 0.0, double dY3 = 0.0, bool bPerformFit = false); 

	virtual void SetX1(double dX, double dY){m_dX1 = dX, m_dY1 = dY;}
	virtual void SetX2(double dX, double dY){m_dX2 = dX, m_dY2 = dY;}
	virtual void SetX3(double dX, double dY){m_dX3 = dX, m_dY3 = dY;}

	virtual bool PerformFit();

	virtual double GetA(){return m_dA;}
	virtual double GetB(){return m_dB;}
	virtual double GetC(){return m_dC;}

protected:
	double m_dX1;
	double m_dY1;

	double m_dX2;
	double m_dY2;

	double m_dX3;
	double m_dY3;

	double m_dA;
	double m_dB;
	double m_dC;
};

#endif