VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Begin VB.Form frmPulse 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Set Pulse"
   ClientHeight    =   1800
   ClientLeft      =   1230
   ClientTop       =   4335
   ClientWidth     =   3495
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
   ScaleHeight     =   1800
   ScaleWidth      =   3495
   Begin VB.CommandButton cmdCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Cancel"
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
      Left            =   1800
      TabIndex        =   2
      Top             =   1350
      Width           =   1485
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "OK"
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
      Left            =   150
      TabIndex        =   1
      Top             =   1350
      Width           =   1485
   End
   Begin VB.PictureBox picPSU 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
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
      Height          =   825
      Left            =   690
      ScaleHeight     =   795
      ScaleWidth      =   1935
      TabIndex        =   0
      Top             =   390
      Width           =   1965
   End
   Begin Spin.SpinButton spinChange 
      Height          =   825
      Index           =   1
      Left            =   240
      TabIndex        =   6
      Top             =   390
      Width           =   285
      _Version        =   65536
      _ExtentX        =   503
      _ExtentY        =   1455
      _StockProps     =   73
      BackColor       =   -2147483643
   End
   Begin Spin.SpinButton spinChange 
      Height          =   825
      Index           =   0
      Left            =   2820
      TabIndex        =   7
      Top             =   390
      Width           =   435
      _Version        =   65536
      _ExtentX        =   767
      _ExtentY        =   1455
      _StockProps     =   73
      BackColor       =   -2147483643
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "+/- 1V"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   2790
      TabIndex        =   4
      Top             =   150
      Width           =   525
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "PSU Voltage"
      ForeColor       =   &H00FF0000&
      Height          =   225
      Left            =   1140
      TabIndex        =   5
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "+/- 0.1V"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   90
      TabIndex        =   3
      Top             =   150
      Width           =   615
   End
End
Attribute VB_Name = "frmPulse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim volts As Single



Private Sub cmdCancel_Click()

Unload frmPulse

End Sub



Private Sub cmdOK_Click()

SendIEEECmd (Str$(ieeeaddr(psu)))

SendIEEEdata ("X" + Format$(volts, "#0.0#") + "V1A")

frmPulse.Tag = Str$(volts)

frmTrace!mnuSetupPulse.Caption = "&Pulse (" + Format$(volts, "#0.0") + " V)"

frmPulse.Hide

End Sub



Private Sub Form_Activate()

picPSU.Tag = "-1"

displayLCD Format$(volts, "00.00"), picPSU, Red

End Sub



Private Sub Form_Load()

CentreForm Me

configureLCD picPSU, 3

volts = Val(frmPulse.Tag)

End Sub



Private Sub spinChange_SpinDown(Index As Integer)

volts = volts - (1 / (10 ^ Index))

If volts < 0 Then volts = 0

displayLCD Format$(volts, "00.00"), picPSU, Red

End Sub



Private Sub spinChange_SpinUp(Index As Integer)

volts = volts + (1 / (10 ^ Index))

If volts > 30 Then volts = 30

displayLCD Format$(volts, "00.00"), picPSU, Red

End Sub



