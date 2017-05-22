Attribute VB_Name = "PSUQL355TP"
Option Explicit

Public Function QL355TP_SetVoltage(voltage, channel As Integer, addr As Integer, Optional currentLimitIndex As Integer = -1)

    Dim s As String
    
    'Current Limit Index
    '0 -> 2mA
    '1 -> 20mA
    '2 -> 100mA
    
    If currentLimitIndex < 0 Or currentLimitIndex > 2 Then
        s = "V" + Format(channel) + " " + Format(voltage, "0.0##E+0#")
    Else
        s = "V" + Format(channel) + " " + Format(voltage, "0.0##E+0#") + " " + "I" + " " + Format(channel) + Format(currentLimitIndex, "0")
    End If
    
    GPIB.send s, addr

End Function

Public Function QL355TP_Standby(addr As Integer)
    
    Dim channel As Integer
    Dim Stby As String
    
    If channel = 1 Then Stby = "OP1 0"
    If channel = 2 Then Stby = "OP2 0"
    If channel = 3 Then Stby = "OP3 0"

    GPIB.send "Stby", addr

End Function

Public Function QL355TP_Enable(channel As Integer, addr As Integer)

    Dim En As String

    If channel = 1 Then En = "OP1 1"
    If channel = 2 Then En = "OP2 1"
    If channel = 3 Then En = "OP3 1"

    GPIB.send En, addr

End Function
