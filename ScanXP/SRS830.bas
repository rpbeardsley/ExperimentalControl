Attribute VB_Name = "SRS830"
Public Function SRS830_SetPhase(phas, addr As Integer)

    GPIB.send "PHAS " + Mid(Str(phas), 2), addr

End Function

Public Function SRS830_GetPhase(addr As Integer) As Single


    Dim inbuf As String
    Dim strng As String
    
    'Request phase
    strng = "PHAS?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    SRS830_GetPhase = CSng(Val(inbuf))

End Function

Public Function SRS830_SetSineOutAmplitude(amp As Single, addr As Integer)

    If amp >= 0.004 And amp <= 5 Then
        GPIB.send "SLVL " + Format(amp, "0.000"), addr
    Else
        MsgBox "Invalid sine-out amplitude.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_SetRefFrequency(f As Double, addr As Integer)

    If f >= 0.001 And f <= 102000 Then
        f = f * 10000
        f = CLng(f)
        
        GPIB.send "FREQ " + Format(f, "0.0000"), addr
    Else
        MsgBox "Invalid sine-out amplitude.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_SetHarmNumber(addr As Integer, n As Integer)

    If (n > 0 And n < 19999) Then
        GPIB.send "HARM " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid harmonic number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetHarmNumber(addr As Integer) As Integer

    Dim inbuf As String
    Dim strng As String
    
    'Request harmonic
    strng = "HARM?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    SRS830_GetHarmNumber = CInt(inbuf)

End Function

Public Function SRS830_SetExtTriggerMode(addr As Integer, n As Integer)

    If (n >= 0 And n < 3) Then
        GPIB.send "RSLP " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid external-trigger reference-mode option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetExtTriggerMode(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "RSLP?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "Sine"
    If indx = 1 Then s = "+ve Edge"
    If indx = 2 Then s = "-ve Edge"
    
    SRS830_GetExtTriggerMode = s

End Function

Public Function SRS830_SetRefSource(addr As Integer, n As Integer)

    If (n >= 0 And n < 2) Then
        GPIB.send "FMOD " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid reference source option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetRefSource(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "FMOD?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "External"
    If indx = 1 Then s = "Internal"
    
    SRS830_GetRefSource = s

End Function

Public Function SRS830_SetReserveMode(addr As Integer, n As Integer)

    If (n >= 0 And n < 3) Then
        GPIB.send "RMOD " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid reserve mode option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetReserveMode(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "RMOD?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "High Reserve"
    If indx = 1 Then s = "Normal"
    If indx = 2 Then s = "Low Noise"
    
    SRS830_GetReserveMode = s

End Function

Public Function SRS830_SetLPFilterSlope(addr As Integer, n As Integer)

    If (n >= 0 And n < 4) Then
        GPIB.send "OFSL " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid low-pass filter slope option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetLPFilterSlope(addr As Integer, indx As Integer) As Single

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "OFSL?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = 6
    If indx = 1 Then s = 12
    If indx = 2 Then s = 18
    If indx = 3 Then s = 24
    
    SRS830_GetLPFilterSlope = s

End Function

Public Function SRS830_SetInputConfig(addr As Integer, n As Integer)

    If (n >= 0 And n < 4) Then
        GPIB.send "ISRC " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid input configuration option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetInputConfig(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "ISRC?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "A"
    If indx = 1 Then s = "A-B"
    If indx = 2 Then s = "I (1 M-Ohm)"
    If indx = 3 Then s = "I (100 M-Ohm)"
    
    SRS830_GetInputConfig = s

End Function

Public Function SRS830_SetInputShieldGrounding(addr As Integer, n As Integer)

    If (n >= 0 And n < 2) Then
        GPIB.send "IGND " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid input shield grounding option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetInputShieldGrounding(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "IGND?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "Float"
    If indx = 1 Then s = "Ground"
    
    SRS830_GetInputShieldGrounding = s

End Function

Public Function SRS830_SetInputCoupling(addr As Integer, n As Integer)

    If (n >= 0 And n < 2) Then
        GPIB.send "ICPL " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid input coupling option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetInputCoupling(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "ICPL?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "AC"
    If indx = 1 Then s = "DC"
    
    SRS830_GetInputCoupling = s

End Function

Public Function SRS830_SetInputLineNotchFilter(addr As Integer, n As Integer)

    If (n >= 0 And n < 4) Then
        GPIB.send "ILIN " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid input line notch filter mode option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetInputLineNotchFilter(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "ILIN?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "Out"
    If indx = 1 Then s = "Line Notch In"
    If indx = 2 Then s = "2x Line Notch In"
    If indx = 3 Then s = "1x and 2x Line Notch In"
    
    SRS830_GetInputLineNotchFilter = s

End Function

Public Function SRS830_SetTimeConstant(addr As Integer, n As Integer)

    If (n >= 0 And n < 20) Then
        GPIB.send "OFLT " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid time constant option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetTimeConstant(addr As Integer, indx As Integer) As Double

    Dim inbuf As String
    Dim strng As String
    
    'Request time constant
    strng = "OFLT?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    
    a = Val(inbuf)
    If a = 0 Then tc = 0.00001
    If a = 1 Then tc = 0.00003
    If a = 2 Then tc = 0.0001
    If a = 3 Then tc = 0.0003
    If a = 4 Then tc = 0.001
    If a = 5 Then tc = 0.003
    If a = 6 Then tc = 0.01
    If a = 7 Then tc = 0.03
    If a = 8 Then tc = 0.1
    If a = 9 Then tc = 0.3
    If a = 10 Then tc = 1
    If a = 11 Then tc = 3
    If a = 12 Then tc = 10
    If a = 13 Then tc = 30
    If a = 14 Then tc = 100
    If a = 15 Then tc = 300
    If a = 16 Then tc = 1000
    If a = 17 Then tc = 3000
    If a = 18 Then tc = 10000
    If a = 19 Then tc = 30000
    
    indx = a
    SRS830_GetTimeConstant = tc

End Function

Public Function SRS830_SetSensitivity(addr As Integer, n As Integer)

    If (n >= 0 And n < 20) Then
        GPIB.send "SENS " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid sensitivity option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SRS830_GetSensitivity(addr As Integer, Optional VoltageOrCurrent As Integer = 0) As Double
'Public Function SRS830_GetSensitivity(addr As Integer, indx As Integer, Optional VoltageOrCurrent As Integer = 0) As Double
    'Get sensitivity.
    'If VoltageOrCurrent = 0 then sensitivity is returned in
    'voltage units, otherwise it is in current units.
    'Default is voltage units

    Dim inbuf As String
    Dim strng As String
    Dim a As Integer
    Dim b As Boolean
    
    'Request sensitivity
    strng = "SENS?"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    
    a = Val(inbuf)
    If VoltageOrCurrent = 0 Then b = True Else b = False
    sens = GetFullScale(a, b)
    
    indx = a
    SRS830_GetSensitivity = sens

End Function

Public Function SRS830_SetAuxVoltage(addr As Integer, channel As Integer, voltage As Double, Optional success As Boolean = False)

    Dim s As String
    Dim DidItWork As Boolean
    success = False
    DidItWork = False

    If channel = 1 Then
        s = "AUXV1," & Format(voltage, "#0.00#")
        GPIB.send s, addr, DidItWork
    ElseIf channel = 2 Then
        s = "AUXV2," & Format(voltage, "#0.00#")
        GPIB.send s, addr, DidItWork
    Else
        MsgBox "Invalid Auxiliary Voltage Channel Index", vbExclamation, "Lockin communications error"
    End If
    
    If DidItWork = True Then success = True
    
End Function

Public Function SRS830_GetAuxVoltage(addr As Integer, channel As Integer, Optional success As Boolean = False) As Single

    Dim inbuf As String
    Dim strng As String
    Dim DidItWork As Boolean
    
    DidItWork = False
    success = False
    
    'Request phase
    If channel = 1 Then
        strng = "AUXV? 1"
        GPIB.send strng, addr, DidItWork
    ElseIf channel = 2 Then
        strng = "AUXV? 2"
        GPIB.send strng, addr, DidItWork
    End If
    
    
    If DidItWork = True Then
    
        'Read Response
        DidItWork = False
        If channel = 1 Or channel = 2 Then
            inbuf = GPIB.Recv(addr, 256, DidItWork)
            If DidItWork = True Then
                SRS830_GetAuxVoltage = CSng(Val(inbuf))
                success = True
            Else
                MsgBox "Error receiving auxiliary voltage from SRS830", vbExclamation, "Lockin Communications Error"
            End If
        End If
        
    Else
        MsgBox "Error sending request for auxiliary voltage to SRS830", vbExclamation, "Lockin Communications Error"
    End If

End Function

Public Function SRS830_FastMeasure(samp_rate As Integer, numsamples As Integer, addr As Integer, X, Y)

'Not supported by current GPIB programming

'    Dim buff As String
'    Dim b1, b2, b3, b4 As Byte
'    Dim lockinX() As Integer
'    Dim lockinY() As Integer
'    Dim tmp

'    'Setup data to record
'    ReDim lockinX(0 To numsamples - 1)
'    ReDim lockinY(0 To numsamples - 1)

    'Reset data buffer
'    GPIB.send "REST", addr

    'Set sample rate to 1Hz
'    GPIB.send "SRAT" + Mid(Str(samp_rate), 2), addr

    'Query offsets and expands
'    GPIB.send "OEXP? 1", addr
'    buff = GPIB.Recv(addr, 256) 'Recieve up to 256 bytes
'    split_delimited_string buff, ",", tmp
'    Offset = Val(tmp(0))
'    Expand = 10 ^ Val(tmp(1))
    
    'Query sensitivity
'    GPIB.send "SENS?", addr
'    buff = GPIB.Recv(addr, 256)
'    fullscale = GetFullScale(Val(buff), True)

    'Set loop mode collection
'    GPIB.send "SEND1", addr

    'Set fast data transfer mode. X and Y are sent over
    'the IEEE every time a point is sampled and stored
    'by the lockin.
'    GPIB.send "FAST1", addr
    
    
    'Start the fast data transfer after 0.5 seconds
'    GPIB.send "STRD", addr
    
'    For a = 0 To numsamples - 1
'        buff = GPIB.RecvBinary(addr, 4)
'        b1 = Mid(buff, 1, 1)
'        b2 = Mid(buff, 2, 1)
'        b3 = Mid(buff, 3, 1)
'        b4 = Mid(buff, 4, 1)
'        lockinX(a) = fullscale * (b2 + b1 * 256) / 30000
'        lockinY(a) = fullscale * (b4 + b3 * 256) / 30000
'    Next a
    

    'Pause and reset the buffer to stop recording
'    GPIB.send "PAUS", addr
'    GPIB.send "REST", addr

'    For a = 0 To numsamples - 1
'        X(a) = lockinX(a)
'        Y(a) = lockinY(a)
'    Next a

End Function

Public Function SRS830_ReadChannel(addr As Integer, channel As Integer, ByRef readtime, ByRef success As Boolean) As Double

    Dim inbuf As String
    Dim strng As String
    Dim DidItWork As Boolean

    'channel = 1 reads X
    'channel = 2 reads Y
    'channel = 3 reads R
    'channel = 4 reads theta
    'channel = 5 Read Amplitude of Reference Sine Out
    'channel = 6 Reads Reference Frequency
    
    'Request the value of Channel 1 on the lock-in
    If (channel > 0 And channel < 5) Then
        strng = "OUTP? " + Format(channel, "#")
    ElseIf (channel = 5) Then
        strng = "SLVL?"
    ElseIf (channel = 6) Then
        strng = "FREQ?"
    Else
        success = False
        GoTo ext
    End If
    
    DidItWork = False
    GPIB.send strng, addr, DidItWork
    readtime = Timer
    If DidItWork = False Then success = False: GoTo ext
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256, DidItWork)
    If DidItWork = False Then success = False: GoTo ext

    'Scan through the 20 char buffer and
    'separate mantissa from exponent
    m1 = -1
    m2 = -1
    success = True
    For a = 1 To 20
        If Mid(inbuf, a, 1) = "e" Then m1 = a
        If Mid(inbuf, a, 1) = vbLf Then m2 = a: GoTo fin
        If a = Len(inbuf) Then m2 = a + 1: GoTo fin
    Next a
fin:
    If (m1 > -1 And m2 > -1) Then
        mantissa = Val(Mid(inbuf, 1, (m1 - 1)))
        exponent = Val(Mid(inbuf, (m1 + 1), (m2 - (m1 + 1))))
        valu = mantissa * (10 ^ exponent)
    ElseIf (m1 = -1 And m2 > -1) Then
        valu = Val(Mid(inbuf, 1, (m2 - 1)))
    ElseIf (m2 = -1) Then
        success = False
    End If

    SRS830_ReadChannel = valu
    
ext:

End Function
Public Function SR830_getDataBuffer(addr As Integer, ByRef succes As Boolean) As Double

Dim j As String
Dim inbuf As String
Dim tdata() As Integer
Dim sdata() As Integer

addr = 6

Open "C:\Documents and Settings\phononshared\Desktop\maryam\test.txt" For Append As #1

GPIB.send "SPTS?", addr     'queries how many points in buffer?
r = GPIB.Recv(addr, 256)    'set r to number of points
GPIB.send "TRCA?1,0," + Format(r), addr   'sends commands for buffer (channel 1, 0(from start), total in buffer)
j = GPIB.Recv(addr, 256) 'receives the whole buffer
b = InStr(1, j, ",") 'number of char until the comma

ReDim tdata(0 To r - 1)
ReDim sdata(0 To r - 1)

For d = 0 To r - 1

    inbuf = Left(j, b - 1)  'take the front point
    e = Right(j, Len(j))    'cut out the front point

'Scan through the 20 char buffer (one point) and
    'separate mantissa from exponent
    m1 = -1
    m2 = -1
    success = True
    For a = 1 To 20
        If Mid(inbuf, a, 1) = "e" Then m1 = a
        If Mid(inbuf, a, 1) = vbLf Then m2 = a: GoTo fin
        If a = Len(inbuf) Then m2 = a + 1: GoTo fin
    Next a
fin:
    If (m1 > -1 And m2 > -1) Then
        mantissa = Val(Mid(inbuf, 1, (m1 - 1)))
        exponent = Val(Mid(inbuf, (m1 + 1), (m2 - (m1 + 1))))
        valu = mantissa * (10 ^ exponent)
    ElseIf (m1 = -1 And m2 > -1) Then
        valu = Val(Mid(inbuf, 1, (m2 - 1)))
    ElseIf (m2 = -1) Then
        success = False
    End If
    j = e
    tdata(d) = valu
    sdata(d) = d
    'Print #1, valu
Next d
'makedata tdata(), sdata()
'GPIB.send "REST", 6
Close #1

End Function
Public Function makedata(tdata As Integer, sdata As Integer)

End Function
Public Function SRS830_Trigger(addr As Integer)
    GPIB.send "TRIG", addr
End Function

Public Function SRS830_AutoPhase(addr As Integer)
    GPIB.send "APHS", addr
End Function

Public Function SRS830_ReadXY(addr As Integer, ByRef readtime, ByRef success As Boolean, ByRef X, ByRef Y) As Double

    Dim inbuf As String
    Dim strng As String
    Dim DidItWork As Boolean
    
    'Request the value of Channels 1 and 2 on the lockin at the same time
    strng = "SNAP?1,2"

    DidItWork = False
    GPIB.send strng, addr, DidItWork
    readtime = Timer
    If DidItWork = False Then success = False: GoTo ext
    
    'Read Response
    DidItWork = False
    inbuf = GPIB.Recv(addr, 256, DidItWork)
    If DidItWork = False Then success = False: GoTo ext

    'Split Response at comma
    s = split_delimited_string(inbuf, ",", Out)
    in1 = Out(0)
    in2 = Out(1)
    
    If s = True Then
    
        inbuf = in1
    
        'Scan through the 20 char buffer and
        'separate mantissa from exponent
        m1 = -1
        m2 = -1
        success = True
        For a = 1 To 20
            If Mid(inbuf, a, 1) = "e" Then m1 = a
            If Mid(inbuf, a, 1) = vbLf Then m2 = a: GoTo fin
            If a = Len(inbuf) Then m2 = a + 1: GoTo fin
        Next a
fin:
        If (m1 > -1 And m2 > -1) Then
            mantissa = Val(Mid(inbuf, 1, (m1 - 1)))
            exponent = Val(Mid(inbuf, (m1 + 1), (m2 - (m1 + 1))))
            valu = mantissa * (10 ^ exponent)
        ElseIf (m1 = -1 And m2 > -1) Then
            valu = Val(Mid(inbuf, 1, (m2 - 1)))
        ElseIf (m2 = -1) Then
            success = False
        End If

        X = valu

        inbuf = in2
    
        'Scan through the 20 char buffer and
        'separate mantissa from exponent
        m1 = -1
        m2 = -1
        For a = 1 To 20
            If Mid(inbuf, a, 1) = "e" Then m1 = a
            If Mid(inbuf, a, 1) = vbLf Then m2 = a: GoTo fin2
            If a = Len(inbuf) Then m2 = a + 1: GoTo fin2
        Next a
fin2:
        If (m1 > -1 And m2 > -1) Then
            mantissa = Val(Mid(inbuf, 1, (m1 - 1)))
            exponent = Val(Mid(inbuf, (m1 + 1), (m2 - (m1 + 1))))
            valu = mantissa * (10 ^ exponent)
        ElseIf (m1 = -1 And m2 > -1) Then
            valu = Val(Mid(inbuf, 1, (m2 - 1)))
        ElseIf (m2 = -1) Then
            success = False
        End If

        Y = valu

    Else
        success = False
    End If
    
ext:

End Function


Private Function GetFullScale(V As Integer, voltage As Boolean)

    'voltage = true for full scale in voltage or false for full scale in current

    If V = 0 Then f = 0.000000002
    If V = 1 Then f = 0.000000005
    If V = 2 Then f = 0.00000001
    If V = 3 Then f = 0.00000002
    If V = 4 Then f = 0.00000005
    If V = 5 Then f = 0.0000001
    If V = 6 Then f = 0.0000002
    If V = 7 Then f = 0.0000005
    If V = 8 Then f = 0.000001
    If V = 9 Then f = 0.000002
    If V = 10 Then f = 0.000005
    If V = 11 Then f = 0.00001
    If V = 12 Then f = 0.00002
    If V = 13 Then f = 0.00005
    If V = 14 Then f = 0.0001
    If V = 15 Then f = 0.0002
    If V = 16 Then f = 0.0005
    If V = 17 Then f = 0.001
    If V = 18 Then f = 0.002
    If V = 19 Then f = 0.005
    If V = 20 Then f = 0.01
    If V = 21 Then f = 0.02
    If V = 22 Then f = 0.05
    If V = 23 Then f = 0.1
    If V = 24 Then f = 0.2
    If V = 25 Then f = 0.5
    If V = 26 Then f = 1
    
    If voltage = False Then f = f * 0.000001
    
    GetFullScale = f
    
End Function
