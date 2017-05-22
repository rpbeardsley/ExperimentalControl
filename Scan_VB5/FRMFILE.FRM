VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmFileIO 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "File load/save"
   ClientHeight    =   5925
   ClientLeft      =   1560
   ClientTop       =   1815
   ClientWidth     =   8055
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
   HelpContextID   =   320
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5925
   ScaleWidth      =   8055
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
      Left            =   4650
      TabIndex        =   40
      Top             =   5490
      Visible         =   0   'False
      Width           =   1335
   End
   Begin Threed.SSFrame frameSaveFile 
      Height          =   2085
      Left            =   4260
      TabIndex        =   28
      Top             =   3300
      Width           =   3705
      _Version        =   65536
      _ExtentX        =   6535
      _ExtentY        =   3678
      _StockProps     =   14
      Caption         =   "File to save:"
      ForeColor       =   192
      Enabled         =   0   'False
      Begin VB.CommandButton cmdSave 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "SAVE"
         Height          =   405
         Left            =   2460
         TabIndex        =   2
         Top             =   1410
         Width           =   975
      End
      Begin VB.TextBox txtNamePrefix 
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
         Left            =   1200
         MaxLength       =   6
         TabIndex        =   1
         Top             =   510
         Width           =   705
      End
      Begin VB.TextBox txtSaveDirectory 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   1200
         TabIndex        =   30
         TabStop         =   0   'False
         Top             =   270
         Width           =   2205
      End
      Begin Threed.SSCheck chkBitmap 
         Height          =   195
         Left            =   1200
         TabIndex        =   35
         Top             =   1800
         Width           =   945
         _Version        =   65536
         _ExtentX        =   1667
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Bitmap"
         Font3D          =   3
      End
      Begin Threed.SSCheck chkText 
         Height          =   195
         Left            =   1200
         TabIndex        =   34
         Top             =   1380
         Width           =   945
         _Version        =   65536
         _ExtentX        =   1667
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Text"
         Value           =   -1  'True
         Font3D          =   3
      End
      Begin Threed.SSCheck chkBinary 
         Height          =   195
         Left            =   1200
         TabIndex        =   33
         Top             =   1590
         Width           =   825
         _Version        =   65536
         _ExtentX        =   1455
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Binary"
         Font3D          =   3
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "NB:Numerical filenames not recommended, as they may clash with auto-saved files."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   435
         Left            =   150
         TabIndex        =   41
         Top             =   900
         Width           =   3315
      End
      Begin VB.Label Label14 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Save as:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   60
         TabIndex        =   36
         Top             =   1350
         Width           =   1095
      End
      Begin VB.Label Label13 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "(max 6 characters, no extension)"
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
         Height          =   435
         Left            =   1980
         TabIndex        =   32
         Top             =   480
         Width           =   1485
      End
      Begin VB.Label Label12 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Name PREFIX:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   60
         TabIndex        =   31
         Top             =   540
         Width           =   1095
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Directory:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   360
         TabIndex        =   29
         Top             =   270
         Width           =   1035
      End
   End
   Begin Threed.SSFrame frameSelectedFile 
      Height          =   3075
      Left            =   4230
      TabIndex        =   12
      Top             =   120
      Width           =   3735
      _Version        =   65536
      _ExtentX        =   6588
      _ExtentY        =   5424
      _StockProps     =   14
      Caption         =   "Currently selected file:"
      ForeColor       =   192
      Enabled         =   0   'False
      Begin VB.CommandButton cmdConvertFormat 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Convert"
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
         Left            =   2730
         TabIndex        =   27
         Top             =   2670
         Width           =   855
      End
      Begin VB.CommandButton cmdView 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "View/edit"
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
         Left            =   990
         TabIndex        =   24
         Top             =   2670
         Width           =   885
      End
      Begin VB.CommandButton cmdDelete 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Delete"
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
         Left            =   1860
         TabIndex        =   23
         Top             =   2670
         Width           =   855
      End
      Begin VB.CommandButton cmdOpen 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "OPEN"
         Height          =   285
         Left            =   150
         TabIndex        =   22
         Top             =   2670
         Width           =   855
      End
      Begin VB.TextBox txtFileFormat 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   780
         TabIndex        =   21
         Top             =   1080
         Width           =   2445
      End
      Begin VB.TextBox txtFileSize 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   750
         TabIndex        =   18
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox txtFileDateTime 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   810
         TabIndex        =   17
         Top             =   840
         Width           =   1995
      End
      Begin VB.TextBox txtFullFileName 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   780
         TabIndex        =   14
         Top             =   360
         Width           =   2685
      End
      Begin VB.TextBox txtFileInfo 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1245
         Left            =   810
         MultiLine       =   -1  'True
         TabIndex        =   26
         Top             =   1320
         Width           =   2625
      End
      Begin VB.Image imgBitmap 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         Height          =   1200
         Left            =   1200
         Stretch         =   -1  'True
         Top             =   1350
         Width           =   1200
      End
      Begin VB.Label Label10 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Info:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   60
         TabIndex        =   25
         Top             =   1320
         Width           =   675
      End
      Begin VB.Label Label9 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Format:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   60
         TabIndex        =   20
         Top             =   1080
         Width           =   675
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Size:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   270
         TabIndex        =   16
         Top             =   600
         Width           =   465
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Date:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   270
         TabIndex        =   15
         Top             =   840
         Width           =   465
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Name:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   180
         TabIndex        =   13
         Top             =   360
         Width           =   555
      End
   End
   Begin Threed.SSFrame frameFileManager 
      Height          =   5595
      Left            =   150
      TabIndex        =   6
      Top             =   90
      Width           =   3975
      _Version        =   65536
      _ExtentX        =   7011
      _ExtentY        =   9869
      _StockProps     =   14
      Caption         =   "SCAN File Manager"
      ForeColor       =   192
      Begin Threed.SSFrame frameFiles 
         Height          =   2475
         Left            =   90
         TabIndex        =   37
         Top             =   3030
         Width           =   3825
         _Version        =   65536
         _ExtentX        =   6747
         _ExtentY        =   4366
         _StockProps     =   14
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.TextBox txtFileName 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   0  'None
            Height          =   225
            Left            =   510
            TabIndex        =   19
            Top             =   150
            Width           =   2145
         End
         Begin VB.FileListBox lstFile 
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
            Height          =   1395
            Left            =   120
            TabIndex        =   39
            Top             =   390
            Width           =   3585
         End
         Begin VB.ComboBox lstFileExt 
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
            Left            =   150
            Style           =   2  'Dropdown List
            TabIndex        =   38
            Top             =   2070
            Width           =   3585
         End
         Begin VB.Label Label4 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "File:"
            ForeColor       =   &H00FF0000&
            Height          =   255
            Left            =   150
            TabIndex        =   4
            Top             =   150
            Width           =   495
         End
         Begin VB.Label Label1 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "File Extension(s):"
            ForeColor       =   &H00FF0000&
            Height          =   255
            Left            =   150
            TabIndex        =   10
            Top             =   1830
            Width           =   2415
         End
      End
      Begin VB.DriveListBox lstDrive 
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
         Left            =   210
         TabIndex        =   0
         Top             =   540
         Width           =   3555
      End
      Begin VB.DirListBox lstDirectory 
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
         Height          =   1470
         Left            =   210
         TabIndex        =   9
         Top             =   1200
         Width           =   3555
      End
      Begin VB.TextBox txtCurDirPath 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   225
         Left            =   1110
         TabIndex        =   8
         Top             =   960
         Width           =   2505
      End
      Begin VB.CommandButton cmdNewDir 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Create New"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   210
         TabIndex        =   7
         Top             =   2760
         Width           =   1455
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Drive:"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   210
         TabIndex        =   5
         Top             =   300
         Width           =   2175
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Directory:"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   210
         TabIndex        =   11
         Top             =   960
         Width           =   2415
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
      Height          =   345
      Left            =   6300
      TabIndex        =   3
      Top             =   5490
      Width           =   1335
   End
End
Attribute VB_Name = "frmFileIO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdCancel_Click()
gQUIT = 1
Unload frmFileIO
End Sub

Private Sub cmdDelete_Click()
X% = MsgBox("Are you sure you wish to delete " + txtFullFileName + " ?", 4 + 32 + 256, "Confirm File Deletion")
If X% = 6 Then
Kill txtFullFileName.Text
lstFile.Refresh
End If
End Sub

Private Sub cmdNewDir_Click()
directory$ = InputBox$("Enter name (max 8 char) for new directory", "Create new subdirectory", lstDirectory.Path)
If directory$ <> "" And directory$ <> lstDirectory.Path Then MkDir directory$
lstDirectory.Refresh
End Sub

Private Sub cmdOK_Click()
Path = frmFileIO!txtCurDirPath.Text
file = frmFileIO!txtFileName.Text
i% = InStr(file, "."): If i% > 0 Then file = Left$(file, i% - 1)
cmdOK.Visible = False
frmFileIO.Hide
End Sub

Private Sub cmdOpen_Click()
Path = frmFileIO!txtCurDirPath.Text
file = frmFileIO!txtFileName.Text
If (gDATA_TYPE = xyload Or gDATA_TYPE = imgload) And Not Exists(file) Then frmSCAN!panelInfo.Caption = "File '" + file + "' does not exist": Exit Sub
frmFileIO.Hide
If gDATA_TYPE = BROWSE Then Exit Sub

If InStr(UCase(file), "BMP") Then gDATA_TYPE = xybitmap

' if opening a file, identify its type
If gDATA_TYPE = 0 Then
Close
Open file For Input As #4
Input #4, id$
Close #4
If InStr(id$, "Image") > 0 Then gDATA_TYPE = imgload
End If

If mode = SUPERIMPOSE And gDATA_TYPE = imgload Then MsgBox ("Invalid File Format"): Exit Sub

Select Case gDATA_TYPE
Case xybitmap
 XYBitmapSave
End Select
End Sub

Private Sub cmdSave_Click()
file = txtSaveDirectory
If Right$(file, 1) <> "\" Then file = file + "\"
If InStr(txtNamePrefix, ".") Then txtNamePrefix = Left$(txtNamePrefix, InStr(txtNamePrefix, "."))
file = file + txtNamePrefix
frameSaveFile.Enabled = False
frameFiles.Enabled = True
frmFileIO.Hide
End Sub

Private Sub cmdView_Click()
frmPad.Tag = "edit:" + txtFullFileName
frmPad.Show 1
End Sub

Private Sub Form_Activate()
txtCurDirPath = lstDirectory.Path
lstFile.Refresh
txtFileName.Text = lstFile.filename
End Sub

Private Sub Form_Load()
CentreForm Me
gQUIT = 0
frameSelectedFile.Enabled = False
End Sub

Private Sub lstDirectory_Change()
lstFile.Path = lstDirectory.Path
txtCurDirPath = lstDirectory.Path
If frameSaveFile.Enabled = True Then txtSaveDirectory = lstDirectory.Path
ChDir lstDirectory.Path
txtFileName = ""
End Sub

Private Sub lstDrive_Change()
lstDirectory.Path = lstDrive.Drive
ChDrive lstDrive.Drive
End Sub

Private Sub lstFile_Click()
txtFileName = lstFile.filename
dirname$ = txtCurDirPath
If Right$(dirname$, 1) <> "\" Then dirname$ = dirname$ + "\"
frameSelectedFile.Enabled = True
txtFullFileName = dirname$ + txtFileName
txtFileDateTime = FileDateTime(txtFullFileName)
txtFileSize = Str$(FileLen(txtFullFileName)) + " bytes"
txtFileInfo = ""
txtFileInfo.Visible = True

extension$ = LCase$(Right$(txtFullFileName, 3))
Select Case extension$
Case "dat"
txtFileFormat = "SCAN XY Plot data (text format)"
Case "dax"
txtFileFormat = "SCAN XY Plot data (binary format)"
Case "img"
txtFileFormat = "SCAN Image data (text format)"
 ' Get file information
 Open txtFullFileName For Input As #1
 Input #1, head1$
 If head1$ <> "[Header]" Then
 ' Argh. Old header format
  Input #1, descript$
  Input #1, centreX, centreY, wide, high, stepsize, angle
  Close #1
 Else
  Close #1
  ' Yay. New format, readable by GetPrivateProfileString!
  imgfile$ = txtFullFileName
  centreX = Val(ReadFromIMGHeader("CentreX", imgfile$))
  centreY = Val(ReadFromIMGHeader("CentreY", imgfile$))
  wide = Val(ReadFromIMGHeader("Width", imgfile$))
  high = Val(ReadFromIMGHeader("Height", imgfile$))
  stepsize = Val(ReadFromIMGHeader("Stepsize", imgfile$))
  angle = Val(ReadFromIMGHeader("Angle", imgfile$))
  descript$ = ReadFromIMGHeader("Info", imgfile$)
 End If
 If descript$ <> "" Then fileinfo$ = descript$ + NL Else fileinfo$ = ""
 fileinfo$ = fileinfo$ + "Mirror centre:X=" + Str$(centreX) + " Y=" + Str$(centreY) + NL
 fileinfo$ = fileinfo$ + "Scan width:" + Str$(wide) + "mm  Height:" + Str$(high) + "mm" + NL
 fileinfo$ = fileinfo$ + "Step size:" + Str$(stepsize * 1000) + "um  Angle: " + Str$(angle) + " deg." + NL
 fileinfo$ = fileinfo$ + "(" + Format(wide / stepsize, "##0") + " x " + Format(high / stepsize, "##0") + " steps)"
 txtFileInfo = fileinfo$

Case "imx"
txtFileFormat = "SCAN Image data (binary format)"
Case "bmp", "ico"
txtFileFormat = "Windows Bitmap or Icon"
imgBitmap.Picture = LoadPicture(txtFullFileName)
txtFileInfo.Visible = False
Case "gif"
txtFileFormat = "Compuserve GIF format image"
Case "jpg"
txtFileFormat = "JPEG image"
Case "doc"
txtFileFormat = "WP-Win or MS-Word document"
Case "txt"
txtFileFormat = "Plain text file"
Case "wp"
txtFileFormat = "DOS WordPerfect file"
Case "exe", "com", "bat"
txtFileFormat = "Executable file"
Case ".id"
txtFileFormat = "Directory marker, do not delete"
Case Else
txtFileFormat = "Unknown format"
End Select
End Sub

Private Sub lstFileExt_Click()
' extract the file pattern from the extension list
txt$ = lstFileExt.List(lstFileExt.ListIndex)
pos% = 0: Do
pos% = pos% + 1
Loop Until Mid$(txt$, pos%, 1) = "("
Pattern$ = "": Do
pos% = pos% + 1
Pattern$ = Pattern$ + Mid$(txt$, pos%, 1)
Loop Until Mid$(txt$, pos% + 1, 1) = ")"
lstFile.Pattern = Pattern$

End Sub

Private Sub txtFileName_KeyPress(keyAscii As Integer)
If keyAscii = 13 Then cmdOK_Click
End Sub

