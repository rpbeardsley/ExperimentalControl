Attribute VB_Name = "Module1"
Global ICSObj As Object

Global flag_load As Integer
Global iec As Integer
Global xdataec As Variant
Global ydataec As Variant
Global protnumber As Integer
Global ExtraData As Variant
Global bresult As Boolean
Global totalb As Single
Global totalg As Single
Global mult As Integer

Global Nec As Variant
Global xdatec(3, 16000) As Variant
Global ydatec(3, 16000) As Variant
Global flagset As Integer
Global gate_vol As Single

Global sample As Variant
Global toffset As Variant
Global av As Long
Global reclenec As Variant
Global dtime As Single
Global voffset As Single
Global pe As Boolean


Global s As String
Global recstr As String
Global avstr As String
Global sampl_str As String
Global toffstr As String
Global voffstr As String
Global dtstr As String
Global pestr As String

Global timewin As Integer
Global timewindowec(3) As Integer

Public Sub gatewin()
Dim bwidth As Integer
Dim gwidth As Integer
bl$ = CStr(timewindowec(0)) + "-" + CStr(timewindowec(1))
bwidth = timewindowec(1) - timewindowec(0)
frmeclipse!Label20.Caption = bl$ + " ns"
frmeclipse!Label22.Caption = Str(bwidth) + " ns"

gw$ = CStr(timewindowec(2)) + "-" + CStr(timewindowec(3))
gwidth = timewindowec(3) - timewindowec(2)
frmeclipse!Label25.Caption = gw$ + " ns"
frmeclipse!Label26.Caption = Str(gwidth) + " ns"
If flag_load = 1 Then
getavgate
End If
End Sub
Public Sub getavgate()
Dim starp As Integer
Dim stopp As Integer
Dim cwid As Integer
Dim gwid As Integer
totalg = 0
totalb = 0
cwid = 0
gwid = 0

starp = (timewindowec(0) / sample) + 1
stopp = (timewindowec(1) / sample) + 1
For k% = starp To stopp Step 1
cwid = cwid + 1
totalb = totalb + ydatec(2, k%)
Next
totalb = totalb / cwid
frmeclipse!Label28.Caption = Format(totalb, "##0.0##") + " mV"

starp = (timewindowec(2) / sample) + 1
stopp = (timewindowec(3) / sample) + 1
For k% = starp To stopp Step 1
gwid = gwid + 1
totalg = totalg + ydatec(2, k%)
Next
totalg = totalg / gwid
frmeclipse!Label29.Caption = Format(totalg, "##0.0##") + " mV"

End Sub
Public Sub getectrace()
Dim type1 As Integer
For k% = 0 To 1 Step 1
Select Case frmeclipse!Combo4(k%).ListIndex
Case 0
Bias (1)
average k%
Case 1
Bias (0)
average k%
Case 2
'set zero voltage
'SetGate 0
average k%
Case 3
'set +ve vol
'setgate gate_vol
average k%
Case 4
'-ve vol
'setgate -gate_vol
average k%
Case 5
End Select
Next

showtrace2

'file = "X" + CStr(curx%) + "Y" + CStr(cury%) + ".dat"
'Open file For Output As #1
'For iec = 1 To Nec
'Print #1, xdatec(2, iec), ydatec(2, iec)
'Next iec
'Close #1

End Sub
Public Sub showtrace2()
'For k% = 0 To 2 Step 1
Select Case frmeclipse!Combo6.ListIndex
Case 0
For iec = 1 To Nec Step 1
xdatec(2, iec) = xdatec(0, iec)
ydatec(2, iec) = ydatec(0, iec)
Next
Case 1
For iec = 1 To Nec Step 1
xdatec(2, iec) = xdatec(0, iec)
ydatec(2, iec) = ydatec(0, iec)
Next
Case 2
For iec = 1 To Nec Step 1
xdatec(2, iec) = xdatec(0, iec)
ydatec(2, iec) = ydatec(0, iec) - ydatec(1, iec)
Next
Case 3
For iec = 1 To Nec Step 1
xdatec(2, iec) = xdatec(0, iec)
ydatec(2, iec) = ydatec(1, iec) - ydatec(0, iec)
Next
Case 4
For iec = 1 To Nec Step 1
xdatec(2, iec) = xdatec(0, iec)
ydatec(2, iec) = ydatec(0, iec) + ydatec(1, iec)
Next
End Select
End Sub
Public Sub createclass()
Set ICSObj = CreateObject("ICS.ICSGP")

End Sub

Public Sub setupeclip()
ICSObj.Reset
ICSObj.Direct "SET_REC_LEN " & Str(reclenec) & ",0"
ICSObj.Direct "SET_PERI " & Str(sample) & ",0"
ICSObj.Direct "SET_RECORD_PRESET " & Str(av) & ",0"
ICSObj.TimeOffset 0, toffset
ICSObj.Direct "SET_OFFSET " & Str(voffset) & ",0"
ICSObj.DeadTime 0, dtime
ICSObj.Enhancer 0, pe

'N = reclen / av

'ICSObj.Direct
'ICSObj.Direct
'ICSObj.Direct
'ICSObj.Direct
'ICSObj.Direct

End Sub

Public Sub average(traceno As Integer)

Dim recsc As Variant
Dim softsweeps As Integer
Dim recs As Long
ReDim ExtraData(0) As Double

For softsweeps = 1 To mult Step 1

ICSObj.StartAverageAcquisition ExtraData(0), 0, 0#, 0

Do
recs = ICSObj.Record
Loop Until recs >= (av - 100)

ReDim xdataec(0) As Double
ReDim ydataec(0) As Double
bresult = False

While (Not bresult)
 If (ICSObj.GetDataFromInst(xdataec, ydataec)) Then
 bresult = True
End If
Wend

ICSObj.StopAverageAcquisition

For iec = 1 To Nec Step 1
If Abs(ydataec(iec)) > 499 Then
ydataec(iec) = ydataec(iec - 1)
End If
ydatec(traceno, iec) = ydatec(traceno, iec) + ydataec(iec) / 2
xdatec(traceno, iec) = xdataec(iec)
Next
Next softsweeps

For iec = 1 To Nec Step 1
ydatec(traceno, iec) = ydatec(traceno, iec) / mult
Next
End Sub




Public Sub cleararray()
For k% = 0 To 2
For l% = 0 To 16000
 xdatec(k%, l%) = 0
 ydatec(k%, l%) = 0
Next l%
Next k%
End Sub
