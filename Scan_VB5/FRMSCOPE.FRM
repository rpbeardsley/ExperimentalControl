VERSION 5.00
Begin VB.Form frmScope 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Oscilloscope IEEE workbench"
   ClientHeight    =   4980
   ClientLeft      =   2895
   ClientTop       =   1905
   ClientWidth     =   5760
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
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4980
   ScaleWidth      =   5760
   Begin VB.CommandButton Command6 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "IEEE command send"
      Height          =   885
      Left            =   3540
      TabIndex        =   9
      Top             =   3390
      Width           =   2025
   End
   Begin VB.TextBox Text3 
      Appearance      =   0  'Flat
      Height          =   1305
      Left            =   480
      TabIndex        =   8
      Top             =   3240
      Width           =   2985
   End
   Begin VB.CommandButton Command5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "IEEE data receive"
      Height          =   765
      Left            =   3570
      TabIndex        =   7
      Top             =   2190
      Width           =   1965
   End
   Begin VB.TextBox Text2 
      Appearance      =   0  'Flat
      Height          =   1065
      Left            =   450
      TabIndex        =   6
      Top             =   2100
      Width           =   2985
   End
   Begin VB.CommandButton Command4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "IEEE data send"
      Height          =   435
      Left            =   3510
      TabIndex        =   5
      Top             =   1440
      Width           =   2025
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   615
      Left            =   420
      TabIndex        =   4
      Top             =   1350
      Width           =   2985
   End
   Begin VB.ComboBox Combo1 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   390
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   870
      Width           =   3045
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "addr 8"
      Height          =   375
      Left            =   4110
      TabIndex        =   2
      Top             =   210
      Width           =   1275
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "SPOLL"
      Height          =   375
      Left            =   2070
      TabIndex        =   1
      Top             =   210
      Width           =   1605
   End
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "LOCAL"
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Top             =   210
      Width           =   1365
   End
End
Attribute VB_Name = "frmScope"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
SendIEEECmd ("LOCAL 8")
End Sub

Private Sub Command2_Click()
SendIEEECmd ("SPOLL")
End Sub

Private Sub Command3_Click()
SendIEEECmd ("8")
End Sub

Private Sub Command4_Click()
Text = text1: If Combo1.ListIndex = 2 Then Text = Text + Chr$(13)
If Combo1.ListIndex > 0 Then Text = Text + Chr$(10)
SendIEEEdata (Text)
text1 = ""
End Sub

Private Sub Command5_Click()
Text2 = recvIEEEdata(255)
End Sub

Private Sub Command6_Click()
SendIEEECmd (Text3)
Text3 = ""
End Sub

Private Sub Form_Load()
CentreForm Me
Combo1.AddItem "nothing"
Combo1.AddItem "LF"
Combo1.AddItem "CR + LF"
Combo1.ListIndex = 2
End Sub

