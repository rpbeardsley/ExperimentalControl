VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmTrace 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00C0C0C0&
   Caption         =   "Digitiser"
   ClientHeight    =   6945
   ClientLeft      =   0
   ClientTop       =   1710
   ClientWidth     =   11835
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
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6945
   ScaleWidth      =   11835
   Begin VB.TextBox TempRead 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   9840
      TabIndex        =   102
      Text            =   "Text1"
      Top             =   6600
      Width           =   1815
   End
   Begin VB.TextBox txtTime 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   3000
      TabIndex        =   3
      TabStop         =   0   'False
      Text            =   "Time/nanoseconds"
      Top             =   6570
      Width           =   1755
   End
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   8280
      MultiLine       =   -1  'True
      TabIndex        =   2
      TabStop         =   0   'False
      Text            =   "FRMTRACE.frx":0000
      Top             =   60
      Width           =   1215
   End
   Begin VB.PictureBox picTrace 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      FillColor       =   &H008080FF&
      FillStyle       =   0  'Solid
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000C000&
      Height          =   5895
      Left            =   180
      ScaleHeight     =   979.95
      ScaleMode       =   0  'User
      ScaleWidth      =   1000
      TabIndex        =   0
      Top             =   270
      Width           =   7455
      Begin Threed.SSFrame frameSaveOptions 
         Height          =   3405
         Left            =   2250
         TabIndex        =   67
         Top             =   1050
         Visible         =   0   'False
         Width           =   4305
         _Version        =   65536
         _ExtentX        =   7594
         _ExtentY        =   6006
         _StockProps     =   14
         Caption         =   "Setup: Trace acquisition for swept parameters"
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
         Begin VB.CommandButton cmdCancel 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            Caption         =   "Cancel"
            Height          =   375
            Left            =   2190
            TabIndex        =   66
            Top             =   2880
            Width           =   1485
         End
         Begin VB.CommandButton cmdSaveOptionsOK 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            Caption         =   "OK"
            Height          =   375
            Left            =   420
            TabIndex        =   73
            Top             =   2880
            Width           =   1485
         End
         Begin VB.TextBox txtFilePrefix 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   2520
            MaxLength       =   4
            TabIndex        =   68
            Top             =   510
            Width           =   555
         End
         Begin Threed.SSCheck chkSave 
            Height          =   195
            Left            =   1110
            TabIndex        =   72
            Top             =   300
            Width           =   1185
            _Version        =   65536
            _ExtentX        =   2090
            _ExtentY        =   344
            _StockProps     =   78
            Caption         =   "Save traces"
            ForeColor       =   -2147483640
            Value           =   -1  'True
            Font3D          =   3
         End
         Begin Threed.SSCheck chkIntegrals 
            Height          =   225
            Left            =   210
            TabIndex        =   65
            Top             =   1770
            Width           =   3675
            _Version        =   65536
            _ExtentX        =   6482
            _ExtentY        =   397
            _StockProps     =   78
            Caption         =   "Plot graph of pulse height vs parameter"
            ForeColor       =   -2147483640
            Font3D          =   3
         End
         Begin VB.Label label77 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   $"FRMTRACE.frx":000E
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   675
            Left            =   210
            TabIndex        =   74
            Top             =   2040
            Width           =   3945
         End
         Begin VB.Label Label28 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Pulse height integrals"
            ForeColor       =   &H00FF0000&
            Height          =   225
            Left            =   210
            TabIndex        =   86
            Top             =   1500
            Width           =   1605
         End
         Begin VB.Line Line4 
            X1              =   390
            X2              =   3660
            Y1              =   1410
            Y2              =   1410
         End
         Begin VB.Label Label27 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Saving files:"
            ForeColor       =   &H00FF0000&
            Height          =   225
            Left            =   150
            TabIndex        =   85
            Top             =   270
            Width           =   945
         End
         Begin VB.Label Label35 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "File prefix (max=4 characters) :"
            ForeColor       =   &H80000008&
            Height          =   255
            Left            =   180
            TabIndex        =   69
            Top             =   540
            Width           =   2325
         End
         Begin VB.Label LabFileNameMessage 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "In swept attenuation mode, filename=xxxxyydB.dat where xxxx=prefix, yy=attenuation level."
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   465
            Index           =   2
            Left            =   180
            TabIndex        =   70
            Top             =   870
            Visible         =   0   'False
            Width           =   4065
         End
         Begin VB.Label LabFileNameMessage 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "In swept voltage mode, filename=xxxxyyyV.dat where xxxx=prefix, yy.y=pulse voltage."
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   -1  'True
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   465
            Index           =   1
            Left            =   150
            TabIndex        =   71
            Top             =   870
            Visible         =   0   'False
            Width           =   4005
         End
      End
   End
   Begin Threed.SSFrame Frame3D4 
      Height          =   6555
      Left            =   8400
      TabIndex        =   11
      Top             =   -120
      Width           =   3615
      _Version        =   65536
      _ExtentX        =   6376
      _ExtentY        =   11562
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
      Begin VB.CommandButton cmdAcquire 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "ACQUIRE"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   1980
         TabIndex        =   1
         Top             =   5520
         Width           =   1335
      End
      Begin VB.ComboBox cmbDisplay 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   900
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   270
         Width           =   1515
      End
      Begin VB.ComboBox cmbTraceType 
         Appearance      =   0  'Flat
         Height          =   315
         Index           =   2
         Left            =   750
         Style           =   2  'Dropdown List
         TabIndex        =   56
         Top             =   5040
         Width           =   1995
      End
      Begin VB.ComboBox cmbTraceType 
         Appearance      =   0  'Flat
         Height          =   315
         Index           =   1
         Left            =   750
         Style           =   2  'Dropdown List
         TabIndex        =   54
         Top             =   4680
         Width           =   1995
      End
      Begin VB.ComboBox cmbTraceType 
         Appearance      =   0  'Flat
         Height          =   315
         Index           =   0
         Left            =   750
         Style           =   2  'Dropdown List
         TabIndex        =   52
         Top             =   4320
         Width           =   1995
      End
      Begin VB.TextBox txtImpedance 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   225
         Left            =   120
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   2400
         Width           =   225
      End
      Begin VB.TextBox txtTrigger 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   225
         Left            =   150
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   2880
         Width           =   1485
      End
      Begin VB.TextBox txtSamplePeriod 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   255
         Left            =   2820
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   2970
         Width           =   585
      End
      Begin VB.TextBox txtRecLen 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   225
         Left            =   2820
         TabIndex        =   7
         TabStop         =   0   'False
         Top             =   3180
         Width           =   585
      End
      Begin VB.TextBox txtAverages 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   225
         Left            =   780
         MultiLine       =   -1  'True
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   3120
         Width           =   855
      End
      Begin VB.TextBox txtFullScale 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   255
         Left            =   2700
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   2400
         Width           =   675
      End
      Begin VB.TextBox txtOffset 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         Height          =   255
         Left            =   2670
         TabIndex        =   10
         TabStop         =   0   'False
         Top             =   2640
         Width           =   675
      End
      Begin VB.ComboBox cmbTimeBase 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   870
         Style           =   2  'Dropdown List
         TabIndex        =   46
         Top             =   3750
         Width           =   735
      End
      Begin VB.ComboBox cmbVolts 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   2400
         Style           =   2  'Dropdown List
         TabIndex        =   45
         Top             =   3750
         Width           =   735
      End
      Begin Threed.SSFrame frameDisplay 
         Height          =   1545
         Index           =   2
         Left            =   120
         TabIndex        =   13
         Top             =   540
         Visible         =   0   'False
         Width           =   3435
         _Version        =   65536
         _ExtentX        =   6059
         _ExtentY        =   2725
         _StockProps     =   14
         Caption         =   "Time gating:"
         ForeColor       =   16711680
         Begin VB.CommandButton cmdOnScreen 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            Caption         =   "On-screen"
            Height          =   285
            Left            =   2400
            TabIndex        =   88
            Top             =   1170
            Width           =   945
         End
         Begin Threed.SSCheck chkLock 
            Height          =   195
            Index           =   0
            Left            =   1320
            TabIndex        =   89
            Top             =   1230
            Width           =   885
            _Version        =   65536
            _ExtentX        =   1561
            _ExtentY        =   344
            _StockProps     =   78
            Caption         =   "Avg-lock"
            ForeColor       =   -2147483640
            Alignment       =   1
            Font3D          =   3
         End
         Begin Threed.SSCheck chkLock 
            Height          =   195
            Index           =   1
            Left            =   90
            TabIndex        =   87
            Top             =   1230
            Width           =   1035
            _Version        =   65536
            _ExtentX        =   1826
            _ExtentY        =   344
            _StockProps     =   78
            Caption         =   "Base-lock"
            ForeColor       =   -2147483640
            Alignment       =   1
            Font3D          =   3
         End
         Begin VB.Label Label44 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "ns"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   3120
            TabIndex        =   97
            Top             =   750
            Width           =   195
         End
         Begin VB.Label Label43 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "ns"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   3120
            TabIndex        =   96
            Top             =   240
            Width           =   195
         End
         Begin VB.Label labWindowWidth 
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
            Height          =   165
            Index           =   1
            Left            =   540
            TabIndex        =   95
            Top             =   450
            Width           =   945
         End
         Begin VB.Label Label42 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Width"
            ForeColor       =   &H80000008&
            Height          =   165
            Left            =   30
            TabIndex        =   94
            Top             =   450
            Width           =   555
         End
         Begin VB.Label Label41 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "AVERAGE:"
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
            Left            =   60
            TabIndex        =   93
            Top             =   750
            Width           =   945
         End
         Begin VB.Label Label40 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "BASE:"
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
            Left            =   60
            TabIndex        =   92
            Top             =   240
            Width           =   975
         End
         Begin VB.Label labWindowWidth 
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
            Height          =   165
            Index           =   0
            Left            =   540
            TabIndex        =   91
            Top             =   960
            Width           =   915
         End
         Begin VB.Label Label39 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "to"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   2340
            TabIndex        =   90
            Top             =   240
            Width           =   195
         End
         Begin VB.Label labWindowVoltage 
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
            Height          =   165
            Index           =   0
            Left            =   2040
            TabIndex        =   83
            Top             =   960
            Width           =   1245
         End
         Begin VB.Label Label38 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Level"
            ForeColor       =   &H80000008&
            Height          =   165
            Left            =   1590
            TabIndex        =   82
            Top             =   960
            Width           =   435
         End
         Begin VB.Label Label37 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Level"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   1590
            TabIndex        =   81
            Top             =   450
            Width           =   435
         End
         Begin VB.Label labWindowVoltage 
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
            Height          =   165
            Index           =   1
            Left            =   2040
            TabIndex        =   80
            Top             =   450
            Width           =   1305
         End
         Begin VB.Label labTimeWindow 
            Alignment       =   1  'Right Justify
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
            Index           =   2
            Left            =   1740
            TabIndex        =   79
            Top             =   240
            Width           =   435
         End
         Begin VB.Label Label33 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Window:"
            ForeColor       =   &H00000000&
            Height          =   165
            Left            =   960
            TabIndex        =   78
            Top             =   750
            Width           =   765
         End
         Begin VB.Label Label21 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Window:"
            ForeColor       =   &H00000000&
            Height          =   195
            Left            =   930
            TabIndex        =   77
            Top             =   240
            Width           =   795
         End
         Begin VB.Label Label22 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "to"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   2340
            TabIndex        =   14
            Top             =   750
            Width           =   195
         End
         Begin VB.Label Label23 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "Width"
            ForeColor       =   &H80000008&
            Height          =   165
            Left            =   30
            TabIndex        =   15
            Top             =   960
            Width           =   555
         End
         Begin VB.Label labTimeWindow 
            Alignment       =   1  'Right Justify
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
            Height          =   165
            Index           =   0
            Left            =   1740
            TabIndex        =   16
            Top             =   750
            Width           =   435
         End
         Begin VB.Label labTimeWindow 
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
            Height          =   165
            Index           =   1
            Left            =   2550
            TabIndex        =   17
            Top             =   750
            Width           =   435
         End
         Begin VB.Label labTimeWindow 
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
            Index           =   3
            Left            =   2550
            TabIndex        =   18
            Top             =   240
            Width           =   435
         End
      End
      Begin Threed.SSFrame frameDisplay 
         Height          =   1005
         Index           =   0
         Left            =   180
         TabIndex        =   32
         Top             =   570
         Width           =   3195
         _Version        =   65536
         _ExtentX        =   5636
         _ExtentY        =   1773
         _StockProps     =   14
         Caption         =   "Zoom window:"
         ForeColor       =   16711680
         Begin VB.CommandButton cmdZoom 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            Caption         =   "Zoom in"
            Enabled         =   0   'False
            Height          =   405
            Left            =   2220
            TabIndex        =   33
            Top             =   360
            Width           =   855
         End
      End
      Begin Threed.SSFrame frameDisplay 
         Height          =   975
         Index           =   1
         Left            =   180
         TabIndex        =   59
         Top             =   600
         Visible         =   0   'False
         Width           =   3195
         _Version        =   65536
         _ExtentX        =   5636
         _ExtentY        =   1720
         _StockProps     =   14
         Caption         =   "Cursors:"
         ForeColor       =   16711680
         Begin VB.PictureBox picCursor 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000FF&
            Height          =   225
            Index           =   0
            Left            =   150
            ScaleHeight     =   10
            ScaleMode       =   0  'User
            ScaleWidth      =   10
            TabIndex        =   19
            Top             =   360
            Width           =   285
         End
         Begin VB.PictureBox picCursor 
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000FF&
            Height          =   225
            Index           =   1
            Left            =   150
            ScaleHeight     =   10
            ScaleMode       =   0  'User
            ScaleWidth      =   10
            TabIndex        =   20
            Top             =   600
            Width           =   285
         End
         Begin VB.Frame Frame1 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
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
            Height          =   615
            Left            =   1950
            TabIndex        =   60
            Top             =   240
            Width           =   1125
            Begin VB.Label labCursorY 
               Alignment       =   1  'Right Justify
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
               Height          =   225
               Index           =   2
               Left            =   360
               TabIndex        =   21
               Top             =   360
               Width           =   405
            End
            Begin VB.Label labCursorX 
               Alignment       =   1  'Right Justify
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
               Height          =   225
               Index           =   2
               Left            =   360
               TabIndex        =   22
               Top             =   120
               Width           =   405
            End
            Begin VB.Label Label19 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "dY="
               ForeColor       =   &H80000008&
               Height          =   195
               Left            =   60
               TabIndex        =   23
               Top             =   360
               Width           =   315
            End
            Begin VB.Label Label18 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "dX="
               ForeColor       =   &H80000008&
               Height          =   195
               Left            =   60
               TabIndex        =   63
               Top             =   120
               Width           =   315
            End
            Begin VB.Label Label29 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "ns"
               ForeColor       =   &H80000008&
               Height          =   195
               Left            =   810
               TabIndex        =   62
               Top             =   120
               Width           =   285
            End
            Begin VB.Label Label30 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "mV"
               ForeColor       =   &H80000008&
               Height          =   195
               Left            =   810
               TabIndex        =   61
               Top             =   360
               Width           =   285
            End
         End
         Begin VB.Label labCursorX 
            Alignment       =   1  'Right Justify
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
            Height          =   225
            Index           =   0
            Left            =   420
            TabIndex        =   24
            Top             =   360
            Width           =   375
         End
         Begin VB.Label labCursorX 
            Alignment       =   1  'Right Justify
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
            Height          =   225
            Index           =   1
            Left            =   420
            TabIndex        =   25
            Top             =   600
            Width           =   375
         End
         Begin VB.Label labCursorY 
            Alignment       =   1  'Right Justify
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
            Height          =   225
            Index           =   0
            Left            =   1080
            TabIndex        =   26
            Top             =   360
            Width           =   405
         End
         Begin VB.Label labCursorY 
            Alignment       =   1  'Right Justify
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
            Height          =   225
            Index           =   1
            Left            =   1080
            TabIndex        =   27
            Top             =   600
            Width           =   405
         End
         Begin VB.Label Label14 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "ns,"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   840
            TabIndex        =   28
            Top             =   360
            Width           =   225
         End
         Begin VB.Label Label15 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "ns,"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   840
            TabIndex        =   29
            Top             =   600
            Width           =   225
         End
         Begin VB.Label Label16 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "mV"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   1530
            TabIndex        =   30
            Top             =   360
            Width           =   225
         End
         Begin VB.Label Label17 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "mV"
            ForeColor       =   &H80000008&
            Height          =   195
            Left            =   1530
            TabIndex        =   31
            Top             =   600
            Width           =   225
         End
      End
      Begin Threed.SSCheck chkShowTrace 
         Height          =   210
         Index           =   2
         Left            =   2790
         TabIndex        =   98
         Top             =   5070
         Width           =   705
         _Version        =   65536
         _ExtentX        =   1244
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Show"
         ForeColor       =   -2147483640
         Value           =   -1  'True
         Font3D          =   3
      End
      Begin Threed.SSOption optTraceMethod 
         Height          =   285
         Index           =   2
         Left            =   90
         TabIndex        =   84
         TabStop         =   0   'False
         Top             =   6240
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   503
         _StockProps     =   78
         Caption         =   "Set of traces for gate voltage sweep"
         ForeColor       =   -2147483640
      End
      Begin Threed.SSOption optTraceMethod 
         Height          =   285
         Index           =   1
         Left            =   90
         TabIndex        =   76
         TabStop         =   0   'False
         Top             =   5970
         Width           =   2985
         _Version        =   65536
         _ExtentX        =   5265
         _ExtentY        =   503
         _StockProps     =   78
         Caption         =   "Set of traces for attenuation sweep"
         ForeColor       =   -2147483640
      End
      Begin Threed.SSOption optTraceMethod 
         Height          =   315
         Index           =   0
         Left            =   90
         TabIndex        =   75
         Top             =   5700
         Width           =   1395
         _Version        =   65536
         _ExtentX        =   2461
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Single traces"
         ForeColor       =   -2147483640
         Value           =   -1  'True
      End
      Begin Threed.SSCheck chkShowTrace 
         Height          =   210
         Index           =   1
         Left            =   2790
         TabIndex        =   51
         Top             =   4710
         Width           =   705
         _Version        =   65536
         _ExtentX        =   1244
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Show"
         ForeColor       =   -2147483640
         Font3D          =   3
      End
      Begin Threed.SSCheck chkShowTrace 
         Height          =   195
         Index           =   0
         Left            =   2790
         TabIndex        =   58
         Top             =   4380
         Width           =   705
         _Version        =   65536
         _ExtentX        =   1244
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Show"
         ForeColor       =   -2147483640
         Font3D          =   3
      End
      Begin VB.Label Label20 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Acquisition method:"
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
         TabIndex        =   64
         Top             =   5490
         Width           =   1725
      End
      Begin VB.Line Line1 
         X1              =   120
         X2              =   3480
         Y1              =   5430
         Y2              =   5430
      End
      Begin VB.Label Label13 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Display:"
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
         Left            =   210
         TabIndex        =   34
         Top             =   300
         Width           =   705
      End
      Begin VB.Label Label26 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "RESULT:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   225
         Left            =   60
         TabIndex        =   57
         Top             =   5070
         Width           =   705
      End
      Begin VB.Label Label25 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Trace 2:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   225
         Left            =   60
         TabIndex        =   55
         Top             =   4710
         Width           =   645
      End
      Begin VB.Label Label24 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Trace 1:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000FFFF&
         Height          =   225
         Left            =   60
         TabIndex        =   53
         Top             =   4350
         Width           =   645
      End
      Begin VB.Label Label32 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "On-screen trace:"
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
         Left            =   60
         TabIndex        =   35
         Top             =   3510
         Width           =   1455
      End
      Begin VB.Line Line3 
         X1              =   120
         X2              =   3510
         Y1              =   3450
         Y2              =   3450
      End
      Begin VB.Label Label31 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "DSP board:"
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
         TabIndex        =   36
         Top             =   2190
         Width           =   1335
      End
      Begin VB.Line Line2 
         X1              =   120
         X2              =   3510
         Y1              =   2130
         Y2              =   2130
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "ohm i/p impedance"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   360
         TabIndex        =   37
         Top             =   2400
         Width           =   1335
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Triggering signal ="
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   120
         TabIndex        =   38
         Top             =   2670
         Width           =   1335
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Sample period:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   1770
         TabIndex        =   39
         Top             =   2970
         Width           =   1095
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Record length:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   1770
         TabIndex        =   40
         Top             =   3180
         Width           =   1095
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Sweeps:"
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   120
         TabIndex        =   41
         Top             =   3120
         Width           =   705
      End
      Begin VB.Label Label6 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Input amplifier:"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Left            =   1830
         TabIndex        =   42
         Top             =   2190
         Width           =   1335
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Full-scale = "
         ForeColor       =   &H00000000&
         Height          =   225
         Left            =   1830
         TabIndex        =   43
         Top             =   2400
         Width           =   945
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "I/P offset ="
         ForeColor       =   &H80000008&
         Height          =   225
         Left            =   1860
         TabIndex        =   44
         Top             =   2640
         Width           =   855
      End
      Begin VB.Label Label9 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Timebase:"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   120
         TabIndex        =   50
         Top             =   3780
         Width           =   765
      End
      Begin VB.Label Label10 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "ns/div"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   900
         TabIndex        =   49
         Top             =   4050
         Width           =   465
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Y-scale:"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   1770
         TabIndex        =   48
         Top             =   3780
         Width           =   645
      End
      Begin VB.Label Label12 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "mV/div"
         ForeColor       =   &H80000008&
         Height          =   165
         Left            =   2430
         TabIndex        =   47
         Top             =   4050
         Width           =   525
      End
   End
   Begin Threed.SSCheck ACcoupling 
      Height          =   255
      Left            =   6240
      TabIndex        =   100
      Top             =   6570
      Width           =   1365
      _Version        =   65536
      _ExtentX        =   2408
      _ExtentY        =   450
      _StockProps     =   78
      Caption         =   "AC coupling"
      ForeColor       =   -2147483640
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   1
      Font3D          =   3
   End
   Begin VB.Label Label34 
      Caption         =   "Lock-In Reading"
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
      Left            =   8400
      TabIndex        =   101
      Top             =   6600
      Width           =   1335
   End
   Begin VB.Label SaturationWarning 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "WARNING: data saturated on this gain setting."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   225
      Left            =   180
      TabIndex        =   99
      Top             =   30
      Visible         =   0   'False
      Width           =   4125
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuSave 
         Caption         =   "&Save Trace As..."
      End
      Begin VB.Menu mnuPrint 
         Caption         =   "Print..."
      End
      Begin VB.Menu mnuSeparator 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuDisplayMenu 
      Caption         =   "&Display"
      Begin VB.Menu mnuDisplayAids 
         Caption         =   "DISPLAY AIDS:"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuDisplay 
         Caption         =   "&Zoom window"
         Index           =   0
      End
      Begin VB.Menu mnuDisplay 
         Caption         =   "&Cursors"
         Index           =   1
      End
      Begin VB.Menu mnuDisplay 
         Caption         =   "&Time gating"
         Index           =   2
      End
      Begin VB.Menu mnuSeparate1 
         Caption         =   "-"
      End
   End
   Begin VB.Menu mnuSetup 
      Caption         =   "&Setup"
      Begin VB.Menu mnuSetupDigitiser 
         Caption         =   "&Digitiser"
      End
      Begin VB.Menu mnuAttenuate 
         Caption         =   "&Attenuator"
      End
      Begin VB.Menu mnuGate 
         Caption         =   "&Gate voltage (from DVS)"
      End
      Begin VB.Menu mnuSetupPulse 
         Caption         =   "&Voltage pulse (from PSU)"
      End
      Begin VB.Menu mnuSpike 
         Caption         =   "&Spike Filter"
      End
   End
End
Attribute VB_Name = "frmTrace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim traceon(2) As Integer
Dim cursorx(1) As Single, cursory(1) As Single
Dim dis(1) As Single
Dim timelines
Dim tracecolour(3) As Long
Dim zoommode As Integer
Dim startx As Long, starty As Long, curx As Long, cury As Long
Dim display_mode As Integer

Private Sub ACcoupling_Click(Value As Integer)
DisplayTraces
End Sub

Private Sub CheckTimeWindowOrdering(timewin)
Select Case (timewin Mod 2)
Case 1
' want this line be to the right of the preceding one
If timewindow(timewin) < timewindow(timewin - 1) Then
tmp = timewindow(timewin): timewindow(timewin) = timewindow(timewin - 1)
timewindow(timewin - 1) = tmp
End If

Case 0
' want this line be to the left of the following one
If timewindow(timewin) > timewindow(timewin + 1) Then
tmp = timewindow(timewin): timewindow(timewin) = timewindow(timewin + 1)
timewindow(timewin + 1) = tmp
End If
End Select
End Sub

Private Sub chkShowTrace_Click(Index As Integer, Value As Integer)
DisplayTraces
End Sub

Private Sub cmbDisplay_Click()
If cmbDisplay.ListIndex = display_mode Then Exit Sub
If cmbDisplay.ListIndex = 0 Then mnuDisplay(i%).CHECKED = True Else mnuDisplay(i%).CHECKED = False
For i% = 0 To 2
If cmbDisplay.ListIndex <> i% Then
frameDisplay(i%).Visible = False: mnuDisplay(i%).CHECKED = False
Else
frameDisplay(i%).Visible = True: mnuDisplay(i%).CHECKED = True
End If
Next
ToolsOff display_mode
display_mode = cmbDisplay.ListIndex
ToolsOn display_mode
End Sub

Private Sub cmbTimeBase_Click()
rec_on_screen% = Val(cmbTimeBase.Text) * 10 / gDIG_SAMPLEPER
If rec_on_screen% > 0 And max_on_screen% > 0 Then setscale
DisplayTraces
End Sub

Private Sub cmbVolts_Click()
max_on_screen% = Val(cmbVolts.Text) * 8
If max_on_screen% > 0 And rec_on_screen% > 0 Then setscale
DisplayTraces
End Sub

Private Sub cmdAcquire_Click()
If cmdAcquire.Caption <> "STOP" Then
cmdAcquire.Caption = "STOP"
Dim method As Integer, min As Single, max As Single
Dim stp As Single, gate As Single, integral As Single
Dim count As Integer
gQUIT = 0
SetupDigitiser

gotzerobias = 0

method = 0
For i% = 0 To 2: If optTraceMethod(i%).Value = True Then method = i%
Next

frmSCAN!panelInfo.ForeColor = &HFF

Select Case method
' ---------------------------------------------------------
Case 0
' single (averaged) traces
frmSCAN!panelInfo = "Beginning trace acquisition.. please wait."
AcquireOne
DisplayTraces

'Read in the temperature from the lock-in
SendIEEECmd (Str$(ieeeaddr(lckn)))
SendIEEEdata ("OUTR? 1")
TempRead = 1000 * Val(recvIEEEdata$(20))

' --------------------------------------------------------
Case 2
' varying gate voltage

savedirectory = CheckPresent(gDATdir)
ChDir savedirectory
labFileNameMessage(1).Visible = True
labFileNameMessage(2).Visible = False
mnuDisplay_Click (2)
frameSaveOptions.Visible = True

'New bit for temp recording
tempfile = "C:\Data\temprec.dat"
Open tempfile For Output As #29

Do
DoEvents
Loop Until frameSaveOptions.Visible = False

DisplayTraces
If gQUIT = 0 Then
min = Val(frmdvs!text1.Text)
max = Val(frmdvs!Text2.Text)
stp = Abs(Val(frmdvs!Text3.Text))
If max < min Then
stp = -stp
End If
If chkIntegrals.Value = True Then Open "c:\tmp\temp.dat" For Output As #5
'MsgBox (Str$(min) + " " + Str$(max) + " " + Str$(stp))
count = 0
dvsset
For gate = min To max Step stp
If gQUIT = 1 Then Exit For
 frmSCAN!panelInfo = "Getting " + Format(gate, "#0.0##") + " V gate trace.. please wait."
 count = count + 1
 SetGate gate
 pause 6
 AcquireOne
 gQUIT = 0
 DisplayTraces
 DisplayTimeWindowInfo
 integral = TimeIntegral(0) - TimeIntegral(1)
' Write to file
If chkIntegrals.Value = True Then Print #5, gate, integral
file = txtFilePrefix + CStr(count)

If chkSave.Value = True Then SaveDigitiserTrace 2, file + ".dat"



'__________________________________________
'Read in the temperature from the lock-in
SendIEEECmd (Str$(ieeeaddr(lckn)))
SendIEEEdata ("OUTR? 1")
TempRead = 1000 * Val(recvIEEEdata$(20))

'____________________________
'New bit to plot temperature as the scan progresses


Print #29, TempRead
'_____________________________________

Next gate

If chkIntegrals.Value = True Then
 Close #5
 ' now make the graph appear
 datasavefile = "c:\tmp\temp.dat"
 datatmpfile = datasavefile
 gNumPts(1) = count
 frmXYDisplay!gphXY.NumSets = 1
 frmXYDisplay!gphXY.ThisSet = 1
 mode = BROWSE
 xysetupload
 frmXYDisplay.Show 1
End If
End If
Close #29
' --------------------------------------------------------
Case 3
' this will be for variable PSU pulse
labFileNameMessage(1).Visible = True
labFileNameMessage(2).Visible = False
frameSaveOptions.Visible = True
Do
DoEvents
Loop Until frameSaveOptions.Visible = False
DisplayTraces
' -------------------------------------------------------'
Case 1
' variable attenuation
'New bit to plot temperature as the scan progresses
tempfile = "C:\Data\temprec.dat"
Open tempfile For Output As #29

savedirectory = CheckPresent(gDATdir)
ChDir savedirectory
labFileNameMessage(2).Visible = True
labFileNameMessage(1).Visible = False

frameSaveOptions.Visible = True
Do
DoEvents
Loop Until frameSaveOptions.Visible = False

DisplayTraces

If gQUIT = 0 Then

min = Abs(Val(frmAttenuate!txtAttenRange(0))): max = Abs(Val(frmAttenuate!txtAttenRange(1)))
stp = Abs(Val(frmAttenuate!txtAttenStep)): If max < min Then stp = -stp
'MsgBox (Str$(min) + " " + Str$(max) + " " + Str$(stp))
If chkIntegrals.Value = True Then Open "c:\tmp\temp.dat" For Output As #5
For i% = min To max Step stp
gQUIT = 0
 
 frmSCAN!panelInfo = "Getting " + Str$(i%) + " dB trace.. please wait."
 'SetAttenuator i%
 SetAttenuator (63 - i%)
 pause 500
 If gQUIT = 1 Then Exit For
 AcquireOne
 gQUIT = 0
 DisplayTraces
 DisplayTimeWindowInfo
 integral = TimeIntegral(0) - TimeIntegral(1)

' Write to file
If chkIntegrals.Value = True Then Print #5, i%, integral
file = txtFilePrefix + Format$(i%, "00") + "dB"
ChDir savedirectory

If chkSave.Value = True Then SaveDigitiserTrace 2, file + ".dat"

'__________________________________________
'Read in the temperature from the lock-in
SendIEEECmd (Str$(ieeeaddr(lckn)))
SendIEEEdata ("OUTR? 1")
TempRead = 1000 * Val(recvIEEEdata$(20))

'____________________________

Print #29, TempRead
'_____________________________________



Next i%
If chkIntegrals.Value = True Then
 Close #5
 ' now make the graph appear
 datasavefile = "c:\tmp\temp.dat"
 datatmpfile = datasavefile
 gNumPts(1) = count
 frmXYDisplay!gphXY.NumSets = 1
 frmXYDisplay!gphXY.ThisSet = 1
 mode = BROWSE
 xysetupload
 frmXYDisplay.Show 1
End If
End If
Close #29
' --------------------------------------------------------
End Select
cmdAcquire.Caption = "ACQUIRE"
frmSCAN!panelInfo.ForeColor = 0

End If
End Sub

Private Sub cmdCancel_Click()
gQUIT = 1: frameSaveOptions.Visible = False

End Sub

Private Sub cmdOnScreen_Click()
For i% = 0 To 3
If timewindow(i%) > rec_on_screen% Then
timewindow(i%) = Int(rec_on_screen% / (i% + 1))
showtimewindow i%
CheckTimeWindowOrdering i%
End If
Next
DisplayTimeWindowInfo
End Sub

Private Sub cmdSaveOptionsOK_Click()
gQUIT = 0: frameSaveOptions.Visible = False

End Sub

Private Sub cmdZoom_Click()
Dim yoffset As Single, ystep As Single
If cmdZoom.Caption = "Zoom in" Then
' erase zoom area box and disable buttons
picTrace.DrawMode = 6
picTrace.Line (startx, starty)-(curx, cury), , B
cmdZoom.Enabled = False
picTrace.DrawMode = 13

' ensure that StartX,StartY define bottom-left of box
If startx > curx Then swap = curx: curx = startx: startx = swap
If starty < cury Then swap = cury: cury = starty: starty = swap

Dim maxval As Long, divisor As Integer
sweeps = (2 ^ gDIG_SWEEPS) / 256
If sweeps <> Int(sweeps) Then sweeps = Int(sweeps + 1)

picTrace.Scale (startx, starty)-(curx, cury)

frmTrace.Cls

' number axes
xposn = picTrace.Left + picTrace.Width + 100
ystep = (starty - cury) / (screen_to_mV_ratio * 8)
yoffset = cury / screen_to_mV_ratio
For Y = 0 To 8
yposn = (Y / 8) * (frmTrace!picTrace.Height) + frmTrace!picTrace.Top - 90
CurrentX = xposn
CurrentY = yposn
Print Format$(((8 - Y) * ystep) + yoffset, "####0.0")
Next

yposn = picTrace.Top + picTrace.Height + 100
maxval = rec_on_screen%: maxval = maxval * gDIG_SAMPLEPER
If maxval >= 10000 Then divisor = 1000: txtTime = "Time/microseconds" Else divisor = 1: txtTime = "Time/nanoseconds"
For X = startx To curx Step ((curx - startx) / 10)
x1 = Int(X * gDIG_SAMPLEPER / divisor)
xposn = ((X - startx) / (curx - startx)) * (picTrace.Width) + picTrace.Left - 50 * Len(Str$(x1))
CurrentX = xposn
CurrentY = yposn
Print Str$(x1)
Next
DisplayTraces
cmdZoom.Caption = "Zoom out"
cmdZoom.Enabled = True

Else
setscale
DisplayTraces
cmdZoom.Caption = "Zoom in"
End If
End Sub

Private Function DigitalToVolts(dat)
DigitalToVolts = Int(dat * Val(txtFullScale) / 256)
End Function

Private Sub DisplayCursorInfo()
For cursor = 0 To 1
labCursorX(cursor) = Str$(cursorx(cursor) * gDIG_SAMPLEPER)
labCursorY(cursor) = Str$(DigitalToVolts(cursory(cursor)))
Next
labCursorX(2) = Str$(Abs(cursorx(0) - cursorx(1)) * gDIG_SAMPLEPER)
labCursorY(2) = Str$(Abs(DigitalToVolts(cursory(0)) - DigitalToVolts(cursory(1))))
End Sub

Private Sub DisplayTimeWindowInfo()
For timewin = 0 To 3
labTimeWindow(timewin) = Str$(timewindow(timewin) * gDIG_SAMPLEPER)
Next
For i% = 0 To 1
labWindowWidth(i%) = Str$(Abs(timewindow(i% * 2 + 1) - timewindow(i% * 2)) * gDIG_SAMPLEPER) + " ns"
Next
trace_for_level = 2
labWindowVoltage(1) = Format$(TimeIntegral(1), "###0.00") + " mV"
labWindowVoltage(0) = Format$(TimeIntegral(0) - TimeIntegral(1), "###0.00") + " mV"
End Sub

Private Sub DisplayTraces()
SaturationWarning.Visible = (satval% = 1)
ToolsOff display_mode
picTrace.Cls
For i% = 0 To 2
If (cmbTraceType(i%).ListIndex > 0 Or i% = 2) And chkShowTrace(i%).Value = True Then
showtrace frmTrace!picTrace, i%, tracecolour(i%)
End If
Next

ToolsOn display_mode
End Sub

Private Sub Form_Activate()
SetupDigitiser
UpdateSetupWindow
setscale
End Sub

Private Sub Form_Load()
cmbTimeBase.AddItem "10"
cmbTimeBase.AddItem "20"
cmbTimeBase.AddItem "50"
cmbTimeBase.AddItem "100"
cmbTimeBase.AddItem "200"
cmbTimeBase.AddItem "500"
cmbTimeBase.AddItem "1000"
cmbTimeBase.AddItem "2000"
cmbTimeBase.AddItem "5000"

cmbVolts.AddItem "0.5"
cmbVolts.AddItem "1"
cmbVolts.AddItem "2"
cmbVolts.AddItem "5"
cmbVolts.AddItem "10"
cmbVolts.AddItem "20"
cmbVolts.AddItem "50"
cmbVolts.AddItem "100"
cmbVolts.AddItem "200"
cmbVolts.AddItem "500"
cmbVolts.AddItem "1000"

For i% = 0 To 1
cmbTraceType(i%).AddItem "(none)"
cmbTraceType(i%).AddItem "+ve bias (switch)"
cmbTraceType(i%).AddItem "-ve bias (switch)"
cmbTraceType(i%).AddItem "+ve bias (boxcar)"
cmbTraceType(i%).AddItem "-ve bias (boxcar)"
Next
cmbTraceType(1).AddItem "zero bias"
cmbTraceType(0).ListIndex = 2
cmbTraceType(1).ListIndex = 1


cmbTraceType(2).AddItem "Copy 1"
cmbTraceType(2).AddItem "Copy 2"
cmbTraceType(2).AddItem "Subtract: 1-2"
cmbTraceType(2).AddItem "Subtract: 2-1"
cmbTraceType(2).AddItem "Add: 1+2"
cmbTraceType(2).AddItem "Differentiate 1"
cmbTraceType(2).AddItem "Differentiate 2"
cmbTraceType(2).AddItem "Integrate 1"
cmbTraceType(2).AddItem "Integrate 2"
cmbTraceType(2).AddItem "Sub: 1-zerobias"
cmbTraceType(2).ListIndex = 0

SetupDigitiser
frmTrace!cmbVolts.ListIndex = Val(GetINIString("Digitiser", "Y-Volts"))
frmTrace!cmbTimeBase.ListIndex = Val(GetINIString("Digitiser", "TimeBase"))
For i% = 0 To 3
timewindow(i%) = Val(GetINIString("Trace", "TimeWin" + Format$(i% + 1, "0")))
Next
For i% = 0 To 2
cmbTraceType(i%).ListIndex = Val(GetINIString("Trace", "TraceType" + Format$(i% + 1, "0")))
Next

picTrace.DrawMode = 13
tracecolour(0) = YELLOW
tracecolour(1) = Red
tracecolour(2) = WHITE

picCursor(0).ForeColor = MAGENTA
picCursor(1).ForeColor = CYAN
For i% = 0 To 1
picCursor(i%).ScaleHeight = 10: picCursor(i%).ScaleWidth = 12
picCursor(i%).AutoRedraw = True
picCursor(i%).Line (1, 5)-(9, 5)
picCursor(i%).Line (5, 1)-(5, 9)
picCursor(i%).AutoRedraw = False
Next

picTrace.Scale (0, 0)-(10, 8)
For X% = 0 To 10
For Y% = 0 To 8
picTrace.Line (0, Y%)-(10, Y%)
picTrace.Line (X%, 0)-(X%, 8)
Next: Next
picTrace.AutoRedraw = False

CentreForm Me

cmbDisplay.AddItem "Zoom window"
cmbDisplay.AddItem "Cursors"
cmbDisplay.AddItem "Time gating"
cmbDisplay.ListIndex = 0

cursorx(0) = 50: cursory(0) = 100
cursorx(1) = 100: cursory(1) = 80
hardware_sweeps = 1
software_sweeps = 1
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
frmSCAN!panelInfo.ForeColor = 0
frmSCAN!panelInfo = "SCAN"
SaveTraceSettings
End Sub

Private Sub mnuAttenuate_Click()
frmAttenuate.Show 1
DisplayTraces
End Sub

Private Sub mnuDisplay_Click(Index As Integer)
For i% = 0 To 2
If i% = Index Then
cmbDisplay.ListIndex = i%
End If
Next
End Sub

Private Sub mnuexit_Click()
gQUIT = 1
cmdAcquire.Caption = "ACQUIRE"
SaveTraceSettings
frmTrace.Hide
End Sub

Private Sub mnuGate_Click()
frmdvs.Show 1
DisplayTraces
End Sub

Private Sub mnuPrint_Click()
Call PrintPicBox(picTrace)
End Sub

Private Sub mnusave_Click()
Dim timeaxis As Single, voltaxis As Single
gDATA_TYPE = xysave
frmFileIO.Caption = "Save Digitiser data (XY Plot format)"

savedirectory = CheckPresent(gDATdir)
ChDir savedirectory
frmFileIO!lstDirectory.Path = savedirectory
frmFileIO!frameSaveFile.Enabled = True
frmFileIO!frameFiles.Enabled = False
frmFileIO!frameSelectedFile.Enabled = False
frmFileIO!txtSaveDirectory = savedirectory
gQUIT = 0
frmFileIO.Show 1
If gQUIT <> 1 Then
frmSCAN!panelInfo.ForeColor = &HFF
frmSCAN!panelInfo = "Saving digitiser trace as XY Plot data..."
datasavefile = file + ".dat"
savedirectory = frmFileIO!lstDirectory.Path
ChDir savedirectory
SaveDigitiserTrace 2, datasavefile
frmSCAN!panelInfo.ForeColor = 0
frmSCAN!panelInfo = "SCAN"

End If
DisplayTraces

End Sub

Private Sub mnuSetupDigitiser_Click()
frmDigSetup.Show 1
DisplayTraces
End Sub

Private Sub mnuSetupPulse_Click()
frmPulse.Show 1
DisplayTraces
End Sub

Private Sub picTrace_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

Select Case Button

Case 1
' Left button
Select Case cmbDisplay.ListIndex
Case 1
' Cursors
SetCursor CLng(X), CLng(Y)
Case 2
' Time gating
SetTimeWindow CInt(X)
Case 0
' zoom window
zoommode = 1
startx = X: starty = Y: curx = X: cury = Y
picTrace.DrawMode = 6
picTrace.FillStyle = 1
picTrace.Line (startx, starty)-(curx, cury), , B
End Select

Case Else
' Right button: toggle display device
X = cmbDisplay.ListIndex: X = X + 1
If X > 2 Then X = 0
cmbDisplay.ListIndex = X
End Select
End Sub

Private Sub picTrace_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
If zoommode = 1 Then
picTrace.Line (startx, starty)-(curx, cury), , B
curx = X: cury = Y
picTrace.Line (startx, starty)-(curx, cury), , B
End If
End Sub

Private Sub picTrace_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
zoommode = 0
If (curx <> startx) Or (cury <> starty) Then cmdZoom.Enabled = True
picTrace.DrawMode = 13
End Sub

Private Sub SaveDigitiserTrace(trace As Integer, filename As String)
Open filename For Output As #1
For i% = 0 To rec_on_screen% - 1
timeaxis = CLng(i%) * gDIG_SAMPLEPER
voltaxis = hidata(trace, i%) / screen_to_mV_ratio
Print #1, timeaxis, voltaxis
Next
Close #1

End Sub

Private Sub SaveTraceSettings()
Dim volts As Integer, timebase As Integer
volts = cmbVolts.ListIndex
timebase = cmbTimeBase.ListIndex
section$ = "Trace"
For i% = 0 To 3
ret% = WritePrivateProfileString(ByVal section$, ByVal "TimeWin" + Format$(i% + 1, "0"), ByVal Str$(timewindow(i%)), ByVal "c:\scan\scan.ini")
Next
For i% = 0 To 2
tracetype = cmbTraceType(i%).ListIndex
ret% = WritePrivateProfileString(ByVal section$, ByVal "TraceType" + Format$(i% + 1, "0"), ByVal Str$(tracetype), ByVal "c:\scan\scan.ini")
Next
section$ = "Digitiser"
ret% = WritePrivateProfileString(ByVal section$, ByVal "Y-Volts", ByVal Str$(volts), ByVal "c:\scan\scan.ini")
ret% = WritePrivateProfileString(ByVal section$, ByVal "TimeBase", ByVal Str$(timebase), ByVal "c:\scan\scan.ini")

End Sub

Private Sub SetCursor(xpos As Long, ypos As Long)
' see which cursor the current position is closest to
Dim temp As Single
temp = ypos / screen_to_mV_ratio

For i% = 0 To 1
xdis = Abs(xpos - cursorx(i%)): ydis = Abs(ypos - cursory(i%))
dis(i%) = xdis ^ 2 + ydis ^ 2
Next: If dis(0) < dis(1) Then cursor = 0 Else cursor = 1

' delete old cursor
ShowCursor cursor

cursorx(cursor) = xpos: cursory(cursor) = ypos
DisplayCursorInfo
' print new cursor
ShowCursor cursor
End Sub

Private Sub setscale()
Dim maxval As Long, divisor As Integer, ystep As Single
Dim tmp As Integer
Dim x1 As Single
'hardware_sweeps = 1 'sc
'sweeps = (2 ^ gDIG_SWEEPS) / 256
'If sweeps <> Int(sweeps) And sweeps > 1 Then sweeps = Int(sweeps + 1)
If hardware_sweeps < 256 Then tmp = hardware_sweeps Else tmp = 256
size_of_scale = Val(frmTrace!cmbVolts.Text) * tmp * software_sweeps * 2048 * 0.01 / (gDIG_FULLSCALE)
screen_to_mV_ratio = size_of_scale / (Val(frmTrace!cmbVolts.Text) * 8)
scale_offset = size_of_scale * (gDIG_AMPOFFSET / (100))
frmTrace!picTrace.Scale (0, size_of_scale - scale_offset)-(rec_on_screen%, -scale_offset)

frmTrace.Cls

' number axes
xposn = frmTrace!picTrace.Left + frmTrace!picTrace.Width + 100
ystep = Val(frmTrace!cmbVolts.Text): yoffset = (ystep * 8) * (gDIG_AMPOFFSET / 100)
For Y = 0 To 8
yposn = (Y / 8) * (frmTrace!picTrace.Height) + frmTrace!picTrace.Top - 90
frmTrace.CurrentX = xposn
frmTrace.CurrentY = yposn
frmTrace.Print Str$(((8 - Y) * ystep) - yoffset)
Next

yposn = picTrace.Top + picTrace.Height + 100
maxval = rec_on_screen%: maxval = maxval * gDIG_SAMPLEPER
If maxval >= 10000 Then divisor = 1000: txtTime = "Time/microseconds" Else divisor = 1: txtTime = "Time/nanoseconds"


For X = 0 To 10
x1 = X * Val(cmbTimeBase.Text)
xposn = (X / 10) * (frmTrace!picTrace.Width) + frmTrace!picTrace.Left - 50 * Len(Str$(x1))
frmTrace.CurrentX = xposn
frmTrace.CurrentY = yposn
frmTrace.Print Str$(x1)
Next

End Sub

Private Sub SetTimeWindow(timeaxis As Integer)
Dim dist As Single, mindist As Single

' determine which of the existing time window lines
' the user has clicked closest to; this is the one
' we'll move.
mindist = 100000000#
For i% = -2 * (chkLock(0).Value = True) To (3 + 2 * (chkLock(1).Value = True))
dist = Abs(timewindow(i%) - timeaxis)
If dist < mindist Then mindist = dist: timewin = i%
Next

' Delete old line
showtimewindow timewin

' Draw new one
timewindow(timewin) = timeaxis
showtimewindow timewin

CheckTimeWindowOrdering timewin

DisplayTimeWindowInfo
End Sub

Private Sub ShowCursor(cursor)
Exit Sub
Dim scaleX As Single, scaleY As Single
scaleX = picTrace.ScaleWidth / 50
scaleY = (picTrace.ScaleHeight / 50) * (picTrace.Width / picTrace.Height)
If cursor = 1 Then picTrace.ForeColor = CYAN Else picTrace.ForeColor = MAGENTA
picTrace.DrawMode = 7
picTrace.Line (cursorx(cursor) - scaleX, software_sweeps * hardware_sweeps * cursory(cursor))-(cursorx(cursor) + scaleX, software_sweeps * hardware_sweeps * cursory(cursor))
picTrace.Line (cursorx(cursor), (software_sweeps * hardware_sweeps * cursory(cursor)) - scaleY)-(cursorx(cursor), (software_sweeps * hardware_sweeps * cursory(cursor)) + scaleY)
picTrace.DrawMode = 13
End Sub

Private Sub showtimewindow(timewin)
Dim colour As Long
picTrace.DrawMode = 7
If timewin < 2 Then colour = BLUE Else colour = &H808080
picTrace.Line (timewindow(timewin), picTrace.ScaleHeight)-(timewindow(timewin), -picTrace.ScaleHeight), colour
picTrace.DrawMode = 13
End Sub

Private Sub ToolsOff(mode As Integer)
Select Case mode
Case 1
' cursors
For i% = 0 To 1
ShowCursor i%
Next
DisplayCursorInfo

Case 2
' time gating
For i% = 0 To 3
showtimewindow i%
Next
DisplayTimeWindowInfo

End Select
End Sub

Private Sub ToolsOn(mode As Integer)
Select Case mode
Case 1
' cursors
For i% = 0 To 1
ShowCursor i%
Next
DisplayCursorInfo

Case 2
' time gating
For i% = 0 To 3
showtimewindow i%
Next
DisplayTimeWindowInfo

End Select
End Sub

Private Sub text1_Change()

End Sub


