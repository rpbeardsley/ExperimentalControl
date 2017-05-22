// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#ifndef _EMBEDDED
#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxmt.h>
#include <afxtempl.h>
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows 95 Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT

#else   // _EMBEDDED
#include <stdio.h>
#ifdef _DEBUG
#define ASSERT(x) if (!(x)) DebugBreak();
#define TRACE   //::printf
#else
#define ASSERT(x)
#define TRACE   1 ? (void)0 : ::printf
#endif
#include <windows.h>
#endif // _EMBEDDED



