# Microsoft Developer Studio Generated NMAKE File, Format Version 4.20
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

!IF "$(CFG)" == ""
CFG=scan97 - Win32 Release
!MESSAGE No configuration specified.  Defaulting to scan97 - Win32 Release.
!ENDIF 

!IF "$(CFG)" != "scan97 - Win32 Release"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "scan97.mak" CFG="scan97 - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "scan97 - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
# PROP Target_Last_Scanned "scan97 - Win32 Release"
MTL=mktyplib.exe
RSC=rc.exe
CPP=cl.exe
# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\Release
INTDIR=.\Release

ALL : "$(OUTDIR)\scan97.dll"

CLEAN : 
	-@erase "$(INTDIR)\digitiser.obj"
	-@erase "$(INTDIR)\general.obj"
	-@erase "$(INTDIR)\ieee.obj"
	-@erase "$(OUTDIR)\scan97.dll"
	-@erase "$(OUTDIR)\scan97.exp"
	-@erase "$(OUTDIR)\scan97.lib"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /G5 /Gz /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD BASE MTL /nologo /D "NDEBUG" /win32
# ADD MTL /nologo /D "NDEBUG" /win32
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/scan97.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:windows /dll /incremental:no\
 /pdb:"$(OUTDIR)/scan97.pdb" /machine:I386 /def:".\scan97.def"\
 /out:"$(OUTDIR)/scan97.dll" /implib:"$(OUTDIR)/scan97.lib" 
DEF_FILE= \
	".\scan97.def"
LINK32_OBJS= \
	"$(INTDIR)\digitiser.obj" \
	"$(INTDIR)\general.obj" \
	"$(INTDIR)\ieee.obj"

"$(OUTDIR)\scan97.dll" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

MTL_PROJ=/nologo /D "NDEBUG" /win32 
CPP_PROJ=/nologo /G5 /Gz /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/scan97.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=.\.

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "scan97 - Win32 Release"
################################################################################
# Begin Source File

SOURCE=.\ieee.c
DEP_CPP_IEEE_=\
	".\scan97.h"\
	

"$(INTDIR)\ieee.obj" : $(SOURCE) $(DEP_CPP_IEEE_) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\scan97.def
# End Source File
################################################################################
# Begin Source File

SOURCE=.\general.cpp
DEP_CPP_GENER=\
	".\RADHWLib.h"\
	".\scan97.h"\
	

"$(INTDIR)\general.obj" : $(SOURCE) $(DEP_CPP_GENER) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\digitiser.c
DEP_CPP_DIGIT=\
	".\scan97.h"\
	

"$(INTDIR)\digitiser.obj" : $(SOURCE) $(DEP_CPP_DIGIT) "$(INTDIR)"


# End Source File
# End Target
# End Project
################################################################################
