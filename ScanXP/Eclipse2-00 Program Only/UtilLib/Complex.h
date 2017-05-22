
#ifndef __COMPLEX_H
#define __COMPLEX_H

class TComplex {
public:
    TComplex();
	TComplex(bool bInit);
    TComplex(double dRe);
	TComplex(double dRe,double dIm);

    void FromPolar(double dRadius,double dAngle);

//    TComplex& operator=(const TComplex&);
    TComplex& operator=(double);
    TComplex& operator*=(const TComplex&);
    TComplex& operator/=(const TComplex&);
    TComplex& operator*=(double);
    TComplex& operator/=(double);
    TComplex& operator+=(const TComplex&);
    TComplex& operator-=(const TComplex&);
    bool operator==(const TComplex&) const;

	inline double& GetReal()      { return dRe; }
	inline double GetReal() const { return dRe; }
	inline double& GetImag()      { return dIm; }
	inline double GetImag() const { return dIm; }
	inline double& GetX()      { return dRe; }
	inline double GetX() const { return dRe; }
	inline double& GetY()      { return dIm; }
	inline double GetY() const { return dIm; }
    double GetRadius() const;
    inline double GetMagnitude() const { return GetRadius(); }
    double GetRadius2() const;
    double GetAngle() const;

    bool IsFinite() const;

protected:
	double dRe,dIm;
};

TComplex operator+(const TComplex&,const TComplex&);
TComplex operator-(const TComplex&,const TComplex&);
TComplex operator*(const TComplex&,const TComplex&);
TComplex operator/(const TComplex&,const TComplex&);
TComplex operator-(const TComplex&);

double Dot(const TComplex&,const TComplex&);
TComplex Conj(const TComplex& c);
TComplex Heading(const TComplex& c);
TComplex Uoo(double dAngle);
TComplex Ln(const TComplex& c);
TComplex Exp(const TComplex& c);
TComplex Pow(const TComplex& cMantissa,double dPower);

class TBaseComplexArray {
public:
    TBaseComplexArray(DWORD dwNumPoints,bool bInit = false);
    TBaseComplexArray(const TBaseComplexArray&);
    virtual ~TBaseComplexArray();
    TBaseComplexArray& operator=(const TBaseComplexArray& Src);
    TBaseComplexArray& operator*=(double);
    TBaseComplexArray& operator/=(double);
    TBaseComplexArray& operator*=(const TComplex&);
    inline const TComplex& operator[](int iIndex) const { return pc[iIndex]; }
    inline TComplex& operator[](int iIndex) { return pc[iIndex]; }
    void Zero();
    double SumSquareMagnitude() const;
    double MaxMagnitude() const;
    inline DWORD GetNumPoints() const { return dwN; }
protected:
    TComplex* const pc;
    const DWORD dwN;
};

class TUnitVectorTable : public TBaseComplexArray {
public:
    TUnitVectorTable(double dPointsPerRevolution,DWORD dwTotalPoints);
};

class TComplexArray : public TBaseComplexArray {
public:
    TComplexArray(DWORD dwNumPoints,bool bInit = false);
    TComplexArray(const TComplexArray&);
    TComplexArray& operator=(const TBaseComplexArray& Src);
    void TimeShiftSpectralDensity(double dPoints);
    void DoFourierTransform();
    void DoInverseFourierTransform();
    void LoadAsFourierTransformFromReals(const int iRealsOnly[]);
    void LoadAsInverseFourierTransformFromReals(const int iRealsOnly[]);
    void LoadAsFourierTransformFromReals(const double dRealsOnly[]);
    void LoadAsInverseFourierTransformFromReals(const double dRealsOnly[]);
protected:
    void DoFFTLoadFromRealsAndFirstColumn(const int iRealsOnly[],bool bInverse);
    void DoFFTLoadFromRealsAndFirstColumn(const double dRealsOnly[],bool bInverse);
    void DoFFTFromRealsSecondColumn(bool bInverse);
    void DoFFTFirstTwoColumns(bool bInverse);
    void DoFFTColumnLoop(DWORD dwColumn,bool bInverse);
    DWORD BitReverse(DWORD dw) const;
    // These constants are exp(-j*2*pi*k/N) where k is the bin of interest. There are 
    // dwNumPoints/2 angles. Divide by two because remaining half is just minus
    // the first half, and we don't bother to calculate it.
    const TUnitVectorTable uvt;
};

#endif

