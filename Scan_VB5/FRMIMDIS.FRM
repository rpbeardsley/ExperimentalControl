VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmImageDisplay 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00C0C0C0&
   Caption         =   "Image Scan Display"
   ClientHeight    =   6750
   ClientLeft      =   60
   ClientTop       =   1740
   ClientWidth     =   11385
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
   HelpContextID   =   330
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6750
   ScaleWidth      =   11385
   Begin VB.TextBox TempRead 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   6840
      TabIndex        =   59
      Text            =   "Text1"
      Top             =   6240
      Width           =   1095
   End
   Begin Threed.SSFrame Frame3D2 
      Height          =   825
      Left            =   8190
      TabIndex        =   53
      Top             =   5850
      Width           =   2685
      _Version        =   65536
      _ExtentX        =   4736
      _ExtentY        =   1455
      _StockProps     =   14
      Caption         =   "Allen-Bradley resistance"
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
      Begin Threed.SSFrame Frame3D5 
         Height          =   495
         Left            =   1110
         TabIndex        =   55
         Top             =   240
         Width           =   1455
         _Version        =   65536
         _ExtentX        =   2566
         _ExtentY        =   873
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
         Begin VB.PictureBox picLCD 
            Appearance      =   0  'Flat
            BackColor       =   &H00000000&
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
            Height          =   345
            Left            =   60
            ScaleHeight     =   315
            ScaleWidth      =   1305
            TabIndex        =   56
            Top             =   120
            Width           =   1335
         End
      End
      Begin VB.ComboBox AllenDevice 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   54
         Top             =   360
         Width           =   915
      End
   End
   Begin VB.TextBox gatebox 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   6840
      TabIndex        =   50
      Top             =   5640
      Width           =   1095
   End
   Begin Threed.SSFrame Frame3D4 
      Height          =   2565
      Left            =   8130
      TabIndex        =   35
      Top             =   60
      Width           =   3195
      _Version        =   65536
      _ExtentX        =   5636
      _ExtentY        =   4524
      _StockProps     =   14
      Caption         =   "Image scan parameters"
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
      Begin VB.Label labSave 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "(unsaved)"
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
         Left            =   1020
         TabIndex        =   40
         Top             =   2280
         Width           =   735
      End
      Begin VB.Label labIntensity 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         Left            =   1050
         TabIndex        =   39
         Top             =   720
         Width           =   1695
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Intensity:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   270
         TabIndex        =   38
         Top             =   720
         Width           =   735
      End
      Begin VB.Label labFileName 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "temp.img"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   1080
         TabIndex        =   19
         Top             =   2040
         Width           =   1095
      End
      Begin VB.Label labMagnetPSU 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   1080
         TabIndex        =   20
         Top             =   1830
         Width           =   795
      End
      Begin VB.Label Label21 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Magnet PSU:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   90
         TabIndex        =   25
         Top             =   1830
         Width           =   945
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Filename:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   360
         TabIndex        =   36
         Top             =   2040
         Width           =   675
      End
      Begin VB.Label labAngle 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         Left            =   1080
         TabIndex        =   16
         Top             =   1620
         Width           =   765
      End
      Begin VB.Label Label20 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Angle:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   510
         TabIndex        =   17
         Top             =   1620
         Width           =   495
      End
      Begin VB.Label Label22 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Step size:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   270
         TabIndex        =   26
         Top             =   1410
         Width           =   735
      End
      Begin VB.Label labStepSize 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         Left            =   1050
         TabIndex        =   27
         Top             =   1410
         Width           =   735
      End
      Begin VB.Label labHeight 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         Height          =   225
         Left            =   1020
         TabIndex        =   28
         Top             =   1170
         Width           =   765
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Centre:"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   480
         TabIndex        =   29
         Top             =   240
         Width           =   525
      End
      Begin VB.Label Label17 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Offset:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   480
         TabIndex        =   30
         Top             =   480
         Width           =   525
      End
      Begin VB.Label labScanCentre 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         Left            =   1020
         TabIndex        =   31
         Top             =   240
         Width           =   1845
      End
      Begin VB.Label labScanOffset 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
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
         Left            =   1020
         TabIndex        =   32
         Top             =   480
         Width           =   1845
      End
      Begin VB.Label Label18 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Scan width:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   120
         TabIndex        =   33
         Top             =   960
         Width           =   885
      End
      Begin VB.Label Label19 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Scan height:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   90
         TabIndex        =   34
         Top             =   1170
         Width           =   915
      End
      Begin VB.Label labWidth 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
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
         Height          =   225
         Left            =   1020
         TabIndex        =   18
         Top             =   960
         Width           =   675
      End
   End
   Begin Threed.SSFrame framePrint 
      Height          =   1155
      Left            =   840
      TabIndex        =   21
      Top             =   2700
      Visible         =   0   'False
      Width           =   3945
      _Version        =   65536
      _ExtentX        =   6959
      _ExtentY        =   2037
      _StockProps     =   14
      Caption         =   "Print selection"
      ForeColor       =   16711680
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
      Begin VB.CommandButton cmdPrintOK 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "OK"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2910
         TabIndex        =   24
         Top             =   630
         Width           =   765
      End
      Begin VB.ComboBox cmbPrint 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   180
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   630
         Width           =   2445
      End
      Begin VB.Label Label9 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Print:"
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
         Height          =   255
         Left            =   180
         TabIndex        =   23
         Top             =   360
         Width           =   1605
      End
   End
   Begin Threed.SSFrame Frame3D3 
      Height          =   3075
      Left            =   8130
      TabIndex        =   11
      Top             =   2670
      Width           =   3195
      _Version        =   65536
      _ExtentX        =   5636
      _ExtentY        =   5424
      _StockProps     =   14
      Caption         =   "Scanning controls"
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
      Begin VB.CommandButton cmdPauseScan 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Pause scan"
         Enabled         =   0   'False
         Height          =   285
         Left            =   2040
         TabIndex        =   52
         Top             =   810
         Width           =   1035
      End
      Begin VB.CommandButton cmdRescale 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Rescale"
         Height          =   405
         Left            =   1920
         TabIndex        =   10
         Top             =   2580
         Width           =   1035
      End
      Begin VB.TextBox txtMagnify 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   1170
         TabIndex        =   45
         Top             =   3450
         Width           =   885
      End
      Begin VB.CommandButton cmdLineScan 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Linescan along X"
         Enabled         =   0   'False
         Height          =   375
         Index           =   0
         Left            =   90
         TabIndex        =   44
         Top             =   1500
         Width           =   1395
      End
      Begin VB.CommandButton cmdLineScan 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Linescan along Y"
         Enabled         =   0   'False
         Height          =   375
         Index           =   1
         Left            =   1560
         TabIndex        =   43
         Top             =   1500
         Width           =   1395
      End
      Begin VB.CommandButton cmdSCAN 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "SCAN"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   90
         TabIndex        =   1
         Top             =   300
         Width           =   1065
      End
      Begin Threed.SSCheck improvement 
         Height          =   225
         Left            =   90
         TabIndex        =   42
         Top             =   840
         Width           =   1815
         _Version        =   65536
         _ExtentX        =   3201
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Gradual improvement"
         Alignment       =   1
         Value           =   -1  'True
         Font3D          =   3
      End
      Begin Threed.SSCheck chkAutoRescale 
         Height          =   225
         Left            =   540
         TabIndex        =   12
         Top             =   2730
         Width           =   1275
         _Version        =   65536
         _ExtentX        =   2249
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Auto rescale"
         Alignment       =   1
         Value           =   -1  'True
         Font3D          =   3
      End
      Begin Spin.SpinButton Spin1 
         Height          =   315
         Left            =   2010
         TabIndex        =   57
         Top             =   3510
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin VB.Line Line3 
         X1              =   120
         X2              =   3060
         Y1              =   3300
         Y2              =   3300
      End
      Begin VB.Line Line2 
         X1              =   120
         X2              =   3060
         Y1              =   1950
         Y2              =   1950
      End
      Begin VB.Line Line1 
         X1              =   90
         X2              =   3060
         Y1              =   1170
         Y2              =   1170
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Zoom level:"
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
         Left            =   150
         TabIndex        =   13
         Top             =   3510
         Width           =   1035
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Colour rescaling"
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
         TabIndex        =   14
         Top             =   2040
         Width           =   1395
      End
      Begin VB.Label labRescale 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "All intensity values are within range of scale."
         ForeColor       =   &H80000008&
         Height          =   405
         Left            =   90
         TabIndex        =   15
         Top             =   2280
         Width           =   2955
         WordWrap        =   -1  'True
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Linescans"
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
         TabIndex        =   37
         Top             =   1260
         Width           =   1185
      End
      Begin VB.Label Label15 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Time elapsed:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   1410
         TabIndex        =   49
         Top             =   270
         Width           =   1005
      End
      Begin VB.Label Label16 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Time remaining:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   1290
         TabIndex        =   48
         Top             =   480
         Width           =   1155
      End
      Begin VB.Label labTimeTaken 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   2430
         TabIndex        =   47
         Top             =   270
         Width           =   645
      End
      Begin VB.Label labTimeLeft 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   2430
         TabIndex        =   46
         Top             =   510
         Width           =   645
      End
   End
   Begin VB.Timer timeScan 
      Enabled         =   0   'False
      Interval        =   990
      Left            =   6330
      Top             =   6240
   End
   Begin Threed.SSFrame Frame3D1 
      Height          =   5235
      Left            =   6780
      TabIndex        =   9
      Top             =   90
      Width           =   1215
      _Version        =   65536
      _ExtentX        =   2143
      _ExtentY        =   9234
      _StockProps     =   14
      Caption         =   "Intensity"
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
      Begin VB.PictureBox picKey 
         Appearance      =   0  'Flat
         AutoRedraw      =   -1  'True
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
         Height          =   4455
         Left            =   90
         ScaleHeight     =   4425
         ScaleWidth      =   585
         TabIndex        =   2
         Top             =   450
         Width           =   615
      End
      Begin VB.Label lab0PerCent 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
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
         Height          =   195
         Left            =   90
         TabIndex        =   6
         Top             =   4920
         Width           =   735
      End
      Begin VB.Label lab100PerCent 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
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
         Height          =   195
         Left            =   90
         TabIndex        =   41
         Top             =   240
         Width           =   705
      End
      Begin VB.Label Label14 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "0%"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   780
         TabIndex        =   3
         Top             =   4740
         Width           =   315
      End
      Begin VB.Label Label13 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "25%"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   780
         TabIndex        =   4
         Top             =   3720
         Width           =   345
      End
      Begin VB.Label Label12 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "50%"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   780
         TabIndex        =   5
         Top             =   2550
         Width           =   375
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "75%"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   780
         TabIndex        =   7
         Top             =   1440
         Width           =   375
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "100%"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   750
         TabIndex        =   8
         Top             =   420
         Width           =   405
      End
   End
   Begin VB.PictureBox picImage 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
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
      Height          =   6585
      Left            =   120
      ScaleHeight     =   6555
      ScaleWidth      =   6555
      TabIndex        =   0
      Top             =   90
      Width           =   6585
      Begin VB.Timer BackgroundTimer 
         Interval        =   5000
         Left            =   5970
         Top             =   180
      End
   End
   Begin VB.Label Label2 
      Caption         =   "Lock-In"
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
      Left            =   6960
      TabIndex        =   58
      Top             =   6000
      Width           =   855
   End
   Begin VB.Label gatelabel 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "IntelliGATE"
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
      Left            =   6960
      TabIndex        =   51
      Top             =   5400
      Width           =   945
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open New Image"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save Current Image"
      End
      Begin VB.Menu mnuPrint 
         Caption         =   "&Print Image"
      End
      Begin VB.Menu mnuBitmap 
         Caption         =   "Create Presentation &Bitmap"
      End
      Begin VB.Menu mnuSeparate 
         Caption         =   "-"
      End
      Begin VB.Menu mnuClose 
         Caption         =   "&Close"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Edit"
      Begin VB.Menu mnuCopyToClipboard 
         Caption         =   "&Copy Image to Clipboard"
      End
      Begin VB.Menu mnuGrid 
         Caption         =   "Show &Grid"
      End
      Begin VB.Menu mnuSeparate1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuManipulate 
         Caption         =   "Image Manipulation:"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuSharpen 
         Caption         =   "Sharpen &Peaks"
         Index           =   0
      End
      Begin VB.Menu mnuSharpen 
         Caption         =   "Sharpen &Troughs"
         Index           =   1
      End
      Begin VB.Menu mnuSmooth 
         Caption         =   "&Smooth Image"
      End
      Begin VB.Menu mnuSeparate3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuResize 
         Caption         =   "Resizing/shaping:"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuZoom 
         Caption         =   "&Zoom and Rescan"
         Index           =   0
      End
      Begin VB.Menu mnuZoom 
         Caption         =   "C&rop"
         Index           =   1
      End
   End
   Begin VB.Menu mnuSetup 
      Caption         =   "&Setup"
      Begin VB.Menu mnuConfigureInstrument 
         Caption         =   "&Scan instrument"
      End
      Begin VB.Menu mnuUserConfig 
         Caption         =   "&User Configuration"
      End
      Begin VB.Menu mnuGenConfig 
         Caption         =   "&General Configuration"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
   End
End
Attribute VB_Name = "frmImageDisplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim centreX As Long, centreY As Long
Dim zoommode As Integer
Dim filenumber As Integer
Dim mmx As Single
Dim mmy As Single
Dim mmxsc As Single
Dim mmysc As Single
Dim maxint As Single
Dim minint As Single
Dim maxintensity As Single
Dim minintensity As Single
Dim intensity As Single
Dim GridX As Single
Dim GridY As Single
Dim start_time As Single
Dim fileletter As String
Dim savedir As String
Dim savefile As String
Dim halt As Integer
Dim curx%, cury%
Dim sqdone As Integer
Dim sqtotal As Integer
Dim IX As Single
Dim IY As Single
Dim vgain As Integer
Dim timeconst As Integer
Dim newtimeconst As Single
Dim newvgain As Single
Dim fcsfactor As Single
Private Sub AllenDevice_Change()
BackgroundTimer_Timer
End Sub

Private Sub BackgroundTimer_Timer()
Dim i As Single

If AllenDevice.ListIndex < 2 Then

dev% = dmm1
If AllenDevice.ListIndex = 1 Then dev% = dmm2

SendIEEECmd (Str$(ieeeaddr(dev%)))
i = Val(recvIEEEdata(20))

displayLCD Format$(i, "##0.0"), picLCD, &HFF
End If

End Sub

Private Sub chkAutoRescale_Click(Value As Integer)
frmImageSetup!optAutoRescale.Value = chkAutoRescale.Value
End Sub

Private Sub cmdEditDescription_Click()
X$ = Left$(InputBox$("Enter short scan description", "Edit description"), 60)
If Len(X$) > 0 Then
If Mid$(imagetmpfile, 2, 1) <> ":" Then imagetmpfile = savedirectory + "/" + imagetmpfile
WriteIMGHeader "Info", X$, imagetmpfile
txtDescription = X$
End If
End Sub

Private Sub cmdLineScan_Click(Index As Integer)
If img.scanwidth = img.scanstepsize And Index = 1 Then linescanrowcol% = 0: PutLineScanDataOnGraph 1: frmXYDisplay.Show 1: Exit Sub
If img.scanheight = img.scanstepsize And Index = 0 Then linescanrowcol% = 0: PutLineScanDataOnGraph 0: frmXYDisplay.Show 1: Exit Sub

  picImage.DrawMode = 6
  picImage.Line (-(img.scanwidth + img.scanstepsize) * 500, GridY)-((img.scanwidth + img.scanstepsize) * 500, GridY)
  picImage.Line (GridX, -(img.scanheight + img.scanstepsize) * 500)-(GridX, (img.scanheight + img.scanstepsize) * 500)
  picImage.DrawMode = 13
  cmdLineScan(0).Enabled = False: cmdLineScan(1).Enabled = False
  zoommode = 0
Close

If Index = 0 Then ofst = OffsetToArray(GridY / 1000, img.scanheight) Else ofst = OffsetToArray(GridX / 1000, img.scanwidth)
linescanrowcol% = ofst

mode = BROWSE

PutLineScanDataOnGraph Index
frmXYDisplay.Show 1
End Sub

Private Sub cmdOutline_Click()
DrawGrid
End Sub

Private Sub cmdPauseScan_Click()
      halt = 1
m$ = "Image scan halted." + Chr$(13) + Chr$(10) + Chr$(13) + Chr$(10) + "Click OK to continue, Cancel to quit scan."
         retval = MsgBox(m$, 49, "Image Scan")
If retval = 1 Then halt = 0
If retval = 2 Then halt = 2
End Sub

Private Sub cmdPrintOK_Click()
framePrint.Visible = False
End Sub

Private Sub cmdRescale_Click()
If halt = 1 Then Exit Sub
halt = 1
maxint = maxintensity: minint = minintensity
'Close #8
PlotImage ""
'Open imagetmpfile For Append As #8
labRescale.Caption = "All intensity values are within range of scale."
halt = 0
End Sub

Private Sub cmdSave_Click()
End Sub

Private Sub cmdSCAN_Click()
On Error Resume Next
cmdPauseScan.Enabled = True

Dim dis1 As Single, dis2 As Single



gatelabel.Visible = False
gatebox.Visible = False

If (frmImageSetup!cboSource.Text = "Digitiser" And whichgate = 1) Then
gatelabel.Visible = True
gatebox.Visible = True
End If

If (frmImageSetup!cboSource.Text = "Eclipse") Then
createclass
End If
'MsgBox (frmImageSetup!cboSource.Text)
If frmImageSetup!cboSource.Text = "Lock-in amplifier" Then
If Spoll(lckn) = 0 Then
MsgBox "Lock-in amplifier is not connected - cannot proceed with scan.": Exit Sub
End If
End If

'If Val(txtMagnetPSU) > 0 And Spoll(bxcr) = 0 Then MsgBox "Boxcar is not connected - cannot supply required B-field.": Exit Sub
frmSCAN!panelInfo.Caption = message$
If gAUTOSAVE = True Then imagesavefile = GetFileName(True, gDATdir, ".img"): labFileName.Caption = imagesavefile
direction_flag = frmImageSetup!cmbDirection.ListIndex
labSaved = "(unsaved)"
'mnuSave.Enabled = False
mnuPrint.Enabled = False
cmdScan.Enabled = False

picImage.Cls
If gCOLOURS <= 256 Then
picImage.Picture = LoadPicture("c:\tmp\palette.bmp")
End If
picImage.DrawWidth = 1
picImage.FillStyle = 0
picImage.DrawMode = 13

'reset the mirrors to zero positions before starting
MirrorCommand "BX", "0"
MirrorCommand "BY", "0"

' initialise parameters (intensity scale, delays)
' for chosen measurement device
Select Case frmImageSetup!cboSource.Text

Case "Lock-in amplifier"
' Interrogate current gain level of lock-in,
' to form initial intensity scale.
SendIEEECmd (Str$(ieeeaddr(lckn)))
SendIEEEdata ("sens ?")
vgain = Val(recvIEEEdata$(200))
SendIEEEdata ("OFLT ?")
timeconst = Val(recvIEEEdata$(200))
'MsgBox (Str(timeconst))
'Stop
getlevels timeconst, vgain
maxint = newvgain
'maxint = ((((vgain - 1) Mod 3) ^ 2) + 1) * 10 ^ Int(((vgain - 1) / 3) - 8)
'minint = -maxint

' Calculate required scan delay in milliseconds
' = 3 x time constant of lock-in, plus 100 ms for
' mirror settle time
'scandel = 100 + 3 * ((1 + 2 * ((timeconst - 1) Mod 2)) * 10 ^ (Int((timeconst + 1) / 2) - 1))
scandel = 100 + 3 * newtimeconst
Case "Digitiser"
' set scale to min/max possible for range..
' do we need a scan delay?

'sweeps = (2 ^ gDIG_SWEEPS) / 256
'If sweeps <> Int(sweeps) And sweeps > 1 Then sweeps = Int(sweeps + 1)

maxint = gDIG_FULLSCALE
minint = -maxint
scandel = 50
SetupDigitiser
Case "Eclipse"
scandel = 50
maxint = 500
minint = -maxint

End Select

'Stop
' Calculate mm step size
stepsize = frmImageSetup!txtStepSize.Text / 1000

' Calculate number of X and Y steps needed
NumX% = img.scanwidth / img.scanstepsize
NumY% = img.scanheight / img.scanstepsize

If NumX% = 1 Then NumX% = 0
If NumY% = 1 Then NumY% = 0
ReDim im(0 To NumX%, 0 To NumY%)

For i% = 0 To NumX%: For j% = 0 To NumY%
im(i%, j%) = 0: Next: Next

' Obtain co-ordinates of the mirror centre position
IX0 = Val(frmMirrorSetup!txtCentreX)
IY0 = Val(frmMirrorSetup!txtCentreY)

' Convert scan angle into radians
scang = 2 * 3.14159265358979 * Val(frmImageSetup!txtAngle.Text) / 360

' Send command to IEEE to make lock-in the current device
' (for now, doesn't matter if we're using digitiser, since
' its non-IEEE. If later use DMMs/boxcar, must put this
' command into a Select Case statement)
SendIEEECmd (Str$(ieeeaddr(lckn)))

' Set default max/min intensities such that they'll
' change on first data read
maxintensity = -1000000#: minintensity = 1000000#

' Set interval on timer according to reqd. scan delay
timeScan.Enabled = False
timeScan.Interval = scandel

looptimes% = 0
maxx% = 0: maxy% = 0
Do
halt = 0
start_time = Timer
sqtotal = (NumX% + 1) * (NumY% + 1)
sqdone = 0

Close
Open imagetmpfile For Output As #8
Print #8, "[Header]"
Print #8, "[Data]"
Close #8

' Output scan parameters to file (in new format)
WriteIMGHeader "CentreX", Str$(img.mirrorX), imagetmpfile
WriteIMGHeader "CentreY", Str$(img.mirrorY), imagetmpfile
WriteIMGHeader "Width", Str$(img.scanwidth), imagetmpfile
WriteIMGHeader "Height", Str$(img.scanheight), imagetmpfile
WriteIMGHeader "Stepsize", Str$(img.scanstepsize), imagetmpfile
WriteIMGHeader "Angle", Str$(img.scanangle), imagetmpfile
img.information = "": If img.information = "" Then img.information = " "
WriteIMGHeader "Info", img.information, imagetmpfile

Open imagetmpfile For Append As #8

looptimes% = looptimes% + 1
' Main scanning loop - step mirrors and
' take intensity readings
curx% = 0: cury% = 0
Do
Do

DoEvents

' Rem make sure that if we're busy rescaling,
' we're not also taking data at same time.
Do: Loop Until halt <> 1

' Calculate mirror offset positions relative
' to starting position (in mm)
mmx = ArrayToOffset(curx%, img.scanwidth)
mmy = ArrayToOffset(cury%, img.scanheight)
mmxsc = mmx
mmysc = mmy
' Calculate absolute mirror positions based on mirror offsets.
IX = IX0 + ((mmx * Cos(scang)) - (mmy * Sin(scang)))
IY = IY0 + ((mmy * Cos(scang)) + (mmx * Sin(scang)))
'MsgBox (IX0)
'MsgBox (IX)
MoveMirrors IX, IY
'MsgBox (mmy)
' Pause for a while (and do some processing) while
' waiting for mirrors to settle. This cause problems with mmx and mmy so
'using new variables after this mmxsc and mmysc
'Stop

ScanDelay
'MsgBox (mmy)
If halt = 2 Then Exit Sub
'Stop
' Get intensity from measuring device

'Read in the temperature from the lock-in
SendIEEECmd (Str$(ieeeaddr(lckn)))
SendIEEEdata ("OUTR? 1")
TempRead = 1000 * Val(recvIEEEdata$(20))

'____________________________
'New bit to plot temperature as the scan progresses

tempfile = "C:\Data\temp.dat"
Open tempfile For Output As #29
Print #29, TempRead


Select Case frmImageSetup!cboSource.Text
Case "Lock-in amplifier"
SendIEEEdata ("OUTR ? 1")
intensity = Val(recvIEEEdata$(20))

Case "Digitiser"
gQUIT = 0

If whichgate = 1 Then
    ' Intelligate calculations
     
     dis1 = Sqr((mmxsc) ^ 2 + (mmysc) ^ 2)  ' in mm
     'MsgBox (dis1)
     dis2 = Sqr(dis1 ^ 2 + ((int_WaferThickness / 1000) ^ 2)) ' in mm
     disratio = dis2 / (int_WaferThickness / 1000)
     
     disratio = int_fscfactor * (disratio - 1)
     newtime = CSng(int_PulseTime) * (1 + disratio)
     timewindow(0) = CInt(newtime) / 5 ' in ns
     timewindow(1) = timewindow(0) + int_GateWidth / 5
     gatebox = CStr(timewindow(0) * 5) & " - " & CStr(timewindow(1) * 5) & " ns"
   
   End If
AcquireOne

file = "X" + CStr(curx%) + "Y" + CStr(cury%) + ".dat"
Open file For Output As #1

For i% = 0 To rec_on_screen% - 1
timeaxis = CLng(i%) * gDIG_SAMPLEPER
voltaxis = hidata(2, i%) / screen_to_mV_ratio



Print #1, timeaxis, voltaxis
Next
Close #1
'Stop
DoEvents
'Do   sc
'Loop Until gQUIT = 1  sc
intensity = TimeIntegral(0) - TimeIntegral(1)
'intensity = 2
Case "Eclipse"
'MsgBox ("hello")
cleararray
getectrace

file = "X" + CStr(curx%) + "Y" + CStr(cury%) + ".dat"
Open file For Output As #1
For iec = 1 To Nec
Print #1, xdatec(2, iec), ydatec(2, iec)
Next iec
Close #1

gatewin
intensity = totalg - totalb
'MsgBox (intensity)
End Select

labScanOffset.Caption = "X=" + Format(mmxsc, "#0.0#") + "mm  Y=" + Format(mmysc, "#0.0#") + "mm"
labIntensity.Caption = Format(intensity, "0.000E+0") + " V"
intensity = (((looptimes% - 1) * im(curx%, cury%)) + intensity) / looptimes%
Print #8, mmxsc, mmysc, intensity
im(curx%, cury%) = intensity

If intensity > maxintensity Then maxintensity = intensity
If intensity < minintensity Then minintensity = intensity

' Plot
PlotBox ByVal curx%, ByVal cury%
If curx% > maxx% Then maxx% = curx%
If cury% > maxy% Then maxy% = cury%

' decide whether we should be increasing X or Y
' dependent on scan direction.
curx% = curx% + (direction_flag)
cury% = cury% + (direction_flag Xor 1)
Loop Until (direction_flag = 1 And curx% = NumX% + 1) Or (direction_flag = 0 And cury% = NumY% + 1)

' same again but want reverse decision, and variable
' that isn't increased goes to zero.
curx% = (curx% * (direction_flag Xor 1)) + (direction_flag Xor 1)
cury% = (cury% * direction_flag) + (direction_flag)
Loop Until (direction_flag = 0 And curx% = NumX% + 1) Or (direction_flag = 1 And cury% = NumY% + 1)
Close
' end scan loop

PlotImage "" ' rescales completed picture

Loop Until improvement.Value = False

cmdPauseScan.Enabled = False

If NumY% = 0 Then cmdLineScan(0).Enabled = True
If NumX% = 0 Then cmdLineScan(1).Enabled = True
mode = BROWSE
mnuPrint.Enabled = True
'mnuSave.Enabled = (frmUserConfig!chkAutoSave.Value = False)
If gAUTOSAVE = True Then SaveImg 1
Close #29
End Sub

Private Sub ConvertOldFormatToNew(imgfilename$)
ChDir savedirectory
Open imgfilename$ For Input As #1
 ' grab data in old format
 Input #1, head1$
 Input #1, descript$
 Input #1, centreX, centreY, wide, high, stepsize, angle
 Close #1

 convfile$ = "c:\tmp\convert.dat"
 Open convfile$ For Output As #2
 Print #2, "[Header]"
 Print #2, "[Data]"
 Close #2
 ' Write the shiny new format..
 WriteIMGHeader "CentreX", Str$(centreX), convfile$
 WriteIMGHeader "CentreY", Str$(centreY), convfile$
 WriteIMGHeader "Width", Str$(wide), convfile$
 WriteIMGHeader "Height", Str$(high), convfile$
 WriteIMGHeader "Stepsize", Str$(stepsize), convfile$
 WriteIMGHeader "Angle", Str$(angle), convfile$

' Now just need to transfer across the data...
Open imgfilename$ For Input As #1
Do: Input #1, xx$: Loop Until xx$ = "* end of header section *"
Open convfile$ For Append As #2
Do
Input #1, mmx, mmy, intensity
Print #2, mmx, mmy, intensity
Loop Until EOF(1)
Close
Kill imgfilename$
Name convfile$ As imgfilename$
End Sub

Private Sub ConvertTextImageToBinary(filename As String)
LoadImageData filename
filename = Left$(filename, Len(filename) - 1)
SaveImageAsBinary filename + "x"
End Sub

Private Sub Crop()
Open imagetmpfile For Input As #8
Open "c:\tmp\crop.img" For Output As #9
' Move past file's header information
Do
Input #8, xx$
Print #9, xx$
Loop Until xx$ = "[Data]"

Do While Not EOF(8)
Input #8, mmx, mmy, intensity
X = mmx * 1000: Y = mmy * 1000: stp = stepsize * 1000
If ((X + stp) > startx And (X - stp) < curx) And ((Y - stp) < starty And (Y + stp) > cury) Then Print #9, mmx, mmy, intensity
Loop
Close
Kill imagetmpfile
Name "c:\tmp\crop.img" As imagetmpfile
If gAUTOSAVE = True Then imagesavefile = GetFileName(False, gDATdir, ".img"): cmdSave_Click

End Sub

Private Sub DrawGrid()
picImage.DrawWidth = 1
picImage.DrawMode = 6

For X = (-wide / 2) To (wide / 2) Step stepsize
 picImage.Line (X * 1000, -high * 500)-(X * 1000, high * 500)
 Next
 For Y = (-high / 2) To (high / 2) Step stepsize
 picImage.Line (-wide * 500, Y * 1000)-(wide * 500, Y * 1000)
 Next

picImage.DrawMode = 13

End Sub

Private Sub DrawKey()
If gCOLOURS <= 256 Then
picKey.Picture = LoadPicture("c:\tmp\palette.bmp")
End If
picKey.ScaleHeight = 256
picKey.ScaleWidth = 5
picKey.DrawWidth = 3

For i% = 0 To 255
picKey.ForeColor = colour(i%)
picKey.Line (0, 255 - i%)-(5, 255 - i% + 1), , BF
Next i%

End Sub

Private Sub Form_Activate()
BackgroundTimer_Timer

If mode = OPENFILE Then
frmSCAN!panelInfo.ForeColor = &HFF: frmSCAN!panelInfo = "Opening Image scan data file, please wait a moment."
ChDir savedirectory

If LCase$(Right$(imagesavefile, 3)) = "imx" Then
' binary format
LoadImageData imagesavefile
Else

' text format
Open imagesavefile For Input As #1
labFileName = imagesavefile: labSaved = "(saved)": imagesavedir = frmFileIO!lstDirectory.Path
Input #1, head1$
If head1$ <> "[Header]" Then
' Argh. Now obsolete text format : convert
 Input #1, img.information
 Input #1, img.mirrorX, img.mirrorY, img.scanwidth, img.scanheight, img.scanstepsize, img.scanangle
 Close #1
 ConvertOldFormatToNew imagesavefile
Else
 Close #1
 ' Yay. New format, readable by GetPrivateProfileString!
 
 LoadImageData imagesavefile
End If
End If

frmImageSetup!txtWidth = Str$(img.scanwidth)
frmImageSetup!txtHeight = Str$(img.scanheight)
frmImageSetup!txtStepSize = Str$(img.scanstepsize * 1000)
frmImageSetup!txtAngle = Str$(img.scanangle)
frmMirrorSetup!txtCentreX = Str$(img.mirrorX)
frmMirrorSetup!txtCentreY = Str$(img.mirrorY)

If img.scanwidth = img.scanstepsize Then cmdLineScan(1).Enabled = True
If img.scanheight = img.scanstepsize Then cmdLineScan(0).Enabled = True

maxint = -1000000#
minint = 1000000#
Else
datasaved = datasaved And 253
mnuzoom(0).Enabled = False: mnuzoom(1).Enabled = False
txtMagnify.Text = "4 times"
zoommode = 0
halt = 1

Rem switch on magnet power supply
Rem - boxcar, analogue port 7

labMagnetPSU.Caption = frmImageSetup!txtMagnetPSU(0).Text + " volts"
Rem SendIEEECmd (Str$(ieeeaddr(bxcr)))
' Switch to asynchronous mode, configure ports
' 5-8 for o/p, write to port 7
Rem SendIEEEdata ("I4")
Rem pause 50
Rem SendIEEEdata ("S7=" + Format(Val(labMagnetPSU.Caption), "0.000"))

img.scanstepsize = Val(frmImageSetup!txtStepSize.Text) / 1000
img.scanwidth = Val(frmImageSetup!txtWidth.Text)
img.scanheight = Val(frmImageSetup!txtHeight.Text)
End If

maxint = -1000000#
minint = 1000000#

If img.scanwidth = img.scanstepsize Then
cmdLineScan(1).Enabled = True
picImage.Height = 6585: picImage.Width = 120
frmImageDisplay.Caption = "Image Scan - single line mode"
picImage.Scale (-img.scanwidth * 500, (img.scanheight + img.scanstepsize) * 500)-(img.scanwidth * 500, -(img.scanheight + img.scanstepsize) * 500)
End If

If img.scanheight = img.scanstepsize Then
cmdLineScan(0).Enabled = True
picImage.Height = 120: picImage.Width = 6585
frmImageDisplay.Caption = "Image Scan - single line mode"
picImage.Scale (-(img.scanwidth + img.scanstepsize) * 500, img.scanheight * 500)-((img.scanwidth + img.scanstepsize) * 500, -img.scanheight * 500)
End If

If (img.scanheight <> img.scanstepsize) And (img.scanwidth <> img.scanstepsize) Then
frmImageDisplay.Caption = "Image Scan"

If img.scanwidth > img.scanheight Then
 picImage.Height = 6585 * (img.scanheight / img.scanwidth)
Else
 picImage.Width = 6585 * (img.scanwidth / img.scanheight)
End If

picImage.Scale ((-(img.scanwidth + img.scanstepsize) * 500), (img.scanheight + img.scanstepsize) * 500)-((img.scanwidth + img.scanstepsize) * 500, (-(img.scanheight + img.scanstepsize) * 500))
End If

picImage.Top = 90 + (6585 - picImage.Height) / 2
picImage.Left = 120 + (6585 - picImage.Width) / 2

chkAutoRescale.Value = frmImageSetup!optAutoRescale.Value
DrawKey

labWidth.Caption = frmImageSetup!txtWidth.Text + "mm"
labHeight.Caption = frmImageSetup!txtHeight.Text + "mm"
labStepSize.Caption = frmImageSetup!txtStepSize.Text + "um"
labAngle.Caption = frmImageSetup!txtAngle.Text + " degrees"
labScanCentre.Caption = "X=" + frmMirrorSetup!txtCentreX + "   Y=" + frmMirrorSetup!txtCentreY

If mode <> OPENFILE Then
X$ = frmImageSetup!cboSource.Text
If X$ = "Digitiser" Then
    If whichgate = 0 Then X$ = X$ + " - default gate" Else X$ = X$ + " - IntelliGATE"
End If

frmImageDisplay.Caption = frmImageDisplay.Caption + " (" + X$ + ")"

End If

If mode = OPENFILE Then
PlotImage "": imagetmpfile = imagesavefile: frmSCAN!panelInfo.ForeColor = 0: frmSCAN!panelInfo = "SCAN"
If imagetmpfile = "temp.img" Then imagetmpfile = "c:\tmp\temp.img"
End If
End Sub

Private Sub Form_Load()
AllenDevice.AddItem "DVM1"
AllenDevice.AddItem "DVM2"
AllenDevice.AddItem "n/a"
AllenDevice.ListIndex = 2
configureLCD picLCD, 4

CentreForm Me
imagetmpfile = "c:\tmp\temp.img"
picImage.MousePointer = 2
cmbPrint.AddItem "Entire screen"
cmbPrint.AddItem "Main image picture only"
cmbPrint.ListIndex = 1

mnuConfigureInstrument.Caption = "&Setup " + frmImageSetup.cboSource.Text
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
halt = 2
pause 800
Close
End Sub

Private Sub LoadImageData(filename As String)

Close

Select Case Right$(filename, 3)
Case "imx"
' Binary format
 Open filename For Binary Access Write As #1


 Get #1, , img
 'info$ = img.information
 'centreX = img.mirrorX
 'centreY = img.mirrorY
 'wide = img.scanwidth
 'high = img.scanheight
 'stepsize = img.scanstepsize
 'angle = img.scanangle

 Seek #1, 129  ' move beyond header

 If img.scanwidth = img.scanstepsize Then
 maxx% = 0
 Else
 maxx% = img.scanwidth / img.scanstepsize
 End If
 
 If img.scanheight = img.scanstepsize Then
 maxy% = 0
 Else
 maxy% = high / stepsize
 End If
 
 ReDim im(0 To maxx%, 0 To maxy%)
 bytes_to_be_read = (maxx% + 1) * (maxy% + 1) * 4

 ' get file handle for API read
 dosfilehandle% = FileAttr(1, 2)
 ret% = hread(dosfilehandle%, im(0, 0), bytes_to_be_read)
 Close

Case Else
 ' text format
 Open filename For Input As #8

 img.mirrorX = Val(ReadFromIMGHeader("CentreX", filename))
 img.mirrorY = Val(ReadFromIMGHeader("CentreY", filename))
 img.scanwidth = Val(ReadFromIMGHeader("Width", filename))
 img.scanheight = Val(ReadFromIMGHeader("Height", filename))
 img.scanstepsize = Val(ReadFromIMGHeader("Stepsize", filename))
 img.scanangle = Val(ReadFromIMGHeader("Angle", filename))
 img.information = ReadFromIMGHeader("Info", filename)
 
 ' Move past file's header information
 Do
 Input #8, xx$
 Loop Until xx$ = "[Data]"
 
 If img.scanwidth = img.scanstepsize Then maxx% = 0 Else maxx% = img.scanwidth / img.scanstepsize
 If img.scanheight = img.scanstepsize Then maxy% = 0 Else maxy% = img.scanheight / img.scanstepsize
 ReDim im(0 To maxx%, 0 To maxy%)
 
 For Y = 0 To maxy%
 For X = 0 To maxx%
 Input #8, mmx, mmy, intensity
 im(X, Y) = intensity
 Next: Next
 Close

End Select
txtDescription = img.information
End Sub

Private Sub mnuBitmap_Click()
 Dim hFile As Integer
 Dim hMem As Integer, lpmem As Long
 Dim r As Integer, nval As Long, datarange As Single, pxnt As Single
 Dim nextpxnt As Single, pointer As Long
 Dim imagecol As Integer, datarow As Integer, datacol As Integer
 Dim xx As Integer, yy As Integer
 Dim lp As LOGPALETTE
 Dim i As Integer, filehandle As Integer, palentry As Integer
 Dim rgbval As String * 1, shadowDC As Integer, kill1 As Integer
 Dim hbmp_DIB As Integer, hbmp_DDB As Integer, hbmpold As Integer
 Dim hDC_DIB As Integer, hDC_DDB As Integer
 Dim bytesread As Long, bmpwidth As Integer, bmpheight As Integer
 Dim byte1 As Integer, power2wide As Integer, power2high As Integer
 Dim maxint As Single, minint As Single

 bmpwidth = maxx%: bmpheight = maxy%
 power2wide = 1 + Int(Log(bmpwidth) / Log(2)): power2high = 1 + Int(Log(bmpheight) / Log(2))
 ReDim bitmapbuffer(0 To ((2 ^ power2wide - 1) \ 2), 0 To 2 ^ power2high - 1)
 picImage.ScaleMode = 3

' find min/max values of intensity
 maxint = im(0, 0): minint = maxint
            
    For xx = 0 To bmpwidth
    For yy = 0 To bmpheight
      If im(xx, yy) > maxint Then maxint = im(xx, yy)
      If im(xx, yy) < minint Then minint = im(xx, yy)
    Next
    Next

  ' Convert data to 8 bit integers, squash into bitmaparray()
    datarange = (maxint - minint) / 255
   For datarow = 0 To 2 ^ power2high - 1
   For datacol = 0 To (2 ^ power2wide - 1) Step 2
             
   If (datacol > bmpwidth) Or (datarow > bmpheight) Then
    pxnt = 0
   Else
    pxnt = im(datacol, datarow) - minint
    pxnt = Int(pxnt / datarange)
   End If
             
   If ((datacol + 1) > bmpwidth) Or (datarow > bmpheight) Then
    nextpxnt = 0
   Else
    nextpxnt = im(datacol + 1, datarow) - minint
    nextpxnt = Int(nextpxnt / datarange)
   End If
             
       nval = nextpxnt * &H100&
       If nval > &H7FFF Then
        nval = nval - &H10000
       End If
       imagecol = datacol \ 2
       
   bitmapbuffer(imagecol, datarow) = nval + pxnt
   
         Next datacol
        Next datarow

' Device Independent BITMAP definition
BMI.bmiheader.BISIZE = 40
BMI.bmiheader.biwidth = 2 ^ power2wide
BMI.bmiheader.biheight = 2 ^ power2high
BMI.bmiheader.biplanes = 1
BMI.bmiheader.biBitCount = 8
BMI.bmiheader.bicompression = BI_RGB
BMI.bmiheader.bisizeimage = 0
BMI.bmiheader.bixpelspermeter = 0
BMI.bmiheader.biypelspermeter = 0
BMI.bmiheader.biclrused = 0
BMI.bmiheader.biclrimportant = 0

' Palette definition (256 grey scale)

lp.palversion = &H300
lp.palnumentries = 256

For palentry = 0 To 255
rgbval = Chr$(palentry)
Mid$(BMI.bmicolors, (palentry * 4) + 1) = rgbval + rgbval + rgbval + Chr$(0)
Next palentry


Dim apiwrite As Long
Dim dosfilehandle As Integer
Dim ptr As Long

' BITMAPFILEHEADER

Dim bm As Integer
Dim no_of_bytes As Long
Dim dummy1 As Integer
Dim dummy2 As Integer
Dim offset As Long

bm = 19778
no_of_bytes = 1078 + (2 ^ power2high) * (2 ^ power2wide)
dummy1 = 0
dummy2 = 0
offset = 1078

Open "c:\tmp\testpic.bmp" For Binary Access Read Write As #2

Seek #2, 1

' write WIN BITMAP HEADERINFO to file

Put #2, , bm
Put #2, , no_of_bytes
Put #2, , dummy1
Put #2, , dummy2
Put #2, , offset

' write WIN BITMAP BITMAPINFOHEADER to file

Put #2, , BMI.bmiheader.BISIZE
Put #2, , BMI.bmiheader.biwidth
Put #2, , BMI.bmiheader.biheight
Put #2, , BMI.bmiheader.biplanes
Put #2, , BMI.bmiheader.biBitCount
Put #2, , BMI.bmiheader.bicompression
Put #2, , BMI.bmiheader.bisizeimage
Put #2, , BMI.bmiheader.bixpelspermeter
Put #2, , BMI.bmiheader.biypelspermeter
Put #2, , BMI.bmiheader.biclrused
Put #2, , BMI.bmiheader.biclrimportant

' write WIN BITMAP BITMAPHEADER (palette) to file

Put #2, , BMI.bmicolors

Seek #2, 1079

' position file pointer at end of header data (1078 bytes long)

dosfilehandle% = FileAttr(2, 2)
apiwrite = hwrite(dosfilehandle%, bitmapbuffer(0, 0), (2 ^ power2high * 2 ^ power2wide))

Close #2

gDATA_TYPE = BROWSE
frmFileIO!frameSaveFile.Enabled = True
frmFileIO!frameFiles.Enabled = False
frmFileIO!chkBitmap.Value = True
frmFileIO!chkBinary.Value = False
frmFileIO!chkText.Value = False
frmFileIO!txtSaveDirectory = savedirectory
frmFileIO!frameSelectedFile.Enabled = False
frmFileIO!lstDirectory.Path = savedirectory
frmFileIO.Caption = "Save postage stamp bitmap"
frmFileIO.Show 1
If gQUIT <> 1 Then
ChDir frmFileIO!lstDirectory.Path
If InStr(file, ".") = 0 Then file = file + ".bmp"
FileCopy "c:\tmp\testpic.bmp", file
End If


End Sub

Private Sub mnuClose_Click()
Unload frmImageDisplay
End Sub

Private Sub mnuConfigureInstrument_Click()
X$ = frmImageSetup!cboSource.Text
If X$ = "Digitiser" Then frmDigSetup.Show 1
If X$ = "Lock-in amplifier" Then frmLockIn.Show 1
End Sub

Private Sub mnuCopyToClipboard_Click()
Clipboard.Clear
Clipboard.SetData picImage.Image
MsgBox ("Image copied to Clipboard, can paste into another Windows application (ctrl-V) to save or manipulate further.")

End Sub

Private Sub mnuGrid_Click()
DrawGrid
mnuGrid.CHECKED = Not (mnuGrid.CHECKED)

End Sub

Private Sub mnuHelp_Click()
txt$ = txt$ + "This screen controls the acquisition of image scans"
txt$ = txt$ + " from the experimental apparatus." + NL + NL
txt$ = txt$ + "A synopsis of the controls follows:" + NL
txt$ = txt$ + "Time controls: Continuously updated throughout the duration"
txt$ = txt$ + " of a scan, keep the user informed about time to completion." + NL + NL
txt$ = txt$ + "Perform Scan: begin taking scan. Information about current mirror coordinates is displayed in 'X' and 'Y' boxes at the top of the screen." + NL + NL
txt$ = txt$ + "Rescaling colours: Warns the user if the colour key is either being"
txt$ = txt$ + " inefficiently used (only a small fraction of the scale)"
txt$ = txt$ + " or if a data point is outside the currently set range."
txt$ = txt$ + "This information enables the user to either rescale for himself,"
txt$ = txt$ + " or pass this control over to the computer, using the 'Auto rescale' checkbox." + NL + NL
txt$ = txt$ + "Magnification control: currently unsupported. This function will allow the user"
txt$ = txt$ + " to select a region of a completed scan with the mouse, and zoom in on it with a"
txt$ = txt$ + " greater resolution." + NL + NL
txt$ = txt$ + "Overlay grid: Superimpose a grid upon the completed scan."
frmPad!txtPad = txt$
frmPad.Tag = "show:Image Scan Display Help"
frmPad.Show 1
End Sub

Private Sub mnuPrint_Click()
framePrint.Visible = True
Do: DoEvents
Loop Until framePrint.Visible = False
If cmbPrint.ListIndex = 0 Then PrintForm Else Call PrintPicBox(picImage)
End Sub

Private Sub mnusave_Click()
SaveImg 0
End Sub

Private Sub mnuSharpen_Click(Index As Integer)
Close
minintensity = 9000000000#
labFileName.Caption = "temp.img"
labSave.Caption = "(unsaved)"
Open imagetmpfile For Input As #8
Do
Input #8, xx$
Loop Until xx$ = "[Data]"

Do
Input #8, mmx, mmy, intensity
If intensity < minintensity Then minintensity = intensity
Loop Until EOF(8)
Close

If minintensity < 0 Then offset = minintensity Else offset = 0
Open imagetmpfile For Input As #8
Open "c:\tmp\sharp.img" For Output As #9

Do
Input #8, xx$
Print #9, xx$
Loop Until xx$ = "[Data]"

maxint = -9000000000#: minint = 9000000000#
Do
Input #8, mmx, mmy, intensity
intensity = intensity - offset
If Index = 0 Then intensity = intensity ^ 1.15 Else intensity = intensity ^ (1 / 1.15)
Print #9, mmx, mmy, intensity
If intensity > maxint Then maxint = intensity
If intensity < minint Then minint = intensity
Loop Until EOF(8)
Close
Kill imagetmpfile
Name "c:\tmp\sharp.img" As imagetmpfile
PlotImage imagetmpfile
If gAUTOSAVE = True Then imagesavefile = GetFileName(False, gDATdir, ".img"): cmdSave_Click
End Sub

Private Sub mnuSmooth_Click()
Close
labFileName.Caption = "temp.img"
labSave.Caption = "(unsaved)"

If imagetmpfile = imagesavefile Then FileCopy imagesavefile, "c:\tmp\temp.img"
If imagetmpfile = "" Then imagetmpfile = "c:\tmp\temp.img"
Open imagetmpfile For Input As #8
' Move past file's header information
Do
Input #8, xx$
Loop Until xx$ = "[Data]"

maxx% = 0: maxy% = 0
Do
Input #8, mmx, mmy, intensity
X% = OffsetToArray(mmx, wide)
Y% = OffsetToArray(mmy, high)
If X% > maxx% Then maxx% = X%
If Y% > maxy% Then maxy% = Y%
im(X%, Y%) = intensity
Loop Until EOF(8)
Close #8

Open imagetmpfile For Input As #8
Open "c:\tmp\smooth.img" For Output As #9
Do
Input #8, xx$
Print #9, xx$
Loop Until xx$ = "[Data]"

Do
Input #8, mmx, mmy, intensity
x1% = OffsetToArray(mmx, wide)
Y1% = OffsetToArray(mmy, high)
If x1% = 0 And (Y1% > 0 And Y1% < maxy%) Then surround = (im(0, Y1% + 1) + im(0, Y1% - 1) + im(1, Y1%) + im(1, Y1% - 1) + im(1, Y1% + 1)) * 8 / 5
If Y1% = 0 And (x1% > 0 And x1% < maxx%) Then surround = (im(x1% + 1, 0) + im(x1% - 1, 0) + im(x1%, 1) + im(x1% + 1, 1) + im(x1% - 1, 1)) * 8 / 5
If x1% = maxx% And (Y1% > 0 And Y1% < maxy%) Then surround = (im(x1%, Y1% + 1) + im(x1%, Y% - 1) + im(x1% - 1, Y1%) + im(x1% - 1, Y1% - 1) + im(x1% - 1, Y1% + 1)) * 8 / 5
If Y1% = maxy% And (x1% > 0 And x1% < maxx%) Then surround = (im(x1% + 1, Y%) + im(x1% - 1, Y1%) + im(x1%, Y1% - 1) + im(x1% + 1, Y1% - 1) + im(x1% - 1, Y1% - 1)) * 8 / 5
If (x1% > 0 And x1% < maxx%) And (Y1% > 0 And Y1% < maxy%) Then surround = im(x1% - 1, Y1%) + im(x1% + 1, Y1%) + im(x1% + 1, Y1% - 1) + im(x1% - 1, Y1% - 1) + im(x1% + 1, Y1% + 1) + im(x1% + 1, Y1% - 1) + im(x1%, Y1% - 1) + im(x1%, Y1% + 1)
If x1% = 0 And Y1% = 0 Then surround = (im(0, 1) + im(1, 0) + im(1, 1)) * 8 / 3
If x1% = 0 And Y1% = maxy% Then surround = (im(0, maxy% - 1) + im(1, maxy% - 1) + im(1, maxy%)) * 8 / 3
If Y1% = 0 And x1% = maxx% Then surround = (im(maxx% - 1, 0) + im(maxx% - 1, 1) + im(maxx%, 1)) * 8 / 3
If Y1% = maxy% And x1% = maxx% Then surround = (im(maxx%, maxy% - 1) + im(maxx% - 1, maxy%) + im(maxx% - 1, maxy% - 1)) * 8 / 3
intensity = (intensity * 0.8 + (0.2 * surround / 8))
Print #9, mmx, mmy, intensity
Loop Until EOF(8)
Close
Kill imagetmpfile
Name "c:\tmp\smooth.img" As imagetmpfile
PlotImage imagetmpfile
If gAUTOSAVE = True Then imagesavefile = GetFileName(False, gDATdir, ".img"): cmdSave_Click

End Sub

Private Sub mnuUserConfig_Click()
frmUserConfig.Show 1
DrawKey
PlotImage imagetmpfile

End Sub

Private Sub mnuZoom_Click(Index As Integer)

' erase zoom area box and disable buttons
picImage.Line (startx, starty)-(curx, cury), , B
mnuzoom(0).Enabled = False: mnuzoom(1).Enabled = False
picImage.DrawMode = 13

' ensure that StartX,StartY define bottom-left of box
If startx > curx Then swap = curx: curx = startx: startx = swap
If starty < cury Then swap = cury: cury = starty: starty = swap

' recalculate new scan height, width, step size
' and initial mirror position
frmMirrorSetup!txtCentreX = Str$(Int(Val(frmMirrorSetup!txtCentreX) + ((startx + curx) / 2000) * Val(frmMirrorSetup!cmbLens.Text)))
frmMirrorSetup!txtCentreY = Str$(Int(Val(frmMirrorSetup!txtCentreY) + ((starty + cury) / 2000) * Val(frmMirrorSetup!cmbLens.Text)))

If Index = 1 Then mag% = 1 Else mag% = Val(txtMagnify)
frmImageSetup!txtStepSize = Str$(Val(frmImageSetup!txtStepSize) / mag%)
frmImageSetup!txtHeight = Str$(Abs(cury - starty) / 1000)
frmImageSetup!txtWidth = Str$(Abs(curx - startx) / 1000)

Rem * now want to clear screen, redefine picbox scale,
Rem * and PerformScan once more. Probably.
picImage.Cls
Form_Activate
If Index = 0 Then
'If gAUTOSAVE = True Then ImageSave = GetFileName(False, gDATdir, ".img"): labFileName = imagesavefile
cmdSCAN_Click
Else
Crop
End If

End Sub

Private Sub MoveMirrors(xpos As Single, ypos As Single)
If (Abs(xpos) > 10) Or (Abs(ypos) > 10) Then
MsgBox ("Invalid Mirror Position")
halt = 2
Else
xpos = xpos * 10 / 4.5
ypos = ypos * 10 / 4.5
MirrorCommand "BX", Format(xpos, "#0.00#")
MirrorCommand "BY", Format(ypos, "#0.00#")
End If
End Sub

Private Sub picImage_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

If zoommode = 2 Then
picImage.DrawMode = 6
picImage.Line (-(wide + stepsize) * 500, GridY)-((wide + stepsize) * 500, GridY)
picImage.Line (GridX, -(high + stepsize) * 500)-(GridX, (high + stepsize) * 500)
picImage.DrawMode = 13
cmdLineScan(0).Enabled = False: cmdLineScan(1).Enabled = False
End If

If mnuzoom(0).Enabled = True Then
 picImage.Line (startx, starty)-(curx, cury), , B
 mnuzoom(0).Enabled = False: mnuzoom(1).Enabled = False
End If
zoommode = 1
startx = X: starty = Y: curx = X: cury = Y
picImage.DrawMode = 6
picImage.ForeColor = RGB(0, 0, 0)
picImage.FillStyle = 1
picImage.Line (startx, starty)-(curx, cury), , B
End Sub

Private Sub picImage_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

If zoommode = 1 Then
picImage.Line (startx, starty)-(curx, cury), , B
curx = X: cury = Y
picImage.Line (startx, starty)-(curx, cury), , B
End If
End Sub

Private Sub picImage_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
zoommode = 0
If (curx <> startx) Or (cury <> starty) Then
mnuzoom(0).Enabled = True: mnuzoom(1).Enabled = True
Else
Rem mini-grid
If wide <> stepsize And high <> stepsize Then
zoommode = 2
picImage.DrawMode = 6
GridY = ArrayToOffset(OffsetToArray(Y / 1000, high), high) * 1000
GridX = ArrayToOffset(OffsetToArray(X / 1000, high), high) * 1000
labScanOffset.Caption = "X=" + Format(GridX / 1000, "#0.0#") + "mm  Y=" + Format(GridY / 1000, "#0.0#") + "mm"
picImage.Line (-(wide + stepsize) * 500, GridY)-((wide + stepsize) * 500, GridY)
picImage.Line (GridX, -(high + stepsize) * 500)-(GridX, (high + stepsize) * 500)
cmdLineScan(0).Enabled = True: cmdLineScan(1).Enabled = True
picImage.DrawMode = 13
End If
End If
End Sub

Private Sub PlotBox(ByVal X As Integer, ByVal Y As Integer)
Dim scaleint As Long

If maxint = minint Then
 scaleint = 255
Else
 scaleint = 255 * (im(X, Y) - minint) / (maxint - minint)
End If

If scaleint < 0 Then
 scaleint = 0
 labRescale.Caption = "Rescale - measured intensity below scale minimum."
End If

If scaleint > 255 Then
 scaleint = 255
 labRescale.Caption = "Rescale - measured intensity above scale maximum."
End If

picImage.ForeColor = colour(scaleint)
picImage.DrawWidth = 3
mmx = ArrayToOffset(X, img.scanwidth)
mmy = ArrayToOffset(Y, img.scanheight)

If (img.scanheight > img.scanstepsize) And (img.scanwidth > img.scanstepsize) Then
 ' full scan
 picImage.Line ((mmx - img.scanstepsize * 0.5) * 1000, (mmy - img.scanstepsize * 0.5) * 1000)-((mmx + img.scanstepsize * 0.5) * 1000, (mmy + img.scanstepsize * 0.5) * 1000), , BF
Else
 ' linescan
  If wide = stepsize Then
   ' along X
   picImage.Line (-img.scanwidth * 500, (mmy - img.scanstepsize * 0.5) * 1000)-(img.scanwidth * 500, (mmy + img.scanstepsize * 0.5) * 1000), , BF
  Else
   ' along Y
   picImage.Line ((mmx - img.scanstepsize * 0.5) * 1000, img.scanheight * 500)-((mmx + img.scanstepsize * 0.5) * 1000, -img.scanheight * 500), , BF
  End If
End If
picImage.DrawWidth = 1
End Sub

Private Sub PlotImage(filename As String)
Dim X As Integer, Y As Integer

If filename <> "" Then
LoadImageData filename
End If

maxint = -1000000000#: minint = 1000000000#
For X = 0 To maxx%
For Y = 0 To maxy%
If im(X, Y) > maxint And im(X, Y) <> 0 Then maxint = im(X, Y)
If im(X, Y) < minint And im(X, Y) <> 0 Then minint = im(X, Y)
Next: Next

If gCOLOURS <= 256 Then
picImage.Picture = LoadPicture("c:\tmp\palette.bmp")
End If

For cx% = 0 To maxx%
For cy% = 0 To maxy%
PlotBox ByVal cx%, ByVal cy%
Next
Next

lab100PerCent = Format$(maxint, "0.0E+0#") + " V"
lab0PerCent = Format$(minint, "0.0E+0#") + " V"
maxintensity = maxint: minintensity = minint
End Sub

Private Sub SaveImageAsBinary(filename)

' construct filename
If filename <> "" Then
imagesavefile = filename
Else
imagesavefile = GetFileName(True, gDATdir, ".imx")
End If
labFileName.Caption = imagesavefile

Open imagesavefile For Binary Access Write As #1

Put #1, , img

Seek #1, 129  ' move beyond header

If img.scanwidth = img.scanstepsize Then
maxx% = 0
Else
maxx% = img.scanwidth / img.scanstepsize
End If

If img.scanheight = img.scanstepsize Then
maxy% = 0
Else
maxy% = img.scanheight / img.scanstepsize
End If

bytes_to_be_written = (maxx% + 1) * (maxy% + 1) * 4

' get file handle for API write
dosfilehandle% = FileAttr(1, 2)
ret% = hwrite(dosfilehandle%, im(0, 0), bytes_to_be_written)
Close
End Sub

Private Sub SaveImg(Ind As Integer)
 Close
 frmImageDisplay!cmdRescale.Enabled = False

savedirectory = CheckPresent(ByVal gDATdir)
ChDir savedirectory

If Ind = 0 Then
gDATA_TYPE = imgsave
frmFileIO.Caption = "Save Image Scan data"
'frmFileIO!lstFileExt.List(0) = "Image raw data files (*.img)"
'frmFileIO.lstFileExt.List(1) = "Bitmap of image (*.bmp)"
'frmFileIO!lstFileExt.List(2) = "All files (*.*)"
'frmFileIO!lstFileExt.ListIndex = 0
frmFileIO!lstDirectory.Path = savedirectory
frmFileIO!frameSaveFile.Enabled = True
frmFileIO!frameFiles.Enabled = False
frmFileIO!txtSaveDirectory = savedirectory
frmFileIO!frameSelectedFile.Enabled = False
frmFileIO.Show 1
savedirectory = frmFileIO!lstDirectory.Path

If Right$(savedirectory, 1) <> "\" Then savedirectory = savedirectory + "\"
imagesavefile = file + ".img"
End If

ImageSave
labFileName = imagesavefile: labSave.Caption = "(saved)"

End Sub

Private Sub ScanDelay()
done = 0
timeScan.Enabled = True
Do While timeScan.Enabled = True
DoEvents
If done = 0 Then
 sqdone = sqdone + 1: If sqdone = 3 Then cmdRescale_Click
 pcdone = sqdone / sqtotal
 ctime = Timer
 taken% = ctime - start_time
 min = Int(taken% / 60): sec% = taken% Mod 60
 labTimeTaken.Caption = Format(min, "#00") + ":" + Format(sec%, "00")
 lft = ((1 - pcdone) * taken%) / pcdone
 min = Int(lft / 60): sec% = lft Mod 60
 labTimeLeft.Caption = Format(min, "#00") + ":" + Format(sec%, "00")
 done = 1
End If
If Left$(labRescale.Caption, 3) <> "All" And chkAutoRescale.Value = True Then cmdRescale_Click: Do: Loop Until halt <> 1
Loop


End Sub

Private Sub Spin1_SpinDown()
If Val(txtMagnify.Text) > 2 Then txtMagnify.Text = Str$(Val(txtMagnify.Text) / 2) + " times"
End Sub

Private Sub Spin1_SpinUp()
If Val(txtMagnify.Text) < 16 Then txtMagnify.Text = Str$(Val(txtMagnify.Text) * 2) + " times"
End Sub

Private Sub text1_Change()

End Sub

Private Sub timeScan_Timer()
timeScan.Enabled = False
End Sub

Private Sub WriteIMGHeader(subheader$, subheadval$, imgfilename$)
ret% = WritePrivateProfileString(ByVal "Header", ByVal subheader$, ByVal subheadval$, ByVal imgfilename$)
End Sub


Private Sub getlevels(n1 As Integer, n2 As Integer)
Select Case n1
Case 0
newvgain = 0.000000002
Case 1
newvgain = 0.000000005
Case 2
newvgain = 0.00000001
Case 3
newvgain = 0.00000002
Case 4
newvgain = 0.00000005
Case 5
newvgain = 0.0000001
Case 6
newvgain = 0.0000002
Case 7
newvgain = 0.0000005
Case 8
newvgain = 0.000001
Case 9
newvgain = 0.000002
Case 10
newvgain = 0.000005
Case 11
newvgain = 0.00001
Case 12
newvgain = 0.00002
Case 13
newvgain = 0.00005
Case 14
newvgain = 0.0001
Case 15
newvgain = 0.0002
Case 16
newvgain = 0.0005
Case 17
newvgain = 0.001
Case 18
newvgain = 0.002
Case 19
newvgain = 0.005
Case 20
newvgain = 0.01
Case 21
newvgain = 0.02
Case 22
newvgain = 0.05
Case 23
newvgain = 0.1
Case 24
newvgain = 0.2
Case 25
newvgain = 0.5
Case 26
newvgain = 1
End Select
Select Case n2
Case 0
newtimeconst = 0.00001
Case 1
newtimeconst = 0.00003
Case 2
newtimeconst = 0.0001
Case 3
newtimeconst = 0.0003
Case 4
newtimeconst = 0.001
Case 5
newtimeconst = 0.003
Case 6
newtimeconst = 0.01
Case 7
newtimeconst = 0.03
Case 8
newtimeconst = 0.1
Case 9
newtimeconst = 0.3
Case 10
newtimeconst = 1
Case Else
newtimeconst = 30
End Select



End Sub
