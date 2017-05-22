#pragma once

class TStretchedBitmapStatic : public CStatic {
public:
    TStretchedBitmapStatic(UINT AnBitmapID);
    virtual ~TStretchedBitmapStatic();
    virtual void SetBitmap(UINT nNewBitmapID);
protected:
    UINT nIDBitmap;
    HDC hdcSrc;
    HGDIOBJ hbmpOldSrc;
    afx_msg void OnPaint();
    DECLARE_MESSAGE_MAP();
};
