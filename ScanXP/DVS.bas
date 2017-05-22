Attribute VB_Name = "DVS"
Public Function DVS_SetVoltage(voltage, addr As Integer, Optional currentLimitIndex As Integer = -1)

    Dim s As String

    'Current limit:
    '0 -> 2mA
    '1 -> 20mA
    '2 -> 100mA

    If currentLimitIndex < 0 Or currentLimitIndex > 2 Then
        s = "V" + Format(voltage, "0.0##E+0#") + "X"
    Else
        s = "V" + Format(voltage, "0.0##E+0#") + "I" + Format(currentLimitIndex, "0") + "X"
    End If
    
    GPIB.Send s, addr

End Function

Public Function DVS_Init(addr As Integer)

    GPIB.Send "F0R0L2B2I2G2X", addr

End Function

Public Function DVS_Standby(addr As Integer)

    GPIB.Send "F0X", addr

End Function

Public Function DVS_Operate(addr As Integer)

    GPIB.Send "F1X", addr

End Function

