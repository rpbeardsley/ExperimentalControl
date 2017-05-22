VERSION 5.00
Object = "{0842D103-1E19-101B-9AAF-1A1626551E7C}#1.0#0"; "GRAPH32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmXYDisplay 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "XY plot display"
   ClientHeight    =   6465
   ClientLeft      =   1350
   ClientTop       =   1530
   ClientWidth     =   10335
   FillColor       =   &H000000FF&
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
   HelpContextID   =   1
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6465
   ScaleWidth      =   10335
   Begin VB.Timer Timer3 
      Interval        =   5000
      Left            =   2040
      Top             =   0
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   480
      Top             =   0
   End
   Begin VB.Timer Timer1 
      Left            =   0
      Top             =   0
   End
   Begin Threed.SSPanel panelFileName 
      Height          =   375
      Left            =   7230
      TabIndex        =   30
      Top             =   6090
      Width           =   1815
      _Version        =   65536
      _ExtentX        =   3201
      _ExtentY        =   661
      _StockProps     =   15
      ForeColor       =   255
      BackColor       =   14737632
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   7.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   1
   End
   Begin Threed.SSFrame Frame3D2 
      Height          =   975
      Left            =   8400
      TabIndex        =   27
      Top             =   120
      Width           =   1755
      _Version        =   65536
      _ExtentX        =   3096
      _ExtentY        =   1720
      _StockProps     =   14
      Caption         =   "Current position"
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
      Alignment       =   2
      Begin VB.TextBox txtXValue 
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
         Left            =   480
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   240
         Width           =   1035
      End
      Begin VB.TextBox txtYValue 
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
         Left            =   480
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   600
         Width           =   1035
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "X="
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
         Left            =   210
         TabIndex        =   14
         Top             =   270
         Width           =   285
      End
      Begin VB.Label Label3 
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
         Left            =   210
         TabIndex        =   29
         Top             =   630
         Width           =   255
      End
   End
   Begin Threed.SSFrame Frame3D1 
      Height          =   4785
      Left            =   8400
      TabIndex        =   21
      Top             =   1200
      Width           =   1785
      _Version        =   65536
      _ExtentX        =   3149
      _ExtentY        =   8440
      _StockProps     =   14
      Caption         =   "Control Panel"
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
      Alignment       =   2
      Begin VB.CommandButton cmdStepLineScan 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "+ve step"
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
         Left            =   120
         TabIndex        =   33
         Top             =   2670
         Width           =   765
      End
      Begin VB.CommandButton cmdStepLineScan 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "-ve step"
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
         Left            =   870
         TabIndex        =   32
         Top             =   2670
         Width           =   765
      End
      Begin VB.CommandButton cmdReDraw 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Redraw Graph"
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
         Left            =   120
         TabIndex        =   12
         Tag             =   "Redraw screen (after a scale change)"
         Top             =   4470
         Width           =   1485
      End
      Begin VB.TextBox Text4 
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
         Left            =   480
         TabIndex        =   11
         Top             =   4080
         Width           =   855
      End
      Begin VB.TextBox Text3 
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
         Left            =   480
         TabIndex        =   10
         Top             =   3750
         Width           =   855
      End
      Begin VB.CommandButton cmdLessData 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Less data"
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
         Left            =   60
         TabIndex        =   7
         Tag             =   "Shell to EasyPlot to display current data set"
         Top             =   1770
         Width           =   825
      End
      Begin VB.CommandButton cmdMoreData 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "More data"
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
         Left            =   870
         TabIndex        =   8
         Tag             =   "Shell to EasyPlot to display current data set"
         Top             =   1770
         Width           =   825
      End
      Begin VB.CommandButton cmdInvert 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Invert"
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
         Left            =   60
         TabIndex        =   5
         Tag             =   "Flip the X and Y axes"
         Top             =   1470
         Width           =   825
      End
      Begin VB.CommandButton cmdClear 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Clear"
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
         Left            =   60
         TabIndex        =   9
         Top             =   2070
         Width           =   825
      End
      Begin VB.CommandButton cmdEP 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "EasyPlot"
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
         Left            =   870
         TabIndex        =   6
         Tag             =   "Shell to EasyPlot to display current data set"
         Top             =   1470
         Width           =   825
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
         Height          =   315
         Left            =   870
         TabIndex        =   0
         Tag             =   "Stop taking data, or exit form"
         Top             =   270
         Width           =   765
      End
      Begin VB.CommandButton cmdContinue 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Continue"
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
         Left            =   120
         TabIndex        =   2
         Top             =   570
         Width           =   765
      End
      Begin VB.CommandButton cmdPrint 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Print"
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
         Left            =   870
         TabIndex        =   3
         Tag             =   "Save data"
         Top             =   570
         Width           =   765
      End
      Begin VB.CommandButton cmdSave 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Save"
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
         Left            =   120
         TabIndex        =   1
         Tag             =   "Save data"
         Top             =   270
         Width           =   765
      End
      Begin VB.CommandButton cmdShowData 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Data Manager"
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
         Left            =   60
         TabIndex        =   4
         Top             =   1140
         Width           =   1635
      End
      Begin Threed.SSOption optScatter 
         Height          =   255
         Left            =   780
         TabIndex        =   23
         TabStop         =   0   'False
         Top             =   3240
         Width           =   825
         _Version        =   65536
         _ExtentX        =   1455
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Scatter"
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
      End
      Begin Threed.SSOption optLine 
         Height          =   255
         Left            =   90
         TabIndex        =   24
         Top             =   3240
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Line"
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
         Value           =   -1  'True
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Linescans:"
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
         Left            =   120
         TabIndex        =   31
         Top             =   2430
         Width           =   1005
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "MAX"
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
         Height          =   210
         Left            =   90
         TabIndex        =   19
         Top             =   4140
         Width           =   345
      End
      Begin VB.Label Label9 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "MIN"
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
         Height          =   210
         Left            =   120
         TabIndex        =   20
         Top             =   3810
         Width           =   345
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Y-scale:"
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
         Left            =   90
         TabIndex        =   22
         Top             =   3510
         Width           =   795
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Data handling:"
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
         Left            =   90
         TabIndex        =   26
         Top             =   930
         Width           =   1395
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Graph type:"
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
         Left            =   90
         TabIndex        =   25
         Top             =   3030
         Width           =   1095
      End
   End
   Begin VB.Timer TimerFree 
      Enabled         =   0   'False
      Left            =   960
      Top             =   0
   End
   Begin Threed.SSPanel PanelFree 
      Height          =   375
      Left            =   9060
      TabIndex        =   16
      Top             =   6090
      Width           =   1185
      _Version        =   65536
      _ExtentX        =   2090
      _ExtentY        =   661
      _StockProps     =   15
      Caption         =   "Free: 100%"
      ForeColor       =   255
      BackColor       =   14737632
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   7.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   1
   End
   Begin Threed.SSPanel PanelMode 
      Height          =   375
      Left            =   4320
      TabIndex        =   17
      Top             =   6090
      Width           =   2895
      _Version        =   65536
      _ExtentX        =   5106
      _ExtentY        =   661
      _StockProps     =   15
      ForeColor       =   255
      BackColor       =   14737632
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   7.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   1
   End
   Begin Threed.SSPanel panelStatus 
      Height          =   375
      Left            =   -30
      TabIndex        =   18
      Top             =   6090
      Width           =   4335
      _Version        =   65536
      _ExtentX        =   7646
      _ExtentY        =   661
      _StockProps     =   15
      Caption         =   "Displaying previously saved XY plot data"
      ForeColor       =   255
      BackColor       =   14737632
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   7.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   1
      Alignment       =   6
   End
   Begin GraphLib.Graph gphXY 
      Height          =   5805
      Left            =   60
      TabIndex        =   15
      Top             =   90
      Width           =   8205
      _Version        =   65536
      _ExtentX        =   14473
      _ExtentY        =   10239
      _StockProps     =   96
      BorderStyle     =   1
      AutoInc         =   0
      Background      =   0
      DrawMode        =   3
      Foreground      =   10
      GraphType       =   6
      GridStyle       =   3
      NumPoints       =   2
      RandomData      =   1
      ThickLines      =   0
      YAxisMax        =   30
      YAxisStyle      =   1
      YAxisTicks      =   10
      ColorData       =   1
      ColorData[0]    =   15
      ExtraData       =   0
      ExtraData[]     =   0
      FontFamily      =   4
      FontFamily[0]   =   1
      FontFamily[1]   =   1
      FontFamily[2]   =   1
      FontFamily[3]   =   1
      FontSize        =   4
      FontSize[0]     =   120
      FontSize[1]     =   125
      FontSize[2]     =   85
      FontSize[3]     =   125
      FontStyle       =   4
      FontStyle[0]    =   6
      GraphData       =   0
      GraphData[]     =   0
      LabelText       =   0
      LegendText      =   0
      PatternData     =   0
      SymbolData      =   1
      XPosData        =   0
      XPosData[]      =   0
   End
End
Attribute VB_Name = "frmXYDisplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
    Dim inter& ' interval in milliseconds for timer
    Dim olddata As Single ' previous x (time) data in timed mode
    Dim xdat As Single, ydat As Single ' data read in from IEEE devices
    Dim xtarget As Single, deltaX As Single, dirn% ' reqd for DeltaX mode
    Dim x_ok, y_ok ' flags determining whether
                   ' x, y devices present

Private Sub cmdCancel_Click()
If gSTOP = 0 Then
gphXY.DrawMode = 3
gSTOP = 1
cmdShowData.Enabled = True
cmdClear.Enabled = True
cmdContinue.Enabled = True
cmdInvert.Enabled = True
cmdReDraw.Enabled = True

cmdEP.Enabled = True
Text3.Enabled = True
Text4.Enabled = True
cmdSave.Enabled = True
panelStatus.Caption = "Data input stopped."
cmdCancel.Caption = "Cancel"
Else
gSTOP = 2
Close #1
SetGate 0
frmXYDisplay.Hide
End If
End Sub

Private Sub cmdClear_Click()
gphXY.DataReset = 1
gphXY.DataReset = 8
gphXY.NumPoints = 2
gphXY.NumSets = 1
gphXY.DrawMode = 3
End Sub

Private Sub cmdContinue_Click()
gSTOP = 0
End Sub

Private Sub cmdEP_Click()
 Dim file1 As String
 file1 = frmUserConfig!txtDATdir(0)
 If Right$(file1, 1) <> "\" Then file1 = file1 + "\"
 file1 = file1 + "temp.dat"
 Open file1 For Output As #4
 For h% = 1 To gphXY.NumSets
 
 Print #4, "/sa m " + Str$(h%) + " 2"
 Print #4, "/td " + Chr$(34) + "xy" + Chr$(34)
 
 'For i% = 1 To gNumPts(h%)
 For i% = 1 To gphXY.NumPoints
 gphXY.ThisSet = h%
 gphXY.ThisPoint = i%
 Print #4, gphXY.XPosData, gphXY.GraphData
 Next i%
 Print #4, "//nc"
 Next h%
 Close #4
cm$ = gEPloc + " " + file1
MsgBox (cm$)
X% = Shell(cm$, 3)
End Sub

Private Sub cmdInvert_Click()
For h% = 1 To gphXY.NumSets
For i% = 1 To gphXY.NumPoints
gphXY.ThisSet = h%
gphXY.ThisPoint = i%
yposn = gphXY.XPosData
xposn = gphXY.GraphData
gphXY.XPosData = xposn
gphXY.GraphData = yposn
Next
Next
gphXY.DrawMode = 3
End Sub

Private Sub cmdLessData_Click()
If frmXYsetup!optTimed.Value = True Then
 newint& = frmXYDisplay!Timer1.Interval * 2
 frmXYsetup!txtTimeInterval.Text = Str$(newint& / 1000)
 frmXYDisplay!Timer1.Interval = newint&
 PanelMode.Caption = "Timed mode (" & Format$(frmXYsetup!txtTimeInterval.Text, "0.0##") & " sec)"
End If

If frmXYsetup!OptDeltaX.Value = True Then
 del = Val(frmXYsetup!txtDeltaX.Text)
 frmXYsetup!txtDeltaX.Text = Str$(del * 2)
 PanelMode.Caption = "Delta-X mode (step=" & frmXYsetup!txtDeltaX.Text & ")"
End If
End Sub

Private Sub cmdMoreData_Click()
' timed mode
If frmXYsetup!optTimed.Value = True And Timer1.Interval > 490 Then
 newint& = Timer1.Interval / 2
 frmXYsetup!txtTimeInterval.Text = Str$(newint& / 1000)
 Timer1.Interval = newint&
 PanelMode.Caption = "Timed mode (" & Format$(frmXYsetup!txtTimeInterval.Text, "0.0##") & " sec)"
End If

' delta-X mode
If frmXYsetup!OptDeltaX.Value = True Then
 del = Val(frmXYsetup!txtDeltaX.Text)
 frmXYsetup!txtDeltaX.Text = Str$(del / 2)
 PanelMode.Caption = "Delta-X mode (step=" & frmXYsetup!txtDeltaX.Text & ")"
End If
End Sub

Private Sub cmdPrint_Click()
gphXY.PrintStyle = 1
gphXY.DrawMode = 5
End Sub

Private Sub cmdReDraw_Click()
gphXY.DrawMode = 3
End Sub

Private Sub cmdSave_Click()
gDATA_TYPE = xysave
frmFileIO.Caption = "Save XY plot data"

savedirectory = CheckPresent(gDATdir)
ChDir savedirectory
frmFileIO!lstDirectory.Path = savedirectory
frmFileIO!frameSaveFile.Enabled = True
frmFileIO!frameFiles.Enabled = False
frmFileIO!frameSelectedFile.Enabled = False
frmFileIO!txtSaveDirectory = savedirectory
frmFileIO.Show 1
If gQUIT <> 1 Then
datasavefile = file + ".dat"
savedirectory = frmFileIO!lstDirectory.Path
XYsetupsave
End If
End Sub

Private Sub cmdShowData_Click()
If mode = TAKEDATA Then
 frmDataGrid!Grid1.Row = 0
 For n% = 1 To gpointnum
 gphXY.ThisPoint = n%
 If frmDataGrid!Grid1.Row + 1 = frmDataGrid!Grid1.Rows Then frmDataGrid!Grid1.Rows = frmDataGrid!Grid1.Rows + 1
 frmDataGrid!Grid1.Row = frmDataGrid!Grid1.Row + 1
 frmDataGrid!Grid1.Col = 0
 frmDataGrid!Grid1.Text = gphXY.XPosData
 frmDataGrid!Grid1.Col = 1
 frmDataGrid!Grid1.Text = gphXY.GraphData
 Next
 frmDataGrid!Picture1.Picture = gphXY.Picture
End If
frmDataGrid.Show 1
End Sub

Private Sub cmdStepLineScan_Click(Index As Integer)
If wide = stepsize Or high = stepsize Then Exit Sub
linescanrowcol% = linescanrowcol% - (Index = 0) + (Index = 1)

If ax$ = "X" Then dirn = 1 Else dirn = 0
If dirn = 1 And linescanrowcol% > maxy% Then linescanrowcol% = maxy%
If dirn = 0 And linescanrowcol% > maxx% Then linescanrowcol% = maxx%
If linescanrowcol% < 0 Then linescanrowcol% = 0
PutLineScanDataOnGraph dirn
End Sub

Private Function DisplayFormat(number) As String
If number = 0 Then number = 1
power_of_ten = Log(Abs(number)) / Log(10#)
If power_of_ten > 0 Then figs_before_point = power_of_ten + 1 Else figs_before_point = 1
DisplayFormat = String(figs_before_point - 1, "#") + "0.0" + String(4 - figs_before_point, "#")
If power_of_ten < -3 Then DisplayFormat = "0.0###E+##"
End Function

Private Sub Form_Activate()
ShowFree
'MsgBox ("hello2")
If mode = TAKEDATA Then mode = -2: PerformExperiment
End Sub

Private Sub Form_Load()
' Centre the form
CentreForm Me
Text3.Text = "Auto"
Text4.Text = "Auto"
TimerFree.Interval = 20000
TimerFree.Enabled = True

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
' ensure that no more readings are being taken
gSTOP = 1
End Sub

Private Sub optLine_Click(Value As Integer)
If gphXY.GraphType <> 6 Then
 gphXY.GraphType = 6
 gphXY.DrawMode = 3
End If
End Sub

Private Sub optScatter_Click(Value As Integer)
If gphXY.GraphType <> 9 Then
 gphXY.GraphType = 9
 gphXY.DrawMode = 3
End If
End Sub

Private Sub PerformExperiment()
Dim autosavefile As String
frmDataGrid!chkplot(0).Value = 1
frmXYDisplay.Caption = "XY Plot: " & frmXYsetup!Ydevlist.Text & " as a function of " & frmXYsetup!Xdevlist.Text & "."

Timer1.Enabled = False

gSTOP = 0
datasaved = datasaved And 254
If optLine.Value = True Then gphXY.GraphType = 6 Else gphXY.GraphType = 9
gphXY.AutoInc = 0
gphXY.NumPoints = 2

datatmpfile = "c:\tmp\temp.dat": datasavefile = datatmpfile
If gAUTOSAVE = True Then
autosavefile = GetFileName(True, gDATdir, ".dat")
datasavefile = autosavefile
End If
panelFileName.Caption = datasavefile + " (unsaved)"

Close
'MsgBox (Str(ydev))
'If ydev = ieeeaddr(bxcr) Then SendIEEEdata ("I1")
'MsgBox ("hello3")
Open datatmpfile For Output As #1
gpointnum = 0

If frmXYsetup!Xdevlist.Text = "Voltage sweep" Then
'MsgBox ("hello4")
xdat = Val(frmdvs!text1.Text)
xdev = ieeeaddr(dvs)
dvsset
' configure boxcar analogue port 8 for output
SetGate (xdat)
t = Timer
While Timer < t + 1
Wend
End If

Do
panelStatus.Caption = "Reading XY plot data, press STOP to end."
ShowControls False
If frmXYsetup!optTimed.Value = True Then Timer1.Enabled = True
If frmXYsetup!OptDeltaX.Value = True Then
 Timer2.Enabled = True
Else
 Timer3.Enabled = True
End If
Do
If frmXYsetup!Xdevlist.Text = "B-field sweep" And xdat >= Val(frmFieldSweep!txtFieldEnd) Then gSTOP = 1: ShowControls True: cmdContinue.Enabled = False
If frmXYsetup!Xdevlist.Text = "Voltage sweep" Then
 If (Val(frmdvs!text1.Text) > Val(frmdvs!Text2.Text) And xdat < (Val(frmdvs!Text2.Text)) - Val(Text3.Text)) Then gSTOP = 1: ShowControls True: cmdContinue.Enabled = False
 If (Val(frmdvs!Text2.Text) > Val(frmdvs!text1.Text)) And xdat > (Val(frmdvs!Text2.Text) + (Val(frmdvs!Text3.Text))) Then gSTOP = 1: ShowControls True: cmdContinue.Enabled = False
End If
DoEvents
Loop Until gSTOP > 0
gNumPts(gphXY.NumSets) = gpointnum
Timer1.Enabled = False
Timer2.Enabled = False
Timer3.Enabled = False
Do: DoEvents: Loop Until gSTOP <> 1
Loop Until gSTOP = 2
Close #1
If gAUTOSAVE = True Then
panelFileName.Caption = autosavefile + " (saved)"
FileCopy datatmpfile, autosavefile
datasaved = datasaved Or 1
cmdSave.Enabled = False
End If
End Sub

Private Sub PlotXData()
gphXY.XPosData = xdat
End Sub

Private Sub PlotYData()
gphXY.GraphData = ydat
End Sub

Private Function Pressure(dat)
Pressure = 1.006 * 101325 * (dat - 0.00085) / 0.1438
End Function

Private Function ReadXData() As Boolean
' Read from x-device
SendIEEECmd (Str$(xdev))
If xdev = ieeeaddr(bxcr) Then
 SweepField
Else
 
 If xdev = ieeeaddr(dmm1) Then
 SendIEEEdata ("READ?")
 End If
 If xdev = ieeeaddr(dmm2) Then
 SendIEEEdata ("READ?")
 End If
 xda$ = recvIEEEdata(255)
 xdat = Val(xda$)

 If frmXYsetup!cmbDVMx.ListIndex = 2 And xdat > 0 Then xdat = Temperature(Pressure(xdat))
 If frmXYsetup!cmbDVMx.ListIndex = 1 And xdat > 0 Then xdat = Pressure(xdat)
 If frmXYsetup!cmbDVMx.ListIndex = 3 And xdat > 0 Then xdat = xdat * 46.73
End If
copyxdat = xdat
txtXValue.Text = Format$(copyxdat, DisplayFormat(copyxdat))
End Function

Private Function ReadYData() As Boolean
' Read from y-device

Dim inbuf As String

SendIEEECmd (Str(ydev))

If ydev = ieeeaddr(lckn) Then
'Stop
SendIEEEdata ("OUTR? 1")
End If


If ydev = ieeeaddr(dmm1) Then

'SendIEEECmd (Str$(ydev))
SendIEEEdata ("READ?")
End If

If ydev = ieeeaddr(dmm2) Then
'Stop
SendIEEEdata ("READ?")
End If


If ydev = ieeeaddr(lckn) Then

    inbuf = recvIEEERawData(255)

    'Scan through the 255 char buffer and
    'separate mantissa from exponent
    m1 = -1
    m2 = -1
    For a = 1 To 20
        If Mid(inbuf, a, 1) = "e" Then m1 = a
        If Mid(inbuf, a, 1) = vbLf Then m2 = a: GoTo fin
    Next a
fin:
    If (m1 > -1 And m2 > -1) Then
        mantissa = Val(Mid(inbuf, 1, (m1 - 1)))
        exponent = Val(Mid(inbuf, (m1 + 1), (m2 - (m1 + 1))))
        ydat = mantissa * (10 ^ exponent)
    ElseIf (m1 = -1 And m2 > -1) Then
        ydat = Val(Mid(inbuf, 1, (m2 - 1)))
    ElseIf (m2 = -1) Then
        ReadYData = False: GoTo ext
    End If
    
    ReadYData = True

Else

    yda$ = recvIEEEdata(255)
    ydat = Val(yda$)

End If

If frmXYsetup!cmbDVMy.ListIndex = 2 And ydat > 0 Then ydat = Temperature(Pressure(ydat))
If frmXYsetup!cmbDVMy.ListIndex = 1 And ydat > 0 Then ydat = Pressure(ydat)
If frmXYsetup!cmbDVMy.ListIndex = 3 And ydat > 0 Then ydat = ydat * 46.73
copyydat = ydat
frmXYDisplay!txtYValue.Text = Format$(copyydat, DisplayFormat(copyydat))

ext:

End Function

Sub ShowControls(bool As Integer)
cmdShowData.Enabled = bool
cmdClear.Enabled = bool
cmdInvert.Enabled = bool
cmdReDraw.Enabled = bool
cmdEP.Enabled = bool
Text3.Enabled = bool
Text4.Enabled = bool
cmdSave.Enabled = bool
cmdContinue.Enabled = bool
cmdPrint.Enabled = bool
If bool = False Then
cmdCancel.Caption = "STOP"
Else
cmdCancel.Caption = "Cancel"
End If
End Sub

Private Sub ShowFree()
' have two limitations on memory:
' (1) 3800 total points on graph (GRAPH.VBX limit)
' (2) 2000 total in one data set (GRID.VBX limit)
free1% = 100 - ((gphXY.NumSets * gphXY.NumPoints) / 60)
free2% = 100 - (gphXY.NumPoints / 20)
If free1% < free2% Then free% = free1% Else free% = free2%
PanelFree.Caption = "Free:" & Str$(free%) & "%"

If free% < 5 And gSTOP = 0 Then
 ' take course of action to free up memory
 ' "crunch" the graph by half
gSTOP = 1
For pnt% = 2 To gphXY.NumPoints Step 2
' read the old graph values for given point number
 gphXY.ThisPoint = pnt%
 xdat = gphXY.XPosData
 ydat = gphXY.GraphData
' reallocate those values to new point numbers
 gphXY.ThisPoint = Int(pnt% / 2)
 gphXY.XPosData = xdat
 gphXY.GraphData = ydat
Next
gphXY.NumPoints = Int(gphXY.NumPoints / 2)
gpointnum = gphXY.NumPoints
ShowFree
cmdLessData_Click
gphXY.DrawMode = 3
gSTOP = 0
End If
End Sub

Private Sub SweepField()
xdat = xdat + Val(frmFieldSweep!txtFieldStep) / 1000
psu_voltage = xdat / 46.73
SetGate psu_voltage
'Pause Val(frmFieldSweep!txtStepDelay)
End Sub

Private Function Temperature(P As Single)
Dim E As Single, F As Single, tmp As Single, tmp2 As Single
D0 = 1.392408: D1 = 0.527153: D2 = 0.166756: D3 = 0.050988
D4 = 0.026514: D5 = 0.001975: D6 = -0.017976: D7 = 0.005409
D8 = 0.013259: D9 = 0: A0 = 3.146631: A1 = 1.357655
A2 = 0.413923: A3 = 0.091159: A4 = 0.016349: A5 = 0.001826
A6 = -0.004325: A7 = -0.004973: A8 = 0: A9 = 0
G = 5.6: z = 2.9: B = 10.3: c = 1.9

E = ((Log(P) - B) / c)
F = ((Log(P) - G) / z)

tmp = (A0 * E + A1 * E ^ 2 + A2 * E ^ 3 + A3 * E ^ 4 + A4 * E ^ 5 + A5 * E ^ 6 + A6 * E ^ 7 + A7 * E ^ 8 + A8 * E ^ 9 + A9 * E ^ 10) / E
tmp2 = (D0 * F + D1 * F ^ 2 + D2 * F ^ 3 + D3 * F ^ 4 + D4 * F ^ 5 + D5 * F ^ 6 + D6 * F ^ 7 + D7 * F ^ 8 + D8 * F ^ 9 + D9 * F ^ 10) / F
If tmp < 2.1769 Then
 Temperature = tmp2
Else
 Temperature = tmp
End If
End Function

Private Sub Text3_Change()
If UCase(Text3.Text) = "AUTO" Then
 Text3.Text = "Auto": Text4.Text = "Auto"
 gphXY.YAxisStyle = 1
Else
 gphXY.YAxisStyle = 2
 gphXY.YAxisMin = Val(Text3.Text)
If UCase(Text4.Text) = "AUTO" Then Text4.Text = "0"
End If
End Sub

Private Sub Text4_Change()
If UCase(Text4.Text) = "AUTO" Then
 Text3.Text = "Auto": Text4.Text = "Auto"
 gphXY.YAxisStyle = 1
Else
gphXY.YAxisStyle = 2
gphXY.YAxisMax = Val(Text4.Text)
If UCase(Text3.Text) = "AUTO" Then Text3.Text = "0"
End If
End Sub

Private Sub Timer1_Timer()
If gpointnum >= gphXY.NumPoints Then gphXY.NumPoints = gpointnum + 1
oldxdata = gphXY.XPosData
gpointnum = gpointnum + 1
gphXY.ThisPoint = gpointnum

Select Case xdev
Case 0
' time sweep; get new time
 xdat = oldxdata + Val(frmXYsetup!txtTimeInterval)
 If gpointnum = 0 Then xdat = 0
 gphXY.XPosData = xdat
 txtXValue.Text = Str$(xdat)
'MsgBox ("hello5")
PlotXData
ReadYData

Case ieeeaddr(dvs)
' dvs sweep
' divisor = Val(frmBoxCar!txtDivisor)
 txtXValue.Text = Str$(xdat)
 PlotXData
 ReadYData

 dvsstep = Val(frmdvs!Text3.Text)
 If Val(frmdvs!Text2.Text) < Val(frmdvs!text1.Text) Then
  ' negative going sweep
  dvsstep = -dvsstep
 End If
 xdat = xdat + dvsstep
 SetGate xdat




Case Else
ReadXData
ReadYData

PlotXData

End Select

PlotYData
WriteData

End Sub

Private Sub Timer2_Timer()

ReadXData
If xtarget = -9000000000# Then xtarget = xdat
If (xdat - xtarget) * dirn% >= 0 Then
 ReadYData
 xtarget = xtarget + (deltaX * dirn%)

 If gpointnum >= gphXY.NumPoints Then gphXY.NumPoints = gpointnum + 1
 gpointnum = gpointnum + 1
 gphXY.ThisPoint = gpointnum

 PlotXData
 PlotYData
 WriteData

 gphXY.DrawMode = 3
 panelStatus.Caption = "Waiting for X to reach " & Format(xtarget, "###0.0###") & " (STOP to end)"
End If
End Sub

Private Sub Timer3_Timer()
gphXY.DrawMode = 3
End Sub

Private Sub TimerFree_Timer()
ShowFree
End Sub

Private Sub WriteData()
Print #1, xdat, ydat
End Sub

