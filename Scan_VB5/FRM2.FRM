VERSION 5.00
Begin VB.Form frm2 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Eclipse Setup"
   ClientHeight    =   4185
   ClientLeft      =   435
   ClientTop       =   2040
   ClientWidth     =   6870
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4185
   ScaleWidth      =   6870
   Begin VB.TextBox Text6 
      Height          =   315
      Left            =   4920
      TabIndex        =   15
      Text            =   "Text6"
      Top             =   840
      Width           =   1095
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Precision Enhancer"
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
      Left            =   1800
      TabIndex        =   13
      Top             =   2880
      Width           =   1935
   End
   Begin VB.TextBox Text5 
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
      Left            =   2760
      TabIndex        =   12
      Text            =   "Text5"
      Top             =   1920
      Width           =   975
   End
   Begin VB.TextBox Text4 
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
      Left            =   2760
      TabIndex        =   9
      Text            =   "Text4"
      Top             =   1560
      Width           =   975
   End
   Begin VB.TextBox Text3 
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
      Left            =   2760
      TabIndex        =   4
      Text            =   "Text3"
      Top             =   2280
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
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
      Left            =   2040
      TabIndex        =   3
      Top             =   3480
      Width           =   1095
   End
   Begin VB.ComboBox Combo1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2760
      TabIndex        =   2
      Text            =   "Combo1"
      Top             =   1200
      Width           =   975
   End
   Begin VB.TextBox Text2 
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
      Left            =   2760
      TabIndex        =   1
      Text            =   "Text2"
      Top             =   840
      Width           =   975
   End
   Begin VB.TextBox Text1 
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
      Left            =   2760
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   450
      Width           =   975
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      Caption         =   "Multiplier"
      Height          =   210
      Left            =   4200
      TabIndex        =   14
      Top             =   840
      Width           =   615
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      Caption         =   "Y-Offset / mV"
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
      TabIndex        =   11
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Time Offset / micosec"
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
      TabIndex        =   10
      Top             =   1560
      Width           =   1815
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Sample Period / ns"
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
      TabIndex        =   8
      Top             =   1200
      Width           =   1545
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Dead Time / microsec"
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
      TabIndex        =   7
      Top             =   2280
      Width           =   1785
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Averages"
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
      TabIndex        =   6
      Top             =   840
      Width           =   795
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Record Length / micosec"
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
      TabIndex        =   5
      Top             =   480
      Width           =   2055
   End
End
Attribute VB_Name = "frm2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Combo1_Change()

End Sub


Private Sub Command1_Click()
reclenec = Val(text1.Text)
av = Val(Text2.Text)
sample = Val(Combo1.Text)
dtime = Val(Text3.Text)
toffset = Val(Text4.Text)
voffset = Val(Text5.Text)
pe = Check1.Value
mult = Val(Text6.Text)
Nec = reclenec * 1000 / sample
'MsgBox (Nec)
flagset = 1
setupeclip
frm2.Hide
End Sub

Private Sub Form_Activate()
text1.Text = recstr
Combo1.Text = sampl_str
Text2.Text = avstr
Text3.Text = dtstr
Text4.Text = toffstr
Text5.Text = voffstr
Check1.Value = Val(pestr)
Text6.Text = "1"
End Sub

Private Sub Form_Load()
text1.Text = ""
Text2.Text = ""
Text3.Text = ""
Text4.Text = ""

Combo1.AddItem "0.5"
Combo1.AddItem "1.0"
Combo1.AddItem "2.0"
Combo1.ListIndex = 0



End Sub


