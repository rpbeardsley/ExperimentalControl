Attribute VB_Name = "BiasSwitch"
Public bias_direction As Integer

'Bias direction - 0 for reverse, 1 for forward bias

Public Function SetBias(direction As Integer, Optional success As Boolean = True)

    Dim DidItWork As Boolean

    success = True

    If direction = 0 Or direction = 1 Then

        If direction <> bias_direction Then
            GPIB.Send "AID" + Mid(Str(BIASSWITCH_SECONDARY_ADDR), 2) + ";C " + Format$(direction, "0"), BIASSWITCH_PRIMARY_ADDR, DidItWork
            If DidItWork = False Then BiasError ("Switching Operation Failed - Cannot send command"): success = False: GoTo ext
            Pause (0.1)
            GetSwitchPosition (DidItWork)
            If DidItWork = False Then
                success = False
            ElseIf bias_direction <> direction Then
                BiasError ("Switching Operation Failed - Device did not switch."): success = False
            End If
        End If

    End If

ext:

End Function

Public Function FlipBias(Optional success As Boolean = False)

        If bias_direction = 1 Then direction = 0
        If bias_direction = 0 Then direction = 1
        
        SetBias (direction)

End Function

Public Sub Reset()

    Dim success As Boolean

    GPIB.IFC
    GPIB.ResetDeviceInterface BIASSWITCH_PRIMARY_ADDR
    GPIB.Send "AID" + Mid(Str(BIASSWITCH_SECONDARY_ADDR), 2) + ";R0", BIASSWITCH_PRIMARY_ADDR, success

    If success = False Then MsgBox "Could not reset switch successfully.", vbExclamation, "Switch-box Error"

End Sub

Public Function GetSwitchPosition(success As Boolean) As Integer

    Dim DidItWork As Boolean
    
    success = False

    GPIB.Send "AID" + Mid(Str(BIASSWITCH_SECONDARY_ADDR), 2) + ";D?", BIASSWITCH_PRIMARY_ADDR, DidItWork
    If DidItWork = False Then BiasError ("Could not send command to request current switch state."): GoTo ext
    
    ret = GPIB.Recv(BIASSWITCH_PRIMARY_ADDR, 256, DidItWork)
    If DidItWork = False Then BiasError ("Switch unresponsive when requesting current state."): GoTo ext
    
    For a = Len(ret) To 1 Step -1
        If Mid(ret, a, 1) = " " Then GoTo fin
    Next a
fin:
    If a = Len(ret) Then
        s = "fail"
    Else
        s = Mid(ret, a + 1, Len(ret) - a)
    End If
    
    If Len(s) > 2 Or (Val(s) = 0 And s <> "0") Then
        BiasError ("Error retrieving bias direction.")
    Else
        bias_direction = Val(s)
        GetSwitchPosition = bias_direction
        success = True
    End If
    
ext:
End Function

Private Sub BiasError(s As String)

    ret = MsgBox(s + " Reset Switch Box?", vbCritical Or vbYesNo, "Switch-box Error")
    
    If ret = 6 Then
        Reset
    Else
    End If

End Sub
