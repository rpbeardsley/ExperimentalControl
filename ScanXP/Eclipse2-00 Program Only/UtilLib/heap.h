
#ifndef __Heap_h
#define __Heap_h

#include <memory.h>

// abstract iteration position
#ifndef __TPOSITIONDEFINED
#define __TPOSITIONDEFINED
struct __TPOSITION { };
typedef __TPOSITION* TPOSITION;
#endif

template <class T> 
class THeap {
public: 
    inline THeap(int iInitialSize,int AiGrowBy,bool (T::*AIsLargerThan)(const T&,LPARAM) const,LPARAM Alparam)
        : iGrowBy(AiGrowBy) { 
        IsLargerThan = AIsLargerThan;
        lparam = Alparam;
        iSize = iInitialSize;
        ppt = static_cast<T**>(malloc(sizeof(T*)*(iSize+1)));    // we use a "1" based array!!!
        iCount = 0;
    }
    inline THeap(const THeap<T>& other) 
        : iGrowBy(other.iGrowBy) {
        CopyOther(other);
    }
    inline THeap<T>& operator=(const THeap<T>& other) {
        free(ppt);
        CopyOther(other);
        return *this;
    }
    inline ~THeap() { free(ppt); }
    void Insert(T*);
    T* Remove();
    void ReHeap(bool (T::*AIsLargerThan)(const T&,LPARAM) const,LPARAM Alparam,int iNewCount = 0);
    // MFC style iteration functions
    inline TPOSITION GetHeadPosition() const { return (TPOSITION)1; }
    T* GetNext(TPOSITION& pos) const;
    T*& GetNext(TPOSITION& pos);
    inline T*& GetAt(TPOSITION pos) const { return ppt[(int)pos]; }
    inline T* GetAt(TPOSITION pos) { return ppt[(int)pos]; }
    inline int GetCount() const { return iCount; }
    inline bool IsEmpty() const { return iCount == 0; }
protected:
    void Up(int iBottom);
    void Down(int iTop);
    static inline int DadIndx(int iSonIndx) { return iSonIndx/2; }
    static inline int SonIndx(int iDadIndx) { return iDadIndx+iDadIndx; }
    static inline int BroIndx(int iSonIndx) { return iSonIndx^1; }
    inline int LastSon() const { return iCount; }
    inline int LastDad() const { return DadIndx(LastSon()); }
    void IncCount();
    void CopyOther(const THeap<T>&);
    int iCount;
    int iSize;
    const int iGrowBy;
    T** ppt;    // array of pointer to be heaped, this array is "1-based" to make parent/child calcs simple
    bool (T::*IsLargerThan)(const T&,LPARAM) const;
    LPARAM lparam;
};

//*****************************************************************************************
//
// Implementation is in the header since Visual C++ 5.0 doesn't support the export keyword!
//
template <class T> 
void THeap<T>::Insert(T* pt) {
    IncCount();             // declare one more element on the heap
    ppt[iCount] = pt;       // put the new element at the end
    Up(iCount);             // push new element up till heap is valid again
}
template <class T>
T* THeap<T>::Remove() {
    if (!iCount) return 0;
    T* ptRet = ppt[1];      // pull largest value off top
    ppt[1] = ppt[iCount];   // and replace with last value
    iCount--;               // declare one less element
    Down(1);                // push current top value down until the heap is valid again
    return ptRet;
}
template <class T>
void THeap<T>::ReHeap(bool (T::*AIsLargerThan)(const T&,LPARAM) const,LPARAM Alparam,int iNewCount) {
    IsLargerThan = AIsLargerThan;
    lparam = Alparam;
    if (iNewCount) iCount = iNewCount;
    // Do bottom up heap construction from random initial contents
    for (int i = LastDad(); i; i--) Down(i);
}
template <class T>
T*& THeap<T>::GetNext(TPOSITION& pos) {
    int iIndex = (int)pos;
    pos = (TPOSITION)((iIndex == iCount) ? 0 : (iIndex+1));
    return ppt[iIndex];
}
template <class T>
T* THeap<T>::GetNext(TPOSITION& pos) const {
    int iIndex = (int)pos;
    pos = (TPOSITION)((iIndex == iCount) ? 0 : (iIndex+1));
    return ppt[iIndex];
}
template <class T>
void THeap<T>::CopyOther(const THeap<T>& other) {
    IsLargerThan = other.IsLargerThan;
    lparam = other.lparam;
    iSize = other.iSize;
    ppt = static_cast<T**>(malloc(sizeof(T*)*(iSize+1)));    // we use a "1" based array!!!
    iCount = other.iCount;
    memcpy(ppt,other.ppt,(iCount+1)*sizeof(T*));
}
// Take value at iSon and push it up the heap until the 
// heap is valid.
template <class T>
void THeap<T>::Up(int iSon) {
    T* pt = ppt[iSon];                 // temp copy of the value to promote up
    int iDad = DadIndx(iSon);          // init current dad location
    while (iDad && (pt->*IsLargerThan)(*ppt[iDad],lparam)) { // Is relation invalid (is son bigger than dad)?
        ppt[iSon] = ppt[iDad];         // if so, put the dad in the son's position
        iSon = iDad;                   // declare next test position for son
        iDad = DadIndx(iSon);          // declare new dad location
    }
    ppt[iSon] = pt;    // put original son in new location
}
// Take value at iDad and push it down the heap until the 
// heap is valid.
template <class T>
void THeap<T>::Down(int iDad) {
    T* pt = ppt[iDad];              // temp copy of the value to move down
    const int iLastDad = LastDad(); // remember index of last dad
    while (iDad <= iLastDad) {      // while iDad is still has a son
        int iSon = SonIndx(iDad);   // get first son
        if (iSon < LastSon()) {         // if we have two sons, we must check the larger
            int iBro = BroIndx(iSon);   // get other son
            if ((ppt[iBro]->*IsLargerThan)(*ppt[iSon],lparam))  // if second son is larger
                iSon = iBro;            // then second son as son of interest     
        }
        if (ppt[iSon]->IsLargerThan(*pt,lparam)) { // is relation invalid (is son bigger than dad)?
            ppt[iDad] = ppt[iSon];        // if so, put the son in the dad's position 
            iDad = iSon;                // declare next test position of dad
        } else break;                   // if relation is now valid, we are done
    }
    ppt[iDad] = pt;  // put original dad in new location
}

template <class T>
void THeap<T>::IncCount() {
    if (iCount == iSize) {
        iSize += iGrowBy;
        ppt = static_cast<T**>(realloc(ppt,sizeof(T*)*(iSize+1)));    // we use a "1" based array!!!
    }
    iCount++;
}


#endif
