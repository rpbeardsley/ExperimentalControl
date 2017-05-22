
#ifndef __ThreadUtils_h
#define __ThreadUtils_h 
//
// TAutoCriticalSection -- automatically initializes and deletes itself
// Put this in the class/struct to be protected (simplier than having the
// parent objects ctor/dtor maintain the critical section manually)
// Note that this object can be used anywhere a LPCRITICALSECTION is called for.
//
// Example:
// 
//      class T {
//          .
//          .
//      public:
//          // thread safe setter/getters 
//          void GetName(char* pszNameBack,int iMaxLen) const;
//          void SetName(const char* pszNewName);
//      private:
//          char m_szName[400];   // only one thread allowed to muck with this at a time
//          TAutoCriticalSection m_csName;
//          .
//          .
//          
//      };
//
class TAutoCriticalSection {
public:
    TAutoCriticalSection() { ::InitializeCriticalSection(&cs); }
    inline ~TAutoCriticalSection() { ::DeleteCriticalSection(&cs); }
    inline operator LPCRITICAL_SECTION() { return &cs; }
    CRITICAL_SECTION cs;
};

//
// TExclusiveAccess -- Declare one on the stack to get ownership of a critical
//  section. Critical section is automatically released as soon as stack variables
//  are deleted -- even works if an exception is thrown while the critical section
//  is owned.
//
//  Example: (look at example for TAutoCriticalSection also for a corresponding
//            class definition)
//
//      void T::SetName(const char* pszNewName) {
//          TExclusiveAccess ex(m_csName);  // NOT "TExclusiveAccess(m_csName);" !!!!!!
//          // we can do stuff here with szName knowing that no other thread 
//          // can be messing with the szName at the same time
//          strncpy(m_szName,pszNewName,sizeof(m_szName));
//          m_szName[sizeof(m_szName)-1] = 0;
//      }   // critical section automagically released here
//
//      void T::GetName(char* pszNameBack,int iMaxSize) const {
//          TExclusiveAccess ex(m_csName);
//          strncpy(pszNameBack,m_szName,iMaxSize);
//          pszNameBack[iMaxSize-1] = 0;
//      }
//
class TExclusiveAccess {
public:
    inline TExclusiveAccess(LPCRITICAL_SECTION Apcs):pcs(Apcs) { ::EnterCriticalSection(pcs); }
    inline ~TExclusiveAccess() { ::LeaveCriticalSection(pcs); }
protected:
    CRITICAL_SECTION* const pcs;
};

//
// TAutoMutex -- A mutex that automatically creates and destroys itself
// Put this in the class/struct to be protected (simplier than having the
// parent objects ctor/dtor maintain the critical section manually)
// Note that this object can be used anywhere a handle to a mutex is used.
//
//  Example: (look at example for TAutoCriticalSection)
//
class TAutoMutex {
public:
    TAutoMutex() {
        mutex = NULL;
    }

    TAutoMutex(const char *szName) {
        mutex = ::CreateMutex(NULL, FALSE, szName);
        if(mutex == NULL) {
            ::OutputDebugString("*** TAutoMutex \"");
            ::OutputDebugString(szName);
            ::OutputDebugString("\" Constructor Failed ***\r\n");
        }
    }

    void Create(const char *szName) {
        if(mutex == NULL) {
            mutex = ::CreateMutex(NULL, FALSE, szName);
            if(mutex == NULL) {
                ::OutputDebugString("*** TAutoMutex \"");
                ::OutputDebugString(szName);
                ::OutputDebugString("\" Create Failed ***\r\n");
            }
        } else {
            ::OutputDebugString("*** TAutoMutex \"");
            ::OutputDebugString(szName);
            ::OutputDebugString("\" Attempted second Create ***\r\n");
        }
    }
    inline ~TAutoMutex() { if(mutex != NULL) CloseHandle(mutex); }
    inline operator HANDLE() { return mutex; }
    HANDLE mutex;
};

//
// TMutexAccess -- Declare one on the stack to enter a mutually exclusive section
//  (mutex protected section). Mutex is automatically released as soon as the variable
//  is deleted -- even works if an exception is thrown while in the mutex section.
//
//  Example: (look at example for TAutoCriticalSection)
//
class TMutexAccess {
public:
    inline TMutexAccess(HANDLE hMutex) : m_hMutex(hMutex) {
        if(WaitForSingleObject(m_hMutex, INFINITE) == WAIT_FAILED) {
            ::OutputDebugString("*** TMutexAccess Wait Failed ***\r\n");
        }
    }
    inline ~TMutexAccess() { if(m_hMutex != NULL) ReleaseMutex(m_hMutex); }
protected:
    HANDLE const m_hMutex;
private:
    TMutexAccess();   // Must not use default ctor!
};

// 
// TWorkerThread -- Declare one as a member of a class that needs are worker thread.
//  The worker will be guaranteed to shut down gracefully when the parent object of 
//  is deleted. The thread proc should be a member function. It doesn't have to be
//  static and can even be virtual. The worker thread will start when the TWorkerThread's
//  Start fuction is called and will stop when the Stop function is called or when the
//  parent object is deleted. 
//
// Example:
//
//  struct TSomeDocument {
//      TSomeDocument() : wtPrint(this,Print) {    // init wtPrint in ctor
//          // other initialization
//      }
//          .
//          .
//      void StartPrint() { wtPrint.Start(); }
//      void CancelPrint() { wtPrint.Stop(); }
//          .
//          .
//  protected:
//      // the worker thread declaration
//      TWorkerThread<TSomeDocument> wtPrint;
//      // the thread proc
//      UINT Print(TWorkerThread<TSomeDocument>* pwt) {
//          // print a little
//          .
//          .
//          pwt->CheckStop();   // throws exception if somebody says stop
//          // print a little more
//          .
//          .
//          pwt->CheckStop();   // throws exception if somebody says stop
//          // print a little more
//          .
//          .
//          return 0;   // ret value not currently used by anybody
//      }
//  };
// 
//
template <typename T>
class TWorkerThread {
public:
    typedef UINT (T::*TWorkerThreadProc)(TWorkerThread<T>*);
    TWorkerThread(T* Apt,TWorkerThreadProc Aproc,int AnPriority = THREAD_PRIORITY_NORMAL)
        : proc(Aproc),pt(Apt),nPriority(AnPriority),hthrd(INVALID_HANDLE_VALUE),
          hevtStop(::CreateEvent(NULL,TRUE,FALSE,NULL)) { }
    ~TWorkerThread() { Stop(); ::CloseHandle(hevtStop); };
    // Useful functions for the parent object to call
    void Start() {
        if (IsRunning()) return;                    // already started?
        ::ResetEvent(hevtStop);                     // reset previous worker thread shutdown
#ifndef _EMBEDDED   // implementation depends on whether or not this is an embedded build
        hthrd = *::AfxBeginThread(ThreadProc,this,nPriority);
#else
        hthrd = _beginthread(static_cast<void (*)(void*)>(ThreadProc),8192,this);
#endif
    }
    void Stop() {
        if (!IsRunning()) return;                   // not running?
        ::SetEvent(hevtStop);                       // initiate worker thread shutdown
        ::WaitForSingleObject(hthrd, INFINITE);     // wait forever for thread to exit
        hthrd = INVALID_HANDLE_VALUE;
    }
    bool AttemptStop(DWORD dwMilliSecTimeOut) { 
        if (!IsRunning()) return true;  // no problem if already stoped
        ::SetEvent(hevtStop);           // initiate worker thread shutdown
        DWORD dw = ::WaitForSingleObject(hthrd,dwMilliSecTimeOut);
        // Note that if thread stoped after we asked "IsRunning", then hthrd will 
        // now be INVALID_HANDLE_VALUE, and the WaitForSingleObject will return
        // WAIT_FAILED instead of WAIT_OBJECT_0.
        // Return false if thread won't stop -- leave it to user to take drastic actions
        return (dw == WAIT_OBJECT_0) || (dw == WAIT_FAILED); 
    }
    bool IsRunning() const { return (hthrd != INVALID_HANDLE_VALUE); }
    // Useful functions for the thread proc to call
    bool ShouldStop() const { return ::WaitForSingleObject(hevtStop,0) == WAIT_OBJECT_0; }
    void CheckStop() const { if (ShouldStop()) throw EThreadStop(); }
    HANDLE GetStopEvent() const { return hevtStop; }
    class EThreadStop { }; // throw one of these in the thread to stop
private:
    const HANDLE hevtStop;
    const TWorkerThreadProc proc;
    T* const pt;
    HANDLE hthrd;
    const int nPriority;
    static UINT ThreadProc(LPVOID pv);
};

template <typename T>
UINT TWorkerThread<T>::ThreadProc(LPVOID pv) {
    TWorkerThread* pThis = static_cast<TWorkerThread<T>*>(pv);
    UINT uRet = 0xBADDBADD;
    try {
        uRet = (pThis->pt->*(pThis->proc))(pThis);
    } catch (EThreadStop) {  }
    pThis->hthrd = INVALID_HANDLE_VALUE;    // we're good as gone
    return uRet;
}

//
// Example of Use:
//
//  void foo(TLocakableThing* pThing) {
//      TLock<TLockableThing> lock(pThing);
//      // NOTE: TLockableThing must have "Lock" and "Unlock" functions
//      .
//      .
//      do stuff (exception throwing is ok, pThing will get Unlocked anyway)
//      .
//      .
//  }
//
template <typename T>
struct TLock {
    TLock(T* Apt) : pt(Apt) { pt->Lock(); }
    ~TLock() { pt->Unlock(); }
private:
    T* pt;
};

//
// Example of Use:
//
//  void foo() {
//      TAutoHANDLE hFile = ::CreateFile(.......); // or any system handle!
//      .
//      .
//      do stuff (exception throwing is ok, file will be closed)
//      .
//      .
//  }
//
struct TAutoHANDLE {
    inline TAutoHANDLE() : h(INVALID_HANDLE_VALUE) { }
    inline TAutoHANDLE(HANDLE Ah) : h(Ah) { }
    inline TAutoHANDLE& operator=(const HANDLE& Ah) 
        { if (h != INVALID_HANDLE_VALUE) ::CloseHandle(h); h = Ah; return *this; }
    inline ~TAutoHANDLE() { if (h != INVALID_HANDLE_VALUE) ::CloseHandle(h); }
    inline operator HANDLE&() { return h; }
private:
    HANDLE h;
};

#ifndef _EMBEDDED   // TAutoMapViewOfFile not implemented for embedded systems
//
// Example of Use:
//
//  void foo() {
//      TAutoHANDLE hFile = ::CreateFile(.......);
//      TAutoHANDLE hMapping = ::CreateFileMapping(hFile,....);
//      // example is for file of bytes, but we could use any type of record
//      TAutoMapViewOfFile<BYTE> pFile = 
//                       static_cast<const BYTE*>(::MapViewOfFile(hMapping,....));
//      .
//      .
//      do stuff (exception throwing is ok, 
//                          map will be unmapped, 
//                          mapping will be closed, 
//                          and file will be closed -- in the right order! )
//      .
//      .
//  }
//
template <typename T>
struct TAutoMapViewOfFile {
    inline TAutoMapViewOfFile() : pt(0) {}
    inline TAutoMapViewOfFile(T* Apt) : pt(Apt) {}
    inline TAutoMapViewOfFile<T>& operator=(T* Apt) 
        { if (pt) ::UnmapViewOfFile(pt); pt = Apt; return *this; }
    inline ~TAutoMapViewOfFile() { if (pt) ::UnmapViewOfFile(pt); }
    typedef T* PTR_T;
    inline operator PTR_T() { return pt; }
private:
    T* pt;
};
#endif // not _EMBEDDED



#endif
