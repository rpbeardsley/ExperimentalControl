Attribute VB_Name = "SR510"
Public Function SR510_SetBandpassFilter(addr As Integer, n As Integer)

    'n=0 : Filter out
    'n=1 : Filter in

    If n = 0 Or n = 1 Then
        If SR510_GPIB_OR_RS232 = "GPIB" Then
            GPIB.send "B " + Mid(Str(phas), 2), addr
        Else
            SR510_RS232_Send "B" + Mid(Str(phas), 2)
        End If
    End If

End Function

Public Function SR510_GetBandpassFilter(addr As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "B"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "Out"
    If indx = 1 Then s = "In"
    
   SR510_GetBandpassFilter = s

End Function

Public Function SR510_SetHarmonicNum(addr As Integer, n As Integer)

    'n=0 : Reference mode f
    'n=1 : Reference mode 2f

    If n = 0 Or n = 1 Then
        GPIB.send "M " + Mid(Str(phas), 2), addr
    End If

End Function

Public Function SR510_GetHarmonicNum(addr As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "M"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "f"
    If indx = 1 Then s = "2f"
    
   SR510_GetHarmonicNum = s

End Function


Public Function SR510_GetPreAmpStatus(addr As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "H"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "Not Connected"
    If indx = 1 Then s = "Connected"
    
    SR510_GetPreAmpStatus = s

End Function

Public Function SR510_SetLocal(addr As Integer)

    GPIB.send "I 0", addr

End Function

Public Function SR510_SetRemote(addr As Integer)

    GPIB.send "I 1", addr

End Function

Public Function SR510_SetLockout(addr As Integer)

    GPIB.send "I 2", addr

End Function

Public Function SR510_SetPhase(phas, addr As Integer)

    GPIB.send "P " + Mid(Str(phas), 2), addr

End Function

Public Function SR510_GetPhase(addr As Integer) As Single

    Dim inbuf As String
    Dim strng As String
    
    'Request phase
    strng = "P"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    SR510_GetPhase = CSng(Val(inbuf))

End Function

Public Function SR510_GetRefFreq(addr As Integer) As Single

    Dim inbuf As String
    Dim strng As String
    
    'Request phase
    strng = "F"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    SR510_GetRefFreq = CSng(Val(inbuf))

End Function


Public Function SR510_SetExtTriggerMode(addr As Integer, n As Integer)

    '0=Positive
    '1=Symmetric
    '2=Negative
    
    'NB Numbers are different from SRS830

    If (n >= 0 And n < 3) Then
        GPIB.send "R " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid external-trigger reference-mode option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SR510_GetExtTriggerMode(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "R"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "+ve"
    If indx = 1 Then s = "Symmetric"
    If indx = 2 Then s = "-ve Edge"
    
    SR510_GetExtTriggerMode = s

End Function


Public Function SR510_SetReserveMode(addr As Integer, n As Integer)

    If (n >= 0 And n < 3) Then
        GPIB.send "D " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid reserve mode option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SR510_GetReserveMode(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    'Request trigger mode index number
    strng = "D"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = CInt(inbuf)
    
    If indx = 0 Then s = "Low"
    If indx = 1 Then s = "Normal"
    If indx = 2 Then s = "High"
    
    SR510_GetReserveMode = s

End Function

Public Function SR510_SetInputLineNotchFilter(addr As Integer, n As Integer)

    '0=out
    '1=1x in
    '2=2x in
    '3=Both in
    
    If n = 0 Then
        GPIB.send "L 1,0", addr
        GPIB.send "L 2,0", addr
    ElseIf n = 1 Then
        GPIB.send "L 1,1", addr
        GPIB.send "L 2,0", addr
    ElseIf n = 2 Then
        GPIB.send "L 1,0", addr
        GPIB.send "L 2,1", addr
    ElseIf n = 3 Then
        GPIB.send "L 1,1", addr
        GPIB.send "L 2,1", addr
    Else
        MsgBox "Invalid input line notch filter mode option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SR510_GetInputLineNotchFilter(addr As Integer, indx As Integer) As String

    Dim inbuf As String
    Dim strng As String
    
    indx = 0
    
    'Request 1x filter status
    strng = "L 1"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = indx + CInt(inbuf)
      
    'Request 2x filter status
    strng = "L 1"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    indx = indx + 2 * CInt(inbuf)
        
    If indx = 0 Then s = "Out"
    If indx = 1 Then s = "Line Notch In"
    If indx = 2 Then s = "2x Line Notch In"
    If indx = 3 Then s = "1x and 2x Line Notch In"
    
    SR510_GetInputLineNotchFilter = s

End Function

Public Function SR510_SetTimeConstant(addr As Integer, n As Integer)

    If (n >= 1 And n < 12) Then
        GPIB.send "T 1," + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid time constant option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SR510_SetPostTimeConstant(addr As Integer, n As Integer)

    If (n >= 0 And n < 3) Then
        GPIB.send "T 2," + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid time constant option number.", vbExclamation, "Lockin Control Error"
    End If

End Function


Public Function SR510_GetTimeConstant(addr As Integer, indx As Integer) As Double

    Dim inbuf As String
    Dim strng As String
    
    'Request time constant
    strng = "T 1"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    
    a = Val(inbuf)
    If a = 1 Then tc = 0.001
    If a = 2 Then tc = 0.003
    If a = 3 Then tc = 0.01
    If a = 4 Then tc = 0.03
    If a = 5 Then tc = 0.1
    If a = 6 Then tc = 0.3
    If a = 7 Then tc = 1
    If a = 8 Then tc = 3
    If a = 9 Then tc = 10
    If a = 10 Then tc = 30
    If a = 11 Then tc = 100
    
    indx = a
    SR510_GetTimeConstant = tc

End Function

Public Function SR510_GetPostTimeConstant(addr As Integer, indx As Integer) As Double

    Dim inbuf As String
    Dim strng As String
    
    'Request time constant
    strng = "T 2"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    
    a = Val(inbuf)
    If a = 0 Then tc = 0
    If a = 1 Then tc = 0.1
    If a = 2 Then tc = 1
    
    indx = a
    SR510_GetPostTimeConstant = tc

End Function

Public Function SR510_SetSensitivity(addr As Integer, n As Integer)

    If (n >= 1 And n < 25) Then
        GPIB.send "G " + Mid(Str(n), 2), addr
    Else
        MsgBox "Invalid sensitivity option number.", vbExclamation, "Lockin Control Error"
    End If

End Function

Public Function SR510_GetSensitivity(addr As Integer, indx As Integer, Optional VoltageOrCurrent As Integer = 0) As Double

    'Get sensitivity.
    'If VoltageOrCurrent = 0 then sensitivity is returned in
    'voltage units, otherwise it is in current units.
    'Default is voltage units

    Dim inbuf As String
    Dim strng As String
    Dim a As Integer
    Dim b As Boolean
    
    'Request time constant
    strng = "G"
    GPIB.send strng, addr
    
    'Read Response
    inbuf = GPIB.Recv(addr, 256)
    
    a = Val(inbuf)
    
    If a = 1 Then sens = 0.00000001
    If a = 2 Then sens = 0.00000002
    If a = 3 Then sens = 0.00000005
    If a = 4 Then sens = 0.0000001
    If a = 5 Then sens = 0.0000002
    If a = 6 Then sens = 0.0000005
    If a = 7 Then sens = 0.000001
    If a = 8 Then sens = 0.000002
    If a = 9 Then sens = 0.000005
    If a = 10 Then sens = 0.00001
    If a = 11 Then sens = 0.00002
    If a = 12 Then sens = 0.00005
    If a = 13 Then sens = 0.0001
    If a = 14 Then sens = 0.0002
    If a = 15 Then sens = 0.0005
    If a = 16 Then sens = 0.001
    If a = 17 Then sens = 0.002
    If a = 18 Then sens = 0.005
    If a = 19 Then sens = 0.01
    If a = 20 Then sens = 0.02
    If a = 21 Then sens = 0.05
    If a = 22 Then sens = 0.1
    If a = 23 Then sens = 0.2
    If a = 24 Then sens = 0.5
    
    SR510_GetSensitivity = sens

End Function

Public Function SR510_SetAuxVoltage(addr As Integer, channel As Integer, voltage As Double, Optional success As Boolean = False)

    Dim s As String
    Dim DidItWork As Boolean
    success = False
    DidItWork = False

    If channel = 5 Then
        s = "X 5," & Format(voltage, "#0.00#")
        GPIB.send s, addr, DidItWork
    ElseIf channel = 6 Then
        s = "X 6," & Format(voltage, "#0.00#")
        GPIB.send s, addr, DidItWork
    Else
        MsgBox "Invalid Auxiliary Voltage Channel Index", vbExclamation, "Lockin communications error"
    End If
    
    If DidItWork = True Then success = True
    
End Function

Public Function SR510_GetAuxVoltage(addr As Integer, channel As Integer, Optional success As Boolean = False) As Single

    Dim inbuf As String
    Dim strng As String
    Dim DidItWork As Boolean
    
    DidItWork = False
    success = False
    
    'Request phase
    If channel > 0 And channel < 7 Then
        strng = "X " + Format(channel)
        GPIB.send strng, addr, DidItWork
    End If
    
    
    If DidItWork = True Then
    
        'Read Response
        DidItWork = False
        If channel = 1 Or channel = 2 Then
            inbuf = GPIB.Recv(addr, 256, DidItWork)
            If DidItWork = True Then
                SR510_GetAuxVoltage = CSng(Val(inbuf))
                success = True
            Else
                MsgBox "Error receiving auxiliary voltage from SRS830", vbExclamation, "Lockin Communications Error"
            End If
        End If
        
    Else
        MsgBox "Error sending request for auxiliary voltage to SRS830", vbExclamation, "Lockin Communications Error"
    End If

End Function


Public Function SR510_ReadX(addr As Integer, ByRef readtime, ByRef success As Boolean) As Double

    Dim inbuf As String
    Dim strng As String
    Dim DidItWork As Boolean
    
    DidItWork = False
    
    If SR510_GPIB_OR_RS232 = "GPIB" Then
            GPIB.send "S0", addr, DidItWork
        Else
            SR510_RS232_Send "S0"
    End If
        
    If SR510_GPIB_OR_RS232 = "GPIB" Then
            GPIB.send "Q", addr, DidItWork
        Else
            SR510_RS232_Send "Q"
    End If
    readtime = Timer
    
    'Read Response
    If SR510_GPIB_OR_RS232 = "GPIB" Then
        inbuf = GPIB.Recv(addr, 256, DidItWork)
    Else
        inbuf = SR510_RS232_Recv(DidItWork)
    End If
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

    SR510_ReadX = valu
    
ext:

End Function

Public Function SR510_RS232_Send(strng As String)

    RS232.MSComm1.CommPort = 1
    RS232.MSComm1.DTREnable = True
    RS232.MSComm1.EOFEnable = False
    RS232.MSComm1.Settings = "19200,O,8,2"
    RS232.MSComm1.Handshaking = comXOnXoff
    RS232.MSComm1.RThreshold = 0 'Do not generate OnComm event when characters arrive
    RS232.MSComm1.InputLen = 0 'Read whole buffer each time input is queried
    RS232.MSComm1.RTSEnable = False
    
    RS232.MSComm1.PortOpen = True
    
    RS232.MSComm1.Output = strng + vbCr
    
    RS232.MSComm1.PortOpen = False

End Function

Public Function SR510_RS232_Recv(Optional success As Boolean = False) As String

    timout = 1
    
    RS232.MSComm1.CommPort = 1
    RS232.MSComm1.DTREnable = True
    RS232.MSComm1.EOFEnable = False
    RS232.MSComm1.Settings = "19200,O,8,2"
    RS232.MSComm1.Handshaking = comXOnXoff
    RS232.MSComm1.RThreshold = 0 'Do not generate OnComm event when characters arrive
    RS232.MSComm1.InputLen = 0 'Read whole buffer each time input is queried
    RS232.MSComm1.RTSEnable = False
    
    RS232.MSComm1.PortOpen = True
    
    t = Timer + timout
    stat = -2
    buff = ""
    While stat = -2
    
        If Timer > t Then stat = -1
        
        If RS232.MSComm1.InBufferCount > 0 Then
            tmpbuff = RS232.MSComm1.Input
            
            'Stop checking when we get carriage return character
            For a = 1 To Len(tmpbuff)
                If Asc(Mid(tmpbuff, a, 1)) = 13 Then
                    buff = buff + Mid(tmpbuff, 1, a - 1)
                    stat = Len(buff)
                    GoTo nxt
                End If
            Next a
            
            If stat < 0 Then buff = buff + tmpbuff
nxt:
        End If
        
        DoEvents
        
    Wend
    
    RS232.MSComm1.PortOpen = False
    
    If stat > -1 Then
        SR510_RS232_Recv = buff
        success = True
    Else
        SR510_RS232_Recv = ""
        success = False
    End If
        

End Function
