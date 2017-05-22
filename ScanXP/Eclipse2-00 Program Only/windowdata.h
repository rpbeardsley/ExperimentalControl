//CWindowData Header

#if !defined _WINDOWDATA__H
#define _WINDOWDATA__H


class CBaseWindowData : public CObject
{
public:
	CBaseWindowData(double* pData = NULL, int iNumPoints = 0, bool bCopyData = false);
	~CBaseWindowData();

	virtual bool Calculate() = 0;

	virtual void SetData(double* pData = NULL, int iNumPoints = 0);
	virtual double* GetData(){return m_pData;}
	

protected:
	

	double* m_pData;
	bool m_bCopyData;
	int m_iNumPoints;
};

class CParzenWindow : public CBaseWindowData
{
public:

	CParzenWindow(double* pData = NULL, int iNumPoints = 0, bool bCopyData = false);
	~CParzenWindow();

	virtual bool Calculate();

protected:
	

};

class CHanningWindow : public CBaseWindowData
{
public:

	CHanningWindow(double* pData = NULL, int iNumPoints = 0, bool bCopyData = false);
	~CHanningWindow();

	virtual bool Calculate();

protected:
	

};

#endif