VERSION 5.00
Begin VB.Form DVSForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Keithley 230 Programmable Voltage Source"
   ClientHeight    =   6015
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6780
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6015
   ScaleWidth      =   6780
   Begin VB.CheckBox Check1 
      Caption         =   "Operating"
      Height          =   495
      Left            =   3720
      TabIndex        =   9
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Set"
      Height          =   495
      Left            =   3720
      TabIndex        =   8
      Top             =   120
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1680
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   1320
      Width           =   1695
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1680
      TabIndex        =   6
      Text            =   "0"
      Top             =   960
      Width           =   1695
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1680
      TabIndex        =   5
      Top             =   120
      Width           =   1695
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1680
      TabIndex        =   3
      Text            =   "2"
      Top             =   480
      Width           =   1695
   End
   Begin VB.Line Line1 
      X1              =   240
      X2              =   6600
      Y1              =   1920
      Y2              =   1920
   End
   Begin VB.Label Label4 
      Caption         =   "Device Address:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label Label3 
      Caption         =   "Current Limit:"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   1320
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Memory Location:"
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   480
      Width           =   1575
   End
   Begin VB.Label Label1 
      Caption         =   "Voltage:"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   960
      Width           =   735
   End
End
Attribute VB_Name = "DVSForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Combo1.Clear
    Combo1.AddItem "2mA"
    Combo1.AddItem "20mA"
    Combo1.AddItem "100mA"
    Combo1.ListIndex = 2

    Text2.Text = DVS_ADDR
End Sub
