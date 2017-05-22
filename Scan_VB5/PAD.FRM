VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmPad 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "SCAN-Pad"
   ClientHeight    =   6555
   ClientLeft      =   810
   ClientTop       =   1740
   ClientWidth     =   9060
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
   ScaleHeight     =   6555
   ScaleWidth      =   9060
   Begin Threed.SSFrame frameView 
      Height          =   975
      Left            =   480
      TabIndex        =   7
      Top             =   150
      Width           =   7515
      _Version        =   65536
      _ExtentX        =   13256
      _ExtentY        =   1720
      _StockProps     =   14
      Caption         =   "SCAN-Pad File Viewer"
      ForeColor       =   16711680
      ShadowStyle     =   1
      Begin VB.CommandButton cmdViewOK 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "OK"
         Height          =   345
         Left            =   6300
         TabIndex        =   3
         Top             =   390
         Width           =   1005
      End
      Begin VB.Label labFileDateTime 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
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
         Left            =   1320
         TabIndex        =   5
         Top             =   600
         Width           =   5355
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Last modified:"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   60
         TabIndex        =   6
         Top             =   570
         Width           =   1245
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Viewing:"
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   90
         TabIndex        =   9
         Top             =   300
         Width           =   765
      End
      Begin VB.Label labView 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Label4"
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
         Left            =   900
         TabIndex        =   8
         Top             =   300
         Width           =   4725
      End
   End
   Begin VB.TextBox txtPad 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5175
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   1200
      Width           =   8835
   End
   Begin Threed.SSFrame frameEdit 
      Height          =   615
      Left            =   1200
      TabIndex        =   0
      Top             =   360
      Width           =   5025
      _Version        =   65536
      _ExtentX        =   8864
      _ExtentY        =   1085
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
      ShadowStyle     =   1
      Begin VB.TextBox txtFileName 
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
         Height          =   315
         Left            =   1440
         TabIndex        =   4
         Text            =   "(untitled)"
         Top             =   180
         Width           =   3105
      End
      Begin Threed.SSOption optEditFile 
         Height          =   255
         Left            =   180
         TabIndex        =   2
         Top             =   210
         Width           =   1185
         _Version        =   65536
         _ExtentX        =   2090
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Editing file:"
         Value           =   -1  'True
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open..."
         Index           =   0
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "&Import..."
         Index           =   1
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
      End
      Begin VB.Menu mnuSaveAs 
         Caption         =   "Save &As..."
      End
      Begin VB.Menu mnuSeparate 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Edit"
      Begin VB.Menu mnuCut 
         Caption         =   "&Cut"
         Shortcut        =   ^X
      End
      Begin VB.Menu mnuCopy 
         Caption         =   "C&opy"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuPaste 
         Caption         =   "&Paste"
         Shortcut        =   ^V
      End
   End
End
Attribute VB_Name = "frmPad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
   Private Declare Function SendMessage% Lib "user" (ByVal hWnd%, ByVal wMsg%, ByVal wParam%, ByVal lParam As Any)
   Dim Buffer As String
   Dim resizing As Integer
   Const EM_GETLINE = &H400 + 20
   Const EM_GETLINECOUNT = &H400 + 10
   Const MAX_CHAR_PER_LINE = 60  ' Scale this to size of text box.

Private Sub cmdViewOK_Click()
mnuexit_Click
End Sub

   Private Function fGetLine$(LineNumber As Long)
     ' This function fills the buffer with a line of text
     ' specified by LineNumber from the text-box control.

     ' The first line starts at zero.
      byteLo% = MAX_CHAR_PER_LINE And (255)  '[changed 5/15/92]
      byteHi% = Int(MAX_CHAR_PER_LINE / 256) '[changed 5/15/92]
      Buffer$ = Chr$(byteLo%) + Chr$(byteHi%) + Space$(MAX_CHAR_PER_LINE - 2)
      ' [Above line changed 5/15/92 to correct problem.]
      X% = SendMessage(txtPad.hWnd, EM_GETLINE, LineNumber, Buffer$)
      fGetLine$ = Left$(Buffer$, X%)
   End Function

   Private Function fGetLineCount&()
      ' This function will return the number of lines
      ' currently in the text-box control.
      ' Setfocus method illegal while in resize event,

      ' so use global flag to see if called from there
      ' (or use setfocus before this function call in general case).
      lcount% = SendMessage(txtPad.hWnd, EM_GETLINECOUNT, 0&, 0&)
      'aGetLineCount.caption = "GetLineCount = " + Str$(lcount%)
      fGetLineCount& = lcount%
   End Function

Private Sub FileOpen(ffile As String, Index As Integer)

Open ffile For Input As #1
txt$ = Input$(FileLen(ffile), 1)
Close

If Index = 0 Then
txtPad = txt$
txtFileName = ffile
Else
txtPad.SelText = txt$
End If

End Sub

Private Sub Form_Activate()
Dim ffile As String
frameView.Visible = False
X$ = Left$(Me.Tag, 4)
Select Case X$

Case "edit"
optEditFile.Value = True
If Len(Me.Tag) > 5 Then
' optEditFile_Click (True)
ffile = Right$(Me.Tag, Len(Me.Tag) - 5)
txtFileName = ffile
FileOpen ffile, 0
End If

Case "view"
frameEdit.Visible = False
frameView.Visible = True
ffile = Right$(Me.Tag, Len(Me.Tag) - 5)
labView = ffile
labFileDateTime = FileDateTime(ffile)
FileOpen ffile, 0
cmdViewOK.SetFocus

Case "show"
frameEdit.Visible = False
frameView.Visible = True
labView = Right$(Me.Tag, Len(Me.Tag) - 5)
labFileDateTime = ""
cmdViewOK.SetFocus
End Select
End Sub

Private Sub Form_Load()
CentreForm Me
End Sub

Private Sub mnuCopy_Click()
Clipboard.SetText txtPad.SelText
End Sub

Private Sub mnuCut_Click()
Clipboard.SetText txtPad.SelText
txtPad.SelText = ""
End Sub

Private Sub mnuexit_Click()
Unload frmPad
End Sub

Private Sub mnuOpen_Click(Index As Integer)
Dim ffile As String, dat As Integer
gDATA_TYPE = 0
frmXYDisplay!gphXY.YAxisStyle = 1
frmXYDisplay!gphXY.NumSets = 1
frmFileIO!lstFileExt.List(0) = "Known text files (*.txt; *.dat; *.img)"
frmFileIO!lstFileExt.List(1) = "All files (*.*)"
frmFileIO!lstFileExt.ListIndex = 0
'frmFileIO!lstDirectory.Path = savedirectory

mode = OPENFILE
frmFileIO.Caption = "Open SCAN-Pad file"
frmFileIO.Show 1

If gQUIT <> 1 Then
'savedirectory = frmFileIO!lstDirectory.Path
ffile = frmFileIO!lstDirectory.Path: If Right$(ffile, 1) <> "\" Then ffile = ffile + "\"
ffile = ffile + file

FileOpen ffile, Index
End If
End Sub

Private Sub mnuPaste_Click()
txtPad.SelText = Clipboard.GetText()
End Sub

Private Sub mnusave_Click()
'If txtFileName = "(untitled)" Then mnuSaveAs_Click
'Open txtFileName For Output As #1
'Print #1, txtPad.Text
'Close
End Sub

