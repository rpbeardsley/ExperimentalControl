
#ifndef __DaoUtils_h
#define __DaoUtils_h

#include "afxdao.h"
#define DLLEXPORT   // prevend dbDAO objects from being exported
#include "dbdao.h"
#include "List.h"

class TRow;
class TVersionedRow;
class TRowIterator;
class TBaseRowMover;
class TRowMover;
class TVersionedRowMover;
class TColumnDescriptor;
class TRowVersion;

namespace NDaoUtilsLocal {
    class TFieldCopyBlock;
    class TTableRecordset;
}

namespace NDaoUtils {
    void ThrowNonReportingDaoException();
    void ReportDaoError(CDaoException* pe);
    CString GetUnusedRelationName(CDaoDatabase* pdb) /* throw CDaoException */;

    class TUnknownTableVersion : public CException {
    public:
        TUnknownTableVersion(const char* pszTable) : CException(TRUE),strTable(pszTable) {}
        virtual BOOL GetErrorMessage(LPTSTR lpszError,UINT nMaxError,PUINT pnHelpContext = NULL);
        const CString strTable;
    };
}

class TRow {
    friend class TRowMover;
public:
    TRow();
    virtual ~TRow() { }
    inline TRow& operator=(const TRow& Src) { pdbSource = Src.pdbSource; return *this; };
    virtual bool CreateTable(const char* pszDatabase) /* throw CDaoException*/ const;
    virtual bool CreateTable(CDaoDatabase*) /* throw CDaoException*/ const;

    // Read returns actual number of rows read
    virtual int Read(TRowIterator*,int iNumToRead = 1) /* throw CDaoException */ ;

    virtual void Write(TRowIterator*,bool bFixupAutoNumbers = true) /* throw CDaoException */ ;
    bool IsWritten() const;   // is there a corresponding record in a database
    CDaoDatabase* UnWrite();            // declare no corresponding record in the database (use to make copies)
    void DeclareWritten(CDaoDatabase* pdbNew) { pdbSource = pdbNew;} // use this to undo an UnWrite
    
    virtual void Remove();

    virtual TRowIterator* CreateRowReadIterator(CDaoDatabase*,const char* szIndex) 
        /* throw CDaoException */ const;
    virtual TRowIterator* CreateRowWriteIterator(CDaoDatabase*) 
        /* throw CDaoException */ const;

protected:
    void RemoveGuts(const char* pszTableName);

    virtual TBaseRowMover* GetRowMover() const = 0;

    virtual void CreateIndexes(CDaoTableDef*) 
        /* throw CDaoException */ const  = 0;
    virtual void CreateRelations(CDaoDatabase*) 
        /* throw CDaoException */ const = 0;
    virtual int GetPrimaryKey() const = 0;

    // derived classes should override the AppendColumnDescriptorList to add member defined
    // by the derived class. Return false if the specified table name is unknown.
    virtual void AppendColumnDescriptorList(TList<TColumnDescriptor*>*,
                                            int iOffset,const char* pszTableName) 
                                            /* throw NDaoUtils::TUnknownTableVersion*/ const = 0;

    CDaoDatabase* pdbSource;  // NULL until we read, or write
};

class TVersionedRow : public TRow {
    friend class TVersionedRowMover;
public:
    inline TVersionedRow& operator=(const TVersionedRow& Src) { TRow::operator=(Src); 
                                                                strSourceTableName = Src.strSourceTableName; 
                                                                return *this; };
    virtual int Read(TRowIterator*,int iNumToRead = 1) /* throw CDaoException */ ;
    virtual void Write(TRowIterator*,bool bFixupAutoNumbers = true) /* throw CDaoException */ ;
    virtual void Remove();
    bool IsTableCurrent() const;
protected:
    virtual CString GetCurrentVersion() const = 0;
    virtual void TranslateFromOldTable(const char* pszTableName); // default function converts to version and calls next
    virtual void TranslateFromOldTable(TRowVersion*);
    virtual void AppendColumnDescriptorList(TList<TColumnDescriptor*>*,
                                            int iOffset,const char* pszTableName) 
                                            /* throw NDaoUtils::TUnknownTableVersion*/ const;
    virtual void AppendColumnDescriptorList(TList<TColumnDescriptor*>*,
                                            int iOffset,TRowVersion*) 
                                            /* throw NDaoUtils::TUnknownTableVersion*/ const;
    CString strSourceTableName; // "" until we read, or write
};

class TRowIterator {
friend TRow;
friend class TRowMover;
friend class TVersionedRowMover;
public:
    virtual ~TRowIterator();
    virtual bool GoFirst() /* throw CDaoException */ ;
    virtual bool GoLast() /* throw CDaoException */ ;
    virtual bool GoPrev() /* throw CDaoException */ ;
    virtual bool GoNext() /* throw CDaoException */ ;
    virtual bool GoHere(int iSimpleIndexValue) /* throw CDaoException */ ;
    virtual bool GoHere(int iIndex1,int iIndex2) /* throw CDaoException */ ;
    virtual bool GoHere(int iIndex1,int iIndex2,int iIndex3) /* throw CDaoException */ ;
    virtual bool GoHereOrBeyond(int iSimpleIndexValue) /* throw CDaoException */ ;
	virtual bool CanTransact() const;
    CString GetTableName() const;
    CDaoDatabase* const pdb;
protected:
    TRowIterator(CDaoDatabase* pdb);
    TRowIterator(CDaoDatabase* pdb,const char* pszTable,const char* pszIndex) /*throw CDaoException*/ ;
    void Init(const char* pszTable,const char* pszIndex) /*throw CDaoException*/ ;
    NDaoUtilsLocal::TTableRecordset* prs;
    const bool bAutoDeleteDB;
};

class TBaseRowMover {
friend class TRow;
friend class TVersionedRowMover;
public:
    virtual ~TBaseRowMover() {}
    virtual int GetRowSize() const = 0;
    virtual CString GetTableName(const TRow* prAny) const = 0;
    virtual CString GetPrimaryKey() const = 0;
    virtual TRowIterator* CreateRowReadIterator(CDaoDatabase* pdb,const char* pszIndex,const TRow* prAny) const 
        /* throw CDaoException */ = 0;
    virtual TRowIterator* CreateRowWriteIterator(CDaoDatabase* pdb,const TRow* prAny) const 
        /* throw CDaoException */ = 0;
	virtual int ReadBuffer(TRow* prows,TRowIterator* pri,int iNumRows)  = 0 /* throw CDaoException */ ;	

protected:
    virtual void CreateColumns(const TRow* prAny,CDaoTableDef*) /* throw CDaoException */ = 0; 
    virtual int ReadRows(TRow* prow,TRowIterator* pri,int iNumToRead) /* throw CDaoException */ = 0;
    virtual void SetFieldValues(TRow* prow,TRowIterator* pri) /* throw CDaoException */ = 0;
    virtual void FixupAutoNumberFields(TRow*,TRowIterator*) /* throw CDaoException */ = 0;
};

class TRowMover : public TBaseRowMover {
public:
    TRowMover(const char* pszTableName,int iSizeOfRow,const char* pszPrimaryKey,bool bLoadByName);
    virtual ~TRowMover();
    virtual int GetRowSize() const { return iSizeOfRow; }
    virtual CString GetTableName(const TRow* prAny) const { return strTableName; }
    virtual CString GetPrimaryKey() const { return strPrimaryKey; }
    virtual TRowIterator* CreateRowReadIterator(CDaoDatabase* pdb,const char* pszIndex,const TRow* prAny) const 
        /* throw CDaoException */ ;
    virtual TRowIterator* CreateRowWriteIterator(CDaoDatabase* pdb,const TRow* prAny) const /* throw CDaoException */ ;
	virtual int ReadBuffer(TRow* prows,TRowIterator* pri,int iNumRows) /* throw CDaoException */ ;	
    const int iSizeOfRow;
    const bool bLoadByName;
    const CString strTableName;
    const CString strPrimaryKey;
protected: // TRow visible functionality
    virtual void CreateColumns(const TRow* prAny,CDaoTableDef*) /* throw CDaoException */; 
    virtual int ReadRows(TRow* prow,TRowIterator* pri,int iNumToRead) /* throw CDaoException */ ;
    virtual void SetFieldValues(TRow* prow,TRowIterator* pri) /* throw CDaoException */ ;
    virtual void FixupAutoNumberFields(TRow*,TRowIterator*) /* throw CDaoException */ ;

private: 
    void BuildBindingArray(const TRow* prAny);
    void FillAutoBindingRows(BYTE* pbyDstRows,BYTE* pbySrcBuffer,int iNumRows);
    // the following members are built on an as needed basis and don't change once they are built
    TList<TColumnDescriptor*> lstcd;
    DAORSETBINDING* pbndAuto;
    int iNumAutoBindings;
    bool bAnyManualBindings;
    NDaoUtilsLocal::TFieldCopyBlock* pfcb;
    BYTE* pReadBuffer;
    int iReadBufferSize;
};

class TVersionedRowMover : public TBaseRowMover {
public:
    TVersionedRowMover(const char* pszOriginalTableName,const char* pszVersionedTableBaseName,
                       const char* pszPrimaryKey,int iSizeOfRow,bool bLoadByName);
    virtual ~TVersionedRowMover();
    virtual int GetRowSize() const { return iSizeOfRow; }
    virtual CString GetTableName(const TRow* prAny) const;
    virtual CString GetPrimaryKey() const { return strPrimaryKey; }
    virtual TRowIterator* CreateRowReadIterator(CDaoDatabase* pdb,const char* pszIndex,const TRow* prAny) const 
        /* throw CDaoException */ ;
    virtual TRowIterator* CreateRowWriteIterator(CDaoDatabase* pdb,const TRow* prAny) const /* throw CDaoException */ ;
    virtual int ReadBuffer(TRow* prows,TRowIterator* pri,int iNumRows) /* throw CDaoException */ ;	
    const CString strOriginalTableName;
    const CString strVersionedTableBaseName;
    const CString strPrimaryKey;
    const int iSizeOfRow;
    const bool bLoadByName;
protected: // TRow visible functionality
    virtual void CreateColumns(const TRow* prAny,CDaoTableDef*) /* throw CDaoException */ ; 
    virtual int ReadRows(TRow* prow,TRowIterator* pri,int iNumToRead) /* throw CDaoException */ ;
    virtual void SetFieldValues(TRow* prow,TRowIterator* pri) /* throw CDaoException */ ;
    virtual void FixupAutoNumberFields(TRow*,TRowIterator*) /* throw CDaoException */ ;
private:
    TBaseRowMover* FindRowMoverFromTableName(const char* pszTableName,const TRow* prAny);
    TList<TBaseRowMover*> lstrm;
};

//
// Standard DAO supported data types and compatible TRow data declarations: 
//  
// ecdtBOOL           BOOL bVal;
// ecdtbool           bool bVal;
// ecdtByte           BYTE byVal; bool bVal;
// ecdtInteger        short sVal;
// ecdtLong           long lVal;
// ecdtSingle         float fVal;
// ecdtDouble         double dVal;
// ecdtDate           COleDateTime dt;
// ecdtText           char sz[iMaxSize];    // where iSize<=255
// ecdtLongBinary     BYTE* pby;
// ecdtMemo           char* psz;
//
// Extended types with alternate binding
//
// ecdtCString       CString str;
// ecdtCByteArray    CByteArray ba;
//

enum EColumnDescriptorType { 
    ecdtBOOL=0,ecdtbool=1,ecdtByte=2,ecdtInteger=3,ecdtLong=4,
    ecdtSingle=5,ecdtDouble=6,ecdtDate=7,
    ecdtText=8,ecdtLongBinary=9,ecdtMemo=10,
    ecdtCString=11,ecdtCByteArray=12 };

class TColumnDescriptor {
public:
    // non-array ctor
    TColumnDescriptor(
        const char* szName,             // name of column (NO BRACKETS!)
        EColumnDescriptorType ecdt,     // cdt constant such as cdtDouble
        int iOffset,                    // offset from owner of list to owner's data member
        long lExtraAttrib,              // possibly dbAutoIncrField and/or dbDescending
        void* pStaticMember);           // if data is static, pointer to data (iOffset ignored)
    // array ctor (w/fixed length)
    TColumnDescriptor(
        const char* szName,             // name of column (NO BRACKETS!)
        EColumnDescriptorType ecdt,     // cdt constant such as cdtDouble
        DWORD dwMaxSize,                // size of corresponding TRow array required for fields
        int iOffset,                    // offset from owner of list to owner's data member
        long lExtraAttrib,              // possibly dbDescending
        void* pStaticMember);           // if data is static, pointer to data (iOffset ignored)

    const CString strName;              // column name for column creation
    const EColumnDescriptorType ecdt;   // type of data member  
    const long lExtraAttrib;            // Combination of dbAutoIncrField and/or dbDescending
    const DWORD dwMaxSize;              // max size of array type in bytes
    const int iOffset;              // offset BYTES from the beginning of the mother structure
    void* const pStaticMember;      // absolute address of field for static members
    DWORD GetBindingType() const;
    DWORD GetBindingSize() const;
    DataTypeEnum GetDAOType() const;
    void Create(CDaoTableDef* ptbldef) /* throw CDaoException*/ ;
};

class TRowVersion {
public:
    TRowVersion(int iVersion,int iBitCount);
    TRowVersion(const char*);
    TRowVersion(const TRowVersion&);
    TRowVersion& operator=(const TRowVersion&);
    int PullBits(int iHowMany);
    inline int GetBitCount() const { return iBitCount; }
    TRowVersion& operator+=(const TRowVersion&);
    TRowVersion& operator<<=(int iNumBitsToPull);
    inline operator CString() const { return str; }
    inline operator const CString() const { return str; }
    inline operator LPCSTR() const { return str; }
protected:
    CString str;
    int iBitCount;
    static const int iBitsPerChar;
    static const int iBitMask;
    static char BitsToChar(int i);
    static int CharToBits(char c);
};

#endif
