VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Begin VB.Form PulseAttenuation 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Pulse Attenuation"
   ClientHeight    =   8760
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3495
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8760
   ScaleWidth      =   3495
   WhatsThisHelp   =   -1  'True
   Begin VB.TextBox txtAverages 
      Height          =   285
      Left            =   1680
      TabIndex        =   29
      Text            =   "600"
      Top             =   3360
      Width           =   855
   End
   Begin VB.TextBox txtScpAddr 
      Height          =   285
      Left            =   1680
      TabIndex        =   26
      Text            =   "3"
      Top             =   2760
      Width           =   855
   End
   Begin VB.Frame Frame1 
      Caption         =   "Bolometer Bias Subtraction"
      Height          =   735
      Left            =   480
      TabIndex        =   22
      Top             =   3960
      Width           =   2295
      Begin VB.OptionButton Option3 
         Caption         =   "Off"
         Height          =   375
         Left            =   1560
         TabIndex        =   23
         Top             =   240
         Value           =   -1  'True
         Width           =   615
      End
      Begin VB.OptionButton Option2 
         Caption         =   "-ve"
         Height          =   375
         Left            =   840
         TabIndex        =   24
         Top             =   240
         Width           =   975
      End
      Begin VB.OptionButton Option1 
         Caption         =   "+ve"
         Height          =   375
         Left            =   120
         TabIndex        =   25
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.ComboBox CardCombo 
      Height          =   315
      Left            =   840
      TabIndex        =   21
      Top             =   2160
      Width           =   1815
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   240
      TabIndex        =   19
      Top             =   5160
      Width           =   2775
   End
   Begin VB.CommandButton cmdSetPara 
      Caption         =   "Set Parameters"
      Height          =   255
      Left            =   840
      TabIndex        =   18
      Top             =   1800
      Width           =   1815
   End
   Begin VB.CommandButton cmdSet 
      BackColor       =   &H000000FF&
      Caption         =   "Set Attenuation"
      Height          =   255
      Left            =   840
      TabIndex        =   16
      ToolTipText     =   "Set the attenuation level but don't measure anything "
      Top             =   1440
      Width           =   1815
   End
   Begin VB.TextBox txtAttenStep 
      Height          =   285
      Left            =   2280
      TabIndex        =   15
      Text            =   "1"
      Top             =   6720
      Width           =   375
   End
   Begin VB.TextBox txtAttenRange1 
      Height          =   285
      Left            =   240
      TabIndex        =   14
      Text            =   "1"
      Top             =   6720
      Width           =   375
   End
   Begin VB.TextBox txtAttenRange2 
      Height          =   315
      Left            =   960
      TabIndex        =   13
      Text            =   "63"
      Top             =   6720
      Width           =   375
   End
   Begin Spin.SpinButton SpinButton2 
      Height          =   735
      Left            =   480
      TabIndex        =   10
      Top             =   600
      Width           =   375
      _Version        =   65536
      _ExtentX        =   661
      _ExtentY        =   1296
      _StockProps     =   73
      BorderColor     =   -2147483646
   End
   Begin Spin.SpinButton SpinButton1 
      Height          =   735
      Left            =   2640
      TabIndex        =   9
      Top             =   600
      Width           =   375
      _Version        =   65536
      _ExtentX        =   661
      _ExtentY        =   1296
      _StockProps     =   73
      BorderColor     =   -2147483646
   End
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H80000005&
      Caption         =   "Measure"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Index           =   0
      Left            =   1920
      TabIndex        =   1
      ToolTipText     =   "Take an averaged measurement at this attenuation"
      Top             =   5880
      Width           =   1005
   End
   Begin VB.CommandButton cmdSweep 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Sweep"
      Height          =   375
      Left            =   1920
      TabIndex        =   0
      ToolTipText     =   "Sweep through the attenuation taking an averaged measurement at each step"
      Top             =   7200
      Width           =   1005
   End
   Begin VB.Label Label10 
      Caption         =   "Number of Scope Averages"
      Height          =   495
      Left            =   120
      TabIndex        =   28
      Top             =   3360
      Width           =   1455
   End
   Begin VB.Label Label9 
      Caption         =   "Scope Address"
      Height          =   255
      Left            =   360
      TabIndex        =   27
      Top             =   2760
      Width           =   1215
   End
   Begin VB.Label Label8 
      Caption         =   "Directory in which to save data in:"
      Height          =   255
      Left            =   240
      TabIndex        =   20
      Top             =   4920
      Width           =   2535
   End
   Begin VB.Line Line3 
      X1              =   240
      X2              =   3000
      Y1              =   6480
      Y2              =   6480
   End
   Begin VB.Line Line2 
      BorderWidth     =   2
      X1              =   240
      X2              =   3000
      Y1              =   7800
      Y2              =   7800
   End
   Begin VB.Label Label7 
      BackColor       =   &H0000FF00&
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   360
      TabIndex        =   17
      Top             =   8040
      Width           =   2655
   End
   Begin VB.Label Label6 
      Caption         =   "Measure at this level of attenuation"
      Height          =   615
      Left            =   360
      TabIndex        =   12
      Top             =   5760
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1440
      TabIndex        =   11
      Top             =   720
      Width           =   855
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      Caption         =   "+/- 10dB"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   2670
      TabIndex        =   8
      Top             =   360
      Width           =   645
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      Caption         =   "+/- 1dB"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   360
      Width           =   615
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Caption         =   "Attenuation/ dB"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   405
      Left            =   1290
      TabIndex        =   6
      Top             =   150
      Width           =   1005
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label34 
      Appearance      =   0  'Flat
      Caption         =   "dB"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   2760
      TabIndex        =   5
      Top             =   6720
      Width           =   315
   End
   Begin VB.Label Label28 
      Appearance      =   0  'Flat
      Caption         =   "dB, step = "
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   1440
      TabIndex        =   4
      Top             =   6720
      Width           =   945
   End
   Begin VB.Label Label27 
      Appearance      =   0  'Flat
      Caption         =   "to"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   720
      TabIndex        =   3
      Top             =   6720
      Width           =   315
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   240
      X2              =   3000
      Y1              =   5640
      Y2              =   5640
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Caption         =   " Swept attenuation"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   240
      TabIndex        =   2
      Top             =   7260
      Width           =   1665
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "PulseAttenuation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim att_level As Integer

Private Sub Form_Load()

    att_level = 0
    Label4.Caption = att_level
    PulseAttenuator.SetAttenuator 63 - att_level, 14
    CardCombo.AddItem ("Eclipse")
    CardCombo.AddItem ("Digitiser")
    CardCombo.AddItem ("DPO 7054 Scope")
    CardCombo.ListIndex = 2
    
End Sub
Private Sub cmdSetPara_Click()

    MsgBox "For use with the Eclipse go to the Eclipse form" & vbCr & "and press 'Init' this will start the Eclipse software.  Set the" & vbCr & "parameters from within the Eclipse software.  In order to" & vbCr & "change the measurement parameters Scan and the Eclipse software" & vbCr & "must be restarted" & vbCr & vbCr & "For use with the Digitiser go to the Digitiser" & vbCr & "form and set the parameters required", vbOKOnly, "Set Parameters"
    
End Sub
Private Sub cmdSet_Click()

    att_level = Label4.Caption
    PulseAttenuator.SetAttenuator 63 - att_level, 14

End Sub

Private Sub cmdOK_Click(att_level As Integer)
    
    Dim ScpAddr As Integer
    Dim NumAvs As Single
    
    att_level = Label4.Caption
    PulseAttenuator.SetAttenuator 63 - att_level, 14
    ScpAddr = Val(txtScpAddr.Text)
    NumAvs = Val(txtAverages)
    
    If CardCombo.ListIndex = 0 Then
        EclipseFrm.GetAndSaveEclipseTrace (Text1.Text & " " & Label4.Caption & " dB attenuation.dat")
    ElseIf CardCombo.ListIndex = 1 Then
        'Set bias switch to initial state
        If Option1.value = True Then
            BiasSwitch.SetBias (0)
        ElseIf Option2.value = True Then
            BiasSwitch.SetBias (1)
        End If
        
        'Take Trace
        dat = Digitiser.GetTrace(xdata, ydata)

        'Set bias switch and take 2nd trace
        If Option3.value = False Then
            BiasSwitch.FlipBias
            dat2 = Digitiser.GetTrace(xdata2, ydata2)
        End If

        'Subtract Traces
        If Option3.value = False Then
            For a = LBound(xdata) To UBound(xdata)
                ydata(a) = ydata(a) - ydata2(a)
            Next a
        End If
    Else
        'set the bolometer bias direction
        If Option1.value = True Then
            BiasSwitch.SetBias (0)
        ElseIf Option2.value = True Then
            BiasSwitch.SetBias (1)
        End If
    
        'take a bolometer trace
        AvgTrace = Scope_DPO7054.DPO_ScopeAverageTrace(xdata, ydata, ScpAddr, NumAvs)
            
        'If bias subtraction is on flip the bias and take a bolometer trace
        If Option3.value = False Then
            BiasSwitch.FlipBias
            AvgTrace2 = Scope_DPO7054.DPO_ScopeAverageTrace(xdata2, ydata2, ScpAddr, NumAvs)
        End If
        
        'Subtract Traces if bias subtraction is on
        If Option3.value = False Then
            For a = LBound(xdata) To UBound(xdata)
                ydata(a) = ydata(a) - ydata2(a)
            Next a
        End If
    End If
    
    Open Text1.Text & " " & Label4.Caption & " dB attenuation.dat" For Output As #1
    For a = LBound(ydata) To UBound(ydata)
            Print #1, Format(xdata(a), "0.00000E-00") + ", " + Format(ydata(a), "0.00000E-00")
    Next a
    Close #1
    
End Sub

Private Sub cmdSweep_Click()
    
    Dim MinAtt As Integer
    Dim MaxAtt As Integer
    Dim StepAtt As Integer
    Dim StopMeasurement As Boolean
    
    StopMeasurement = False
    
    If cmdSweep.Caption = "Sweep" Then
        cmdSweep.Caption = "Stop"
        Label7.BackColor = &HFF&
    
        MinAtt = Val(txtAttenRange1.Text)
        MaxAtt = Val(txtAttenRange2.Text)
        StepAtt = Val(txtAttenStep.Text)
    
        If MinAtt < 0 Then MinAtt = 0
        If MaxAtt > 63 Then MaxAtt = 0
    
        For att_level = MinAtt To MaxAtt Step StepAtt
            Label4.Caption = att_level
            cmdOK_Click att_level
            If StopMeasurement = True Then GoTo ext:
        Next
    
        Label7.BackColor = &HFF00&
        cmdSweep.Caption = "Sweep"
        
    Else
        cmdSweep.Caption = "Sweep"
        Label7.BackColor = &HFF00&
        StopMeasurement = True
   End If
   
ext:
    
End Sub

Private Sub SpinButton1_SpinUp()
     
    att_level = att_level + 10
    If att_level > 63 Then att_level = 63
    Label4.Caption = att_level
    
End Sub

Private Sub SpinButton1_SpinDown()
    
    att_level = att_level - 10
    If att_level < 0 Then att_level = 0
    Label4.Caption = att_level
    
End Sub

Private Sub SpinButton2_SpinUp()
     
    att_level = att_level + 1
    If att_level > 63 Then att_level = 63
    Label4.Caption = att_level
    
End Sub

Private Sub SpinButton2_SpinDown()
    
    att_level = att_level - 1
    If att_level < 0 Then att_level = 0
    Label4.Caption = att_level
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        PulseAttenuation.Hide
    End If

End Sub
