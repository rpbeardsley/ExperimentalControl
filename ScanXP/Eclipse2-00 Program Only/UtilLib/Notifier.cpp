
#include "stdafx.h"
#include "Notifier.h"


#ifndef _EMBEDDED   // implementation depends on whether or not this is an embedded build

//
// static initialization
//
const UINT TNotifier::WM_NOTIFIER = RegisterWindowMessage("WM_NOTIFIER");
//
// ctor
//

const int ORTEC_USER_MSG =  WM_APP + 199;

TNotifier::TNotifier(LPARAM Alparam) : lparam(Alparam) {
    dwEvents = 0;    // Declare nothing happened;
    CreateEx(0,::AfxRegisterWndClass(0,NULL,NULL,NULL),"TNotifier",0,0,0,0,0,NULL,0,NULL);
    ::InitializeCriticalSection(&csEvents);
	CWnd* pWnd = FromHandlePermanent(m_hWnd);
}
//
// dtor
//
TNotifier::~TNotifier() {
    POSITION pos = lstpnln.GetHeadPosition();
    while (pos) { delete lstpnln.GetNext(pos); }
    lstpnln.RemoveAll();
    ::DeleteCriticalSection(&csEvents);
    DestroyWindow();
}
//
// Notify
//
void TNotifier::Notify(HWND hwnd) {
    Notify(hwnd,WM_NOTIFIER);
}
//
// Notify
//
void TNotifier::Notify(HWND hwnd,UINT uMessage) {
    lstpnln.AddHead(new TNotifierListNode(hwnd,uMessage));
}
//
// UnNotify
//
void TNotifier::UnNotify(HWND hwnd) {
    POSITION pos = lstpnln.GetHeadPosition();
    while (pos) {
        POSITION posCurrent = pos;
        TNotifierListNode* pnln = lstpnln.GetNext(pos);
        if (pnln->hwnd == hwnd) {
            delete pnln;
            lstpnln.RemoveAt(posCurrent);
        }
    }
}
//
// GetCount
//
int TNotifier::GetNotificationTargetCount() const { 
    return lstpnln.GetCount();
}

//
// DeclareEvent
//
void TNotifier::DeclareEvent(DWORD dwNewEvents) {
    DeferDeclareEvent(dwNewEvents);
    if (::GetWindowThreadProcessId(*this,NULL) == ::GetCurrentThreadId())
        NotifyWindows();
    else PostMessage(ORTEC_USER_MSG,0,0);
}
//
// DeferDeclareEvent 
//
void TNotifier::DeferDeclareEvent(DWORD dwNewEvents) {
    ::EnterCriticalSection(&csEvents);
    dwEvents |= dwNewEvents;
    ::LeaveCriticalSection(&csEvents);
}
//
// NotifyWindows
//
void TNotifier::NotifyWindows() {
    ::EnterCriticalSection(&csEvents);
    // Go ahead and declare no events so we don't recurse if we get called again by
    // one of the message response funtions.
    DWORD dwEventsLocal = dwEvents;
    dwEvents = 0;
    ::LeaveCriticalSection(&csEvents);
    if (dwEventsLocal) {
        POSITION pos = lstpnln.GetHeadPosition();
        while (pos) {
            POSITION posCurrent = pos;
            TNotifierListNode* pnln = lstpnln.GetNext(pos);
            if (::IsWindow(pnln->hwnd)) {
                // Even though a Post might be less prone to cause deadly embraces, it is
                // sometimes necessary that everybody know about the previous event right
                // now. An example is an event signaling the deletion of some object that 
                // other people have pointers to. In this case, everybody must be notified
                // now to prevent them from attempting to use that pointer. The SendMessage
                // prevents this problem -- assuming the resource wasn't invalidated by
                // a worker thread (WHICH IS NOT ALLOWED!). 
                //
                // Deadly embraces can't occur if the DeclareEvent occurs on the user thread
                // because the message response also occurs on the user thread. Events declared 
                // by worker threads are asynchronous and the DeclareEvent function returns
                // immediately. This prevents deadly embraces assuming the worker eventually
                // releases its owned critial sections.
                ::SendMessage(pnln->hwnd,pnln->uMessage,dwEventsLocal,lparam); 
            } else {
                delete pnln;
                lstpnln.RemoveAt(posCurrent);
            }
        }
    }
}

BEGIN_MESSAGE_MAP(TNotifier,CWnd)
    ON_MESSAGE(ORTEC_USER_MSG,OnSync)
END_MESSAGE_MAP()

//
// OnSync
//
LRESULT TNotifier::OnSync(WPARAM,LPARAM) {
    NotifyWindows();
    return 0;
}

#else // else do embedded system implementation

TNotifier::TNotifier(LPARAM lpObjID)
    : lparam(lpObjID) {
    for (int i =0; i < eMaxTargets; i++)
        sinkarray[i].pThat =0;
    dwEvents = 0;
}

void TNotifier::DeclareEvent(DWORD dwNewEvents) {
    DWORD dwLocalEvents;
    {
        TExclusiveAccess ex(csEvents);
        dwLocalEvents = (dwEvents | dwNewEvents);
        dwEvents = 0;
    }
    for (int i =0; i < eMaxTargets; i++) {
        if (sinkarray[i].pThat) {
            (sinkarray[i].pThat->*sinkarray[i].pCallBack)(lparam,dwLocalEvents);
        }
    }
}

void TNotifier::DeferDeclareEvent(DWORD dwNewEvents) {
    TExclusiveAccess ex(csEvents);
    dwEvents |= dwNewEvents;
}

int TNotifier::GetNotificationTargetCount() const {
    int iRet = 0;
    for (int i = 0; i < eMaxTargets; i++)
        if (sinkarray[i].pThat) iRet++;
    return iRet;
}

#endif