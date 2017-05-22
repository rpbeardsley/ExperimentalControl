Attribute VB_Name = "Globals"
Public Const PI = 3.14159265358979

Public LOCKIN_ADDR As Integer
Public LOCKIN2_ADDR As Integer
Public TEMP_CONTROL_LOCKIN As Integer
Public TEMP_CONTROL_LOCKIN_MODEL As Integer
Public TEMP_CONTROL_TYPE As Integer
Public BIASSWITCH_PRIMARY_ADDR As Integer
Public BIASSWITCH_SECONDARY_ADDR As Integer
Public DIGITISER_MODEL As Integer
Public DIGITISER_ADDR As String
Public FIXED_RESISTANCE_IN_CERNOX_CIRCUIT
Public MIRROR_LOCKIN_ADDR As Integer
Public DVM1_ADDR As Integer
Public DVM2_ADDR As Integer
Public DVS_ADDR As Integer
Public NANOSTEPPER_TYPE As Integer
Public THORLABS_STEPPER_CONTROLLER_SERIALNUM As Long
Public BOXCAR_ADDR As Integer
Public MIRROR_DISTANCE_TO_VOLTAGE_RATIO As Single
Public ECLIPSE_PROG_PATH As String
Public IEEECARD As Integer
Public Newport_Stepper_Port As Integer
Public ave() As Double

Public SR510_GPIB_OR_RS232 As String
Public PSU_ADDR As Integer
Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pSavefilename As OPENFILENAME) As Long

'Alarms for temperature
Public tempalenabled As Boolean
'''''
Declare Function VarPtrArray Lib "msvbvm60.dll" Alias "VarPtr" (Var() As Any) As Long




Private Type OPENFILENAME
  lStructSize As Long
  hwndOwner As Long
  hInstance As Long
  lpstrFilter As String
  lpstrCustomFilter As String
  nMaxCustFilter As Long
  nFilterIndex As Long
  lpstrFile As String
  nMaxFile As Long
  lpstrFileTitle As String
  nMaxFileTitle As Long
  lpstrInitialDir As String
  lpstrTitle As String
  flags As Long
  nFileOffset As Integer
  nFileExtension As Integer
  lpstrDefExt As String
  lCustData As Long
  lpfnHook As Long
  lpTemplateName As String
End Type

Public CurrentMirrorX
Public CurrentMirrorY
Public MirrorCentreX
Public MirrorCentreY

Public working_directory As String

Sub Main()

    LOCKIN_ADDR = 6
    LOCKIN2_ADDR = 30
    TEMP_CONTROL_LOCKIN = 23
    TEMP_CONTROL_LOCKIN_MODEL = 830
    TEMP_CONTROL_TYPE = 2
    BIASSWITCH_PRIMARY_ADDR = 10
    BIASSWITCH_SECONDARY_ADDR = 210
    DIGITISER_MODEL = 9825
    DIGITISER_ADDR = "350"
    FIXED_RESISTANCE_IN_CERNOX_CIRCUIT = 10000000
    MIRROR_LOCKIN_ADDR = 6
    MIRROR_DISTANCE_TO_VOLTAGE_RATIO = 0.45 * 1.734
    DVM1_ADDR = 15
    DVM2_ADDR = 22
    DVS_ADDR = 13
    BOXCAR_ADDR = 16
    SR510_GPIB_OR_RS232 = "GPIB"
    PSU_ADDR = 11
    Newport_Stepper_Port = 3
    
    'Set what type of IEEE488 card is in the machine
    '1 - National Instruments NI-488.2 GPIB-PCI card
    '2 - Keithley CEC488
    '3 - IOTECH Personal488 (make sure in the BIOS you have the IRQ and DMA set to legacy ISA)
    IEEECARD = 1
    
    NANOSTEPPER_TYPE = 3 '1 = Melles Griot, 2 = Thorlabs, 3=Newport
    THORLABS_STEPPER_CONTROLLER_SERIALNUM = 40809322
    
    ECLIPSE_PROG_PATH = App.Path
    If Right(ECLIPSE_PROG_PATH, 1) <> "\" Then ECLIPSE_PROG_PATH = ECLIPSE_PROG_PATH + "\"
    ECLIPSE_PROG_PATH = ECLIPSE_PROG_PATH + "Eclipse.exe"
    
    working_directory = App.Path

    NanoStep.Init ("") 'Default init
    GPIB.Init
    'Digitiser.Init
    'Mirrors.Init
    'DVS.DVS_Init (DVS_ADDR)
    'Boxcar.InitBoxcar (BOXCAR_ADDR)
    
    RS232.Hide
    MDIForm1.Show

End Sub

Public Function split_delimited_string(strng As String, delimiter As String, Out) As Boolean
    
    Dim strngout() As String
    
    b = 0
    strt = 1
    success = False
    For a = 1 To Len(strng) - (Len(delimiter) - 1)
    
        If Mid(strng, a, Len(delimiter)) = delimiter Then
            ReDim Preserve strngout(0 To b)
            strngout(b) = Mid(strng, strt, (a - strt))
            b = b + 1
            a = a + Len(delimiter)
            strt = a
            success = True
        End If
    
    Next a

    ReDim Preserve strngout(0 To b)
    strngout(b) = Mid(strng, strt, (a - strt))

    Out = strngout

    split_delimited_string = success

End Function

Public Function FileExists(fname As String) As Boolean

If fname = "" Or Right(fname, 1) = "\" Then
  FileExists = False: Exit Function
End If

FileExists = (Dir(fname) <> "")

End Function
Public Function IsEven(ByVal lngNumber As Integer) As Boolean
    
    IsEven = ((lngNumber Mod 2) = 0)

End Function

Public Sub Pause(pause_tim)

    t = Timer
    
    While (Timer < t + pause_tim)
        DoEvents
    Wend

End Sub

Public Sub Cleanup()

GPIB.Cleanup

End Sub

Public Function GetTemperature(sineout_voltage, lockin_reading, Thermometer_Type As Integer) As Double

    Dim coefs(10) As Double
    
    'Thermometer_type :- 1 = Cernox; 2 = Allen Bradley
    
    If Thermometer_Type = 1 Then
    
        If sineout_voltage = 0 Then sineout_voltage = 1
        SensorCurrent = sineout_voltage / FIXED_RESISTANCE_IN_CERNOX_CIRCUIT
        r = lockin_reading / SensorCurrent
    
        If r > 632.65 Then
            a = 8.026026
            b = -16.961066
            n = 7
            coefs(0) = -0.00019
            coefs(1) = 0.00051
            coefs(2) = 0.0003
            coefs(3) = -0.00847
            coefs(4) = 0.01748
            coefs(5) = 0.11329
            coefs(6) = -1.51295
            coefs(7) = 3.60533
    
        Else
    
            a = 9.137652
            b = -15.278483
            n = 8
            coefs(0) = 0.000053
            coefs(1) = 0.000089
            coefs(2) = -0.000145
            coefs(3) = -0.000665
            coefs(4) = 0.002312
            coefs(5) = -0.002648
            coefs(6) = -0.069569
            coefs(7) = -1.239404
            coefs(8) = 9.057825
        
        End If
    
        If r <= 0 Then r = 900
        r = Log(Log(r))
        X = a * r + b
    
        For i = 0 To n
            G = X * f - d + coefs(i)
            e = d
            d = f
            f = G
        Next
    
        GetTemperature = Exp(0.5 * (G - e))
    
    Else
        
        lockin_reading = X
        
        t = (0.06708 * X ^ 5 + 0.5467 * X ^ 4 - 19.35 * X ^ 3 - 0.772 * X ^ 2 + 0.02683 * X + 0.00001724) / (X ^ 5 + 0.3805 * X ^ 4 + 69.68 * X ^ 3 - 0.4282 * X ^ 2 + 0.01024 * X + -0.0000004443)
        GetTemperature = t
    
    End If
    
End Function

Public Function AutoGetTemperature(lockin_address As Integer, lockin_model As Integer, Thermometer_Type As Integer, Optional ByRef sineout_voltage = False, Optional ByRef lockin_reading = False) As Double

    Dim success As Boolean
    Dim rt
    Dim coefs(10) As Double
    
    'Thermometer_Type :- 1 = Cernox; 2 = Allen Bradley
    
    If Thermometer_Type = 1 Then
    
        If TEMP_CONTROL_LOCKIN_MODEL = 830 Then
            LockinMagnitude = CDec(SRS830.SRS830_ReadChannel(lockin_address, 3, rt, success))
            refvoltage = CDec(SRS830.SRS830_ReadChannel(lockin_address, 5, rt, success))
            If refvoltage = 0 Then refvoltage = 1
            SensorCurrent = refvoltage / FIXED_RESISTANCE_IN_CERNOX_CIRCUIT
            r = LockinMagnitude / SensorCurrent
        Else
            LockinMagnitude = CDec(SR510.SR510_ReadX(lockin_address, rt, success))
            refvoltage = sineout_voltage
            If refvoltage = 0 Then refvoltage = 1
            SensorCurrent = refvoltage / FIXED_RESISTANCE_IN_CERNOX_CIRCUIT
            r = LockinMagnitude / SensorCurrent
        End If
    
        If sineout_voltage Then
            sineout_voltage = refvoltage
        End If
    
        If lockin_reading Then
            lockin_reading = LockinMagnitude
        End If

        If r > 632.65 Then
            a = 8.026026
            b = -16.961066
            n = 7
            coefs(0) = -0.00019
            coefs(1) = 0.00051
            coefs(2) = 0.0003
            coefs(3) = -0.00847
            coefs(4) = 0.01748
            coefs(5) = 0.11329
            coefs(6) = -1.51295
            coefs(7) = 3.60533
    
        Else
    
            a = 9.137652
            b = -15.278483
            n = 8
            coefs(0) = 0.000053
            coefs(1) = 0.000089
            coefs(2) = -0.000145
            coefs(3) = -0.000665
            coefs(4) = 0.002312
            coefs(5) = -0.002648
            coefs(6) = -0.069569
            coefs(7) = -1.239404
            coefs(8) = 9.057825
        
        End If
    
        If r <= 0 Then r = 900
        r = Log(Log(r))
        X = a * r + b
    
        For i = 0 To n
            G = X * f - d + coefs(i)
            e = d
            d = f
            f = G
        Next
    
        AutoGetTemperature = Exp(0.5 * (G - e))
    
    Else
        
        If TEMP_CONTROL_LOCKIN_MODEL = 830 Then
            LockinMagnitude = CDec(SRS830.SRS830_ReadChannel(lockin_address, 3, rt, success))
         Else
             LockinMagnitude = CDec(SR510.SR510_ReadX(lockin_address, rt, success))
         End If
       
         X = LockinMagnitude
          
        t = (0.06708 * X ^ 5 + 0.5467 * X ^ 4 - 19.35 * X ^ 3 - 0.772 * X ^ 2 + 0.02683 * X + 0.00001724) / (X ^ 5 + 0.3805 * X ^ 4 + 69.68 * X ^ 3 - 0.4282 * X ^ 2 + 0.01024 * X + -0.0000004443)
        AutoGetTemperature = t
        
    End If


End Function

Public Function FourierPowerSpectrum(inarr, outarr) As Boolean

    ubin = UBound(inarr)
    lbin = LBound(inarr)
    ubout = UBound(outarr)
    lbout = LBound(outarr)
    
    If (ubin - lbin = ubout - lbout) Then
        lngth = (ubin - lbin) + 1
    Else
        FourierPowerSpectrum = False
        GoTo ext
    End If
    
    For a = lbout To ubout
        outarr(a) = 0
    Next a
    
    const2 = 0
    For a = lbin To ubin
        const2 = const2 + inarr(a) * inarr(a)
    Next a
    
    
    For n = lbout To ubout
    
        const1 = 2 * PI * n / lngth
        
        For a = lbin To ubin
        For b = a + 1 To ubin
        
            i = a - lbin
            j = b - lbin
            outarr(n) = outarr(n) + inarr(a) * inarr(b) * Cos(const1 * (j - i))
        
        Next b
        Next a
    
        outarr(n) = const2 + outarr(n) * 2
    
    Next n
    
    FourierPowerSpectrum = True
    
ext:
End Function

Public Function HammingWindow(inarr, outarr) As Boolean

    li = UBound(inarr) - LBound(inarr) + 1
    lo = UBound(outarr) - LBound(outarr) + 1

    If li <> lo Then
        HammingWindow = False
    Else
        For a = LBound(outarr) To UBound(outarr)
        
            b = a + LBound(inarr) - LBound(outarr)
            k = a - LBound(outarr)
            outarr(a) = inarr(b) * (0.54 - 0.46 * Cos(2 * PI * k / (lo - 1)))
        
        Next a
        HammingWindow = True
    End If

End Function

Public Function SaveDialog() As String

  Dim OpenFile As OPENFILENAME
  Dim lReturn As Long
  Dim sFilter As String
  Dim s As String
  
  cpath = working_directory
  
  OpenFile.lStructSize = Len(OpenFile)
  OpenFile.hwndOwner = MDIForm1.hwnd
  OpenFile.hInstance = App.hInstance
  sFilter = "Data Files (*.dat)" & Chr(0) & "*.DAT" & Chr(0) & "All Files (*.*)" & Chr(0) & "*.*" & Chr(0)
  OpenFile.lpstrFilter = sFilter
  OpenFile.nFilterIndex = 1
  OpenFile.lpstrFile = String(257, 0)
  OpenFile.nMaxFile = Len(OpenFile.lpstrFile) - 1
  OpenFile.lpstrFileTitle = OpenFile.lpstrFile
  OpenFile.nMaxFileTitle = OpenFile.nMaxFile
  OpenFile.lpstrInitialDir = cpath
  OpenFile.lpstrTitle = "Save As"
  OpenFile.flags = 0
  lReturn = GetSaveFileName(OpenFile)
  
  ChDir (App.Path)
  
  If lReturn = 0 Then
     'Pressed Cancel
     SaveDialog = ""
  Else
     s = Trim(OpenFile.lpstrFile)
     For a = 1 To Len(s)
        If Asc(Mid(s, a, 1)) = 0 Then s = Mid(s, 1, a - 1): GoTo fin
     Next a
fin:
     working_directory = GetPath(s)
     SaveDialog = s
  End If
  
End Function

Public Function OpenDialog() As String

  Dim OpenFile As OPENFILENAME
  Dim lReturn As Long
  Dim sFilter As String
  Dim s As String
  
  cpath = working_directory
  
  OpenFile.lStructSize = Len(OpenFile)
  OpenFile.hwndOwner = MDIForm1.hwnd
  OpenFile.hInstance = App.hInstance
  sFilter = "Data Files (*.dat)" & Chr(0) & "*.DAT" & Chr(0) & "All Files (*.*)" & Chr(0) & "*.*" & Chr(0)
  OpenFile.lpstrFilter = sFilter
  OpenFile.nFilterIndex = 1
  OpenFile.lpstrFile = String(257, 0)
  OpenFile.nMaxFile = Len(OpenFile.lpstrFile) - 1
  OpenFile.lpstrFileTitle = OpenFile.lpstrFile
  OpenFile.nMaxFileTitle = OpenFile.nMaxFile
  OpenFile.lpstrInitialDir = cpath
  OpenFile.lpstrTitle = "Open File"
  OpenFile.flags = 0
  lReturn = GetOpenFileName(OpenFile)
  
  ChDir (cpath)
  
  If lReturn = 0 Then
     'Pressed Cancel
     OpenDialog = ""
  Else
     s = Trim(OpenFile.lpstrFile)
     For a = 1 To Len(s)
        If Asc(Mid(s, a, 1)) = 0 Then s = Mid(s, 1, a - 1): GoTo fin
     Next a
fin:
     working_directory = GetPath(s)
     OpenDialog = s
  End If
  
End Function

Public Function CropData(X, Y, lb, ub, newX, newY)

    Dim NX()
    Dim NY()

    If X(LBound(X)) <= X(UBound(X)) Then
    
        success1 = False
        success2 = False
        For a = LBound(X) To UBound(X)
            If X(a) > lb And success1 = False Then li = a: success1 = True
            If X(a) > ub And success2 = False Then ui = a - 1: success2 = True
        Next a
        
        ReDim Preserve NX(0 To 0)
        ReDim Preserve NY(0 To 0)
        NX(0) = lb
        s = interplinear(X, Y, lb, tmpy)
        NY(0) = tmpy
        
        b = 1
        For a = li To ui
            ReDim Preserve NX(0 To b)
            ReDim Preserve NY(0 To b)
            NX(b) = X(a)
            NY(b) = Y(a)
            b = b + 1
        Next a
        
        ReDim Preserve NX(0 To b)
        ReDim Preserve NY(0 To b)
        NX(b) = ub
        s = interplinear(X, Y, ub, tmpy)
        NY(b) = tmpy
        
    Else
        
        success1 = False
        success2 = False
        For a = UBound(X) To LBound(X) Step -1
            If X(a) > lb And success1 = False Then li = a: success1 = True
            If X(a) > ub And success2 = False Then ui = a + 1: success2 = True
        Next a
        
        ReDim Preserve NX(0 To 0)
        ReDim Preserve NY(0 To 0)
        NX(0) = lb
        s = interplinear(X, Y, lb, tmpy)
        NY(0) = tmpy
        
        b = 1
        For a = li To ui Step -1
            ReDim Preserve NX(0 To b)
            ReDim Preserve NY(0 To b)
            NX(b) = X(a)
            NY(b) = Y(a)
            b = b + 1
        Next a
        
        ReDim Preserve NX(0 To b)
        ReDim Preserve NY(0 To b)
        NX(b) = ub
        s = interplinear(X, Y, ub, tmpy)
        NY(b) = tmpy
        
    End If

    newX = NX
    newY = NY
    
End Function

Public Function interplinear(X, Y, px, py) As Boolean

'Supply X, Y and px and returns py, the value of Y at px

Dim success As Boolean

    If X(LBound(X)) <= X(UBound(X)) Then
    
        success = False
        For a = LBound(X) To UBound(X)
            If X(a) > px And success = False Then ui = a: success = True: GoTo nxt1
        Next a
nxt1:
        If success = True Then
            li = a - 1
            py = (px - X(li)) * Y(ui) / Abs(X(ui) - X(li)) + (X(ui) - px) * Y(li) / Abs(X(ui) - X(li))
        End If
        
    Else
    
        success = False
        For a = LBound(X) To UBound(X)
            If X(a) < px And success = False Then li = a: success = True: GoTo nxt2
        Next a
nxt2:
        If success = True Then
            ui = a - 1
            py = (px - X(li)) * Y(ui) / Abs(X(ui) - X(li)) + (X(ui) - px) * Y(li) / Abs(X(ui) - X(li))
        End If
        
    End If

interplinear = success

End Function

Public Function FormatRemainingTime(t) As String

Dim mins As Integer
Dim hrs As Integer
Dim days As Integer

    mins = Int(t / 60)
    secs = t - 60 * mins
    hrs = Int(mins / 60)
    mins = mins - 60 * hrs
    days = Int(hrs / 24)
    hrs = hrs - days * 24
    
    s = ""
    If days = 1 Then s = s + Format(days) + " day, "
    If days > 1 Then s = s + Format(days) + " days, "
    If hrs = 1 Then s = s + Format(hrs) + " hour, "
    If hrs > 1 Then s = s + Format(hrs) + " hours, "
    If mins = 1 Then s = s + Format(mins) + " minute, "
    If mins > 1 Then s = s + Format(mins) + " minutes, "
    If secs = 1 Then s = s + Format(secs) + " second. "
    If secs > 1 Then s = s + Format(secs, "0.00") + " seconds. "
    
    If s = "" Then s = "None  "
    s = Mid(s, 1, Len(s) - 2)
    
    FormatRemainingTime = s

End Function

Public Function GetPath(s As String) As String

    p = App.Path
    For a = Len(s) To 1 Step -1
        If Mid(s, a, 1) = "\" Then p = Mid(s, 1, a): GoTo fin
    Next a

fin:
GetPath = p

End Function

Public Function GetColourCodeFromHSL(H, s, l)

Dim r
Dim G
Dim b

HueAngle = H * (360 / 255)

If (HueAngle >= 0 And HueAngle < 60) Then
        r = 255
        G = HueAngle * (255 / 60)
        b = 0.1
End If

If (HueAngle >= 60 And HueAngle < 120) Then
        G = 255
        r = 255 - (HueAngle - 60) * (255 / 60)
        b = 0.1
End If

If (HueAngle >= 120 And HueAngle < 180) Then
        G = 255
        b = (HueAngle - 120) * (255 / 60)
        r = 0.1
End If

If (HueAngle >= 180 And HueAngle < 240) Then
        b = 255
        G = 255 - (HueAngle - 180) * (255 / 60)
        r = 0.1
End If
    
If (HueAngle >= 240 And HueAngle < 300) Then
        b = 255
        r = (HueAngle - 240) * (255 / 60)
        G = 0.1
End If
       
If (HueAngle >= 300# And HueAngle < 360) Then
        r = 255
        b = 255 - (HueAngle - 300) * (255 / 60)
        G = 0.1
End If

ratio = s / 255
p = (1 - ratio) * 127.5
    
r = r * ratio + p
G = G * ratio + p
b = b * ratio + p

ratio = l / 127.5
p = (ratio - 1) * 255

If (ratio >= 1) Then
        r = (2 - ratio) * r + p
        G = (2 - ratio) * G + p
        b = (2 - ratio) * b + p
Else
    r = ratio * r
    G = ratio * G
    b = ratio * b
End If

r = CInt(r)
G = CInt(G)
b = CInt(b)

GetColourCodeFromHSL = RGB(r, G, b)

End Function
