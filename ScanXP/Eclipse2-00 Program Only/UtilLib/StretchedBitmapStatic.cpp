#include "stdafx.h"
#include "StretchedBitmapStatic.h"

//***************************************
//
// TStretchedBitmapStatic
//
//***********
//
// ctor
//
TStretchedBitmapStatic::TStretchedBitmapStatic(UINT AnIDBitmap) 
: nIDBitmap(AnIDBitmap),hdcSrc(0) {
}

TStretchedBitmapStatic::~TStretchedBitmapStatic() {
    if (hdcSrc) {
        ::SelectObject(hdcSrc,hbmpOldSrc);
        ::DeleteDC(hdcSrc);
    }
}

void TStretchedBitmapStatic::SetBitmap(UINT AuIDBitmap) {
    // if same bitmap and already loaded in DC, don't bother
    if (hdcSrc && nIDBitmap == AuIDBitmap) return;
    // make new bitmap ID official
    nIDBitmap = AuIDBitmap; // make new bitmap ID official
    // kill any existing GDI resources
    if (hdcSrc) {
        ::DeleteObject(::SelectObject(hdcSrc,hbmpOldSrc));
        ::DeleteDC(hdcSrc);
        hdcSrc = 0;
    }
    // create and load a dc for the resource bitmap
    HDC hdcRaw = ::CreateCompatibleDC(NULL);
    CBitmap bmpRaw;
    bmpRaw.LoadBitmap(nIDBitmap);
    HGDIOBJ hbmpOldRaw = ::SelectObject(hdcRaw,bmpRaw);
    // we're gonna need the client rect
    CRect rc;
    ::GetClientRect(*this,&rc);
    // create a color Source dc for the data member
    hdcSrc = ::CreateCompatibleDC(NULL);
    HDC hdcColor = ::GetDC(NULL);
    HGDIOBJ hbmpSrc = ::CreateCompatibleBitmap(hdcColor,rc.right,rc.bottom);
    ::ReleaseDC(NULL,hdcColor);
    hbmpOldSrc = ::SelectObject(hdcSrc,hbmpSrc);

    // merge the raw bitmap into the member dc
    BITMAP bmpInfo; bmpInfo.bmBits = NULL;
    bmpRaw.GetBitmap(&bmpInfo);
    ::StretchBlt(hdcSrc,0,0,rc.right,rc.bottom,
                 hdcRaw,0,0,bmpInfo.bmWidth,bmpInfo.bmHeight,SRCCOPY);
    // clean up the raw dc
    ::SelectObject(hdcRaw,hbmpOldRaw);  // bmpRaw get deleted automatically
    ::DeleteDC(hdcRaw);
}

BEGIN_MESSAGE_MAP(TStretchedBitmapStatic,CStatic)
    ON_WM_PAINT()
END_MESSAGE_MAP()

void TStretchedBitmapStatic::OnPaint() {
    SetBitmap(nIDBitmap);
    CPaintDC dc(this);
    RECT rc;
    GetClientRect(&rc);
    ::BitBlt(dc,0,0,rc.right,rc.bottom,hdcSrc,0,0,SRCCOPY);
}
