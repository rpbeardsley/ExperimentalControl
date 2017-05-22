VERSION 5.00
Begin VB.Form BiasForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bias"
   ClientHeight    =   2370
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5910
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2370
   ScaleWidth      =   5910
   Begin VB.CommandButton Command3 
      Caption         =   "Flip"
      Height          =   495
      Left            =   240
      TabIndex        =   5
      Top             =   1680
      Width           =   1215
   End
   Begin VB.OptionButton Option2 
      Caption         =   "Low"
      Height          =   495
      Left            =   3000
      TabIndex        =   4
      Top             =   960
      Width           =   1215
   End
   Begin VB.OptionButton Option1 
      Caption         =   "High"
      Height          =   495
      Left            =   1680
      TabIndex        =   3
      Top             =   960
      Value           =   -1  'True
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Set Bias"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   960
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Get Bias"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label1 
      Height          =   495
      Left            =   1560
      TabIndex        =   1
      Top             =   240
      Width           =   3975
   End
End
Attribute VB_Name = "BiasForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim success As Boolean
a = BiasSwitch.GetSwitchPosition(success)
If success = True Then Label1.Caption = a Else Label1.Caption = "Failed"
End Sub

Private Sub Command2_Click()

If Option1.value = True Then
    BiasSwitch.SetBias (1)
ElseIf Option2.value = True Then
    BiasSwitch.SetBias (0)
End If

End Sub

Private Sub Command3_Click()
Dim success As Boolean
BiasSwitch.FlipBias success
End Sub
