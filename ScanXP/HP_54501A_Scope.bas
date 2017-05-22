Attribute VB_Name = "Scope_HP_54501A"

Public Function HP_54501A_GetTrace(addr As Integer, Avgs As Single)
    
    Dim strng As String
    Dim strng2 As String
    Dim strng3 As String
    Dim strng4 As String
    Dim strng5 As String
    Dim strng6 As String
    Dim strng7 As String
    Dim inbuff As String
    Dim strng8 As String
    Dim busy As String
    
    'Most aquisition parameters are set locally on the scope but
    'we still need to set some
    strAvgs = Str(Avgs)
    
    strng = ":ACQUIRE:TYPE AVERAGE;COUNT" + strAvgs
    GPIB.send strng, addr 'Trace type (COUNT 2048 = averages max)
    
    strng3 = ":ACQUIRE:COMPLETE 100"
    GPIB.send strng3, addr 'Percentage of time bucket must be that filled to complete
    
    strng4 = ":DIGITIZE CHANNEL1"
    GPIB.send strng4, addr 'Read channel
    
    strng5 = ":ACQUIRE:POINTS 500"
    GPIB.send strng6, addr 'Number of points
    
    strng6 = ":WAVEFORM:SOURCE CHANNEL1;FORMAT ASCII"
    GPIB.send strng6, addr 'Active channel
    
    'Check the busy status
    busy = ""
    While busy = ""
        GPIB.send "*OPC?", addr
        busy = GPIB.Recv(addr, 256)
        DoEvents
    Wend
    
    'Send the data query and read back the response
    strng8 = ":WAVEFORM:DATA?"
    GPIB.send strng8, addr
    inbuf = GPIB.Recv(addr, 8192)
    HP_54501A_GetTrace = inbuf 'Pass the data to be processed

End Function

Public Function HP_54501A_GetTracePreamble(addr As Integer)

    Dim PrmbleQuery As String
    Dim Preamble As String
        
    'Request preamble
    PrmbleQuery = ":WAVEFORM:PREAMBLE?"
    GPIB.send PrmbleQuery, addr
    
    'Recieve preamble
    Preamble = GPIB.Recv(addr, 256)
    HP_54501A_GetTracePreamble = Preamble
    
End Function
