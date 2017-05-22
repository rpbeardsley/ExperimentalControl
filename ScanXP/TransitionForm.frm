VERSION 5.00
Begin VB.Form TransitionForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Record Bolometer Transition"
   ClientHeight    =   3240
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6870
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3240
   ScaleWidth      =   6870
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3480
      Style           =   2  'Dropdown List
      TabIndex        =   9
      Top             =   480
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Browse"
      Height          =   375
      Left            =   5040
      TabIndex        =   8
      Top             =   1800
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   3480
      TabIndex        =   6
      Top             =   840
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   3480
      TabIndex        =   4
      Top             =   120
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   360
      TabIndex        =   2
      Text            =   "trans.dat"
      Top             =   1800
      Width           =   4455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Stop"
      Height          =   495
      Left            =   1800
      TabIndex        =   1
      Top             =   2520
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Start"
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   2520
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "Lockin Used To Monitor Temperature:"
      Height          =   255
      Left            =   360
      TabIndex        =   10
      Top             =   480
      Width           =   3015
   End
   Begin VB.Label Label3 
      Caption         =   "Output Filename"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   1440
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "Multimeter Address:"
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   840
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "Temperature Meaurement Lockin Address:"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   120
      Width           =   3135
   End
End
Attribute VB_Name = "TransitionForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private running As Boolean

Private Sub Command1_Click()

    Dim addr1 As Integer
    Dim addr2 As Integer
    Dim model As Integer
    Dim sineout
    Dim transX()
    Dim transY()
    
    addr1 = Int(Val(Text2.Text))
    addr2 = Int(Val(Text3.Text))
    
    If Combo1.ListIndex = 0 Then model = 830
    If Combo1.ListIndex = 1 Then model = 510

    sineout = 1

    running = True
    Open Text1.Text For Output As #1
    
    n = 0
loopstart:
        t = Timer + 1

        temp = AutoGetTemperature(addr1, model, TEMP_CONTROL_TYPE, sineout)
        r = DVM34401A.DVM34401A_GetSample(addr2)
    
        Print #1, Format(temp) + "," + r
        ReDim Preserve transX(0 To n)
        ReDim Preserve transY(0 To n)
        transX(n) = Val(temp)
        transY(n) = Val(r)
        n = n + 1
        TraceForm.PlotTrace transX, transY
    
        While Timer < t
            DoEvents
        Wend

        If running = True Then GoTo loopstart
    
    Close #1

End Sub

Private Sub Command2_Click()
    running = False
End Sub

Private Sub Command3_Click()
    a = Globals.SaveDialog
    If a <> "" Then Text1.Text = a
End Sub

Private Sub Form_Load()
Text2.Text = TEMP_CONTROL_LOCKIN
Text3.Text = DVM2_ADDR

Combo1.Clear
Combo1.AddItem "SRS830"
Combo1.AddItem "SR510"
If TEMP_CONTROL_LOCKIN_MODEL = 510 Then
    Combo1.ListIndex = 1
Else
    Combo1.ListIndex = 0
End If


End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
If UnloadMode = 0 Then Cancel = 1: TransitionForm.Hide
End Sub
