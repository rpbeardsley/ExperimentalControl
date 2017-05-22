VERSION 5.00
Begin VB.Form PumpProbeAccurate 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Step-by-Step Pump-Probe"
   ClientHeight    =   9630
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9510
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9630
   ScaleWidth      =   9510
   Begin VB.TextBox Text14 
      Height          =   285
      Left            =   2520
      TabIndex        =   59
      Top             =   7440
      Width           =   375
   End
   Begin VB.CheckBox Check1 
      Height          =   495
      Left            =   240
      TabIndex        =   58
      Top             =   7320
      Width           =   255
   End
   Begin VB.ComboBox Combo5 
      Height          =   315
      Left            =   8520
      Style           =   2  'Dropdown List
      TabIndex        =   57
      Top             =   5640
      Width           =   855
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      Left            =   3840
      Style           =   2  'Dropdown List
      TabIndex        =   56
      Top             =   5640
      Width           =   855
   End
   Begin VB.TextBox Text13 
      Height          =   285
      Left            =   8520
      TabIndex        =   53
      Text            =   "6"
      Top             =   5160
      Width           =   495
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   5760
      Style           =   2  'Dropdown List
      TabIndex        =   51
      Top             =   5145
      Width           =   1695
   End
   Begin VB.TextBox Text12 
      Height          =   285
      Left            =   3840
      TabIndex        =   49
      Text            =   "6"
      Top             =   5160
      Width           =   495
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   1080
      Style           =   2  'Dropdown List
      TabIndex        =   47
      Top             =   5145
      Width           =   1695
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Pause"
      Height          =   495
      Left            =   2880
      TabIndex        =   45
      Top             =   7920
      Width           =   1215
   End
   Begin VB.TextBox Text8 
      Height          =   285
      Left            =   2040
      TabIndex        =   31
      Text            =   "NS_1000"
      Top             =   120
      Width           =   2655
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   2160
      TabIndex        =   28
      Text            =   "68.45"
      Top             =   2280
      Width           =   975
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   6840
      TabIndex        =   25
      Top             =   1800
      Width           =   975
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   6840
      TabIndex        =   23
      Top             =   960
      Width           =   975
   End
   Begin VB.TextBox Text11 
      Height          =   285
      Left            =   2160
      TabIndex        =   21
      Top             =   1800
      Width           =   975
   End
   Begin VB.TextBox Text10 
      Height          =   285
      Left            =   2160
      TabIndex        =   19
      Top             =   960
      Width           =   975
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Set"
      Height          =   375
      Left            =   8040
      TabIndex        =   18
      Top             =   1800
      Width           =   1215
   End
   Begin VB.TextBox Text9 
      Height          =   285
      Left            =   4680
      TabIndex        =   16
      Top             =   1800
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Set"
      Height          =   375
      Left            =   8040
      TabIndex        =   15
      Top             =   960
      Width           =   1215
   End
   Begin VB.TextBox Text7 
      Height          =   285
      Left            =   4680
      TabIndex        =   13
      Top             =   960
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   "FFT"
      Height          =   495
      Left            =   6600
      TabIndex        =   12
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "View Trace"
      Height          =   495
      Left            =   5280
      TabIndex        =   11
      Top             =   7920
      Width           =   1215
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   6000
      TabIndex        =   10
      Top             =   6360
      Width           =   1455
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   2520
      TabIndex        =   8
      Top             =   6840
      Width           =   4935
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Stop"
      Height          =   495
      Left            =   1560
      TabIndex        =   6
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Go"
      Height          =   495
      Left            =   240
      TabIndex        =   5
      Top             =   7920
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   2520
      TabIndex        =   4
      Text            =   "10"
      Top             =   4440
      Width           =   1695
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   7080
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   4440
      Width           =   1935
   End
   Begin VB.Label Label39 
      Caption         =   "scans)"
      Height          =   255
      Left            =   5640
      TabIndex        =   66
      Top             =   8760
      Width           =   495
   End
   Begin VB.Label Label38 
      Height          =   255
      Left            =   5280
      TabIndex        =   65
      Top             =   8760
      Width           =   375
   End
   Begin VB.Label Label37 
      Caption         =   "of"
      Height          =   255
      Left            =   5040
      TabIndex        =   64
      Top             =   8760
      Width           =   255
   End
   Begin VB.Label Label36 
      Height          =   255
      Left            =   4680
      TabIndex        =   63
      Top             =   8760
      Width           =   375
   End
   Begin VB.Label Label35 
      Caption         =   "(Scan"
      Height          =   255
      Left            =   4200
      TabIndex        =   62
      Top             =   8760
      Width           =   495
   End
   Begin VB.Label Label34 
      Caption         =   "Repeat this measurement"
      Height          =   255
      Left            =   600
      TabIndex        =   61
      Top             =   7440
      Width           =   2175
   End
   Begin VB.Label Label33 
      Caption         =   "times"
      Height          =   255
      Left            =   3000
      TabIndex        =   60
      Top             =   7440
      Width           =   495
   End
   Begin VB.Label Label32 
      Caption         =   "Sub Addr:"
      Height          =   255
      Left            =   7680
      TabIndex        =   55
      Top             =   5655
      Width           =   735
   End
   Begin VB.Label Label31 
      Caption         =   "Sub Addr:"
      Height          =   255
      Left            =   3000
      TabIndex        =   54
      Top             =   5655
      Width           =   735
   End
   Begin VB.Label Label30 
      Caption         =   "At Addr:"
      Height          =   255
      Left            =   7680
      TabIndex        =   52
      Top             =   5175
      Width           =   735
   End
   Begin VB.Label Label29 
      Caption         =   "Imag. Part:"
      Height          =   255
      Left            =   4920
      TabIndex        =   50
      Top             =   5175
      Width           =   975
   End
   Begin VB.Label Label28 
      Caption         =   "At Addr:"
      Height          =   255
      Left            =   3000
      TabIndex        =   48
      Top             =   5175
      Width           =   735
   End
   Begin VB.Label Label27 
      Caption         =   "Real Part:"
      Height          =   255
      Left            =   240
      TabIndex        =   46
      Top             =   5175
      Width           =   975
   End
   Begin VB.Shape Shape1 
      FillColor       =   &H0000FF00&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   7320
      Shape           =   4  'Rounded Rectangle
      Top             =   8640
      Width           =   1335
   End
   Begin VB.Line Line5 
      X1              =   240
      X2              =   9360
      Y1              =   8520
      Y2              =   8520
   End
   Begin VB.Label Label26 
      Height          =   255
      Left            =   5400
      TabIndex        =   44
      Top             =   9120
      Width           =   3135
   End
   Begin VB.Label Label25 
      Caption         =   "Time Remaining:"
      Height          =   255
      Left            =   4200
      TabIndex        =   43
      Top             =   9120
      Width           =   1455
   End
   Begin VB.Label Label24 
      Height          =   255
      Left            =   960
      TabIndex        =   42
      Top             =   9120
      Width           =   3135
   End
   Begin VB.Label Label23 
      Caption         =   "Position:"
      Height          =   255
      Left            =   240
      TabIndex        =   41
      Top             =   9120
      Width           =   735
   End
   Begin VB.Label StatusLabel 
      Height          =   255
      Left            =   840
      TabIndex        =   40
      Top             =   8760
      Width           =   4455
   End
   Begin VB.Label Label22 
      Caption         =   "Status:"
      Height          =   255
      Left            =   240
      TabIndex        =   39
      Top             =   8760
      Width           =   615
   End
   Begin VB.Label Label21 
      Caption         =   "Optical delay per point:"
      Height          =   255
      Left            =   360
      TabIndex        =   38
      Top             =   3360
      Width           =   1815
   End
   Begin VB.Line Line4 
      X1              =   360
      X2              =   9360
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Label Label20 
      Caption         =   "GHz"
      Height          =   255
      Left            =   5520
      TabIndex        =   37
      Top             =   3720
      Width           =   375
   End
   Begin VB.Label Label19 
      Caption         =   "Nyquist Frequency:"
      Height          =   255
      Left            =   360
      TabIndex        =   36
      Top             =   3720
      Width           =   1455
   End
   Begin VB.Label Label18 
      Height          =   255
      Left            =   2400
      TabIndex        =   35
      Top             =   3720
      Width           =   3015
   End
   Begin VB.Label Label17 
      Caption         =   "ps"
      Height          =   255
      Left            =   5520
      TabIndex        =   34
      Top             =   3360
      Width           =   255
   End
   Begin VB.Label Label16 
      Height          =   255
      Left            =   2400
      TabIndex        =   33
      Top             =   3360
      Width           =   3015
   End
   Begin VB.Label Label15 
      Caption         =   "mm"
      Height          =   255
      Left            =   5520
      TabIndex        =   32
      Top             =   3000
      Width           =   375
   End
   Begin VB.Label Label14 
      Caption         =   "Nanostepper Speed:"
      Height          =   255
      Left            =   360
      TabIndex        =   30
      Top             =   120
      Width           =   1575
   End
   Begin VB.Line Line3 
      X1              =   360
      X2              =   9360
      Y1              =   600
      Y2              =   600
   End
   Begin VB.Line Line2 
      X1              =   360
      X2              =   9240
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line1 
      X1              =   360
      X2              =   9360
      Y1              =   1440
      Y2              =   1440
   End
   Begin VB.Label Label13 
      Caption         =   "Zero Delay Point / mm:"
      Height          =   255
      Left            =   360
      TabIndex        =   29
      Top             =   2280
      Width           =   1695
   End
   Begin VB.Label Label9 
      Height          =   255
      Left            =   2400
      TabIndex        =   27
      Top             =   3000
      Width           =   3015
   End
   Begin VB.Label Label7 
      Caption         =   "No. Points :"
      Height          =   255
      Left            =   5760
      TabIndex        =   26
      Top             =   1800
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "No. Points :"
      Height          =   255
      Left            =   5760
      TabIndex        =   24
      Top             =   960
      Width           =   1215
   End
   Begin VB.Label Label12 
      Caption         =   "Start Point / ps:"
      Height          =   255
      Left            =   360
      TabIndex        =   22
      Top             =   1800
      Width           =   1215
   End
   Begin VB.Label Label11 
      Caption         =   "Start Point / mm:"
      Height          =   255
      Left            =   360
      TabIndex        =   20
      Top             =   960
      Width           =   1215
   End
   Begin VB.Label Label10 
      Caption         =   "End Point / ps:"
      Height          =   255
      Left            =   3360
      TabIndex        =   17
      Top             =   1800
      Width           =   1215
   End
   Begin VB.Label Label8 
      Caption         =   "End Point / mm:"
      Height          =   255
      Left            =   3360
      TabIndex        =   14
      Top             =   960
      Width           =   1215
   End
   Begin VB.Label Label6 
      Caption         =   "Delay between moving and recording / seconds (should be 10 time constants):"
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   6360
      Width           =   5775
   End
   Begin VB.Label Label5 
      Caption         =   "Output Filename:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   6840
      Width           =   2055
   End
   Begin VB.Label Label4 
      Caption         =   "Number of Averages per point:"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   4440
      Width           =   2535
   End
   Begin VB.Label Label3 
      Caption         =   "Averaging Rate:"
      Height          =   255
      Left            =   4920
      TabIndex        =   2
      Top             =   4440
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Distance per point:"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   3000
      Width           =   1455
   End
End
Attribute VB_Name = "PumpProbeAccurate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private PPAxdata()
Private PPAydata()
Private stopscan As Boolean
Private pausescan As Boolean
Private startpoint
Private distperpoint
Private numpoints As Integer
Private isset As Boolean

Private Sub Combo2_Click()

    Combo4.Clear
    
    If Combo2.ListIndex = 1 Then
        Combo4.AddItem "X"
        Combo4.AddItem "Y"
        Combo4.AddItem "R"
        Combo4.AddItem "Theta"
        Combo4.ListIndex = 0
    ElseIf Combo2.ListIndex = 2 Then
        Combo4.AddItem "Reading"
        Combo4.ListIndex = 0
    ElseIf Combo2.ListIndex = 3 Then
        For a = 1 To 8
            Combo4.AddItem "Ch " + Format(a, "#")
        Next
        Combo4.ListIndex = 0
    Else
        Combo4.AddItem "None"
        Combo4.ListIndex = 0
    End If
    
End Sub

Private Sub Combo3_Click()

    Combo5.Clear
    
    If Combo3.ListIndex = 1 Then
        Combo5.AddItem "X"
        Combo5.AddItem "Y"
        Combo5.AddItem "R"
        Combo5.AddItem "Theta"
        Combo5.ListIndex = 0
    ElseIf Combo3.ListIndex = 2 Then
        Combo5.AddItem "Reading"
        Combo5.ListIndex = 0
    ElseIf Combo3.ListIndex = 3 Then
        For a = 1 To 8
            Combo5.AddItem "Ch " + Format(a, "#")
        Next
        Combo5.ListIndex = 0
    Else
        Combo5.AddItem "None"
        Combo5.ListIndex = 0
    End If
End Sub

Private Sub Command1_Click()

    If Check1.value = 0 Or Check1.value = 2 Then
        SingleScan
    Else
        MultiMeasure
    End If

End Sub

Private Sub SingleScan()

    Dim t As Single
    Dim success As Boolean
    Dim pnt As Double
    Dim pnty As Double
    Dim tcindx As Integer
    Dim addr As Integer
    Dim addrY As Integer

    If Not (isset) Then
        MsgBox "You must set values for the scan."
        ret = 0
        GoTo fin
    End If

    If CDec(Int(distperpoint / NanoStep.GetSmallestNanoStep)) <> CDec(distperpoint / NanoStep.GetSmallestNanoStep) Then
        MsgBox "Step size does not correspond to an integer number of motor movements.", vbExclamation, "Error"
        ret = 0
        GoTo fin
    End If

    If FileExists(Text4.Text + ".dat") Then
        ret = MsgBox("Are you sure you want to overwrite the file?", vbExclamation Or vbYesNo, "File Exists")
    Else
        ret = 6
    End If
    
    If ret = 6 Then
    
        Command1.Enabled = False
        Text10.Enabled = False
        Text11.Enabled = False
        Text7.Enabled = False
        Text6.Enabled = False
        Text9.Enabled = False
        Text2.Enabled = False
        Text3.Enabled = False
        Text4.Enabled = False
        Text5.Enabled = False
        Combo1.Enabled = False
        Combo2.Enabled = False
        Combo3.Enabled = False
        Combo4.Enabled = False
        Combo5.Enabled = False
        Text13.Enabled = False
        Text12.Enabled = False
        Text14.Enabled = False
        Check1.Enabled = False
        Shape1.FillColor = &HFF
        
        addr = Int(Val(Text12.Text))
        addrY = Int(Val(Text13.Text))
        
        NanoStep.Init (Text8.Text)
        If Combo2.ListIndex = 3 Then Boxcar.SetBoxcarTrigger addr, "Internal"
        If Combo3.ListIndex = 3 Then Boxcar.SetBoxcarTrigger addrY, "Internal"
        
        StatusLabel.Caption = "Moving nanostepper to start position..."
        NanoStep.GoToPosition (startpoint)
        NanoStep.UpdateNanoStepPositionCounter
        Label24.Caption = NanoStep.CurrentPosition
    
        PPAccFout1 = FreeFile
        Open Text4.Text + ".dat" For Output As #PPAccFout1
        PPAccFout2 = FreeFile
        Open Text4.Text + "-main.dat" For Output As #PPAccFout2
        ReDim PPAxdata(0 To 0)
        ReDim PPAydata(0 To 0)
        
        Print #PPAccFout2, ";Averaged Step-by-step Pump-Probe data"
        Print #PPAccFout2, ";Nanostepper position, Averaged X data from lockin, Standard Deviation"
        strng = "/td" + vbTab + Chr(34) + "xye" + Chr(34) + vbTab + vbTab + ";define the columns"
        Print #PPAccFout2, strng
        
        Print #PPAccFout1, ";Raw Step-by-step Pump-Probe data"
        Print #PPAccFout1, ";Taking points to average at approx " + Combo1.List(Combo1.ListIndex)
        Print #PPAccFout1, ";Columns: X, Y"
        If Combo2.ListIndex = 1 And (addr = addrY) Then
            litc = SRS830_GetTimeConstant(addr, tcindx)
            Print #PPAccFout1, ";Lockin Time Constant is " + Format(litc, "0.000000") + " seconds."
            litc = SRS830_GetPhase(addr)
            Print #PPAccFout1, ";Lockin Phase Offset is " + Format(litc, "000.00") + " degrees."
        Else
            If Combo2.ListIndex = 1 Then
                litc = SRS830_GetTimeConstant(addr, tcindx)
                Print #PPAccFout1, ";Real component Lockin Time Constant is " + Format(litc, "0.000000") + " seconds."
            End If
            If Combo3.ListIndex = 1 Then
                litc = SRS830_GetTimeConstant(addrY, tcindx)
                Print #PPAccFout1, ";Imaginary Component Lockin Time Constant is " + Format(litc, "0.000000") + " seconds."
            End If
        End If
        Print #PPAccFout1, ";Waiting " + Text5.Text + " secs between stage movement and start of data collection."
        Print #PPAccFout1, ""
   
        'Calculate predicted total time for scan and set variables for 'Time Remaining guage'
        predtime = Val(Text5.Text)
        predtime = predtime + Int(Val(Text3.Text)) * (1 / (0.0625 * 2 ^ (Combo1.ListIndex)))
        predtime = predtime + distperpoint / NanoStep.CurrentSpeed
        predtime = predtime * numpoints
        Label26.Caption = FormatRemainingTime(predtime)
        timperpoint = 0
        
        starttim = Timer
   
        For a = 1 To numpoints
        
        pointstarttim = Timer
            
            t = Timer
            While (Timer < t + Val(Text5.Text))
                StatusLabel.Caption = "Waiting for lockin to settle..." + Format(CInt(t + Val(Text5.Text) - Timer), "0")
                DoEvents
            Wend
            
            Print #PPAccFout1, "Nanostepper position:"
            Print #PPAccFout1, NanoStep.CurrentPosition
            Print #PPAccFout1, "Points collected at this position at a rate of " + Combo1.List(Combo1.ListIndex) + " :"
            av = 0
            avsq = 0
            npa = 0
            StatusLabel.Caption = "Collecting Data From Lockin"
            For b = 1 To Int(Val(Text3.Text))
                Pause (1 / (0.0625 * 2 ^ (Combo1.ListIndex)))
                GetPoint pnt, pnty, addr, addrY
                Print #PPAccFout1, Format(pnt) + "," + Format(pnty)
                av = av + pnt
                avsq = avsq + pnt * pnt
                npa = npa + 1
            Next b
            av = av / npa
            avsq = avsq / npa
            sqdiff = avsq - (av * av)
            If sqdiff > 0 Then st_error = Sqr(sqdiff) Else st_error = 0
            Print #PPAccFout2, Format(NanoStep.CurrentPosition) + ", " + Format(av) + ", " + Format(st_error)
            Print #PPAccFout1, ""
            
            'av = SRS830.SRS830_ReadChannel(1, t, success)
            
            ReDim Preserve PPAxdata(0 To a - 1)
            ReDim Preserve PPAydata(0 To a - 1)
            PPAxdata(a - 1) = NanoStep.CurrentPosition
            PPAydata(a - 1) = av

            'Print #100, Format(NanoStep.CurrentPosition) + ", " + Format(av)
            
            TraceForm.PlotTrace PPAxdata, PPAydata
            'GraphForm.AddPointToGraph NanoStep.CurrentPosition, av
            DoEvents
            NanoStep.MoveTrack distperpoint
            NanoStep.UpdateNanoStepPositionCounter
            Label24.Caption = NanoStep.CurrentPosition
    
            DoEvents
            If stopscan = True Then GoTo ext
            
            'Update 'Time Remaining' Counter if we have enough points to have a good average
            pointfinishedtim = Timer
            timperpoint = timperpoint + (pointfinishedtim - pointstarttim)
            If a > 5 Then predtime = (numpoints * timperpoint / a) - (pointfinishedtim - starttim)
            Label26.Caption = FormatRemainingTime(predtime)
            
            While pausescan = True
                StatusLabel.Caption = "Paused"
                Shape1.FillColor = &HFF00&
                DoEvents
            Wend
            Shape1.FillColor = &HFF
    
        Next a
        
ext:
        
        Close #PPAccFout1
        Close #PPAccFout2
        
        Text10.Enabled = True
        Text11.Enabled = True
        Text7.Enabled = True
        Text6.Enabled = True
        Text9.Enabled = True
        Text2.Enabled = True
        Text3.Enabled = True
        Text4.Enabled = True
        Text5.Enabled = True
        Combo1.Enabled = True
        Combo2.Enabled = True
        Combo3.Enabled = True
        Combo4.Enabled = True
        Combo5.Enabled = True
        Text13.Enabled = True
        Text12.Enabled = True
        Command1.Enabled = True
        Text14.Enabled = True
        Check1.Enabled = True
        Shape1.FillColor = &HFF00&
        
        'GraphForm.Graph1.BottomTitle = "Idle"
        StatusLabel.Caption = "Finished"
        
        stopscan = False
        
    End If

fin:

End Sub

Private Sub Command2_Click()
stopscan = True
End Sub

Private Sub Command3_Click()
    TraceForm.PlotTrace PPAxdata, PPAydata
End Sub

Private Sub Command5_Click()
If Text10.Text <> "" Then startpoint = CDec(Text10.Text)
If Text7.Text <> "" Then endpoint = CDec(Text7.Text)
If Text2.Text <> "" Then numpoints = CInt(Val(Text2.Text))

If numpoints > 0 And (Text10.Text <> "" And Text7.Text <> "") Then

distperpoint = (endpoint - startpoint) / numpoints
timdistperpoint = distperpoint / 0.15
Label9.Caption = Format(distperpoint)
Label16.Caption = Format(timdistperpoint, "0.###")
Label18.Caption = Format(Abs(500 / timdistperpoint), "0.###")
Text11.Text = Format((CDec(Text1.Text) - startpoint) / 0.15)
Text9.Text = Format((CDec(Text1.Text) - endpoint) / 0.15)
Text6.Text = Format(numpoints)

'Calculate predicted total time for scan
predtime = Val(Text5.Text)
predtime = predtime + Int(Val(Text3.Text)) * (1 / (0.0625 * 2 ^ (Combo1.ListIndex)))
predtime = predtime + distperpoint / NanoStep.CurrentSpeed
predtime = predtime * numpoints
Label26.Caption = FormatRemainingTime(predtime)

isset = True

Else
MsgBox "You cannot have zero points in your scan.", vbExclamation, "Error"
End If

End Sub

Private Sub Command6_Click()

    If Text1.Text <> "" And Text11.Text <> "" Then startpoint = CDec(Text1.Text) - CDec(Text11.Text) * 0.15
    If Text1.Text <> "" And Text9.Text <> "" Then endpoint = CDec(Text1.Text) - CDec(Text9.Text) * 0.15
    If Text6.Text <> "" Then numpoints = CInt(Val(Text6.Text))

    If ((numpoints > 0 And Text11.Text <> "") And (Text1.Text <> "" And Text9.Text <> "")) Then

        distperpoint = (endpoint - startpoint) / numpoints
        timdistperpoint = distperpoint / 0.15
        Label9.Caption = Format(distperpoint)
        Label16.Caption = Format(timdistperpoint, "0.###")
        Label18.Caption = Format(Abs(500 / timdistperpoint), "0.###")
        Text10.Text = Format(startpoint)
        Text7.Text = Format(endpoint)
        Text2.Text = Format(numpoints)

        'Calculate predicted total time for scan and set variables for 'Time Remaining guage'
        predtime = Val(Text5.Text)
        predtime = predtime + Int(Val(Text3.Text)) * (1 / (0.0625 * 2 ^ (Combo1.ListIndex)))
        predtime = predtime + distperpoint / NanoStep.CurrentSpeed
        predtime = predtime * numpoints
        Label26.Caption = FormatRemainingTime(predtime)

        isset = True

    Else

        MsgBox "You cannot have zero points in your scan.", vbExclamation, "Error"
    
    End If

End Sub

Private Sub Command7_Click()

    If pausescan = True Then
        pausescan = False
        Command7.Caption = "Pause"
    Else
        pausescan = True
        Command7.Caption = "Unpause"
    End If

End Sub

Private Sub Form_Load()

    Combo1.Clear

    Combo1.AddItem "62.5 mHz"
    Combo1.AddItem "125 mHz"
    Combo1.AddItem "250 mHz"
    Combo1.AddItem "500 mHz"
    Combo1.AddItem "1 Hz"
    Combo1.AddItem "2 Hz"
    Combo1.AddItem "4 Hz"
    Combo1.AddItem "8 Hz"
    Combo1.AddItem "16 Hz"
    Combo1.AddItem "32 Hz"
    Combo1.AddItem "64 Hz"
    Combo1.AddItem "128 Hz"
    Combo1.AddItem "256 Hz"
    Combo1.AddItem "512 Hz"
    Combo1.AddItem "Trigger"
    Combo1.ListIndex = 7
    
    Combo2.Clear
    Combo2.AddItem "None"
    Combo2.AddItem "SRS830 Lockin"
    Combo2.AddItem "34401A DMM"
    Combo2.AddItem "Boxcar"
    Combo2.ListIndex = 1
    
    Combo3.Clear
    Combo3.AddItem "None"
    Combo3.AddItem "SRS830 Lockin"
    Combo3.AddItem "34401A DMM"
    Combo3.AddItem "Boxcar"
    Combo3.ListIndex = 1
    
    Combo4.Clear
    Combo4.AddItem "X"
    Combo4.AddItem "Y"
    Combo4.AddItem "R"
    Combo4.AddItem "Theta"
    Combo4.ListIndex = 0
    
    Combo5.Clear
    Combo5.AddItem "X"
    Combo5.AddItem "Y"
    Combo5.AddItem "R"
    Combo5.AddItem "Theta"
    Combo5.ListIndex = 0
    
    stopscan = False
    
End Sub

Private Function GetPoint(ByRef X, ByRef Y, addr As Integer, addrY As Integer)

    Dim pnt As Double
    Dim pnty As Double
    Dim success As Boolean
    Dim t As Single

    If ((Combo2.ListIndex = Combo3.ListIndex) And addr = addrY) Then
    
        If Combo2.ListIndex = 1 Then
            SRS830.SRS830_ReadXY addr, t, success, pnt, pnty
            X = pnt
            Y = pnty
        ElseIf Combo2.ListIndex = 2 Then
            DVM34401A.DVM34401A_GetSample (addr)
            X = pnt
            Y = pnt
        ElseIf Combo2.ListIndex = 3 Then
            X = Boxcar.BoxcarRead(addr, Combo4.ListIndex + 1)
            Y = Boxcar.BoxcarRead(addr, Combo5.ListIndex + 1)
        Else
            X = 0
            Y = 0
        End If
        
    Else
    
        'Real component reading
        If Combo2.ListIndex = 1 Then
            X = SRS830.SRS830_ReadChannel(addr, Combo4.ListIndex + 1, t, success)
        ElseIf Combo2.ListIndex = 2 Then
            X = DVM34401A.DVM34401A_GetSample(addr)
        ElseIf Combo1.ListIndex = 3 Then
            X = Boxcar.BoxcarRead(addr, Combo4.ListIndex + 1)
        Else
            X = 0
        End If
        
        'Imaginary component reading
        If Combo2.ListIndex = 1 Then
            Y = SRS830.SRS830_ReadChannel(addrY, Combo5.ListIndex + 1, t, success)
        ElseIf Combo2.ListIndex = 2 Then
            Y = DVM34401A.DVM34401A_GetSample(addrY)
        ElseIf Combo1.ListIndex = 3 Then
            Y = Boxcar.BoxcarRead(addrY, Combo5.ListIndex + 1)
        Else
            Y = 0
        End If
        
        
        
    End If

End Function

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: PumpProbeAccurate.Hide

End Sub

Private Sub MultiMeasure()

    Dim l(0 To 25)
    Dim Repeats As Integer
    Dim File As String
    
    l(0) = "a"
    l(1) = "b"
    l(2) = "c"
    l(3) = "d"
    l(4) = "e"
    l(5) = "f"
    l(6) = "g"
    l(7) = "h"
    l(8) = "i"
    l(9) = "j"
    l(10) = "k"
    l(11) = "l"
    l(12) = "m"
    l(13) = "n"
    l(14) = "o"
    l(15) = "p"
    l(16) = "q"
    l(17) = "r"
    l(18) = "s"
    l(19) = "t"
    l(20) = "u"
    l(21) = "v"
    l(22) = "w"
    l(23) = "x"
    l(24) = "y"
    l(25) = "z"

    Repeats = Val(Text14.Text)
    File = Text4.Text
    Label38.Caption = Repeats
    n = 0
    
    For a = 0 To (Repeats - 1)
        Text4.Text = File + l(a)
        n = n + 1
        Label36.Caption = n
        SingleScan
    Next a

    Label38.Caption = ""
    Label36.Caption = ""

End Sub
