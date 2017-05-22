
#ifndef __Notifier_h
#define __Notifier_h

#include "ThreadUtils.h"

#ifndef _EMBEDDED   // implementation depends on whether or not this is an embedded build

#include <afxtempl.h>

class TNotifierListNode;
//
// NOTE: Events should be defined as bits that can be OR'ed together, because they
// will be anytime two events occur before notification message goes out!
//
class TNotifier : public CWnd {
public:
    TNotifier(LPARAM lpObjID);
    ~TNotifier();
    void Notify(HWND);
    void Notify(HWND,UINT uMessage);
    void UnNotify(HWND);
    // DeclareEvent sends out notifications immediately if called by the user 
    // thread. This allows people to find out about invalidated pointers 
    // immediately before anybody has a chance to use them. Deadly embraces 
    // can't occur if the DeclareEvent is called on the user thread because
    // the message response also occurs on the user thread which will fall through
    // any critical section request that is already owned by the function calling
    // DeclareEvent. 
    // Events declared by worker threads go out asynchronously on the user thread
    // via normal message handling. The DeclareEvent function returns immediately
    // to the worker and doesn't wait for the events to go out. This prevents deadly 
    // embraces assuming the worker eventually releases any owned critial sections.
    // This means that notification of pointers invalidated by a worker thread will
    // also be delayed so DON'T INVALIDATE POINTERS ON WORKER THREADS!
    void DeclareEvent(DWORD dwNewEvents = 0);  // this is the ONLY thread safe function
    void DeferDeclareEvent(DWORD dwNewEvents); // this is the other only one
    int GetNotificationTargetCount() const;    // yet another only one
    const static UINT WM_NOTIFIER;
protected:
    CRITICAL_SECTION csEvents;   
    DWORD dwEvents;
    const LPARAM lparam;
    CWnd* pWnd;
    void NotifyWindows();
    CTypedPtrList<CPtrList,TNotifierListNode*> lstpnln; // accessed on user thread only!
    afx_msg LRESULT OnSync(WPARAM,LPARAM);
    DECLARE_MESSAGE_MAP()
};

class TNotifierListNode {
public:
    TNotifierListNode(HWND Ahwnd,UINT AuMessage) { hwnd = Ahwnd; uMessage = AuMessage; }
    HWND hwnd;
    UINT uMessage;
};

#else

class TNotifier {
public:
    TNotifier(LPARAM lpObjID);
    template <typename T> void Notify(T* pt,void (T::* ptfunc)(LPARAM,DWORD)) {    // NOT thread safe!!
        // find an empty slot
        for (int i = 0; (i < eMaxTargets) && sinkarray[i].pThat; i++);
        if (i <= eMaxTargets) {
            // fill the slot
            sinkarray[i].pThat = reinterpret_cast<TPolymorphicClass*>(pt);
            sinkarray[i].pCallBack = reinterpret_cast<TNotificationCallBackProc>(ptfunc);
        }
    }
    template <typename T> void UnNotify(T* pt,void (T::* ptfunc)(LPARAM,DWORD)) {  // NOT thread safe!!
        // find the slot
        for (int i = 0; (i < eMaxTargets) && 
                        sinkarray[i].pThat != reinterpret_cast<TPolymorphicClass*>(pt) &&
                        sinkarray[i].pCallBack != reinterpret_cast<TNotificationCallBackProc>(ptfunc); i++);
        if (i < eMaxTargets) sinkarray[i].pThat = 0;
    }
    void DeclareEvent(DWORD dwNewEvents = 0);  
    void DeferDeclareEvent(DWORD dwNewEvents); 
    int GetNotificationTargetCount() const;    
protected:
    TAutoCriticalSection csEvents;   
    DWORD dwEvents;
    const LPARAM lparam;

    class TPolymorphicClass { virtual void foo(); };
    enum { eMaxTargets = 20 };
    typedef void (TPolymorphicClass::*TNotificationCallBackProc)(LPARAM,DWORD);
    struct TNotificationSinkElement {
        TPolymorphicClass* pThat;
        TNotificationCallBackProc pCallBack;
    } sinkarray[eMaxTargets];
};


#endif

#endif
