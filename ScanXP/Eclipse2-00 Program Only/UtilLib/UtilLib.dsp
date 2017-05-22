# Microsoft Developer Studio Project File - Name="UtilLib" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=UtilLib - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "UtilLib.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "UtilLib.mak" CFG="UtilLib - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "UtilLib - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "UtilLib - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""$/TotalPowerStep/UtilLib", BHLAAAAA"
# PROP Scc_LocalPath "."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "UtilLib - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
F90=df.exe
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GR /GX /Zi /Ot /Og /Oi /Oy /Ob1 /I "..\\" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /YX"stdafx.h" /FD /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "UtilLib - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
F90=df.exe
# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MDd /W3 /GR /GX /Zi /Od /I "..\\" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "UtilLib - Win32 Release"
# Name "UtilLib - Win32 Debug"
# Begin Source File

SOURCE=.\AnalysisUtils.cpp
# End Source File
# Begin Source File

SOURCE=.\AnalysisUtils.h
# End Source File
# Begin Source File

SOURCE=.\ArrowDown.bmp
# End Source File
# Begin Source File

SOURCE=.\ArrowRight.bmp
# End Source File
# Begin Source File

SOURCE=.\Complex.cpp
# End Source File
# Begin Source File

SOURCE=.\Complex.h
# End Source File
# Begin Source File

SOURCE=.\ComplexArray.cpp
# End Source File
# Begin Source File

SOURCE=.\ComplexExp.cpp
# End Source File
# Begin Source File

SOURCE=.\CRC.cpp
# End Source File
# Begin Source File

SOURCE=.\CRC.h
# End Source File
# Begin Source File

SOURCE=.\DaoUtils.cpp
# End Source File
# Begin Source File

SOURCE=.\DaoUtils.h
# End Source File
# Begin Source File

SOURCE=.\FileUtils.cpp
# End Source File
# Begin Source File

SOURCE=.\FileUtils.h
# End Source File
# Begin Source File

SOURCE=.\heap.h
# End Source File
# Begin Source File

SOURCE=.\indicators.cpp
# End Source File
# Begin Source File

SOURCE=.\Indicators.h
# End Source File
# Begin Source File

SOURCE=.\IntegralSecondsEntry.cpp
# End Source File
# Begin Source File

SOURCE=.\IntegralSecondsEntry.h
# End Source File
# Begin Source File

SOURCE=.\List.h
# End Source File
# Begin Source File

SOURCE=.\MyControls.cpp
# End Source File
# Begin Source File

SOURCE=.\MyControls.h
# End Source File
# Begin Source File

SOURCE=.\MyControls.rc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\MyControlsTmplt.h
# End Source File
# Begin Source File

SOURCE=.\Notifier.cpp
# End Source File
# Begin Source File

SOURCE=.\Notifier.h
# End Source File
# Begin Source File

SOURCE=.\NumberUtils.cpp
# End Source File
# Begin Source File

SOURCE=.\NumberUtils.h
# End Source File
# Begin Source File

SOURCE=.\OhmEditBox.cpp
# End Source File
# Begin Source File

SOURCE=.\OhmEditBox.h
# End Source File
# Begin Source File

SOURCE=.\ProgressDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\ProgressDlg.h
# End Source File
# Begin Source File

SOURCE=.\ProgressDlg.rc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\RedBlkTree.h
# End Source File
# Begin Source File

SOURCE=.\ScreenBuffer.cpp
# End Source File
# Begin Source File

SOURCE=.\ScreenBuffer.h
# End Source File
# Begin Source File

SOURCE=.\statistics.cpp
# End Source File
# Begin Source File

SOURCE=.\statistics.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "UtilLib - Win32 Release"

!ELSEIF  "$(CFG)" == "UtilLib - Win32 Debug"

# ADD CPP /Yc"stdafx.h"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\Stdafx.h
# End Source File
# Begin Source File

SOURCE=.\StretchedBitmapStatic.cpp
# End Source File
# Begin Source File

SOURCE=.\StretchedBitmapStatic.h
# End Source File
# Begin Source File

SOURCE=.\ThreadUtils.h
# End Source File
# Begin Source File

SOURCE=.\UtilLibResource.h
# End Source File
# End Target
# End Project
