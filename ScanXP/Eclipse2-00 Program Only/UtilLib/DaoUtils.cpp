
#include "stdafx.h"
#include "DaoUtils.h"
#include "NumberUtils.h"

//
// Global Helper functions
//
void NDaoUtils::ThrowNonReportingDaoException() {
    CDaoException* pe = new CDaoException;
    pe -> m_scode = S_OK;
    pe -> m_nAfxDaoError = NO_AFX_DAO_ERROR;
    throw pe;
}

void NDaoUtils::ReportDaoError(CDaoException* pe) {
    if (pe -> m_scode != S_OK ||                    // if real DAO error
        pe -> m_nAfxDaoError != NO_AFX_DAO_ERROR)   // or faked MFC DAO error
        pe -> ReportError();                        // tell user, else user already knows
}

CString NDaoUtils::GetUnusedRelationName(CDaoDatabase* pdb) /* throw CDaoException */ {
    CString strRelation;
    for (int i = 0; ; i++) {
        strRelation.Format(_T("Relation%i"),i);
        try { 
            pdb->GetRelationInfo(strRelation,CDaoRelationInfo()); 
        } catch (CDaoException* pe) {
            if (pe->m_scode != E_DAO_VtoNameNotFound) throw;
            pe->Delete();
            break;
       }
    }
    return strRelation;
}

BOOL NDaoUtils::TUnknownTableVersion::GetErrorMessage(LPTSTR lpszError,UINT nMaxError,PUINT pnHelpContext) {
	if (pnHelpContext != NULL) *pnHelpContext = 0;
    if (nMaxError > 0) {
        CString str;
        str.Format(_T("Unknown Table Name: %s"),(const char*)strTable);
        strncpy(lpszError,str,nMaxError);
        lpszError[nMaxError-1] = 0;
    }
	return TRUE;
}

namespace NDaoUtilsLocal {
    //
    // Local Helper functions
    //
    CString AddBrackets(const char* psz) {
        return CString(_T("[")) + psz + _T("]");
    }
    //
    // Local Helper classes
    //
    class TFieldCopyBlock {
    public:
        DWORD dwOffset;     // offset into read buffer to start of block to copy
                            // and equililent offset into the TRow derivation
        int iNumBytes;      // number of sequential bytes to move
    };
    //
    // TTableRecordset Declaration/Definition
    //
    class TTableRecordset : public CDaoRecordset {
    public:
        TTableRecordset(CDaoDatabase* pdb,const char* pszIndex);
        virtual ~TTableRecordset();
        void Open(const char* pszTableName);
        bool SeekAndVerifyFirstField(const char* pszCmp,COleVariant& varIndex) /*throw CDaoException*/;
        CString GetTableName() const;
    protected:
        CString strTableName;
        const CString strIndex;
        virtual CString GetDefaultSQL();
    };

    TTableRecordset::TTableRecordset(CDaoDatabase* pdb,const char* pszIndex) 
    : CDaoRecordset(pdb),strIndex(pszIndex) {
        m_nDefaultType = dbOpenTable;
    }
    TTableRecordset::~TTableRecordset() {
        if (IsOpen()) Close();
    }
    CString TTableRecordset::GetTableName() const {
        return strTableName;
    }
    CString TTableRecordset::GetDefaultSQL() {
        return AddBrackets(strTableName);
    }
    void TTableRecordset::Open(const char* pszTableName) /*throw CDaoException*/ {
        if (IsOpen()) Close();
        strTableName = pszTableName;
        CDaoRecordset::Open();
        SetCurrentIndex(strIndex); 
    }
    #pragma warning(disable:4800) // BOOL to bool conversion
    bool TTableRecordset::SeekAndVerifyFirstField(const char* pszCmp,COleVariant& varIndex) 
        /* throw CDaoException */ {
        if (!Seek(pszCmp,&varIndex)) return false;
        CdbDatabase dbdatabase(m_pDatabase->m_pDAODatabase,TRUE);
        CdbTableDef& dbtbldef = dbdatabase.TableDefs[strTableName];
        CdbIndex& dbindex = dbtbldef.Indexes[strIndex];
        if (dbindex.Fields.GetCount() == 1) return true;
        CString strIndexFieldName = (const char*)(dbindex.Fields[(long)0].GetName());
        COleVariant varIndexFieldValue;
        GetFieldValue(strIndexFieldName,varIndexFieldValue);
        return (varIndexFieldValue == varIndex);
    }   
    #pragma warning(default:4800)
    //
    // TVersionedRowIterator Declaration/Definition
    //
    class TVersionedRowIterator : public TRowIterator {
    friend TVersionedRowMover;
    public:
        virtual bool GoHere(int iSimpleIndexValue) /* throw CDaoException */ ;
        virtual bool GoHereOrBeyond(int iSimpleIndexValue) /* throw CDaoException */ ;
    protected:
        TVersionedRowIterator(CDaoDatabase* pdb,
                              const char* pszCurrentTableName,
                              const char* pszOriginalTableName,
                              const char* pszVersionedTableBaseName,
                              const char* pszIndex);
        bool GoHereGuts(int iSimpleIndexValue,const char* pszCmp) /*throw CDaoException*/ ;
        const CString strOriginalTableName;
        const CString strVersionedTableBaseName;
        const CString strCurrentTableName;
    };

    TVersionedRowIterator::TVersionedRowIterator(CDaoDatabase* pdb,
                                                 const char* pszCurrentTableName,
                                                 const char* pszOriginalTableName,
                                                 const char* pszVersionedTableBaseName,
                                                 const char* pszIndex)
    : TRowIterator(pdb),strOriginalTableName(pszOriginalTableName),strCurrentTableName(pszCurrentTableName),
      strVersionedTableBaseName(pszVersionedTableBaseName) {
        try {
            Init(strCurrentTableName,pszIndex);
        } catch (CDaoException* pe) { pe->Delete(); }
    }

    bool TVersionedRowIterator::GoHere(int iSimpleIndexValue) {
        return GoHereGuts(iSimpleIndexValue,_T("="));
    }
    bool TVersionedRowIterator::GoHereOrBeyond(int iSimpleIndexValue) {
        return GoHereGuts(iSimpleIndexValue,_T(">="));
    }

    bool TVersionedRowIterator::GoHereGuts(int iSimpleIndexValue,const char* pszCmp) {
        if (iSimpleIndexValue == -1) return false;
        COleVariant varIndex((long)iSimpleIndexValue);
        bool bFoundIt = false;
        // if we have an open record set, try it first
        if (prs->IsOpen()) bFoundIt = prs->SeekAndVerifyFirstField(pszCmp,varIndex);
        // if not there, start looking at versioned tables
        if (!bFoundIt) {
            CDaoTableDefInfo tabledefinfo;
            int iNumTables = pdb->GetTableDefCount();
            for (int i = 0; i < iNumTables; i++) {
                try { 
                    pdb->GetTableDefInfo(i,tabledefinfo);
                    if (tabledefinfo.m_strName.Find(strVersionedTableBaseName) == 0 || 
                        tabledefinfo.m_strName == strOriginalTableName) {
                        prs->Open(tabledefinfo.m_strName);
                        bFoundIt = prs->SeekAndVerifyFirstField(pszCmp,varIndex);
                    }
                    if (bFoundIt) break;
                } catch (CDaoException* pe) { pe->Delete(); }
            } // end for each table in the database
        } // end if didn't find it with initial seek
        return bFoundIt;
    }

} // end namespace NDaoUtilsLocal

//**********************************************************************************************
//
// TRow Definition
//
TRow::TRow() {
    pdbSource = 0;
}
bool TRow::CreateTable(const char* pszDatabase) /* throw CDaoException*/ const {
    CDaoDatabase db;
    try {
        db.Open(pszDatabase);
        return CreateTable(&db);
    } catch (CDaoException*) {
        if (db.IsOpen()) db.Close();
        throw;
    }
}
bool TRow::CreateTable(CDaoDatabase* pdb) /* throw CDaoException*/ const {
    CDaoTableDef tbldef(pdb);
    bool bMustCreateTable = false;
    bool bTableCreated = false;
    try {
        try { 
            tbldef.Open(GetRowMover()->GetTableName(this)); 
            tbldef.Close();
            return false; // table already exists
        } catch (CDaoException* pe) {
            if (pe -> m_scode != E_DAO_VtoNameNotFound) throw;
            else bMustCreateTable = true;
            pe->Delete();
        }
        if (bMustCreateTable) {
            // Create the table
            tbldef.Create(GetRowMover()->GetTableName(this));
            // Create the fields in the table
            GetRowMover()->CreateColumns(this,&tbldef);
            CreateIndexes(&tbldef);
            tbldef.Append();
            tbldef.Close();
            bTableCreated = true;
            CreateRelations(pdb);
        }
    } catch (CDaoException*) {
        if (tbldef.IsOpen()) tbldef.Close();
        if (bTableCreated) {
            CdbDatabase dbdatabase(pdb->m_pDAODatabase,TRUE);
            dbdatabase.TableDefs.Delete(GetRowMover()->GetTableName(this));
        }
        throw;
    }
    return true; // successfully created table (and relations)
}
TRowIterator* TRow::CreateRowReadIterator(CDaoDatabase* pdb,const char* pszIndex) const
    /* throw CDaoException */ {
    return GetRowMover()->CreateRowReadIterator(pdb,pszIndex,this);
}
TRowIterator* TRow::CreateRowWriteIterator(CDaoDatabase* pdb) const /* throw CDaoException */ {
    return GetRowMover()->CreateRowWriteIterator(pdb,this);
}

int TRow::Read(TRowIterator* pri,int iNumToRead) /* throw CDaoException */ {
    int iNumRead = GetRowMover()->ReadRows(this,pri,iNumToRead);
    for (int i = 0; i < iNumRead; i++) {
        char* pc = (char*)this;
        pc += i*GetRowMover()->GetRowSize();
        TRow* prow = (TRow*)pc;
        prow->pdbSource = pri->pdb;
    }
    return iNumRead;
}
void TRow::Write(TRowIterator* pri,bool bFixupAutoNumbers) /* throw CDaoException */ {
    // have we never been read, or are writing to a different database
    bool bNew = ((pdbSource == 0)  || (pdbSource != pri->pdb));
    if (bNew)     
        pri->prs->AddNew(); 
    else { // otherwise we need to update an existing record
        bool bWentThere = pri->GoHere(GetPrimaryKey());
        ASSERT(bWentThere);
        pri->prs->Edit();		
    }
    GetRowMover()->SetFieldValues(this,pri);
    pri->prs->Update();	
    if (bNew && bFixupAutoNumbers) {
        pri->prs->SetBookmark(pri->prs->GetLastModifiedBookmark());
        GetRowMover()->FixupAutoNumberFields(this,pri);
        pdbSource = pri->pdb;
    } // otherwise this row is still valid -- it is still linked to the original database
}

CDaoDatabase* TRow::UnWrite() {
    CDaoDatabase* pdbOld = pdbSource;
    pdbSource = 0;
    return pdbOld;
}
//void TRow::DeclareWritten(CDaoDatabase* pdbNew) {
//    pdbSource = pdbNew;
//}
bool TRow::IsWritten() const {
    return (pdbSource != 0);
}
void TRow::Remove() {
    RemoveGuts(GetRowMover()->GetTableName(this));
}
void TRow::RemoveGuts(const char* pszTableName) {
    if (!IsWritten()) return;
    NDaoUtilsLocal::TTableRecordset rs(pdbSource,GetRowMover()->GetPrimaryKey());
    rs.Open(pszTableName);
    COleVariant varIndex((long)GetPrimaryKey());
    rs.Seek(_T("="),&varIndex);
    rs.Delete();
    UnWrite();
}
//**********************************************************************************************
//
// TVersionedRow Definition
//
void TVersionedRow::AppendColumnDescriptorList(TList<TColumnDescriptor*>* plstcd,
                                               int iOffset,const char* pszTableName) 
    /* throw NDaoUtils::TUnknownTableVersion*/ const {
    TVersionedRowMover* prm = (TVersionedRowMover*)GetRowMover();
    const char* pszVersion = prm->strOriginalTableName == pszTableName ? _T("") :
                             pszTableName + prm->strVersionedTableBaseName.GetLength(); 
    TRowVersion rv(pszVersion);
    AppendColumnDescriptorList(plstcd,iOffset,&rv);
}
void TVersionedRow::AppendColumnDescriptorList(TList<TColumnDescriptor*>*,
                                               int iOffset,TRowVersion*) 
    /* throw NDaoUtils::TUnknownTableVersion*/ const {
    // This function exists only so the derived class won't be abstract in case the derived class
    // overrides the pszTableName version of the function instead of the TRowVersion version of
    // the AppendColumnDescriptionList function.
}
void TVersionedRow::TranslateFromOldTable(const char* pszTableName) {
    TVersionedRowMover* prm = (TVersionedRowMover*)GetRowMover();
    const char* pszVersion = prm->strOriginalTableName == pszTableName ? _T("") :
                             pszTableName + prm->strVersionedTableBaseName.GetLength(); 
    TRowVersion rv(pszVersion);
    TranslateFromOldTable(&rv);
}
void TVersionedRow::TranslateFromOldTable(TRowVersion*) {
}
void TVersionedRow::Write(TRowIterator* pri,bool bFixupAutoNumbers) /* throw CDaoException */ {
    // have we never been read, or are writing to a different database
    bool bNew = ((pdbSource == 0)  || (pdbSource != pri->pdb));
    if (!bNew && !IsTableCurrent() && bFixupAutoNumbers) 
        Remove();
    TRow::Write(pri,bFixupAutoNumbers);
    if (bFixupAutoNumbers) 
        strSourceTableName = pri->GetTableName();
}

int TVersionedRow::Read(TRowIterator* pri,int iNumToRead) /* throw CDaoException */ {
    int iNumRead = TRow::Read(pri,iNumToRead);
    for (int i = 0; i < iNumRead; i++) {
        char* pc = (char*)this;
        pc += i*GetRowMover()->GetRowSize();
        TVersionedRow* prow = (TVersionedRow*)pc;
        prow->strSourceTableName = pri->GetTableName();
    }
    return iNumRead;
}
void TVersionedRow::Remove() {
    RemoveGuts(strSourceTableName);
}
bool TVersionedRow::IsTableCurrent() const {
    if (!IsWritten()) return true;
    return strSourceTableName == GetRowMover()->GetTableName(this);
}

//**********************************************************************************************
//
// TRowIterator Implementation
//
// simple ctor (can't fail because it doesn't open the recordset)
TRowIterator::TRowIterator(CDaoDatabase* Apdb) 
: bAutoDeleteDB(false),pdb(Apdb) {
    prs = NULL;
}
// non-simple ctor (opens the recordset -- might throw)
TRowIterator::TRowIterator(CDaoDatabase* Apdb,const char* pszTable,const char* pszIndex) 
    /* throw CDaoException */ 
: bAutoDeleteDB(false),pdb(Apdb){
    prs = NULL;
    Init(pszTable,pszIndex);
}
void TRowIterator::Init(const char* pszTable,const char* pszIndex) /*throw CDaoException*/ {
    prs = new NDaoUtilsLocal::TTableRecordset(pdb,pszIndex);
    try {
        prs->Open(pszTable);
    } catch (CDaoException*) {
        if (prs->IsOpen()) prs->Close();
        throw;
    }
}
TRowIterator::~TRowIterator() {
    delete prs;
    if (bAutoDeleteDB) delete pdb;
}
CString TRowIterator::GetTableName() const {
    return prs->GetTableName();
}
bool TRowIterator::GoFirst() /* throw CDaoException */ { 
    bool bRet = false;
    try {
        prs->MoveFirst(); 
        bRet = true;
    } catch (CDaoException* pe) {
        if (pe->m_scode == E_DAO_NoCurrentRecord) {
            pe->Delete();
        } else throw;
    }
    return bRet; 
}
bool TRowIterator::GoLast() /* throw CDaoException */ { 
    bool bRet = false;
    try {
        prs->MoveLast(); 
        bRet = true;
    } catch (CDaoException* pe) {
        if (pe->m_scode == E_DAO_NoCurrentRecord) {
            pe->Delete();
        } else throw;
    }
    return bRet;
}
bool TRowIterator::GoPrev() /* throw CDaoException */  { 
    ASSERT(!prs->IsBOF()); 
    prs->MovePrev(); 
    return !prs->IsBOF(); 
}
bool TRowIterator::GoNext() /* throw CDaoException */  { 
    ASSERT(!prs->IsEOF()); 
    prs->MoveNext(); 
    return !prs->IsEOF(); 
}
bool TRowIterator::GoHere(int iSimpleIndexValue) /* throw CDaoException */ {
    if (iSimpleIndexValue == -1) return false;
    COleVariant varIndex((long)iSimpleIndexValue);
    // can't use >= because GoHere might go somewhere else
    return (prs->Seek(_T("="),&varIndex) != FALSE);
}
bool TRowIterator::GoHere(int iIndex1,int iIndex2) /* throw CDaoException */ {
    COleVariant varIndex1((long)iIndex1);
    COleVariant varIndex2((long)iIndex2);
    // can't use >= because GoHere might go somewhere else
    return (prs->Seek(_T("="),&varIndex1,&varIndex2) != FALSE);
}
bool TRowIterator::GoHere(int iIndex1,int iIndex2,int iIndex3) /* throw CDaoException */ {
    COleVariant varIndex1((long)iIndex1);
    COleVariant varIndex2((long)iIndex2);
    COleVariant varIndex3((long)iIndex3);
    // can't use >= because GoHere might go somewhere else
    return (prs->Seek(_T("="),&varIndex1,&varIndex2,&varIndex3) != FALSE);
}

bool TRowIterator::GoHereOrBeyond(int iSimpleIndexValue) /* throw CDaoException */ {
    if (iSimpleIndexValue == -1) return false;
    COleVariant varIndex((long)iSimpleIndexValue);
    return (prs->Seek(_T(">="),&varIndex) != FALSE);
}

bool TRowIterator::CanTransact() const {
	return (prs->CanTransact() == TRUE);
}
//**********************************************************************************************
//
// TRowMover Implementation
//
//
TRowMover::TRowMover(const char* pszTableName,int AiSizeOfRow,
                     const char* ApszPrimaryKey,bool AbLoadByName) 
: strTableName(pszTableName),iSizeOfRow(AiSizeOfRow),
  bLoadByName(AbLoadByName),strPrimaryKey(ApszPrimaryKey),pbndAuto(NULL) {
    pReadBuffer = NULL;
    iReadBufferSize = 0;
    iNumAutoBindings = 0;
    bAnyManualBindings = false;
    pfcb = NULL;
}

TRowMover::~TRowMover() {
    TPOSITION pos = lstcd.GetHeadPosition();
    while (pos) delete lstcd.GetNext(pos);
    delete [] pbndAuto;
    delete [] pReadBuffer;
    delete [] pfcb;
}
TRowIterator* TRowMover::CreateRowReadIterator(CDaoDatabase* pdb,const char* pszIndex,const TRow* prAny) const
    /* throw CDaoException */ {
    return new TRowIterator(pdb,GetTableName(prAny),pszIndex);
}
TRowIterator* TRowMover::CreateRowWriteIterator(CDaoDatabase* pdb,const TRow* prAny) const /* throw CDaoException */ {
    return new TRowIterator(pdb,GetTableName(prAny),GetPrimaryKey());
}

void TRowMover::CreateColumns(const TRow* prAny,CDaoTableDef* ptbldef) /* throw CDaoException */ {
    if (lstcd.IsEmpty()) prAny->AppendColumnDescriptorList(&lstcd,0,GetTableName(prAny));
    TPOSITION pos = lstcd.GetHeadPosition();
    while (pos) lstcd.GetNext(pos)->Create(ptbldef);
}

void TRowMover::BuildBindingArray(const TRow* prAny) {
    // if we have already done this, don't bother to do it again
    if (iNumAutoBindings != 0 || bAnyManualBindings) return; 
    // if column descriptor list has not been built yet, now is the time
    if (lstcd.IsEmpty()) prAny->AppendColumnDescriptorList(&lstcd,0,GetTableName(prAny));
    ASSERT(!lstcd.IsEmpty());
    pbndAuto = new DAORSETBINDING[lstcd.GetCount()];
    TPOSITION pos = lstcd.GetHeadPosition();
    DAORSETBINDING* pbndLoc = pbndAuto;
    int iColumnIndex = 0;
    while (pos) {
        const TColumnDescriptor* pcd = lstcd.GetNext(pos);
        if ((pcd->pStaticMember == 0) &&
            (pcd->ecdt!=ecdtMemo)&&(pcd->ecdt!=ecdtLongBinary)&&
            (pcd->ecdt!=ecdtCString)&&(pcd->ecdt!=ecdtCByteArray)&&
            (pcd->ecdt!=ecdtbool)&&(pcd->ecdt!=ecdtByte)) {
            if (bLoadByName) {
                pbndLoc->dwBindIndexType = dbBindIndexSTR;
                pbndLoc->pstr = pcd->strName;
            } else {
                pbndLoc->dwBindIndexType = dbBindIndexINT;
                pbndLoc->i = iColumnIndex;
            }
            pbndLoc->dwType = pcd->GetBindingType();
            pbndLoc->dwOffset = pcd->iOffset;
            pbndLoc->cb = pcd->GetBindingSize();
            pbndLoc++;
            iNumAutoBindings++;
       } else bAnyManualBindings = true;
       iColumnIndex++;
    }
    // allocate copy block array of max possible size ( + 1 for zero terminator)
    pfcb = new NDaoUtilsLocal::TFieldCopyBlock[iNumAutoBindings + 1];    
    NDaoUtilsLocal::TFieldCopyBlock* pfcbLoc = pfcb;
    pbndLoc = pbndAuto;
    pfcbLoc->dwOffset = pbndLoc->dwOffset;
    pfcbLoc->iNumBytes = 0;
    for (int i = 0; i < iNumAutoBindings; i++) {
        if (pfcbLoc->dwOffset+pfcbLoc->iNumBytes == pbndLoc->dwOffset) 
            pfcbLoc->iNumBytes += pbndLoc->cb;
        else {
            pfcbLoc++;
            pfcbLoc->dwOffset = pbndLoc->dwOffset;
            pfcbLoc->iNumBytes = pbndLoc->cb;
        }
        pbndLoc++;
    }
    pfcbLoc++;
    pfcbLoc->iNumBytes = 0;  // zero terminator
}

void TRowMover::SetFieldValues(TRow* prow,TRowIterator* pri) /* throw CDaoException */ {
    if (lstcd.IsEmpty()) prow->AppendColumnDescriptorList(&lstcd,0,GetTableName(prow));
    TPOSITION pos = lstcd.GetHeadPosition();
    BYTE* pbyRow = (BYTE*)prow;
    for (int iCol = 0; pos; iCol++) {
        TColumnDescriptor* pcd = lstcd.GetNext(pos);
        if (pcd->lExtraAttrib & dbAutoIncrField) continue;
        BYTE* pbyValue = pcd->pStaticMember ? (BYTE*)(pcd->pStaticMember) : &pbyRow[pcd->iOffset]; 
        COleVariant var;
        switch (pcd->ecdt) {
            case ecdtBOOL:
            case ecdtLong:          var = COleVariant(*((long*)pbyValue)); break;
            case ecdtbool:
            case ecdtByte:          var = COleVariant(*((BYTE*)pbyValue)); break;
            case ecdtInteger:       var = COleVariant(*((short*)pbyValue)); break;
            case ecdtSingle:        var = COleVariant(*((float*)pbyValue)); break;
            case ecdtDouble:        var = COleVariant(*((double*)pbyValue)); break;
            case ecdtDate:          var = COleVariant(*((COleDateTime*)pbyValue)); break;
            case ecdtMemo:          var = COleVariant(*((const char**)pbyValue),VT_BSTRT); break;
            case ecdtText:          var = COleVariant((const char*)pbyValue,VT_BSTRT); break;
            case ecdtLongBinary: {
                const BYTE** ppby = (const BYTE**)pbyValue;
                if (*ppby != NULL) {
                    var.vt = VT_UI1 | VT_ARRAY;
    		        SAFEARRAYBOUND bound;
		            bound.cElements = pcd->dwMaxSize;
		            bound.lLbound = 0;
		            var.parray = ::SafeArrayCreate(VT_UI1,1,&bound);
                    BYTE* pDest;
            	    ::SafeArrayAccessData(var.parray,(void**)(&pDest));
	                memcpy(pDest,*ppby,pcd->dwMaxSize);
	                ::SafeArrayUnaccessData(var.parray);
                } else var.vt = VT_NULL;
                break;
            }
            case ecdtCString: {
                CString* pstr = ((CString*)pbyValue);
                var = COleVariant((const char*)(*pstr),VT_BSTRT);
                break;
            }
            case ecdtCByteArray: {
                CByteArray* pba = ((CByteArray*)pbyValue);
                if (pba->GetData() != NULL) {
                    var.vt = VT_UI1 | VT_ARRAY;
    		        SAFEARRAYBOUND bound;
		            bound.cElements = pba->GetSize();
		            bound.lLbound = 0;
		            var.parray = ::SafeArrayCreate(VT_UI1,1,&bound);
                    BYTE* pDest;
            	    ::SafeArrayAccessData(var.parray,(void**)(&pDest));
	                memcpy(pDest,pba->GetData(),bound.cElements);
	                ::SafeArrayUnaccessData(var.parray);
                } else var.vt = VT_NULL;
                break;
            }
            default: ASSERT(0);
        }
        if (bLoadByName)
            pri->prs->SetFieldValue(pcd->strName,var); 
        else
            pri->prs->SetFieldValue(iCol,var);
    }
}

void TRowMover::FixupAutoNumberFields(TRow* prow,TRowIterator* pri) {
    TPOSITION pos = lstcd.GetHeadPosition();
    BYTE* pbyRow = (BYTE*)prow;
    for (int iCol = 0; pos; iCol++) {
        TColumnDescriptor* pcd = lstcd.GetNext(pos);
        if (pcd->lExtraAttrib & dbAutoIncrField) {
            COleVariant var;
            if (bLoadByName)
                pri->prs->GetFieldValue(pcd->strName,var);
            else
                pri->prs->GetFieldValue(iCol,var);
            BYTE* pbyValue = &pbyRow[pcd->iOffset]; 
            switch (pcd->ecdt) {
                case ecdtByte:    *((BYTE*)pbyValue) = (BYTE)(var.iVal); break;
                case ecdtInteger: *((short*)pbyValue) = var.iVal; break;
                case ecdtLong:    *((long*)pbyValue) = var.lVal; break;
                case ecdtSingle:  *((float*)pbyValue) = var.fltVal; break;
                case ecdtDouble:  *((double*)pbyValue) = var.dblVal; break;
                default: ASSERT(0);
            }
        }
    }
}

int TRowMover::ReadBuffer(TRow* prows,TRowIterator* pri,int iNumRows) /* throw CDaoException */ 
{
    BuildBindingArray(prows);
    int iNeededBufferSize = bAnyManualBindings ? iSizeOfRow : (iSizeOfRow*iNumRows);
    if (iReadBufferSize < iNeededBufferSize) {
        delete [] pReadBuffer;
        pReadBuffer = new BYTE[iNeededBufferSize];
        iReadBufferSize = iNeededBufferSize;
    }
    int iNumRead = 0;
    if (!bAnyManualBindings) {
        try {
            CdbRecordset dbrs(pri->prs->m_pDAORecordset,TRUE);
            iNumRead = dbrs.GetRowsEx(pReadBuffer,iSizeOfRow,pbndAuto,iNumAutoBindings,
                                      NULL,0,iNumRows);
        } catch (CdbException* pe) {
            delete pe;
            throw new CDaoException();
        }
        // GetRowsEx zeroes out everything in the read buffer that isn't read from the record, this
        // is why we have to read to a buffer and then transfer the good stuff to the row object.
        FillAutoBindingRows((BYTE*)prows,pReadBuffer,iNumRows);
    }
    return iNumRead;
}

int TRowMover::ReadRows(TRow* prow,TRowIterator* pri,int iNumToRead) /* throw CDaoException */ {
    BuildBindingArray(prow);
    int iNeededBufferSize = bAnyManualBindings ? iSizeOfRow : (iSizeOfRow*iNumToRead);
    if (iReadBufferSize < iNeededBufferSize) {
        delete [] pReadBuffer;
        pReadBuffer = new BYTE[iNeededBufferSize];
        iReadBufferSize = iNeededBufferSize;
    }
    int iNumRead = 0;
    if (bAnyManualBindings) {
        BYTE* pbyDstRow = (BYTE*)prow;
        for (int iRow = 0; iRow < iNumToRead; ) {
            try {
                CdbRecordset dbrs(pri->prs->m_pDAORecordset,TRUE);
                if (dbrs.GetRowsEx(pReadBuffer,iSizeOfRow,pbndAuto,
                                   iNumAutoBindings,NULL,0,1) != 1) break;
                iNumRead++;
                FillAutoBindingRows(pbyDstRow,pReadBuffer,1);
                TPOSITION pos = lstcd.GetHeadPosition();
                int iCol = 0;
                while (pos) {
                    TColumnDescriptor* pcd = lstcd.GetNext(pos);
                    if (pcd->ecdt==ecdtMemo) {
                        char** ppszDestData = (char**)(&(pbyDstRow[pcd->iOffset]));
                        delete [] (*ppszDestData);
                        DWORD dwNewSize = 1 + (bLoadByName ? dbrs.Fields[(const char*)(pcd->strName)].FieldSize() :
                                                             dbrs.Fields[(long)iCol].FieldSize());
                        *ppszDestData = new char[dwNewSize];
                        COleVariant var;
                        if (bLoadByName)
                            pri->prs->GetFieldValue(pcd->strName,var);
                        else
                            pri->prs->GetFieldValue(iCol,var);
                        ASSERT(var.vt==VT_BSTR);
                        memcpy(*ppszDestData,(char*)(var.bstrVal),dwNewSize-1);
                        (*ppszDestData)[dwNewSize-1] = 0;
                    } else if (pcd->ecdt==ecdtCString) {
                        CString* pstr = (CString*)(&(pbyDstRow[pcd->iOffset]));
                        COleVariant var;
                        if (bLoadByName)
                            pri->prs->GetFieldValue(pcd->strName,var);
                        else
                            pri->prs->GetFieldValue(iCol,var);
                        ASSERT(var.vt==VT_BSTR);
                        *pstr = (const char*)(var.bstrVal);
                    } else if (pcd->ecdt==ecdtLongBinary) {
                        BYTE** ppbyDestData = (BYTE**)(&(pbyDstRow[pcd->iOffset]));
                        DWORD dwNewSize = bLoadByName ? dbrs.Fields[(const char*)(pcd->strName)].FieldSize() :
                                                        dbrs.Fields[(long)iCol].FieldSize();
                        if (dwNewSize != 0) {
                            if (dwNewSize != pcd->dwMaxSize || *ppbyDestData == NULL) {
                                delete [] (*ppbyDestData);
                                *ppbyDestData = new BYTE[dwNewSize];
                            }
                            COleVariant var;
                            if (bLoadByName)
                                pri->prs->GetFieldValue(pcd->strName,var);
                            else
                                pri->prs->GetFieldValue(iCol,var);
                            ASSERT(var.vt==(VT_UI1 | VT_ARRAY));
                            BYTE* pSrc;
            	            ::SafeArrayAccessData(var.parray,(void**)(&pSrc));
	                        memcpy(*ppbyDestData,pSrc,min(pcd->dwMaxSize,dwNewSize));
	                        ::SafeArrayUnaccessData(var.parray);
                        } else {    // NULL blob read
                            delete [] (*ppbyDestData);
                            *ppbyDestData = NULL;
                        }
                    } else if (pcd->ecdt==ecdtCByteArray) {
                        CByteArray* pba = (CByteArray*)(&(pbyDstRow[pcd->iOffset]));
                        DWORD dwNewSize = bLoadByName ? dbrs.Fields[(const char*)(pcd->strName)].FieldSize() :
                                                        dbrs.Fields[(long)iCol].FieldSize();
                        if (dwNewSize != 0) {
                            pba->SetSize(dwNewSize);
                            COleVariant var;
                            if (bLoadByName)
                                pri->prs->GetFieldValue(pcd->strName,var);
                            else
                                pri->prs->GetFieldValue(iCol,var);
                            ASSERT(var.vt==(VT_UI1 | VT_ARRAY));
                            BYTE* pSrc;
            	            ::SafeArrayAccessData(var.parray,(void**)(&pSrc));
	                        memcpy(pba->GetData(),pSrc,dwNewSize);
	                        ::SafeArrayUnaccessData(var.parray);
                        } else     // NULL blob read
                            pba->SetSize(0);
                    } else if (pcd->ecdt==ecdtbool || pcd->ecdt==ecdtByte) {
                        BYTE* pby = &(pbyDstRow[pcd->iOffset]);
                        COleVariant var;
                        if (bLoadByName)
                            pri->prs->GetFieldValue(pcd->strName,var);
                        else
                            pri->prs->GetFieldValue(iCol,var);
                        ASSERT(var.vt==VT_I2);
                        *pby = (BYTE)var.iVal;
                    } else if (pcd->pStaticMember) {  
						// else we have some type that is normally auto-binding, but not because it
                        // refers to a static member instead of a per object member.
                        BYTE* pbyValue = (BYTE*)(pcd->pStaticMember);
                        COleVariant var;
                        if (bLoadByName)
                            pri->prs->GetFieldValue(pcd->strName,var);
                        else
                            pri->prs->GetFieldValue(iCol,var);
                        switch (pcd->ecdt) {
                            case ecdtBOOL:
                            case ecdtLong:      ASSERT(var.vt==VT_I4);
                                                *((long*)pbyValue) = var.lVal; 
                                                break;
                            case ecdtInteger:   ASSERT(var.vt==VT_I2);    
                                                *((short*)pbyValue) = var.iVal; 
                                                break;
                            case ecdtSingle:    ASSERT(var.vt==VT_R4);
                                                *((float*)pbyValue) = var.fltVal; 
                                                break;
                            case ecdtDouble:    ASSERT(var.vt==VT_R8);
                                                *((double*)pbyValue) = var.dblVal; 
                                                break;
                            case ecdtDate:      ASSERT(var.vt==VT_DATE);
                                                *((COleDateTime*)pbyValue) = var.date; 
                                                break;
                            case ecdtText:      ASSERT(var.vt==VT_BSTR);
                                                strcpy((char*)pbyValue,(const char*)var.bstrVal);
                                                break;
                            default: ASSERT(0);
                        }
                    }
                    iCol++;
                }
            } catch (CdbException* pe) {
                delete pe;
                throw new CDaoException();
            }
            pbyDstRow += iSizeOfRow;
            // to the next record to read, and we shouldn't either
            iRow++;
            if (iRow != iNumToRead) pri->GoNext();
        }
    } else {    // else no manual bindings and we can do all rows on a single call!!
        try {
            CdbRecordset dbrs(pri->prs->m_pDAORecordset,TRUE);
            iNumRead = dbrs.GetRowsEx(pReadBuffer,iSizeOfRow,pbndAuto,iNumAutoBindings,
                                      NULL,0,iNumToRead);
        } catch (CdbException* pe) {
            delete pe;
            throw new CDaoException();
        }
        // GetRowsEx zeroes out everything in the read buffer that isn't read from the record, this
        // is why we have to read to a buffer and then transfer the good stuff to the row object.
        FillAutoBindingRows((BYTE*)prow,pReadBuffer,iNumRead);
    }
    return iNumRead;
}

void TRowMover::FillAutoBindingRows(BYTE* pbyDstRows,BYTE* pbySrcBuffer,int iNumRows) {
    for (int iRow = 0; iRow < iNumRows; iRow++) {
        NDaoUtilsLocal::TFieldCopyBlock* pfcbLoc = pfcb;
        while (pfcbLoc->iNumBytes) {
            memcpy(&pbyDstRows[pfcbLoc->dwOffset],
                   &pbySrcBuffer[pfcbLoc->dwOffset],pfcbLoc->iNumBytes);
            pfcbLoc++;
        }
        pbyDstRows += iSizeOfRow;
        pbySrcBuffer += iSizeOfRow;
    }
}
//**********************************************************************************************
//
// TVersionedRowMover Definition
//
TVersionedRowMover::TVersionedRowMover(const char* pszOriginalTableName,const char* pszVersionedTableBaseName,
                                       const char* pszPrimaryKey,int AiSizeOfRow,bool AbLoadByName)
    : strOriginalTableName(pszOriginalTableName),strVersionedTableBaseName(pszVersionedTableBaseName),
      strPrimaryKey(pszPrimaryKey),iSizeOfRow(AiSizeOfRow),bLoadByName(AbLoadByName) {
}
TVersionedRowMover::~TVersionedRowMover() {
    TPOSITION pos = lstrm.GetHeadPosition();
    while (pos) delete lstrm.GetNext(pos);
}
CString TVersionedRowMover::GetTableName(const TRow* prAny) const {
    return strVersionedTableBaseName+((TVersionedRow*)prAny)->GetCurrentVersion();
}
void TVersionedRowMover::CreateColumns(const TRow* prAny,CDaoTableDef* ptbldef) /* throw CDaoException */ {
    TBaseRowMover* prm = FindRowMoverFromTableName(GetTableName(prAny),prAny);
    prm->CreateColumns(prAny,ptbldef);
}

int TVersionedRowMover::ReadBuffer(TRow* prows,TRowIterator* pri,int iNumRows) /* throw CDaoException */ 
{
    const char* pszTableName = pri->GetTableName();
    TBaseRowMover* prm = FindRowMoverFromTableName(pszTableName,prows);
    bool bCurrentTable = (GetTableName(prows) == pszTableName);
	int iNumRead = 0;
    if (bCurrentTable) { // if current, we can do it fast (no translation needed)
        iNumRead = prm->ReadRows(prows,pri,iNumRows);
    }
	return iNumRead;
}

int TVersionedRowMover::ReadRows(TRow* prow,TRowIterator* pri,int iNumToRead) /* throw CDaoException */ {
    const char* pszTableName = pri->GetTableName();
    TBaseRowMover* prm = FindRowMoverFromTableName(pszTableName,prow);
    bool bCurrentTable = (GetTableName(prow) == pszTableName);

    if (bCurrentTable)  // if current, we can do it fast (no translation needed)
        return prm->ReadRows(prow,pri,iNumToRead);
    else {      // otherwise translation must be applied one row at a time
        for (int i = 0; i < iNumToRead; ) {
            char* pc = (char*)prow;
            pc += i*iSizeOfRow;
            TRow* prowInArray = (TRow*)pc;
            prm->ReadRows(prowInArray,pri,1);
            ((TVersionedRow*)prowInArray)->TranslateFromOldTable(pszTableName);
            // reads on the current table don't automatically move the iterator
            // to the next record to read, and we shouldn't either
            i++;
            if (i != iNumToRead) pri->GoNext();
        }
        return iNumToRead;
    }
}
void TVersionedRowMover::SetFieldValues(TRow* prow,TRowIterator* pri) /* throw CDaoException */ {
    TBaseRowMover* prm = FindRowMoverFromTableName(pri->GetTableName(),prow);
    prm->SetFieldValues(prow,pri);
}
void TVersionedRowMover::FixupAutoNumberFields(TRow* prow,TRowIterator* pri) /* throw CDaoException */ {
    TBaseRowMover* prm = FindRowMoverFromTableName(pri->GetTableName(),prow);
    prm->FixupAutoNumberFields(prow,pri);
}
TBaseRowMover* TVersionedRowMover::FindRowMoverFromTableName(const char* pszTableName,const TRow* prAny) {
    TPOSITION posHead = lstrm.GetHeadPosition();
    TPOSITION pos = posHead;
    while (pos) {
        TPOSITION posHere = pos;
        TBaseRowMover* prm = lstrm.GetNext(pos);
        if (prm->GetTableName(prAny) == pszTableName) {
            // move to front of list if not alread there so next search will be faster
            if (posHere != posHead) {
                lstrm.RemoveAt(posHere);    
                lstrm.AddHead(prm);
            }
            return prm;
        }
    }
    // if we get here, the row mover will have to be created
    TBaseRowMover* prm = new TRowMover(pszTableName,GetRowSize(),GetPrimaryKey(),
                                       (GetTableName(prAny) == pszTableName) ? bLoadByName : true);
    lstrm.AddHead(prm);
    return prm;
}
TRowIterator* TVersionedRowMover::CreateRowReadIterator(CDaoDatabase* pdb,const char* pszIndex,const TRow* prAny) const
    /* throw CDaoException */ {
    return new NDaoUtilsLocal::TVersionedRowIterator(pdb,GetTableName(prAny),
                                                     strOriginalTableName,strVersionedTableBaseName,pszIndex);
}
TRowIterator* TVersionedRowMover::CreateRowWriteIterator(CDaoDatabase* pdb,const TRow* prAny) const 
    /* throw CDaoException */ {
    TRowIterator* priRet = 0;
    do {
        try {
            priRet = new TRowIterator(pdb,GetTableName(prAny),GetPrimaryKey());
        } catch (CDaoException* pe) {
            if (pe->m_scode == E_DAO_VtoNameNotFound && pe->m_pErrorInfo->m_strSource == _T("DAO.TableDefs")) {
                try { prAny->CreateTable(pdb); }
                catch (CDaoException* pe) {
                    pe->ReportError();
                }
            } else 
                throw;
        }
    } while (priRet == 0);
    return priRet;
}

//**********************************************************************************************
//
// TColumnDescriptor Implementation
//
//
TColumnDescriptor::TColumnDescriptor(const char* AszName,EColumnDescriptorType Aecdt,
                                     int AiOffset,long AlExtraAttrib,void* ApStaticMember)
: ecdt(Aecdt),strName(AszName),iOffset(AiOffset),dwMaxSize(0),
  lExtraAttrib(AlExtraAttrib),pStaticMember(ApStaticMember) {
}
TColumnDescriptor::TColumnDescriptor(const char* AszName,EColumnDescriptorType Aecdt,
                                     DWORD AdwMaxSize,int AiOffset,long AlExtraAttrib,void* ApStaticMember)
: ecdt(Aecdt),strName(AszName),iOffset(AiOffset),dwMaxSize(AdwMaxSize),
  lExtraAttrib(AlExtraAttrib),pStaticMember(ApStaticMember) {
}
void TColumnDescriptor::Create(CDaoTableDef* ptbldef) /* throw CDaoException */ {
    CDaoFieldInfo fi;
    fi.m_strName = strName;
    fi.m_nType = GetDAOType();
    fi.m_lSize = (ecdt == ecdtText) ? (dwMaxSize-1) : 0;
    fi.m_lAttributes = lExtraAttrib;
    fi.m_nOrdinalPosition = 0;
    fi.m_bRequired = FALSE;          
    fi.m_bAllowZeroLength = ((ecdt==ecdtText)||
                             (ecdt==ecdtMemo)||
                             (ecdt==ecdtCString)) ? TRUE : FALSE;
    fi.m_lCollatingOrder = 0;
    ptbldef->CreateField(fi);
}

DataTypeEnum TColumnDescriptor::GetDAOType() const {
    static const DataTypeEnum dbInv = (DataTypeEnum)(-1);
    static const DataTypeEnum db[] = {
        dbBoolean,      // ecdtBOOL
        dbInteger,      // ecdtbool
        dbInteger,      // ecdtByte
        dbInteger,      // ecdtInteger
        dbLong,         // ecdtLong
        dbSingle,       // ecdtSingle
        dbDouble,       // ecdtDouble
        dbDate,         // ecdtDate
        dbText,         // ecdtText
        dbLongBinary,   // ecdtLongBinary
        dbMemo,         // ecdtMemo
        dbMemo,         // ecdtCString
        dbLongBinary    // ecdtCByteArray
    };
    DataTypeEnum dbRet = dbInv;
    if (ecdt <= ecdtCByteArray) dbRet = db[ecdt];
    ASSERT(dbRet != dbInv);
    return dbRet;
}

DWORD TColumnDescriptor::GetBindingType() const {
    static const DWORD bndInv = (DWORD)(-1);
    static const DWORD bnd[] = {
        dbBindBOOL,     // ecdtBOOL
        bndInv,         // ecdtbool
        bndInv,         // ecdtByte
        dbBindI2,       // ecdtInteger
        dbBindI4,       // ecdtLong
        dbBindR4,       // ecdtSingle
        dbBindR8,       // ecdtDouble
        dbBindDATE,     // ecdtDate
        dbBindSTRING,   // ecdtText
        bndInv,         // ecdtLongBinary
        bndInv,         // ecdtMemo
        bndInv,         // ecdtCString
        bndInv          // ecdtCByteArray
    };
    DWORD bndRet = bndInv;
    if (ecdt <= ecdtCByteArray) bndRet = bnd[ecdt];
    ASSERT(bndRet != bndInv);
    return bndRet;
}

DWORD TColumnDescriptor::GetBindingSize() const {
    static const DWORD sizInv = (DWORD)(-1);
    static const DWORD bnd[] = {
        sizeof(BOOL),           // ecdtBOOL
        sizInv,                 // ecdtbool
        sizInv,                 // ecdtByte
        sizeof(short),          // ecdtInteger
        sizeof(long),           // ecdtLong
        sizeof(float),          // ecdtSingle
        sizeof(double),         // ecdtDouble
        sizeof(COleDateTime),   // ecdtDate
        sizInv,                 // ecdtText
        sizInv,                 // ecdtLongBinary
        sizInv,                 // ecdtMemo
        sizInv,                 // ecdtCString
        sizInv                  // ecdtCByteArray
    };
    DWORD sizRet = sizInv;
    if (ecdt == ecdtText) sizRet = dwMaxSize;
    else if (ecdt <= ecdtCByteArray) sizRet = bnd[ecdt];
    ASSERT(sizRet != sizInv);
    return sizRet;
}

//**********************************************************************************************
//
// TRowVersion Definition
//
/* test code -- run this to make sure the encode/decode works
    TRowVersion rv(0x5,3);      // "K"
    rv += TRowVersion(0x3,2);   // "N" = "K" + "O"
    rv += TRowVersion(0x7F,7);  // "NVO" = "N" + "VS"
    rv += TRowVersion(0x2,2);   // "NVS" = "NVO" + "G"
    rv <<= 5;  // "VS"
    rv <<= 2;  // "VG"
    rv <<= 2;  // "U"
    rv <<= 3;  // "G"
    rv <<= 1;  // "0"
*/
const int TRowVersion::iBitsPerChar = 5;
const int TRowVersion::iBitMask = (1 << iBitsPerChar) - 1;

TRowVersion::TRowVersion(int iVersion,int AiBitCount) {
    iBitCount = AiBitCount;
    int iChars = (iBitCount-1)/iBitsPerChar + 1;
    char* pc = str.GetBuffer(iChars);
    iVersion <<= (32-iBitCount);
    for (int i = 0; i < iChars; i++) 
        pc[i] = BitsToChar(ShiftLeftN(&iVersion,iBitsPerChar));
    str.ReleaseBuffer(iChars);
}

TRowVersion::TRowVersion(const char* psz)
 : str(psz) {
    iBitCount = iBitsPerChar * str.GetLength();
}
TRowVersion::TRowVersion(const TRowVersion& other) {
    *this = other;
}

TRowVersion& TRowVersion::operator=(const TRowVersion& other) {
    str = (const CString)other;
    iBitCount = other.GetBitCount();
    return *this;
}

int TRowVersion::PullBits(int iHowMany) {
    if (iBitCount == 0) return -1;
    int i = CharToBits(str[0]);
    *this <<= iHowMany;
    return ShiftLeftN(&i,32-iBitsPerChar+iHowMany);
}

TRowVersion& TRowVersion::operator<<=(int iNumBitsToPull) {
    if (iBitCount==0) return *this;
    // build a new string of the appropriate length
    CString strNew;
    int iNewBitCount = iBitCount - iNumBitsToPull;
    int iNewChars = (iNewBitCount-1)/iBitsPerChar + 1;
    char* pcNew = strNew.GetBuffer(iNewChars);

    // characterize the copy loop
    const char* pcOld = str;    // assume we start at first char
    pcOld += iNumBitsToPull / iBitsPerChar; // now bump to char with any bits to copy
    int iLastBits = 0;          // bits left over from initial partial char (assume no initial partial char)
    // figure number of bits we are pulling out of initial char
    int iBitOffset = iNumBitsToPull % iBitsPerChar;
    // if we are keeping only some bits from initial char, then we
    // need to put those bits in iLastBits and inc the source pointer
    if (iBitOffset) iLastBits = (CharToBits(*pcOld++) << iBitOffset) & iBitMask;
    // loop till we've copied all the bits
    int iBitsCopied = 0;      // declare nothing copied in yet
    while (iBitsCopied < iNewBitCount) {
        if (iBitOffset) {
            // get old bits and position them to shift    
            int iOldBits = CharToBits(*pcOld++);
            int iBits = iLastBits | ShiftLeftN(&iOldBits,32-iBitsPerChar+iBitOffset);
            // save remaining bits in source char for next time through
            iLastBits = iOldBits ? ShiftLeftN(&iOldBits,iBitsPerChar) : 0;
            *pcNew++ = BitsToChar(iBits);
        } else *pcNew++ = *pcOld++;
        iBitsCopied += iBitsPerChar;  // declare some more bits moved
    }
    strNew.ReleaseBuffer(iNewChars);

    // make new values official
    str = strNew;
    iBitCount = iNewBitCount;
    return *this;
}

TRowVersion& TRowVersion::operator+=(const TRowVersion& rvOther) {
    // build a new string of the appropriate length
    CString strNew;
    int iNewBitCount = iBitCount + rvOther.iBitCount;
    int iNewChars = (iNewBitCount-1)/iBitsPerChar + 1;

    // copy current bits into new string
    int iOldChars = str.GetLength();    // not NULL terminated, so we have to count chars
    const char* pcOld = str;
    char* pcNew = strNew.GetBuffer(iNewChars);
    for (int i = 0; i < iOldChars; i++) *pcNew++ = *pcOld++;

    // characterize the "copy other" loop
    int iLastBits = 0;      // bits left over from last partial char (assume no last partial char)
    // adjust initial target char and left over bits if we
    // have an initial partial char to finish filling
    int iBitOffset = iBitCount % iBitsPerChar;
    if (iBitOffset) {
        pcNew--;                        // back off next char to be same as last char copied in
        iLastBits = CharToBits(*pcNew); // get bits from last char copied in
    }
    // calc number of bits to initially shift in from other rv
    int iShiftCount = iBitsPerChar - iBitOffset; 

    // loop till we've copied all the bits
    int iBitsCopied = 0;    // declare nothing copied in yet
    const char* pcOther = rvOther.str;  // pointer to source chars
    while (iBitsCopied < rvOther.iBitCount) {
        int iOtherBits = CharToBits(*pcOther++);
        int iBits = iLastBits | ShiftLeftN(&iOtherBits,32-iBitsPerChar+iShiftCount);
        *pcNew++ = BitsToChar(iBits);
        // save remaining bits in source char for next time through
        iLastBits = iOtherBits ? ShiftLeftN(&iOtherBits,iBitsPerChar) : 0;
        iBitsCopied += (iBitsCopied ? iBitsPerChar : iShiftCount);  // declare some more bits moved
    }
    strNew.ReleaseBuffer(iNewChars);
    // make new values official
    str = strNew;
    iBitCount = iNewBitCount;
    return *this;
}

char TRowVersion::BitsToChar(int i) {
    if (i <= 9) return '0' + (char)i;
    return 'A' + (char)(i - 10);
}

int TRowVersion::CharToBits(char c) {
    if (c == 0) return 0;
    if (c >= '0' && c <= '9') return c - '0';
    return 10 + (c - 'A');
}
