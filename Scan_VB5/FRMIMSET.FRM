VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.0#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmImageSetup 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Image"
   ClientHeight    =   4545
   ClientLeft      =   1590
   ClientTop       =   2070
   ClientWidth     =   5970
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
   HelpContextID   =   310
   LinkTopic       =   "Form5"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4545
   ScaleWidth      =   5970
   Begin VB.CommandButton cmdMagSetup 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Magnet Setup"
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
      Left            =   4200
      TabIndex        =   5
      Top             =   3360
      Width           =   1635
   End
   Begin VB.CommandButton cmdLockSetup 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Lock-in Setup"
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
      Left            =   4200
      TabIndex        =   3
      Top             =   2220
      Width           =   1635
   End
   Begin VB.CommandButton cmdImageColours 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "User Setup"
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
      Left            =   4200
      TabIndex        =   6
      Top             =   3930
      Width           =   1635
   End
   Begin VB.CommandButton cmdDigSetup 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Digitiser Setup"
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
      Left            =   4200
      TabIndex        =   2
      Top             =   1650
      Width           =   1635
   End
   Begin VB.ComboBox cboSource 
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
      Left            =   1260
      Style           =   2  'Dropdown List
      TabIndex        =   16
      Top             =   3570
      Width           =   1995
   End
   Begin VB.TextBox txtStepSize 
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
      Height          =   315
      Left            =   1020
      TabIndex        =   11
      Text            =   "100"
      Top             =   510
      Width           =   705
   End
   Begin VB.TextBox txtHeight 
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
      Height          =   315
      Left            =   780
      TabIndex        =   9
      Text            =   "2"
      Top             =   1380
      Width           =   705
   End
   Begin VB.TextBox txtWidth 
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
      Height          =   315
      Left            =   780
      TabIndex        =   7
      Text            =   "2"
      Top             =   930
      Width           =   705
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Scan parameters"
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
      Height          =   3195
      Left            =   120
      TabIndex        =   19
      Top             =   180
      Width           =   3885
      Begin MSMask.MaskEdBox txtMagnetPSU 
         Height          =   285
         Index           =   0
         Left            =   1050
         TabIndex        =   13
         Top             =   2790
         Width           =   645
         _Version        =   65536
         _ExtentX        =   1138
         _ExtentY        =   503
         _StockProps     =   109
         BackColor       =   -2147483643
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   1
         Format          =   "0.000"
      End
      Begin MSMask.MaskEdBox txtMagnetPSU 
         Height          =   285
         Index           =   1
         Left            =   2070
         TabIndex        =   14
         Top             =   2790
         Width           =   645
         _Version        =   65536
         _ExtentX        =   1138
         _ExtentY        =   503
         _StockProps     =   109
         BackColor       =   -2147483643
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   1
         Format          =   "0.000"
      End
      Begin VB.ComboBox cmbDirection 
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
         Left            =   1650
         Style           =   2  'Dropdown List
         TabIndex        =   33
         Top             =   1770
         Width           =   1515
      End
      Begin VB.TextBox txtAngle 
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
         Left            =   1020
         TabIndex        =   12
         Text            =   "0"
         Top             =   2160
         Width           =   645
      End
      Begin VB.TextBox txtHeightSteps 
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
         Height          =   315
         Left            =   1950
         TabIndex        =   10
         Top             =   1200
         Width           =   585
      End
      Begin VB.TextBox txtWidthSteps 
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
         Height          =   315
         Left            =   1950
         TabIndex        =   8
         Top             =   750
         Width           =   585
      End
      Begin VB.Line Line2 
         X1              =   90
         X2              =   3690
         Y1              =   2640
         Y2              =   2640
      End
      Begin VB.Label Label15 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Scan base direction:"
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
         TabIndex        =   32
         Top             =   1800
         Width           =   1515
      End
      Begin VB.Label Label14 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tesla"
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
         Left            =   2790
         TabIndex        =   31
         Top             =   2820
         Width           =   405
      End
      Begin VB.Label Label13 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "V = "
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
         Left            =   1740
         TabIndex        =   30
         Top             =   2820
         Width           =   285
      End
      Begin VB.Label Label12 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Magnet PSU:"
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
         Height          =   195
         Left            =   90
         TabIndex        =   29
         Top             =   2820
         Width           =   915
      End
      Begin VB.Line Line1 
         X1              =   90
         X2              =   3690
         Y1              =   1650
         Y2              =   1650
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "degrees anticlockwise wrt base direction."
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
         Height          =   405
         Left            =   1710
         TabIndex        =   27
         Top             =   2130
         Width           =   1755
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Scan angle:"
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
         TabIndex        =   28
         Top             =   2190
         Width           =   885
      End
      Begin VB.Label Label9 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "steps (max 300)"
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
         Left            =   2580
         TabIndex        =   25
         Top             =   1260
         Width           =   1215
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "steps (max 300)"
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
         Left            =   2580
         TabIndex        =   26
         Top             =   780
         Width           =   1245
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "um"
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
         TabIndex        =   24
         Top             =   390
         Width           =   315
      End
      Begin VB.Label Label6 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "mm   ="
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
         Left            =   1410
         TabIndex        =   23
         Top             =   1260
         Width           =   525
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "mm   ="
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
         Left            =   1410
         TabIndex        =   22
         Top             =   810
         Width           =   525
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Step size:"
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
         TabIndex        =   15
         Top             =   390
         Width           =   855
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Height:"
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
         TabIndex        =   21
         Top             =   1260
         Width           =   1095
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Width:"
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
         Top             =   810
         Width           =   1095
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
      Height          =   495
      Left            =   4200
      TabIndex        =   1
      Top             =   810
      Width           =   1635
   End
   Begin VB.CommandButton cmdMirrorSetup 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Mirror Setup"
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
      Left            =   4200
      TabIndex        =   4
      Top             =   2790
      Width           =   1635
   End
   Begin VB.CommandButton cmdGo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Go"
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
      Left            =   4200
      TabIndex        =   0
      Top             =   240
      Width           =   1635
   End
   Begin Threed.SSCheck optAutoRescale 
      Height          =   285
      Left            =   180
      TabIndex        =   17
      Top             =   4140
      Width           =   3405
      _Version        =   65536
      _ExtentX        =   6006
      _ExtentY        =   503
      _StockProps     =   78
      Caption         =   "Auto rescale colours while scanning"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Value           =   -1  'True
      Font3D          =   3
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Data source:"
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
      Left            =   150
      TabIndex        =   18
      Top             =   3600
      Width           =   1095
   End
End
Attribute VB_Name = "frmImageSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cboSource_Click()
If cboSource.Text = "Digitiser" Then
    cmdDigSetup.Enabled = True
Else
    cmdDigSetup.Enabled = False
End If
If cboSource.Text = "Lock-in amplifier" Then
    cmdLockSetup.Enabled = True
Else
    cmdLockSetup.Enabled = False
End If

End Sub

Private Sub cboSource_KeyPress(keyAscii As Integer)
keyAscii = 0
End Sub

Private Sub cmdCancel_Click()
Unload frmImageSetup
End Sub

Private Sub cmdDigSetup_Click()
frmDigSetup.Show 1
End Sub

Private Sub cmdGo_Click()
section$ = "Last scan"
bool = WritePrivateProfileString(ByVal section$, ByVal "Width", ByVal Str$(txtWidth), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Height", ByVal Str$(txtHeight), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Stepsize", ByVal Str$(txtStepSize), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Angle", ByVal Str$(txtAngle), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Magnet", ByVal Str$(txtMagnetPSU(0)), ByVal "c:\scan\scan.ini")
bool = WritePrivateProfileString(ByVal section$, ByVal "Direction", ByVal Str$(cmbDirection.ListIndex), ByVal "c:\scan\scan.ini")

mode = TAKEDATA
frmImageDisplay.Show 1
End Sub

Private Sub cmdImageColours_Click()
frmUserConfig.Show 1
End Sub

Private Sub cmdLockSetup_Click()
frmLockIn.Show 1
End Sub

Private Sub cmdMagSetup_Click()
frmFieldSweep.Show 1
End Sub

Private Sub cmdMirrorSetup_Click()
frmMirrorSetup.Show 1
End Sub

Private Sub Form_Activate()
txtWidthSteps.Text = Str$(Int(1000 * Val(txtWidth.Text) / Val(txtStepSize.Text)))
txtHeightSteps.Text = Str$(Int(1000 * Val(txtHeight.Text) / Val(txtStepSize.Text)))

End Sub

Private Sub Form_Load()

CentreForm Me
' set up source combo box

cboSource.AddItem "DMM1"
cboSource.AddItem "DMM2"
cboSource.AddItem "Boxcar"
cboSource.AddItem "Digitiser"
cboSource.AddItem "Lock-in amplifier"
cboSource.AddItem "Eclipse"
cboSource.ListIndex = 3
cmbDirection.AddItem "Along Y"
cmbDirection.AddItem "Along X"
cmbDirection.ListIndex = 0
txtMagnetPSU(0).Text = "0": txtMagnetPSU(1).Text = "0"

' [Last scan]
section$ = "Last scan"
frmImageSetup!txtWidth.Text = GetINIString(section$, "Width")
frmImageSetup!txtHeight.Text = GetINIString(section$, "Height")
frmImageSetup!cmbDirection.ListIndex = GetINIInt(section$, "Direction")
frmImageSetup!txtStepSize.Text = GetINIString(section$, "Stepsize")
frmImageSetup!txtAngle.Text = GetINIString(section$, "Angle")
frmImageSetup!txtMagnetPSU(0).Text = GetINIString(section$, "Magnet")

End Sub

Private Sub txtHeight_keypress(keyAscii As Integer)
 If keyAscii = 13 Or keyAscii = 9 Then
  txtHeightSteps.Text = Str$(1000 * Val(txtHeight.Text) / Val(txtStepSize.Text))
 End If
End Sub

Private Sub txtHeight_LostFocus()
txtHeight_keypress (9)
End Sub

Private Sub txtHeightSteps_keypress(keyAscii As Integer)
 If keyAscii = 13 Or keyAscii = 9 Then
  txtHeight.Text = Str$(Val(txtStepSize) * Val(txtHeightSteps) / 1000)
End If
End Sub

Private Sub txtHeightSteps_LostFocus()
txtHeightSteps_keypress (9)
End Sub

Private Sub txtMagnetPSU_LostFocus(Index As Integer)
txtMagnetPSU(Index Xor 1).Text = Str$(Val(txtMagnetPSU(Index).Text) * ((46.73 / Val(frmFieldSweep!txtStepDown)) ^ -(Index * 2 - 1)))
End Sub

Private Sub txtStepSize_keypress(keyAscii As Integer)
 If keyAscii = 13 Or keyAscii = 9 Then
  'If Val(txtStepSize.Text) < 10 Then txtStepSize.Text = "10"
  txtWidthSteps.Text = Str$(Int(0.5 + (1000 * Val(txtWidth.Text) / Val(txtStepSize.Text))))
  txtHeightSteps.Text = Str$(Int(0.5 + (1000 * Val(txtHeight.Text) / Val(txtStepSize.Text))))
 End If

End Sub

Private Sub txtStepSize_LostFocus()
txtStepSize_keypress (9)
End Sub

Private Sub txtWidth_keypress(keyAscii As Integer)
 If keyAscii = 13 Or keyAscii = 9 Then
  txtWidthSteps.Text = Str$(Int(1000 * Val(txtWidth.Text) / Val(txtStepSize.Text)))
 End If
End Sub

Private Sub txtWidth_LostFocus()
txtWidth_keypress (9)
End Sub

Private Sub txtWidthSteps_keypress(keyAscii As Integer)
 If keyAscii = 13 Or keyAscii = 9 Then
  txtWidth.Text = Str$(Val(txtStepSize) * Val(txtWidthSteps) / 1000)
  End If
End Sub

Private Sub txtWidthSteps_LostFocus()
txtWidthSteps_keypress (9)
End Sub

