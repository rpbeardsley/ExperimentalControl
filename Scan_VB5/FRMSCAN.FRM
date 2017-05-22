VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.0#0"; "MSCOMM32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.MDIForm frmSCAN 
   Appearance      =   0  'Flat
   BackColor       =   &H8000000C&
   Caption         =   "Scan-Turbo"
   ClientHeight    =   5730
   ClientLeft      =   2895
   ClientTop       =   2940
   ClientWidth     =   10095
   HelpContextID   =   10
   LinkTopic       =   "MDIForm1"
   ScrollBars      =   0   'False
   WindowState     =   2  'Maximized
   Begin VB.PictureBox Picture1 
      Align           =   1  'Align Top
      Appearance      =   0  'Flat
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
      ForeColor       =   &H80000008&
      Height          =   8415
      Left            =   0
      ScaleHeight     =   8415
      ScaleWidth      =   10095
      TabIndex        =   1
      Top             =   0
      Width           =   10095
      Begin Threed.SSPanel panelMail 
         Height          =   405
         Left            =   9870
         TabIndex        =   28
         Top             =   8040
         Width           =   1155
         _Version        =   65536
         _ExtentX        =   2037
         _ExtentY        =   714
         _StockProps     =   15
         ForeColor       =   16711680
         BackColor       =   14737632
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   2
         BorderWidth     =   2
         BevelOuter      =   0
         BevelInner      =   1
         Outline         =   -1  'True
         ShadowColor     =   1
      End
      Begin VB.Timer Clock 
         Interval        =   30000
         Left            =   30
         Top             =   660
      End
      Begin Threed.SSPanel panelTools 
         Height          =   525
         Left            =   0
         TabIndex        =   13
         Top             =   -30
         Width           =   12015
         _Version        =   65536
         _ExtentX        =   21193
         _ExtentY        =   926
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
         BevelOuter      =   1
         BevelInner      =   2
         RoundedCorners  =   0   'False
         Outline         =   -1  'True
         ShadowColor     =   1
         Alignment       =   6
         Begin VB.PictureBox picClock 
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
            Height          =   315
            Left            =   11130
            ScaleHeight     =   0.503
            ScaleMode       =   0  'User
            ScaleWidth      =   1.296
            TabIndex        =   29
            Top             =   120
            Width           =   765
         End
         Begin VB.Label Label15 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Time:"
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
            Left            =   10620
            TabIndex        =   30
            Top             =   180
            Width           =   495
         End
         Begin VB.Label Label8 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Help:"
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
            Left            =   5970
            TabIndex        =   16
            Top             =   150
            Width           =   465
         End
         Begin VB.Image imgAbout 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   6810
            Picture         =   "FRMSCAN.frx":0000
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgMirror 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   4200
            Picture         =   "FRMSCAN.frx":018A
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgScope 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   1830
            Picture         =   "FRMSCAN.frx":0314
            Top             =   90
            Width           =   360
         End
         Begin VB.Label Label7 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Setup:"
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
            Left            =   2400
            TabIndex        =   15
            Top             =   150
            Width           =   525
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Expt:"
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
            Left            =   150
            TabIndex        =   14
            Top             =   150
            Width           =   435
         End
         Begin VB.Image imgDMM1 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   2940
            Picture         =   "FRMSCAN.frx":049E
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgDMM2 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   3360
            Picture         =   "FRMSCAN.frx":0628
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgMagnet 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   3780
            Picture         =   "FRMSCAN.frx":07B2
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgHelp 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   6390
            Picture         =   "FRMSCAN.frx":093C
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgXYPlot 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   570
            Picture         =   "FRMSCAN.frx":0AC6
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgImageScan 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   990
            Picture         =   "FRMSCAN.frx":0C50
            Top             =   90
            Width           =   360
         End
         Begin VB.Image imgTrace 
            Appearance      =   0  'Flat
            Height          =   330
            Left            =   1410
            Picture         =   "FRMSCAN.frx":0DDA
            Top             =   90
            Width           =   360
         End
      End
      Begin Threed.SSPanel panelUser 
         Height          =   405
         Left            =   11010
         TabIndex        =   9
         Top             =   8040
         Width           =   1035
         _Version        =   65536
         _ExtentX        =   1826
         _ExtentY        =   714
         _StockProps     =   15
         ForeColor       =   16711680
         BackColor       =   14737632
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   2
         BorderWidth     =   2
         BevelOuter      =   0
         BevelInner      =   1
         Outline         =   -1  'True
         ShadowColor     =   1
      End
      Begin Threed.SSPanel panelInfo 
         Height          =   405
         Left            =   -30
         TabIndex        =   7
         Top             =   8040
         Width           =   9915
         _Version        =   65536
         _ExtentX        =   17489
         _ExtentY        =   714
         _StockProps     =   15
         ForeColor       =   0
         BackColor       =   14737632
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   2
         BorderWidth     =   2
         BevelOuter      =   0
         BevelInner      =   1
         Outline         =   -1  'True
         ShadowColor     =   1
      End
      Begin VB.Timer Pause 
         Enabled         =   0   'False
         Left            =   450
         Top             =   660
      End
      Begin Threed.SSFrame frameCredits 
         Height          =   4245
         Left            =   1860
         TabIndex        =   2
         Top             =   1590
         Visible         =   0   'False
         Width           =   8445
         _Version        =   65536
         _ExtentX        =   14896
         _ExtentY        =   7488
         _StockProps     =   14
         Caption         =   "Image Scanning Control Software"
         ForeColor       =   32768
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
         ShadowColor     =   1
         Begin VB.PictureBox picVersion 
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
            Height          =   315
            Left            =   7230
            ScaleHeight     =   0.503
            ScaleMode       =   0  'User
            ScaleWidth      =   1.825
            TabIndex        =   33
            Top             =   210
            Width           =   1065
         End
         Begin Threed.SSFrame Frame3D1 
            Height          =   1935
            Left            =   330
            TabIndex        =   3
            Top             =   480
            Width           =   4275
            _Version        =   65536
            _ExtentX        =   7541
            _ExtentY        =   3413
            _StockProps     =   14
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
            ShadowColor     =   1
            ShadowStyle     =   1
            Begin VB.Label RecordSpeed 
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
               ForeColor       =   &H00FF0000&
               Height          =   255
               Left            =   1470
               TabIndex        =   20
               Top             =   1380
               Width           =   2715
            End
            Begin VB.Label Label9 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Record speed:"
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
               Height          =   255
               Left            =   180
               TabIndex        =   21
               Top             =   1380
               Width           =   1275
            End
            Begin VB.Label txtUser 
               Alignment       =   2  'Center
               Appearance      =   0  'Flat
               BackColor       =   &H00FFFFFF&
               BorderStyle     =   1  'Fixed Single
               Caption         =   "dflt"
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
               Left            =   2790
               TabIndex        =   22
               Top             =   720
               Width           =   615
               WordWrap        =   -1  'True
            End
            Begin VB.Label Label1 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Welcome to SCAN-Turbo!"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   12
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000008&
               Height          =   315
               Left            =   1200
               TabIndex        =   17
               Top             =   330
               Width           =   2925
            End
            Begin VB.Image imgLogo 
               Appearance      =   0  'Flat
               BorderStyle     =   1  'Fixed Single
               Height          =   840
               Index           =   0
               Left            =   180
               Picture         =   "FRMSCAN.frx":0F64
               Top             =   270
               Width           =   870
            End
            Begin VB.Label Label4 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Current user:"
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
               Height          =   255
               Left            =   1620
               TabIndex        =   18
               Top             =   720
               Width           =   1155
            End
         End
         Begin Threed.SSFrame frameCheck 
            Height          =   2505
            Left            =   4890
            TabIndex        =   24
            Top             =   780
            Width           =   3315
            _Version        =   65536
            _ExtentX        =   5847
            _ExtentY        =   4419
            _StockProps     =   14
            Caption         =   "Checklist"
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
            ShadowColor     =   1
            Begin Threed.SSCheck chkHardware 
               Height          =   225
               Index           =   1
               Left            =   2700
               TabIndex        =   19
               Top             =   600
               Width           =   225
               _Version        =   65536
               _ExtentX        =   397
               _ExtentY        =   397
               _StockProps     =   78
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
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
            Begin Threed.SSCheck chkHardware 
               Height          =   210
               Index           =   0
               Left            =   2700
               TabIndex        =   26
               Top             =   330
               Width           =   225
               _Version        =   65536
               _ExtentX        =   397
               _ExtentY        =   370
               _StockProps     =   78
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   6
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Enabled         =   0   'False
               Alignment       =   1
               Font3D          =   3
            End
            Begin VB.Label labScreenWidth 
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
               Left            =   2190
               TabIndex        =   31
               Top             =   1500
               Width           =   945
            End
            Begin VB.Label labScreenHeight 
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
               Left            =   2190
               TabIndex        =   32
               Top             =   1800
               Width           =   945
            End
            Begin VB.Label labScreenColours 
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
               Left            =   2190
               TabIndex        =   10
               Top             =   2100
               Width           =   945
            End
            Begin VB.Label Label21 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Screen width (pixels):"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000C0&
               Height          =   225
               Left            =   120
               TabIndex        =   11
               Top             =   1500
               Width           =   1965
            End
            Begin VB.Label Label20 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Screen height (pixels):"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000C0&
               Height          =   225
               Left            =   120
               TabIndex        =   23
               Top             =   1800
               Width           =   1905
            End
            Begin VB.Label Label18 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Screen colours:"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000C0&
               Height          =   225
               Left            =   120
               TabIndex        =   12
               Top             =   2100
               Width           =   1695
            End
            Begin VB.Label Label10 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "Mirror drive unit present"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000C0&
               Height          =   225
               Left            =   120
               TabIndex        =   27
               Top             =   600
               Width           =   2205
            End
            Begin VB.Label Label14 
               Appearance      =   0  'Flat
               BackColor       =   &H00C0C0C0&
               Caption         =   "IEEE interface loaded"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H000000C0&
               Height          =   225
               Left            =   120
               TabIndex        =   25
               Top             =   300
               Width           =   2175
            End
         End
         Begin VB.TextBox Text1 
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
            ForeColor       =   &H00808000&
            Height          =   255
            Left            =   6480
            TabIndex        =   8
            Text            =   "Version:"
            Top             =   270
            Width           =   735
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
            Height          =   255
            Left            =   5820
            TabIndex        =   0
            Top             =   3750
            Width           =   1515
         End
         Begin VB.TextBox txtAuthors 
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
            Height          =   615
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   5
            Top             =   3390
            Width           =   4605
         End
         Begin VB.Label Label3 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   "For introductory help, click on the menu above."
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
            Left            =   4890
            TabIndex        =   6
            Top             =   3450
            Width           =   3465
         End
         Begin VB.Label Label2 
            Alignment       =   2  'Center
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            Caption         =   $"FRMSCAN.frx":1F76
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
            Height          =   705
            Left            =   150
            TabIndex        =   4
            Top             =   2610
            Width           =   4455
         End
      End
      Begin MSCommLib.MSComm Comm1 
         Left            =   870
         Top             =   660
         _Version        =   65536
         _ExtentX        =   847
         _ExtentY        =   847
         _StockProps     =   0
         CDTimeout       =   0
         CommPort        =   2
         CTSTimeout      =   0
         DSRTimeout      =   0
         DTREnable       =   0   'False
         Handshaking     =   0
         InBufferSize    =   1024
         InputLen        =   0
         Interval        =   1000
         NullDiscard     =   0   'False
         OutBufferSize   =   512
         ParityReplace   =   "?"
         RThreshold      =   1
         RTSEnable       =   -1  'True
         Settings        =   "9600,n,8,2"
         SThreshold      =   0
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      HelpContextID   =   210
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open SCAN datafile"
      End
      Begin VB.Menu mnuPad 
         Caption         =   "SCAN &Pad"
      End
      Begin VB.Menu mnuSeparate1 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "1:"
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "2:"
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "3: "
         Index           =   3
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "4:"
         Index           =   4
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "5:"
         Index           =   5
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "6:"
         Index           =   6
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "7:"
         Index           =   7
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "8:"
         Index           =   8
         Visible         =   0   'False
      End
      Begin VB.Menu mnuRecentFiles 
         Caption         =   "9:"
         Index           =   9
         Visible         =   0   'False
      End
      Begin VB.Menu mnuSeparate 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuExp 
      Caption         =   "&Experiment"
      HelpContextID   =   220
      Begin VB.Menu mnuImage 
         Caption         =   "&Image"
      End
      Begin VB.Menu mnuXY 
         Caption         =   "X-Y &plot"
      End
      Begin VB.Menu mnuScope1 
         Caption         =   "&Scope"
      End
      Begin VB.Menu mnueclipse 
         Caption         =   "&Eclipse"
      End
      Begin VB.Menu mnuDigitiser1 
         Caption         =   "&Digitiser"
      End
   End
   Begin VB.Menu mnuSetup 
      Caption         =   "&Setup"
      HelpContextID   =   230
      Begin VB.Menu mnuDMM1 
         Caption         =   "DMM&1"
      End
      Begin VB.Menu mnuDMM2 
         Caption         =   "DMM&2"
      End
      Begin VB.Menu mnudvs 
         Caption         =   "D&VS"
      End
      Begin VB.Menu mnuSwitchBox 
         Caption         =   "&Switch box"
      End
      Begin VB.Menu mnuPulse 
         Caption         =   "&Pulse"
      End
      Begin VB.Menu mnuAttenuate 
         Caption         =   "&Attenuator"
      End
      Begin VB.Menu mnuITC4 
         Caption         =   "&ITC4"
      End
      Begin VB.Menu mnuMagnet 
         Caption         =   "&Magnet"
      End
      Begin VB.Menu mnuMirror 
         Caption         =   "M&irrors"
      End
      Begin VB.Menu mnuDigitiser2 
         Caption         =   "&Digitiser"
      End
      Begin VB.Menu mnuScope2 
         Caption         =   "&Scope"
      End
      Begin VB.Menu mnuLockin 
         Caption         =   "&Lock-in"
      End
   End
   Begin VB.Menu mnuConfigure 
      Caption         =   "&Configure"
      HelpContextID   =   240
      Begin VB.Menu mnuDevices 
         Caption         =   "&IEEE devices"
      End
      Begin VB.Menu mnuGeneralConfig 
         Caption         =   "&General configuration"
      End
      Begin VB.Menu mnuDataFiles 
         Caption         =   "&User configuration"
      End
      Begin VB.Menu mnuINIfile 
         Caption         =   "Edit &SCAN.INI file"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      HelpContextID   =   250
      Begin VB.Menu mnuIntro 
         Caption         =   "&Introduction"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmSCAN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim inbuf$(13)

Private Sub Clock_Timer()
timr$ = Left$(Time$, 5)
displayLCD timr$, frmSCAN.picClock, &HFF00&
End Sub

Private Sub cmdContinue_Click()
FrameCredits.Visible = False
End Sub

Private Sub cmdQuit_Click()
' Make a record of the last user of the program
ret% = WritePrivateProfileString(ByVal "Misc", ByVal "CurUser", ByVal CurUser, ByVal "c:\scan\scan.ini")
End

End Sub

Private Sub imgAbout_Click()
mnuAbout_Click
End Sub

Private Sub imgAbout_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "About SCAN..."
End Sub

Private Sub imgDMM1_Click()
mnuDMM1_Click
End Sub

Private Sub imgDMM1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Set up multimeter 1"
End Sub

Private Sub imgDMM2_Click()
mnuDMM2_Click
End Sub

Private Sub imgDMM2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Set up multimeter 2"
End Sub

Private Sub imgHelp_Click()
mnuIntro_Click
End Sub

Private Sub imgHelp_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Request introductory SCAN Help"
End Sub

Private Sub imgImageScan_Click()
mnuImage_Click
End Sub

Private Sub imgImageScan_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo.Caption = "Perform an Image Scan experiment"
End Sub

Private Sub imgMagnet_Click()
mnuMagnet_Click
End Sub

Private Sub imgMagnet_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Set up magnetic field sweep parameters"
End Sub

Private Sub imgMirror_Click()
mnuMirror_Click
End Sub

Private Sub imgMirror_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Set up image-scan control mirrors"
End Sub

Private Sub imgScope_Click()
mnueclipse_Click
End Sub

Private Sub imgScope_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Use Eclipse DSA"
End Sub

Private Sub imgTrace_Click()
mnuDigitiser1_Click
End Sub

Private Sub imgTrace_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Perform a digitiser trace experiment"
End Sub

Private Sub imgXYPlot_Click()
mnuXY_Click
End Sub

Private Sub imgXYPlot_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
panelInfo = "Perform an XY Plot of two swept parameters"
End Sub

Private Sub MDIForm_Activate()
picVersion.AutoRedraw = True
displayLCD "04-11-04", frmSCAN!picVersion, &HFF&
picVersion.AutoRedraw = False
panelInfo = "SCAN"
Clock_Timer
End Sub

Private Sub MDIForm_Load()
      Dim hSysMenu%, r%, j%, dw&, rr&
      Dim sc As Long
      Const MF_BYPOSITION = &H400
      ' Me refers to the form where code is currently executing:
      hSysMenu = GetSystemMenu(Me.hWnd, 0)
      For j = 7 To 0 Step -1
         r = RemoveMenu(hSysMenu, j, MF_BYPOSITION)
      Next j
      ' Leave the Switch To item only

      dw& = GetWindowLong(Me.hWnd, -16)   'Window style
      dw& = dw& And &HFFF8FFFF
      rr& = SetWindowLong(Me.hWnd, -16, dw&)

' masks for digits 0-9 in LCD display
mask(0) = 119
mask(1) = 96
mask(2) = 62
mask(3) = 124
mask(4) = 105
mask(5) = 93
mask(6) = 95
mask(7) = 100
mask(8) = 127
mask(9) = 125


' initialise COM2 connection to scanning mirrors
'frmSCAN!Comm1.CommPort = 2
'frmSCAN!Comm1.PortOpen = True
'frmSCAN!Comm1.RTSEnable = True

' See if the mirrors are working..
 '  Comm1.Output = "" + Chr$(13)
While sc < 1000000
sc = sc + 1
Wend
   'pause 100  'pause for 100msec
    'X$ = Comm1.Input
   'If InStr(X$, ">") Then
    'chkHardware(1).Value = True
   'Else
    'chkHardware(1).Value = False
    'nomirrors = True
   'End If

' load global variables from c:\scan\scan.ini

' [Recent files]
For i% = 1 To 9
recentfile$(i%) = GetINIString("Recent files", Format$(i%, "0"))
mnuRecentFiles(i%).Caption = "&" + Format$(i%, "0") + "  " + recentfile$(i%)
If recentfile$(i%) <> "" Then mnuRecentFiles(i%).Visible = True: mnuSeparate1.Visible = True Else mnuRecentFiles(i%).Visible = False
Next


' [Digitiser]
digitiser = 9825
BaseAddr% = &H300
MBAddr% = BaseAddr% + 3
gDIG_THRESHOLD = Val(GetINIString("Digitiser", "gDIG_THRESHOLD"))
gDIG_SAMPLEPER = Val(GetINIString("Digitiser", "gDIG_SAMPLEPER"))
gDIG_RECORDLEN = Val(GetINIString("Digitiser", "gDIG_RECORDLEN"))
gDIG_AMPOFFSET = Val(GetINIString("Digitiser", "gDIG_AMPOFFSET"))
gDIG_FULLSCALE = Val(GetINIString("Digitiser", "gDIG_FULLSCALE"))
gDIG_SWEEPS = Val(GetINIString("Digitiser", "gDIG_SWEEPS"))
gDIG_TRIGFALL = Val(GetINIString("Digitiser", "gDIG_TRIGFALL"))
gDIG_INPIMP50 = Val(GetINIString("Digitiser", "gDIG_INPIMP50"))
recspeed = Val(GetINIString("Digitiser", "Record speed"))
RecordSpeed = Format$(recspeed, "######0.0") + " sweeps per second."
ignore = Val(GetINIString("Digitiser", "Reads to ignore"))
whichgate = Val(GetINIString("Digitiser", "Gate Type"))

' [IntelliGATE]
section$ = "IntelliGATE"
int_PulseTime = Val(GetINIString(section$, "PulseTime"))
int_ModeSpeed = Val(GetINIString(section$, "ModeSpeed"))
int_WaferThickness = Val(GetINIString(section$, "WaferThickness"))
int_GateWidth = Val(GetINIString(section$, "GateWidth"))
int_xoffset = Val(GetINIString(section$, "xoffset"))
int_yoffset = Val(GetINIString(section$, "yoffset"))
int_fscfactor = Val(GetINIString(section$, "fscfactor"))
' [IEEE]
ReDim ieeeaddr(9), IEEEname(9)
For i% = 0 To 8
ad$ = "IEEEaddr(" + Format$(i%, "0") + ")"
ad1$ = "IEEEname(" + Format$(i%, "0") + ")"
ieeeaddr(i%) = GetINIInt("IEEE", ad$)
IEEEname(i%) = GetINIString("IEEE", ad1$)
Next

configureLCD frmSCAN!picClock, 5
configureLCD frmSCAN!picVersion, 8

 A5% = CreateIC("DISPLAY", "", "", 0&)
 z1% = Get_Device_Information(A5%)
 finished% = DeleteDC(A5%)
    
    SendIEEECmd ("TO 8 END=ON EOS=10")
    datasaved = 255: gQUIT = False

NL = Chr$(13) + Chr$(10)
txtAuthors.Text = "Development and coding:" + NL + "Andy Cross , Ver 1.0.  " + "Stuart Cavill, Ver 2.0."

bias_direction = -1
FrameCredits.Visible = True
Show
c = Timer

' check for IEEE Driver presence
'ret% = Pro488Present()
chkHardware(0).Value = False
If ret% <> -1 Then chkHardware(0).Value = True

' [User]
CurUser = GetINIString("Misc", "CurUser")
If CurUser = "" Then CurUser = "DFLT"
txtUser = CurUser: panelUser.Caption = CurUser

' load in preferred directories/colours etc for CurUser
LoadUserSettings CurUser
savedirectory = gDATdir

Do
DoEvents
Loop Until Timer > c + 4
FrameCredits.Visible = False

End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
QuitProgram
End Sub

Private Sub mnuAbout_Click()
FrameCredits.Visible = True
End Sub

Private Sub mnuAttenuate_Click()
frmAttenuate.Show 1
End Sub

Private Sub mnudvs_Click()
frmdvs.Show 1
End Sub

Private Sub mnuConfigure_Click()
panelInfo.Caption = "Change IEEE bus settings, or individual user program preferences."
End Sub

Private Sub mnuDataFiles_Click()
frmUserConfig.Show 1
End Sub

Private Sub mnuDevices_Click()
frmDevice.Show 1
End Sub

Private Sub mnuDigitiser1_Click()
frmTrace.Show 1
End Sub

Private Sub mnuDigitiser2_Click()
frmDigSetup.Show 1
End Sub

Private Sub mnuDMM1_Click()
If Spoll(dmm1) = 0 Then MsgBox "DMM1 not found at IEEE address" + Str$(ieeeaddr(dmm1)) + "." + NL + "Go to 'Configure | Devices Present' to locate device.", MB_ICONEXCLAMATION, "SCAN Error": Exit Sub
dev% = dmm1
dmm% = 1
frmDvm1Setup.Show 1
End Sub

Private Sub mnuDMM2_Click()
If Spoll(dmm2) = 0 Then MsgBox "DMM2 not found at IEEE address" + Str$(ieeeaddr(dmm2)) + "." + NL + "Go to 'Configure | Devices Present' to locate device.", MB_ICONEXCLAMATION, "SCAN Error": Exit Sub
dev% = dmm2
dmm% = 2
frmDvm1Setup.Show 1
End Sub

Private Sub mnueclipse_Click()
frmeclipse.Show 1
End Sub

Private Sub mnuexit_Click()
QuitProgram
End Sub

Private Sub mnuExp_Click()
panelInfo.Caption = "Perform an XY Plot, laser scan or digitiser trace experiment"
End Sub

Private Sub mnuFile_Click()
panelInfo.Caption = "Open a previously saved data file, or leave program."
End Sub

Private Sub mnuGeneralConfig_Click()
frmGenConfig.Show 1
End Sub

Private Sub mnuHelp_Click()
panelInfo.Caption = "Obtain help and program information."

End Sub

Private Sub mnuImage_Click()
frmImageSetup.Show 1
End Sub

Private Sub mnuINIfile_Click()
frmPad.Tag = "edit:c:\scan\scan.ini"
frmPad.Show 1
End Sub

Private Sub mnuIntro_Click()
txt$ = "The Scan program is designed for use in a dual purpose role:" + NL + NL
txt$ = txt$ + "Firstly, as a general experimental control program; taking input from IEEE-connected "
txt$ = txt$ + "measurement devices (DVMs, etc) and plotting graphs from the results obtained. To perform "
txt$ = txt$ + "such an experiment, click on 'XY Plot' on the 'Experiment' sub-menu." + NL + NL
txt$ = txt$ + "The Scan software's more specialised role is in the control of a laser raster-scanning system, "
txt$ = txt$ + "which requires both output (controlling the focussing mirrors) and input (measurement of intensity) "
txt$ = txt$ + "from the computer, and produces a colour-map of a sample's surface. This function is accessed through "
txt$ = txt$ + "the 'Image' option on the 'Experiment' submenu." + NL + NL
txt$ = txt$ + "Additionally, the software is currently being tested in co-ordination with a 9845 digitiser board, "
txt$ = txt$ + "enabling oscilloscope-like traces to be displayed on screen, to detect phonon emission/reflection, etc."
txt$ = txt$ + "This function is currently 'in stasis', awaiting an improved digitiser board which will allow on-board "
txt$ = txt$ + "averaging to be done." + NL + NL
txt$ = txt$ + "Further help files are available for certain parts of the program, by way of a 'Help' button on the "
txt$ = txt$ + "screen in question." + NL + NL
txt$ = txt$ + "Configuration of preferences for colours, directories, etc, can be made for up to 6 different users, "
txt$ = txt$ + "through the 'Configure | User Configuration' menu; when initially loaded, SCAN will use the saved settings "
txt$ = txt$ + "of the previous user of the program."
frmPad!txtPad = txt$
frmPad.Tag = "show:SCAN Introductory Help"
frmPad.Show 1
End Sub

Private Sub mnuLockin_Click()
frmLockIn.Show 1
End Sub

Private Sub mnuMagnet_Click()
frmFieldSweep.Show 1
End Sub

Private Sub mnuMirror_Click()
frmMirrorSetup.Show 1
End Sub

Private Sub mnuOpen_Click()
Dim ffile As String
gDATA_TYPE = 0
frmXYDisplay!gphXY.YAxisStyle = 1
frmXYDisplay!gphXY.NumSets = 1
frmFileIO!lstFileExt.List(0) = "All SCAN data files (*.img; *.imx; *.dat; *.dax)"
frmFileIO!lstFileExt.List(1) = "Image data files (*.img; *.imx)"
frmFileIO!lstFileExt.List(2) = "XY Plot data files (*.dat; *.dax)"
frmFileIO!lstFileExt.List(3) = "All files (*.*)"
frmFileIO!lstFileExt.ListIndex = 0
frmFileIO!lstDirectory.Path = savedirectory

mode = OPENFILE
frmFileIO.Caption = "Open SCAN data file"
gQUIT = 0
frmFileIO.Show 1

If gQUIT <> 1 Then
savedirectory = frmFileIO!lstDirectory.Path


' add to list of recently used files

ffile = savedirectory: If Right$(savedirectory, 1) <> "\" Then ffile = ffile + "\"
ffile = ffile + file

already_there% = 0
For i% = 1 To 9: If ffile = recentfile$(i%) Then already_there% = 1
Next

If already_there% = 0 Then
 For i% = 9 To 2 Step -1: recentfile$(i%) = recentfile$(i% - 1): Next
 recentfile$(1) = ffile
End If

' update recent files menu
For i% = 1 To 9
mnuRecentFiles(i%).Caption = "&" + Format$(i%, "0") + "  " + recentfile$(i%)
If recentfile$(i%) <> "" Then mnuRecentFiles(i%).Visible = True: mnuSeparate1.Visible = True Else mnuRecentFiles(i%).Visible = False
Next

' update recent files in scan.ini
For i% = 1 To 9
ret% = WritePrivateProfileString(ByVal "Recent files", ByVal Format$(i%, "0"), ByVal recentfile$(i%), ByVal "c:\scan\scan.ini")
Next

savedirectory = Path
If Right$(savedirectory, 1) <> "\" Then savedirectory = savedirectory + "\"

Select Case Right$(file, 3)
Case "img", "imx"
imagesavefile = savedirectory + file
ImageLoad
Case "dat", "dax"
datasavefile = file
xysetupload
End Select

End If
End Sub

Private Sub mnuPad_Click()
frmPad.Tag = "edit:"
frmPad.Show 1
End Sub

Private Sub mnuPulse_Click()
frmPulse.Show 1
End Sub

Private Sub mnuScope1_Click()
'FrontPanel
'frmXYDisplay.Show 1
imgScope_Click
'frmScope.Show 1
End Sub

Private Sub mnuScope2_Click()
frmScope.Show 1
End Sub

Private Sub mnuSetup_Click()
panelInfo.Caption = "Setup parameters of hardware devices."
End Sub

Private Sub mnuXY_Click()
frmXYsetup.Show 1
End Sub

Private Sub panelMail_DblClick()
If labNovellUserName <> "" Then
X% = Shell("t:\pegasus\winpmail.exe", 5)
End If
End Sub

Private Sub Pause_Timer()
pause.Enabled = False
End Sub

Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
If panelInfo.Caption <> "SCAN" Then
panelInfo.ForeColor = 0
panelInfo.Caption = "SCAN"
End If
End Sub

Private Sub QuitProgram()
End
End Sub

