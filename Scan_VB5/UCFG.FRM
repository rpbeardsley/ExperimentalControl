VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmUserConfig 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "User configuration"
   ClientHeight    =   6690
   ClientLeft      =   1500
   ClientTop       =   825
   ClientWidth     =   7530
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
   HelpContextID   =   340
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6690
   ScaleWidth      =   7530
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
      Height          =   405
      Left            =   4380
      TabIndex        =   15
      Top             =   6090
      Width           =   1275
   End
   Begin Threed.SSFrame Frame3D1 
      Height          =   4245
      Left            =   5640
      TabIndex        =   10
      Top             =   1350
      Width           =   1395
      _Version        =   65536
      _ExtentX        =   2461
      _ExtentY        =   7488
      _StockProps     =   14
      Caption         =   "Image colours"
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
      Begin VB.CommandButton cmdColourChange 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Change >>"
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
         Left            =   150
         TabIndex        =   12
         Top             =   3840
         Width           =   1065
      End
      Begin VB.PictureBox picKey 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   3375
         Left            =   180
         ScaleHeight     =   3345
         ScaleWidth      =   645
         TabIndex        =   11
         Top             =   330
         Width           =   675
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "max"
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
         Left            =   930
         TabIndex        =   14
         Top             =   240
         Width           =   435
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "min"
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
         Height          =   165
         Left            =   930
         TabIndex        =   13
         Top             =   3570
         Width           =   435
      End
   End
   Begin VB.CommandButton cmdNewUser 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Enter new user"
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
      Left            =   3060
      TabIndex        =   8
      Top             =   120
      Width           =   1785
   End
   Begin VB.ComboBox cmbUsers 
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
      Left            =   1500
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   150
      Width           =   1395
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
      Height          =   405
      Left            =   2820
      TabIndex        =   2
      Top             =   6090
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
      Height          =   405
      Left            =   1080
      TabIndex        =   1
      Top             =   6090
      Width           =   1275
   End
   Begin Threed.SSFrame Frame3D2 
      Height          =   5025
      Left            =   240
      TabIndex        =   9
      Top             =   810
      Width           =   6915
      _Version        =   65536
      _ExtentX        =   12197
      _ExtentY        =   8864
      _StockProps     =   14
      Caption         =   "Directories and filenames"
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
      Begin VB.CommandButton cmdDATbrowse 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Change"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   2
         Left            =   4020
         TabIndex        =   30
         Top             =   1080
         Width           =   945
      End
      Begin VB.TextBox txtDATdir 
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
         Index           =   2
         Left            =   1950
         TabIndex        =   4
         Text            =   "f:\"
         Top             =   1050
         Width           =   1875
      End
      Begin Threed.SSFrame Frame3D5 
         Height          =   645
         Left            =   180
         TabIndex        =   17
         Top             =   3300
         Width           =   2775
         _Version        =   65536
         _ExtentX        =   4895
         _ExtentY        =   1138
         _StockProps     =   14
         Caption         =   "Text data save format:"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSOption Option3D2 
            Height          =   210
            Left            =   120
            TabIndex        =   5
            Top             =   300
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "Text (*.dat)"
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
         End
         Begin Threed.SSOption Option3D1 
            Height          =   195
            Left            =   1320
            TabIndex        =   21
            TabStop         =   0   'False
            Top             =   300
            Width           =   1305
            _Version        =   65536
            _ExtentX        =   2302
            _ExtentY        =   344
            _StockProps     =   78
            Caption         =   "Binary (*.dax)"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin Threed.SSFrame Frame3D4 
         Height          =   885
         Left            =   180
         TabIndex        =   24
         Top             =   2250
         Width           =   2775
         _Version        =   65536
         _ExtentX        =   4895
         _ExtentY        =   1561
         _StockProps     =   14
         Caption         =   "Image data save format:"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSCheck Check3D2 
            Height          =   225
            Left            =   120
            TabIndex        =   25
            Top             =   540
            Width           =   2505
            _Version        =   65536
            _ExtentX        =   4419
            _ExtentY        =   397
            _StockProps     =   78
            Caption         =   "Save image bitmaps by default"
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
         Begin Threed.SSOption optText 
            Height          =   210
            Left            =   120
            TabIndex        =   26
            TabStop         =   0   'False
            Top             =   270
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "Text (*.img)"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption optBinary 
            Height          =   195
            Left            =   1320
            TabIndex        =   27
            Top             =   270
            Width           =   1305
            _Version        =   65536
            _ExtentX        =   2302
            _ExtentY        =   344
            _StockProps     =   78
            Caption         =   "Binary (*.imx)"
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
         End
      End
      Begin VB.CommandButton cmdDATbrowse 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Change"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   1
         Left            =   4020
         TabIndex        =   18
         Top             =   720
         Width           =   945
      End
      Begin VB.TextBox txtDATdir 
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
         Index           =   1
         Left            =   1950
         TabIndex        =   19
         Text            =   "f:\"
         Top             =   690
         Width           =   1875
      End
      Begin VB.CommandButton cmdDATbrowse 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Change"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   4020
         TabIndex        =   0
         Top             =   330
         Width           =   945
      End
      Begin VB.TextBox txtDATdir 
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
         Index           =   0
         Left            =   1950
         TabIndex        =   3
         Text            =   "c:\"
         Top             =   330
         Width           =   1875
      End
      Begin Threed.SSCheck Check3D1 
         Height          =   285
         Left            =   210
         TabIndex        =   16
         Top             =   1410
         Width           =   3825
         _Version        =   65536
         _ExtentX        =   6747
         _ExtentY        =   503
         _StockProps     =   78
         Caption         =   "Network directory takes priority when logged in."
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
      Begin Threed.SSCheck chkDatedDirs 
         Height          =   225
         Left            =   210
         TabIndex        =   23
         Top             =   1950
         Width           =   4575
         _Version        =   65536
         _ExtentX        =   8070
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Create dated subdirectories of primary directories above."
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
      Begin Threed.SSCheck chkAutoSave 
         Height          =   255
         Left            =   210
         TabIndex        =   22
         Top             =   1680
         Width           =   3855
         _Version        =   65536
         _ExtentX        =   6800
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Auto-save data (creates files 1.dat, 2.dat, etc)"
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
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Address book directory:"
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
         TabIndex        =   28
         Top             =   1080
         Width           =   1815
      End
      Begin VB.Label Label12 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Network data directory:"
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
         TabIndex        =   29
         Top             =   720
         Width           =   1755
      End
      Begin VB.Label Label17 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Local data directory:"
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
         Left            =   360
         TabIndex        =   20
         Top             =   360
         Width           =   1545
      End
   End
   Begin VB.Label Label9 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Current User:"
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
      Left            =   390
      TabIndex        =   7
      Top             =   180
      Width           =   1065
   End
End
Attribute VB_Name = "frmUserConfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim uname(8) As String
Dim oldname, olduser, firstfree

Private Sub cmbUsers_Click()
CurUser = Trim$(cmbUsers.Text)
If (CurUser <> olduser) And olduser <> "" Then
 SaveUserSettings olduser
 LoadUserSettings CurUser
 savedirectory = CheckPresent(gDATdir)
 imagesavefile = GetFileName(True, gDATdir, ".img")
 olduser = CurUser
 ShowUserSettings
End If
End Sub

Private Sub cmdCancel_Click()
Unload frmUserConfig
End Sub

Private Sub cmdColourChange_Click()
frmImageColoursSetup.Show 1
DrawColKey
End Sub

Private Sub cmdDATbrowse_Click(Index As Integer)
gDATA_TYPE = BROWSE
frmFileIO!lstFile.Enabled = 0
frmFileIO!cmdOK.Visible = True
frmFileIO.Show 1
frmFileIO!lstFile.Enabled = 1
If gQUIT = 0 Then txtDATdir(Index) = Path
End Sub

Private Sub cmdNewUser_Click()
Do
newname$ = InputBox("Enter new user ID (max 6 chr)")
Loop Until Len(newname$) < 7

' save existing user settings
SaveUserSettings (CurUser)

' load default settings, save them as initial
' settings for the new user
LoadUserSettings ("dflt")
SaveUserSettings (newname$)

' Add new name to official list
ret% = WritePrivateProfileString(ByVal "Users", ByVal Format$(firstfree, "0"), ByVal newname$, ByVal "c:\scan\scan.ini")
firstfree = firstfree + 1
CurUser = newname$: olduser = newname$
ShowUserSettings
cmbUsers.AddItem newname$
cmbUsers.ListIndex = cmbUsers.ListCount - 1
End Sub

Private Sub cmdOK_Click()
SaveUserSettings (CurUser)
gDATdir = txtDATdir(0)

frmUserConfig.Hide
End Sub

Private Sub DrawColKey()
If gCOLOURS <= 256 Then
picKey.Picture = LoadPicture("c:\tmp\palette.bmp")
End If

picKey.ScaleHeight = 256
picKey.ScaleWidth = 5
picKey.DrawWidth = 3

For i% = 0 To 255
picKey.ForeColor = colour(i%)
picKey.Line (0, 255 - i%)-(5, 255 - i%)
Next i%

End Sub

Private Sub Form_Activate()
frmFileIO.Caption = "Browsing directories"
cmdOK.SetFocus
End Sub

Private Sub Form_Load()
CentreForm Me
current = 1: firstfree = 0

For i% = 1 To 8
uname(i%) = GetINIString("Users", Format$(i%, "0"))
If uname(i%) <> "" Then cmbUsers.AddItem uname(i%) Else If firstfree = 0 Then firstfree = i%
If uname(i%) = CurUser Then current = i%
Next
cmbUsers.ListIndex = current - 1

olduser = CurUser
ShowUserSettings

End Sub

Private Sub ShowUserSettings()
txtDATdir(0) = gDATdir
txtUsername = gUSERNAME
DrawColKey
End Sub

