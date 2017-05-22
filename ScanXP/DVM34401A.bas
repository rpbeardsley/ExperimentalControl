Attribute VB_Name = "DVM34401A"
'Module for Hewlett Packard or Agilent 34401A Digital Volt Meter

Public Function DVM34401A_GetSample(addr As Integer) As String
    
    GPIB.send "TRIG:SOUR IMM", addr
    GPIB.send "TRIG:COUN MIN", addr
    GPIB.send "TRIG:DEL MIN", addr
    GPIB.send "SAMP:COUN MIN", addr
    GPIB.send "INIT", addr
    
    'Pause (0.1)

    GPIB.send "FETC?", addr

    inbuf = GPIB.Recv(addr, 256)
    
    DVM34401A_GetSample = inbuf

End Function

Public Function DVM34401A_Read(addr As Integer, OutBuffer, Optional SamplesPerTrigger As Integer = 1, Optional DelayBetweenSamples As Integer = 0, Optional NumTriggersToAccept As Integer = 1, Optional TrigSource As Integer = 2) As Integer

    'Reads one or more values from DVM. With no options just reads one value straight away
    
    'Returns a status integer - 0=success
    '                           1=timeout waiting for data
    '                           2=bad settings given
    '                           3=Nonsense data received
    
    'SamplesPerTrigger - Between 1 and 50000, default is 1
    
    'TrigSource -   1=Trigger from GPIB bus using "*TRG" or GET
    '               2=Trigger from internal source at fastest rate possible
    '               3=Trigger when a pulse comes in to the EXT Trigger connector on the back of the DVM
    
    Dim s As String
    Dim BadSetup As Boolean
    Dim ReturnedValues() As Double
    Dim timeout As Boolean


    GPIB.send "CONF:VOLT:DC DEF, DEF", addr

    'Set trigger source. Default is immediate internal trigger
    If TrigSource = 1 Then
        s = "BUS"
    ElseIf TrigSource = 3 Then
        s = "EXT"
    Else
        s = "IMM"
    End If
    s = "TRIG:SOUR " & s
    GPIB.send s, addr

    'Set number of samples per trigger
    If SamplesPerTrigger > 0 And SamplesPerTrigger < 50001 Then
        s = "SAMP:COUN " + Format(SamplesPerTrigger, "0")
        GPIB.send s, addr
    Else
        BadSetup = True
    End If
    
    'Set the number of triggers to accept before returning to idle state
    If NumTriggersToAccept > 0 And NumTriggersToAccept < 50001 Then
        s = "TRIG:COUN " + Format(NumTriggersToAccept, "0")
        GPIB.send s, addr
    Else
        BadSetup = True
    End If
    
    'Set the trigger delay between 0 and 3600
    If DelayBetweenSamples >= 0 And DelayBetweenSamples < 3601 Then
        s = "TRIG:DEL " + Format(DelayBetweenSamples, "0")
        GPIB.send s, addr
    Else
        BadSetup = True
    End If
    
    If BadSetup = False Then
    
        GPIB.send "INIT", addr
        GPIB.send "FETC?", addr

            'Wait for value to be ready to read
            t = Timer + DelayBetweenSamples * NumTriggersToAccept + 0.1
            timeout = False
            a = 0
            While Timer < t
                DoEvents
            Wend
            inbuf = GPIB.Recv(addr, 256)
            success = ProcResponses(inbuf, resp, n)
            If success = False Then GoTo ext
            For c = 0 To n - 1
                b = b + 1
                ReDim Preserve ReturnedValues(0 To b - 1)
                ReturnedValues(b - 1) = resp(c)
            Next c

    End If
    
    ReDim Preserve ReturnedValues(0 To (SamplesPerTrigger * NumTriggersToAccept - 1))
    OutBuffer = ReturnedValues

ext:
If BadSetup = True Then
    DVM34401A_Read = 2
ElseIf success = False Then
    DVM34401A_Read = 3
ElseIf timeout = True Then
    DVM34401A_Read = 1
Else
    DVM34401A_Read = 0
End If
    
End Function

Private Function ProcResponses(s, resp, n) As Boolean
    
    Dim r() As Double

    'Convert string numeric response possibly
    'with exponential to double.
    '
    'Format: SD.DDDDDDDDESDD,...,...,<nl>
    'S is + or - sign
    'D is numeric digit
    'E exponent
    '
    'May be multiple values in one response
    'so this should send an array of them and
    'number n giving the number of values

    strt = 1
    b = 0
    For a = 1 To Len(s)
    
        If Mid(s, a, 1) = "," Then
            cvs = Mid(s, strt, a - strt)
            strt = a + 1
            cv = Val(cvs)
            b = b + 1
            ReDim Preserve r(0 To b - 1)
            r(b - 1) = cv
        End If
    
    Next a

    cvs = Mid(s, strt, a - strt)
    cv = Val(cvs)
    b = b + 1
    ReDim Preserve r(0 To b - 1)
    r(b - 1) = cv
    
    n = b
    resp = r
    
End Function
