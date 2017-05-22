VERSION 5.00
Begin VB.Form TempControl 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Temperature Control"
   ClientHeight    =   5835
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8235
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5835
   ScaleWidth      =   8235
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   3840
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   1320
      Width           =   1695
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3840
      Style           =   2  'Dropdown List
      TabIndex        =   15
      Top             =   600
      Width           =   1695
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   7200
      Top             =   2160
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   4200
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   3240
      Width           =   1935
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   2640
      TabIndex        =   12
      Text            =   "1"
      Top             =   3240
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Manual"
      Height          =   495
      Left            =   6720
      TabIndex        =   10
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   2640
      TabIndex        =   7
      Text            =   "1"
      Top             =   2880
      Width           =   1455
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Auto-Measure:"
      Height          =   495
      Left            =   240
      TabIndex        =   5
      Top             =   2040
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Set"
      Height          =   495
      Left            =   5880
      TabIndex        =   4
      Top             =   240
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   3840
      TabIndex        =   3
      Top             =   960
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   3840
      TabIndex        =   1
      Top             =   240
      Width           =   1695
   End
   Begin VB.Label Label8 
      Caption         =   "Sensor Type:"
      Height          =   255
      Left            =   240
      TabIndex        =   16
      Top             =   1320
      Width           =   3375
   End
   Begin VB.Label Label3 
      Caption         =   "Lockin Used To Monitor Temperature:"
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   600
      Width           =   3495
   End
   Begin VB.Label Label7 
      Caption         =   "Lockin Reading Magnitude:"
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   3240
      Width           =   2535
   End
   Begin VB.Label Label6 
      Height          =   255
      Left            =   2640
      TabIndex        =   9
      Top             =   3720
      Width           =   1575
   End
   Begin VB.Label Label5 
      Caption         =   "Temperature (K):"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   3720
      Width           =   2175
   End
   Begin VB.Label Label4 
      Caption         =   "Lockin Sine-Out Voltage (V):"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   2880
      Width           =   2535
   End
   Begin VB.Line Line2 
      X1              =   240
      X2              =   7920
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line1 
      X1              =   240
      X2              =   7920
      Y1              =   1920
      Y2              =   1920
   End
   Begin VB.Label Label2 
      Caption         =   "Resistance of fixed resistor in circuit (ohms):"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   960
      Width           =   3495
   End
   Begin VB.Label Label1 
      Caption         =   "GPIB Address of Temperature Monitoring Lockin:"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   3615
   End
End
Attribute VB_Name = "TempControl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Check1_Click()

If Check1.value = 1 Then
    Timer1.Enabled = True
Else
    Timer1.Enabled = False
End If

End Sub

Private Sub Command1_Click()
TEMP_CONTROL_LOCKIN = Int(Val(Text1.Text))
FIXED_RESISTANCE_IN_CERNOX_CIRCUIT = CDec(Text2.Text)

If Combo2.ListIndex = 1 Then
    TEMP_CONTROL_LOCKIN_MODEL = 510
Else
    TEMP_CONTROL_LOCKIN_MODEL = 830
End If

TEMP_CONTROL_TYPE = Combo3.ListIndex + 1

End Sub

Private Sub Command2_Click()
c = (0.001) ^ (2 - CInt(Combo1.ListIndex))
t = GetTemperature(CDec(Text3.Text), c * CDec(Text4.Text), TEMP_CONTROL_TYPE)
Label6.Caption = Format(t, "0.000")
End Sub

Private Sub Form_Load()

Text1.Text = TEMP_CONTROL_LOCKIN
Text2.Text = FIXED_RESISTANCE_IN_CERNOX_CIRCUIT
Combo1.Clear
Combo1.AddItem ("Micro-volts")
Combo1.AddItem ("Milli-volts")
Combo1.AddItem ("Volts")
Combo1.ListIndex = 0

Combo2.Clear
Combo2.AddItem "SRS830"
Combo2.AddItem "SR510"
If TEMP_CONTROL_LOCKIN_MODEL = 510 Then
    Combo2.ListIndex = 1
Else
    Combo2.ListIndex = 0
End If

Combo3.Clear
Combo3.AddItem "Cernox"
Combo3.AddItem "Allen Bradley"
Combo3.ListIndex = TEMP_CONTROL_TYPE - 1
    
End Sub

Private Sub Timer1_Timer()

Dim sineout
Dim reading

If TEMP_CONTROL_LOCKIN_MODEL = 830 Then
    sineout = -1
    reading = -1
    t = AutoGetTemperature(TEMP_CONTROL_LOCKIN, TEMP_CONTROL_LOCKIN_MODEL, TEMP_CONTROL_TYPE, sineout, reading)
ElseIf TEMP_CONTROL_LOCKIN_MODEL = 510 Then
    sineout = CDec(Text3.Text)
    reading = -1
    t = AutoGetTemperature(TEMP_CONTROL_LOCKIN, TEMP_CONTROL_LOCKIN_MODEL, TEMP_CONTROL_TYPE, sineout, reading)
End If

Label6.Caption = Format(t, "0.000")

If sineout <> -1 Then
    Text3.Text = Format(sineout, "0.000")
End If

If reading <> -1 Then
    Text4.Text = Format(reading * 1000000, "0.00")
    Combo1.ListIndex = 0
End If


End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        Timer1.Enabled = False
        Check1.value = 0
        TempControl.Hide
    End If

End Sub
