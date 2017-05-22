VERSION 5.00
Begin VB.Form Calibration 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Thrmometer Calibration"
   ClientHeight    =   3435
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5790
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3435
   ScaleWidth      =   5790
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   3000
      TabIndex        =   8
      Text            =   "Combo1"
      Top             =   1920
      Width           =   1455
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   3000
      TabIndex        =   7
      Top             =   1320
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Create data file and start calibration"
      Height          =   375
      Left            =   480
      TabIndex        =   5
      Top             =   720
      Width           =   3975
   End
   Begin VB.Timer Timer1 
      Left            =   3120
      Top             =   2520
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1320
      TabIndex        =   2
      Top             =   120
      Width           =   3495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Measure"
      Height          =   495
      Left            =   3600
      TabIndex        =   0
      Top             =   2520
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Thermometer type used to monitor temperature during calibration"
      Height          =   375
      Left            =   120
      TabIndex        =   9
      Top             =   1920
      Width           =   2655
   End
   Begin VB.Label Label1 
      Caption         =   "Read lock-in address :"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1320
      Width           =   1695
   End
   Begin VB.Label lblCurrTemp 
      Height          =   255
      Left            =   2040
      TabIndex        =   4
      Top             =   2640
      Width           =   855
   End
   Begin VB.Label Label4 
      Caption         =   "Current Temperature (k) :"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   2640
      Width           =   1935
   End
   Begin VB.Label Label3 
      Caption         =   "Save data as :"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "Calibration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()

    Timer1.Interval = 300
    Timer1.Enabled = True
    TEMP_CONTROL_LOCKIN_MODEL = 830
    
    Combo1.Clear
    Combo1.AddItem "Cernox"
    Combo1.AddItem "Allen Bradley"
    Combo1.ListIndex = 0
    
End Sub
Private Sub Command2_Click()

    Dim Savas As String
    Dim ret As Variant
        
    Saveas = Text3.Text + ".txt"
    
    'If FileExists(Saveas) Then
        'ret = MsgBox("Are you sure you want to overwrite this file?", vbYesNo, "File Already Exists")
    'End If
    
    'If ret = vbNo Then GoTo ext
           
    If Command2.Caption = "Create data file and start calibration" Then
        Command2.Caption = "End calibration"
        Open Saveas For Output As #1
        Print #1, "Temperature", "Lock-in reading"
    Else
        Command2.Caption = "Create data file and start calibration"
        Close #1
    End If

ext:

End Sub
Private Sub Command1_Click()
    
    Dim success As Boolean
    
    X = SRS830.SRS830_ReadChannel(Val(Text4.Text), 1, t, success)
    Print #1, lblCurrTemp.Caption, X
   
End Sub

Private Sub Timer1_Timer()

    Dim sineout
    Dim reading
    Dim Thermometer As Integer
    
    If Combo1.ListIndex = 0 Then Thermometer = 1
    If Combo1.ListIndex = 1 Then Thermometer = 2
    
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

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        Timer1.Enabled = False
        Calibration.Hide
    End If

End Sub
