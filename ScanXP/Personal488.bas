Attribute VB_Name = "Personal488"
Dim Termin As TermT
Dim devlist() As Integer
Dim devaddrlist() As Integer
Dim numdevs As Integer

Public Sub Personal488Init()

    'Terminator structure
    Termin.eoi = 1
    Termin.EightBits = 1
    Termin.nChar = 2
    Termin.Term1 = 10
    Termin.Term2 = 13

End Sub

Public Function Personal488Send(addr As Integer, dat As String, success As Boolean)

    Dim hIEEEDev As Long
    Dim comps As Long
    Dim DidItWork As Boolean
    
    comps = 1
    success = False
        
    hIEEEDev = GetDev(addr, DidItWork)
    
    If DidItWork = False Then
       MsgBox ("Personal488 can't create GPIB device")
       success = False
    Else
        'Personal488Send = IOTIEEE.OutputXdll(hIEEEDev, ByVal dat, Len(dat), 1, 1, Termin, 0, comps)
         ret = IOTIEEE.Output(hIEEEDev, dat + vbLf)
         If ret > -1 Then success = True
    End If
    

End Function


Public Function Personal488Recv(addr As Integer, nbytes As Integer, success As Boolean) As String
    
    Dim hIEEEDev As Long
    Dim compr As Long
    Dim buffer As String
    Dim status As Integer
    Dim DidItWork As Boolean
    Dim outp As String
    
    compr = 1
    success = False
    
    hIEEEDev = GetDev(addr, DidItWork)
    
    If DidItWork = False Then
       MsgBox ("Personal488 can't create GPIB device")
       success = False
    Else
        'buffer = String(nbytes, " ")
        'status = IOTIEEE.EnterXdll(hIEEEDev, buffer, Len(buffer), 1, Termin, 0, compr)
        'IOTIEEE.enter hIEEEDev, buffer
        
        buffer = ""
        For a = 1 To nbytes
            outp = " "
            IOTIEEE.EnterN hIEEEDev, outp, 1
            If outp = vbLf Then success = True: Personal488Recv = buffer: GoTo fin
            buffer = buffer + outp
        Next a
        
    End If
        
fin:
        
End Function

Public Function Personal488Trigger(addr As Integer)

    Dim hIEEEDev As Long
    Dim DidItWork As Boolean

    hIEEEDev = GetDev(addr, DidItWork)
    
    If DidItWork = True Then
        IOTIEEE.Trigger hIEEEDev
    End If

End Function

'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'Lower level calls

Private Function GetDev(addr As Integer, success As Boolean)

    Dim hDev As Long
    Dim namestring As String

    hDev = -1
    found = 0
    For a = 0 To numdevs - 1
        If devaddrlist(a) = addr Then hDev = devlist(a): found = 1
    Next a

    If found < 1 Then
        'Initialise device and add to list
        namestring = "New" + Format(numdevs)
        hDev = IOTIEEE.MakeNewDevice("IEEE0", namestring, addr, 255, Termin, Termin, 100)
        
        If (hDev = -1) Then
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

Private Function UnregisterDevs()

'Take devices offline
Dim hDev As Integer

    For a = 0 To numdevs - 1
        hDev = devlist(a)
        IOTIEEE.ioClose (hDev)
        IOTIEEE.RemoveDevice (hDev)
    Next a
    
    numdevs = 0
    ReDim devlist(0 To 0)
    ReDim devaddrlist(0 To 0)

End Function

Public Sub Cleanup()

    Call UnregisterDevs

End Sub
