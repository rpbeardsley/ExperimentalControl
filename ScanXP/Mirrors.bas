Attribute VB_Name = "Mirrors"
Private busy As Boolean

Public Function MoveXMirror(pos) As Integer
'0 = OK
'1 = Fail
'2 = Busy

    'Positions between -4.5 and 4.5 mm
    
    If busy = True Then MoveXMirror = 2: GoTo ext
    
    Dim voltage As Double
    Dim addr As Integer
    Dim DidItWork As Boolean
    addr = MIRROR_LOCKIN_ADDR

    voltage = pos / MIRROR_DISTANCE_TO_VOLTAGE_RATIO
    If Abs(voltage) > 10 Then
        MsgBox ("Invalid Mirror X Position")
        MoveXMirror = 1
    Else
        busy = True
        Pause (0.05)
        SRS830.SRS830_SetAuxVoltage addr, 1, voltage, DidItWork
        busy = False
        MoveXMirror = CInt(DidItWork) + 1
    End If

ext:
End Function

Public Function MoveYMirror(pos) As Integer
'0 = OK
'1 = Fail
'2 = Busy

    'Positions between -4.5 and 4.5 mm
    
    Dim voltage As Double
    Dim addr As Integer
    Dim DidItWork As Boolean
    
    If busy = True Then MoveYMirror = 2: GoTo ext
    
    addr = MIRROR_LOCKIN_ADDR
    voltage = pos / MIRROR_DISTANCE_TO_VOLTAGE_RATIO
    If Abs(voltage) > 10 Then
        MsgBox ("Invalid Mirror Y Position")
        MoveYMirror = 1
    Else
        busy = True
        Pause (0.05)
        SRS830.SRS830_SetAuxVoltage addr, 2, voltage, DidItWork
        busy = False
        MoveYMirror = CInt(DidItWork) + 1
    End If

ext:
End Function

Public Function GetXMirrorPos(status As Integer) As Single
'Status:

    Dim addr As Integer
    Dim DidItWork As Boolean
    
    If busy = True Then status = 2: GoTo ext

    addr = MIRROR_LOCKIN_ADDR
    busy = True
    Pause (0.05)
    V = SRS830.SRS830_GetAuxVoltage(addr, 1, DidItWork)
    busy = False
    status = CInt(DidItWork) + 1
    
    If DidItWork = True Then
        GetXMirrorPos = V * MIRROR_DISTANCE_TO_VOLTAGE_RATIO
    End If
    
ext:
End Function

Public Function GetYMirrorPos(status As Integer) As Single

    Dim addr As Integer
    Dim DidItWork As Boolean

    If busy = True Then status = 2: GoTo ext

    addr = MIRROR_LOCKIN_ADDR
    busy = True
    Pause (0.05)
    V = SRS830.SRS830_GetAuxVoltage(addr, 2, DidItWork)
    busy = False
    status = CInt(DidItWork) + 1
    
    If DidItWork = True Then
        GetYMirrorPos = V * MIRROR_DISTANCE_TO_VOLTAGE_RATIO
    End If
    
ext:
End Function

Public Function Init()

    Dim status As Integer

    CurrentMirrorX = GetXMirrorPos(status)
    If status = 0 Then CurrentMirrorY = GetYMirrorPos(status)

    If (status = 1 Or status = 2) Then
        MsgBox "Error getting mirror positions.", vbExclamation, "Mirror Error"
        CurrentMirrorX = 0
        CurrentMirrorY = 0
    End If

    MirrorCentreX = CurrentMirrorX
    MirrorCentreY = CurrentMirrorY

    
End Function
