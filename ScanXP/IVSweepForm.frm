VERSION 5.00
Begin VB.Form IVSweepForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "IV Sweep"
   ClientHeight    =   9480
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7635
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9480
   ScaleWidth      =   7635
   Begin VB.TextBox Text15 
      Height          =   285
      Left            =   2400
      TabIndex        =   41
      Top             =   8640
      Width           =   1095
   End
   Begin VB.TextBox Text14 
      Height          =   285
      Left            =   5520
      TabIndex        =   39
      Top             =   8640
      Width           =   1095
   End
   Begin VB.TextBox Text13 
      Height          =   285
      Left            =   5520
      TabIndex        =   37
      Top             =   8160
      Width           =   1095
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Activate delay stage"
      Height          =   255
      Left            =   960
      TabIndex        =   35
      Top             =   8160
      Width           =   1815
   End
   Begin VB.TextBox Text12 
      Height          =   315
      Left            =   2640
      TabIndex        =   34
      Text            =   "1"
      Top             =   6000
      Width           =   1695
   End
   Begin VB.CheckBox Check1 
      Height          =   255
      Left            =   1320
      TabIndex        =   32
      Top             =   6000
      Width           =   255
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   2640
      Style           =   2  'Dropdown List
      TabIndex        =   30
      Top             =   240
      Width           =   1695
   End
   Begin VB.CommandButton Command3 
      Caption         =   "stop!!"
      Height          =   495
      Left            =   5040
      TabIndex        =   28
      Top             =   4800
      Width           =   1215
   End
   Begin VB.TextBox Text11 
      Height          =   285
      Left            =   2640
      TabIndex        =   27
      Text            =   "0.2"
      Top             =   5520
      Width           =   1695
   End
   Begin VB.TextBox Text10 
      Height          =   285
      Left            =   2640
      TabIndex        =   25
      Text            =   "1"
      Top             =   4800
      Width           =   1695
   End
   Begin VB.Frame Frame1 
      Caption         =   "Status"
      Height          =   2535
      Left            =   5160
      TabIndex        =   22
      Top             =   1560
      Width           =   2295
      Begin VB.Label Label11 
         Height          =   2055
         Left            =   120
         TabIndex        =   23
         Top             =   360
         Width           =   2055
         WordWrap        =   -1  'True
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Browse"
      Height          =   375
      Left            =   5040
      TabIndex        =   21
      Top             =   6840
      Width           =   1215
   End
   Begin VB.TextBox Text9 
      Height          =   285
      Left            =   2640
      TabIndex        =   20
      Top             =   7320
      Width           =   3615
   End
   Begin VB.TextBox Text8 
      Height          =   285
      Left            =   2640
      TabIndex        =   18
      Text            =   "1"
      Top             =   6720
      Width           =   1695
   End
   Begin VB.TextBox Text7 
      Height          =   285
      Left            =   2640
      TabIndex        =   16
      Text            =   "10"
      Top             =   5160
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Go"
      Height          =   495
      Left            =   5160
      TabIndex        =   14
      Top             =   240
      Width           =   1215
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   2640
      TabIndex        =   13
      Text            =   "100"
      Top             =   4080
      Width           =   1695
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   2640
      TabIndex        =   11
      Text            =   "0"
      Top             =   1200
      Width           =   1695
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   2640
      TabIndex        =   9
      Text            =   "0"
      Top             =   720
      Width           =   1695
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   2640
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   3600
      Width           =   1695
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   2640
      TabIndex        =   5
      Text            =   "10"
      Top             =   3120
      Width           =   1695
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2640
      TabIndex        =   3
      Text            =   "0"
      Top             =   2640
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   2640
      TabIndex        =   2
      Text            =   "0"
      Top             =   2160
      Width           =   1695
   End
   Begin VB.Label Label21 
      Height          =   255
      Left            =   2880
      TabIndex        =   43
      Top             =   9120
      Width           =   1215
   End
   Begin VB.Label Label20 
      Caption         =   "Delay current position"
      Height          =   255
      Left            =   960
      TabIndex        =   42
      Top             =   9120
      Width           =   1695
   End
   Begin VB.Label Label19 
      Caption         =   "Repeats/position"
      Height          =   255
      Left            =   960
      TabIndex        =   40
      Top             =   8640
      Width           =   1215
   End
   Begin VB.Label Label18 
      Caption         =   "2nd position"
      Height          =   255
      Left            =   4080
      TabIndex        =   38
      Top             =   8640
      Width           =   975
   End
   Begin VB.Label Label17 
      Caption         =   "1st position"
      Height          =   255
      Left            =   4080
      TabIndex        =   36
      Top             =   8160
      Width           =   1095
   End
   Begin VB.Line Line1 
      X1              =   360
      X2              =   7200
      Y1              =   7920
      Y2              =   7920
   End
   Begin VB.Label Label16 
      Caption         =   "Pause time / s"
      Height          =   375
      Left            =   1800
      TabIndex        =   33
      Top             =   6000
      Width           =   735
   End
   Begin VB.Label Label15 
      Caption         =   "0 V bias on"
      Height          =   255
      Left            =   360
      TabIndex        =   31
      Top             =   6000
      Width           =   855
   End
   Begin VB.Label Label14 
      Caption         =   "Read Device:"
      Height          =   255
      Left            =   360
      TabIndex        =   29
      Top             =   240
      Width           =   1935
   End
   Begin VB.Label Label13 
      Caption         =   "Pause between averages / s:"
      Height          =   255
      Left            =   360
      TabIndex        =   26
      Top             =   5520
      Width           =   2295
   End
   Begin VB.Label Label12 
      Caption         =   "Settling Time / s:"
      Height          =   255
      Left            =   360
      TabIndex        =   24
      Top             =   4800
      Width           =   1815
   End
   Begin VB.Label Label10 
      Caption         =   "Base Filename:"
      Height          =   255
      Left            =   360
      TabIndex        =   19
      Top             =   7320
      Width           =   1815
   End
   Begin VB.Label Label9 
      Caption         =   "Total Repeats:"
      Height          =   255
      Left            =   360
      TabIndex        =   17
      Top             =   6720
      Width           =   1815
   End
   Begin VB.Label Label8 
      Caption         =   "Averages at each point:"
      Height          =   255
      Left            =   360
      TabIndex        =   15
      Top             =   5160
      Width           =   1815
   End
   Begin VB.Label Label7 
      Caption         =   "Software Current Limit / mA:"
      Height          =   255
      Left            =   360
      TabIndex        =   12
      Top             =   4080
      Width           =   2055
   End
   Begin VB.Label Label6 
      Caption         =   "Voltage Source GPIB Address:"
      Height          =   255
      Left            =   360
      TabIndex        =   10
      Top             =   1200
      Width           =   2175
   End
   Begin VB.Label Label5 
      Caption         =   "Read GPIB Address:"
      Height          =   255
      Left            =   360
      TabIndex        =   8
      Top             =   720
      Width           =   1935
   End
   Begin VB.Label Label4 
      Caption         =   "Hardware Current Limit:"
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   3600
      Width           =   1815
   End
   Begin VB.Label Label3 
      Caption         =   "Number of Steps:"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   3120
      Width           =   1815
   End
   Begin VB.Label Label2 
      Caption         =   "Ending Voltage / V:"
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   2640
      Width           =   1815
   End
   Begin VB.Label Label1 
      Caption         =   "Starting Voltage / V:"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   2160
      Width           =   1815
   End
End
Attribute VB_Name = "IVSweepForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private running As Boolean

Private Sub Command1_Click()

    Dim fname As String
    Dim b As Integer
    Dim nmoves As Integer
    Dim TotalSweeps As Integer
    Dim e As Integer
       
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    Text5.Enabled = False
    Text6.Enabled = False
    Text7.Enabled = False
    Text8.Enabled = False
    Text9.Enabled = False
    Text10.Enabled = False
    Text11.Enabled = False
    Text12.Enabled = False
    Text13.Enabled = False
    Text14.Enabled = False
    Text15.Enabled = False
    Check2.Enabled = False
    Combo1.Enabled = False
    Combo2.Enabled = False
    Command1.Enabled = False
    Command2.Enabled = False
    
    nrepeats = Int(Val(Text8.Text))
    RepsPerPos = Int(Val(Text15.Text))
    PosOne = Val(Text13.Text)
    PosTwo = Val(Text14.Text)
    TotalSweepes = 1
    
    NanoStep.Init (3000)
    
    If Check2.value = 1 Then
        nmoves = nrepeats / RepsPerPos
        For e = 1 To nmoves
            
            If Globals.IsEven(e) = True Then pos = PosOne Else pos = PosTwo
            NanoStep.GoToPosition (pos)
            NanoStep.UpdateNanoStepPositionCounter
            Label21.Caption = NanoStep.CurrentPosition
            Globals.Pause (1)  'Pause to allow stage to stop vibrating
            
            For d = 1 To RepsPerPos
                TotalSweeps = TotalSweeps + 1
                
                fname = Text9.Text + "-" + Format(TotalSweeps) + ".dat"
                If FileExists(fname) Then
                    ret = MsgBox("Are you sure you want to overwrite the file?", vbExclamation Or vbYesNo, "File Exists")
                Else
                    ret = 6
                End If
                If ret <> 6 Then GoTo ext2
                Open fname For Output As #1
                
                SingleSweep
                
                If running = False Then GoTo ext2
                
                Close #1
            Next d
            
        Next e
    Else
        For b = 1 To nrepeats
            
            fname = Text9.Text + "-" + Format(b) + ".dat"
            If FileExists(fname) Then
                ret = MsgBox("Are you sure you want to overwrite the file?", vbExclamation Or vbYesNo, "File Exists")
            Else
                ret = 6
            End If
            If ret <> 6 Then GoTo ext2
            Open fname For Output As #1
            
            SingleSweep
            
            If running = False Then GoTo ext2
            
            Close #1
        Next b
    End If
    
ext2:

    Text1.Enabled = True
    Text2.Enabled = True
    Text3.Enabled = True
    Text4.Enabled = True
    Text5.Enabled = True
    Text6.Enabled = True
    Text7.Enabled = True
    Text8.Enabled = True
    Text9.Enabled = True
    Text10.Enabled = True
    Text11.Enabled = True
    Text12.Enabled = True
    Text13.Enabled = True
    Text14.Enabled = True
    Text15.Enabled = True
    Check2.Enabled = True
    Combo1.Enabled = True
    Combo2.Enabled = True
    Command1.Enabled = True
    Command2.Enabled = True

End Sub

Private Sub Command2_Click()
    a = Globals.SaveDialog
    If a <> "" Then
        Text9.Text = a
    End If
End Sub

Private Sub Command3_Click()
    running = False
End Sub

Private Sub Form_Load()

    Combo1.Clear
    Combo1.AddItem "2mA"
    Combo1.AddItem "20mA"
    Combo1.AddItem "100mA"
    Combo1.ListIndex = 2
    
    Combo2.Clear
    Combo2.AddItem "DMM"
    Combo2.AddItem "Lock-in X"
    Combo2.AddItem "Lock-in R"
    Combo2.AddItem "Lock-in X and Y"
    Combo2.ListIndex = 0
    
    Text4.Text = DVM1_ADDR
    Text5.Text = DVS_ADDR

End Sub

Private Function GetSample(addr As Integer)

    Dim success As Boolean
    Dim tmparr(0 To 1)

    If Combo2.ListIndex = 0 Then
        V = DVM34401A.DVM34401A_GetSample(addr)
        GetSample = V
    ElseIf Combo2.ListIndex = 1 Then
        V = SRS830.SRS830_ReadChannel(addr, 1, t, success)
        GetSample = V
    ElseIf Combo2.ListIndex = 2 Then
        V = SRS830.SRS830_ReadChannel(addr, 3, t, success)
        GetSample = V
    ElseIf Combo2.ListIndex = 3 Then
        SRS830.SRS830_ReadXY addr, t, success, X, Y
        tmparr(0) = X
        tmparr(1) = Y
        GetSample = tmparr
    End If

End Function

Private Sub SingleSweep()
    
    Dim read_addr As Integer
    Dim source_addr As Integer
    Dim i As Double
    Dim V As Double
        
    Dim Iarr() As Double
    Dim Varr() As Double
    
    read_addr = Int(Val(Text4.Text))
    source_addr = Int(Val(Text5.Text))
    
    startv = Val(Text1.Text)
    endv = Val(Text2.Text)
    numpoints = Int(Val(Text3.Text))
    
    soft_curr_limit = Val(Text6.Text)
    settling_time = Val(Text10.Text)
    pause_between_avs = Val(Text11.Text)
    
    naverages = Int(Val(Text7.Text))
    
    running = True
    DVS.DVS_Init (source_addr)
    
    For a = 1 To numpoints
    
        V = startv + (endv - startv) * ((a - 1) / (numpoints - 1))
        DVS.DVS_SetVoltage V, source_addr, Combo1.ListIndex
        DVS.DVS_Operate (source_addr)
        Pause (settling_time)
        Label11.Caption = "Voltage:" + vbCrLf + Format(V)
        
        i = 0
        i2 = 0
        For c = 1 To naverages
            s = GetSample(read_addr)
            If Combo2.ListIndex <> 3 Then
                i = i + Val(s)
            Else
                i = i + Val(s(0))
                i2 = i2 + Val(s(1))
            End If
            Pause (pause_between_avs)
        Next c
        i = i / naverages
        i2 = i2 / naverages
    
        If i > (soft_curr_limit / 1000) Then Label11.Caption = "Software current limit exceeded!": GoTo ext
    
        Label11.Caption = Label11.Caption + vbCrLf + vbCrLf + "Current:" + vbCrLf + Format(i)
    
        If Combo2.ListIndex <> 3 Then
            Print #1, Format(V) + ", " + Format(i)
        Else
            Print #1, Format(V) + ", " + Format(i) + ", " + Format(i2)
        End If
        
        DoEvents
        
        ReDim Preserve Iarr(0 To a - 1)
        ReDim Preserve Varr(0 To a - 1)
        Iarr(a - 1) = i
        Varr(a - 1) = V
        TraceForm.Show
        TraceForm.PlotTrace Varr, Iarr
        
        If Check1.value = 1 Then
            DVS.DVS_SetVoltage 0, source_addr, Combo1.ListIndex
            DVS.DVS_Operate (source_addr)
            Pause (Val(Text12.Text))
        End If
        
        If running = False Then GoTo ext
    
    Next a

ext:

    DVS.DVS_Standby (source_addr) 'Put dvs in standby

End Sub
