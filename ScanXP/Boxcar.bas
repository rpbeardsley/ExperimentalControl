Attribute VB_Name = "Boxcar"
Public Function BoxcarRead(addr As Integer, channel As Integer)

    GPIB.send "I" + Format(channel), addr 'Designate channels 1 to 'channel' as inputs - the rest become outputs
    GPIB.send "?" + Format(channel), addr 'Send request to read channel 'channel'
    BoxcarGetChannel = Val(GPIB.Recv(addr, 255)) 'Read back data

End Function

Public Function BoxcarSet(addr As Integer, channel As Integer, voltage As Single)

    If voltage < 0.000000001 Then voltage = 0

    'Set channel to given output voltage
    GPIB.send "S" + Format(channel) + "=" + Format(voltage, "##.#E+#"), addr
    
End Function

Public Function SetBoxcarTrigger(addr As Integer, trig As String)

    If trig = "External" Then
        GPIB.send "MS", addr
    Else
        GPIB.send "MA", addr
    End If
    
End Function

Public Function BoxcarSetReadChannels(addr As Integer, lastReadChannel As Integer)

    'Sets channels 1 to 'lastreadchannel' to be read channels
    'The rest become output channels
    GPIB.send "I" + Format(lastReadChannel), addr

End Function

Public Function InitBoxcar(addr As Integer)

    SetBoxcarTrigger addr, "Internal"
    BoxcarSetReadChannels addr, 8

End Function
