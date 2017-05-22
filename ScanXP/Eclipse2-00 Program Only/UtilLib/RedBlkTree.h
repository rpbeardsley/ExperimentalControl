
#ifndef __RedBlkTree_h
#define __RedBlkTree_h

// abstract iteration position
#ifndef __TPOSITIONDEFINED
#define __TPOSITIONDEFINED
#ifndef __AFX_H__
struct __POSITION { };
typedef __POSITION* POSITION;
#endif
#define TPOSITION POSITION
#endif

// incase some fool arbitrarily redefined new (as in afxTempl.h)
#ifdef new
#undef new
#endif

#ifdef _DEBUG
#define CHECKBALANCE() //CheckBalance();
#define CHECKBALANCEBUT(posBut) //CheckBalance(posBut);
#else
#define CHECKBALANCE()
#define CHECKBALANCEBUT(posBut)
#endif

#pragma warning(disable:4291)   // problems if exception generated within new operator

namespace NRedBlkTreeLocal {
    template <class T> struct TNodePool;
    template <class T> struct TNodeInfo;
    template <class T> struct TNodeNode;
}

template <class T> 
struct TRedBlkTreeNode {
    void* operator new(size_t n,NRedBlkTreeLocal::TNodePool<T>*);
    void operator delete(void*);
    TRedBlkTreeNode(T* Apt) : pt(Apt) { InitLinks(); }
    TRedBlkTreeNode() : pt(0) { InitLinks(); }
    inline void InitLinks() { pPrev = pLess = pMore = 0; eclr = blk; }
    TRedBlkTreeNode* pPrev;
    TRedBlkTreeNode* pLess;
    TRedBlkTreeNode* pMore;
    enum ERedBlack { blk, red } eclr;
    T* pt;
    inline bool Is4node() const { return pMore->IsRed() && pLess->IsRed(); }
    inline bool IsLessThanParent() const { return (this == pPrev->pLess); }
    inline bool IsBlack() const { return this ? (eclr == blk) : true; }
    inline bool IsRed() const { return !IsBlack(); }
};

namespace NRedBlkTreeLocal {
    template <class T> 
    struct TNodeInfo {
        TNodePool<T>* pPool;       // initialized on pool creation and never changed
        TNodeNode<T>* pNextFree;
    };
    
    // define multiply derived class to allow easy conversion of node info
    // and node pointers
    template <class T>
    struct TNodeNode : public TNodeInfo<T>, public TRedBlkTreeNode<T> {
    };

    template <class T> 
    struct TNodePool {
        void* operator new(size_t n,int iMaxNodes);
        void operator delete(void*);
        inline TNodePool(int AiNodeChunkSize);
        inline ~TNodePool() { delete pNextPool; }
        bool AnyRoomLeft() const { return (pNextFree != 0) ? true : (pNextPool && pNextPool->AnyRoomLeft()); }
        const int iNodeChunkSize;
        TNodePool<T>* pNextPool;  
        TNodeNode<T>* pNextFree;
        TNodeNode<T> nodes[1];     // probably a lot more than one
    };

    template <class T>
    TNodePool<T>::TNodePool(int AiNodeChunkSize) : iNodeChunkSize(AiNodeChunkSize) {
        pNextPool = 0;
        for (int i = 0; i < iNodeChunkSize; i++) {
            nodes[i].pPool = this;
            nodes[i].pNextFree = &nodes[i+1];
        }
        nodes[iNodeChunkSize-1].pNextFree = 0;
        pNextFree = nodes;
    }

    template <class T>
    void* TNodePool<T>::operator new(size_t n,int iMaxNodes) {
        // do ctor type work here while we know how many nodes to initialize
        return malloc(sizeof(TNodePool<T>)+sizeof(TNodeNode<T>)*(iMaxNodes-1));
    }
    template <class T>
    void TNodePool<T>::operator delete(void* p) {
        free(p);
    }
}

template <class T>
void* TRedBlkTreeNode<T>::operator new(size_t,NRedBlkTreeLocal::TNodePool<T>* pPool) {
    NRedBlkTreeLocal::TNodeNode<T>* pnnRet = pPool->pNextFree;
    while (!pnnRet) {
        if (!pPool->pNextPool) 
            pPool->pNextPool = new(pPool->iNodeChunkSize) NRedBlkTreeLocal::TNodePool<T>(pPool->iNodeChunkSize);
        pPool = pPool->pNextPool;
        pnnRet = pPool->pNextFree;
    }
    pPool->pNextFree = pnnRet->pNextFree;
    return static_cast<TRedBlkTreeNode<T>*>(pnnRet); // modifies value to take TRedBlkTreeNode<T> part only
}

template <class T>
void TRedBlkTreeNode<T>::operator delete(void* p) {
    TRedBlkTreeNode<T>* pn = (TRedBlkTreeNode<T>*)p;
    // back the pointer down to the full TNodeNode object 
    NRedBlkTreeLocal::TNodeNode<T>* pnn = (NRedBlkTreeLocal::TNodeNode<T>*)pn;
    pnn->pNextFree = pnn->pPool->pNextFree;
    pnn->pPool->pNextFree = pnn;
}

template <class T> 
class TRedBlkTree {
public: 
    typedef bool (T::*TreeCmpFunc)(const T&) const;
    inline TRedBlkTree(int AiNodeChunk = 100) 
        { iCount = 0; 
          pRoot = 0; 
          pIsLargerThan = &T::operator>; 
          pIsEqualTo = &T::operator==; 
          pPool = new(AiNodeChunk) NRedBlkTreeLocal::TNodePool<T>(AiNodeChunk);
        }
    inline TRedBlkTree(TreeCmpFunc ApIsLargerThan,TreeCmpFunc ApIsEqualTo,int AiNodeChunk = 100) 
        { iCount = 0; 
          pRoot = 0; 
          pIsLargerThan = ApIsLargerThan; 
          pIsEqualTo = ApIsEqualTo;  
          pPool = new(AiNodeChunk) NRedBlkTreeLocal::TNodePool<T>(AiNodeChunk);
        }
    inline ~TRedBlkTree() { RemoveAll(); delete pPool; }

    TPOSITION Insert(T*);
    void RepositionAt(TPOSITION);
    inline TPOSITION Find(const T* pt) const { return FindFrom(pt,pRoot); }
    TPOSITION FindNodeLessThanOrEqualTo(const T* ptTest) const;
    void RemoveAt(TPOSITION);
    inline void Remove(const T* pt) { RemoveAt(Find(pt)); }
    TPOSITION GetHeadPosition() const;
    TPOSITION GetTailPosition() const;
    T* GetNext(TPOSITION& pos) const;
    T* GetPrev(TPOSITION& pos) const;
    inline T* GetAt(TPOSITION pos) const 
        { return reinterpret_cast<TRedBlkTreeNode<T>*>(pos)->pt; }
    inline void RemoveAll() { if (pRoot) Prune(pRoot); pRoot = 0; }
    inline int GetCount() const { return iCount; }
    inline bool IsEmpty() const { return iCount == 0; }
#ifdef _DEBUG
    inline void Trace() const { PrintFrom(pRoot,0); }
    void CheckBalance(TPOSITION posBut = 0) const;
#endif

protected:
    int iCount;
    TRedBlkTreeNode<T>* pRoot;
    TPOSITION Insert(TRedBlkTreeNode<T>*);
    TRedBlkTreeNode<T>* RemoveAtButDontDelete(TPOSITION);
    void Rotate(TRedBlkTreeNode<T>* pParent,TRedBlkTreeNode<T>* pChild);
    void Split(TRedBlkTreeNode<T>*);
    TRedBlkTreeNode<T>* Leastest(TRedBlkTreeNode<T>* pn);
    inline const TRedBlkTreeNode<T>* Leastest(const TRedBlkTreeNode<T>* pn) const 
        { return const_cast<TRedBlkTree<T>*>(this)->Leastest(const_cast<TRedBlkTreeNode<T>*>(pn)); }
    TRedBlkTreeNode<T>* Greatest(TRedBlkTreeNode<T>* pn);
    inline const TRedBlkTreeNode<T>* Greatest(const TRedBlkTreeNode<T>* pn) const
        { return const_cast<TRedBlkTree<T>*>(this)->Greatest(const_cast<TRedBlkTreeNode<T>*>(pn)); }
    void Prune(TRedBlkTreeNode<T>*);
    TPOSITION FindFrom(const T* pt,TRedBlkTreeNode<T>* pn) const;
    void ReBalanceAfterRemove(TRedBlkTreeNode<T>* pParent,TRedBlkTreeNode<T>* pInvalidHead);
#ifdef _DEBUG
    int CheckBalanceFrom(const TRedBlkTreeNode<T>* p,TPOSITION posBut = 0) const;
    void PrintFrom(const TRedBlkTreeNode<T>* p,int iIndent) const;
#endif
    TreeCmpFunc pIsLargerThan;
    TreeCmpFunc pIsEqualTo;
    NRedBlkTreeLocal::TNodePool<T>* pPool;
};

//*****************************************************************************************
//
// Implementation is in the header since Visual C++ 5.0 doesn't support the export keyword!
//
template <class T>
TPOSITION TRedBlkTree<T>::Insert(T* pt) {
    TRedBlkTreeNode<T>* pnNew = new(pPool) TRedBlkTreeNode<T>(pt);
    return Insert(pnNew);
}
template <class T>
TPOSITION TRedBlkTree<T>::Insert(TRedBlkTreeNode<T>* pnNew) {
    if (iCount++ == 0) {
        pRoot = pnNew;
    } else {
        TRedBlkTreeNode<T>* pn = pRoot;
        while (true) {
            if (pn->Is4node()) Split(pn);
            TRedBlkTreeNode<T>*& pnNext = (pnNew->pt->*pIsLargerThan)(*pn->pt) ? pn->pMore : pn->pLess;
            if (!pnNext) {
                pnNext = pnNew;  // link pn to new child
                pnNew->pPrev = pn;
                Split(pnNew);    // push new node up into previous 2-node or 3-node
                break;
            }
            pn = pnNext;
        }
    }
    CHECKBALANCE()
    return reinterpret_cast<TPOSITION>(pnNew);
}
// This function should be called any the the value of an item is changed such that
// the tree may no longer be sorted properly. This function modifies the node to
// revalidate the tree. Note that the pos for the node is unchanged so folks that
// remember pos values don't get their pos values invalidated.
template <class T>
void TRedBlkTree<T>::RepositionAt(TPOSITION pos) {
    CHECKBALANCEBUT(pos)
    TRedBlkTreeNode<T>* pn = RemoveAtButDontDelete(pos);
    pn->InitLinks();
    Insert(pn);
}
template <class T>
void TRedBlkTree<T>::RemoveAt(TPOSITION pos) {
    delete RemoveAtButDontDelete(pos);
}
template <class T>
TRedBlkTreeNode<T>* TRedBlkTree<T>::RemoveAtButDontDelete(TPOSITION pos) {
    // convert pos to a corresponding node pointer
    TRedBlkTreeNode<T>* pDel = reinterpret_cast<TRedBlkTreeNode<T>*>(pos);
    // dec count, handle special case of empty tree
    if (--iCount == 0) {
        pRoot = 0;      // no more tree
        return pDel; 
    }
    // We need to modify the tree so the node we get rid of has one
    // or no children. We can then collapse the tree around that node.
    //
    // Start by assuming node to delete has one or no children
    TRedBlkTreeNode<T>* pHasOneOrNoChild = pDel;   
    // if assumption was wrong go find "next" node to swap places with
    // pDel. The "next" node is guaranteed to have one or no children.
    if (pDel->pLess && pDel->pMore)        
        pHasOneOrNoChild = Leastest(pDel->pMore);
    
    //
    // Colapse the tree around pHasOneOrNoChild
    // 
    // Removing a black node will decrease the black node count to the bottom of the
    // tree and require tree modifications to maintain balance of the tree. Remember
    // the color of the node to be removed. This might even cause two reds in a row
    // but the ReBalanceAfterRemove function will take care of that also.
    bool bRemovedBlack = pHasOneOrNoChild->IsBlack();
    TRedBlkTreeNode<T>* pHasOneOrNoChildParent = pHasOneOrNoChild->pPrev;
    // Get the parent pointer to pHasOneOrNoChild. Note that it is possible than pHasOneOrNoChild has no
    // parent if pDel is the root and one or no children (pDel == pHasOneOrNoChild)
    TRedBlkTreeNode<T>*& pParentPtr = !pHasOneOrNoChildParent ? pRoot :
                                          (pHasOneOrNoChild->IsLessThanParent() ? 
                                               pHasOneOrNoChildParent->pLess : pHasOneOrNoChildParent->pMore);
    // Get the single child to be linked to pHasOneOrNoChild's parent
    TRedBlkTreeNode<T>* pTheOneChild = pHasOneOrNoChild->pMore ? pHasOneOrNoChild->pMore : pHasOneOrNoChild->pLess;
    // Do the link removing pHasOneOrNoChild
    pParentPtr = pTheOneChild;
    if (pTheOneChild) pTheOneChild->pPrev = pHasOneOrNoChildParent;
    //
    // If we the node we just took out, isn't the node to delete, we
    // need to move that node to pDel's location (keeping pDel's color)
    if (pHasOneOrNoChild != pDel) {
        T* ptRestore = pHasOneOrNoChild->pt;    // remember the sources data pointer
        *pHasOneOrNoChild = *pDel;              // now pHasOneOrNoChild thinks its where pDel is. (and also has its pt)
        pHasOneOrNoChild->pt = ptRestore;       // restore pHasOneOrNoChild's pt
        // note that pHasOneOrNoChild has at least one child and probably two!
        // Fix the uplink's in the new children
        if (pHasOneOrNoChild->pLess) pHasOneOrNoChild->pLess->pPrev = pHasOneOrNoChild;
        if (pHasOneOrNoChild->pMore) pHasOneOrNoChild->pMore->pPrev = pHasOneOrNoChild;
        // Fix down link of parent to go to pHasOneOrNoChild instead of pDel
        TRedBlkTreeNode<T>*& pParentPtr = !pDel->pPrev ? pRoot :
                                              (pDel->IsLessThanParent() ? 
                                                   pDel->pPrev->pLess : pDel->pPrev->pMore);
        pParentPtr = pHasOneOrNoChild;
        // if we moved the removed node up only one notch, then pHasOneOrNoChildParent was pDel, which isn't 
        // correct. The real parent of pTheOneChild is actually pHasOneOrNoChild.
        if (pHasOneOrNoChildParent == pDel)
            pHasOneOrNoChildParent = pHasOneOrNoChild;
    } 
    // At this point, no links exist to pDel
    if (bRemovedBlack) 
        ReBalanceAfterRemove(pHasOneOrNoChildParent,pTheOneChild);
    CHECKBALANCE()
    return pDel;
}

template <class T>
TPOSITION TRedBlkTree<T>::GetHeadPosition() const {
    return (TPOSITION)(Leastest(pRoot));
}

template <class T>
TPOSITION TRedBlkTree<T>::GetTailPosition() const {
    return (TPOSITION)(Greatest(pRoot));
}

template <class T>
T* TRedBlkTree<T>::GetNext(TPOSITION& pos) const {
    T* ptRet = GetAt(pos);
    const TRedBlkTreeNode<T>*& pn = reinterpret_cast<TRedBlkTreeNode<T>*&>(pos);
    if (pn->pMore) {
        pn = Leastest(pn->pMore);
    } else {
        while (pn->pPrev && !pn->IsLessThanParent()) 
            pn = pn->pPrev;
        pn = pn->pPrev;
    }
    return ptRet;
}

template <class T>
T* TRedBlkTree<T>::GetPrev(TPOSITION& pos) const {
    T* ptRet = GetAt(pos);
    const TRedBlkTreeNode<T>*& pn = reinterpret_cast<TRedBlkTreeNode<T>*&>(pos);
    if (pn->pLess) {
        pn = Greatest(pn->pLess);
    } else {
        while (pn->pPrev && pn->IsLessThanParent()) 
            pn = pn->pPrev;
        pn = pn->pPrev;
    }
    return ptRet;
}

template <class T>
void TRedBlkTree<T>::Rotate(TRedBlkTreeNode<T>* pParent,TRedBlkTreeNode<T>* pChild) {
    // move current grandparent down link to go directly to child
    TRedBlkTreeNode<T>*& pGrandParentPtr = !pParent->pPrev ? pRoot :
                                              (pParent->IsLessThanParent() ? 
                                                  pParent->pPrev->pLess : pParent->pPrev->pMore);
    pGrandParentPtr = pChild;
    // move child uplink to go directly to grandparent to complete the move
    pChild->pPrev = pParent->pPrev;

    // get references to what is the current middle node pointer, and what will be the
    // new middle node pointer (so we don't have to keep checking which child). Can't
    // use IsLessThanParent function because child's parent is already changed to the
    // grandparent!
    bool bChildOnLessSide = (pParent->pLess == pChild);
    TRedBlkTreeNode<T>*& pOldMiddle = bChildOnLessSide ? pChild->pMore : pChild->pLess;
    TRedBlkTreeNode<T>*& pNewMiddle = bChildOnLessSide ? pParent->pLess : pParent->pMore;
    // replace the parent to child link with a link from the parent to the middle
    pNewMiddle = pOldMiddle;
    if (pNewMiddle) pNewMiddle->pPrev = pParent;
    // replace the old child to middle node link with a link from child to parent
    pOldMiddle = pParent;
    pParent->pPrev = pChild;
}

template <class T>
void TRedBlkTree<T>::Split(TRedBlkTreeNode<T>* p) {
    ASSERT(p->IsBlack());     // must be top of a 4-node
    // Start by doing a simple color flip. 
    // For the case where p is the root, we just convert the root 
    // from a 4-node into a 2-node and add a level to the tree. The 
    // root is always black.
    // For the case where p is a brand new node with no children,
    // we just make to new node red to begin pushing it into the
    // previous 2-node or 3-node.
    if (p->pLess) p->pLess->eclr = TRedBlkTreeNode<T>::blk;
    if (p->pMore) p->pMore->eclr = TRedBlkTreeNode<T>::blk;
    if (p->pPrev) p->eclr = TRedBlkTreeNode<T>::red;
    else return;
    // hopefully, our parent is black, otherwise we just made an invalid change
    // to the tree and will have to correct it. Note that if our parent is the
    // root, then our parent can't be red. Therefore our parent can't be the 
    // root if our parent is red. If our parent is not the root, we are 
    // guaranteed to have a grandparent as well.
    if (p->pPrev->IsRed()) {
        if (p->IsLessThanParent() != p->pPrev->IsLessThanParent()) {
            Rotate(p->pPrev,p);
            p->eclr = TRedBlkTreeNode<T>::blk;
            p->pPrev->eclr = TRedBlkTreeNode<T>::red;
            Rotate(p->pPrev,p);
        } else {
            p->pPrev->eclr = TRedBlkTreeNode<T>::blk;
            p->pPrev->pPrev->eclr = TRedBlkTreeNode<T>::red;
            Rotate(p->pPrev->pPrev,p->pPrev);
        }
    }
    CHECKBALANCE()
}

template <class T>
TRedBlkTreeNode<T>* TRedBlkTree<T>::Leastest(TRedBlkTreeNode<T>* pn) {
    if (!pn) return 0;
    while (pn->pLess) pn = pn->pLess;
    return pn;
}

template <class T>
TRedBlkTreeNode<T>* TRedBlkTree<T>::Greatest(TRedBlkTreeNode<T>* pn) {
    if (!pn) return 0;
    while (pn->pMore) pn = pn->pMore;
    return pn;
}

template <class T>
void TRedBlkTree<T>::Prune(TRedBlkTreeNode<T>* p) {
    if (p->pLess) Prune(p->pLess);
    if (p->pMore) Prune(p->pMore);
    if (p->pPrev)
        if (p->IsLessThanParent())
            p->pPrev->pLess = 0;
        else
            p->pPrev->pMore = 0;
    delete p;
}

template <class T>
TPOSITION TRedBlkTree<T>::FindFrom(const T* pt,TRedBlkTreeNode<T>* pn) const {
    if (!pn) return 0;
    if (pn->pt == pt) return reinterpret_cast<TPOSITION>(pn);
    if ((pt->*pIsLargerThan)(*pn->pt)) {
        return FindFrom(pt,pn->pMore);
    } else if ((pt->*pIsEqualTo)(*pn->pt)) {
        // could be on either side, so search both
        TPOSITION posMore;
        if (posMore = FindFrom(pt,pn->pMore)) 
            return posMore;
        else 
            return FindFrom(pt,pn->pLess);
    } else 
        return FindFrom(pt,pn->pLess);
}

template <class T>
TPOSITION TRedBlkTree<T>::FindNodeLessThanOrEqualTo(const T* ptTest) const {
    TRedBlkTreeNode<T>* pnLess = 0;
    TRedBlkTreeNode<T>* pn = pRoot;
    while (pn) {
        if ((ptTest->*pIsLargerThan)(*pn->pt)) {
            pnLess = pn;    // register as a possible canidate for return value
            pn = pn->pMore;
        } else if ((ptTest->*pIsEqualTo)(*pn->pt)) {
            pnLess = pn;    // by golly, this is it
            pn = 0;         // force look break
        } else { // else must be less
            pn = pn->pLess;
        }
    }
    return reinterpret_cast<TPOSITION>(pnLess);
}

// The colapsing of the tree around a black node raises all nodes previously below the removed node up
// one black height. The purpose of this function is to push those nodes back down, or alternatively to
// raise everybody else. pInvalidHead is the node that was the removed node's child (which will be NULL  
// if the removed node had no children -- which is why we have to pass the parent in as well). pParent 
// is the parent of the removed node which is now the parent of pInvalidHead.
template <class T>
void TRedBlkTree<T>::ReBalanceAfterRemove(TRedBlkTreeNode<T>* pParent,TRedBlkTreeNode<T>* pInvalidHead) {
    // muck with the list while.....
    // pInvalidHead != pRoot, otherwise this is an indication that the depth of the entire tree has been
    //                        lowered by one and all we have to do is ensure the root is left black. Note
    //                        that pInvalidHead can walk up the tree (per case 2a) and eventually reach
    //                        the root even if that's not where it started.
    // AND
    // pInvalidHead->IsBlack, otherwise (case 0) we just make pInvalidHead black which pushes it and all 
    //                        its children down one black height.
    while (pInvalidHead != pRoot && pInvalidHead->IsBlack()) {
        // Note than pInvalidHead is guaranteed to not be the root in here, and therefore it is guaranteed
        // to have a parent. Also note that pInvalidHead is guaranteed to have a sibling, otherwise the
        // path through the sibling couldn't be longer than the path thru pInvalidHead (which is the reason
        // we are here in the first place. CAUTION pInvalidHead may be NULL so we can't use it's
        // IsLessThanParent function.

        // Ensure sibling is black first (case 1, sibling is red)
        TRedBlkTreeNode<T>* pSibling = (pParent->pLess == pInvalidHead) ? pParent->pMore : pParent->pLess;
        if (pSibling->IsRed()) {    // (case 1)
            // Note parent must be black if pSibling is red. 
            // Also, sibling must have two children if it is red since it must take more black's to 
            // get to the bottom thru the sibling than thru pInvalidHead. This indicates that
            // the new sibling will also be non-NULL.
            pSibling->eclr = TRedBlkTreeNode<T>::blk;   // swap colors on sibling and parent
            pParent->eclr = TRedBlkTreeNode<T>::red;
            Rotate(pParent,pSibling);
            pSibling = (pParent->pLess == pInvalidHead) ? pParent->pMore : pParent->pLess;
        }
        // Case 2a and 2b, siblings children are black
        if (pSibling->pLess->IsBlack() && pSibling->pMore->IsBlack()) {
            // pull otherside up to match depth of pInvalidHead, then worry about pushing the
            // parent back down.
            pSibling->eclr = TRedBlkTreeNode<T>::red;
            // if parent is currently red (2b), loop will end on next iteration and make parent black to
            // validate the tree. If parent is currently black (2a) we will loop again trying to push
            // down the redefined pInvalidHead (unless the new parent turns out to be the NULL).
            pInvalidHead = pParent;
            pParent = pInvalidHead->pPrev;
        } else {    // at least one of sibling's children are red (case 3 or case 4)
            TRedBlkTreeNode<T>* pSiblingsFarChild = (pParent->pLess == pInvalidHead) ? pSibling->pMore : pSibling->pLess;
            // case 3 ensures siblings far child is red for case 4
            if (pSiblingsFarChild->IsBlack()) { // and therefore, sibling's near child is red (case 3)
                TRedBlkTreeNode<T>* pSiblingsNearChild = (pParent->pLess == pInvalidHead) ? pSibling->pLess : 
                                                                                            pSibling->pMore;
                // since siblings near child is red, it must not be NULL. Swap colors of sibling's 
                // near child and sibling and rotate.
                pSiblingsNearChild->eclr = TRedBlkTreeNode<T>::blk; // child was red, so sibling must be black
                pSibling->eclr = TRedBlkTreeNode<T>::red;           // sibling takes childs color
                Rotate(pSibling,pSiblingsNearChild);
                pSiblingsFarChild = pSibling;
                pSibling = pSiblingsNearChild; // still guaranteed non-NULL
            }
            // case 4 sibling's far child is red
            pSibling->eclr = pParent->eclr;
            pParent->eclr = TRedBlkTreeNode<T>::blk;
            if (pSiblingsFarChild->IsRed())     // also checks for pSiblingsFarChild == NULL!
                pSiblingsFarChild->eclr = TRedBlkTreeNode<T>::blk;
            Rotate(pParent,pSibling);
            // Done, tree is valid again
            pInvalidHead = pRoot;   // cheap trick to end loop and force root black
            pParent = 0;            // shouldn't really be necessary.....
        }
    }
    // Loop ends whenever pInvalidHead is red or pInvalidHead is the root. If pInvalidHead is the root,
    // the entire tree depth has been effectively decreased by one and all that is left to do is ensure
    // the root is left black. Otherwise, turning pInvalidHead from red to black pushes pInvalidHead and 
    // all its children down a notch to validate the tree. Note that pInvalidHead will be NULL if the 
    // removed node had no children.
    if (pInvalidHead) pInvalidHead->eclr = TRedBlkTreeNode<T>::blk;
}

#ifdef _DEBUG
template <class T>
void TRedBlkTree<T>::CheckBalance(TPOSITION posBut) const {
    if (!pRoot) return;
    ASSERT(pRoot->IsBlack());
    CheckBalanceFrom(pRoot,posBut);
}

template <class T>
int TRedBlkTree<T>::CheckBalanceFrom(const TRedBlkTreeNode<T>* p,TPOSITION posBut) const {
    if (!p) return 1;
    ASSERT(!p->pMore || p->pMore->pPrev == p);
    ASSERT(!p->pLess || p->pLess->pPrev == p);
    // return black node count to end of the line
    int iMoreCount = CheckBalanceFrom(p->pLess,posBut);
    int iLessCount = CheckBalanceFrom(p->pMore,posBut);
    ASSERT(iMoreCount == iLessCount);
    int iRet = iMoreCount;
    if (p->IsBlack())
        iRet++;
    else {
        // if we are red, we better have a black parent
        ASSERT(p->pPrev->IsBlack());
        // and both our children better be black
        ASSERT(p->pLess->IsBlack());
        ASSERT(p->pMore->IsBlack());
    }
    if (p->pPrev) {
        const TRedBlkTreeNode<T>* pnBut = reinterpret_cast<TRedBlkTreeNode<T>*>(posBut);
        if (p != pnBut && p->pPrev != pnBut) {
            if (p->IsLessThanParent()) {
                ASSERT(!(p->pt->*pIsLargerThan)(*p->pPrev->pt));
            } else {
                ASSERT((p->pt->*pIsLargerThan)(*p->pPrev->pt) || (p->pt->*pIsEqualTo)(*p->pPrev->pt));
            }
        }
    }
    return iRet;
}

template <class T>
void TRedBlkTree<T>::PrintFrom(const TRedBlkTreeNode<T>* p,int iIndent) const {
    CString strMargin(' ',3*iIndent);
    if (!p)
        TRACE(strMargin + "Leaf\n");
    else {
        CString strVal = p->pt->GetValueText();
        TRACE(strMargin + strVal + "@%x %s\n",p,p->IsBlack() ? "blk" : "red");
        iIndent++;
        PrintFrom(p->pLess,iIndent);
        PrintFrom(p->pMore,iIndent);
    }
}
#endif

#endif
