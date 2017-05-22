VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmAttenuate 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Attenuator"
   ClientHeight    =   3495
   ClientLeft      =   1095
   ClientTop       =   1485
   ClientWidth     =   3525
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
   ScaleHeight     =   3495
   ScaleWidth      =   3525
   Begin VB.CommandButton cmdSweep 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "sweep now"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1860
      TabIndex        =   16
      Top             =   1860
      Width           =   1245
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Update"
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
      Index           =   1
      Left            =   1230
      TabIndex        =   14
      Top             =   3030
      Width           =   1005
   End
   Begin VB.TextBox txtAttenRange 
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
      Index           =   0
      Left            =   480
      TabIndex        =   8
      Text            =   "0"
      Top             =   2130
      Width           =   315
   End
   Begin VB.TextBox txtAttenRange 
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
      Index           =   1
      Left            =   1020
      TabIndex        =   7
      Text            =   "63"
      Top             =   2130
      Width           =   285
   End
   Begin VB.TextBox txtAttenStep 
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
      Left            =   2130
      TabIndex        =   6
      Text            =   "1"
      Top             =   2130
      Width           =   285
   End
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
      Left            =   2400
      TabIndex        =   4
      Top             =   3030
      Width           =   1005
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
      Index           =   0
      Left            =   90
      TabIndex        =   3
      Top             =   3030
      Width           =   1005
   End
   Begin VB.PictureBox picAttenuate 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   825
      Left            =   1110
      ScaleHeight     =   795
      ScaleWidth      =   945
      TabIndex        =   0
      Top             =   810
      Width           =   975
   End
   Begin Threed.SSCheck autoupdate 
      Height          =   285
      Left            =   60
      TabIndex        =   15
      Top             =   2640
      Width           =   2475
      _Version        =   65536
      _ExtentX        =   4366
      _ExtentY        =   503
      _StockProps     =   78
      Caption         =   "No-click update of attenuation"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   1
      Value           =   -1  'True
   End
   Begin Spin.SpinButton spinChange 
      Height          =   825
      Index           =   1
      Left            =   600
      TabIndex        =   17
      Top             =   840
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
      Left            =   2340
      TabIndex        =   18
      Top             =   810
      Width           =   435
      _Version        =   65536
      _ExtentX        =   767
      _ExtentY        =   1455
      _StockProps     =   73
      BackColor       =   -2147483643
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   " Swept attenuation:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   225
      Left            =   150
      TabIndex        =   13
      Top             =   1860
      Width           =   1665
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Fixed attenuation:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   150
      TabIndex        =   12
      Top             =   120
      Width           =   1605
      WordWrap        =   -1  'True
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   300
      X2              =   2790
      Y1              =   1740
      Y2              =   1740
   End
   Begin VB.Label Label27 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      Left            =   840
      TabIndex        =   11
      Top             =   2160
      Width           =   315
   End
   Begin VB.Label Label28 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      Left            =   1350
      TabIndex        =   10
      Top             =   2160
      Width           =   945
   End
   Begin VB.Label Label34 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      Left            =   2460
      TabIndex        =   9
      Top             =   2160
      Width           =   315
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H000000FF&
      Height          =   405
      Left            =   1110
      TabIndex        =   5
      Top             =   390
      Width           =   1005
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "+/- 1dB"
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
      Height          =   255
      Left            =   420
      TabIndex        =   2
      Top             =   600
      Width           =   615
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "+/ 10dB"
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
      Height          =   255
      Left            =   2250
      TabIndex        =   1
      Top             =   600
      Width           =   645
   End
End
Attribute VB_Name = "frmAttenuate"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim att_level As Integer

Private Sub cmdCancel_Click()
Unload frmAttenuate
End Sub

Private Sub cmdOK_Click(Index As Integer)
'SetAttenuator att_level
SetAttenuator (63 - att_level)
frmAttenuate.Tag = Str$(att_level)
If Index = 0 Then
frmAttenuate.Hide
End If
End Sub

Private Sub cmdSweep_Click()
'att_level = 63 - att_level
For att_level = txtAttenRange(0) To txtAttenRange(1) Step txtAttenStep
displayLCD Format$(att_level, "00"), picAttenuate, Red
cmdOK_Click (1)
Beep
pause 15000
Next
End Sub

Private Sub Form_Activate()
picAttenuate.Tag = "-1"
displayLCD Format$(att_level, "00"), picAttenuate, Red

End Sub

Private Sub Form_Load()
CentreForm Me
configureLCD picAttenuate, 2
SendIEEECmd "IFC"
End Sub

Private Sub spinChange_SpinDown(Index As Integer)
att_level = att_level - (10 / (10 ^ Index))
If att_level < 0 Then att_level = 0
displayLCD Format$(att_level, "00"), picAttenuate, Red

If autoupdate.Value = True Then cmdOK_Click (1)
End Sub

Private Sub spinChange_SpinUp(Index As Integer)
att_level = att_level + (10 / (10 ^ Index))
If att_level > 64 Then att_level = 64
displayLCD Format$(att_level, "00"), picAttenuate, Red
If autoupdate.Value = True Then cmdOK_Click (1)
End Sub

