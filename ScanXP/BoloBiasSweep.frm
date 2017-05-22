VERSION 5.00
Begin VB.Form BoloBiasSweep 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bolometer Measurement and Bias Sweep"
   ClientHeight    =   3960
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9510
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3960
   ScaleWidth      =   9510
   Begin VB.Frame Frame3 
      Caption         =   "Bias Sweep Parameters"
      Height          =   1695
      Left            =   4680
      TabIndex        =   14
      Top             =   120
      Width           =   4695
      Begin VB.TextBox txtMinBias 
         Height          =   285
         Left            =   720
         TabIndex        =   20
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox txtMaxBias 
         Height          =   285
         Left            =   1920
         TabIndex        =   19
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox txtStepBias 
         Height          =   285
         Left            =   3120
         TabIndex        =   18
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox txtSetBias 
         Height          =   285
         Left            =   1680
         TabIndex        =   16
         Top             =   1200
         Width           =   1215
      End
      Begin VB.CommandButton cmdSetBias 
         Caption         =   "Set Single Trace Voltage"
         Height          =   495
         Left            =   240
         TabIndex        =   15
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label6 
         Caption         =   "From"
         Height          =   255
         Left            =   240
         TabIndex        =   24
         Top             =   360
         Width           =   495
      End
      Begin VB.Label Label7 
         Caption         =   "V to"
         Height          =   255
         Left            =   1560
         TabIndex        =   23
         Top             =   360
         Width           =   375
      End
      Begin VB.Label Label8 
         Caption         =   "V in"
         Height          =   255
         Left            =   2760
         TabIndex        =   22
         Top             =   360
         Width           =   495
      End
      Begin VB.Label Label9 
         Caption         =   "V steps"
         Height          =   255
         Left            =   3960
         TabIndex        =   21
         Top             =   360
         Width           =   615
      End
      Begin VB.Label Label2 
         Caption         =   "V"
         Height          =   255
         Left            =   3000
         TabIndex        =   17
         Top             =   1200
         Width           =   375
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Device Configuration"
      Height          =   3135
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   4215
      Begin VB.TextBox txtSaveData 
         Height          =   285
         Left            =   120
         TabIndex        =   27
         Top             =   2640
         Width           =   3975
      End
      Begin VB.TextBox txtDVSAddr 
         Height          =   315
         Left            =   3120
         TabIndex        =   25
         Text            =   "13"
         Top             =   1680
         Width           =   735
      End
      Begin VB.TextBox txtNumAvs 
         Height          =   285
         Left            =   3120
         TabIndex        =   12
         Text            =   "600"
         Top             =   1200
         Width           =   735
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         ItemData        =   "BoloBiasSweep.frx":0000
         Left            =   1920
         List            =   "BoloBiasSweep.frx":0002
         TabIndex        =   9
         Top             =   240
         Width           =   1935
      End
      Begin VB.TextBox txtScpAddr 
         Height          =   285
         Left            =   3120
         TabIndex        =   8
         Text            =   "3"
         Top             =   720
         Width           =   735
      End
      Begin VB.Label Label3 
         Caption         =   "Directory in which to save data:"
         Height          =   375
         Left            =   120
         TabIndex        =   28
         Top             =   2280
         Width           =   3375
      End
      Begin VB.Label Label10 
         Caption         =   "Voltage source address:"
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   1680
         Width           =   1815
      End
      Begin VB.Label Label15 
         Caption         =   "Number of scope averages (optional):"
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   1200
         Width           =   2655
      End
      Begin VB.Label Label14 
         Caption         =   "Read device:"
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label13 
         Caption         =   "Scope address (optional):"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   720
         Width           =   1935
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Bolometer Bias Subtraction"
      Height          =   735
      Left            =   4680
      TabIndex        =   3
      Top             =   2280
      Width           =   2295
      Begin VB.OptionButton Option3 
         Caption         =   "Off"
         Height          =   375
         Left            =   1560
         TabIndex        =   6
         Top             =   240
         Value           =   -1  'True
         Width           =   615
      End
      Begin VB.OptionButton Option2 
         Caption         =   "-ve"
         Height          =   375
         Left            =   840
         TabIndex        =   5
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton Option1 
         Caption         =   "+ve"
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.CommandButton cmdSweep 
      Caption         =   "Bias Sweep Measurement"
      Height          =   495
      Left            =   7200
      TabIndex        =   1
      Top             =   2760
      Width           =   2055
   End
   Begin VB.CommandButton cmdMeasure 
      Caption         =   "Single Trace Measurement"
      Height          =   495
      Left            =   7200
      TabIndex        =   0
      Top             =   2040
      Width           =   2055
   End
   Begin VB.Label lblStatus 
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   3480
      Width           =   9255
   End
End
Attribute VB_Name = "BoloBiasSweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()

    lblStatus.BackColor = &HFF00&
    
    Combo1.AddItem "DPO 7054 Scope", 0
    Combo1.AddItem "Digitiser", 1
    Combo1.ListIndex = 0
    
End Sub

Private Sub cmdSetBias_Click()
    
    Dim Bias As Single
    Dim DVSAddr As Integer
    
    DVSAddr = Val(txtDVSAddr.Text)
    Bias = Val(txtSetBias.Text)
    
    DVS.DVS_SetVoltage Bias, DVSAddr
        
End Sub
Public Sub Measure(Bias_level As Single)

    Dim DVSAddr As Integer
    Dim ScpAddr As Integer
    Dim NumAvs As Single
    
    ScpAddr = Val(txtScpAddr)
    DVSAddr = Val(txtDVSAddr.Text)
    Bias = Val(txtSetBias.Text)
    NumAvs = Val(txtNumAvs.Text)
    
    'make sure the address boxes are complete
    If Combo1.ListIndex = 0 And txtScpAddr.Text = "" Then
        Z = MsgBox("The scope address is missing", vbOKOnly, "Error")
        GoTo ext:
    End If
    
    If txtDVSAddr.Text = "" Then
        Z = MsgBox("The voltage source address is missing", vbOKOnly, "Error")
        GoTo ext:
    End If
    
    'Apply the voltage source voltage
    DVS.DVS_SetVoltage Bias_level, DVSAddr
    DVS.DVS_Operate DVSAddr
        
    'set the bolometer bias direction
    If Option1.value = True Then
        BiasSwitch.SetBias (0)
    ElseIf Option2.value = True Then
        BiasSwitch.SetBias (1)
    End If
    
    'take a bolometer trace
    If Combo1.ListIndex = 0 Then
        AvgTrace = Scope_DPO7054.DPO_ScopeAverageTrace(xdata, ydata, ScpAddr, NumAvs)
    Else
        dat = Digitiser.GetTrace(xdata, ydata)
    End If
    
    'If bias subtraction is on flip the bias and take a bolometer trace
    If Option3.value = False Then
        BiasSwitch.FlipBias
        If Combo1.ListIndex = 0 Then
            AvgTrace2 = Scope_DPO7054.DPO_ScopeAverageTrace(xdata2, ydata2, ScpAddr, NumAvs)
        Else
            dat2 = Digitiser.GetTrace(xdata2, ydata2)
        End If
    End If
        
    'Subtract Traces if bias subtraction is on
    If Option3.value = False Then
        For a = LBound(xdata) To UBound(xdata)
            ydata(a) = ydata(a) - ydata2(a)
        Next a
    End If

    'save the data file
    Open txtSaveData.Text & "_" & Format(Bias_level, "0.0000") & "V.dat" For Output As #1
    For H = 1 To (UBound(xdata) - LBound(xdata))
        Print #1, xdata(H), ydata(H)
    Next H
    Close #1

    'Display the resulting trace
    TraceForm.Show
    TraceForm.PlotTrace xdata, ydata
    
ext:

End Sub


Private Sub cmdMeasure_Click()

    BoloBiasSweep.Measure (Val(txtSetBias.Text))
    DVS.DVS_Standby (Val(txtDVSAddr.Text))

End Sub

Private Sub cmdSweep_Click()

    Dim MinBias As Single
    Dim MaxBias As Single
    Dim BiasStep As Single
    Dim StopMeasurement As Boolean
    Dim Bias_level As Single
    
    StopMeasurement = False
    DVSAddr = Val(txtDVSAddr.Text)
    
    If txtMinBias.Text = "" Or txtMaxBias.Text = "" Or txtStepBias.Text = "" Then
        k = MsgBox("You must fill in the sweep parameters.", vbOKOnly, "Error")
        GoTo ext:
    End If
    
    If cmdSweep.Caption = "Bias Sweep Measurement" Then
        cmdSweep.Caption = "Stop"
        lblStatus.BackColor = &HFF&
    
        MinBias = Val(txtMinBias.Text)
        MaxBias = Val(txtMaxBias.Text)
        StepBias = Val(txtStepBias.Text)
        
        Bias_level = MinBias
        For Bias_level = MinBias To (MaxBias + StepBias) Step StepBias
            Measure (Bias_level)
            If StopMeasurement = True Then GoTo ext:
        Next
    
        lblStatus.BackColor = &HFF00&
        cmdSweep.Caption = "Bias Sweep Measurement"
        
    Else
        cmdSweep.Caption = "Bias Sweep Measurement"
        lblStatus.BackColor = &HFF00&
        StopMeasurement = True
   End If
   
ext:

   DVS.DVS_Standby (DVSAddr)

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        BoloBiasSweep.Hide
    End If

End Sub
