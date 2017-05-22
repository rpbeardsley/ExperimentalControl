VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "comdlg32.ocx"
Begin VB.Form frmeclipse 
   Caption         =   "EG&G Instruments  - Eclipse DSP"
   ClientHeight    =   7905
   ClientLeft      =   1200
   ClientTop       =   1365
   ClientWidth     =   11985
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7905
   ScaleWidth      =   11985
   Begin VB.TextBox TempRead 
      Height          =   285
      Left            =   9360
      TabIndex        =   69
      Text            =   "Text4"
      Top             =   6840
      Width           =   1335
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      Index           =   1
      Left            =   8880
      TabIndex        =   66
      Text            =   "Combo4"
      Top             =   5760
      Width           =   1695
   End
   Begin VB.Frame Frame3 
      Caption         =   "Time Gating"
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
      Height          =   1575
      Index           =   2
      Left            =   8040
      TabIndex        =   26
      Top             =   600
      Width           =   3495
      Begin VB.Label Label29 
         AutoSize        =   -1  'True
         Caption         =   "Label29"
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
         Height          =   210
         Left            =   2520
         TabIndex        =   42
         Top             =   1080
         Width           =   630
      End
      Begin VB.Label Label28 
         AutoSize        =   -1  'True
         Caption         =   "Label28"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808080&
         Height          =   210
         Left            =   2520
         TabIndex        =   41
         Top             =   480
         Width           =   630
      End
      Begin VB.Label Label27 
         AutoSize        =   -1  'True
         Caption         =   "Average"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2520
         TabIndex        =   40
         Top             =   240
         Width           =   690
      End
      Begin VB.Label Label26 
         AutoSize        =   -1  'True
         Caption         =   "Label26"
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
         Left            =   1320
         TabIndex        =   39
         Top             =   1200
         Width           =   570
      End
      Begin VB.Label Label25 
         AutoSize        =   -1  'True
         Caption         =   "Label25"
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
         Left            =   1320
         TabIndex        =   38
         Top             =   960
         Width           =   570
      End
      Begin VB.Label Label24 
         AutoSize        =   -1  'True
         Caption         =   "Width"
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
         Left            =   240
         TabIndex        =   37
         Top             =   1200
         Width           =   405
      End
      Begin VB.Label Label23 
         AutoSize        =   -1  'True
         Caption         =   "Signal Gate"
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
         Left            =   240
         TabIndex        =   36
         Top             =   960
         Width           =   825
      End
      Begin VB.Label Label22 
         AutoSize        =   -1  'True
         Caption         =   "Label22"
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
         Left            =   1320
         TabIndex        =   35
         Top             =   600
         Width           =   570
      End
      Begin VB.Label Label21 
         AutoSize        =   -1  'True
         Caption         =   "Width"
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
         Left            =   240
         TabIndex        =   34
         Top             =   600
         Width           =   405
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   "Label20"
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
         Left            =   1320
         TabIndex        =   33
         Top             =   360
         Width           =   570
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         Caption         =   "BaseLine"
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
         Left            =   240
         TabIndex        =   32
         Top             =   360
         Width           =   675
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Cursors"
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
      Height          =   1575
      Index           =   1
      Left            =   8040
      TabIndex        =   25
      Top             =   600
      Width           =   3495
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   1920
         TabIndex        =   29
         Top             =   840
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   480
         TabIndex        =   28
         Top             =   840
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.CheckBox chk1 
         Caption         =   "On / Off"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   27
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Y / mV"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2280
         TabIndex        =   31
         Top             =   1200
         Visible         =   0   'False
         Width           =   525
      End
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "X / ns"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   840
         TabIndex        =   30
         Top             =   1200
         Visible         =   0   'False
         Width           =   450
      End
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Control Panel"
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
      Height          =   2295
      Index           =   0
      Left            =   7920
      TabIndex        =   22
      Top             =   0
      Width           =   3735
      Begin VB.ComboBox Combo3 
         Height          =   315
         Left            =   840
         TabIndex        =   23
         Text            =   "Combo3"
         Top             =   240
         Width           =   1815
      End
      Begin VB.Frame Frame3 
         Caption         =   "Zoom"
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
         Height          =   1575
         Index           =   0
         Left            =   120
         TabIndex        =   24
         Top             =   600
         Width           =   3495
         Begin VB.CommandButton Command4 
            Caption         =   "Zoom Out"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1920
            TabIndex        =   65
            Top             =   1200
            Visible         =   0   'False
            Width           =   1215
         End
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "DSP Settings"
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
      Height          =   4335
      Left            =   7920
      TabIndex        =   3
      Top             =   2400
      Width           =   3735
      Begin VB.CheckBox Check3 
         Caption         =   "Show"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2760
         TabIndex        =   60
         Top             =   3840
         Value           =   1  'Checked
         Width           =   855
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Show"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2760
         TabIndex        =   59
         Top             =   3480
         Width           =   855
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Show"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2760
         TabIndex        =   58
         Top             =   3120
         Width           =   855
      End
      Begin VB.ComboBox Combo6 
         Height          =   315
         Left            =   960
         TabIndex        =   54
         Text            =   "Combo6"
         Top             =   3720
         Width           =   1695
      End
      Begin VB.ComboBox Combo4 
         Height          =   315
         Index           =   0
         Left            =   960
         TabIndex        =   53
         Text            =   "Combo4"
         Top             =   3000
         Width           =   1695
      End
      Begin VB.ComboBox Combo2 
         Height          =   315
         Left            =   1920
         TabIndex        =   5
         Text            =   "Combo2"
         Top             =   2280
         Width           =   1455
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   240
         TabIndex        =   4
         Text            =   "Combo1"
         Top             =   2280
         Width           =   1455
      End
      Begin VB.Label Label37 
         AutoSize        =   -1  'True
         Caption         =   "Result"
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
         Height          =   210
         Left            =   240
         TabIndex        =   57
         Top             =   3720
         Width           =   525
      End
      Begin VB.Label Label36 
         AutoSize        =   -1  'True
         Caption         =   "Trace 2"
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
         Height          =   210
         Left            =   240
         TabIndex        =   56
         Top             =   3360
         Width           =   600
      End
      Begin VB.Label Label35 
         Caption         =   "Trace 1"
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
         Left            =   240
         TabIndex        =   55
         Top             =   3000
         Width           =   855
      End
      Begin VB.Line Line3 
         X1              =   240
         X2              =   3480
         Y1              =   2880
         Y2              =   2880
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Label16"
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
         Left            =   2040
         TabIndex        =   21
         Top             =   1680
         Width           =   570
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Label15"
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
         Left            =   2040
         TabIndex        =   20
         Top             =   1440
         Width           =   570
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         Caption         =   "Label14"
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
         Left            =   2040
         TabIndex        =   19
         Top             =   1200
         Width           =   570
      End
      Begin VB.Label Label13 
         AutoSize        =   -1  'True
         Caption         =   "Label13"
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
         Left            =   2040
         TabIndex        =   18
         Top             =   960
         Width           =   570
      End
      Begin VB.Label Label12 
         AutoSize        =   -1  'True
         Caption         =   "Label12"
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
         Left            =   2040
         TabIndex        =   17
         Top             =   720
         Width           =   570
      End
      Begin VB.Label Label11 
         AutoSize        =   -1  'True
         Caption         =   "Label11"
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
         Left            =   2040
         TabIndex        =   16
         Top             =   480
         Width           =   570
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "Label10"
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
         Left            =   2040
         TabIndex        =   15
         Top             =   240
         Width           =   570
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Precision Enhancer"
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
         Left            =   360
         TabIndex        =   14
         Top             =   1680
         Width           =   1395
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "Dead Time"
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
         Left            =   360
         TabIndex        =   13
         Top             =   1440
         Width           =   750
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Y-Offset"
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
         Left            =   360
         TabIndex        =   12
         Top             =   1200
         Width           =   645
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Time Offset"
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
         Left            =   360
         TabIndex        =   11
         Top             =   960
         Width           =   840
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Sample Period"
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
         Left            =   360
         TabIndex        =   10
         Top             =   720
         Width           =   1020
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Averages"
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
         Left            =   360
         TabIndex        =   9
         Top             =   480
         Width           =   720
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Record Length"
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
         Left            =   360
         TabIndex        =   8
         Top             =   240
         Width           =   1065
      End
      Begin VB.Line Line1 
         X1              =   240
         X2              =   3360
         Y1              =   1920
         Y2              =   1920
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Full Scale /mV"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2040
         TabIndex        =   7
         Top             =   2040
         Width           =   1140
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "TimeBase"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   480
         TabIndex        =   6
         Top             =   2040
         Width           =   825
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Stop"
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
      Left            =   8040
      TabIndex        =   2
      Top             =   7440
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Acquire"
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
      Left            =   9360
      TabIndex        =   1
      Top             =   7440
      Width           =   2055
   End
   Begin VB.PictureBox pic1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   6255
      Left            =   960
      ScaleHeight     =   6225
      ScaleWidth      =   6825
      TabIndex        =   0
      Top             =   480
      Width           =   6855
      Begin VB.Frame Frame4 
         Caption         =   "Setup: Experimental Control"
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
         Height          =   3135
         Left            =   1080
         TabIndex        =   48
         Top             =   1560
         Visible         =   0   'False
         Width           =   5055
         Begin VB.TextBox Text3 
            Height          =   285
            Left            =   2880
            TabIndex        =   62
            Top             =   2280
            Width           =   975
         End
         Begin VB.CheckBox Check4 
            Caption         =   "Save Traces"
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
            Height          =   255
            Left            =   3000
            TabIndex        =   61
            Top             =   1440
            Width           =   1575
         End
         Begin VB.CommandButton Command3 
            Caption         =   "Ok"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1920
            TabIndex        =   52
            Top             =   2760
            Width           =   1095
         End
         Begin VB.OptionButton Option3 
            Caption         =   "Voltage Sweep"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1200
            TabIndex        =   51
            Top             =   960
            Width           =   1575
         End
         Begin VB.OptionButton Option2 
            Caption         =   "Attenuator Sweep"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1200
            TabIndex        =   50
            Top             =   720
            Width           =   2295
         End
         Begin VB.OptionButton Option1 
            Caption         =   "Single Trace"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1200
            TabIndex        =   49
            Top             =   480
            Value           =   -1  'True
            Width           =   2535
         End
         Begin VB.Label Label39 
            AutoSize        =   -1  'True
            Caption         =   "MultiTrace Setup"
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
            Height          =   210
            Left            =   240
            TabIndex        =   64
            Top             =   1440
            Width           =   1395
         End
         Begin VB.Label Label38 
            AutoSize        =   -1  'True
            Caption         =   "Label38"
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
            Height          =   210
            Left            =   360
            TabIndex        =   63
            Top             =   1800
            Width           =   570
         End
         Begin VB.Line Line2 
            X1              =   240
            X2              =   4560
            Y1              =   1320
            Y2              =   1320
         End
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   2160
      Top             =   7320
      _ExtentX        =   688
      _ExtentY        =   688
      _Version        =   327680
   End
   Begin VB.Label Label42 
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
      Left            =   7920
      TabIndex        =   70
      Top             =   6840
      Width           =   1335
   End
   Begin VB.Label Label41 
      AutoSize        =   -1  'True
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   600
      TabIndex        =   68
      Top             =   3480
      Width           =   90
   End
   Begin VB.Label Label40 
      AutoSize        =   -1  'True
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   600
      TabIndex        =   67
      Top             =   6600
      Width           =   135
   End
   Begin VB.Label Label34 
      AutoSize        =   -1  'True
      Caption         =   "Signal / mV"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   240
      TabIndex        =   47
      Top             =   120
      Width           =   915
   End
   Begin VB.Label Label33 
      AutoSize        =   -1  'True
      Caption         =   "Time / ns"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   3960
      TabIndex        =   46
      Top             =   6960
      Width           =   765
   End
   Begin VB.Label Label32 
      AutoSize        =   -1  'True
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   960
      TabIndex        =   45
      Top             =   6720
      Width           =   90
   End
   Begin VB.Label Label31 
      AutoSize        =   -1  'True
      Caption         =   "100"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   7560
      TabIndex        =   44
      Top             =   6720
      Width           =   270
   End
   Begin VB.Label Label30 
      AutoSize        =   -1  'True
      Caption         =   "112"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   600
      TabIndex        =   43
      Top             =   480
      Width           =   270
   End
   Begin VB.Menu mnufile 
      Caption         =   "&File"
      Begin VB.Menu mnusave 
         Caption         =   "&Save"
      End
      Begin VB.Menu mnuexit 
         Caption         =   "&Exit"
      End
   End
   Begin VB.Menu mnuexpt 
      Caption         =   "&Experiment"
   End
   Begin VB.Menu mnusetup 
      Caption         =   "&Setup"
      Begin VB.Menu mnuatten 
         Caption         =   "&Attenuator"
      End
      Begin VB.Menu mnudvm 
         Caption         =   "&DVM"
      End
      Begin VB.Menu mnudsp 
         Caption         =   "&Eclipse"
      End
   End
End
Attribute VB_Name = "frmeclipse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim r As Variant
Dim flag As Integer
Dim xend As Single
Dim yscal As Single

Dim display_mode As Integer
Dim zmode As Integer
Dim startx As Single
Dim starty As Single
Dim curx As Single
Dim cury As Single

Private Sub Check1_Click()
setscale1
replot_data
End Sub

Private Sub Check2_Click()
setscale1
replot_data
End Sub


Private Sub Check3_Click()
setscale1
replot_data
End Sub


Private Sub Chk1_Click()
If Chk1.Value = 1 Then
text1.Visible = True
Text2.Visible = True
Label17.Visible = True
Label18.Visible = True
pic1.MousePointer = 2
Else
text1.Visible = False
Text2.Visible = False
Label17.Visible = False
Label18.Visible = False
pic1.MousePointer = 1
End If
End Sub


Private Sub Combo1_Click()
If flag_load = 0 Then
Else
xend = Val(Combo1.Text)
setscale1
replot_data
End If
End Sub


Private Sub Combo2_Click()
If flag_load = 0 Then
Else
yscal = Val(Combo2.Text)
setscale1
replot_data
End If
End Sub


Private Sub Combo3_Click()
Dim flagtools As Integer

v% = Combo3.ListIndex
For d% = 0 To 2 Step 1
If d% = v% Then
Frame3(d%).Visible = True
Else
Frame3(d%).Visible = False
End If
Next d%

ToolsOff display_mode
display_mode = Combo3.ListIndex
ToolsOn display_mode
gatewin
End Sub


Private Sub Command1_Click()
Dim min As Single
Dim max As Single
'Dim gate_vol As Single
Dim cntec As Integer
Dim stpec As Single
Dim gate_ec As Single
Dim signal_av As Single
Dim att_level As Integer
flag = 0
If flagset = 0 Then
mnudsp_Click
Else
'---------------------------------------------------
'single trace
If Option1.Value = True Then
setupeclip
ICSObj.Protocol 0
cleararray
frmSCAN!panelInfo = "Acquiring Data"
getectrace
setscale1
replot_data
gatewin

SendIEEECmd (Str$(ieeeaddr(lckn)))
SendIEEEdata ("OUTR? 1")
TempRead = 1000 * Val(recvIEEEdata$(20))

frmSCAN!panelInfo = "Data Acquired"
End If

'-----------------------------------------------------
'Attenuator sweep
If Option2.Value = True Then

attn_start = Val(frmAttenuate!txtAttenRange(0).Text)
attn_end = Val(frmAttenuate!txtAttenRange(1).Text)
attn_step = Val(frmAttenuate!txtAttenStep.Text)
'MsgBox ("attn")
setupeclip
ICSObj.Protocol 0
setscale1
cntec = 0
For att_level = (63 - attn_start) To (63 - attn_end) Step attn_step
SetAttenuator att_level
cntec = cntec + 1
'cleararray
'getectrace
'replot_data
'gatewin

pause 6
cleararray
getectrace
setscale1
replot_data
gatewin
signal_av = totalg - totalb
Print #5, att_level, signal_av
If Check4.Value = 1 Then
filetrace$ = Text3.Text + Str(cntec)
savedata filetrace$
End If
t = Timer
While Timer < t + 1
Wend
Next
Close #5
datasavefile = "c:\tmp\temp.dat"
 datatmpfile = datasavefile
 gNumPts(1) = count
 frmXYDisplay!gphXY.NumSets = 1
 frmXYDisplay!gphXY.ThisSet = 1
 mode = BROWSE
 xysetupload
 frmXYDisplay.Show 1


'autosave
'newdata
'Next
End If
'---------------------------------------------------
'Voltage sweep
If Option3.Value = True Then

setupeclip
ICSObj.Protocol 0

'If flag = 0 Then
Open "c:\tmp\temp.dat" For Output As #5
min = Val(frmdvs!text1.Text)
max = Val(frmdvs!Text2.Text)
stpec = Abs(Val(frmdvs!Text3.Text))
If max < min Then
stpec = -stpec
End If
cntec = 0

For gate_vol = min To max Step stpec
frmSCAN!panelInfo = "Getting " + Format(gate_vol, "#0.0##") + " gate trace....please wait."
cntec = cntec + 1
SetGate gate_vol
DoEvents
If flag = 1 Then
Exit For
End If
pause 6
cleararray
getectrace
setscale1
replot_data
gatewin
signal_av = totalg - totalb
Print #5, gate_ec, signal_av
If Check4.Value = 1 Then
filetrace$ = Text3.Text + Str(cntec)
savedata filetrace$
End If
t = Timer
While Timer < t + 1
Wend
Next
Close #5
datasavefile = "c:\tmp\temp.dat"
 datatmpfile = datasavefile
 gNumPts(1) = count
 frmXYDisplay!gphXY.NumSets = 1
 frmXYDisplay!gphXY.ThisSet = 1
 mode = BROWSE
 xysetupload
 frmXYDisplay.Show 1

End If
'---------------------------------------------------
End If
End Sub

Private Sub Command2_Click()
'flag = 1
ICSObj.StopAverageAcquisition
End Sub


Private Sub Command3_Click()
Frame4.Visible = False
setscale1
replot_data
End Sub

Private Sub Command4_Click()
setscale1
replot_data
Command4.Visible = False
End Sub

Private Sub Form_Activate()
xend = Val(Combo1.Text)
yscal = Val(Combo2.Text)
'MsgBox ("Activ")

s = (ICSObj.GetAverageConfig(0))

setscale1
recstr = Mid(s, 1, 7)
Label10.Caption = recstr + " microsec"

avstr = Mid(s, 9, 5)
Label11.Caption = avstr

sampl_str = Mid(s, 15, 3)
Label12.Caption = sampl_str + " ns"

toffstr = Mid(s, 19, 8)
Label13.Caption = toffstr + " microsec"

voffstr = Mid(s, 28, 7)
Label14.Caption = voffstr + " mV"

dtstr = Mid(s, 36, 6)
Label15.Caption = dtstr + "microsec"

pestr = Mid(s, 42, 2)
Label16.Caption = pestr
If Combo3.ListIndex = 2 Then
ToolsOn 2
End If

End Sub

Private Sub Form_Load()
createclass
i = 0
flagset = 0
ICSObj.Protocol 0
protnumber = ICSObj.Protocol
Combo1.AddItem "20"
Combo1.AddItem "50"
Combo1.AddItem "100"
Combo1.AddItem "200"
Combo1.AddItem "500"
Combo1.AddItem "1000"
Combo1.AddItem "2000"
Combo1.AddItem "5000"
'Combo1.AddItem "20"
Combo2.AddItem "5"
Combo2.AddItem "10"
Combo2.AddItem "20"
Combo2.AddItem "50"
Combo2.AddItem "100"
Combo2.AddItem "200"
Combo2.AddItem "500"
Combo2.AddItem "1000"
Combo3.AddItem "Zoom"
Combo3.AddItem "Cursors"
Combo3.AddItem "Time Gate"
Combo1.ListIndex = 3
Combo2.ListIndex = 4
Combo3.ListIndex = 0
Combo4(0).AddItem "+ve switch"
Combo4(0).AddItem "-ve switch"
Combo4(0).AddItem "Zero Voltage"
Combo4(0).AddItem "+ve Voltage"
Combo4(0).AddItem "-ve Voltage"
Combo4(0).AddItem "None"
Combo4(0).ListIndex = 0
Combo4(1).AddItem "+ve switch"
Combo4(1).AddItem "-ve switch"
Combo4(1).AddItem "Zero Voltage"
Combo4(1).AddItem "+ve Voltage"
Combo4(1).AddItem "-ve Voltage"
Combo4(1).AddItem "None"
Combo4(1).ListIndex = 5

Combo6.AddItem "Copy 1"
Combo6.AddItem "Copy 2"
Combo6.AddItem "Subtract 1-2"
Combo6.AddItem "Subtract 2-1"
Combo6.AddItem "Add 1+2"
Combo6.ListIndex = 0

display_mode = 0
Label10.Caption = ""
Label11.Caption = ""
Label12.Caption = ""
Label13.Caption = ""
Label14.Caption = ""
Label15.Caption = ""
Label16.Caption = ""
Label38.Caption = "Enter 3 letter filename." + Chr(13) + Chr(10) + "Each trace will be saved as this plus the fileno"

For k% = 0 To 3
timewindowec(k%) = (k% + 1) * 10
Next
flagtools = 0
flag_load = 1
sample = 0.5

'setscale1





End Sub



Private Sub savedata(filenam As String)
Open filenam For Output As #1
Dim filenam1 As String
Dim filenam2 As String

filenam1 = CStr(filenam) + "b1.dat"
filenam2 = CStr(filenam) + "b2.dat"
Open filenam1 For Output As #2
Open filenam2 For Output As #3
For iec = 1 To Nec
Print #1, xdatec(2, iec), ydatec(2, iec)
Print #2, xdatec(0, iec), ydatec(0, iec)
Print #3, xdatec(1, iec), ydatec(1, iec)
Next iec
Close #1
Close #2
Close #3
End Sub

Private Sub mnuatten_Click()
frmAttenuate.Show 1
End Sub

Private Sub mnudsp_Click()
frm2.Show 1
End Sub

Private Sub mnudvm_Click()
frmdvs.Show 1
End Sub

Private Sub mnuexit_Click()
frmeclipse.Hide
End Sub

Private Sub mnuexpt_Click()
Frame4.Visible = True
End Sub

Private Sub mnusave_Click()
savedirectory = CheckPresent(gDATdir)
ChDir savedirectory
CommonDialog1.Filter = "All files (*.*)|*.*|Data files(*.dat)|*.dat"
CommonDialog1.FilterIndex = 2
CommonDialog1.Action = 2
filen$ = CommonDialog1.filename
m$ = "File not saved"
If filen$ = "" Then
MsgBox m$, 64, "Save"
Else
savedata filen$
End If

End Sub

Public Sub setscale1()
Dim offset As Single
Dim offset2 As Single
Dim start As Single
Dim stp2 As Single
Dim yscal2 As Single
yoffset = yscal / 20
'pic1.Scale (0, yscal)-(xend, -yoffset)
start = 0
start2 = start
stp2 = xend


yscal2 = (yscal / 2)
offset = Abs(start - xend) * 0.01
offset2 = 0.02 * (yscal / 2)
pic1.DrawWidth = 1

pic1.Scale (start2 - offset, (yscal / 2) + offset2)-(stp2 + offset, -(yscal / 2 + offset2))

pic1.Cls
For E% = 1 To 11 Step 1
pic1.Line (start, yscal2)-(xend, yscal2), QBColor(10)
pic1.Line (start2, -yscal / 2)-(start2, yscal / 2), QBColor(10)

start2 = start2 + (Abs(xend - start) / 10)

yscal2 = yscal2 - (yscal / 10)
Next E%
Label30.Caption = Str(yscal / 2)
Label31.Caption = Str(xend)
Label32.Caption = "0"
Label40.Caption = Str(-yscal / 2)
Label41.Caption = "0"
End Sub

Private Sub replot_data()
'MsgBox ("hello")
plotlen = xend / sample

If Check1.Value = 1 Then
For j% = 1 To plotlen Step 1
If j% = 1 Then
pic1.PSet (sample * j%, ydatec(0, j%)), QBColor(12)
Else
pic1.Line -(sample * j%, ydatec(0, j%)), QBColor(12)
End If
Next j%
Else
End If

If Check2.Value = 1 Then
For j% = 1 To plotlen Step 1
If j% = 1 Then
pic1.PSet (sample * j%, ydatec(1, j%)), QBColor(14)
Else
pic1.Line -(sample * j%, ydatec(1, j%)), QBColor(14)
End If
Next j%
Else
End If

'On Err GoTo errhandle
If Check3.Value = 1 Then
For j% = 1 To plotlen Step 1
If j% = 1 Then
pic1.PSet (sample * j%, ydatec(2, j%)), QBColor(15)
Else
pic1.Line -(sample * j%, ydatec(2, j%)), QBColor(15)
End If
Next j%
Else
End If
If Combo3.ListIndex = 2 Then
ToolsOn 2
End If
'errhandle:
'Resume Next

End Sub

Private Sub pic1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Select Case Button
Case 1 'left button
Select Case Combo3.ListIndex
Case 0
zmode = 1
startx = X
starty = Y
curx = X
cury = Y
pic1.DrawMode = 6
pic1.Line (startx, starty)-(curx, cury), , B
Case 1
Case 2
set_timewin CInt(X)
End Select
Case 2
'Frame4.Visible = True
End Select

End Sub

Private Sub pic1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
If zmode = 1 Then
pic1.Line (startx, starty)-(curx, cury), , B
curx = X
cury = Y
pic1.Line (startx, starty)-(curx, cury), , B
End If
If Chk1.Value = 1 Then
text1.Text = X
Text2.Text = Y
Else
End If
End Sub



Private Sub set_timewin(timeclic As Integer)
Dim dist As Single
Dim mindist As Single

mindist = 1000000000
For k% = 0 To 3
dist = Abs(timewindowec(k%) - timeclic)
If dist < mindist Then
mindist = dist
timewin = k%
End If
Next

showtimewindow timewin
timewindowec(timewin) = timeclic
showtimewindow timewin
gatewin
End Sub

Public Sub showtimewindow(timewin As Integer)
Dim colour As Long
pic1.DrawMode = 7
If timewin < 2 Then
colour = &H808080
Else
colour = &HFF0000
End If
pic1.Line (timewindowec(timewin), pic1.ScaleHeight)-(timewindowec(timewin), -pic1.ScaleHeight), colour
pic1.DrawMode = 13

End Sub

Private Sub ToolsOn(ndis As Integer)
Select Case ndis
Case 0
Case 1
Case 2
For ii% = 0 To 3
showtimewindow ii%
Next
End Select
End Sub

Private Sub ToolsOff(ndis As Integer)
Select Case ndis
Case 0
Case 1
Case 2
For ii% = 0 To 3
showtimewindow ii%
Next
End Select
End Sub





Private Sub pic1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
Select Case Button
Case 1
If Combo3.ListIndex = 0 Then
zmode = 0
If (curx <> startx) Or (cury <> starty) Then
zoom
End If
pic1.DrawMode = 13
End If
Case 2
End Select
End Sub



Private Sub zoom()
Dim xs As Single
Dim xf As Single
Dim ys As Single
Dim yf As Single
xs = startx
ys = starty
xf = curx
yf = cury

Command4.Visible = True
pic1.DrawMode = 6
pic1.Line (startx, starty)-(curx, cury), , B
pic1.DrawMode = 13
pic1.Scale (startx, starty)-(curx, cury)
pic1.Cls
For E% = 1 To 11 Step 1
pic1.Line (startx, yf)-(curx, yf), QBColor(10)
pic1.Line (xs, starty)-(xs, cury), QBColor(10)

xs = xs + (Abs(curx - startx) / 10)

yf = yf + (Abs(cury - starty) / 10)
'ys = ys + (Abs(cury - starty) / 10)
Next E%
Label31.Caption = Format(curx, "#0.0#")
Label32.Caption = Format(startx, "#0.0#")
Label30.Caption = Format(starty, "#0.0#")
Label40.Caption = Format(cury, "#0.0#")
Label41.Caption = Format((starty - cury) / 2, "#0.0#")
replot_data

End Sub





Private Sub autosave()
If Check4.Value = 1 Then
'make filename
'savedata filenam
End If
End Sub

Private Sub Text4_Change()

End Sub


