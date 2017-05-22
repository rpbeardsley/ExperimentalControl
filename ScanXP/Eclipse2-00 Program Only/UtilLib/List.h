
#ifndef __List_h
#define __List_h

// abstract iteration position
#ifndef __TPOSITIONDEFINED
#define __TPOSITIONDEFINED
#ifndef __AFX_H__
struct __POSITION { };
typedef __POSITION* POSITION;
#endif
#define TPOSITION POSITION
#endif

template <class T> 
struct TListNode {
    TListNode(const T& At) : t(At) { pPrev = pNext = NULL; }
    TListNode* pPrev;
    TListNode* pNext;
    T t;
};

template <class T> 
class TList {
public:
    inline TList() { iCount = 0; pHead = pTail = NULL; }
    inline ~TList() { RemoveAll(); }
    TList<T>& operator=(const TList<T>&);
    TPOSITION AddHead(const T&);
    TPOSITION AddTail(const T&);
    void RemoveAt(TPOSITION);
    void Remove(const T&);
    void RemoveAll();
    inline int GetCount() const { return iCount; }
    inline bool IsEmpty() const { return iCount == 0; }
    inline TPOSITION GetHeadPosition() const { return (TPOSITION)pHead; }
    inline TPOSITION GetTailPosition() const { return (TPOSITION)pTail; }
    inline T& GetHead() const { return pHead->t; }
    inline T& GetTail() const { return pTail->t; }
    T& GetNext(TPOSITION& pos) const;
    T& GetPrev(TPOSITION& pos) const;
    inline T& GetAt(TPOSITION pos) const { return ((TListNode<T>*)pos)->t; }
    TPOSITION Find(const T&) const;
//    TPOSITION SortedInsert(const T&);
    TPOSITION InsertAfter(TPOSITION,const T&);
protected:
    int iCount;
    TListNode<T>* pHead;
    TListNode<T>* pTail;
};

//*****************************************************************************************
//
// Implementation is in the header since Visual C++ 5.0 doesn't support the export keyword!
//

//
// operator=
//
template <class T>
TList<T>& TList<T>::operator=(const TList<T>& src) {
    RemoveAll();
    if (!src.IsEmpty()) {
        TPOSITION pos = src.GetHeadPosition();
        while (pos) AddTail(src.GetNext(pos));
    }
    return *this;
}

//
// AddHead
// 
template <class T>
TPOSITION TList<T>::AddHead(const T& t) {
    TListNode<T>* pn = new TListNode<T>(t);
    if (iCount == 0) 
        pHead = pTail = pn;
    else {
        pHead->pPrev = pn;
        pn->pNext = pHead;
        pHead = pn;
    }
    iCount++;
    return (TPOSITION)pn;
}
//
// AddTail
// 
template <class T>
TPOSITION TList<T>::AddTail(const T& t) {
    TListNode<T>* pn = new TListNode<T>(t);
    if (iCount == 0) 
        pHead = pTail = pn;
    else {
        pTail->pNext = pn;
        pn->pPrev = pTail;
        pTail = pn;
    }
    iCount++;
    return (TPOSITION)pn;
}
//
// Find
//
template <class T>
TPOSITION TList<T>::Find(const T& tFind) const {
    TPOSITION pos = GetHeadPosition();
    while (pos) {
        if (tFind == GetAt(pos)) return pos;
        GetNext(pos);
    }
    return NULL;
}
//
// RemoveAt
//
template <class T>
void TList<T>::RemoveAt(TPOSITION pos) {
    TListNode<T>* pn = (TListNode<T>*) pos;
    if (pn->pPrev) pn->pPrev->pNext = pn->pNext;
    if (pn->pNext) pn->pNext->pPrev = pn->pPrev;
    if (pn == pHead) pHead = pn->pNext; 
    if (pn == pTail) pTail = pn->pPrev;
    delete pn;
    iCount--;
}
//
// GetNext
//
template <class T>
T& TList<T>::GetNext(TPOSITION& pos) const {
    TListNode<T>* pn = (TListNode<T>*)pos;
    T& tRet = pn->t;
    pos = (TPOSITION)(pn->pNext);
    return tRet;
}
//
// GetPrev
//
template <class T>
T& TList<T>::GetPrev(TPOSITION& pos) const {
    TListNode<T>* pn = (TListNode<T>*)pos;
    T& tRet = pn->t;
    pos = (TPOSITION)(pn->pPrev);
    return tRet;
}
//
// RemoveAll
//
template <class T>
void TList<T>::RemoveAll() {
    TPOSITION pos = GetHeadPosition();
    while (pos) {
        TPOSITION posKill = pos;
        GetNext(pos);
        delete (TListNode<T>*)posKill;
    }
    pHead = pTail = NULL;
    iCount = 0;
}
//
// Remove
//
template <class T>
void TList<T>::Remove(const T& t) {
    TPOSITION pos = Find(t);
    if (pos) RemoveAt(pos);
}
//
// InsertAfter
//
template <class T>
TPOSITION TList<T>::InsertAfter(TPOSITION pos,const T& t) {
    TListNode<T>* pn = (TListNode<T>*)pos;
    TListNode<T>* pnNew = new TListNode<T>(t);
    pnNew->pPrev = pn;
    pnNew->pNext = pn->pNext;
    if (pn->pNext) pn->pNext->pPrev = pnNew;
    pn->pNext = pnNew;
    return (TPOSITION)pnNew;
}
/*
//
// SortedInsert
//
template <class T>
TPOSITION TList<T>::SortedInsert(const T& t) {
    if (IsEmpty() || t < pHead->t) 
        return AddHead(t);
    if (t <= pHead->t)
        return AddTail(t);
    TPOSITION pos = GetTailPosition();
    while (pos) {
        const T& tTest = GetAt(pos);
        if (t >= tTest) return InsertAfter(pos,t);
        GetNext(pos);
    }
}
*/
#endif
