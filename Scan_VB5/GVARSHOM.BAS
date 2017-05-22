Attribute VB_Name = "GVARSHOM"
Type IMAGE_HEADER
 information As String * 104
 mirrorX As Long
 mirrorY As Long
 scanwidth As Single
 scanheight As Single
 scanstepsize As Single
 scanangle As Single
 Poll As Integer
 
End Type

Type BITMAPINFOHEADER
    BISIZE As Long
    biwidth As Long
    biheight As Long
    biplanes As Integer
    biBitCount As Integer
    bicompression As Long
    bisizeimage As Long
    bixpelspermeter As Long
    biypelspermeter As Long
    biclrused As Long
    biclrimportant As Long
End Type

Type BITMAPINFO
    bmiheader As BITMAPINFOHEADER
    bmicolors As String * 1024 '256 4-byte colour indices
End Type

Type LOGPALETTE
palversion As Integer         ' Conforms to Windows 3.x
palnumentries As Integer      ' no. of distict colours in palette
palpalentry As String * 1024  ' 4 bytes to define each colour
                              ' *256 colours= 1024
End Type

Global BMI As BITMAPINFO
Global BMIinfo As BITMAPINFOHEADER
Global palette_type As Integer

' More global constants, to work
' with GetDeviceCaps
   Global Const DRIVERVERSION = 0
   Global Const TECHNOLOGY = 2
   Global Const HORZSIZE = 4
   Global Const VERTSIZE = 6
   Global Const HORZRES = 8
   Global Const VERTRES = 10
   Global Const BITSPIXEL = 12
   Global Const PLANES = 14
   Global Const NUMBRUSHES = 16
   Global Const NUMPENS = 18
   Global Const NUMMARKERS = 20
   Global Const NUMFONTS = 22

   Global Const NUMCOLORS = 24
   Global Const PDEVICESIZE = 26
   Global Const CURVECAPS = 28
   Global Const LINECAPS = 30
   Global Const POLYGONALCAPS = 32
   Global Const TEXTCAPS = 34
   Global Const CLIPCAPS = 36
   Global Const RASTERCAPS = 38
   Global Const ASPECTX = 40
   Global Const ASPECTY = 42
   Global Const ASPECTXY = 44
   Global Const LOGPIXELSX = 88
   Global Const LOGPIXELSY = 90
   Global Const SIZEPALETTE = 104
   Global Const NUMRESERVED = 106
   Global Const COLORRES = 108
   Global Const DT_PLOTTER = 0
   Global Const DT_RASDISPLAY = 1
   Global Const DT_RASPRINTER = 2
   Global Const DT_RASCAMERA = 3
   Global Const DT_CHARSTREAM = 4
   Global Const DT_METAFILE = 5

   Global Const DT_DISPFILE = 6
   Global Const CP_NONE = 0
   Global Const CP_RECTANGLE = 1
   Global Const RC_BITBLT = 1
   Global Const RC_BANDING = 2
   Global Const RC_SCALING = 4
   Global Const RC_BITMAP64 = 8
   Global Const RC_GDI20_OUTPUT = &H10
   Global Const RC_DI_BITMAP = &H80
   Global Const RC_PALETTE = &H100
   Global Const RC_DIBTODEV = &H200
   Global Const RC_BIGFONT = &H400
   Global Const RC_STRETCHBLT = &H800
   Global Const RC_FLOODFILL = &H1000
   Global Const RC_STRETCHDIB = &H2000

 Global Const CBM_INIT = &H4&    '  initialize bitmap
 Global Const DIB_RGB_COLORS = 0 '  color table in RGBTriples
 Global Const SRCCOPY = &HCC0020 ' (DWORD) dest = source
 Global Const STRETCHBLTAPI = 2048
 Global Const BI_RGB = 0

' Global Memory Flags

Global Const GMEM_FIXED = &H0
Global Const GMEM_MOVEABLE = &H2
Global Const GMEM_NOCOMPACT = &H10
Global Const GMEM_NODISCARD = &H20
Global Const GMEM_ZEROINIT = &H40
Global Const GMEM_MODIFY = &H80
Global Const GMEM_DISCARDABLE = &H100
Global Const GMEM_NOT_BANKED = &H1000
Global Const GMEM_SHARE = &H2000
Global Const GMEM_DDESHARE = &H2000
Global Const GMEM_NOTIFY = &H4000
Global Const GMEM_LOWER = GMEM_NOT_BANKED
Global Const GHND = (GMEM_MOVEABLE Or GMEM_ZEROINIT)
Global Const GPTR = (GMEM_FIXED Or GMEM_ZEROINIT)


' Windows API declarations for disk I/O
Declare Function getmodulehandle Lib "Kernel" (ByVal lpModuleName As String) As Integer
Declare Function hread Lib "Kernel" Alias "_hread" (ByVal hFile As Integer, lpmem As Any, ByVal lsize As Long) As Long
Declare Function hwrite Lib "Kernel" Alias "_hwrite" (ByVal hFile As Integer, lpmem As Any, ByVal lsize As Long) As Long
Declare Function lClose Lib "Kernel" Alias "_lclose" (ByVal hFile As Integer) As Integer
Declare Sub hmemcpy Lib "Kernel" (ByVal hpvdest As Any, ByVal hpvsource As Any, ByVal cpcopy As Long)
'Declare Function lseek Lib "Kernel" Alias "_llseek" (ByVal hFile As Integer, ByVal lOffset As Long, ByVal iOrigin As Integer) As Long
Declare Function GlobalLock Lib "Kernel" (ByVal hMem As Integer) As Long
Declare Function GlobalAlloc Lib "Kernel" (ByVal wFlags As Integer, ByVal dwBytes As Long) As Integer
Declare Function GlobalUnlock Lib "Kernel" (ByVal hMem As Integer) As Integer
Declare Function GlobalFree Lib "Kernel" (ByVal hMem As Integer) As Integer
Declare Function fRead Lib "Kernel" Alias "_lread" (ByVal hFile, lpBuff As Any, ByVal wbytes)
Declare Function lstrcpy Lib "Kernel" (p1 As Any, p2 As Any) As Long
Declare Function lstrcat Lib "Kernel" (b1 As Any, b2 As Any) As Long
Declare Function localfree Lib "Kernel" (ByVal hMem As Integer) As Integer


' Windows API declarations for bitmap creation and manipulation

Declare Function SendMessage Lib "user" (ByVal hWnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, lParam As Any) As Long
Declare Function realizepalette Lib "user" (ByVal hDC As Integer) As Integer
Declare Function selectpalette Lib "user" (ByVal hDC As Integer, ByVal hPalette As Integer, ByVal bForceBackground As Integer) As Integer
Declare Function createpalette Lib "GDI" (lplogpalette As LOGPALETTE) As Integer

Declare Function stretchDIbits Lib "GDI" (ByVal hDC As Integer, ByVal destX As Integer, ByVal destY As Integer, ByVal dX As Integer, ByVal dY As Integer, ByVal SrcX As Integer, ByVal SrcY As Integer, ByVal wSrcWidth As Integer, ByVal wSrcHeight As Integer, ByVal lpBits As Any, lpBitsInfo As BITMAPINFO, ByVal wUsage As Integer, ByVal dwRop&)
Declare Function createDIbitmap Lib "GDI" (ByVal hDC As Integer, lpInfoHeader As BITMAPINFOHEADER, ByVal dwUsage As Long, ByVal lpInitBits As Any, lpInitInfo As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function GetDIBits Lib "GDI" (ByVal aHDC As Integer, ByVal hBitmap As Integer, ByVal nStartScan As Integer, ByVal nNumScans As Integer, ByVal lpBits As String, lpBI As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function setDIbitstodevice% Lib "GDI" (ByVal hDC As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal dX As Integer, ByVal dY As Integer, ByVal SrcX As Integer, ByVal SrcY As Integer, ByVal Scan As Integer, ByVal NumScans As Integer, ByVal Bits As Any, BitsInfo As BITMAPINFO, ByVal wUsage As Integer)

Declare Function CreateBitmap Lib "GDI" (ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nPlanes As Integer, ByVal nBitCount As Integer, ByVal lpBits As Any) As Integer
Declare Function getbitmapbits Lib "GDI" (ByVal hBitmap As Integer, ByVal dwCount As Long, ByVal lpBits As Any) As Long
Declare Function loadbitmap Lib "user" (ByVal hInstance As Integer, ByVal lpBitmapName As Any) As Integer
Declare Function SetMenuItemBitMaps% Lib "user" (ByVal hMenu%, ByVal nPos%, ByVal wFlag%, ByVal BitmapUnChecked%, ByVal hBitmapChecked%)
Declare Function CreateCompatibleBitmap Lib "GDI" (ByVal hDC As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer

Declare Function BitBlt Lib "GDI" (ByVal hDestDC As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hSrcDC As Integer, ByVal XSrc As Integer, ByVal YSrc As Integer, ByVal dwRop As Long) As Integer
Declare Function StretchBlt% Lib "GDI" (ByVal hDC%, ByVal X%, ByVal Y%, ByVal nWidth%, ByVal nHeight%, ByVal hSrcDC%, ByVal XSrc%, ByVal YSrc%, ByVal nSrcWidth%, ByVal nSrcHeight%, ByVal dwRop&)
Declare Function SetStretchBltMode Lib "GDI" (ByVal hDC As Integer, ByVal nStretchMode As Integer) As Integer

Declare Function openclipboard Lib "user" (ByVal hWnd As Integer) As Integer
Declare Function setclipboarddata Lib "user" (ByVal wFormat As Integer, ByVal hMem As Integer) As Integer
Declare Function closeclipboard Lib "user" () As Integer
Declare Function emptyclipboard Lib "user" () As Integer

Declare Function getobjectapi% Lib "GDI" Alias "GetObject" (ByVal hObject As Integer, ByVal nCount As Integer, ByVal lpObject As Long)
Declare Function DeleteObject Lib "GDI" (ByVal hObject As Integer) As Integer
Declare Function SelectObject Lib "GDI" (ByVal hDC As Integer, ByVal hObject As Integer) As Integer

Declare Function DeleteDC Lib "GDI" (ByVal hDC As Integer) As Integer
Declare Function getDC Lib "user" (ByVal hWnd As Integer) As Integer
Declare Function releaseDC Lib "user" (ByVal hWnd As Integer, ByVal hDC As Integer) As Integer
Declare Function CreateCompatibleDC Lib "GDI" (ByVal hDC As Integer) As Integer

Declare Function SetPixel Lib "GDI" (ByVal hDC As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal crColor As Long) As Long
Declare Function GetDeviceCaps Lib "GDI" (ByVal hDC As Integer, ByVal nindex As Integer) As Integer
Declare Function getdesktophwnd Lib "user" () As Integer
Declare Function updatecolors Lib "GDI" (ByVal hDC As Integer) As Integer

Declare Function CreateIC Lib "GDI" (ByVal lpDriverName$, ByVal lpDeviceName$, ByVal lpOutput$, ByVal lpInitData&) As Integer
Declare Function GetProfileString Lib "Kernel" (ByVal lpAppName$, ByVal lpKeyName$, ByVal lpDefault$, ByVal lpReturnedString$, ByVal nSize%) As Integer

   ' Enter each of the following Declare statements as one, single line:
   Declare Function RemoveMenu% Lib "user" (ByVal hMenu%, ByVal nPosition%, ByVal wFlags%)
   Declare Function GetSystemMenu% Lib "user" (ByVal hWnd%, ByVal revert%)
   Declare Function GetWindowLong Lib "user" (ByVal hWnd As Integer, ByVal nindex As Integer) As Long
   Declare Function SetWindowLong Lib "user" (ByVal hWnd As Integer, ByVal nindex As Integer, ByVal dwNewLong As Long) As Long

Declare Function Escape% Lib "GDI" (ByVal hDC As Integer, ByVal nEscape As Integer, ByVal nCount As Integer, LpInData As Any, LpOutData As Any)

' Required declarations for the Pro488 IEEE board
Declare Function Pro488Present Lib "pro488.dll" () As Integer
Declare Function Pro488ReadData Lib "pro488.dll" (ByVal Buffer$, ByVal NumOfBytes%) As Integer
Declare Function Pro488WriteData Lib "pro488.dll" (ByVal Buffer$, ByVal NumOfBytes%) As Integer
Declare Function Pro488ReadCtrl Lib "pro488.dll" (ByVal Buffer$) As Integer
Declare Function Pro488WriteCtrl Lib "pro488.dll" (ByVal Buffer$, ByVal NumOfBytes%) As Integer

' Subroutines to read/write I/O ports
' from vb-io.dll, (c) Andy Cross, Dec '95 - Nov '96
'not needed for eclipse
Declare Sub Inword Lib "vb-io.dll" (ByVal ioport As Integer, datawd As Integer)
Declare Sub Inbyte Lib "vb-io.dll" (ByVal ioport As Integer, databt As Integer)
Declare Sub Outbyte Lib "vb-io.dll" (ByVal ioport As Integer, ByVal databt As Integer)
 Rem Declare Sub InBlock Lib "vb-io.dll" (ByVal ioport As Integer, ByVal reclen As Integer, arrayref As Integer)
Declare Sub average Lib "vb-io.dll" Alias "Average" (ByVal ioport As Integer, ByVal record_length As Integer, arrayref As Long, ByVal averages As Integer)

' Win API function declarations
Declare Function Getprivateprofilestring Lib "Kernel" (ByVal lpApplicationName As String, lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFilename As String) As Integer
Declare Function GetPrivateProfileInt Lib "Kernel" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal nDefault As Integer, ByVal lpFilename As String) As Integer
Declare Function WritePrivateProfileString Lib "Kernel" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lplFileName As String) As Integer

'DAC fns
'Inp/Out port read/write declarations
Declare Function Inp Lib "inpout16.Dll" Alias "Inp16" (ByVal PortAddress As Integer) As Integer
Declare Sub Out Lib "inpout16.Dll" Alias "Out16" (ByVal PortAddress As Integer, ByVal Value As Integer)


'Global constants

Global Const gNUMBERS = "0123456789.-+"
Global Const OPENFILE = 0
Global Const SUPERIMPOSE = 1
Global Const TAKEDATA = 2

' define IEEE devices.
Global Const dmm1 = 0
Global Const dmm2 = 1
Global Const lck = 2
Global Const sw = 3
Global Const psu = 4
Global Const dvs = 5
Global Const scop = 6
Global Const lckn = 7
Global Const attn = 8

' constants referring to i/o processes in load/save form
Global Const BROWSE = -1
Global Const xyload = 0
Global Const xysave = 1
Global Const imgload = 2
Global Const imgsave = 3
Global Const xybitmap = 5

' global variables for digitiser
Global gDIG_THRESHOLD As Single
Global gDIG_SAMPLEPER As Integer
Global gDIG_FULLSCALE As Single
Global gDIG_AMPOFFSET As Single
Global gDIG_SWEEPS As Long
Global gDIG_RECORDLEN As Long
Global gDIG_INPIMP50 As Integer
Global gDIG_TRIGFALL As Integer
Global sclength As Integer
Global delaytime As Integer

' Image display

Global gCOL_MAXRED As Integer
Global gCOL_MAXGREEN As Integer
Global gCOL_MAXBLUE As Integer
Global gCOL_MINRED As Integer
Global gCOL_MINGREEN As Integer
Global gCOL_MINBLUE As Integer
Global gCOL_MEDRED As Integer
Global gCOL_MEDGREEN As Integer
Global gCOL_MEDBLUE As Integer
Global gNUM_BASECOLS As Integer
Global gCOLOURS As Long
Global colour(0 To 255) As Long

' Directories and Extensions
Global gDATdir As String
Global gEPloc As String
Global gDATEDIRS As Integer
Global gAUTOSAVE As Integer
Global gUSERNAME As String

Global xdev As Integer
Global ydev As Integer
Global gDATA_TYPE As Integer
Global curx As Integer
Global cury As Integer
Global startx As Integer
Global starty As Integer
Global datasaved As Integer
Global gQUIT As Integer
Global gSTOP As Integer
Global gNumPts(80) As Integer
Global Path As String
Global file As String
Global gDMM_TYPE(2) As Integer
Global dev%
Global dmm%
Global gpointnum As Integer
Global mode As Integer
Global continue_ok As Integer
Global cmd_done As Integer
Global ieeeaddr() As Integer
Global IEEEname() As String
Global NL As String * 2
Global CurUser As String
Global datasavefile As String
Global imagesavefile As String
Global savedirectory As String
Global imagetmpfile As String
Global datatmpfile As String
Global stepsize As Single
Global ax$
Global target As Single
Global im() As Single
Global bitmapbuffer() As Integer
Global maxx%, maxy%, linescanrowcol%
Global high As Single
Global wide As Single
Global nomirrors As Integer
Global mask(0 To 9) As Integer
Global recentfile$(9)
Global img As IMAGE_HEADER
Global gotzerobias As Integer
Global whichgate As Integer

Global int_PulseTime As Integer
Global int_ModeSpeed As Integer
Global int_WaferThickness As Integer
Global int_GateWidth As Integer
Global int_xoffset As Single
Global int_yoffset As Single
Global disratio As Single
Global newtime As Single
Global mode_param As Single
Global int_fscfactor As Single
' Digitiser arrays
Global dataray(-12 To 16385) As Long
Global dataray1(-12 To 16385) As Integer
Global hidata(0 To 2, 16385) As Long
Global reclen%
Global rec_on_screen%
Global max_on_screen%
Global digitiser ' board ID (9846 or 9825)
Global BaseAddr%, MBAddr%
Global multiplier As Integer
Global screen_to_mV_ratio As Long
Global timewindow(3) As Integer
Global sweeps As Integer
Global software_sweeps As Long
Global bias_direction As Integer
Global hardware_sweeps As Long
Global recspeed As Single
Global satval% ' indicates whether data saturation occurs
Global size_of_scale As Long
Global ignore As Integer

Sub AcquireOne()
Dim trace As Integer, offset As Long, delaytime As Long
Dim spd As Single
offset = CLng(808.875 * software_sweeps * gDIG_AMPOFFSET * 0.01)
sclength = 2 ^ gDIG_RECORDLEN
time_taken = 0: totalsweeps = 0

For trace = 0 To 1
tracetype = frmTrace!cmbTraceType(trace).ListIndex

If (tracetype > 0 And tracetype < 5) Or (tracetype = 5 And (trace = 1 And gotzerobias = 0)) Then

 starttime = Timer
 
 ' Obtain trace
 For j% = 0 To sclength
  hidata(trace, j%) = 0
  dataray(j%) = 0
 Next

 Select Case tracetype
 
 Case 1, 2
   Bias (tracetype Mod 2)
 Case 3, 4
   volts = Abs(Val(frmdvs!Text4.Text))
   sign = -1: If (tracetype Mod 2) = 1 Then sign = 1
   SendIEEECmd (Str$(ieeeaddr(dvs)))
   SendIEEEdata ("V" + Format$(sign * volts, "#0.0##E+0#") + "I2X")
   'SendIEEEdata ("V" + Format$(-sign * volts, "#0.0##E+0#") + "I2X")
 Case 5
   SendIEEECmd (Str$(ieeeaddr(bxcr)))
   SendIEEEdata ("S8=0.000")
   gotzerobias = 1
End Select

' Software averaged traces (in C)
satval% = 0
'MsgBox (software_sweeps)
Call average(&H300, rec_on_screen% + 13, dataray(-12), software_sweeps)
'MsgBox ("finish")
retval% = 0
If retval% = 0 Then
For i% = 0 To rec_on_screen%
dataray(i%) = dataray(i%) * 0.01
Next
 For i% = 0 To rec_on_screen%
 hidata(trace, i%) = (dataray(i%) - offset)
 Next

 finishtime = Timer - starttime
 time_taken = time_taken + finishtime: totalsweeps = totalsweeps + (hardware_sweeps * software_sweeps)
' frmSCAN!panelInfo = "Trace " + Format$(trace + 1, "0") + " completed in " + Format$(finishtime, "#0.0") + " seconds (" + Format$((2 ^ gDIG_SWEEPS) / finishtime, "######0.0") + " sweeps/sec)"
End If

End If

If retval% <> 0 Then Exit For
Next trace

If retval% = 0 Then

TraceManipulation
spd = totalsweeps / time_taken
frmSCAN!panelInfo = "Totals: " + Str$(totalsweeps) + " sweeps in " + Format$(time_taken, "#####0.0") + " seconds = " + Format$(spd, "#######0.0") + " sweeps/sec."
If spd > recspeed Then
recspeed = spd
frmSCAN!RecordSpeed = Format$(recspeed, "######0.0") + " sweeps per second."
bool = WritePrivateProfileString("Digitiser", "Record speed", Str$(recspeed), "c:\scan\scan.ini")
End If
Else
' Fault, or user abort
frmTrace!cmdAcquire.Caption = "ACQUIRE"
frmSCAN!panelInfo.ForeColor = 0
frmSCAN!panelInfo = "Trace acquisition aborted."
pause 100
End If

'gQUIT = 1
End Sub

Function ArrayToOffset(array_argument As Integer, dimension As Single) As Single
' dimension set to either 'high' or 'wide'
' depending whether we're using X or Y axis
ArrayToOffset = (array_argument * stepsize) - (dimension / 2)
End Function

Sub Bias(direction As Integer)
' rem Direction=0 for reverse, 1 for forward bias
If direction <> bias_direction Then
SendIEEECmd (Str$(ieeeaddr(sw)))
SendIEEEdata ("AID210;C" + Format$(direction, "0"))
pause 500
bias_direction = direction
End If
End Sub

Sub CentreForm(Formname As Form)
Formname.Left = (Screen.Width - Formname.Width) / 2
X = Screen.Height + frmSCAN!panelTools.Height
Formname.Top = ((Screen.Height + frmSCAN!panelTools.Height + 40) - Formname.Height) / 2
End Sub

Function CheckPresent(ByVal basedir$)
'If Not Exists(basedir$) Then MkDir basedir$
If gDATEDIRS = True Then basedir$ = basedir$ + "\" + Format$(Now, "ddmmyy")
If Not Exists(basedir$ + "\*.*") Then
MkDir basedir$
ChDir basedir$
Open "dir.id" For Output As #7
'Print #7, "SCAN Data files, " + Now
Print #7, "Don't delete this file, it's important!"
Close #7
End If

CheckPresent = basedir$
End Function

Sub cmd(comm%)
' Send a command to the digitiser command port (E)
Call Outbyte(BaseAddr% + 14, comm%)
Call Inbyte(MBAddr%, X%)
X% = X% Or 32
Call Outbyte(MBAddr%, X%)
End Sub

Sub configureLCD(LCDdisplay As PictureBox, digits As Integer)

LCDdisplay.Scale (0, 20)-(10 * digits, -4)
LCDdisplay.FillStyle = 0
LCDdisplay.ForeColor = &H505050
LCDdisplay.DrawWidth = 2
LCDdisplay.AutoRedraw = True
LCDdisplay.Tag = "-1"
For i% = 0 To digits - 1
drawLCD 0, i%, LCDdisplay, 0
LCDdisplay.PSet (10 + (10 * i%), 0)
Next
LCDdisplay.AutoRedraw = False
End Sub

Sub CurrentDigitiserSettings()
For i% = 0 To 15
Call Inbyte(BaseAddr% + i%, X%)
Outa$ = Hex$(i%) + " : "
For j% = 7 To 0 Step -1
Outa$ = Outa$ + Format$(-((X% And (2 ^ j%)) > 0), "0")
Next
MsgBox Outa$ + " = &H" + Hex$(X%) + " = " + Str$(X%)
Next
End Sub

Sub displayLCD(Inp$, LCDdisplay As PictureBox, colr As Double)
offset = 0

For i% = 0 To (LCDdisplay.ScaleWidth / 10)
DoEvents
If i% > Len(Inp$) Then Exit For
X$ = Mid$(Inp$, i% + 1, 1)

Select Case X$
 Case "0" To "9"
 drawLCD mask(Val(X$)), i% - offset, LCDdisplay, colr
 
 Case "-"
 drawLCD 8, i% - offset, LCDdisplay, colr

 Case " "
' drawLCD 0, i% - offset, LCDdisplay, colr

 Case ":"
 LCDdisplay.ForeColor = colr
 LCDdisplay.Line (8 + (10 * i%), 13)-(8 + (10 * i%), 11)
 LCDdisplay.Line (8 + (10 * i%), 5)-(8 + (10 * i%), 3)
 
 Case "."
 If i% = 0 Then nm = 0 Else nm = i% - 1: offset = 1
 olddot = Val(LCDdisplay.Tag)
 If nm <> olddot Then
 LCDdisplay.ForeColor = colr
 LCDdisplay.PSet (10 + (10 * nm), 0)
 If olddot <> -1 Then
 LCDdisplay.ForeColor = &H505050
 LCDdisplay.PSet (10 + (10 * nm), 0)
 End If
 LCDdisplay.Tag = Str$(nm)
 End If
 
 
 Case Else

End Select
Next

End Sub

Sub drawLCD(msk As Integer, dig As Integer, LCDdisplay As PictureBox, colr As Double)
Dim masq As Integer
For j% = 0 To 1

If j% = 0 Then
LCDdisplay.ForeColor = colr: masq = msk
Else
LCDdisplay.ForeColor = &H505050: masq = msk Xor 127
End If

If (masq And 1) = 1 Then LCDdisplay.Line (2 + (10 * dig), 15)-(2 + (10 * dig), 9)
If (masq And 2) = 2 Then LCDdisplay.Line (2 + (10 * dig), 7)-(2 + (10 * dig), 1)
If (masq And 4) = 4 Then LCDdisplay.Line (3 + (10 * dig), 16)-(7 + (10 * dig), 16)
If (masq And 8) = 8 Then LCDdisplay.Line (3 + (10 * dig), 8)-(7 + (10 * dig), 8)
If (masq And 16) = 16 Then LCDdisplay.Line (3 + (10 * dig), 0)-(7 + (10 * dig), 0)
If (masq And 32) = 32 Then LCDdisplay.Line (8 + (10 * dig), 15)-(8 + (10 * dig), 9)
If (masq And 64) = 64 Then LCDdisplay.Line (8 + (10 * dig), 7)-(8 + (10 * dig), 1)

Next j%
End Sub

Function Exists(pathname As String) As Integer
On Local Error Resume Next
Exists = (Dir(pathname) <> "")
End Function

Sub FrontPanel()
SendIEEECmd ("1")
SendIEEECmd ("EOS=3")
SendIEEECmd ("END=3")
SendIEEECmd ("UNL")
SendIEEECmd ("LISTEN" + Str$(ieeeaddr(scop)))
SendIEEEdata (Chr$(27) + "0MT00")
SendIEEECmd ("UNL")
SendIEEECmd ("TALK" + Str$(ieeeaddr(scop)))
For i% = 1 To 13
inbuf$ = recvIEEEdata(255)
MsgBox (inbuf$)
Next
SendIEEECmd ("UNT")
SendIEEECmd ("LOCAL" + Str$(ieeeaddr(scop)))
End Sub

   Function Get_Device_Information(hDC As Integer)
      A7% = GetDeviceCaps(hDC%, HORZSIZE)
      A8% = GetDeviceCaps(hDC%, VERTSIZE)
      A9% = GetDeviceCaps(hDC%, HORZRES)
      frmSCAN!labScreenHeight = Str$(A8% * (A9% / A7%))
      frmSCAN!labScreenWidth = Str$(A9%)
      
      a11% = GetDeviceCaps(hDC%, BITSPIXEL)
      frmSCAN!labScreenColours = Str$(2 ^ a11%)
      gCOLOURS = 2 ^ a11%
   End Function

Function GetCol(intensity!)
' define the multipliers to base colours
' to form the image colour for given intensity

If gNUM_BASECOLS = 3 Then
' 3 base colour case
max! = (intensity! > 33.3) * (33.3 - intensity!) * 2
min! = (intensity! < 66.6) * (intensity! - 66.6) * 2
med! = (50 - Abs(intensity! - 50)) * 2.2

Else
' if only using 2 base colours
max! = intensity!: min! = 100 - intensity!: med! = 0
End If

total = max! + min! + med!

r = Int((gCOL_MAXRED * max! + gCOL_MINRED * min! + gCOL_MEDRED * med!) / total)
G = Int((gCOL_MAXGREEN * max! + gCOL_MINGREEN * min! + gCOL_MEDGREEN * med!) / total)
B = Int((gCOL_MAXBLUE * max! + gCOL_MINBLUE * min! + gCOL_MEDBLUE * med!) / total)

' adjust R/G/B so that, hopefully, we aren't inventing
' colours that aren't capable of being produced by the screen.


GetCol = RGB(r, G, B)
End Function

Function GetFileName(newpic, basedir$, ext$)
savedir = CheckPresent(ByVal basedir$)
ChDir savedir
If newpic = True Then
' this is a new image
filenumber = 0: Do
filenumber = filenumber + 1
Loop Until Not Exists(Format$(filenumber, "###0") + ext$)

fileletter = ""
GetFileName = Format$(filenumber, "###0") + ext$
Else
' not a new image, just a different shot of the
' existing one
If fileletter = "" Then fileletter = "a" Else fileletter = Chr$(Asc(fileletter) + 1)
GetFileName = Format$(filenumber, "###0") + fileletter + ext$
End If
End Function

Function GetINIInt(header$, subheader$)
GetINIInt = GetPrivateProfileInt(header$, subheader$, 0, "c:\scan\scan.ini")
End Function

Function GetINIString(header$, subheader$)
buf$ = String(255, 0)
ret% = Getprivateprofilestring(header$, ByVal subheader$, "", buf$, 255, CurDir + "\SCAN.ini")
GetINIString = Left$(buf$, ret%)
End Function

Sub gettrace(trace As Integer)
Dim c As Long, offset As Long
offset = Int((655.36 * gDIG_AMPOFFSET) + 0.5)

Select Case digitiser

Case 9846
' Send cmd "Acquire single sweep and send to host"
 wait MBAddr%, 32, 32
 cmd (&H39)

' Wait a little while..
pause 1

' Wait for port B, bit 0 to fall low, this
' indicates that a record is ready to be read
 wait BaseAddr% + 11, 1, 1

Case 9825
' Send cmd "Start acquisition"
wait MBAddr%, 32, 32
cmd (&H3C)

pause 1

' Waits until Port B, bit 2 goes high,
' then previous command is finished.
wait BaseAddr% + 11, 4, 0

wait MBAddr%, 32, 32
' Sends SETUPREAD command
cmd (&H37)

pause 1
wait BaseAddr% + 11, 1, 1
End Select

If gQUIT = 1 Then Exit Sub
 ' Reads data, starting in dataray(-12) ...
 ' first few reads will be neglected, valid data
 ' taken to start at dataray(0)
 
'Call InBlock(&H350, rec_on_screen% + 13, dataray1(-12))

 For i% = 0 To rec_on_screen%
 c = dataray1(i%): If c < 0 Then c = 65536 + c
 c = c - offset
 hidata(trace, i%) = hidata(trace, i%) + c
 Next i%

End Sub

Sub ImageLoad()
mode = OPENFILE
frmImageDisplay.Show 1
End Sub

Sub ImageSave()
 Close
 If imagetmpfile = "temp.img" Then imagetmpfile = "c:\tmp\temp.img"
 FileCopy imagetmpfile, imagesavefile
 datasaved = datasaved Or 2
End Sub

Sub LoadUserSettings(usrname)

' [Image]
section$ = usrname + ":image"
gCOL_MAXRED = GetINIInt(section$, "gCOL_MAXRED")
gCOL_MAXGREEN = GetINIInt(section$, "gCOL_MAXGREEN")
gCOL_MAXBLUE = GetINIInt(section$, "gCOL_MAXBLUE")
gCOL_MINRED = GetINIInt(section$, "gCOL_MINRED")
gCOL_MINGREEN = GetINIInt(section$, "gCOL_MINGREEN")
gCOL_MINBLUE = GetINIInt(section$, "gCOL_MINBLUE")
gCOL_MEDRED = GetINIInt(section$, "gCOL_MEDRED")
gCOL_MEDGREEN = GetINIInt(section$, "gCOL_MEDGREEN")
gCOL_MEDBLUE = GetINIInt(section$, "gCOL_MEDBLUE")
gNUM_BASECOLS = GetINIInt(section$, "gNUM_BASECOLS")
MakeColourArray

' [misc]
section$ = usrname + ":misc"
gDATdir = GetINIString(section$, "Data directory")
gEPloc = GetINIString(section$, "Easyplot pathname")
gAUTOSAVE = GetINIInt(section$, "Auto-save data")
gDATEDIRS = GetINIInt(section$, "Dated subdirectories")
gUSERNAME = GetINIString(section$, "PPN1 username")
End Sub

Sub MakeColourArray()
Dim max As Long, min As Long, med As Long
Dim total As Long, r As Long, B As Long, G As Long

For i% = 0 To 255

If gNUM_BASECOLS = 3 Then
' 3 base colour case
max = (i% > 85) * (85 - i%) * 2
min = (i% < 170) * (i% - 170) * 2
med = (128 - Abs(i% - 127)) * 2

Else
' if only using 2 base colours
max = i%: min = 255 - i%: med = 0
End If

total = max + min + med

r = (gCOL_MAXRED * max + gCOL_MINRED * min + gCOL_MEDRED * med) / total
G = (gCOL_MAXGREEN * max + gCOL_MINGREEN * min + gCOL_MEDGREEN * med) / total
B = (gCOL_MAXBLUE * max + gCOL_MINBLUE * min + gCOL_MEDBLUE * med) / total

colour(i%) = RGB(r, G, B)
Next
' write a 16x16 bitmap of the colour array to temp.file
PaletteBitmap
End Sub

Sub MirrorCommand(mirr$, mcom$)

cmd_done = 0
'Do


 ' attempt to write data to mirror
'frmSCAN!Comm1.Output = mirr$ + mcom$ + Chr$(13)
 
 ' record timer value prior to waiting for response
 ' from scan driver unit
 'stime = Timer
 
 'Do
 ' wait for scan driver unit to respond with prompt
 ' (or, and we hope not, time out)
 'X$ = Left$(frmSCAN!Comm1.Input, 1)
' rtime = Timer - stime

 'Loop Until (X$ = ">" Or rtime > 2)

'If X$ <> ">" Then
 ' Mirror has stalled; reset it
 'frmSCAN!panelInfo.Caption = "Mirrors stalled; attempting to put back online."
 'frmSCAN!Comm1.Output = mirr$ + "0" + Chr$(13)
'MsgBox (mirr$)
'Else
'convert to voltage

ydev = ieeeaddr(lckn)
If mirr$ = "BX" Then
sx$ = "auxv1," + mcom$
ElseIf mirr$ = "BY" Then
sx$ = "auxv2," + mcom$
End If
' send instructions to lockin to output mirror
' voltages NB 1V=1mm
'MsgBox (Str(ydev))
'Stop

SendIEEECmd Str(ydev)
SendIEEEdata sx$

 ' no problem with mirror, set flag to indicate
 ' task performed ok
 cmd_done = 1
' frmSCAN!panelInfo.Caption = "SCAN"
'End If

DoEvents

' try outputting the data again if we had to
' do a mirror reset
'Loop Until cmd_done = 1 Or gQUIT = 1
End Sub

Function OffsetToArray(mmoffset As Single, dimension As Single) As Integer
Dim tmp As Double
' where "dimension" = high or wide
tmp = 0.49999999999 + ((mmoffset + (dimension / 2)) / stepsize)
OffsetToArray = tmp

End Function

Sub PaletteBitmap()
 Dim hFile As Integer
 Dim hMem As Integer, lpmem As Long
 Dim r As Integer, nval As Long, pxnt As Integer
 Dim nextpxnt As Integer, pointer As Long
 Dim imagecol As Integer, datarow As Integer, datacol As Integer
 Dim xx As Integer, yy As Integer
 Dim lp As LOGPALETTE
 Dim i As Integer, filehandle As Integer, palentry As Integer
 Dim rgbval As String * 1, shadowDC As Integer, kill1 As Integer
 Dim hbmp_DIB As Integer, hbmp_DDB As Integer, hbmpold As Integer
 Dim hDC_DIB As Integer, hDC_DDB As Integer
 Dim bytesread As Long
 Dim byte1 As Long  'sc
 Dim maxint As Single, minint As Single

 ReDim bitmapbuffer(0 To 7, 0 To 15)
                        
    For datarow = 0 To 15
    For datacol = 0 To 15 Step 2
             
     pxnt = datarow * 16 + datacol
     nextpxnt = pxnt + 1
    
       nval = nextpxnt * &H100&
       If nval > &H7FFF Then
       nval = nval - &H10000
       End If
       imagecol = datacol \ 2
             
       bitmapbuffer(imagecol, datarow) = nval + pxnt
          
         Next datacol
       Next datarow

' Device Independent BITMAP definition
BMI.bmiheader.BISIZE = 40
BMI.bmiheader.biwidth = 16
BMI.bmiheader.biheight = 16
BMI.bmiheader.biplanes = 1
BMI.bmiheader.biBitCount = 8
BMI.bmiheader.bicompression = BI_RGB
BMI.bmiheader.bisizeimage = 0
BMI.bmiheader.bixpelspermeter = 0
BMI.bmiheader.biypelspermeter = 0
BMI.bmiheader.biclrused = 0
BMI.bmiheader.biclrimportant = 0

' Palette definition (256 colours)

lp.palversion = &H300
lp.palnumentries = 256

For palentry = 0 To 255
' extract the R,G,B components from colour array
' ie colour(palentry)=&Hrrggbb
B = (colour(palentry) And &HFF0000) / &H10000
G = (colour(palentry) And &HFF00&) / &H100
r = colour(palentry) And &HFF&

Mid$(BMI.bmicolors, (palentry * 4) + 1) = Chr$(B) + Chr$(G) + Chr$(r) + Chr$(0)
Next palentry

Dim apiwrite As Long
Dim dosfilehandle As Integer
Dim ptr As Long

' BITMAPFILEHEADER

Dim bm As Integer
Dim no_of_bytes As Long
Dim dummy1 As Integer
Dim dummy2 As Integer
Dim offset As Long

bm = 19778
no_of_bytes = 1078 + (16 * 16)
dummy1 = 0
dummy2 = 0
offset = 1078

Open "c:\tmp\palette.bmp" For Binary Access Read Write As #2

Seek #2, 1

' write WIN BITMAP HEADERINFO to file

Put #2, , bm
Put #2, , no_of_bytes
Put #2, , dummy1
Put #2, , dummy2
Put #2, , offset

' write WIN BITMAP BITMAPINFOHEADER to file

Put #2, , BMI.bmiheader.BISIZE
Put #2, , BMI.bmiheader.biwidth
Put #2, , BMI.bmiheader.biheight
Put #2, , BMI.bmiheader.biplanes
Put #2, , BMI.bmiheader.biBitCount
Put #2, , BMI.bmiheader.bicompression
Put #2, , BMI.bmiheader.bisizeimage
Put #2, , BMI.bmiheader.bixpelspermeter
Put #2, , BMI.bmiheader.biypelspermeter
Put #2, , BMI.bmiheader.biclrused
Put #2, , BMI.bmiheader.biclrimportant

' write WIN BITMAP BITMAPHEADER (palette) to file

Put #2, , BMI.bmicolors

Seek #2, 1079

' position file pointer at end of header data (1078 bytes long)

dosfilehandle% = FileAttr(2, 2)
apiwrite = hwrite(dosfilehandle%, bitmapbuffer(0, 0), (16 * 16))
Close #2
End Sub

Sub pause(delay)
Rem general routine to incorporate delays
frmSCAN!pause.Interval = delay
frmSCAN!pause.Enabled = True
Do
DoEvents
Loop Until frmSCAN!pause.Enabled = False
End Sub

Sub PlotGraph()
 ' Plot the grid data onto the graph
 NumSet% = 0
 For i% = 0 To 5: If frmDataGrid!chkplot(i%).Value = 1 Then NumSet% = NumSet% + 1
 Next: If NumSet% = 0 Then Exit Sub
 frmDataGrid!panelInfo.Caption = "Updating graph, please wait..."
 frmXYDisplay!gphXY.NumSets = NumSet%
 frmXYDisplay!gphXY.NumPoints = frmDataGrid!Grid1.Rows - 1
 ThisSet% = 0
 For curset% = 1 To frmDataGrid!Grid1.Cols / 2
 DoEvents
 If frmDataGrid!chkplot(curset% - 1).Value = 1 Then
  ThisSet% = ThisSet% + 1
  frmXYDisplay!gphXY.ThisSet = ThisSet%
 
  For i% = 1 To frmDataGrid!Grid1.Rows - 1
  frmXYDisplay!gphXY.ThisPoint = i%
  frmDataGrid!Grid1.Row = i%
  frmDataGrid!Grid1.Col = (curset% - 1) * 2
  frmXYDisplay!gphXY.XPosData = Val(frmDataGrid!Grid1.Text)
  frmDataGrid!Grid1.Col = (curset% - 1) * 2 + 1
  frmXYDisplay!gphXY.GraphData = Val(frmDataGrid!Grid1.Text)
  gNumPts(ThisSet%) = ThisPoint%
  Next i%
 
 End If
 Next curset%

 frmXYDisplay!gphXY.DrawMode = 2
 frmDataGrid!Picture1.Picture = frmXYDisplay!gphXY.Picture
 frmDataGrid!panelInfo.Caption = ""
End Sub

Sub Poll(device%)

serial_poll% = Spoll(device%)

End Sub

Sub PrintPicBox(pictureObj As PictureBox)
      Const SRCCOPY = &HCC0020
      Const NEWFRAME = 1
      Const PIXEL = 3

      '* Display hour glass.
      MousePointer = 11
      pictureObj.Picture = pictureObj.Image

      '* StretchBlt requires pixel coordinates.
      pictureObj.ScaleMode = PIXEL
      On Local Error Resume Next
      Printer.ScaleMode = PIXEL
      If Err > 0 Then MsgBox ("No printer installed!"): Exit Sub
      Printer.Print ""

      hMemoryDC% = CreateCompatibleDC(pictureObj.hDC)
      hOldBitMap% = SelectObject(hMemoryDC%, pictureObj.Picture)

      ApiError% = StretchBlt(Printer.hDC, 0, 0, Printer.ScaleWidth, Printer.ScaleHeight, hMemoryDC%, 0, 0, pictureObj.ScaleWidth, pictureObj.ScaleHeight, SRCCOPY)
      hOldBitMap% = SelectObject(hMemoryDC%, hOldBitMap%)
      ApiError% = DeleteDC(hMemoryDC%)

      Result% = Escape(Printer.hDC, NEWFRAME, 0, 0&, 0&)

      Printer.EndDoc
MousePointer = 1

End Sub

Sub PutLineScanDataOnGraph(direction)
Close #9
datatmpfile = "c:\tmp\temp.dat"
Open datatmpfile For Output As #9

If direction = 0 Then
' linescan along X (fixed Y)
For i% = 0 To img.scanwidth / stepsize
If im(i%, linescanrowcol%) <> -99 Then Print #9, (i% * stepsize) - (wide / 2), im(i%, linescanrowcol%)
Next
Else
' linescan along Y (fixed X)
For i% = 0 To img.scanheight / stepsize
If im(linescanrowcol%, i%) <> -99 Then Print #9, (i% * stepsize) - (high / 2), im(linescanrowcol%, i%)
Next
End If
Close #9

If direction = 1 Then ax$ = "X": offset = ArrayToOffset(linescanrowcol%, wide) Else ax$ = "Y": offset = ArrayToOffset(linescanrowcol%, high)

'mode = OPENFILE
datasavefile = datatmpfile
mode = BROWSE

xysetupload
frmXYDisplay.Caption = "XY Plot: Linescan across sample, " + ax$ + " offset=" + Format$(offset, "#0.0#") + "mm"
frmXYDisplay!gphXY.NumSets = 1
frmXYDisplay!gphXY.ThisSet = 1
End Sub

Function ReadFromIMGHeader(subheader$, imgfilename$) As String
buf$ = String(255, 0)
ret% = Getprivateprofilestring(ByVal "Header", ByVal subheader$, "", buf$, 255, imgfilename$)
ReadFromIMGHeader = Left$(buf$, ret%)
End Function

Function recvIEEEdata$(length)
inbuf$ = String(length, 0)
ret% = Pro488ReadData(inbuf$, length)
If ret% = -1 Then
recvIEEEdata$ = "error"
Else
recvIEEEdata$ = Left$(inbuf$, ret%)
End If
End Function

Function recvIEEERawData(length)

inbuf$ = String(length, "0")
ret% = Pro488ReadData(inbuf$, length)
If ret% = -1 Then
recvIEEERawData$ = "error"
Else
recvIEEERawData$ = inbuf$
End If

End Function

Sub SaveUserSettings(usrname)
Dim bool As Integer
section$ = usrname + ":image"
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MAXRED", ByVal Str$(gCOL_MAXRED), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MAXGREEN", ByVal Str$(gCOL_MAXGREEN), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MAXBLUE", ByVal Str$(gCOL_MAXBLUE), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MINRED", ByVal Str$(gCOL_MINRED), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MINGREEN", ByVal Str$(gCOL_MINGREEN), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MINBLUE", ByVal Str$(gCOL_MINBLUE), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MEDRED", ByVal Str$(gCOL_MEDRED), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MEDGREEN", ByVal Str$(gCOL_MEDGREEN), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gCOL_MEDBLUE", ByVal Str$(gCOL_MEDBLUE), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gNUM_BASECOLS", ByVal Str$(gNUM_BASECOLS), ByVal "c:\scan\scan.ini")


' [XY Plot]
section$ = usrname + ":XY Plot"
bool = WritePrivateProfileString(ByVal section$, ByVal "Background", ByVal Str$(frmXYDisplay!gphXY.Background), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Foreground", ByVal Str$(frmXYDisplay!gphXY.Foreground), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Data colour", ByVal Str$(frmXYDisplay!gphXY.ColorData), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Background", ByVal Str$(frmXYDisplay!gphXY.Background), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Background", ByVal Str$(frmXYDisplay!gphXY.Background), ByVal "c:\scan\scan.ini")
frmXYDisplay!gphXY.FontUse = 0
bool = WritePrivateProfileString(ByVal section$, ByVal "Title font", ByVal Str$(frmXYDisplay!gphXY.FontFamily), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Title font style", ByVal Str$(frmXYDisplay!gphXY.FontStyle), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Title font size", ByVal Str$(frmXYDisplay!gphXY.FontSize), ByVal "c:\scan\scan.ini")
frmXYDisplay!gphXY.FontUse = 2
bool = WritePrivateProfileString(ByVal section$, ByVal "Axis font", ByVal Str$(frmXYDisplay!gphXY.FontFamily), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Axis font style", ByVal Str$(frmXYDisplay!gphXY.FontStyle), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Axis font size", ByVal Str$(frmXYDisplay!gphXY.FontSize), ByVal "c:\scan\scan.ini")

gDATdir = frmUserConfig!txtDATdir(0)
gEPloc = frmGenConfig!labEPloc.Caption

section$ = usrname + ":misc"
bool = WritePrivateProfileString(ByVal section$, ByVal "Data directory", ByVal gDATdir, ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Easyplot pathname", ByVal gEPloc, ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Auto-save data", ByVal Str$(gAUTOSAVE), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Dated subdirectories", ByVal Str$(gDATEDIRS), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "PPN1 username", ByVal gUSERNAME, ByVal "c:\scan\scan.ini")
End Sub

Sub SendIEEECmd(dat$)
ret% = Pro488WriteCtrl(dat$ + Chr$(13), Len(dat$) + 1)
End Sub

Sub SendIEEEdata(dat$)
ret% = Pro488WriteData(dat$ + Chr$(13) + Chr$(10), Len(dat$) + 2)
End Sub

Sub SetAttenuator(level As Integer)
'SendIEEECmd (Str$(ieeeaddr(bxcr)))
'pause 10 ' just to make sure the boxcar is
'          ready for instruction
'SendIEEEdata ("SD=" + Format$(level, "#0"))

'new code because switch unit runs off DAC
'Out PIOaddr, (255 - level)

' new code (SC) as atten runs off Ians new GPIB device

' convert no to Hex using Hex fn
'MsgBox (Chr$(level))

SendIEEECmd "16"
SendIEEEdata "G" + (Chr$(0)) + (Chr$(level))
frmTrace!mnuAttenuate.Caption = "&Attenuator (" + Format$(level, "#0") + " dB)"
End Sub

Sub SetGate(voltage)
SendIEEECmd (Str(ieeeaddr(dvs)))
SendIEEEdata ("V" + Format(voltage, "0.0##E+0#") + "I2X")
frmdvs!Text4.Text = Str(voltage)
End Sub

Sub SetupDigitiser()
frmSCAN!panelInfo.ForeColor = &HFF
frmSCAN!panelInfo = "Transferring digitiser setup information to board.."
' Write out values of digitiser setup variables
' to the board.

'cmd (&H34) ' stop any existing average

' Port 2: stores info for trigger slope (D1),
' 50ohm input y/n (D5), and for 9846 only,
' port memory addr (D2->D4).
port2% = 0

If gDIG_INPIMP50 = True Then port2% = port2% + 32
If gDIG_TRIGFALL = True Then port2% = port2% + 2
wait MBAddr%, 32, 32
Call Inbyte(BaseAddr% + 2, X%)
X% = port2% Or (X% And 221)
Call Outbyte(BaseAddr% + 2, X%)
cmd (&H20)

' Port 4: Trigger threshold level
' For 9846: &FF=+10V, &00=-10V
' For 9825: far less easy conversion equation :-(
wait MBAddr%, 32, 32
If digitiser = 9846 Then
port4% = (gDIG_THRESHOLD + 10) * (255 / 20)
Else
 If gDIG_THRESHOLD >= 0 Then
 port4% = 30 - (gDIG_THRESHOLD * 20)
 Else
port4% = 94 - (gDIG_THRESHOLD * 20)
 End If
End If

Call Inbyte(BaseAddr% + 4, X%)
X% = port4% Or (X% And 128)
Call Outbyte(BaseAddr% + 4, X%) 'sc
cmd (&H40)
Call Inbyte(BaseAddr% + 4, X%)

' Port 5: Sampling period
' see p14 of 9846 guide for conversion table
' or p4 of 9825 register guide
wait MBAddr%, 32, 32
If digitiser = 9846 Then
Port5% = 4 + ((Log(gDIG_SAMPLEPER) - Log(10)) / Log(2))
If gDIG_SAMPLEPER = 2 Then Port5% = 2
If gDIG_SAMPLEPER = 4 Then Port5% = 3
Else
' Conversion is so bizarre that we can't formulate
' an equation. Typical!
Select Case gDIG_SAMPLEPER
Case 5
Port5% = 36
Case 10
Port5% = 100
Case 20
Port5% = 52
Case 40
Port5% = 5
Case 80
Port5% = 69
Case 160
Port5% = 21
End Select
End If
Call Outbyte(BaseAddr% + 5, Port5%)
cmd (&H50)

' Port A: Record Length
' Record length=2^(gDIG_RECORDLEN)
' Same algorithm for 9846 and 9825!!
' However, for some reason, can't have 2^11=131072
' record length for 9825..
wait MBAddr%, 32, 32
port10% = Int(gDIG_RECORDLEN)
'MsgBox ("A:" + Str$(port10%))
Call Outbyte(BaseAddr% + 10, port10%)
cmd (&HA0)

' Port 7: Input Signal Full Scale Sensitivity
' dB above 10mV, in 2dB steps
' Different system for 9846 and 9825
wait MBAddr%, 32, 32
If digitiser = 9846 Then
port7% = 6 * (Log(gDIG_FULLSCALE) - Log(10)) / Log(2)
gDIG_FULLSCALE = 20 * 2 ^ ((port7% / 6) - 1)
If (port7% Mod 2) = 1 Then port7% = port7% + 1
' gDIG_FULLSCALE = Int(10 ^ (1 + (port7% / 20)))

Else
Select Case gDIG_FULLSCALE
Case 400
port7% = 63
Case 300
port7% = 66
Case 200
port7% = 74
Case 150
port7% = 86
Case 100
port7% = 104
Case 60
port7% = 145
Case 40
port7% = 189
End Select
End If
'MsgBox ("7:" + Str$(port7%))
Call Outbyte(BaseAddr% + 7, port7%)
cmd (&H70)

' Port C: Input Offset %
' 9846: -20% -> &H6C (108), 120% -> &HF8 (248)
' 9825: -50% -> &H4A (74), 120% -> &HF4 (244)
wait MBAddr%, 32, 32
If digitiser = 9846 Then
port12% = (gDIG_AMPOFFSET + 20) + 108
Else
port12% = (gDIG_AMPOFFSET + 50) + 74
End If
'MsgBox ("C:" + Str$(port12%))
Call Outbyte(BaseAddr% + 12, port12%)
cmd (&HC0)

' Port 9: Number of sweeps
' 9825 only (on 9846, all averaging by software)
'If digitiser = 9846 Then
    'wait MBAddr%, 32, 32
    'software_sweeps = 2 ^ (gDIG_SWEEPS - 14): If software_sweeps < 1 Then software_sweeps = 1
    'hardware_sweeps = 2 ^ gDIG_SWEEPS: If hardware_sweeps > 16384 Then hardware_sweeps = 16384
    'port9% = 128 + gDIG_SWEEPS
    'If port9% > 142 Then port9% = 142
    'MsgBox ("9:" + Str$(port9%))
    'Call Outbyte(BaseAddr% + 9, port9%)
    'cmd (&H90)
If digitiser = 9825 Then
    wait MBAddr%, 32, 32
    software_sweeps = 2 ^ (gDIG_SWEEPS - 8): If software_sweeps < 1 Then software_sweeps = 1
    hardware_sweeps = 2 ^ gDIG_SWEEPS: If hardware_sweeps > 256 Then hardware_sweeps = 256
    port9% = 128 + gDIG_SWEEPS
    If port9% > 136 Then port9% = 136
    'MsgBox (port9%)
    Call Outbyte(BaseAddr% + 9, port9%)
    cmd (&H90)
    
End If

frmSCAN!panelInfo.ForeColor = 0
frmSCAN!panelInfo = "SCAN"
End Sub

Sub showtrace(pic As PictureBox, trace As Integer, colour As Long)
Dim tmp As Double
Dim tmp1 As Long
'MsgBox (trace)
Select Case frmTrace.ACcoupling.Value

Case False
pic.Line (0, hidata(trace, 0))-(1, hidata(trace, 1)), colour
'MsgBox (trace)
For i% = 2 To rec_on_screen%
pic.Line -(i%, hidata(trace, i%)), colour
Next

Case True

tmp = 0
For i% = 0 To rec_on_screen%
tmp = tmp + hidata(trace, i%)
Next
tmp1 = CLng(tmp / (rec_on_screen%))

pic.Line (0, (hidata(trace, 0) - tmp1))-(1, (hidata(trace, 1) - tmp1)), colour

For i% = 2 To rec_on_screen%
pic.Line -(i%, (hidata(trace, i%) - tmp1)), colour
Next

End Select

End Sub

Function Spoll(device%)
SendIEEECmd (frmDevice!txtAddr(device%).Text)
'MsgBox (frmDevice!txtAddr(device%).Text)
DoEvents
SendIEEECmd ("SPOLL")
DoEvents
recv$ = String(255, 0)
ret% = Pro488ReadCtrl(recv$)
DoEvents
serial% = Val(Mid$(recv$, 28, 3))

Spoll = -(serial% <> 13)
End Function

Function TimeIntegral(window As Integer) As Double
Dim total As Single, count As Integer
trace_for_level = 2
If timewindow(window * 2 + 1) < timewindow(window * 2) Then stp = -1 Else stp = 1
count = 0
'MsgBox (timewindow(0))
For i% = timewindow(window * 2) To timewindow(window * 2 + 1) Step stp
' change made sc
count = count + 1
'total = total + (gDIG_FULLSCALE / (software_sweeps * 4)) * (hidata(trace_for_level, i%))
total = total + hidata(trace_for_level, i%) / screen_to_mV_ratio
Next
TimeIntegral = total / CSng(count)
End Function

Sub TraceManipulation()

' perform any trace manipulation requested on trace 3
tracetype = frmTrace!cmbTraceType(2).ListIndex

Select Case tracetype
Case 0, 1
' copy trace
For j% = 0 To rec_on_screen%
hidata(2, j%) = hidata(tracetype, j%)
Next

Case 2, 3
' trace subtraction
'
' (which trace are we subtracting from which?)
trace = tracetype - 2
For j% = 0 To rec_on_screen%
hidata(2, j%) = hidata(trace, j%) - hidata(trace Xor 1, j%)
Next

Case 4
' trace addition
For j% = 0 To rec_on_screen%
hidata(2, j%) = hidata(0, j%) + hidata(1, j%)
Next

Case 5, 6
' differentiate 1,2
trace = tracetype - 5
hidata(2, 0) = 0
For j% = 1 To rec_on_screen% - 1
hidata(2, j%) = (hidata(trace, j%) - hidata(trace, j% - 1))
Next

Case 7, 8
' integrate 1,2
trace = tracetype - 7
hidata(2, 0) = hidata(trace, 0)
For j% = 1 To rec_on_screen%
hidata(2, j%) = hidata(2, j% - 1) + hidata(trace, j%) / rec_on_screen%
Next

Case 9
' subtract from saved zero-bias data

For j% = 0 To rec_on_screen%
hidata(2, j%) = hidata(0, j%) - hidata(1, j%)
Next
End Select
End Sub

Sub UpdateSetupWindow()
If gDIG_INPIMP50 = True Then frmTrace!txtImpedance = "50" Else frmTrace!txtImpedance = "1k"

trig$ = Str$(gDIG_THRESHOLD) + "V"
If gDIG_TRIGFALL = True Then frmTrace!txtTrigger = trig$ + ", falling edge." Else frmTrace!txtTrigger = trig$ + ", rising edge."

frmTrace!txtSamplePeriod = Str$(gDIG_SAMPLEPER) + " ns"
frmTrace!txtRecLen = Str$(2 ^ gDIG_RECORDLEN)
reclen% = 2 ^ gDIG_RECORDLEN
frmTrace!txtAverages = Str$(2 ^ gDIG_SWEEPS)
frmTrace!txtFullScale = Str$(gDIG_FULLSCALE) + " mV"
frmTrace!txtOffset = Str$(gDIG_AMPOFFSET) + " %"
rec_on_screen% = Val(frmTrace!cmbTimeBase.Text) * 10 / Val(frmTrace!txtSamplePeriod)
max_on_screen% = Val(frmTrace!cmbVolts.Text) * 8

End Sub

Sub wait(portaddr%, AND_value%, XOR_value%)
' Wait for a particular port to go high or low
Do
Call Inbyte(portaddr%, dat%)
dat% = (dat% Xor XOR_value%) And AND_value%
DoEvents
Loop Until dat% <> 0 Or gQUIT = 1
End Sub

Sub XYBitmapSave()
 frmXYDisplay!gphXY.DrawMode = 3
 frmXYDisplay!gphXY.ImageFile = file
 frmXYDisplay!gphXY.DrawMode = 6
End Sub

Sub xysetupload()
 gSTOP = 1
 If mode = SUPERIMPOSE Then
  frmDataGrid!Grid1.Cols = frmDataGrid!Grid1.Cols + 2
 Else
  frmDataGrid!Grid1.Cols = 2
  frmDataGrid!Grid1.Rows = 2
 End If
 
frmDataGrid!Grid1.Row = 0
frmSCAN!panelInfo.ForeColor = &HFF: frmSCAN!panelInfo = "Reading in XY Plot data from file and tabulating; please wait."
Open datasavefile For Input As #4
Do While Not EOF(4)
 
' read data from file
Input #4, dataread$
 
If Val(dataread$) = 0 Then
 ' check for EP format commands
  If Left$(dataread$, 3) = "/td" And InStr(frmFileIO.Caption, "Superimpose") = 0 Then
   ThisSet% = ThisSet% + 1: frmDataGrid!Grid1.Row = 0
   frmDataGrid!Grid1.Cols = ThisSet% * 2
   End If
 
 Else
  ' XY Plot Data - eg "0.002  3.14" - need to separate
  i% = 0: Do: i% = i% + 1
  Loop Until Asc(Mid$(dataread$, i%, 1)) = 32
  xposn = Val(Left$(dataread$, i% - 1))
  yposn = Val(Right$(dataread$, Len(dataread$) - i%))

 ThisSet% = frmDataGrid!Grid1.Cols / 2

 ' Write the data to grid
 If frmDataGrid!Grid1.Row + 1 = frmDataGrid!Grid1.Rows Then frmDataGrid!Grid1.Rows = frmDataGrid!Grid1.Rows + 1
 frmDataGrid!Grid1.Row = frmDataGrid!Grid1.Row + 1
 frmDataGrid!Grid1.Col = (ThisSet% - 1) * 2
 frmDataGrid!Grid1.Text = Str$(xposn)
 frmDataGrid!Grid1.Col = (ThisSet% - 1) * 2 + 1
 frmDataGrid!Grid1.Text = Str$(yposn)
 gNumPts(ThisSet%) = frmDataGrid!Grid1.Rows - 1
 End If
 Loop
 Close #4
 
 If (frmXYDisplay!gphXY.NumSets) * (frmDataGrid!Grid1.Rows) < 3800 Then
 frmDataGrid!chkplot(ThisSet% - 1).Value = 1
 PlotGraph
 frmSCAN!panelInfo.ForeColor = 0: frmSCAN!panelInfo = "SCAN"
 If mode = OPENFILE Then frmXYDisplay.Show 1
 End If
End Sub

Sub XYsetupsave()
 Open datasavefile For Output As #4
 Print #4, "rem: XY Plot Data " + Date$
 
 For h% = 1 To frmXYDisplay!gphXY.NumSets
 Print #4, "/sa m " + Str$(h%) + " 2"
 Print #4, "/td " + Chr$(34) + "xy" + Chr$(34)
 
 If gNumPts(h%) < 2 Then pnts = frmXYDisplay!gphXY.NumPoints Else pnts = gNumPts(h%)
 For i% = 1 To pnts
 frmXYDisplay!gphXY.ThisSet = h%
 frmXYDisplay!gphXY.ThisPoint = i%
 Print #4, frmXYDisplay!gphXY.XPosData, frmXYDisplay!gphXY.GraphData
 Next i%
 Print #4, "//nc"
 Next h%
 Close #4
 datasaved = datasaved Or 1
End Sub


Public Sub dvsset()
SendIEEECmd (Str(ieeeaddr(dvs)))
SendIEEEdata ("F1R0GX")
End Sub
