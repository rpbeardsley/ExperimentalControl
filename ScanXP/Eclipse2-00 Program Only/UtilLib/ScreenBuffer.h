#ifndef __ScreenBuffer_h
#define __ScreenBuffer_h

class TScreenBuffer {
public:
    TScreenBuffer();
    ~TScreenBuffer();
    void Clear();
    void Load(HDC,const RECT*);
    void Restore(const RECT*);

protected:
    HDC hdcView;
    RECT rcView;
    HDC hdcMem;
    HBITMAP hbmp;
    HBITMAP hbmpOriginal;
};

#endif
