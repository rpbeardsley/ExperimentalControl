VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmBoxCar 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Boxcar setup and testing"
   ClientHeight    =   4155
   ClientLeft      =   1125
   ClientTop       =   1005
   ClientWidth     =   9480
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
   ScaleHeight     =   4155
   ScaleWidth      =   9480
   Begin Threed.SSFrame Frame3D3 
      Height          =   765
      Left            =   270
      TabIndex        =   32
      Top             =   240
      Width           =   3645
      _Version        =   65536
      _ExtentX        =   6429
      _ExtentY        =   1349
      _StockProps     =   14
      Caption         =   "Analogue ports 6/7: switchable bias"
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.TextBox txtBiasVoltage 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Left            =   1650
         MultiLine       =   -1  'True
         TabIndex        =   18
         TabStop         =   0   'False
         Text            =   "FRMBOXCA.frx":0000
         Top             =   300
         Width           =   675
      End
      Begin Spin.SpinButton spinBiasVoltage 
         Height          =   345
         Left            =   2580
         TabIndex        =   34
         Top             =   300
         Width           =   345
         _Version        =   65536
         _ExtentX        =   609
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton SpinBiasVoltage1 
         Height          =   345
         Left            =   2340
         TabIndex        =   35
         Top             =   300
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Voltage level (+/-)"
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
         Height          =   225
         Left            =   90
         TabIndex        =   33
         Top             =   360
         Width           =   1515
      End
   End
   Begin Threed.SSFrame framePort8 
      Height          =   2325
      Left            =   270
      TabIndex        =   23
      Top             =   1140
      Width           =   3645
      _Version        =   65536
      _ExtentX        =   6429
      _ExtentY        =   4101
      _StockProps     =   14
      Caption         =   "Analogue port 8: gate voltage/field sweep"
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.CommandButton cmdUpdatePort8 
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
         Height          =   315
         Left            =   2490
         TabIndex        =   19
         Top             =   1830
         Width           =   1035
      End
      Begin VB.TextBox txtCurrentPort8 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Left            =   1470
         MultiLine       =   -1  'True
         TabIndex        =   20
         TabStop         =   0   'False
         Text            =   "FRMBOXCA.frx":0006
         Top             =   1830
         Width           =   675
      End
      Begin VB.TextBox txtVoltage 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Left            =   1470
         MultiLine       =   -1  'True
         TabIndex        =   27
         TabStop         =   0   'False
         Text            =   "FRMBOXCA.frx":000B
         Top             =   270
         Width           =   675
      End
      Begin VB.TextBox txtVoltage 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Left            =   1470
         MultiLine       =   -1  'True
         TabIndex        =   26
         TabStop         =   0   'False
         Text            =   "FRMBOXCA.frx":0011
         Top             =   660
         Width           =   675
      End
      Begin VB.TextBox txtDivisor 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
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
         Left            =   1470
         MultiLine       =   -1  'True
         TabIndex        =   25
         Text            =   "FRMBOXCA.frx":0018
         Top             =   1440
         Width           =   675
      End
      Begin VB.TextBox txtVoltageStep 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
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
         Left            =   1470
         MultiLine       =   -1  'True
         TabIndex        =   24
         TabStop         =   0   'False
         Text            =   "FRMBOXCA.frx":001A
         Top             =   1050
         Width           =   675
      End
      Begin Spin.SpinButton spinVoltage 
         Height          =   345
         Index           =   0
         Left            =   2130
         TabIndex        =   36
         Top             =   270
         Width           =   315
         _Version        =   65536
         _ExtentX        =   556
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton spinVoltage 
         Height          =   345
         Index           =   1
         Left            =   2130
         TabIndex        =   37
         Top             =   660
         Width           =   315
         _Version        =   65536
         _ExtentX        =   556
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton SpinVoltage1 
         Height          =   345
         Index           =   0
         Left            =   1290
         TabIndex        =   38
         Top             =   270
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton SpinVoltage1 
         Height          =   345
         Index           =   1
         Left            =   1290
         TabIndex        =   39
         Top             =   660
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton SpinStep1 
         Height          =   345
         Left            =   1290
         TabIndex        =   40
         Top             =   1050
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton spinStep 
         Height          =   345
         Left            =   2130
         TabIndex        =   41
         Top             =   1050
         Width           =   315
         _Version        =   65536
         _ExtentX        =   556
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "V"
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
         Height          =   225
         Left            =   2190
         TabIndex        =   21
         Top             =   1890
         Width           =   195
      End
      Begin VB.Label Label6 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Current voltage:"
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
         Height          =   225
         Left            =   90
         TabIndex        =   22
         Top             =   1890
         Width           =   1365
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Initial voltage:"
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
         Height          =   225
         Left            =   90
         TabIndex        =   31
         Top             =   330
         Width           =   1185
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Final voltage:"
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
         Height          =   225
         Left            =   90
         TabIndex        =   30
         Top             =   720
         Width           =   1185
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Voltage divisor:"
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
         Height          =   225
         Left            =   90
         TabIndex        =   29
         Top             =   1500
         Width           =   1305
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Voltage step:"
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
         Height          =   225
         Left            =   90
         TabIndex        =   28
         Top             =   1110
         Width           =   1155
      End
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
      Height          =   405
      Left            =   1170
      TabIndex        =   17
      Top             =   3630
      Width           =   1755
   End
   Begin VB.CommandButton cmdSerial 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Serial Poll"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   6330
      TabIndex        =   16
      Top             =   3360
      Width           =   1395
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
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
      Left            =   4680
      TabIndex        =   15
      Top             =   3690
      Width           =   915
   End
   Begin VB.CommandButton cmdPoll 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Poll A/D ports"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   4350
      TabIndex        =   14
      Top             =   90
      Width           =   1515
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Index           =   7
      Left            =   4680
      TabIndex        =   13
      Top             =   3180
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Index           =   6
      Left            =   4680
      TabIndex        =   12
      Top             =   2820
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Index           =   5
      Left            =   4680
      TabIndex        =   11
      Top             =   2460
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Index           =   4
      Left            =   4680
      TabIndex        =   10
      Top             =   2100
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Index           =   3
      Left            =   4680
      TabIndex        =   9
      Top             =   1740
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Index           =   2
      Left            =   4680
      TabIndex        =   8
      Top             =   1380
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Left            =   4680
      TabIndex        =   7
      Top             =   1020
      Width           =   915
   End
   Begin VB.TextBox txtADInput 
      Appearance      =   0  'Flat
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
      Left            =   4680
      TabIndex        =   6
      Top             =   660
      Width           =   915
   End
   Begin Threed.SSFrame Frame3D2 
      Height          =   1275
      Left            =   6390
      TabIndex        =   5
      Top             =   150
      Width           =   2865
      _Version        =   65536
      _ExtentX        =   5054
      _ExtentY        =   2249
      _StockProps     =   14
      Caption         =   "Output misc. commands"
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.TextBox txtOutput 
         Appearance      =   0  'Flat
         Height          =   585
         Left            =   210
         TabIndex        =   2
         Top             =   480
         Width           =   2445
      End
   End
   Begin Threed.SSFrame Frame3D1 
      Height          =   1395
      Left            =   6390
      TabIndex        =   1
      Top             =   1650
      Width           =   2865
      _Version        =   65536
      _ExtentX        =   5054
      _ExtentY        =   2461
      _StockProps     =   14
      Caption         =   "Input from boxcar"
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.TextBox txtInput 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   210
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   750
         Width           =   2445
      End
      Begin VB.CommandButton cmdInput 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Input"
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
         Left            =   210
         TabIndex        =   3
         Top             =   300
         Width           =   1365
      End
   End
   Begin VB.CommandButton cmdReset 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Boxcar reset"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   7890
      TabIndex        =   0
      Top             =   3360
      Width           =   1395
   End
End
Attribute VB_Name = "frmBoxCar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdInput_Click()
txtInput.Text = recvIEEEdata$(20)
'ServiceBoxcar
End Sub

Private Sub cmdOK_Click()
frmBoxCar.Hide
End Sub

Private Sub cmdPoll_Click()
For i% = 1 To 8
SendIEEEdata ("?" + Format$(i%, "0"))
txtADinput(i% - 1) = Str$(Val(recvIEEEdata(30)))
Next
SendIEEEdata ("?B1")
text1 = Str$(Val(recvIEEEdata(30)))
End Sub

Private Sub cmdReset_Click()
SendIEEEdata ("MR")
' ServiceBoxcar
End Sub

Private Sub cmdSerial_Click()
'X = Spoll(bxcr)
'MsgBox (Str$(X))
End Sub

Private Sub cmdUpdatePort8_Click()
SendIEEEdata ("S8=" + Format$(txtCurrentPort8, "#0.000"))
UpdateCurrentLevels
End Sub

Private Sub Form_Activate()
SendIEEECmd (Str$(ieeeaddr(bxcr)))
SendIEEEdata ("I5")
UpdateCurrentLevels
cmdPoll_Click
End Sub

Private Sub Form_Load()
CentreForm Me
End Sub

Private Sub ServiceBoxcar()
'Do
'Poll bxcr
'Loop Until frmDevice!labPresent(bxcr).Caption = "OK"
End Sub

Private Sub spinBiasVoltage_SpinDown()
volts = Val(txtBiasVoltage)
volts = volts - 0.1
txtBiasVoltage = Format$(volts, "#0.00") + "V"
SendIEEEdata ("S6=" + Format$(volts, "#0.000"))
SendIEEEdata ("S7=" + Format$(-volts, "#0.000"))
cmdPoll_Click
End Sub

Private Sub spinBiasVoltage_SpinUp()
volts = Val(txtBiasVoltage)
volts = volts + 0.1
txtBiasVoltage = Format$(volts, "#0.00") + "V"
SendIEEEdata ("S6=" + Format$(volts, "#0.000"))
SendIEEEdata ("S7=" + Format$(-volts, "#0.000"))
cmdPoll_Click
End Sub

Private Sub SpinBiasVoltage1_SpinDown()
volts = Val(txtBiasVoltage)
volts = volts - 0.02
txtBiasVoltage = Format$(volts, "#0.00") + "V"
SendIEEEdata ("S6=" + Format$(volts, "#0.000"))
SendIEEEdata ("S7=" + Format$(-volts, "#0.000"))
cmdPoll_Click
End Sub

Private Sub SpinBiasVoltage1_SpinUp()
volts = Val(txtBiasVoltage)
volts = volts + 0.02
txtBiasVoltage = Format$(volts, "#0.00") + "V"
SendIEEEdata ("S6=" + Format$(volts, "#0.000"))
SendIEEEdata ("S7=" + Format$(-volts, "#0.000"))
cmdPoll_Click
End Sub

Private Sub spinStep_SpinDown()
mvolts = Val(txtVoltageStep)
mvolts = mvolts - 5
If mvolts < 0.5 Then mvolts = 0.5
txtVoltageStep = Format$(mvolts, "#0.0") + "mV"

End Sub

Private Sub spinStep_SpinUp()
mvolts = Val(txtVoltageStep)
mvolts = mvolts + 5
txtVoltageStep = Format$(mvolts, "#0.0") + "mV"
End Sub

Private Sub SpinStep1_SpinDown()
mvolts = Val(txtVoltageStep)
mvolts = mvolts - 0.5
If mvolts < 0.5 Then mvolts = 0.5
txtVoltageStep = Format$(mvolts, "#0.0") + "mV"
End Sub

Private Sub SpinStep1_SpinUp()
mvolts = Val(txtVoltageStep)
mvolts = mvolts + 0.5
txtVoltageStep = Format$(mvolts, "#0.0") + "mV"
End Sub

Private Sub spinVoltage_SpinDown(Index As Integer)
volts = Val(txtVoltage(Index))
volts = volts - 0.5
If volts < -10.1 Then volts = -10.1
txtVoltage(Index) = Format$(volts, "#0.00") + "V"
End Sub

Private Sub spinVoltage_SpinUp(Index As Integer)
volts = Val(txtVoltage(Index))
volts = volts + 0.5
If volts > 10.1 Then volts = 10.1
txtVoltage(Index) = Format$(volts, "#0.00") + "V"
End Sub

Private Sub SpinVoltage1_SpinDown(Index As Integer)
volts = Val(txtVoltage(Index))
volts = volts - 0.05
If volts < -10.1 Then volts = -10.1
txtVoltage(Index) = Format$(volts, "#0.00") + "V"
End Sub

Private Sub SpinVoltage1_SpinUp(Index As Integer)
volts = Val(txtVoltage(Index))
volts = volts + 0.05
If volts > 10.1 Then volts = 10.1
txtVoltage(Index) = Format$(volts, "#0.00") + "V"
End Sub

Private Sub txtOutput_KeyPress(keyAscii As Integer)
If keyAscii = 13 Then SendIEEEdata (txtOutput.Text): txtOutput.Text = ""
End Sub

Private Sub UpdateCurrentLevels()
SendIEEEdata ("?8")
txtCurrentPort8 = Format$(Val(recvIEEEdata(30)), "#0.00")
SendIEEEdata ("?6")
txtBiasVoltage = Format$(Val(recvIEEEdata(30)), "#0.00") + "V"
End Sub

