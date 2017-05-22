
#ifndef  __MATRIX_H
#define __MATRIX_H

#define ARRAY_OUT_OF_BOUNDS  -20
#include "vector.h"
#include <memory>
using namespace std;

template <class T>
class CMatrix															
{                                               								
	private:  
	  int     		m_nRowHiBounds;	//upper boundary for number of rows                      							
	  int     		m_nColHiBounds;	//upper boundary for number of cols  
  	  int			m_nLowBounds;	//Lower boundary for both rows and cols
	  CVector<T>*	m_RowVector;
																								
	public:                                      								
	 CMatrix(); 														
	 CMatrix( int nRowHi, int nColHi, int nLo = 0 ); 
	 CMatrix( const CMatrix<T>& M );
	 CMatrix<T>& operator = ( const CMatrix<T>& M );
	 virtual ~CMatrix();
	 const CVector<T>& operator [] (int i) const;
	 CVector<T>& operator [] (int i);

	 int GetRowSize()	{ return m_nRowHiBounds;}
	 int GetColumnSize(){ return m_nColHiBounds;}
};

template <class T>
CMatrix<T>::CMatrix () :
	m_nLowBounds(0),
	m_nRowHiBounds(0),                            								
	m_nColHiBounds(0),
	m_RowVector(NULL)
{}                                       								

template <class T>
CMatrix<T>::CMatrix
( 
	int nRowHi, 
	int nColHi,
	int nLo
) :
  m_nRowHiBounds(nRowHi),                            								
  m_nColHiBounds(nColHi),
  m_nLowBounds(nLo),
  m_RowVector( new CVector<T> [m_nRowHiBounds - m_nLowBounds + 1])
{
 
	  for ( int i = m_nLowBounds; i <= m_nRowHiBounds; i++ )
	  {
			
		   CVector<T> v(m_nColHiBounds, m_nLowBounds);
		   (*this) [i] = v;
	  }
}

template <class T>
CMatrix<T>::~CMatrix()
{
	delete [] m_RowVector;
}

template <class T>
CMatrix<T>::CMatrix<T>
( 
	const CMatrix<T>& M 
)
{
	m_nLowBounds = M.m_nLowBounds; 
	m_nRowHiBounds = M.m_nRowHiBounds;                            								
	m_nColHiBounds = M.m_nColHiBounds;
	for ( int i = m_nLowBounds; i <= m_nRowHiBounds; i++ )
		m_RowVector[i-m_nLowBounds] = M.m_RowVector[i-m_nLowBounds];
}

template <class T>
CMatrix<T>& CMatrix<T>::operator = 
( 
	const CMatrix<T>& M 
)
{
	if ( this == &M )	//check for assignment to self
		;
		//do nothing
	else
	{
		m_nLowBounds = M.m_nLowBounds; 
		m_nRowHiBounds = M.m_nRowHiBounds;                            								
		m_nColHiBounds = M.m_nColHiBounds;
		for ( int i = m_nLowBounds; i <= m_nRowHiBounds; i++ )
			m_RowVector[i-m_nLowBounds] = M.m_RowVector[i-m_nLowBounds];
	}
	return *this;
}


template <class T>
const CVector<T>& CMatrix<T>::operator [] (int i) const
{
   assert ( i == _MIN(_MAX(m_nLowBounds,i),m_nRowHiBounds) );
   return m_RowVector[ i - m_nLowBounds ];
}

template <class T>
CVector<T>& CMatrix<T>::operator [] (int i)
{
	assert ( i == _MIN(_MAX(m_nLowBounds,i),m_nRowHiBounds) );
	return m_RowVector[ i - m_nLowBounds ];
}

#endif

