VERSION 5.00
Begin VB.Form PIDTempControl 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PID Temperature Control"
   ClientHeight    =   7410
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7365
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7410
   ScaleWidth      =   7365
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3840
      TabIndex        =   38
      Text            =   "Combo2"
      Top             =   1320
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Measure Temperature"
      Height          =   495
      Left            =   5400
      TabIndex        =   13
      ToolTipText     =   "I bet you can't guess what this button does!"
      Top             =   6000
      Width           =   1695
   End
   Begin VB.TextBox Text4 
      Height          =   315
      Left            =   3840
      TabIndex        =   2
      Text            =   "5"
      Top             =   960
      Width           =   1695
   End
   Begin VB.TextBox Text18 
      Height          =   285
      Left            =   1920
      TabIndex        =   36
      Top             =   6360
      Width           =   1455
   End
   Begin VB.ComboBox Combolkin 
      Height          =   315
      Left            =   3480
      TabIndex        =   35
      Text            =   "Combolkin"
      Top             =   6360
      Width           =   1695
   End
   Begin VB.Frame Frame2 
      Caption         =   "Heater Power Parameters"
      Height          =   2415
      Left            =   120
      TabIndex        =   31
      Top             =   2880
      Width           =   3615
      Begin VB.TextBox txtMaxV 
         Height          =   315
         Left            =   2160
         TabIndex        =   6
         Text            =   "35"
         Top             =   480
         Width           =   1215
      End
      Begin VB.TextBox txtMaxSwpRate 
         Height          =   315
         Left            =   2160
         TabIndex        =   7
         Text            =   "10"
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox txtTargTemp 
         Height          =   315
         Left            =   2160
         TabIndex        =   8
         Text            =   "15"
         Top             =   1680
         Width           =   1215
      End
      Begin VB.Label Label9 
         Caption         =   "Maximum Output Voltage / V"
         Height          =   495
         Left            =   240
         TabIndex        =   34
         Top             =   360
         Width           =   1335
      End
      Begin VB.Label Label6 
         Caption         =   "Maximum Sweep Rate / K per sec"
         Height          =   495
         Left            =   240
         TabIndex        =   33
         Top             =   1080
         Width           =   1335
      End
      Begin VB.Label Label11 
         Caption         =   "Final Target Temperature / K"
         Height          =   375
         Left            =   240
         TabIndex        =   32
         Top             =   1680
         Width           =   1695
      End
   End
   Begin VB.TextBox Text3 
      Height          =   315
      Left            =   3840
      TabIndex        =   4
      Text            =   "1"
      Top             =   2040
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   3840
      TabIndex        =   0
      Top             =   240
      Width           =   1695
   End
   Begin VB.TextBox Text2 
      Height          =   315
      Left            =   3840
      TabIndex        =   3
      Top             =   1680
      Width           =   1695
   End
   Begin VB.CommandButton cmdSetup 
      Caption         =   "Set"
      Height          =   495
      Left            =   5880
      TabIndex        =   5
      ToolTipText     =   "You must press 'Set' after making any changes above the line."
      Top             =   240
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "PIDTempControl.frx":0000
      Left            =   3840
      List            =   "PIDTempControl.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   600
      Width           =   1695
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Left            =   6000
      Top             =   1200
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Left            =   6600
      Top             =   1200
   End
   Begin VB.Frame Frame1 
      Caption         =   "PID Parameters"
      Height          =   2415
      Left            =   4080
      TabIndex        =   16
      Top             =   2880
      Width           =   3135
      Begin VB.CheckBox ChkScaleProp 
         Height          =   255
         Left            =   1680
         TabIndex        =   12
         Top             =   1920
         Value           =   1  'Checked
         Width           =   495
      End
      Begin VB.TextBox txtInteg 
         Height          =   315
         Left            =   1680
         TabIndex        =   11
         Text            =   "0.5"
         Top             =   1320
         Width           =   1215
      End
      Begin VB.TextBox txtDiff 
         Height          =   315
         Left            =   1680
         TabIndex        =   10
         Text            =   "0.1"
         Top             =   840
         Width           =   1215
      End
      Begin VB.TextBox txtProp 
         Height          =   315
         Left            =   1680
         TabIndex        =   9
         Text            =   "7"
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Scale Prop. term with Temp"
         Height          =   495
         Left            =   120
         TabIndex        =   23
         Top             =   1800
         Width           =   1095
      End
      Begin VB.Label Label10 
         Height          =   375
         Left            =   120
         TabIndex        =   22
         Top             =   1800
         Width           =   1095
      End
      Begin VB.Label Label5 
         Caption         =   "Integral"
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label Label4 
         Caption         =   "Differential"
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   960
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "Proportional (at 300 K)"
         Height          =   495
         Left            =   120
         TabIndex        =   17
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.CommandButton cmdRegulateTemp 
      Caption         =   "Regulate Temperature"
      Height          =   495
      Left            =   5400
      TabIndex        =   15
      ToolTipText     =   "Don't forget to switch on the power supply to the heater"
      Top             =   6600
      Width           =   1695
   End
   Begin VB.Label Label8 
      Caption         =   "GPIB  Address of Heater PSU:"
      Height          =   255
      Left            =   240
      TabIndex        =   37
      Top             =   960
      Width           =   3255
   End
   Begin VB.Label Label17 
      Caption         =   "Lock-in reading"
      Height          =   375
      Left            =   240
      TabIndex        =   30
      Top             =   6360
      Width           =   1335
   End
   Begin VB.Label Label16 
      Caption         =   "Lock-in Sine Out Voltage:"
      Height          =   255
      Left            =   240
      TabIndex        =   29
      Top             =   2040
      Width           =   3015
   End
   Begin VB.Line Line2 
      X1              =   120
      X2              =   7200
      Y1              =   5520
      Y2              =   5520
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   7200
      Y1              =   2640
      Y2              =   2640
   End
   Begin VB.Label Label15 
      Caption         =   "GPIB Address of Temperature Monitoring Lockin:"
      Height          =   255
      Left            =   240
      TabIndex        =   28
      Top             =   240
      Width           =   3615
   End
   Begin VB.Label Label14 
      Caption         =   "Resistance of fixed resistor in circuit (ohms):"
      Height          =   255
      Left            =   240
      TabIndex        =   27
      Top             =   1680
      Width           =   3495
   End
   Begin VB.Label Label13 
      Caption         =   "Lockin Used To Monitor Temperature:"
      Height          =   255
      Left            =   240
      TabIndex        =   26
      Top             =   600
      Width           =   3495
   End
   Begin VB.Label lblCurrTargetT 
      Height          =   255
      Left            =   2160
      TabIndex        =   25
      Top             =   5880
      Width           =   1215
   End
   Begin VB.Label Label12 
      Caption         =   "Current Target / K"
      Height          =   255
      Left            =   240
      TabIndex        =   24
      Top             =   5880
      Width           =   1575
   End
   Begin VB.Label Label7 
      Caption         =   "Sensor Type :"
      Height          =   255
      Left            =   240
      TabIndex        =   21
      Top             =   1320
      Width           =   1335
   End
   Begin VB.Label lblCurrTemp 
      Height          =   375
      Left            =   2160
      TabIndex        =   20
      Top             =   6840
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Current Temperature / K"
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   6840
      Width           =   1815
   End
End
Attribute VB_Name = "PIDTempControl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    
    If Command1.Caption = "Measure Temperature" Then
        Command1.Caption = "Stop Measuring"
        
        Timer2.Enabled = True
        
        Text1.Enabled = False
        Combo1.Enabled = False
        Combo2.Enabled = False
        Text2.Enabled = False
        Text3.Enabled = False
        
    Else
        Command1.Caption = "Measure Temperature"
        lblCurrTemp.Caption = ""
        Timer2.Enabled = False
        
        Text1.Enabled = True
        Combo1.Enabled = True
        Combo2.Enabled = True
        Text2.Enabled = True
        Text3.Enabled = True
        
    End If

End Sub

Private Sub Form_Load()
    
    Text1.Text = TEMP_CONTROL_LOCKIN
    Text2.Text = FIXED_RESISTANCE_IN_CERNOX_CIRCUIT
    
    Combo1.Clear
    Combo1.AddItem "SRS830"
    Combo1.AddItem "SR510"
    Combo1.ListIndex = 0
    
    Combo2.Clear
    Combo2.AddItem "Allen Bradley"
    Combo2.AddItem "Cernox"
    If TEMP_CONTROL_TYPE = 2 Then
        Combo2.ListIndex = 0
    ElseIf TEMP_CONTROL_TYPE = 1 Then
        Combo2.ListIndex = 1
    End If
    
    Combolkin.Clear
    Combolkin.AddItem ("Micro-volts")
    Combolkin.AddItem ("Milli-volts")
    Combolkin.AddItem ("Volts")
    Combolkin.ListIndex = 0
    
    If TEMP_CONTROL_LOCKIN_MODEL = 510 Then
        Combo1.ListIndex = 1
    Else
        Combo1.ListIndex = 0
    End If

    txtTargTemp.Text = 15
    
    Timer1.Enabled = False
    Timer2.Enabled = False
    Timer1.Interval = 300
    Timer2.Interval = 300
    Timer1.Enabled = False
    Timer2.Enabled = False
    
    SetOutputV 0, Int(Val(Text4.Text))
    
End Sub

Private Sub cmdSetup_Click()
    
    Dim PSUaddr As Integer
    
    TEMP_CONTROL_LOCKIN = Int(Val(Text1.Text))
    FIXED_RESISTANCE_IN_CERNOX_CIRCUIT = CDec(Text2.Text)

    If Combo1.ListIndex = 1 Then
        TEMP_CONTROL_LOCKIN_MODEL = 510
    Else
        TEMP_CONTROL_LOCKIN_MODEL = 830
    End If
    
    PSUaddr = Val(Text4.Text) 'For the heater
    
End Sub

Private Sub cmdRegulateTemp_Click()

    Dim PSUaddr As Integer
    
    PSUaddr = Val(Text4.Text)
    
    If cmdRegulateTemp.Caption = "Regulate Temperature" Then
        cmdRegulateTemp.Caption = "Stop Regulating"
        
        Command1.Enabled = False
        txtMaxV.Enabled = False
        txtMaxSwpRate.Enabled = False
        txtTargTemp.Enabled = False
        txtProp.Enabled = False
        txtDiff.Enabled = False
        txtInteg.Enabled = False
        ChkScaleProp.Enabled = False
        Text1.Enabled = False
        Combo1.Enabled = False
        Combo2.Enabled = False
        Text4.Enabled = False
        Text2.Enabled = False
        Text3.Enabled = False
        cmdSetup.Enabled = False
        
        gIntgValue = 0
        gSweepT = Val(lblCurrTemp.Caption)
        
        PSU_TSX3510P.OperateOP 1, PSUaddr
        
        Timer2.Enabled = True
        Timer1.Enabled = True
    Else
        SetOutputV 0, PSUaddr
        cmdRegulateTemp.Caption = "Regulate Temperature"
        Command1.Caption = "Stop Measuring"
        lblCurrTargetT = ""
        
        Command1.Enabled = True
        txtMaxV.Enabled = True
        txtMaxSwpRate.Enabled = True
        txtTargTemp.Enabled = True
        txtProp.Enabled = True
        txtDiff.Enabled = True
        txtInteg.Enabled = True
        ChkScaleProp.Enabled = True
        Text4.Enabled = True
        cmdSetup.Enabled = True
        
        PSU_TSX3510P.OperateOP 0, PSUaddr
        Command1.Enabled = True
        
        Timer1.Enabled = False
    End If
    
End Sub

Private Sub Timer1_Timer()

    Static OldT, LastTime As Single
    
    Dim OutputVoltage As Single
    Dim PSUaddr As Integer
    Dim NewT As Double
    Dim Thermometer As Integer
    
    DoEvents
    
    'Thermometer_Type :- 1 = Cernox; 2 = Allen Bradley
    If Combo2.ListIndex = 0 Then Thermometer = 2
    If Combo2.ListIndex = 1 Then Thermometer = 1
    
    ThisTime = Timer
    If LastTime = 0 Then LastTime = ThisTime
    DeltaTime = ThisTime - LastTime
    
    gProp = Val(txtProp.Text)
    gDiff = Val(txtDiff.Text)
    gIntg = Val(txtInteg.Text)
    gtIntgValue = 0
    gSweepT = Val(lblCurrTemp.Caption)
    gMaxV = Val(txtMaxV.Text)
    gMaxSweepRate = Val(txtMaxSwpRate.Text)
    PSUaddr = Val(Text4.Text) 'For the heater
    
    If TEMP_CONTROL_LOCKIN_MODEL = 830 Then
        sineout = -1
        reading = -1
    ElseIf TEMP_CONTROL_LOCKIN_MODEL = 510 Then
        sineout = CDec(Text3.Text)
        reading = -1
    End If
    
    c = (0.001) ^ (2 - CInt(Combolkin.ListIndex))
    
    SetT = Val(txtTargTemp.Text)
    NewT = Globals.GetTemperature(CDec(Text3.Text), c * CDec(Val(Text18.Text)), Thermometer)
    
    If ChkScaleProp = True Then
        Prop = gProp * NewT / 300   'Scale proportional term with current temperature
    Else
        Prop = gProp
    End If
    
    If OldT = 0 Then OldT = NewT

    If gSweepT < SetT Then
        gSweepT = gSweepT + gMaxSweepRate * DeltaTime
    ElseIf gSweepT > SetT Then
        gSweepT = gSweepT - gMaxSweepRate * DeltaTime
    End If
    
    lblCurrTargetT.Caption = Format$(gSweepT, "###.#")

    If Abs(SetT - gSweepT) < (gMaxSweepRate * DeltaTime) Then gSweepT = SetT

    gIntgValue = gIntgValue + (gSweepT - NewT)
    OutputVoltage = Prop * (gSweepT - NewT) + gDiff * (NewT - OldT) + gIntg * gIntgValue

    If OutputVoltage > gMaxV Then OutputVoltage = gMaxV
    If OutputVoltage < 0 Then OutputVoltage = 0

    PSU_TSX3510P.SetOutputV OutputVoltage, PSUaddr
        
    OldT = NewT
    LastTime = ThisTime
    
End Sub

Private Sub Timer2_Timer()

    Dim sineout
    Dim reading
    Dim Thermometer As Integer
    
    'Thermometer_Type :- 1 = Cernox; 2 = Allen Bradley
    If Combo2.ListIndex = 0 Then Thermometer = 2
    If Combo2.ListIndex = 1 Then Thermometer = 1

    If TEMP_CONTROL_LOCKIN_MODEL = 830 Then
        sineout = -1
        reading = -1
        t = AutoGetTemperature(TEMP_CONTROL_LOCKIN, TEMP_CONTROL_LOCKIN_MODEL, Thermometer, sineout, reading)
    ElseIf TEMP_CONTROL_LOCKIN_MODEL = 510 Then
        sineout = CDec(Text3.Text)
        reading = -1
        t = AutoGetTemperature(TEMP_CONTROL_LOCKIN, TEMP_CONTROL_LOCKIN_MODEL, Thermometer, sineout, reading)
    End If

    lblCurrTemp.Caption = Format(t, "0.000")

    If sineout <> -1 Then
        Text3.Text = Format(sineout, "0.000")
    End If

    If reading <> -1 Then
        Text18.Text = Format(reading * 1000000, "0.00")
        Combolkin.ListIndex = 0
    End If

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        Timer1.Enabled = False
        Timer2.Enabled = False
        PIDTempControl.Hide
    End If

End Sub
