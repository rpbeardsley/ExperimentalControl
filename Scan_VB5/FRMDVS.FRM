VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Begin VB.Form frmdvs 
   Caption         =   "Digital Voltage Source Setup"
   ClientHeight    =   4080
   ClientLeft      =   2160
   ClientTop       =   2925
   ClientWidth     =   6690
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4080
   ScaleWidth      =   6690
   Begin VB.CommandButton Command1 
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
      Height          =   435
      Left            =   2340
      TabIndex        =   15
      Top             =   3510
      Width           =   1935
   End
   Begin VB.Frame Frame1 
      Caption         =   "Output : Voltage set/sweep"
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
      Height          =   2505
      Left            =   630
      TabIndex        =   0
      Top             =   420
      Width           =   5355
      Begin VB.CommandButton Command2 
         Caption         =   "Update"
         Height          =   315
         Left            =   3750
         TabIndex        =   16
         Top             =   2040
         Width           =   1035
      End
      Begin VB.TextBox Text4 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   1650
         TabIndex        =   4
         Top             =   1800
         Width           =   1005
      End
      Begin VB.TextBox Text3 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   1650
         TabIndex        =   3
         Top             =   1380
         Width           =   1005
      End
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   1650
         TabIndex        =   2
         Top             =   960
         Width           =   1005
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   1650
         TabIndex        =   1
         Top             =   540
         Width           =   1005
      End
      Begin Spin.SpinButton SpinButton7 
         Height          =   345
         Left            =   2640
         TabIndex        =   10
         Top             =   1380
         Width           =   315
         _Version        =   65536
         _ExtentX        =   556
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   16777215
      End
      Begin Spin.SpinButton SpinButton6 
         Height          =   345
         Left            =   2640
         TabIndex        =   9
         Top             =   960
         Width           =   315
         _Version        =   65536
         _ExtentX        =   556
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   16777215
      End
      Begin Spin.SpinButton SpinButton5 
         Height          =   345
         Left            =   2640
         TabIndex        =   8
         Top             =   540
         Width           =   315
         _Version        =   65536
         _ExtentX        =   556
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   16777215
      End
      Begin Spin.SpinButton SpinButton3 
         Height          =   345
         Left            =   1470
         TabIndex        =   7
         Top             =   1380
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   16777215
      End
      Begin Spin.SpinButton SpinButton2 
         Height          =   345
         Left            =   1470
         TabIndex        =   6
         Top             =   960
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   16777215
      End
      Begin Spin.SpinButton SpinButton1 
         Height          =   345
         Left            =   1470
         TabIndex        =   5
         Top             =   540
         Width           =   195
         _Version        =   65536
         _ExtentX        =   344
         _ExtentY        =   609
         _StockProps     =   73
         BackColor       =   16777215
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Current  Voltage:"
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
         Left            =   120
         TabIndex        =   14
         Top             =   1860
         Width           =   1410
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Voltage Step:"
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
         Left            =   270
         TabIndex        =   13
         Top             =   1440
         Width           =   1095
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Final Voltage:"
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
         Left            =   270
         TabIndex        =   12
         Top             =   990
         Width           =   1095
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Initial Voltage:"
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
         Left            =   210
         TabIndex        =   11
         Top             =   600
         Width           =   1155
      End
   End
End
Attribute VB_Name = "frmdvs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Command1_Click()
Command2_Click
frmdvs.Hide
End Sub


Private Sub Command2_Click()
dvsset
voltage = Val(Text4.Text)
SetGate voltage
End Sub


Private Sub Form_Load()
text1.Text = "0.000"
Text2.Text = "0.000"
Text3.Text = "0.000"
Text4.Text = "0.0"
End Sub


Private Sub SpinButton1_SpinDown()
init_volt = Val(text1.Text)
init_volt = init_volt - 0.005
text1.Text = Format(init_volt, "#0.00##")
End Sub


Private Sub SpinButton1_SpinUp()
init_volt = Val(text1.Text)
init_volt = init_volt + 0.005
text1.Text = Format(init_volt, "#0.00##")
End Sub


Private Sub SpinButton2_SpinDown()
final_volt = Val(Text2.Text)
final_volt = final_volt - 0.005
Text2.Text = Format(final_volt, "#0.00##")
End Sub


Private Sub SpinButton2_SpinUp()
final_volt = Val(Text2.Text)
final_volt = final_volt + 0.005
Text2.Text = Format(final_volt, "#0.00##")
End Sub


