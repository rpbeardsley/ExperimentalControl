VERSION 5.00
Begin VB.Form DigitiserForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digitiser"
   ClientHeight    =   3975
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10410
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3975
   ScaleWidth      =   10410
   Begin VB.Frame Frame1 
      Caption         =   "Bias Subtraction"
      Height          =   855
      Left            =   7080
      TabIndex        =   32
      Top             =   2880
      Width           =   2655
      Begin VB.OptionButton Option3 
         Caption         =   "Off"
         Height          =   495
         Left            =   1560
         TabIndex        =   35
         Top             =   240
         Value           =   -1  'True
         Width           =   735
      End
      Begin VB.OptionButton Option2 
         Caption         =   "-ve"
         Height          =   495
         Left            =   960
         TabIndex        =   34
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton Option1 
         Caption         =   "+ve"
         Height          =   495
         Left            =   240
         TabIndex        =   33
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Save"
      Height          =   495
      Left            =   5280
      TabIndex        =   31
      Top             =   2880
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Get Settings"
      Height          =   495
      Left            =   1800
      TabIndex        =   29
      Top             =   2880
      Width           =   1695
   End
   Begin VB.ComboBox Combo10 
      Height          =   315
      Left            =   8760
      Style           =   2  'Dropdown List
      TabIndex        =   27
      Top             =   1320
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Send Settings"
      Height          =   495
      Left            =   120
      TabIndex        =   25
      Top             =   2880
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Acquire"
      Height          =   495
      Left            =   3600
      TabIndex        =   24
      Top             =   2880
      Width           =   1575
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   5400
      TabIndex        =   23
      Text            =   "76"
      Top             =   120
      Width           =   1455
   End
   Begin VB.ComboBox Combo9 
      Height          =   315
      Left            =   2640
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   2400
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   6720
      TabIndex        =   19
      Text            =   "1"
      Top             =   1920
      Width           =   1455
   End
   Begin VB.ComboBox Combo8 
      Height          =   315
      Left            =   2640
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   1920
      Width           =   1455
   End
   Begin VB.ComboBox Combo7 
      Height          =   315
      Left            =   1680
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   1320
      Width           =   1455
   End
   Begin VB.ComboBox Combo6 
      Height          =   315
      Left            =   5040
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   1320
      Width           =   1455
   End
   Begin VB.ComboBox Combo5 
      Height          =   315
      Left            =   1680
      Style           =   2  'Dropdown List
      TabIndex        =   11
      Top             =   120
      Width           =   1455
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      Left            =   5040
      Style           =   2  'Dropdown List
      TabIndex        =   10
      Top             =   720
      Width           =   1455
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   6720
      TabIndex        =   9
      Top             =   2400
      Width           =   1455
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   1680
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   720
      Width           =   1455
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   8760
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   720
      Width           =   1455
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   8760
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   120
      Width           =   1455
   End
   Begin VB.Label Label15 
      Caption         =   "Readout via:"
      Height          =   255
      Left            =   8400
      TabIndex        =   30
      Top             =   1920
      Width           =   1695
   End
   Begin VB.Label Label14 
      Caption         =   "Label14"
      Height          =   255
      Left            =   8400
      TabIndex        =   28
      Top             =   2160
      Width           =   1455
   End
   Begin VB.Label Label13 
      Caption         =   "Preamp Coupling:"
      Height          =   255
      Left            =   6720
      TabIndex        =   26
      Top             =   1320
      Width           =   1335
   End
   Begin VB.Line Line4 
      X1              =   120
      X2              =   10200
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line3 
      X1              =   120
      X2              =   10200
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Line Line2 
      X1              =   120
      X2              =   10200
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   10200
      Y1              =   480
      Y2              =   480
   End
   Begin VB.Label Label12 
      Caption         =   "Number of reads to ignore:"
      Height          =   255
      Left            =   3360
      TabIndex        =   22
      Top             =   120
      Width           =   1935
   End
   Begin VB.Label Label11 
      Caption         =   "Full Scale Voltage (mV):"
      Height          =   255
      Left            =   120
      TabIndex        =   20
      Top             =   2400
      Width           =   1815
   End
   Begin VB.Label Label10 
      Caption         =   "Number of software averages:"
      Height          =   255
      Left            =   4440
      TabIndex        =   18
      Top             =   1920
      Width           =   2175
   End
   Begin VB.Label Label9 
      Caption         =   "Number of hardware averages: 2^"
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   1920
      Width           =   2535
   End
   Begin VB.Label Label8 
      Caption         =   "Sample Period / ns:"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   1320
      Width           =   1455
   End
   Begin VB.Label Label7 
      Caption         =   "Record Length:"
      Height          =   255
      Left            =   3360
      TabIndex        =   12
      Top             =   1320
      Width           =   1335
   End
   Begin VB.Label Label6 
      Caption         =   "Input Offset (%):"
      Height          =   255
      Left            =   4440
      TabIndex        =   8
      Top             =   2400
      Width           =   1335
   End
   Begin VB.Label Label5 
      Caption         =   "Trigger Threshold / V:"
      Height          =   255
      Left            =   3360
      TabIndex        =   7
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "Trigger polarity:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   720
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "Trigger Input Impedance:"
      Height          =   255
      Left            =   6720
      TabIndex        =   3
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "Digitiser Address:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Preamp Input:"
      Height          =   255
      Left            =   7080
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
End
Attribute VB_Name = "DigitiserForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private numpoints
Private datx() As Double
Private daty() As Double

Private Sub Combo2_Click()
TriggerThreshComboUpdate
End Sub

Private Sub Command1_Click()

GetSettingsFromDigitiser

Pause (1)

Open "out.txt" For Output As #1
If Option1.value = True Then
    BiasSwitch.SetBias (0)
ElseIf Option2.value = True Then
    BiasSwitch.SetBias (1)
End If

dat = Digitiser.GetTrace(xdata, ydata)
If Option3.value = False Then
    BiasSwitch.FlipBias
    dat2 = Digitiser.GetTrace(xdata2, ydata2)
End If

ReDim datx(0 To (UBound(xdata) - LBound(xdata)))
ReDim daty(0 To (UBound(xdata) - LBound(xdata)))

If Option3.value = False Then
For a = LBound(xdata) To UBound(xdata)
    ydata(a) = ydata(a) - ydata2(a)
Next a
End If

b = 0
For a = LBound(xdata) To UBound(xdata)
    datx(b) = xdata(a)
    daty(b) = ydata(a)
    b = b + 1
    Print #1, Format(xdata(a)) + ", " + Format(ydata(a))
Next a

Close #1

TraceForm.Show
TraceForm.PlotTrace xdata, ydata

End Sub

Private Sub Command2_Click()
SendSettingsToDigitiser
GetSettingsFromDigitiser
End Sub

Private Sub GetSettingsFromDigitiser()

    Dim mindelta

    Combo1.Clear
    Combo2.Clear
    Combo3.Clear
    Combo4.Clear
    Combo5.Clear
    Combo6.Clear
    Combo7.Clear
    Combo8.Clear
    Combo9.Clear
    Combo10.Clear
    Text1.Text = ""
    Text2.Text = ""
    Text3.Text = ""

    Combo5.AddItem ("300")
    Combo5.AddItem ("310")
    Combo5.AddItem ("340")
    Combo5.AddItem ("350")
    ba = Digitiser.GetBaseAddress
    If ba = 300 Then Combo5.ListIndex = 0
    If ba = 310 Then Combo5.ListIndex = 1
    If ba = 340 Then Combo5.ListIndex = 2
    If ba = 350 Then Combo5.ListIndex = 3

    Combo1.AddItem ("1")
    Combo1.AddItem ("2")
    a = Digitiser.GetPreampInput
    If a = "1" Then Combo1.ListIndex = 0 Else Combo1.ListIndex = 1
    
    Combo2.AddItem "50 ohm"
    Combo2.AddItem "1 Kohm"
    a = Digitiser.GetInputImpedance
    If a = "50 ohm" Then Combo2.ListIndex = 0 Else Combo2.ListIndex = 1

    Combo3.AddItem "Rising edge"
    Combo3.AddItem "Falling edge"
    a = Digitiser.GetTriggerPolarity
    If a = "+" Then Combo3.ListIndex = 0 Else Combo3.ListIndex = 1
 
    Combo10.AddItem "DC"
    Combo10.AddItem "AC"
    a = Digitiser.GetCoupling
    If a = "DC" Then Combo10.ListIndex = 0
    If a = "AC" Then Combo10.ListIndex = 1
 
    TriggerThreshComboUpdate
    
    Text3.Text = CStr(Digitiser.GetPreampOffset)
    
    Text2.Text = CStr(Digitiser.ignore)
    
    curr = Digitiser.GetRecordLength
    n = -1
    For a = 0 To 12
        If Not (a = 11 And DIGITISER_MODEL = 9825) Then
            b = 64 * (2 ^ a)
            Combo6.AddItem b
            If b = curr Then n = Combo6.ListCount - 1
        End If
    Next a
    Combo6.ListIndex = n
    
    If DIGITISER_MODEL = 9846 Or DIGITISER_MODEL = 9826 Then
        Combo7.AddItem ("2560")
        Combo7.AddItem ("1280")
        Combo7.AddItem ("640")
        Combo7.AddItem ("320")
        Combo7.AddItem ("160")
        Combo7.AddItem ("80")
        Combo7.AddItem ("40")
        Combo7.AddItem ("20")
        Combo7.AddItem ("10")
        Combo7.AddItem ("4")
        Combo7.AddItem ("2")
    ElseIf DIGITISER_MODEL = 9825 Then
        Combo7.AddItem ("160")
        Combo7.AddItem ("80")
        Combo7.AddItem ("40")
        Combo7.AddItem ("20")
        Combo7.AddItem ("10")
        Combo7.AddItem ("5")
    End If
    curr = Digitiser.GetSamplePeriod
    n = -1
    For a = 0 To Combo7.ListCount - 1
        If Combo7.List(a) = curr Then n = a
    Next a
    Combo7.ListIndex = n
    
    curr = Digitiser.GetHardwareSweeps
    n = -1
    For a = 0 To 16
        If Not (((DIGITISER_MODEL = 9825) And a = 1) Or ((DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846) And a = 16)) Then
            Combo8.AddItem a
            If 2 ^ a = curr Then n = Combo8.ListCount - 1
        End If
    Next a
    Combo8.ListIndex = n
    
    Text1.Text = Digitiser.SoftwareSweeps

    mindelta = 1000
    curr = Digitiser.GetPreampGain
    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        For a = 12 To 40 Step 2
            thisgain = CInt(10 * 2 ^ (a / 6))
            Combo9.AddItem CStr(thisgain)
            delta = Abs(thisgain - curr)
            If delta < mindelta Then mindelta = delta: Combo9.ListIndex = Combo9.ListCount - 1
        Next
    ElseIf DIGITISER_MODEL = 9825 Then
        Combo9.AddItem "40"
        Combo9.AddItem "60"
        Combo9.AddItem "100"
        Combo9.AddItem "150"
        Combo9.AddItem "200"
        Combo9.AddItem "300"
        Combo9.AddItem "400"
        If curr = 40 Then Combo9.ListIndex = 0
        If curr = 60 Then Combo9.ListIndex = 1
        If curr = 100 Then Combo9.ListIndex = 2
        If curr = 150 Then Combo9.ListIndex = 3
        If curr = 200 Then Combo9.ListIndex = 4
        If curr = 300 Then Combo9.ListIndex = 5
        If curr = 400 Then Combo9.ListIndex = 6
    End If

    Label14.Caption = GetReadOutMode

fin:
End Sub


Private Sub TriggerThreshComboUpdate()

    curr = Format(Digitiser.GetTriggerLevel, "+#0.00;-#0.00")

    Combo4.Clear

    'If DIGITISER_MODEL = 9825 And Combo2.ListIndex = 0 Then b = 1.5: c = 0.5
    'If DIGITISER_MODEL <> 9825 And Combo2.ListIndex = 0 Then b = 2.5: c = 0.5
    'If Combo2.ListIndex = 1 Then b = 10: c = 2
    
    n = -1
    
    If DIGITISER_MODEL = 9826 Or DIGITISER_MODEL = 9846 Then
        For a = 255 To 0 Step -1
            d = -10 + a * (20 / 256)
            Combo4.AddItem Format(d, "+#0.00;-#0.00")
            If Combo4.List(Combo4.ListCount - 1) = curr Then n = Combo4.ListCount - 1
        Next a
    ElseIf DIGITISER_MODEL = 9825 Then
        For a = 1.5 To -1.5 Step -0.1
            Combo4.AddItem Format(a, "+#0.00;-#0.00")
            If Combo4.List(Combo4.ListCount - 1) = curr Then n = Combo4.ListCount - 1
        Next a
    End If
    

    If n = -1 Then
        Combo4.AddItem curr
        Combo4.ListIndex = Combo4.ListCount - 1
    Else
        Combo4.ListIndex = n
    End If

End Sub

Private Sub SendSettingsToDigitiser()

Digitiser.SetBaseAddress Combo5.List(Combo5.ListIndex)

Select Case DIGITISER_MODEL
    Case 9825
        If Val(Text3.Text) < -50 Then Text3.Text = "-50"
        If Val(Text3.Text) > 120 Then Text3.Text = "120"
    Case Else
        If Val(Text3.Text) < -20 Then Text3.Text = "-20"
        If Val(Text3.Text) > 120 Then Text3.Text = "120"
End Select

Digitiser.SetPreampInput (Combo1.List(Combo1.ListIndex))
Digitiser.SetCoupling (Combo10.List(Combo10.ListIndex))
Digitiser.SetTriggerLevel CSng(Combo4.List(Combo4.ListIndex))
Digitiser.SetPreampGain CInt(Combo9.List(Combo9.ListIndex))
Digitiser.SetPreampOffset CInt(Text3.Text)
Digitiser.SetRecordLength CLng(Combo6.List(Combo6.ListIndex))
Digitiser.SetHardwareSweeps CLng(2 ^ Combo8.List(Combo8.ListIndex))
Digitiser.SoftwareSweeps = CLng(Val(Text1.Text))
Digitiser.SetSamplePeriod Int(Val(Combo7.List(Combo7.ListIndex)))
ignore = CInt(Text2.Text)

If Combo3.ListIndex = 0 Then
    Digitiser.SetTriggerPolarity "+"
Else
    Digitiser.SetTriggerPolarity "-"
End If

If Combo2.ListIndex = 0 Then
    Digitiser.SetInputImpedance "50 ohm"
Else
    Digitiser.SetInputImpedance "1 Kohm"
End If

End Sub

Private Sub Command3_Click()
Digitiser.DigitiserSettings
End Sub



Private Sub Command4_Click()
    a = Globals.SaveDialog
    If a <> "" Then
        Open a For Output As #1
        For a = LBound(datx) To UBound(datx)
            Print #1, Format(datx(a)) + ", " + Format(daty(a))
        Next a
        Close #1
    End If
End Sub

Private Sub Form_Load()
    GetSettingsFromDigitiser
End Sub

Private Sub GraphInit()

numpoints = 0

Graph1.DrawStyle = 1 'Colour (0=monochrome)
Graph1.NumSets = 1 'Only 1 data set
Graph1.ThisSet = 1 'Data set 1
Graph1.numpoints = 2 'Initially 2 is the minimum
Graph1.ColorData = 15 'White
Graph1.Foreground = 10
Graph1.ThickLines = 0 'No
Graph1.GraphType = 6
Graph1.GraphStyle = 4

End Sub

Private Function AddPointToGraph(X, Y)

    numpoints = numpoints + 1
    If numpoints > 2 Then Graph1.numpoints = numpoints
    Graph1.ThisPoint = numpoints

    Graph1.GraphData = Y
    Graph1.XPosData = X
        
End Function

Private Function RefreshGraph()

    If Graph1.ThisPoint > 1 Then
        Graph1.DrawMode = 3
    End If

End Function

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: DigitiserForm.Hide

End Sub
