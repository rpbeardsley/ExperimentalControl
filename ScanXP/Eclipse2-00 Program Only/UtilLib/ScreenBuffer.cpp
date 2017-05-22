#include "stdafx.h"

#include "ScreenBuffer.h"

TScreenBuffer::TScreenBuffer() {
    hdcMem = hdcView = NULL;
    hbmp = hbmpOriginal = NULL;
}

TScreenBuffer::~TScreenBuffer() {
    Clear();
}

void TScreenBuffer::Clear() {
    if (hdcMem) {
        ::SelectObject(hdcMem,hbmpOriginal);
        hbmpOriginal = NULL;
        ::DeleteObject(hbmp);
        hbmp = NULL;
        ::DeleteDC(hdcMem);
        hdcMem = NULL;
    }
}

void TScreenBuffer::Load(HDC hdc,const RECT* prcVisible) {
    ASSERT(hdcMem == NULL);
    hdcView = hdc;
    rcView = *prcVisible;
    hdcMem = ::CreateCompatibleDC(hdcView);
    int iWidth = rcView.right-rcView.left;
    int iHeight = rcView.bottom-rcView.top;
    hbmp = ::CreateCompatibleBitmap(hdcView,iWidth,iHeight);
    hbmpOriginal = (HBITMAP)::SelectObject(hdcMem,hbmp);
    ::BitBlt(hdcMem,0,0,iWidth,iHeight,hdcView,0,0,SRCCOPY);
}

void TScreenBuffer::Restore(const RECT* prc) {
    ASSERT(hdcView);
    RECT rcIntersect;
    ::IntersectRect(&rcIntersect,prc,&rcView);
    int iWidth = rcIntersect.right-rcIntersect.left;
    int iHeight = rcIntersect.bottom-rcIntersect.top;
    if (iWidth && iHeight)
        ::BitBlt(hdcView,rcIntersect.left,rcIntersect.top,iWidth,iHeight,
                 hdcMem,rcIntersect.left,rcIntersect.top,SRCCOPY);
}

