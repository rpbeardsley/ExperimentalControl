VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmDataGrid 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Examine/Edit Data"
   ClientHeight    =   5640
   ClientLeft      =   540
   ClientTop       =   1485
   ClientWidth     =   10065
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
   ScaleHeight     =   5640
   ScaleWidth      =   10065
   Begin VB.CommandButton cmdSplit 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Split set"
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
      TabIndex        =   15
      Top             =   4320
      Width           =   1455
   End
   Begin Threed.SSPanel panelInfo 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   14
      Top             =   5385
      Width           =   10065
      _Version        =   65536
      _ExtentX        =   17754
      _ExtentY        =   450
      _StockProps     =   15
      ForeColor       =   255
      BackColor       =   14737632
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelOuter      =   0
      BevelInner      =   1
   End
   Begin VB.CheckBox chkPlot 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Set 6"
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
      Index           =   5
      Left            =   4920
      TabIndex        =   13
      Top             =   2880
      Width           =   855
   End
   Begin VB.CheckBox chkPlot 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Set 5"
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
      Index           =   4
      Left            =   4920
      TabIndex        =   12
      Top             =   2520
      Width           =   855
   End
   Begin VB.CommandButton cmdAdd 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Add new data"
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
      Left            =   7080
      TabIndex        =   11
      Top             =   4800
      Width           =   1455
   End
   Begin VB.CommandButton cmdCopy 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Copy to new set"
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
      TabIndex        =   10
      Top             =   4800
      Width           =   1455
   End
   Begin VB.CheckBox chkPlot 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Set 4"
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
      Index           =   3
      Left            =   4920
      TabIndex        =   8
      Top             =   2190
      Width           =   855
   End
   Begin VB.CheckBox chkPlot 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Set 3"
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
      Index           =   2
      Left            =   4920
      TabIndex        =   7
      Top             =   1800
      Width           =   855
   End
   Begin VB.CheckBox chkPlot 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Set 2"
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
      Index           =   1
      Left            =   4920
      TabIndex        =   6
      Top             =   1440
      Width           =   855
   End
   Begin VB.CheckBox chkPlot 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Set 1"
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
      Index           =   0
      Left            =   4920
      TabIndex        =   5
      Top             =   1080
      Width           =   855
   End
   Begin VB.TextBox txtCurSel 
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
      Height          =   285
      Left            =   4440
      TabIndex        =   4
      Text            =   "Text1"
      Top             =   120
      Width           =   1095
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
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
      Height          =   3615
      Left            =   6000
      ScaleHeight     =   3585
      ScaleWidth      =   3825
      TabIndex        =   3
      Top             =   360
      Width           =   3855
   End
   Begin VB.CommandButton cmdSave 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Save changes"
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
      Left            =   5640
      TabIndex        =   2
      Top             =   4800
      Width           =   1455
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
      Left            =   8520
      TabIndex        =   1
      Top             =   4800
      Width           =   1455
   End
   Begin MSGrid.Grid Grid1 
      Height          =   5055
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   3855
      _Version        =   65536
      _ExtentX        =   6800
      _ExtentY        =   8916
      _StockProps     =   77
      BackColor       =   -2147483643
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Rows            =   3
      FixedCols       =   0
      MouseIcon       =   "FRMDATAG.frx":0000
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "PLOT:"
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
      Left            =   4920
      TabIndex        =   9
      Top             =   840
      Width           =   855
   End
End
Attribute VB_Name = "frmDataGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub chkPlot_Click(Index As Integer)
PlotGraph
End Sub

Private Sub cmdAdd_Click()
mode = SUPERIMPOSE
frmXYDisplay!gphXY.NumSets = frmXYDisplay!gphXY.NumSets + 1
frmXYDisplay!gphXY.ThisSet = frmXYDisplay!gphXY.NumSets
gDATA_TYPE = xyload
frmFileIO!lstDirectory.Path = gDATdir
frmFileIO.Caption = "Superimpose another XY data file"
frmFileIO!lstFileExt.List(0) = "XY plot data (*.dat)"
frmFileIO!lstFileExt.List(1) = "All files (*.*)"
frmFileIO!lstFileExt.ListIndex = 0
frmFileIO.Show 1
End Sub

Private Sub cmdCancel_Click()
frmDataGrid.Hide
End Sub

Private Sub cmdCopy_Click()
CopyData
InitialiseGrid
End Sub

Private Sub cmdSplit_Click()
CopyData
InitialiseGrid

End Sub

Private Sub CopyData()
srow% = Grid1.SelStartRow
numrows% = Grid1.SelEndRow - srow%
scol% = Grid1.SelStartCol
If (scol% Mod 2) = 1 Then scol% = scol% - 1
Grid1.Cols = Grid1.Cols + 2
For currow% = 1 To numrows%
'Get data from original set
Grid1.Row = srow% + currow% - 1
Grid1.Col = scol%
xtxt$ = Grid1.Text
Grid1.Col = scol% + 1
ytxt$ = Grid1.Text

' Copy to new data set
Grid1.Row = currow%
Grid1.Col = Grid1.Cols - 2
Grid1.Text = xtxt$
Grid1.Col = Grid1.Cols - 1
Grid1.Text = ytxt$
Next currow%
End Sub

Private Sub Form_Activate()
InitialiseGrid
End Sub

Private Sub Form_Load()
CentreForm Me

End Sub

Private Sub InitialiseGrid()
Grid1.Row = 0
For i% = 0 To 5
If Grid1.Cols < (i% + 1) * 2 Then chkplot(i%).Enabled = False Else chkplot(i%).Enabled = True
Next
For i% = 0 To (Grid1.Cols - 1)
Grid1.ColWidth(i%) = 1800
Grid1.ColAlignment(i%) = 2
Next i%
For i% = 0 To (Grid1.Cols - 2) Step 2
Grid1.Col = i%
Grid1.Text = "X-data (set" & Str$((i% + 2) / 2) & ")"
Grid1.Col = i% + 1
Grid1.Text = "Y-data (set" & Str$((i% + 2) / 2) & ")"
Next i%

End Sub

Private Sub txtCurSel_KeyPress(keyAscii As Integer)
If keyAscii = 13 Then
If Grid1.Row > 0 Then
Grid1.Text = txtCurSel.Text
frmXYDisplay!gphXY.ThisPoint = Grid1.Row
Grid1.Col = 0
frmXYDisplay!gphXY.XPosData = Val(Grid1.Text)
Grid1.Col = 1
frmXYDisplay!gphXY.GraphData = Val(Grid1.Text)
frmXYDisplay!gphXY.DrawMode = 3
Picture1.Picture = frmXYDisplay!gphXY.Picture
End If
End If
End Sub

