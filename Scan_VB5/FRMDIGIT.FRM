VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmDigSetup 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "EG&G 9826 signal averager setup"
   ClientHeight    =   4560
   ClientLeft      =   465
   ClientTop       =   2040
   ClientWidth     =   6870
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
   HelpContextID   =   300
   LinkTopic       =   "Form2"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4560
   ScaleWidth      =   6870
   Begin VB.CommandButton setupgate 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "setup"
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
      Left            =   4170
      TabIndex        =   32
      Top             =   3270
      Width           =   1515
   End
   Begin VB.ComboBox imaginggate 
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
      Height          =   330
      Left            =   1500
      Style           =   2  'Dropdown List
      TabIndex        =   30
      Top             =   3240
      Width           =   2535
   End
   Begin Threed.SSFrame Frame3D2 
      Height          =   1305
      Left            =   180
      TabIndex        =   6
      Top             =   1710
      Width           =   3255
      _Version        =   65536
      _ExtentX        =   5741
      _ExtentY        =   2302
      _StockProps     =   14
      Caption         =   "Averaging settings:"
      ForeColor       =   16711680
      Begin Spin.SpinButton spnSamplePeriod 
         Height          =   255
         Left            =   2820
         TabIndex        =   33
         Top             =   270
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton spnRecordLemgth 
         Height          =   255
         Left            =   2820
         TabIndex        =   34
         Top             =   600
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton spnSweeps 
         Height          =   255
         Left            =   2820
         TabIndex        =   35
         Top             =   930
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Sampling period:"
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
         Left            =   330
         TabIndex        =   7
         Top             =   270
         Width           =   1245
      End
      Begin VB.Label Label9 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Record length:"
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
         Left            =   450
         TabIndex        =   8
         Top             =   600
         Width           =   1125
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Sweeps to average:"
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
         Left            =   90
         TabIndex        =   12
         Top             =   930
         Width           =   1485
      End
      Begin VB.Label labSamplePeriod 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
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
         Left            =   1620
         TabIndex        =   15
         Top             =   270
         Width           =   1215
      End
      Begin VB.Label labRecordLength 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
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
         Left            =   1620
         TabIndex        =   16
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label labSweeps 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
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
         Left            =   1620
         TabIndex        =   18
         Top             =   930
         Width           =   1215
      End
   End
   Begin Threed.SSFrame Frame3D1 
      Height          =   1815
      Left            =   4080
      TabIndex        =   24
      Top             =   90
      Width           =   2265
      _Version        =   65536
      _ExtentX        =   3995
      _ExtentY        =   3201
      _StockProps     =   14
      Caption         =   "Configuration:"
      ForeColor       =   16711680
      Begin VB.TextBox ReadsToIgnore 
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
         Height          =   315
         Left            =   1290
         TabIndex        =   28
         Text            =   "86"
         Top             =   1020
         Width           =   405
      End
      Begin VB.CommandButton cmdReadDigitiser 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Current settings"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   210
         TabIndex        =   19
         Top             =   1380
         Width           =   1725
      End
      Begin VB.ComboBox PreampInput 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1140
         Style           =   2  'Dropdown List
         TabIndex        =   26
         Top             =   270
         Width           =   555
      End
      Begin VB.ComboBox DigitiserAddress 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1140
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   660
         Width           =   885
      End
      Begin VB.Label Label12 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Reads to ignore:"
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
         Left            =   90
         TabIndex        =   29
         Top             =   1050
         Width           =   1215
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Preamp input:"
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
         Left            =   120
         TabIndex        =   20
         Top             =   300
         Width           =   975
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Port address:"
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
         Left            =   120
         TabIndex        =   27
         Top             =   690
         Width           =   975
      End
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
      Height          =   435
      Left            =   3810
      TabIndex        =   1
      Top             =   3780
      Width           =   1575
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
      Height          =   435
      Left            =   1680
      TabIndex        =   0
      Top             =   3780
      Width           =   1575
   End
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Trigger:"
      ForeColor       =   &H00FF0000&
      Height          =   1425
      Left            =   180
      TabIndex        =   2
      Top             =   90
      Width           =   3555
      Begin VB.ComboBox InputImpedance 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   810
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   960
         Width           =   945
      End
      Begin VB.ComboBox TriggerEdge 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   480
         Width           =   1635
      End
      Begin VB.TextBox txtThreshold 
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
         Height          =   315
         Left            =   2130
         TabIndex        =   17
         Top             =   480
         Width           =   675
      End
      Begin Spin.SpinButton spinThreshold 
         Height          =   315
         Index           =   1
         Left            =   2790
         TabIndex        =   36
         Top             =   480
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Spin.SpinButton spinThreshold 
         Height          =   315
         Index           =   0
         Left            =   2970
         TabIndex        =   37
         Top             =   480
         Width           =   285
         _Version        =   65536
         _ExtentX        =   503
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "input impedance"
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
         Left            =   1830
         TabIndex        =   23
         Top             =   990
         Width           =   1215
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "sent into:"
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
         Left            =   90
         TabIndex        =   22
         Top             =   990
         Width           =   675
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Trigger on:"
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
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   1005
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Trigger level / Volts"
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
         Left            =   1980
         TabIndex        =   5
         Top             =   240
         Width           =   1395
      End
   End
   Begin VB.Frame Frame3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Input pre-amplifier:"
      ForeColor       =   &H00FF0000&
      Height          =   1005
      Left            =   3660
      TabIndex        =   9
      Top             =   2010
      Width           =   2985
      Begin VB.TextBox txtInputOffset 
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
         Height          =   315
         Left            =   1680
         TabIndex        =   13
         Top             =   540
         Width           =   735
      End
      Begin VB.ComboBox cmbFullScale 
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
         Height          =   330
         Left            =   300
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   540
         Width           =   945
      End
      Begin Spin.SpinButton spinOffset 
         Height          =   315
         Left            =   2400
         TabIndex        =   38
         Top             =   540
         Width           =   285
         _Version        =   65536
         _ExtentX        =   503
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Input offset (%)"
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
         Left            =   1650
         TabIndex        =   11
         Top             =   270
         Width           =   1155
      End
      Begin VB.Label Label6 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Full scale (mV)"
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
         Left            =   240
         TabIndex        =   10
         Top             =   270
         Width           =   1155
      End
   End
   Begin VB.Label Label13 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Imaging gate:"
      ForeColor       =   &H00FF0000&
      Height          =   285
      Left            =   300
      TabIndex        =   31
      Top             =   3270
      Width           =   1245
   End
End
Attribute VB_Name = "frmDigSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Threshold As Single
Dim FullScale As Single
Dim AmpOffset As Single
Dim SamplePeriod As Integer
'Dim sweeps As Integer
Dim RecordLen As Integer

Private Sub cmdCancel_Click()
' exit without setting global variables
Unload frmDigSetup
End Sub

Private Sub cmdOK_Click()
' transfer user settings to global variables
gDIG_THRESHOLD = Val(txtThreshold.Text)
gDIG_FULLSCALE = Val(cmbFullScale.Text)
gDIG_AMPOFFSET = Val(txtInputOffset.Text)
gDIG_RECORDLEN = Log(Val(labRecordlength.Caption)) / Log(2)
gDIG_SWEEPS = Log(Val(labSweeps.Caption)) / Log(2)
gDIG_SAMPLEPER = Val(labSamplePeriod.Caption)
ignore = Val(ReadsToIgnore.Text)
If inputimpedance.ListIndex = 0 Then
    gDIG_INPIMP50 = True
Else
    gDIG_INPIMP50 = False
End If
If triggeredge.ListIndex = 1 Then
    gDIG_TRIGFALL = True
Else
    gDIG_TRIGFALL = False
End If

' [Digitiser]
section$ = "Digitiser"
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_THRESHOLD", ByVal Str$(gDIG_THRESHOLD), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_SAMPLEPER", ByVal Str$(gDIG_SAMPLEPER), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_RECORDLEN", ByVal Str$(gDIG_RECORDLEN), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_AMPOFFSET", ByVal Str$(gDIG_AMPOFFSET), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_FULLSCALE", ByVal Str$(gDIG_FULLSCALE), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_SWEEPS", ByVal Str$(gDIG_SWEEPS), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_TRIGFALL", ByVal Str$(gDIG_TRIGFALL), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "gDIG_INPIMP50", ByVal Str$(gDIG_INPIMP50), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Reads to ignore", ByVal Str$(ignore), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Gate Type", Str$(imaginggate.ListIndex), ByVal "c:\scan\scan.ini")
frmDigSetup.Hide
End Sub

Private Sub cmdReadDigitiser_Click()
CurrentDigitiserSettings
End Sub

Private Sub Form_Load()
CentreForm Me
' will eventually read read values direct from board
' but set them here for the time being

imaginggate.AddItem "Default gate"
imaginggate.AddItem "IntelliGATE"
imaginggate.ListIndex = whichgate

preampinput.AddItem "1"
preampinput.AddItem "2"
preampinput.ListIndex = 1

digitiseraddress.AddItem "&H300"
digitiseraddress.AddItem "&H310"
digitiseraddress.AddItem "&H340"
digitiseraddress.AddItem "&H350"
digitiseraddress.ListIndex = 3

inputimpedance.AddItem "50 ohm"
inputimpedance.AddItem "1 Kohm"
triggeredge.AddItem "Rising edge"
triggeredge.AddItem "Falling edge"

txtThreshold.Text = Str$(gDIG_THRESHOLD)
txtInputOffset.Text = Str$(gDIG_AMPOFFSET)
ReadsToIgnore.Text = Str$(ignore)
labRecordlength.Caption = Str$(2 ^ gDIG_RECORDLEN)
labSweeps.Caption = Str$(2 ^ gDIG_SWEEPS)
labSamplePeriod.Caption = Str$(gDIG_SAMPLEPER) + " ns"
If gDIG_INPIMP50 = True Then inputimpedance.ListIndex = 0 Else inputimpedance.ListIndex = 1
If gDIG_TRIGFALL = True Then triggeredge.ListIndex = 1 Else triggeredge.ListIndex = 0

If digitiser = 9825 Then
cmbFullScale.AddItem "400"
cmbFullScale.AddItem "300"
cmbFullScale.AddItem "200"
cmbFullScale.AddItem "150"
cmbFullScale.AddItem "100"
cmbFullScale.AddItem "60"
cmbFullScale.AddItem "40"

Else
cmbFullScale.AddItem "1000"
cmbFullScale.AddItem "800"
cmbFullScale.AddItem "640"
cmbFullScale.AddItem "500"
cmbFullScale.AddItem "400"
cmbFullScale.AddItem "320"
cmbFullScale.AddItem "250"
cmbFullScale.AddItem "200"
cmbFullScale.AddItem "160"
cmbFullScale.AddItem "125"
cmbFullScale.AddItem "100"
cmbFullScale.AddItem "80"
cmbFullScale.AddItem "63"
cmbFullScale.AddItem "50"
cmbFullScale.AddItem "40"
End If

' locate nearest full scale listbox entry to
' value stored in SCAN.INI (so long as digitiser
' type remains constant, there should be an
' exact match)
best = -1: mindelta = 1000000#
For i% = 0 To cmbFullScale.ListCount - 1
X = Val(cmbFullScale.List(i%)): delta = Abs(gDIG_FULLSCALE - X)
If delta < mindelta Then best = i%: mindelta = delta
Next
cmbFullScale.ListIndex = best
End Sub

Private Sub imaginggate_Click()
whichgate = imaginggate.ListIndex
setupgate.Enabled = -whichgate
End Sub

Private Sub setupgate_Click()
fGate.Show 1
End Sub

Private Sub spinOffset_SpinDown()
offset = Val(txtInputOffset) - 5
' min offset=-20% (9846), -50% (9825)
minoffset = -20 + (30 * (digitiser = 9825))
If offset < minoffset Then offset = minoffset
txtInputOffset = Str$(offset)
End Sub

Private Sub spinOffset_SpinUp()
offset = Val(txtInputOffset) + 5
' max offset=+120%
If offset > 120 Then offset = 120
txtInputOffset = Str$(offset)
End Sub

Private Sub spinThreshold_SpinDown(Index As Integer)
thresh = Val(txtThreshold)
thresh = thresh - (0.5 / 10 ^ Index)

Select Case digitiser
Case 9825
If thresh < -1.5 Then thresh = -1.5

Case Else
If thresh < -10 Then thresh = -10

End Select
txtThreshold = Format$(thresh, "##0.00")
End Sub

Private Sub spinThreshold_SpinUp(Index As Integer)
thresh = Val(txtThreshold)
thresh = thresh + (0.5 / 10 ^ Index)

Select Case digitiser
Case 9825
If thresh > 1.5 Then thresh = 1.5

Case Else
If thresh > 10 Then thresh = 10

End Select
txtThreshold = Format$(thresh, "##0.00")

End Sub

Private Sub spnRecordLemgth_SpinDown()
tmp = Val(labRecordlength.Caption)
If tmp = 2048 Then Exit Sub
tmp = tmp / 2
If tmp = 131072 Then tmp = tmp / 2
labRecordlength.Caption = Str$(tmp)
End Sub

Private Sub spnRecordLemgth_SpinUp()
tmp = Val(labRecordlength.Caption)
If tmp = 262144 Then Exit Sub
tmp = tmp * 2
If tmp = 131072 Then tmp = tmp * 2
labRecordlength.Caption = Str$(tmp)
End Sub

Private Sub spnSamplePeriod_SpinDown()
tmp = Val(Left$(labSamplePeriod.Caption, Len(labSamplePeriod.Caption) - 3))
tmp = tmp / 2
'If tmp = 4 Then tmp = 2
If tmp < 5 Then tmp = 5
labSamplePeriod.Caption = Str$(tmp) + " ns"
End Sub

Private Sub spnSamplePeriod_SpinUp()
tmp = Val(Left$(labSamplePeriod.Caption, Len(labSamplePeriod.Caption) - 3))
tmp = tmp * 2
If tmp > 2048 Then tmp = 2048
'If tmp = 4 Then tmp = 8
labSamplePeriod.Caption = Str$(tmp) + " ns"
End Sub

Private Sub spnSweeps_SpinDown()
tmp = Val(labSweeps.Caption)
If tmp = 1 Then Exit Sub
tmp = tmp / 2: If tmp = 2 And digitiser = 9825 Then tmp = 1
labSweeps.Caption = Str$(tmp)
End Sub

Private Sub spnSweeps_SpinUp()
tmp = Val(labSweeps.Caption)
If tmp = 8388608 Then Exit Sub
tmp = tmp * 2: If tmp = 2 And digitiser = 9825 Then tmp = 4
labSweeps.Caption = Str$(tmp)
End Sub

Private Sub txtFullScale_KeyPress(keyAscii As Integer)
If InStr(gNUMBERS, Chr$(keyAscii)) Then
    ' do nothing
ElseIf keyAscii = 8 Then
    ' do nothing
Else
    keyAscii = 0
End If
End Sub

