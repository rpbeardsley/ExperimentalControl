VERSION 5.00
Begin VB.Form frmLockIn 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Lock-in amplifier"
   ClientHeight    =   4845
   ClientLeft      =   1020
   ClientTop       =   2280
   ClientWidth     =   7785
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4845
   ScaleWidth      =   7785
   Begin VB.CommandButton Command1 
      Caption         =   "Cancel"
      Height          =   555
      Left            =   4260
      TabIndex        =   13
      Top             =   3720
      Width           =   1545
   End
   Begin VB.CommandButton cmdok 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   1260
      TabIndex        =   12
      Top             =   3720
      Width           =   1395
   End
   Begin VB.Frame Frame2 
      Caption         =   "Input"
      ForeColor       =   &H00FF0000&
      Height          =   2025
      Left            =   3990
      TabIndex        =   1
      Top             =   510
      Width           =   3285
      Begin VB.ComboBox Combo2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1860
         TabIndex        =   10
         Text            =   "Combo2"
         Top             =   1020
         Width           =   1185
      End
      Begin VB.ComboBox Combo1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1860
         TabIndex        =   8
         Text            =   "Combo1"
         Top             =   390
         Width           =   1185
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Time Constant:"
         Height          =   210
         Left            =   450
         TabIndex        =   11
         Top             =   1080
         Width           =   1260
      End
      Begin VB.Label Label4 
         Caption         =   "Sensitivity:"
         Height          =   285
         Left            =   810
         TabIndex        =   9
         Top             =   420
         Width           =   885
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Reference Signal"
      ForeColor       =   &H00FF0000&
      Height          =   2055
      Left            =   180
      TabIndex        =   0
      Top             =   450
      Width           =   3345
      Begin VB.TextBox Text3 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   1350
         TabIndex        =   4
         Text            =   "Text3"
         Top             =   1470
         Width           =   1185
      End
      Begin VB.TextBox Text2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   1350
         TabIndex        =   3
         Text            =   "Text2"
         Top             =   930
         Width           =   1155
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   1350
         TabIndex        =   2
         Text            =   "Text1"
         Top             =   420
         Width           =   1155
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Phase:"
         Height          =   210
         Left            =   750
         TabIndex        =   7
         Top             =   1530
         Width           =   555
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Frequency:"
         Height          =   210
         Left            =   360
         TabIndex        =   6
         Top             =   1020
         Width           =   915
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Amplitude:"
         Height          =   210
         Left            =   390
         TabIndex        =   5
         Top             =   510
         Width           =   900
      End
   End
End
Attribute VB_Name = "frmLockIn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim amp As Single
Dim amp2 As Single
Dim freq As Single
Dim freq2 As Single
Dim phase As Single
Dim sens As Integer
Dim tconst As Integer
Dim flag_ok As Boolean



Private Sub cmdOK_Click()
flag_ok = True
SendIEEECmd (Str(ieeeaddr(lckn)))
'set amplitude
amp2 = Val(text1.Text)
If (amp2 > 0.004) And (amp2 < 5#) Then
amp = amp2
z$ = Str(amp)
SendIEEEdata "SLVL " + z$
Else
flag_ok = False
MsgBox ("Amplitude must be between 0.004 and 5V")
End If

'set frequency
freq2 = Val(Text2.Text)
If (freq2 > 0.001) And (freq2 < 102000) Then
freq = freq2
z$ = Str(freq)
SendIEEEdata "FREQ " + z$
Else
flag_ok = False
MsgBox ("Frequency must be between 0.001 and 102KHz")
End If

' set phase
phase = Val(Text3.Text)
z$ = Str(phase)
SendIEEEdata "PHAS " + z$

'set Sensitivity
sens = Combo1.ListIndex
z$ = Str(sens)
SendIEEEdata "SENS " + z$

'set Time Constant
tconst = Combo2.ListIndex
z$ = Str(tconst)
SendIEEEdata "OFLT " + z$

If flag_ok = True Then
frmLockIn.Hide
Else
End If
End Sub

Private Sub Command1_Click()
frmLockIn.Hide
End Sub

Private Sub Form_Activate()
SendIEEECmd (Str(ieeeaddr(lckn)))

SendIEEEdata "SENS ?"
sens = Val(recvIEEEdata(255))
Combo1.ListIndex = sens

SendIEEEdata "OFLT ?"
tconst = Val(recvIEEEdata(255))
Combo2.ListIndex = tconst

SendIEEEdata "PHAS ?"
phase = Val(recvIEEEdata(255))
Text3.Text = Str(phase)

SendIEEEdata "SLVL ?"
amp = Val(recvIEEEdata(255))
text1.Text = Str(amp)

SendIEEEdata "FREQ ?"
freq = Val(recvIEEEdata(255))
Text2.Text = Str(freq)

End Sub

Private Sub Form_Load()
flag_ok = True
Combo1.AddItem "2nV"
Combo1.AddItem "5nV"
Combo1.AddItem "10nV"
Combo1.AddItem "20nV"
Combo1.AddItem "50nV"
Combo1.AddItem "100nV"
Combo1.AddItem "200nV"
Combo1.AddItem "500nV"
Combo1.AddItem "1000nV"
Combo1.AddItem "2000nV"
Combo1.AddItem "5000nV"
Combo1.AddItem "0.01mV"
Combo1.AddItem "0.02mV"
Combo1.AddItem "0.05mV"
Combo1.AddItem "0.1mV"
Combo1.AddItem "0.2mV"
Combo1.AddItem "0.5mV"
Combo1.AddItem "1mV"
Combo1.AddItem "2mV"
Combo1.AddItem "5mV"
Combo1.AddItem "10mV"
Combo1.AddItem "20mV"
Combo1.AddItem "50mV"
Combo1.AddItem "100mV"
Combo1.AddItem "200mV"
Combo1.AddItem "500mV"
Combo1.AddItem "1V"

Combo2.AddItem "10 microsec"
Combo2.AddItem "30 microsec"
Combo2.AddItem "100 microsec"
Combo2.AddItem "300 microsec"
Combo2.AddItem "1 msec"
Combo2.AddItem "3 msec"
Combo2.AddItem "10 msec"
Combo2.AddItem "30 msec"
Combo2.AddItem "100 msec"
Combo2.AddItem "300 msec"
Combo2.AddItem "1 sec"
Combo2.AddItem "3 sec"
Combo2.AddItem "10 sec"
Combo2.AddItem "30 sec"
Combo2.AddItem "100 sec"
Combo2.AddItem "300 sec"
Combo2.AddItem "1 Ksec"
Combo2.AddItem "3 Ksec"
Combo2.AddItem "10 Ksec"
Combo2.AddItem "30 Ksec"





CentreForm Me

End Sub























