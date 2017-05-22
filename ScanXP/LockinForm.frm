VERSION 5.00
Begin VB.Form LockinForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Lockin Control"
   ClientHeight    =   6045
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8475
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6045
   ScaleWidth      =   8475
   Begin VB.ComboBox Combo12 
      Height          =   315
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   45
      Top             =   4680
      Width           =   2055
   End
   Begin VB.ComboBox Combo11 
      Height          =   315
      Left            =   6120
      Style           =   2  'Dropdown List
      TabIndex        =   43
      Top             =   4680
      Width           =   2055
   End
   Begin VB.ComboBox Combo10 
      Height          =   315
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   41
      Top             =   4200
      Width           =   2055
   End
   Begin VB.ComboBox Combo9 
      Height          =   315
      Left            =   6120
      Style           =   2  'Dropdown List
      TabIndex        =   40
      Top             =   4200
      Width           =   2055
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Set"
      Height          =   495
      Left            =   1560
      TabIndex        =   37
      Top             =   5400
      Width           =   1215
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Update"
      Height          =   495
      Left            =   120
      TabIndex        =   36
      Top             =   5400
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Trigger Lockin"
      Height          =   495
      Left            =   6960
      TabIndex        =   35
      Top             =   5400
      Width           =   1215
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   6120
      TabIndex        =   34
      Top             =   2280
      Width           =   2055
   End
   Begin VB.ComboBox Combo8 
      Height          =   315
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   32
      Top             =   2760
      Width           =   2055
   End
   Begin VB.ComboBox Combo7 
      Height          =   315
      Left            =   6120
      Style           =   2  'Dropdown List
      TabIndex        =   30
      Top             =   2760
      Width           =   2055
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   1920
      TabIndex        =   28
      Top             =   2280
      Width           =   2055
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   6120
      TabIndex        =   26
      Top             =   1800
      Width           =   2055
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Auto-Phase"
      Height          =   495
      Left            =   5640
      TabIndex        =   24
      Top             =   5400
      Width           =   1215
   End
   Begin VB.ComboBox Combo6 
      Height          =   315
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   23
      Top             =   3720
      Width           =   2055
   End
   Begin VB.ComboBox Combo5 
      Height          =   315
      Left            =   6120
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   3720
      Width           =   2055
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   19
      Top             =   3240
      Width           =   2055
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   6120
      Style           =   2  'Dropdown List
      TabIndex        =   18
      Top             =   3240
      Width           =   2055
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1920
      TabIndex        =   15
      Top             =   1800
      Width           =   2055
   End
   Begin VB.ListBox List1 
      Height          =   255
      Left            =   6720
      TabIndex        =   13
      Top             =   120
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   255
      Left            =   5040
      TabIndex        =   12
      Top             =   120
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3720
      TabIndex        =   11
      Text            =   "Combo2"
      Top             =   120
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Go"
      Height          =   375
      Left            =   7200
      TabIndex        =   10
      Top             =   1200
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1320
      TabIndex        =   5
      Top             =   120
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Go"
      Height          =   375
      Left            =   2880
      TabIndex        =   2
      Top             =   540
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1320
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   570
      Width           =   1455
   End
   Begin VB.Label Label21 
      Caption         =   "Input coupling:"
      Height          =   255
      Left            =   120
      TabIndex        =   44
      Top             =   4680
      Width           =   1695
   End
   Begin VB.Label Label20 
      Caption         =   "Input line notch filter:"
      Height          =   255
      Left            =   4320
      TabIndex        =   42
      Top             =   4680
      Width           =   1695
   End
   Begin VB.Label Label19 
      Caption         =   "Input Shield Grounding:"
      Height          =   255
      Left            =   4320
      TabIndex        =   39
      Top             =   4200
      Width           =   1815
   End
   Begin VB.Label Label18 
      Caption         =   "Input Configuration:"
      Height          =   255
      Left            =   120
      TabIndex        =   38
      Top             =   4200
      Width           =   1575
   End
   Begin VB.Label Label17 
      Caption         =   "Harmonic Number:"
      Height          =   255
      Left            =   4320
      TabIndex        =   33
      Top             =   2280
      Width           =   1575
   End
   Begin VB.Label Label16 
      Caption         =   "Trigger:"
      Height          =   255
      Left            =   120
      TabIndex        =   31
      Top             =   2760
      Width           =   1575
   End
   Begin VB.Label Label15 
      Caption         =   "Reference Source:"
      Height          =   255
      Left            =   4320
      TabIndex        =   29
      Top             =   2760
      Width           =   1575
   End
   Begin VB.Label Label14 
      Caption         =   "Reference Frequency:"
      Height          =   255
      Left            =   120
      TabIndex        =   27
      Top             =   2280
      Width           =   1695
   End
   Begin VB.Label Label13 
      Caption         =   "Sine out Amplitude:"
      Height          =   255
      Left            =   4320
      TabIndex        =   25
      Top             =   1800
      Width           =   1575
   End
   Begin VB.Label Label12 
      Caption         =   "Low pass filter slope:"
      Height          =   255
      Left            =   120
      TabIndex        =   22
      Top             =   3720
      Width           =   1695
   End
   Begin VB.Label Label11 
      Caption         =   "Reserve:"
      Height          =   255
      Left            =   4320
      TabIndex        =   20
      Top             =   3720
      Width           =   1215
   End
   Begin VB.Label Label10 
      Caption         =   "Sensitivity:"
      Height          =   255
      Left            =   4320
      TabIndex        =   17
      Top             =   3240
      Width           =   1215
   End
   Begin VB.Label Label9 
      Caption         =   "Time Constant:"
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   3240
      Width           =   1215
   End
   Begin VB.Label Label8 
      Caption         =   "Phase:"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   1800
      Width           =   615
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   8280
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Label Label7 
      Caption         =   ","
      Height          =   255
      Left            =   3960
      TabIndex        =   9
      Top             =   1200
      Width           =   135
   End
   Begin VB.Label Label6 
      Height          =   255
      Left            =   4200
      TabIndex        =   8
      Top             =   1200
      Width           =   2775
   End
   Begin VB.Label Label5 
      Height          =   255
      Left            =   1440
      TabIndex        =   7
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Label Label4 
      Caption         =   "Read X and Y:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Address:"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label2 
      Height          =   255
      Left            =   4320
      TabIndex        =   3
      Top             =   600
      Width           =   3495
   End
   Begin VB.Label Label1 
      Caption         =   "Read Channel:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Width           =   1215
   End
End
Attribute VB_Name = "LockinForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
    Dim t
    Dim success As Boolean
    valu = SRS830.SRS830_ReadChannel(CInt(Text1.Text), Combo1.ListIndex + 1, t, success)

    If success = True Then
        Label2.Caption = valu
    Else
        Label2.Caption = "Read Failed"
    End If
    
End Sub

Private Sub Command2_Click()
Dim X()
Dim Y()
Dim numsamples As Integer

List1.Clear
List2.Clear

numsamples = 10
ReDim X(0 To numsamples - 1)
ReDim Y(0 To numsamples - 1)

SRS830.SRS830_FastMeasure Combo2.ListIndex, numsamples, LOCKIN_ADDR, X, Y

For a = 0 To numsamples - 1
    List1.AddItem X(a)
    List2.AddItem Y(a)
Next a

End Sub

Private Sub Command3_Click()
    Dim t
    Dim success As Boolean
    Dim X As Double
    Dim Y As Double
    
    SRS830.SRS830_ReadXY CInt(Text1.Text), t, success, X, Y
    If success = True Then
        Label5.Caption = X
        Label6.Caption = Y
    Else
        Label5.Caption = "Read Failed"
        Label6.Caption = ""
    End If
    



End Sub

Private Sub Command4_Click()

    Dim addr As Integer

    addr = CInt(Text1.Text)
    SRS830.SRS830_AutoPhase (addr)
    
End Sub

Private Sub Command5_Click()

    Dim addr As Integer

    addr = CInt(Text1.Text)
    SRS830.SRS830_Trigger (addr)
    
End Sub

Private Sub Command6_Click()

    Dim success As Boolean
    Dim indx As Integer
    Dim addr As Integer

    Combo3.Clear
    Combo3.AddItem "2nV/fA"
    Combo3.AddItem "5nV/fA"
    Combo3.AddItem "10nV/fA"
    Combo3.AddItem "20nV/fA"
    Combo3.AddItem "50nV/fA"
    Combo3.AddItem "100nV/fA"
    Combo3.AddItem "200nV/fA"
    Combo3.AddItem "500nV/fA"
    Combo3.AddItem "1uV/pA"
    Combo3.AddItem "2uV/pA"
    Combo3.AddItem "5uV/pA"
    Combo3.AddItem "10uV/pA"
    Combo3.AddItem "20uV/pA"
    Combo3.AddItem "50uV/pA"
    Combo3.AddItem "100uV/pA"
    Combo3.AddItem "200uV/pA"
    Combo3.AddItem "500uV/pA"
    Combo3.AddItem "1mV/nA"
    Combo3.AddItem "2mV/nA"
    Combo3.AddItem "5mV/nA"
    Combo3.AddItem "10mV/nA"
    Combo3.AddItem "20mV/nA"
    Combo3.AddItem "50mV/nA"
    Combo3.AddItem "100mV/nA"
    Combo3.AddItem "200mV/nA"
    Combo3.AddItem "500mV/nA"
    Combo3.AddItem "1 V/uA"
    
    Combo4.Clear
    Combo4.AddItem "10us"
    Combo4.AddItem "30us"
    Combo4.AddItem "100us"
    Combo4.AddItem "300us"
    Combo4.AddItem "1ms"
    Combo4.AddItem "3ms"
    Combo4.AddItem "10ms"
    Combo4.AddItem "30ms"
    Combo4.AddItem "100ms"
    Combo4.AddItem "300ms"
    Combo4.AddItem "1s"
    Combo4.AddItem "3s"
    Combo4.AddItem "10s"
    Combo4.AddItem "30s"
    Combo4.AddItem "100s"
    Combo4.AddItem "300s"
    Combo4.AddItem "1ks"
    Combo4.AddItem "3ks"
    Combo4.AddItem "10ks"
    Combo4.AddItem "30ks"
    
    Combo5.Clear
    Combo5.AddItem "High Reserve"
    Combo5.AddItem "Normal"
    Combo5.AddItem "Low Noise"
    
    Combo6.Clear
    Combo6.AddItem "6 dB/oct"
    Combo6.AddItem "12 dB/oct"
    Combo6.AddItem "18 dB/oct"
    Combo6.AddItem "24 dB/oct"
    
    Combo7.Clear
    Combo7.AddItem "External"
    Combo7.AddItem "Internal"
    
    Combo8.Clear
    Combo8.AddItem "Sine"
    Combo8.AddItem "+ve Edge"
    Combo8.AddItem "-ve Edge"
    
    Combo10.Clear
    Combo10.AddItem "A"
    Combo10.AddItem "A-B"
    Combo10.AddItem "I (1 M-Ohm)"
    Combo10.AddItem "I (100 M-Ohm)"
    
    Combo9.Clear
    Combo9.AddItem "Float"
    Combo9.AddItem "Ground"
    
    Combo12.Clear
    Combo12.AddItem "AC"
    Combo12.AddItem "DC"
    
    Combo11.Clear
    Combo11.AddItem "Out"
    Combo11.AddItem "Line Notch In"
    Combo11.AddItem "2x Line Notch In"
    Combo11.AddItem "Both In"
    
    addr = CInt(Text1.Text)
    Text2.Text = Format(SRS830.SRS830_GetPhase(addr), "0.00")
    Text3.Text = Format(SRS830.SRS830_ReadChannel(addr, 5, t, success), "0.000")
    Text4.Text = Format(SRS830.SRS830_ReadChannel(addr, 6, t, success))
    Text5.Text = Format(SRS830.SRS830_GetHarmNumber(addr), "0")
    s = SRS830.SRS830_GetExtTriggerMode(addr, indx)
    Combo8.ListIndex = indx
    s = SRS830.SRS830_GetRefSource(addr, indx)
    Combo7.ListIndex = indx
    d = SRS830.SRS830_GetTimeConstant(addr, indx)
    Combo4.ListIndex = indx
    d = SRS830.SRS830_GetSensitivity(addr, indx)
    Combo3.ListIndex = indx
    s = SRS830.SRS830_GetReserveMode(addr, indx)
    Combo5.ListIndex = indx
    s = SRS830.SRS830_GetLPFilterSlope(addr, indx)
    Combo6.ListIndex = indx
    s = SRS830.SRS830_GetInputConfig(addr, indx)
    Combo10.ListIndex = indx
    s = SRS830.SRS830_GetInputShieldGrounding(addr, indx)
    Combo9.ListIndex = indx
    s = SRS830.SRS830_GetInputCoupling(addr, indx)
    Combo12.ListIndex = indx
    s = SRS830.SRS830_GetInputLineNotchFilter(addr, indx)
    Combo11.ListIndex = indx

End Sub

Private Sub Command7_Click()

Dim addr As Integer

addr = CInt(Text1.Text)
SRS830.SRS830_SetPhase Val(Text2.Text), addr
SRS830.SRS830_SetSineOutAmplitude Val(Text3.Text), addr
SRS830.SRS830_SetRefFrequency Val(Text4.Text), addr
SRS830.SRS830_SetHarmNumber addr, CInt(Text5.Text)
SRS830.SRS830_SetExtTriggerMode addr, Combo8.ListIndex
SRS830.SRS830_SetRefSource addr, Combo7.ListIndex
SRS830.SRS830_SetTimeConstant addr, Combo4.ListIndex
SRS830.SRS830_SetSensitivity addr, Combo3.ListIndex
SRS830.SRS830_SetLPFilterSlope addr, Combo6.ListIndex
SRS830.SRS830_SetReserveMode addr, Combo5.ListIndex
SRS830.SRS830_SetInputConfig addr, Combo10.ListIndex
SRS830.SRS830_SetInputShieldGrounding addr, Combo9.ListIndex
SRS830.SRS830_SetInputCoupling addr, Combo12.ListIndex
SRS830.SRS830_SetInputLineNotchFilter addr, Combo11.ListIndex


End Sub

Private Sub Form_Load()

    Combo1.Clear
    Combo1.AddItem ("X")
    Combo1.AddItem ("Y")
    Combo1.AddItem ("R")
    Combo1.AddItem ("Theta")
    Combo1.ListIndex = 0

    Combo2.Clear
    Combo2.AddItem "62.5 mHz"
    Combo2.AddItem "125 mHz"
    Combo2.AddItem "250 mHz"
    Combo2.AddItem "500 mHz"
    Combo2.AddItem "1 Hz"
    Combo2.AddItem "2 Hz"
    Combo2.AddItem "4 Hz"
    Combo2.AddItem "8 Hz"
    Combo2.AddItem "16 Hz"
    Combo2.AddItem "32 Hz"
    Combo2.AddItem "64 Hz"
    Combo2.AddItem "128 Hz"
    Combo2.AddItem "256 Hz"
    Combo2.AddItem "512 Hz"
    Combo2.AddItem "Trigger"

    Combo2.ListIndex = 5
    
    Text1.Text = LOCKIN_ADDR
    
    
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        LockinForm.Hide
    End If

End Sub
