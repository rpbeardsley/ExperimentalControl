Attribute VB_Name = "PSU_TSX3510P"
Option Explicit

Public Function SetOutputV(V As Single, addr As Integer)

    Dim s As String
    
    s = "V" + " " + Format(V, "0.0##E+0#")

    GPIB.send s, addr
    
End Function

Public Function OperateOP(BinaryOnOff As Integer, addr As Integer)

    Dim s As String
    
    s = "OP" + " " + Format(BinaryOnOff, "0.0##E+0#")
    
    GPIB.send s, addr

End Function

Public Function SetCurrLim(Current As Single, addr As Integer)

    Dim s As String

    s = "I" + Format(Current, "0.0##E+0#")

    GPIB.send s, addr
    
End Function
