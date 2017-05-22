VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmMirrorSetup 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mirrors setup"
   ClientHeight    =   6135
   ClientLeft      =   660
   ClientTop       =   1560
   ClientWidth     =   9975
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
   HelpContextID   =   290
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6135
   ScaleWidth      =   9975
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   495
      Index           =   1
      Left            =   4770
      TabIndex        =   34
      Top             =   2010
      Width           =   735
      Begin VB.OptionButton optGreenLight 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "RX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000C000&
         Height          =   285
         Left            =   60
         TabIndex        =   35
         Top             =   150
         Width           =   615
      End
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   495
      Index           =   0
      Left            =   4770
      TabIndex        =   33
      Top             =   1470
      Width           =   735
      Begin VB.OptionButton optRedLight 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "TX"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   285
         Left            =   60
         TabIndex        =   36
         Top             =   150
         Width           =   585
      End
   End
   Begin VB.ComboBox cmbLens 
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
      Left            =   6630
      TabIndex        =   7
      Text            =   "Combo1"
      Top             =   4770
      Width           =   1125
   End
   Begin Threed.SSFrame Frame3D1 
      Height          =   1305
      Left            =   90
      TabIndex        =   18
      Top             =   4740
      Width           =   4845
      _Version        =   65536
      _ExtentX        =   8546
      _ExtentY        =   2302
      _StockProps     =   14
      ForeColor       =   16711680
      Begin VB.TextBox txtCentreY 
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
         Left            =   2670
         TabIndex        =   25
         Top             =   180
         Width           =   795
      End
      Begin VB.TextBox txtCurX 
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
         Left            =   1470
         TabIndex        =   26
         Top             =   540
         Width           =   795
      End
      Begin VB.TextBox txtCurrentX 
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
         Left            =   1470
         TabIndex        =   27
         Top             =   900
         Width           =   795
      End
      Begin VB.TextBox txtCurY 
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
         Left            =   2670
         TabIndex        =   28
         Top             =   540
         Width           =   795
      End
      Begin VB.TextBox txtCurrentY 
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
         Left            =   2670
         TabIndex        =   29
         Top             =   900
         Width           =   795
      End
      Begin VB.TextBox txtCentreX 
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
         Left            =   1470
         TabIndex        =   30
         Top             =   180
         Width           =   795
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "(mirror co-ords)"
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
         Left            =   3570
         TabIndex        =   24
         Top             =   570
         Width           =   1215
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Y="
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
         Left            =   2430
         TabIndex        =   23
         Top             =   540
         Width           =   195
      End
      Begin VB.Label Label6 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Mirrors now at: X="
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
         Left            =   120
         TabIndex        =   22
         Top             =   570
         Width           =   1365
      End
      Begin VB.Label Label18 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "(millimetres)"
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
         Left            =   3570
         TabIndex        =   9
         Top             =   930
         Width           =   1095
      End
      Begin VB.Label Label17 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Y="
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
         Left            =   2430
         TabIndex        =   20
         Top             =   930
         Width           =   195
      End
      Begin VB.Label Label16 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Current offset: X="
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
         Left            =   150
         TabIndex        =   13
         Top             =   930
         Width           =   1335
      End
      Begin VB.Label Label15 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "(mirror co-ords)"
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
         Left            =   3570
         TabIndex        =   14
         Top             =   210
         Width           =   1245
      End
      Begin VB.Label Label14 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Y="
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
         Left            =   2430
         TabIndex        =   21
         Top             =   210
         Width           =   195
      End
      Begin VB.Label Label13 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Centre set at: X="
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
         Left            =   240
         TabIndex        =   19
         Top             =   210
         Width           =   1275
      End
   End
   Begin VB.ComboBox cmbResolution 
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
      Left            =   6390
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   4320
      Width           =   2985
   End
   Begin VB.CommandButton cmdHelp 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Help"
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
      Left            =   5550
      TabIndex        =   1
      Top             =   5310
      Width           =   1275
   End
   Begin VB.CommandButton cmdCentre 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Reposition centre"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1890
      TabIndex        =   5
      Top             =   120
      Width           =   1965
   End
   Begin VB.PictureBox picScope 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      FillStyle       =   0  'Solid
      ForeColor       =   &H0000FF00&
      Height          =   3735
      Left            =   5610
      ScaleHeight     =   3705
      ScaleWidth      =   4125
      TabIndex        =   10
      Top             =   540
      Width           =   4155
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
      Left            =   7020
      TabIndex        =   2
      Top             =   5310
      Width           =   1275
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
      Left            =   8460
      TabIndex        =   0
      Top             =   5310
      Width           =   1275
   End
   Begin VB.VScrollBar vsMirrorY 
      Height          =   3765
      Left            =   240
      TabIndex        =   3
      Top             =   840
      Width           =   255
   End
   Begin VB.HScrollBar hsMirrorX 
      Height          =   255
      Left            =   540
      TabIndex        =   4
      Top             =   540
      Width           =   4125
   End
   Begin VB.PictureBox picMirrorPos 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   3765
      Left            =   540
      ScaleHeight     =   3735
      ScaleWidth      =   4065
      TabIndex        =   8
      Top             =   840
      Width           =   4095
   End
   Begin Threed.SSCheck chkSubtract 
      Height          =   255
      Left            =   8010
      TabIndex        =   32
      Top             =   240
      Width           =   1755
      _Version        =   65536
      _ExtentX        =   3096
      _ExtentY        =   450
      _StockProps     =   78
      Caption         =   "Use bias subtraction"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   1
      Font3D          =   3
   End
   Begin Threed.SSCheck chkDigitiser 
      Height          =   255
      Left            =   6510
      TabIndex        =   31
      Top             =   240
      Width           =   885
      _Version        =   65536
      _ExtentX        =   1561
      _ExtentY        =   450
      _StockProps     =   78
      Caption         =   "Enabled"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Mirror position:"
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
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   180
      Width           =   1455
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "mirror steps per mm"
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
      Left            =   7800
      TabIndex        =   16
      Top             =   4800
      Width           =   1545
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Lens modifier:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Left            =   5580
      TabIndex        =   15
      Top             =   4800
      Width           =   1065
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Resolution:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Left            =   5580
      TabIndex        =   17
      Top             =   4350
      Width           =   825
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Digitiser:"
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
      Height          =   255
      Left            =   5610
      TabIndex        =   12
      Top             =   240
      Width           =   855
   End
End
Attribute VB_Name = "frmMirrorSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim scanx, scany, maxint, minint, intensity, resolution
Dim halt As Integer
Dim sweep As Long
Dim size_of_scale As Long, scale_offset As Long

Private Sub chkDigitiser_Click(Value As Integer)
If Value = False Then
gQUIT = 1
Else
gQUIT = 0
PerformSweeps
End If
End Sub

Private Sub cmbResolution_Click()
resolution = Val(cmbResolution.Text) / 2
SetMirrorResolution
picMirrorPos.Cls
End Sub

Private Sub cmdCancel_Click()
gQUIT = 1
halt = 2: pause 1000
Close
frmMirrorSetup.Hide
End Sub

Private Sub cmdCentre_Click()
txtCentreX = Format$(Val(txtCentreX) + (Val(txtCurrentX)), "#0.00#")
txtCentreY = Format$(Val(txtCentreY) + (Val(txtCurrentY)), "#0.00#")
txtCurX = txtCentreX: txtCurY = txtCentreY
hsMirrorX.Value = 0
vsMirrorY.Value = 0
picMirrorPos.Cls
picScope.Cls
picMirrorPos.SetFocus
End Sub

Private Sub cmdHelp_Click()
txt$ = "This screen enables the user to manually adjust"
txt$ = txt$ + " the control mirrors in order to define"
txt$ = txt$ + " a centre position for a scan." + NL + NL
txt$ = txt$ + "As aids to the location of the centre, clicking"
txt$ = txt$ + " in the larger window will prompt an intensity"
txt$ = txt$ + " measurement, displayed in the corresponding position"
txt$ = txt$ + " of the smaller window." + NL + NL
txt$ = txt$ + "A low-resolution 'sweep' scan"
txt$ = txt$ + " of the entire range of the mirror control window can"
txt$ = txt$ + " also be performed, and clicking on a position in"
txt$ = txt$ + " the smaller window (for example, a point of high"
txt$ = txt$ + " intensity) will automatically move the main mirror"
txt$ = txt$ + " positioning control to that location." + NL + NL
txt$ = txt$ + "The user should note that the START and END coordinates for"
txt$ = txt$ + " a scan are defined relative to the centre that is set here,"
txt$ = txt$ + " according to the scan dimensions, set on the 'Image' form." + NL
txt$ = txt$ + "Clicking on 'OK' will move the scan centre to the current location of the "
txt$ = txt$ + "positioning bars (ie including offset), whereas 'Cancel' will throw away "
txt$ = txt$ + "the offset information." + NL + NL
txt$ = txt$ + "The resolution of the positioning window can be varied through a wide range, "
txt$ = txt$ + "using the control provided. Note that, for example, '20mm x 20mm' implies offsets"
txt$ = txt$ + " between -10mm and +10mm relative to the centre, on each axis."
frmPad!txtPad = txt$
frmPad.Tag = "show:Mirror Setup Help"
frmPad.Show 1

End Sub

Private Sub cmdOK_Click()
gQUIT = 1
cmdCentre_Click
halt = 2: pause 800
Close
' save mirror settings to scan.ini
section$ = "Last scan"
bool = WritePrivateProfileString(ByVal section$, ByVal "CentreX", ByVal Str$(txtCentreX), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "CentreY", ByVal Str$(txtCentreY), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Mirror steps per mm", ByVal Str$(cmbLens.Text), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Resolution", ByVal Str$(cmbResolution.ListIndex), ByVal "c:\scan\scan.ini")
frmMirrorSetup.Hide
End Sub

Private Sub Form_Activate()
SetupDigitiser
UpdateSetupWindow

halt = 0
resolution = Val(cmbResolution.Text) / 2
SetMirrorResolution
maxint = -1000000#: minint = 1000000#
picScope.FillStyle = 0
Close
txtCurX = txtCentreX: txtCurY = txtCentreY

If nomirrors = False Then
'reset mirrors
'frmSCAN!Comm1.Output = "BX0" & Chr$(13)
'frmSCAN!Comm1.Output = "BY0" & Chr$(13)

MoveXMirror
MoveYMirror
End If

imagetmpfile = "c:\tmp\temp.img"
'picMirrorPos.SetFocus
Open imagetmpfile For Output As #2
End Sub

Private Sub Form_Load()

CentreForm Me
picScope.Scale (0, 0)-(10, 8)
For X% = 0 To 10
For Y% = 0 To 8
picScope.Line (0, Y%)-(10, Y%)
picScope.Line (X%, 0)-(X%, 8)
Next: Next
picScope.AutoRedraw = False



cmbResolution.AddItem "9mm x 9mm"
cmbResolution.AddItem "5mm x 5mm"
cmbResolution.AddItem "2mm x 2mm"
cmbResolution.AddItem "1mm x 1mm"
cmbResolution.AddItem "0.5mm x 0.5mm"
cmbResolution.ListIndex = 1

cmbLens.AddItem "384"
cmbLens.ListIndex = 0

section$ = "Last scan"
frmMirrorSetup!txtCentreX = GetINIString(section$, "CentreX")
frmMirrorSetup!txtCentreY = GetINIString(section$, "CentreY")
frmMirrorSetup!cmbLens.Text = GetINIString(section$, "Mirror steps per mm")
frmMirrorSetup!cmbResolution.ListIndex = GetINIInt(section$, "Resolution")

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
Close #2
End Sub

Private Sub hsMirrorX_Change()
Dim Red As Integer
Red = RGB(255, 0, 0)
picMirrorPos.PSet (hsMirrorX.Value, vsMirrorY.Value), Red
txtCurrentX = Format$(hsMirrorX.Value / 100, "#0.00#")
txtCurX = Format$(Val(txtCentreX) + (Val(txtCurrentX)), "#0.00#")
MoveXMirror

End Sub

Private Sub MoveXMirror()
gQUIT = 2 ' instructs digitiser to clear data and restart
mirror_xpos = ((Val(frmMirrorSetup!txtCurrentX)) + Val(txtCentreX))
mirror_xpos = mirror_xpos * 10 / 4.5
If Abs(mirror_xpos) > 10 Then
MsgBox ("Invalid Mirror Position")
Else
optRedLight.Value = True
 MirrorCommand "BX", Format(mirror_xpos, "#0.00#")
If cmd_done = 1 Then optGreenLight.Value = True
End If
End Sub

Private Sub MoveYMirror()
gQUIT = 2 ' instructs digitiser to clear data and restart
mirror_ypos = Val(txtCentreY) + ((Val(txtCurrentY)))
mirror_ypos = mirror_ypos * 10 / 4.5
If Abs(mirror_ypos) > 10 Then
MsgBox ("Invalid Mirror Position")
Else
optRedLight.Value = True
MirrorCommand "BY", Format(mirror_ypos, "#0.00#")
If cmd_done = 1 Then optGreenLight.Value = True
End If
End Sub

Private Sub optGreenLight_Click()
If optGreenLight.Value = True Then optRedLight.Value = False
End Sub

Private Sub optRedLight_Click()
If optRedLight.Value = True Then optGreenLight.Value = False
End Sub

Private Sub PerformSweeps()
sweeps = 0
offset = Int((655.36 * gDIG_AMPOFFSET) + 0.5)
Do
DoEvents

If gQUIT = 2 Or software_sweeps = 0 Then
For i% = 0 To rec_on_screen%
hidata(0, i%) = 0
Next
software_sweeps = 0
gQUIT = 0
End If

'GetTrace 0
   AcquireOne
   For i% = 0 To rec_on_screen%
    hidata(trace, i%) = hidata(trace, i%) + (dataray(i%) - offset)
   Next

software_sweeps = software_sweeps + 1

If software_sweeps Mod 16 = 1 Then
size_of_scale = 65536 * software_sweeps
scale_offset = size_of_scale * (gDIG_AMPOFFSET / 100)
picScope.Scale (0, size_of_scale - scale_offset)-(rec_on_screen%, -scale_offset)
picScope.Cls
showtrace frmMirrorSetup!picScope, 0, YELLOW
End If

Loop Until gQUIT = 1
End Sub

Private Sub picMirrorPos_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = KEY_UP And vsMirrorY.Value < vsMirrorY.min Then vsMirrorY.Value = vsMirrorY.Value + vsMirrorY.SmallChange
If KeyCode = KEY_DOWN And vsMirrorY.Value > vsMirrorY.max Then vsMirrorY.Value = vsMirrorY.Value - vsMirrorY.SmallChange
If KeyCode = KEY_RIGHT And hsMirrorX.Value < hsMirrorX.max Then hsMirrorX.Value = hsMirrorX.Value + hsMirrorX.SmallChange
If KeyCode = KEY_LEFT And hsMirrorX.Value > hsMirrorX.min Then hsMirrorX.Value = hsMirrorX.Value - hsMirrorX.SmallChange

End Sub

Private Sub picMirrorPos_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
hsMirrorX = X: vsMirrorY = Y
End Sub

Private Sub SetMirrorResolution()
hsMirrorX.max = resolution * 100
hsMirrorX.min = -1 * hsMirrorX.max
hsMirrorX.Value = 0
hsMirrorX.LargeChange = hsMirrorX.max / 10
If hsMirrorX.max < 100 Then
 hsMirrorX.SmallChange = 1
Else
 hsMirrorX.SmallChange = hsMirrorX.max / 100
End If

vsMirrorY.min = resolution * 100
vsMirrorY.max = -1 * vsMirrorY.min
vsMirrorY.Value = 0
vsMirrorY.LargeChange = vsMirrorY.min / 10
If vsMirrorY.min < 100 Then
 vsMirrorY.SmallChange = 1
Else
 vsMirrorY.SmallChange = vsMirrorY.min / 100
End If

txtCurrentX = Format$(hsMirrorX.Value, "+#0.00;-#0.00")
txtCurrentY = Format$(vsMirrorY.Value, "+#0.00;-#0.00")

picMirrorPos.Scale (-resolution * 100, resolution * 100)-(resolution * 100, -resolution * 100)

picMirrorPos.CurrentX = 0
picMirrorPos.CurrentY = 0
picMirrorPos.DrawWidth = 1
picMirrorPos.Line (0, -resolution * 100)-(0, resolution * 100)
picMirrorPos.Line (-resolution * 100, 0)-(resolution * 100, 0)
picMirrorPos.AutoRedraw = False
picMirrorPos.DrawWidth = 2
End Sub

Private Sub txtCentreX_KeyPress(keyAscii As Integer)
If keyAscii = 13 Or keyAscii = 9 Then
txtCurX = txtCentreX: txtCurY = txtCentreY
hsMirrorX.Value = 0
vsMirrorY.Value = 0
picMirrorPos.Cls
picScope.Cls
End If

End Sub

Private Sub txtCentreX_LostFocus()
txtCurX = txtCentreX: txtCurY = txtCentreY
hsMirrorX.Value = 0
vsMirrorY.Value = 0
picMirrorPos.Cls
picScope.Cls
picMirrorPos.SetFocus
End Sub

Private Sub txtCentreY_KeyPress(keyAscii As Integer)
If keyAscii = 9 Or keyAscii = 13 Then
txtCurX = txtCentreX: txtCurY = txtCentreY
hsMirrorX.Value = 0
vsMirrorY.Value = 0
picMirrorPos.Cls
picScope.Cls
End If

End Sub

Private Sub txtCentreY_LostFocus()
txtCurX = txtCentreX: txtCurY = txtCentreY
hsMirrorX.Value = 0
vsMirrorY.Value = 0
picMirrorPos.Cls
picScope.Cls
picMirrorPos.SetFocus
End Sub

Private Sub txtCurrentX_KeyPress(keyAscii As Integer)
If keyAscii = 9 Or keyAscii = 13 Then
hsMirrorX.Value = Val(txtCurrentX) * 100
End If

End Sub

Private Sub txtCurrentX_LostFocus()
hsMirrorX.Value = Val(txtCurrentX) * 100
picMirrorPos.SetFocus
End Sub

Private Sub txtCurrentY_KeyPress(keyAscii As Integer)
If keyAscii = 9 Or keyAscii = 13 Then
vsMirrorY.Value = Val(txtCurrentY) * 100
End If

End Sub

Private Sub txtCurrentY_LostFocus()
vsMirrorY.Value = Val(txtCurrentY) * 100
picMirrorPos.SetFocus
End Sub

Private Sub txtCurX_KeyPress(keyAscii As Integer)
If keyAscii = 13 Or keyAscii = 9 Then
txtCurrentX = Str$((Val(txtCurX) - Val(txtCentreX)) / Val(cmbLens.Text))
If Abs(txtCurrentX * 100) <= hsMirrorX.max Then
hsMirrorX.Value = Val(txtCurrentX) * 100
Else
MsgBox ("Cannot adjust scrollbar - off range. Suggest changing resolution or setting new position as a centre.")
End If
End If
End Sub

Private Sub txtCurX_LostFocus()
txtCurrentX = Str$((Val(txtCurX) - Val(txtCentreX)) / Val(cmbLens.Text))
If Abs(txtCurrentX * 100) <= hsMirrorX.max Then
hsMirrorX.Value = Val(txtCurrentX) * 100
Else
MsgBox ("Cannot adjust scrollbar - off range. Suggest changing resolution or setting new position as a centre.")
End If
picMirrorPos.SetFocus
End Sub

Private Sub txtCurY_KeyPress(keyAscii As Integer)
If keyAscii = 13 Or keyAscii = 9 Then
txtCurrentY = Str$((Val(txtCurY) - Val(txtCentreY)) / Val(cmbLens.Text))
If Abs(Val(txtCurrentY) * 100) <= vsMirrorY.min Then
vsMirrorY.Value = Val(txtCurrentY) * 100
Else
MsgBox ("Cannot adjust scrollbar - off range. Suggest changing resolution or setting new position as a centre.")
End If
End If
End Sub

Private Sub txtCurY_LostFocus()
txtCurrentY = Str$((Val(txtCurY) - Val(txtCentreY)) / Val(cmbLens.Text))
If Abs(txtCurrentY * 100) <= vsMirrorY.min Then
vsMirrorY.Value = Val(txtCurrentY) * 100
Else
MsgBox ("Cannot adjust scrollbar - off range. Suggest changing resolution or setting new position as a centre.")
End If
picMirrorPos.SetFocus
End Sub

Private Sub vsMirrorY_Change()
Dim Red As Integer
Red = RGB(255, 0, 0)
picMirrorPos.PSet (hsMirrorX.Value, vsMirrorY.Value), Red
txtCurrentY = Format(vsMirrorY.Value / 100, "#0.00#")
txtCurY = Format$(Val(txtCentreY) + (Val(txtCurrentY)), "#0.00#")
MoveYMirror

End Sub

