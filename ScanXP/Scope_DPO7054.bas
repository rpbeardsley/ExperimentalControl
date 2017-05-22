Attribute VB_Name = "Scope_DPO7054"
Private Dev As String
Private a As Variant

Public Function Query(cma As String, gpibaddress As Integer) As String
    a = GPIB.send(cma, gpibaddress, True)
    Query = GPIB.Recv(gpibaddress, 256, True)
End Function

Public Function WriteString(cma As String, gpibaddress As Integer) As String
    a = GPIB.send(cma, gpibaddress, True)
End Function

Public Function ReadPartialString(gpibaddress As Integer, nbytes As Integer)
    ReadPartialString = GPIB.Recv(gpibaddress, nbytes, True)
End Function

Public Function DPO_Scope_GetTriggerState(addr As Integer) As String

    DPO_Scope_GetTriggerState = Scope_DPO7054.Query("TRIG:STATE?", addr)

End Function

Public Sub DPO_Scope_WaitForReadyToTrigger(addr As Integer)

    
        readytotrigger = False
        Pause (0.1)
        
        Do While readytotrigger = False
            ret = Scope_DPO7054.Query("TRIG:STATE?", addr)
            If Left(ret, 5) = "READY" Then readytotrigger = True
            Pause (0.1)
        Loop

End Sub

Public Function DPO_ScopeTrace(tdata, sdata, addr As Integer, Optional channel As Integer = 1)
    
    Dim strng As String
    
    'StrRecLen = "2000"
    'SetReclen = Scope_DPO7054.WriteString("HORIZONTAL:RECORDLENGTH " + StrRecLen, addr)
    reclen = Scope_DPO7054.Query("HORIZONTAL:RECORDLENGTH?", addr) 'get thge record length
    'DataFormat = Scope_DPO7054.WriteString("WFMOUTPRE:PT_Fmt Y", addr)  'specify the data format
    strng = "DATA:SOURCE CH" + Format(channel)
    ch = Scope_DPO7054.WriteString(strng, addr) 'specify the channel to record
        
    'get scope parameters for scaling
    Xzero = Scope_DPO7054.Query("WFMOUTPRE:XZero?", addr)
    XIncr = Scope_DPO7054.Query("WFMOUTPRE:XIncr?", addr)
    XTriggerPoint = Scope_DPO7054.Query("WFMOUTPRE:PT_OFF?", addr)
    
    YZeroS = Scope_DPO7054.Query("WFMOUTPRE:YZero?", addr)
    YMultS = Scope_DPO7054.Query("WFMOUTPRE:YMult?", addr)
    YOffS = Scope_DPO7054.Query("WFMOUTPRE:YOff?", addr)
        
    datwidth = Scope_DPO7054.Query("WFMOutpre:BYT_Nr?", addr)

        
    Call Scope_DPO7054.WriteString("DATA:STOP 100000000", addr)
    Call Scope_DPO7054.WriteString("DATA:START 1", addr)
    'deserts = Scope_DPO7054.Query("DATA:START?", addr)
    a = Scope_DPO7054.WriteString("Curve?", addr)
    
    'throw away data block preamble
    atr = Scope_DPO7054.ReadPartialString(addr, 2)
    n = Val(Mid(atr, 2))
    numbytestoread = Scope_DPO7054.ReadPartialString(addr, CInt(n))
    separator = Scope_DPO7054.ReadPartialString(addr, 1)
    'Call ibrd32(Dev, rawdat, reclen * 2) 'get the signal data from the chosen channel
    
    If datwidth <> 2 Then
        MsgBox "Data Width is Not 2 Bytes - see WFMOutpre:BYT_NR", vbOKOnly Or vbExclamation, "Error"
        GoTo ext
    End If
    
    If Val(numbytestoread) / Val(datwidth) <> reclen Then
        MsgBox "Scope Not Sending RecLen Number of Records.", vbOKOnly Or vbExclamation, "Error"
        GoTo ext
    End If
    
    
    Call GPIB.RecvIntegerArray(addr, CLng(reclen), dat)

    ReDim sdata(1 To reclen) As Double
    ReDim tdata(1 To reclen) As Double
          
    For H = 1 To reclen
        sdata(H) = YZeroS + YMultS * (dat(H - 1) - YOffS)
        tdata(H) = Xzero + XIncr * (H - 1 - XTriggerPoint)
    Next H
    
ext:
    
End Function

Public Function Acquire(State As Integer, address As Integer)
    
    'Aquire on = 1, Aquire off = 0
    
    If State = 1 Then
        Aqu = Scope_DPO7054.WriteString("ACQUIRE:STATE ON", address)
    Else
        Aqu = Scope_DPO7054.WriteString("ACQUIRE:STATE OFF", address)
    End If
    
End Function

Public Function DPO_ScopeAverageTrace(tdata, sdata, addr As Integer, Averages As Single)
    
    NumAv = Str(Averages)
    
    StopAquire = Scope_DPO7054.Acquire(0, addr)
    NumAverages = Scope_DPO7054.WriteString("ACQUIRE:NUMAVG " & NumAv, addr)
    StopAfterAvs = Scope_DPO7054.WriteString("ACQUIRE:STOPAFTER SEQUENCE", addr)
    StartAquire = Scope_DPO7054.Acquire(1, addr)
    WaitForData = Scope_DPO7054.WaitForAcquisition(addr)
    dat = Scope_DPO7054.DPO_ScopeTrace(tdata, sdata, addr)
    
    
    
End Function

Public Sub DPO_StopAcquisition(address As Integer)

    Scope_DPO7054.WriteString "ACQUIRE:STATE OFF", address

End Sub

Public Sub SetTriggerType(address As Integer)

    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:SOURCE CH1", address 'set the source of transition to channel 1
    Scope_DPO7054.WriteString "TRIGGER:A:TYPE PULSE", address       'set the trigger type to a pulse trigger
    Scope_DPO7054.WriteString "TRIGGER:A:MODE NORMAL", address
    
End Sub

Public Sub SetHorizontalScale(address As Integer)

    Scope_DPO7054.WriteString "HORIZONTAL:MAIN:SAMPLERATE 2E3", address
    Scope_DPO7054.WriteString "HORIZONTAL:RECORDLENGTH 10000", address
    
End Sub

Public Sub SetPulseTriggerSubType(address As Integer)

    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:CLASS TRANSITION", address 'Set tigger to transition A event

End Sub

Public Sub SetupTransitiontrigger(address As Integer)

    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:TRANSITION:DELTATIME 500E-12", address   'set the transition time to 500ps
    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:TRANSITION:POLARITY NEGATIVE", address   'set slope to negative
    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:TRANSITION:QUALIFY OCCURS", address      'set trigger if violation occurs
    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:TRANSITION:THRESHOLD:HIGH 2.58", address 'set upper level to 2.58v
    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:TRANSITION:THRESHOLD:LOW 2.46", address  'set lower limit to 2.46v
    Scope_DPO7054.WriteString "TRIGGER:A:PULSE:TRANSITION:WHEN FASTERTHAN", address     'set transition to less than
    
End Sub

Public Function WaitForAcquisition(address As Integer)
        
        scopebusy = True
        Pause (0.1)
        
        Do While Scope_DPO7054.Query("Busy?", address) = 1
            Pause (0.1)
        Loop
        
        'AquOff = Scope_DPO7054.WriteString("ACQUIRE:STATE OFF", address)
        
End Function
Sub WaitScope(address As Integer)
        
        scopebusy = True
        
        Do While Scope_DPO7054.Query("Busy?", address) = 1
            Pause (0.5)
        Loop
        
End Sub

