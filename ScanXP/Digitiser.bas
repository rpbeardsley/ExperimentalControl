Attribute VB_Name = "Digitiser"
Declare Sub inword Lib "scan97.dll" (ByVal ioport As Integer, datawd As Integer)
Declare Sub inbyte Lib "scan97.dll" (ByVal ioport As Integer, databt As Byte)
Declare Sub outbyte Lib "scan97.dll" (ByVal ioport As Integer, ByVal baseport As Integer, ByVal databt As Byte, ByVal cardmodel As Integer)
Declare Sub average Lib "scan97.dll" (ByVal baseport As Integer, ByVal record_length As Long, ByVal records_to_ignore As Long, arrayref As Double, ByVal software_averages As Long, satval As Integer, ByVal gain As Double, ByVal Offset As Double, status As Byte, ByVal cardmodel As Integer)
Declare Function testdigitiser Lib "scan97.dll" (ByVal timeout As Long, ByVal baseport As Integer) As Integer
Declare Sub setupdll Lib "scan97.dll" (ByVal pb_hwnd As Long, ByVal ioport As Integer)
Declare Sub stopdll Lib "scan97.dll" ()
Public Declare Function GetDriverStatus Lib "scan97.dll" () As Integer
Public Declare Function GetDLLStatus Lib "scan97.dll" () As Integer

Public ignore As Integer
Private tmp As Byte
Private baseaddr As Integer
Public SoftwareSweeps As Long

Public Function SetBaseAddress(Address As String)
    baseaddr = Val("&H" + Address)
End Function

Public Function GetBaseAddress() As String
    GetBaseAddress = Hex$(baseaddr)
End Function

Public Function SetPreampInput(inputnum As String)

    tmp = ReadPort(2)
    
    Select Case inputnum
    Case "1"
    tmp = tmp Or 64
    WritePort 2, tmp
    
    Case "2"
    tmp = tmp And 191
    WritePort 2, tmp
    
    Case Else
    MsgBox "Invalid Property Value"
    End Select

End Function


Public Function GetPreampInput()
    tmp = ReadPort(2) And 64
    
    If tmp > 0 Then
        GetPreampInput = "1"
    Else
        GetPreampInput = "2"
    End If
End Function

Public Function SetCoupling(coupl As String)

    tmp = ReadPort(2)
    
    Select Case Left$(coupl, 1)
    Case "A"
    tmp = tmp Or 128
    WritePort 2, tmp
    
    Case "D"
    tmp = tmp And 127
    WritePort 2, tmp
    
    Case Else
    MsgBox "Invalid Property Value"
    End Select

End Function

Public Function GetCoupling() As String
    tmp = ReadPort(2) And 128
    
    If tmp > 0 Then
    GetCoupling = "AC"
    Else
    GetCoupling = "DC"
    End If

End Function

Public Function SetHardwareSweeps(sweeps As Long)
    If sweeps > 0 Then
        tmp = CInt((Log(sweeps) / Log(2)))
        WritePort 9, tmp + 128
    Else
        If sweeps = 0 Then WritePort 9, 128
    End If
End Function

Public Function GetHardwareSweeps() As Long
    tmp = ReadPort(9)
    GetHardwareSweeps = 2 ^ (tmp - 128)
End Function

Public Function SetInputImpedance(impedance As String)

    tmp = ReadPort(2)
    
    Select Case Left$(impedance, 1)
    Case "5"
    tmp = tmp Or 32
    WritePort 2, tmp
    
    Case "1"
    tmp = tmp And 223
    WritePort 2, tmp
    
    Case Else
    MsgBox "Invalid Property Value"
    End Select

End Function

Public Function GetInputImpedance() As String
    tmp = ReadPort(2) And 32
    
    If tmp > 0 Then
        GetInputImpedance = "50 ohm"
    Else
        GetInputImpedance = "1 Kohm"
    End If

End Function

Public Function SetPreampGain(gain As Integer)

    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        tmp = CByte(6 * (Log(gain / 10)) / Log(2))
        WritePort 7, tmp
    ElseIf DIGITISER_MODEL = 9825 Then
        tmp = 1
        If gain = 40 Then
            tmp = 189
        ElseIf gain = 60 Then
            tmp = 145
        ElseIf gain = 100 Then
            tmp = 104
        ElseIf gain = 150 Then
            tmp = 86
        ElseIf gain = 200 Then
            tmp = 74
        ElseIf gain = 300 Then
            tmp = 66
        ElseIf gain = 400 Then
            tmp = 63
        End If
        
        If tmp > 1 Then
            WritePort 7, tmp
        Else
            MsgBox "Invalid Preamp Gain Setting", vbExclamation, "Digitiser Error"
        End If
        
    End If
    
End Function

Public Function GetPreampGain() As Integer
    tmp = ReadPort(7)
    
    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        If tmp > 40 Then GetPreampGain = 1000 Else GetPreampGain = 10 * 2 ^ (tmp / 6)
    End If
    
    If DIGITISER_MODEL = 9825 Then
        If tmp = 189 Then GetPreampGain = 40
        If tmp = 145 Then GetPreampGain = 60
        If tmp = 104 Then GetPreampGain = 100
        If tmp = 86 Then GetPreampGain = 150
        If tmp = 74 Then GetPreampGain = 200
        If tmp = 66 Then GetPreampGain = 300
        If tmp = 63 Then GetPreampGain = 400
    End If
    
End Function

Public Function SetRecordLength(reclength As Long)
    tmp = Log(reclength) / Log(2)
    WritePort 10, tmp
End Function

Public Function GetRecordLength() As Long
    tmp = ReadPort(10)
    GetRecordLength = 2 ^ tmp
End Function

Public Function SetPreampOffset(Offset As Integer)
    
    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        tmp = 128 + Offset
        WritePort 12, tmp
    ElseIf DIGITISER_MODEL = 9825 Then
        tmp = 124 + Offset
        WritePort 12, tmp
    End If
    
End Function

Public Function GetPreampOffset() As Integer
    tmp = ReadPort(12)
    
    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        GetPreampOffset = tmp - 128
    ElseIf DIGITISER_MODEL = 9825 Then
        GetPreampOffset = tmp - 124
    End If
    
End Function

Public Function SetSamplePeriod(period As Integer)
    
    If DIGITISER_MODEL = 9846 Or DIGITISER_MODEL = 9826 Then
        If period = 2560 Then tmp = 12
        If period = 1280 Then tmp = 11
        If period = 640 Then tmp = 10
        If period = 320 Then tmp = 9
        If period = 160 Then tmp = 8
        If period = 80 Then tmp = 7
        If period = 40 Then tmp = 6
        If period = 20 Then tmp = 5
        If period = 10 Then tmp = 4
        If period = 4 Then tmp = 3
        If period = 2 Then tmp = 2
    End If
    
    If DIGITISER_MODEL = 9825 Then
        If period = 160 Then tmp = 21
        If period = 80 Then tmp = 69
        If period = 40 Then tmp = 5
        If period = 20 Then tmp = 52
        If period = 10 Then tmp = 100
        If period = 5 Then tmp = 36
    End If

    
    WritePort 5, tmp
End Function

Public Function GetSamplePeriod() As Integer
    tmp = ReadPort(5)

    If DIGITISER_MODEL = 9846 Or DIGITISER_MODEL = 9826 Then
        If tmp > 12 Then GetSamplePeriod = 2
        If tmp = 12 Then GetSamplePeriod = 2560
        If tmp = 11 Then GetSamplePeriod = 1280
        If tmp = 10 Then GetSamplePeriod = 640
        If tmp = 9 Then GetSamplePeriod = 320
        If tmp = 8 Then GetSamplePeriod = 160
        If tmp = 7 Then GetSamplePeriod = 80
        If tmp = 6 Then GetSamplePeriod = 40
        If tmp = 5 Then GetSamplePeriod = 20
        If tmp = 4 Then GetSamplePeriod = 10
        If tmp = 3 Then GetSamplePeriod = 4
        If tmp = 2 Then GetSamplePeriod = 2
    End If
    
    
    If DIGITISER_MODEL = 9825 Then
        
        If tmp = 21 Then
            GetSamplePeriod = 160
        ElseIf tmp = 69 Then
            GetSamplePeriod = 80
        ElseIf tmp = 5 Then
            GetSamplePeriod = 40
        ElseIf tmp = 52 Then
            GetSamplePeriod = 20
        ElseIf tmp = 100 Then
            GetSamplePeriod = 10
        ElseIf tmp = 36 Then
            GetSamplePeriod = 5
        Else
            GetSamplePeriod = 5
            MsgBox "Error getting sampling period from digitiser", vbExclamation, "Digitiser Error"
        End If
        
    End If

End Function

Public Function SetTriggerLevel(level As Single)

    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        tmp = CByte(CInt(256 * (level + 10) / 20))
        WritePort 4, tmp
    ElseIf DIGITISER_MODEL = 9825 Then
        If level >= 0 Then
            tmp = CByte(CInt(30 - (level * 20)))
        Else
            tmp = CByte(CInt(94 - (level * 20)))
        End If
        WritePort 4, tmp
    Else
        MsgBox "Invalid Digitiser Model Setting", vbExclamation, "Digitiser Error"
    End If
    

End Function

Public Function GetTriggerLevel() As Single
    tmp = ReadPort(4)
    
    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        GetTriggerLevel = -10 + (tmp * 20 / 256)
    ElseIf DIGITISER_MODEL = 9825 Then
        If tmp >= 94 Then
            GetTriggerLevel = (94 - tmp) / 20
        Else
            GetTriggerLevel = (30 - tmp) / 20
        End If
    Else
        MsgBox "Invalid Digitiser Model Setting", vbExclamation, "Digitiser Error"
    End If
    
End Function

Public Function SetTriggerPolarity(polarity As String)

    tmp = ReadPort(2)
    
    Select Case polarity
    Case "+"
    tmp = tmp And 253
    WritePort 2, tmp
    
    Case "-"
    tmp = tmp Or 2
    WritePort 2, tmp
    
    Case Else
    MsgBox "Invalid Property Value"
    End Select

End Function

Public Function GetTriggerPolarity() As String

    tmp = ReadPort(2) And 2
    
    If tmp > 0 Then
    GetTriggerPolarity = "-"
    Else
    GetTriggerPolarity = "+"
    End If

End Function

Public Function GetReadOutMode()

    tmp = ReadPort(11) And 256
    
    If tmp > 0 Then
    GetReadOutMode = "DT-CONNECT"
    Else
    GetReadOutMode = "ISA bus"
    End If

End Function

Public Function Init()
    
    If DIGITISER_MODEL = 9825 Then
        SetBaseAddress DIGITISER_ADDR
        ignore = 11
    Else
        SetBaseAddress DIGITISER_ADDR
        ignore = 76
    End If
    
    SoftwareSweeps = 1
    
    setupdll MDIForm1.ProgressBar1.hWnd, Val("&H" & GetBaseAddress)
    
    If Not GetDriverStatus = 1 Then MsgBox "Digitiser Port Reading device driver failed to initialise.", vbCritical
    If Not GetDLLStatus > 0 Then MsgBox "Digitiser User-Mode Port Reading Wrapper DLL failed to initialise.", vbCritical
    

End Function

Public Function GetTrace(xdata, ydata)

    Dim satval As Integer 'Does saturation occur
    Dim datarray() As Double
    Dim gain As Double
    Dim Offset As Double
    Dim reclen As Long
    Dim status As Byte
    Dim X() As Double
    Dim Y() As Double
    Dim cardmodel As Integer
    
    intignore = 0
    
    If DIGITISER_MODEL = 9825 Then
        cardmodel = 1
    Else
        cardmodel = 0
    End If
    
    reclen = GetRecordLength
    satval = 0
    gain = GetPreampGain
    Offset = GetPreampOffset / 100
    
    ReDim datarray(0 To reclen - 1)
    
    ' Software averaged traces (in C)
    Call average(baseaddr, reclen, ignore, datarray(0), SoftwareSweeps, satval, gain, Offset, status, cardmodel)
    
    If status = 1 Then MsgBox "Time-out waiting to send command to digitiser", vbExclamation, "Error"
    If status = 2 Then MsgBox "Time-out waiting for card to acquire data.", vbExclamation, "Error"
    If status = 3 Then MsgBox "Time-out waiting for first valid trigger.", vbExclamation, "Error"
    If status = 4 Then MsgBox "Records available before collection.", vbExclamation, "Error"
    
    'Get rid of 'ignore' number of records from end, which will be nonsense, plus 30
    
    ReDim X(0 To (reclen - (ignore + intignore)))
    ReDim Y(0 To (reclen - (ignore + intignore)))
    For a = 0 To (reclen - (ignore + intignore))
        X(a) = (a + ignore + intignore) * GetSamplePeriod
        Y(a) = datarray(a)
    Next a

    xdata = X
    ydata = Y

End Function

Private Function ReadPort(port As Byte) As Byte
    inbyte baseaddr + port, tmp
    ReadPort = tmp
End Function

Private Sub WritePort(port As Byte, value As Byte)
    Dim cardmodel As Integer
    
    If DIGITISER_MODEL = 9825 Then
        cardmodel = 1
    Else
        cardmodel = 0
    End If
    
    Call outbyte(baseaddr + port, baseaddr, value, cardmodel)
End Sub

Private Function ReadWord(port As Byte)
    Dim tmp As Integer
    
    inword baseaddr + port, tmp
    ReadWord = tmp
End Function

Public Sub DigitiserSettings()

Dim strng As String
Dim b As Integer
Dim tmp As Byte
Dim i As Byte

    For i = 0 To 15
    
        tmp = ReadPort(i)
        strng = Hex(i) + " : "
        For b = 7 To 0 Step -1
            strng = strng + Format$(-((tmp And (2 ^ b)) > 0), "0")
        Next b
        strng = strng + " , " + Mid(Str(Val(tmp)), 2)
        MsgBox strng, vbInformation, "Digitiser Settings"
        
    Next i
    
End Sub

Private Sub SetDefaultSettings()


Digitiser.SetPreampInput "1"
Digitiser.SetCoupling "DC"
Digitiser.SetTriggerLevel 0
Digitiser.SetPreampGain 40
Digitiser.SetPreampOffset 50
Digitiser.SetRecordLength 2048
Digitiser.SetHardwareSweeps 4
Digitiser.SoftwareSweeps = 1
Digitiser.SetSamplePeriod 10
Digitiser.SetTriggerPolarity "+"
Digitiser.SetInputImpedance "50 ohm"


End Sub
