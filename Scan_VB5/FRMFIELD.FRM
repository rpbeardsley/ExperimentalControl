VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.0#0"; "MSMASK32.OCX"
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmFieldSweep 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Setup Magnetic Field Sweep"
   ClientHeight    =   3810
   ClientLeft      =   2580
   ClientTop       =   1560
   ClientWidth     =   6870
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
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3810
   ScaleWidth      =   6870
   Begin Threed.SSFrame Frame3D1 
      Height          =   1335
      Left            =   210
      TabIndex        =   21
      Top             =   660
      Width           =   5445
      _Version        =   65536
      _ExtentX        =   9604
      _ExtentY        =   2355
      _StockProps     =   14
      Caption         =   "Field sweep settings"
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
      Begin MSMask.MaskEdBox txtFieldStart 
         Height          =   315
         Left            =   1530
         TabIndex        =   23
         Top             =   270
         Width           =   555
         _Version        =   65536
         _ExtentX        =   979
         _ExtentY        =   556
         _StockProps     =   109
         BackColor       =   -2147483643
         BorderStyle     =   1
         Format          =   "0.00"
      End
      Begin MSMask.MaskEdBox txtFieldEnd 
         Height          =   315
         Left            =   1530
         TabIndex        =   6
         Top             =   600
         Width           =   555
         _Version        =   65536
         _ExtentX        =   979
         _ExtentY        =   556
         _StockProps     =   109
         BackColor       =   -2147483643
         BorderStyle     =   1
         Format          =   "0.00"
      End
      Begin VB.TextBox txtStepDelay 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   4140
         TabIndex        =   4
         Text            =   "50"
         Top             =   570
         Width           =   495
      End
      Begin VB.TextBox txtFieldStep 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   4140
         TabIndex        =   5
         Text            =   "10"
         Top             =   210
         Width           =   495
      End
      Begin Threed.SSCheck cmdFieldLoop 
         Height          =   255
         Left            =   90
         TabIndex        =   3
         Top             =   990
         Width           =   3795
         _Version        =   65536
         _ExtentX        =   6694
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Perform complete field loop (Start > Final > Start)"
      End
      Begin Spin.SpinButton Spin2 
         Height          =   315
         Left            =   2070
         TabIndex        =   26
         Top             =   600
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton Spin1 
         Height          =   315
         Left            =   2070
         TabIndex        =   27
         Top             =   270
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "msec."
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   4680
         TabIndex        =   7
         Top             =   600
         Width           =   585
      End
      Begin VB.Label Label9 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Step delay:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   3300
         TabIndex        =   8
         Top             =   600
         Width           =   885
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "mTesla"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   4680
         TabIndex        =   9
         Top             =   240
         Width           =   585
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Step rate:"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   3420
         TabIndex        =   10
         Top             =   240
         Width           =   765
      End
      Begin VB.Label Label6 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tesla"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   2340
         TabIndex        =   15
         Top             =   660
         Width           =   585
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Final value of field:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   120
         TabIndex        =   25
         Top             =   660
         Width           =   1365
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tesla"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   2340
         TabIndex        =   24
         Top             =   330
         Width           =   585
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Start value of field:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   150
         TabIndex        =   22
         Top             =   330
         Width           =   1365
      End
   End
   Begin Threed.SSFrame frameBoxcarSetup 
      Height          =   1065
      Left            =   210
      TabIndex        =   17
      Top             =   2100
      Width           =   6225
      _Version        =   65536
      _ExtentX        =   10980
      _ExtentY        =   1879
      _StockProps     =   14
      Caption         =   "Configuration of boxcar as magnet power source"
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
      Begin VB.TextBox txtStepDown 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         Height          =   330
         Left            =   1830
         TabIndex        =   20
         Text            =   "50"
         Top             =   270
         Width           =   495
      End
      Begin VB.CommandButton cmdOptimise 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Optimise"
         Height          =   375
         Left            =   360
         TabIndex        =   18
         Top             =   570
         Width           =   1305
      End
      Begin VB.Label labMaxTesla 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   4170
         TabIndex        =   12
         Top             =   570
         Width           =   1545
      End
      Begin VB.Label labTeslaStep 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   4050
         TabIndex        =   13
         Top             =   300
         Width           =   1635
      End
      Begin VB.Label Label13 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "(10V max boxcar O/P ="
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   2430
         TabIndex        =   14
         Top             =   570
         Width           =   1695
      End
      Begin VB.Label Label12 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "(2.5mV boxcar step = "
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   2430
         TabIndex        =   16
         Top             =   300
         Width           =   1635
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Boxcar voltage divisor="
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   90
         TabIndex        =   19
         Top             =   300
         Width           =   1755
      End
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "OK"
      Height          =   345
      Left            =   2820
      TabIndex        =   11
      Top             =   3330
      Width           =   1665
   End
   Begin VB.ComboBox cmbMagnetPSUType 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1110
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   270
      Width           =   1425
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "to provide power supply for magnet."
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   2610
      TabIndex        =   2
      Top             =   300
      Width           =   3225
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Using"
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   480
      TabIndex        =   0
      Top             =   300
      Width           =   495
   End
End
Attribute VB_Name = "frmFieldSweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub cmdOK_Click()

frmFieldSweep.Hide

End Sub



Private Sub cmdOptimise_Click()

' set the voltage divisor to be an integer value that

' sets the maximum boxcar voltage to be equivalent

' to 5% above the maximum required field for the sweep

If Val(txtFieldStart) > Val(txtFieldEnd) Then maxField = Val(txtFieldStart) Else maxField = Val(txtFieldEnd)

txtStepDown = Str$(Int(0.5 + (10 / ((maxField * 1.05) / 46.73))))

UpdateVoltToTesla

End Sub



Private Sub Form_Activate()

UpdateVoltToTesla

End Sub



Private Sub Form_Load()

CentreForm Me

txtFieldStart = "0"

txtFieldEnd = "7"

cmbMagnetPSUType.AddItem "Boxcar"

cmbMagnetPSUType.ListIndex = 0

End Sub



Private Sub Spin1_SpinDown()

If Not (Val(txtFieldStart) < 0.2 And (Val(txtFieldEnd) = 0 Or Val(txtFieldStart = 0))) Then txtFieldStart = Str$(Val(txtFieldStart) - 0.1)

End Sub



Private Sub Spin1_SpinUp()

If Val(txtFieldStart) < 7 Then txtFieldStart = Str$(Val(txtFieldStart) + 0.1)

End Sub



Private Sub Spin2_SpinDown()

If Not (Val(txtFieldEnd) < 0.2 And (Val(txtFieldStart) = 0 Or Val(txtFieldEnd = 0))) Then txtFieldEnd = Str$(Val(txtFieldEnd) - 0.1)

End Sub



Private Sub Spin2_SpinUp()

If Val(txtFieldEnd) < 7 Then txtFieldEnd = Str$(Val(txtFieldEnd) + 0.1)

End Sub



Private Sub txtStepDown_LostFocus()

UpdateVoltToTesla

End Sub



Private Sub UpdateVoltToTesla()

mT_per_step = (46.73 * 2.5) / Val(txtStepDown)

labTeslaStep = Format$(mT_per_step, "##0.0##") + " milliTesla)"

labMaxTesla = Format$(4 * mT_per_step, "0.00#") + " Tesla)"

End Sub



