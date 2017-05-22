#ifndef  __VECTOR_H
#define __VECTOR_H

#include <assert.h>
#include <vector>
#include <algorithm>
using namespace std;
///////////////////////////////////////////////////////////////////////////////////////////////////////
//	Warning C4001:
//
//	A single-line comment ( int i = 1; // comment, instead of int i = 1; /* comment */ ),
//	which is a Microsoft extension to C (but standard in C++), was used in a C source file.
//
//	Compiler Warning (level 1) C4020:
//
//	'function' : too many actual parameters
//	 The number of actual parameters specified in a function call was greater than the number of formal 
//	 parameters specified in the function prototype or function definition.
//	 The extra actual parameters were passed according to the calling convention used on the function.
//
///////////////////////////////////////////////////////////////////////////////////////////////////


#pragma warning(disable: 4001 4020)
////////////////////////////////////////////////////////////////////////////////
// This template class is designed for an array of data. It replaces the more
// cubersome C style arrays which are typically not safe in terms of array bounds,
// memory allocations, etc. 
//
/////////////////////////////////////////////////
template <class T>
class CVector
{
	public:
		CVector();
		CVector( int nHi, int nLo = 0 );
		CVector( const CVector<T>& v );
		CVector<T>& operator = ( const CVector<T>& v );
		//friend bool EqualAndResize(CVector<T>& vDest,const CVector<T>& vSrc);
		CVector<T>& operator += (const CVector<T>& v);
		friend CVector<T> operator + (const CVector<T>& v1, const CVector<T>& v2 );
		virtual ~CVector(){}

		T& operator[](int i); 
		const T& operator[](int i) const;
		//
		const T& At(int pos) const;
		T&       At(int pos);

		int HighBounds() const 
		{ return m_nHighBounds; }

		int LowBounds() const
		{ return m_nLowBounds; }

		int Size() const { return m_Data.size(); }
		
		void SetLowBounds(size_t newVal); 
		void Reserve(size_t n);
		void Resize (size_t n);					// // Just change the size and keep the low bounds
		void Resize (size_t n, int nLow);
		void Clear();
		void Push_Back(const T& val);
		int  Find(const T& t);
		void Reverse();
		bool Remove(size_t n);
		int  Erase(const T& val);
		bool InsetFirstPoint(const T& val);
		bool InsetSecondPoint(const T& val,bool bAfterFirstPoint = true);
		bool InsertAt(const T& val, size_t n);
		vector<T>::iterator Begin();
		vector<T>::iterator End();
		vector<T>::const_iterator Begin()const;
		vector<T>::const_iterator End()const;

		const T* GetData();		// direct access to the data

	private:
		int			m_nHighBounds;
		int			m_nLowBounds;
		vector<T>	m_Data;
};

template <class T>
CVector<T>::CVector()
:m_nHighBounds(0),
 m_nLowBounds(0)
{}

template <class T>
CVector<T>::CVector( int nHi, int nLo )
:m_nHighBounds( nHi ),
 m_nLowBounds( nLo ),
 m_Data( m_nHighBounds - m_nLowBounds + 1 )
{}

template <class T>
CVector<T>::CVector
( 
	const CVector<T>& v 
)
:	m_nLowBounds(v.m_nLowBounds),
	m_nHighBounds(v.m_nHighBounds),
	m_Data(v.m_Data)
{
	int nSize = m_nHighBounds - m_nLowBounds + 1;
	if ( nSize >= 0 ) m_Data.resize(nSize);
}

template <class T>		
CVector<T>& CVector<T>::operator = 
( 
	const CVector<T>& v 
)
{
	if ( this != &v ) {
		m_nHighBounds = v.m_nHighBounds;
		m_nLowBounds = v.m_nLowBounds;
		m_Data = v.m_Data;
		int nSize = m_nHighBounds - m_nLowBounds  + 1;
		if ( nSize >= 0 ) m_Data.resize(nSize);
	}
	return *this;
}

template <class T>		
CVector<T>& CVector<T>::operator +=
(
	const CVector<T>&	v 
)
{
	int nSize2		= v.Size();
	if ( nSize2 <= 0 ) return *this;

	int nLow		= v.LowBounds();
	int nSize1		= m_Data.size();

	m_Data.resize(nSize1 + nSize2);

	if ( m_nHighBounds == 0 && m_nLowBounds == 0 ) m_nLowBounds = nLow;

	m_nHighBounds = nSize1 + nSize2 + (m_nLowBounds - 1);
	//where to "existing" element ends. Note that m_Data is zero based !
	int nStart = nSize1 - 1;
	
	for ( int i = nLow, j = 1; i<=nSize2 + nLow - 1; ++i)
	{
		m_Data[nStart + j] = v[i];
		j++;
	}
	
	return *this;
}

template <class T>		
CVector<T> operator +
(
	const CVector<T>&	v1, 
	const CVector<T>&	v2 
)
{
	int nSize1		= v1.Size();
	int nSize2		= v2.Size();
	
	CVector<T> sum(nSize1+nSize2,1);
	//add. sum low bound starts at 1 
	for ( int i=1, j = v1.LowBounds(); i<=nSize1; ++i)
		sum[i] = v1[j++];
	for ( i=1, j = v2.LowBounds(); i<=nSize2; ++i)
		sum[nSize1 + i] = v2[j++];
	
	return sum;
}

template <class T>
T& CVector<T>::operator[](int i)
{
	return m_Data[ i - m_nLowBounds ];
}

template <class T>
const T& CVector<T>::operator[](int i) const
{
	return m_Data[ i - m_nLowBounds ];
}

template <class T>
void CVector<T>::Push_Back(const T& val)
{
	// insert a single data point
	m_Data.push_back(val);
	if ( m_nHighBounds == 0 && m_nLowBounds == 0 ) {
		m_nHighBounds	= 1;
		m_nLowBounds	= 1; 
	} else {
		m_nHighBounds++;
	}
}

template <class T>
void CVector<T>::Reserve(size_t n)
{
	m_Data.reserve(n);
}

template <class T>
void CVector<T>::Resize(size_t n)
{
	// Just change the size and keep the low bounds
	m_Data.resize(n);
	m_nHighBounds = n + (m_nLowBounds - 1);
}

template <class T>
void CVector<T>::Resize(size_t n, int nLow)
{
	m_Data.resize(n);
	//
	// Resizing in two steps: First, adjust the high bounds only, cashe the resuting
	// bound values into hi and lo. Then, take into account the fact that
	// low bounds has to be changed as well.
	//
	//Here we only change the high bounds
	m_nHighBounds = n + (m_nLowBounds - 1);
	//cashe the results
	int Hi	= m_nHighBounds;
	int Lo	= m_nLowBounds;
	//now, take into account that the low bounds may need change as well
	assert (nLow >=0 ); 
	//function discontinuous at n = 1 since we use high and low bounds inclusively
	if ( n == 1 )		
	{
		m_nLowBounds	= nLow;	
		m_nHighBounds	= nLow;
	}
	else
	{
		m_nLowBounds	= nLow;	
		//m_nHighBounds	= n + nLow - 1;
		m_nHighBounds	= Hi + (nLow - Lo);
	}
}


template <class T>
void CVector<T>::SetLowBounds(size_t newVal)
{
	int Hi	= m_nHighBounds;
	int Lo	= m_nLowBounds;
	if ( newVal >=0 && newVal <= m_nHighBounds ) 
	{
		m_nLowBounds = newVal;	
		m_nHighBounds = Hi + (newVal - Lo);
	}
}

template <class T>
void CVector<T>::Clear()
{
	m_Data.clear();
	m_nHighBounds = m_nLowBounds = 0;
}
/*
//call this one instead of "=" when passing one vector in and
//don't know the size of the left hand side operand
template <class T>
bool EqualAndResize 
( 
	CVector<T>& vDest,
	const CVector<T>& vSrc 
)
{
	bool bAssigned = false;

	if ( &vDest == &vSrc )
	{
		//check for assignment to self
		//nothing done
	}
	else
	{
		int nhigh = vSrc.m_nHighBounds;
		int nlow =  vSrc.m_nLowBounds;
		
		if ( nhigh != 0 && nlow !=0 )
		{
			vDest.Clear();
			vDest.Resize(nhigh - nlow + 1, nlow);
			int iIndex = 0;
			for ( int i = nlow; i <= nhigh; i++ )
			{
				(vDest.m_Data)[iIndex] = (vSrc.m_Data)[iIndex];
				iIndex++;
			}
			//it's done
			bAssigned = true;
		}
	}
	return bAssigned;
}

*/

template <class T>
const T& CVector<T>::At(int pos) const
{
	int i = pos - m_nLowBounds;
	// at() will check bounds
	return m_Data.at(i);
}

template <class T>
T&	CVector<T>::At(int pos)
{
	int i = pos - m_nLowBounds;
	// at() will check bounds
	return m_Data.at(i);
}

template <class T>
int CVector<T>:: Find(const T& t)
{
	int n = -1;
	vector<T>::const_iterator iter = std::find(m_Data.begin(),m_Data.end(),t);
	if ( iter != m_Data.end() ) {			// find it. Which element it is?
		n = static_cast<int>( iter - m_Data.begin() );				// which element, zero based index
		if ( n < 0 || n > m_nHighBounds ) n = -1;					// incorrect index, don't know how to handle
		else							  n = n + m_nLowBounds;		// correct index based on m_nLowBounds
	}
	return n;;
}
template <class T>
void CVector<T>::Reverse()
{
	//reverse the order of elements
	std::reverse(m_Data.begin(),m_Data.end());
}
template <class T>
bool CVector<T>:: Remove(size_t n)
{
	if ( n >= m_nLowBounds && n <= m_nHighBounds ) {		// erase element at index n
		m_Data.erase(m_Data.begin() + ( n - m_nLowBounds ) );
		m_nHighBounds--;
		return true;
	}
	return false;
}

template <class T>
int CVector<T>:: Erase(const T& val)
{
	int n = Find(val);
	if ( n != -1 ) {
		if ( !Erase(n) ) n = -1;				// if failed to erase 
	}
	return n;
}
template <class T>
bool CVector<T>::InsetFirstPoint(const T& val)
{
	bool bret = false;
	if ( m_nHighBounds == 0 && m_nLowBounds == 0 ) {
		m_Data.push_back(val);		
		m_nHighBounds	= 1;
		m_nLowBounds	= 1; 
		bret = true;
	} 
	return bret;
}

template <class T>
bool CVector<T>::InsetSecondPoint(const T& val, bool bAfterFirstPoint)
{
	bool bret = false;
	if ( m_nHighBounds == 1 && m_nLowBounds == 1 ) {
		if ( bAfterFirstPoint ) m_Data.push_back(val);		
		else                    m_Data.insert(m_Data.begin(),val);
		m_nHighBounds++;
		bret = true;
	} 
	return bret;
}
template <class T>
bool CVector<T>::InsertAt(const T& val,size_t n)
{
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Important! If the array is empty and if using this call to insert elements, for the first element
	// pass n = -1, instead of n = 0, sicne if n = 0 is passed the first time, the low bounds will not be
	// set correctly and there will be element size mismatch problem. For the second element, if you want
	// to put before the ONE and ONLY element, pass 1, otherwise, pass -1 to insert at the end.
	// After those two points, the element will be inserted before the n-th element
	//
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	if ( n >= m_nLowBounds && n <= m_nHighBounds ) {
		m_Data.insert( (m_Data.begin() + (n-m_nLowBounds)), val);			//insert before element n. If m_nLowBounds == 0 && m_nHighBounds == 0, and if we use 1 based index, then there are elements already
		m_nHighBounds++;
	} else {
		m_Data.push_back(val);												//this coul be the first element, so check bounds
		if ( m_nHighBounds == 0 && m_nLowBounds == 0 ) {
			m_nHighBounds	= 1;
			m_nLowBounds	= 1; 
		} else {
			m_nHighBounds++;
		}
	}
	return true;
}
template <class T>
vector<T>::iterator CVector<T>::Begin()
{
	return m_Data.begin();
}

template <class T>
vector<T>::iterator CVector<T>::End()
{
	return m_Data.end();
}

template <class T>
vector<T>::const_iterator CVector<T>::Begin() const
{
	return m_Data.begin();
}

template <class T>
vector<T>::const_iterator CVector<T>::End() const
{
	return m_Data.end();
}

template <class T>
const T* CVector<T>::GetData()		// direct access to the data
{
	//call size first to get to know the data size 
	vector<T>::const_iterator iter = m_Data.begin();
	const T* p = 0;
	if ( iter != m_Data.end() ) {
		p = iter;
	}
	return p;
}


#endif
