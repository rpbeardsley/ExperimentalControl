VERSION 5.00
Object = "{2A833923-9AA7-4C45-90AC-DA4F19DC24D1}#1.0#0"; "MG17Motor.ocx"
Object = "{9460A175-8618-4753-B337-61D9771C4C14}#1.0#0"; "MG17System.ocx"
Object = "{2A38BE50-27E7-42F0-8663-CBCB1F25E13D}#1.0#0"; "MG17LO~1.OCX"
Begin VB.Form StepperControlForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "StepperControl"
   ClientHeight    =   4635
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6150
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4635
   ScaleWidth      =   6150
   Begin MG17LoggerLib.MG17Logger MG17Logger1 
      Height          =   495
      Left            =   5520
      TabIndex        =   19
      Top             =   3600
      Visible         =   0   'False
      Width           =   255
      _Version        =   65536
      _ExtentX        =   450
      _ExtentY        =   873
      _StockProps     =   205
   End
   Begin MG17SystemLib.MG17System MG17System1 
      Height          =   375
      Left            =   4560
      TabIndex        =   18
      Top             =   3480
      Visible         =   0   'False
      Width           =   615
      _Version        =   65536
      _ExtentX        =   1085
      _ExtentY        =   661
      _StockProps     =   0
   End
   Begin MG17MotorLib.MG17Motor MG17Motor1 
      Height          =   375
      Left            =   4560
      TabIndex        =   17
      Top             =   3960
      Visible         =   0   'False
      Width           =   615
      _Version        =   65536
      _ExtentX        =   1085
      _ExtentY        =   661
      _StockProps     =   0
   End
   Begin VB.TextBox Text3 
      Height          =   375
      Left            =   1800
      TabIndex        =   11
      Top             =   2160
      Width           =   2415
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Go"
      Height          =   495
      Left            =   4440
      TabIndex        =   10
      Top             =   2160
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Update"
      Height          =   375
      Left            =   4440
      TabIndex        =   9
      Top             =   3000
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Move"
      Height          =   495
      Left            =   4440
      TabIndex        =   6
      Top             =   1440
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   1800
      TabIndex        =   4
      Top             =   1440
      Width           =   2415
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   1440
      TabIndex        =   3
      Text            =   "NS_1000"
      Top             =   240
      Width           =   2775
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Load"
      Height          =   495
      Left            =   4440
      TabIndex        =   2
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Home Stage"
      Height          =   495
      Left            =   4440
      TabIndex        =   1
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label9 
      Height          =   255
      Left            =   2280
      TabIndex        =   16
      Top             =   3960
      Width           =   1935
   End
   Begin VB.Label Label8 
      Caption         =   "Current Smallest Step (nm):"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   3960
      Width           =   2055
   End
   Begin VB.Label Label7 
      Caption         =   "Current Final Speed (mm/s):"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   3480
      Width           =   2055
   End
   Begin VB.Label Label6 
      Height          =   255
      Left            =   2280
      TabIndex        =   13
      Top             =   3480
      Width           =   1935
   End
   Begin VB.Label Label5 
      Caption         =   "Go To Position (mm):"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   2280
      Width           =   1575
   End
   Begin VB.Label Label4 
      Height          =   255
      Left            =   2280
      TabIndex        =   8
      Top             =   3000
      Width           =   1935
   End
   Begin VB.Label Label3 
      Caption         =   "Current Position (mm):"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   3000
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "Distance (mm):"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1560
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Profile:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "StepperControlForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

    If NANOSTEPPER_TYPE = 1 Then NanoStep.Init (Text2.Text)
    NanoStep.MoveTrack Val(Text1.Text)
    Label4.Caption = NanoStep.CurrentPosition

End Sub

Private Sub Command3_Click()
    If NANOSTEPPER_TYPE = 1 Then MGNanoStep.Init (Text2.Text)
    NanoStep.HomeTrack
    Label4.Caption = NanoStep.CurrentPosition
End Sub

Private Sub Command2_Click()

    If NANOSTEPPER_TYPE = 1 Then MGNanoStep.Init (Text2.Text)

End Sub

Private Sub Command4_Click()

    NanoStep.UpdateNanoStepPositionCounter
    Label4.Caption = NanoStep.CurrentPosition
    
    NanoStep.UpdateNanoStepSpeed
    Label6.Caption = NanoStep.CurrentSpeed
    
    Label9.Caption = Format(1000000 * NanoStep.GetSmallestNanoStep, "0.000")

End Sub

Private Sub Command5_Click()
    If NANOSTEPPER_TYPE = 1 Then MGNanoStep.Init (Text2.Text)
    NanoStep.GoToPosition Val(Text3.Text)
    Label4.Caption = NanoStep.CurrentPosition
End Sub


Private Sub Form_Load()

    If NANOSTEPPER_TYPE = 2 Then
        StepperControlForm.Height = StepperControlForm.Height * 1.2
        StepperControlForm.Width = StepperControlForm.Width * 1.5
        MG17Motor1.Top = 0
        MG17Motor1.Left = 0
        MG17Motor1.Width = StepperControlForm.ScaleWidth
        MG17Motor1.Height = StepperControlForm.ScaleHeight
        'MG17Motor1.Visible = True
    ElseIf NANOSTEPPER_TYPE = 1 Then
        MG17Motor1.Visible = False
    End If
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: StepperControlForm.Hide

End Sub

Private Sub MG17Motor1_HomeComplete(ByVal lChanID As Long)
    NanoStep.CurrentPosition = StepperControlForm.MG17Motor1.GetPosition_Position(0)
End Sub

Private Sub MG17Motor1_MoveComplete(ByVal lChanID As Long)
    ThorlabsNanoStep.ThorLabsStepper_Moving = False
    NanoStep.CurrentPosition = StepperControlForm.MG17Motor1.GetPosition_Position(0)
End Sub

