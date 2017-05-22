VERSION 5.00
Begin VB.Form fGate 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "IntelliGATE"
   ClientHeight    =   3690
   ClientLeft      =   2070
   ClientTop       =   3135
   ClientWidth     =   5775
   BeginProperty Font 
      Name            =   "MS Sans Serif"
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
   ScaleHeight     =   3690
   ScaleWidth      =   5775
   Begin VB.TextBox fscfactor 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   4140
      TabIndex        =   16
      Top             =   1320
      Width           =   735
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   2130
      TabIndex        =   0
      Top             =   3150
      Width           =   1305
   End
   Begin VB.TextBox yoffset 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3450
      TabIndex        =   9
      Text            =   "0.00"
      Top             =   2370
      Width           =   585
   End
   Begin VB.TextBox xoffset 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1440
      TabIndex        =   12
      Text            =   "0.00"
      Top             =   2370
      Width           =   585
   End
   Begin VB.TextBox GateWidth 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2430
      TabIndex        =   8
      Text            =   "40"
      Top             =   1440
      Width           =   555
   End
   Begin VB.TextBox WaferThickness 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2790
      TabIndex        =   6
      Text            =   "380"
      Top             =   960
      Width           =   555
   End
   Begin VB.TextBox ModeSpeed 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3960
      TabIndex        =   4
      Text            =   "5200"
      Top             =   570
      Width           =   555
   End
   Begin VB.TextBox PulseTime 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3810
      TabIndex        =   2
      Text            =   "50"
      Top             =   120
      Width           =   495
   End
   Begin VB.Label Label9 
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Factor:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   3480
      TabIndex        =   15
      Top             =   1380
      Width           =   765
   End
   Begin VB.Label Label8 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "NOTE: the baseline gate should be set up using the usual method."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   2790
      Width           =   5115
   End
   Begin VB.Label Label7 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Y-offset (mm) :"
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
      Height          =   285
      Left            =   2160
      TabIndex        =   13
      Top             =   2430
      Width           =   1305
   End
   Begin VB.Label Label6 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "X-offset (mm) :"
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
      Height          =   285
      Left            =   150
      TabIndex        =   11
      Top             =   2430
      Width           =   1305
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   $"FGATE.frx":0000
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   615
      Left            =   120
      TabIndex        =   10
      Top             =   1860
      Width           =   5745
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Required gate width (ns) :"
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
      Height          =   285
      Left            =   120
      TabIndex        =   7
      Top             =   1440
      Width           =   2325
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Substrate thickness (microns) :"
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
      Height          =   285
      Left            =   90
      TabIndex        =   5
      Top             =   1020
      Width           =   2745
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Phonon mode average phase velocity (m/s) :"
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
      Height          =   285
      Left            =   90
      TabIndex        =   3
      Top             =   600
      Width           =   3825
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Arrival time of pulse (ns) on digitiser trace:"
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
      Height          =   285
      Left            =   120
      TabIndex        =   1
      Top             =   150
      Width           =   3675
   End
End
Attribute VB_Name = "fGate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdOK_Click()
file$ = "c:\scan\scan.ini"
section$ = "IntelliGATE"
bool = WritePrivateProfileString(section$, "PulseTime", CStr(PulseTime), file$)
bool = WritePrivateProfileString(section$, "ModeSpeed", CStr(ModeSpeed), file$)
bool = WritePrivateProfileString(section$, "WaferThickness", CStr(WaferThickness), file$)
bool = WritePrivateProfileString(section$, "GateWidth", CStr(GateWidth), file$)
bool = WritePrivateProfileString(section$, "xoffset", CStr(xoffset), file$)
bool = WritePrivateProfileString(section$, "yoffset", CStr(yoffset), file$)
bool = WritePrivateProfileString(section$, "fscfactor", CStr(fscfactor), file$)



fGate.Hide
End Sub
   
Private Sub Form_Load()
PulseTime = int_PulseTime
ModeSpeed = int_ModeSpeed
WaferThickness = int_WaferThickness
GateWidth = int_GateWidth
xoffset = int_xoffset
yoffset = int_yoffset
fscfactor = int_fscfactor
'option1.Value = True
'Option2.Value = False
End Sub

Private Sub fscfactor_Change()
int_fscfactor = fscfactor
End Sub

Private Sub GateWidth_Change()
int_GateWidth = GateWidth
End Sub

Private Sub ModeSpeed_Change()
int_ModeSpeed = ModeSpeed
End Sub

Private Sub option1_Click()
Option1.Value = True
Option2.Value = False
End Sub

Private Sub Option2_Click()
Option2.Value = True
Option1.Value = False
End Sub


Private Sub PulseTime_Change()
int_PulseTime = PulseTime
End Sub

Private Sub txtfactor_Change()

End Sub

Private Sub WaferThickness_Change()
int_WaferThickness = WaferThickness
End Sub

Private Sub xoffset_Change()
int_xoffset = xoffset
End Sub

Private Sub yoffset_Change()
int_yoffset = yoffset
End Sub

