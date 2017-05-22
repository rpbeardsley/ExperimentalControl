VERSION 5.00
Begin VB.Form DVM 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "34401A DVM"
   ClientHeight    =   6720
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7080
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6720
   ScaleWidth      =   7080
   Begin VB.CommandButton Command2 
      Caption         =   "Get Sample"
      Height          =   495
      Left            =   5640
      TabIndex        =   12
      Top             =   120
      Width           =   1215
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   1320
      TabIndex        =   10
      Text            =   "15"
      Top             =   120
      Width           =   2775
   End
   Begin VB.ListBox List1 
      Height          =   2595
      Left            =   4080
      TabIndex        =   9
      Top             =   3960
      Width           =   2775
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Go"
      Height          =   495
      Left            =   360
      TabIndex        =   8
      Top             =   3960
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   4080
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   3360
      Width           =   2775
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   4080
      TabIndex        =   5
      Text            =   "1"
      Top             =   2760
      Width           =   2775
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   4080
      TabIndex        =   3
      Text            =   "0"
      Top             =   2400
      Width           =   2775
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   4080
      TabIndex        =   1
      Text            =   "1"
      Top             =   2040
      Width           =   2775
   End
   Begin VB.Label Label7 
      Height          =   255
      Left            =   1320
      TabIndex        =   14
      Top             =   600
      Width           =   2895
   End
   Begin VB.Label Label6 
      Caption         =   "Reading:"
      Height          =   255
      Left            =   360
      TabIndex        =   13
      Top             =   600
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Address:"
      Height          =   255
      Left            =   360
      TabIndex        =   11
      Top             =   120
      Width           =   735
   End
   Begin VB.Line Line1 
      X1              =   360
      X2              =   6840
      Y1              =   1560
      Y2              =   1560
   End
   Begin VB.Label Label4 
      Caption         =   "Trigger Source:"
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   3360
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Number of triggers to accept:"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   2760
      Width           =   3015
   End
   Begin VB.Label Label2 
      Caption         =   "Delay between trigger and sample (0 to 3600 secs):"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   2400
      Width           =   3735
   End
   Begin VB.Label Label1 
      Caption         =   "Samples per Trigger:"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   2040
      Width           =   1575
   End
End
Attribute VB_Name = "DVM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()

Dim addr As Integer

addr = DVM1_ADDR

success = DVM34401A.DVM34401A_Read(addr, OutBuffer, Int(Val(Text1.Text)), Int(Val(Text2.Text)), Int(Val(Text3.Text)), Combo1.ListIndex + 1)


If success = 0 Then
    List1.Clear
    For a = LBound(OutBuffer) To UBound(OutBuffer)
        List1.AddItem OutBuffer(a)
    Next a
End If


End Sub

Private Sub Command2_Click()

    Dim addr As Integer
    
    addr = Val(Text4.Text)

    Label7.Caption = DVM34401A.DVM34401A_GetSample(addr)

End Sub

Private Sub Form_Load()

Combo1.Clear
Combo1.AddItem "GPIB Bus"
Combo1.AddItem "Internal"
Combo1.AddItem "Ext. Trigger Socket"
Combo1.ListIndex = 1

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: DVM.Hide

End Sub

