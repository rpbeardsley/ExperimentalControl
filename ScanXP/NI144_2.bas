Attribute VB_Name = "NI144_2"
'Main High-Level calls

Public Type abuf
    dat(0 To 5000) As Integer
End Type

Private BOARDID As Integer
Dim devlist() As Integer
Dim devaddrlist() As Integer
Dim numdevs As Integer

Public Sub NI144_GPIB_Init()

    BOARDID = 0
    
    Dim devlist(0 To 0)
    Dim devaddrlist(0 To 0)
    numdevs = 0

End Sub

Public Function NI144_GPIB_Send(dat As String, addr As Integer, success As Boolean)
    
    Dim DidItWork As Boolean
    Dim Dev As Integer
    
    DidItWork = False

    Dev = GetDev(addr, DidItWork)
    
    dat = dat + vbLf
    
    If DidItWork = True Then
        ilwrt Dev, dat, Len(dat)
        If (ibsta And EERR) Then DidItWork = False
    End If
        
    success = DidItWork

End Function

Public Function NI144_Recv_Integer_Array(addr As Integer, count As Long, ByRef outputarray, Optional success As Boolean)

    Dim Dev As Integer
    Dim DidItWork As Boolean
    Dim buff As Integer
    
    Dim arr() As Integer
    
    ReDim arr(0 To count - 1)
    
    Dev = GetDev(addr, DidItWork)
    
    For b = 0 To count - 1
        a = VBIB32.ibrd32(Dev, buff, 2) 'get the signal data from the chosen channel
        arr(b) = buff
    Next

    outputarray = arr

End Function

Public Function NI144_GPIB_RecvData(addr As Integer, nbytes As Integer, success As Boolean) As String

    Dim buff As String
    Dim Dev As Integer
    Dim DidItWork As Boolean

    Dev = GetDev(addr, DidItWork)
    
    If DidItWork = True Then
        buff = String(nbytes, " ")
        ilrd Dev, buff, Len(buff)
        If (ibsta And EERR) Then DidItWork = False
    End If
    
    If DidItWork = True Then
        buff = Mid(buff, 1, ibcntl)
        If Right(buff, 1) = vbLf Then buff = Mid(buff, 1, Len(buff) - 1)
        If Right(buff, 1) = vbCr Then buff = Mid(buff, 1, Len(buff) - 1)
        NI144_GPIB_RecvData = buff
        success = True
    Else
        success = False
    End If

    
End Function

Public Function NI144_GPIB_ResetDevice(addr As Integer)

    Dim Dev As Integer
    Dim success As Boolean

    'Clear device
    Dev = GetDev(addr, success)
    If success = True Then Call ibclr(Dev)


End Function

Public Function NI144_GPIB_GET(addr As Integer)

    Dim Dev As Integer
    Dim success As Boolean

    'Trigger device
    Dev = GetDev(addr, success)
    If success = True Then Call ibtrg(Dev)

End Function

Public Function NI144_GPIB_Serial_Poll_Single(addr As Integer) As Integer

    Dim result As Integer
    Dim Dev As Integer
    Dim success As Boolean
    
    Dev = GetDev(addr, success)

    If success = True Then
        Call ibrsp(Dev, result)
        'NI144_SERIAL_POLL_SINGLE = result
        NI144_GPIB_Serial_Poll_Single = result
    End If

End Function

Public Sub Cleanup()

    Call UnregisterDevs

End Sub


'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Lower level calls

Private Function GetDev(addr As Integer, success As Boolean)

    Dim hDev As Integer

    hDev = 0
    found = 0
    For a = 0 To numdevs - 1
        If devaddrlist(a) = addr Then hDev = devlist(a): found = 1
    Next a

    If found < 1 Then
        'Initialise device and add to list
        hDev = ildev(BOARDID, addr, 0, T1s, 1, 0)
        ilclr hDev
        If (ibsta And EERR) Then
            success = False
        Else
            success = True
            ReDim Preserve devaddrlist(0 To numdevs)
            ReDim Preserve devlist(0 To numdevs)
            devaddrlist(numdevs) = addr
            devlist(numdevs) = hDev
            numdevs = numdevs + 1
        End If
    Else
        success = True
    End If
    
    GetDev = hDev
    
End Function

Public Function UnregisterDevs()

'Take devices offline
Dim hDev As Integer

    For a = 0 To numdevs - 1
        hDev = devlist(a)
        ilonl Dev, 0
    Next a
    
    numdevs = 0
    ReDim devlist(0 To 0)
    ReDim devaddrlist(0 To 0)

End Function
