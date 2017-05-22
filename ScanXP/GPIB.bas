Attribute VB_Name = "GPIB"
Public Function send(dat As String, addr As Integer, Optional success As Boolean = False)

    Dim DidItWork As Boolean
    Dim status As Integer

    If IEEECARD = 1 Then
        NI144_GPIB_Send dat, addr, DidItWork
        success = DidItWork
    ElseIf IEEECARD = 2 Then
        CEC488.send addr, dat, status
        If status = 0 Then success = True Else success = False
    ElseIf IEEECARD = 3 Then
        Personal488.Personal488Send addr, dat, DidItWork
        success = DidItWork
    End If

End Function

Public Function RecvIntegerArray(addr As Integer, count As Long, ByRef outputarray, Optional success As Boolean = False)

    Dim DidItWork As Boolean
    Dim l As Integer
    Dim status As Integer
    Dim buff As String

    If IEEECARD = 1 Then
        Call NI144_Recv_Integer_Array(addr, count, dat)
        success = DidItWork
    ElseIf IEEECARD = 2 Then

    ElseIf IEEECARD = 3 Then
        
    End If

    outputarray = dat

End Function

Public Function Recv(addr As Integer, nbytes As Integer, Optional success As Boolean = False) As String

    Dim DidItWork As Boolean
    Dim l As Integer
    Dim status As Integer
    Dim buff As String

    If IEEECARD = 1 Then
        Recv = NI144_GPIB_RecvData(addr, nbytes, DidItWork)
        success = DidItWork
    ElseIf IEEECARD = 2 Then
    
        buff = String(nbytes, " ")
        CEC488.enter buff, nbytes, l, addr, status
        
        If status = 0 Then
            success = True
            buff = Mid(buff, 1, l)
            If Right(buff, 1) = vbLf Then buff = Mid(buff, 1, Len(buff) - 1)
            If Right(buff, 1) = vbCr Then buff = Mid(buff, 1, Len(buff) - 1)
            Recv = buff
        Else
            success = False
        End If
    ElseIf IEEECARD = 3 Then
    
        Recv = Personal488.Personal488Recv(addr, nbytes, DidItWork)
        success = DidItWork
        
    End If
    

End Function

Public Sub Init()

    If IEEECARD = 1 Then
        NI144_2.NI144_GPIB_Init
    ElseIf IEEECARD = 2 Then
        CEC488.initialize 21, 0
        CEC488.settimeout (3000)
    End If

End Sub

Public Sub IFC()

    Dim status As Integer
    
    If IEEECARD = 1 Then
'        NI144_2.NI144_GPIB_IFC        -   Not supported in GPIB code
    ElseIf IEEECARD = 2 Then
        CEC488.transmit "IFC", status
    ElseIf IEEECARD = 3 Then
        
    End If

End Sub

Public Function ResetDeviceInterface(addr As Integer)

    Dim status As Integer

    If IEEECARD = 1 Then
        NI144_2.NI144_GPIB_ResetDevice (addr)
    ElseIf IEEECARD = 2 Then
        If addr = 0 Then
            CEC488.transmit "DCL", status
        Else
            'Unlisten all, set selected device to listen, send selected device clear
            CEC488.transmit "UNL LISTEN " + Format(addr) + " SDC", status
        End If
    End If

End Function

Public Function GroupExecuteTrigger(addr As Integer)

Dim status As Integer

If IEEECARD = 1 Then
    NI144_2.NI144_GPIB_GET (addr)
ElseIf IEEECARD = 2 Then
    CEC488.transmit "UNL LISTEN " + Format(addr) + " GET", status
End If

End Function

Public Sub Cleanup()

If IEEECARD = 1 Then
    NI144_2.Cleanup
ElseIf IEEECARD = 3 Then
    Personal488.Cleanup
End If

End Sub

Public Function SerialPollSingleDevice(addr As Integer) As Integer

    Dim poll As Integer
    Dim status As Integer

    If IEEECARD = 1 Then
        SerialPollSingleDevice = NI144_2.NI144_GPIB_Serial_Poll_Single(addr)
    ElseIf IEEECARD = 2 Then
        CEC488.spoll addr, poll, status
        SerialPollSingleDevice = poll
    End If

End Function
