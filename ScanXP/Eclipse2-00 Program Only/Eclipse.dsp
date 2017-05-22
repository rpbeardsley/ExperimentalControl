# Microsoft Developer Studio Project File - Name="Eclipse" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=Eclipse - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Eclipse.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Eclipse.mak" CFG="Eclipse - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Eclipse - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "Eclipse - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Eclipse - Win32 Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "..\UtilLib\Release" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 version.lib /nologo /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "Eclipse - Win32 Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "..\UtilLib\Debug" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /FR /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x409 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 version.lib /nologo /subsystem:windows /profile /debug /machine:I386

!ENDIF 

# Begin Target

# Name "Eclipse - Win32 Release"
# Name "Eclipse - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\AcquisitionTab.cpp
# End Source File
# Begin Source File

SOURCE=.\AddCalItem.cpp
# End Source File
# Begin Source File

SOURCE=.\AnalysisTab.cpp
# End Source File
# Begin Source File

SOURCE=.\AverageSaveDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\AverageView.cpp
# End Source File
# Begin Source File

SOURCE=.\Calibration.cpp
# End Source File
# Begin Source File

SOURCE=.\CalibrationTab.cpp
# End Source File
# Begin Source File

SOURCE=.\CalibrationView.cpp
# End Source File
# Begin Source File

SOURCE=.\CompAdvanced.cpp
# End Source File
# Begin Source File

SOURCE=.\DataHover.cpp
# End Source File
# Begin Source File

SOURCE=.\Eclipse.cpp
# End Source File
# Begin Source File

SOURCE=.\Eclipse.rc
# End Source File
# Begin Source File

SOURCE=.\EclipseDoc.cpp
# End Source File
# Begin Source File

SOURCE=.\FloatEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\GraphProperties.cpp
# End Source File
# Begin Source File

SOURCE=.\gsx2.cpp
# End Source File
# Begin Source File

SOURCE=.\ics.cpp
# End Source File
# Begin Source File

SOURCE=.\indicators.cpp
# End Source File
# Begin Source File

SOURCE=.\InfoBar.cpp
# End Source File
# Begin Source File

SOURCE=.\InfoBarDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\InstStatusBar.cpp
# End Source File
# Begin Source File

SOURCE=.\InstStatusBarDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\MainFrm.cpp
# End Source File
# Begin Source File

SOURCE=.\ModifyData.cpp
# End Source File
# Begin Source File

SOURCE=.\OverlayProps.cpp
# End Source File
# Begin Source File

SOURCE=.\PropGeneralPage.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol1Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol2Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol3Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol4Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol5Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol6Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol7Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropProtocol8Page.cpp
# End Source File
# Begin Source File

SOURCE=.\PropSheet.cpp
# End Source File
# Begin Source File

SOURCE=.\ProtocolAdvanced.cpp
# End Source File
# Begin Source File

SOURCE=.\QuadFit.cpp
# End Source File
# Begin Source File

SOURCE=.\RecalcTrendDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\SaveAs.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectedProperties.cpp
# End Source File
# Begin Source File

SOURCE=.\Settings.cpp
# End Source File
# Begin Source File

SOURCE=.\ShowFFT.cpp
# End Source File
# Begin Source File

SOURCE=.\Splash.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# Begin Source File

SOURCE=.\TrendSetup.cpp
# End Source File
# Begin Source File

SOURCE=.\TrendView.cpp
# End Source File
# Begin Source File

SOURCE=.\WindowData.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\AcquisitionTab.h
# End Source File
# Begin Source File

SOURCE=.\AddCalItem.h
# End Source File
# Begin Source File

SOURCE=.\AnalysisTab.h
# End Source File
# Begin Source File

SOURCE=.\AverageSaveDlg.h
# End Source File
# Begin Source File

SOURCE=.\AverageView.h
# End Source File
# Begin Source File

SOURCE=.\Calibration.h
# End Source File
# Begin Source File

SOURCE=.\CalibrationTab.h
# End Source File
# Begin Source File

SOURCE=.\CalibrationView.h
# End Source File
# Begin Source File

SOURCE=.\CompAdvanced.h
# End Source File
# Begin Source File

SOURCE=.\DataHover.h
# End Source File
# Begin Source File

SOURCE=.\Eclipse.h
# End Source File
# Begin Source File

SOURCE=.\EclipseDoc.h
# End Source File
# Begin Source File

SOURCE=.\FloatEdit.h
# End Source File
# Begin Source File

SOURCE=.\GraphProperties.h
# End Source File
# Begin Source File

SOURCE=.\gsx2.h
# End Source File
# Begin Source File

SOURCE=.\ics.h
# End Source File
# Begin Source File

SOURCE=.\indicators.h
# End Source File
# Begin Source File

SOURCE=.\InfoBar.h
# End Source File
# Begin Source File

SOURCE=.\InfoBarDlg.h
# End Source File
# Begin Source File

SOURCE=.\InstStatusBar.h
# End Source File
# Begin Source File

SOURCE=.\InstStatusBarDlg.h
# End Source File
# Begin Source File

SOURCE=.\MainFrm.h
# End Source File
# Begin Source File

SOURCE=.\ModifyData.h
# End Source File
# Begin Source File

SOURCE=.\OverlayProps.h
# End Source File
# Begin Source File

SOURCE=.\PropGeneralPage.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol1Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol2Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol3Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol4Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol5Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol6Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol7Page.h
# End Source File
# Begin Source File

SOURCE=.\PropProtocol8Page.h
# End Source File
# Begin Source File

SOURCE=.\PropSheet.h
# End Source File
# Begin Source File

SOURCE=.\ProtocolAdvanced.h
# End Source File
# Begin Source File

SOURCE=.\QuadFit.h
# End Source File
# Begin Source File

SOURCE=.\RecalcTrendDlg.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\SaveAs.h
# End Source File
# Begin Source File

SOURCE=.\SelectedProperties.h
# End Source File
# Begin Source File

SOURCE=.\Settings.h
# End Source File
# Begin Source File

SOURCE=.\ShowFFT.h
# End Source File
# Begin Source File

SOURCE=.\Splash.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\TrendSetup.h
# End Source File
# Begin Source File

SOURCE=.\TrendView.h
# End Source File
# Begin Source File

SOURCE=.\WindowData.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;cnt;rtf;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\RES\Eclipse.ico
# End Source File
# Begin Source File

SOURCE=.\RES\Eclipse.rc2
# End Source File
# Begin Source File

SOURCE=.\RES\EclipseDoc.ico
# End Source File
# Begin Source File

SOURCE=.\RES\ico00001.ico
# End Source File
# Begin Source File

SOURCE=.\RES\ico00002.ico
# End Source File
# Begin Source File

SOURCE=.\RES\ico00003.ico
# End Source File
# Begin Source File

SOURCE=.\RES\icon1.ico
# End Source File
# Begin Source File

SOURCE=.\Splsh16.bmp
# End Source File
# Begin Source File

SOURCE=.\res\Toolbar.bmp
# End Source File
# Begin Source File

SOURCE=.\RES\toolbar1.bmp
# End Source File
# Begin Source File

SOURCE=.\zoom.cur
# End Source File
# End Group
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# Begin Source File

SOURCE=.\UtilLib\Release\UtilLib.lib
# End Source File
# End Target
# End Project
# Section Eclipse: {4DA21426-C3EE-11D1-90D2-0060089615C2}
# 	2:21:DefaultSinkHeaderFile:gsx.h
# 	2:16:DefaultSinkClass:CGSX
# End Section
# Section Eclipse : {4DA21424-C3EE-11D1-90D2-0060089615C2}
# 	2:5:Class:CGSXDialog
# 	2:10:HeaderFile:gsxdialog.h
# 	2:8:ImplFile:gsxdialog.cpp
# End Section
# Section Eclipse: {DC2C58A1-32B4-11D2-A0B5-0060089615C2}
# 	2:5:Class:CGSXCtrl2
# 	2:10:HeaderFile:gsxctrl2.h
# 	2:8:ImplFile:gsxctrl2.cpp
# End Section
# Section Eclipse : {FA911B00-5F7D-11D2-A0C0-0060089615C2}
# 	2:5:Class:CGSX2
# 	2:10:HeaderFile:gsx2.h
# 	2:8:ImplFile:gsx2.cpp
# End Section
# Section Eclipse: {4DA21424-C3EE-11D1-90D2-0060089615C2}
# 	2:5:Class:CGSX
# 	2:10:HeaderFile:gsx.h
# 	2:8:ImplFile:gsx.cpp
# End Section
# Section Eclipse: {18107EB3-C8D5-11D1-90DA-0060089615C2}
# 	2:5:Class:CIndicators
# 	2:10:HeaderFile:indicators.h
# 	2:8:ImplFile:indicators.cpp
# End Section
# Section Eclipse: {44C03C95-32D8-11D2-A0B5-0060089615C2}
# 	2:21:DefaultSinkHeaderFile:gsx2.h
# 	2:16:DefaultSinkClass:CGSX2
# End Section
# Section Eclipse: {097E2126-9F0C-11D1-9080-0060089615C2}
# 	2:21:DefaultSinkHeaderFile:indicators.h
# 	2:16:DefaultSinkClass:CIndicators
# End Section
# Section Eclipse : {4DA21426-C3EE-11D1-90D2-0060089615C2}
# 	2:21:DefaultSinkHeaderFile:gsx.h
# 	2:16:DefaultSinkClass:CGSX
# End Section
# Section Eclipse: {44C03C94-32D8-11D2-A0B5-0060089615C2}
# 	2:5:Class:CGSX2
# 	2:10:HeaderFile:gsx2.h
# 	2:8:ImplFile:gsx2.cpp
# End Section
# Section Eclipse: {DC2C58A2-32B4-11D2-A0B5-0060089615C2}
# 	2:21:DefaultSinkHeaderFile:gsxctrl2.h
# 	2:16:DefaultSinkClass:CGSXCtrl2
# End Section
# Section Eclipse : {00000000-0078-0000-0000-000000000000}
# 	1:10:IDB_SPLASH:102
# 	2:21:SplashScreenInsertKey:4.0
# End Section
# Section Eclipse : {FA911B02-5F7D-11D2-A0C0-0060089615C2}
# 	2:21:DefaultSinkHeaderFile:gsx2.h
# 	2:16:DefaultSinkClass:CGSX2
# End Section
