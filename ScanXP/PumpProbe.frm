VERSION 5.00
Begin VB.Form PumpProbe 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PumpProbe"
   ClientHeight    =   1755
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7515
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1755
   ScaleWidth      =   7515
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   2400
      TabIndex        =   5
      Text            =   "1"
      Top             =   1170
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2400
      TabIndex        =   3
      Top             =   720
      Width           =   3255
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   2400
      TabIndex        =   1
      Top             =   240
      Width           =   3255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Scan"
      Height          =   495
      Left            =   6120
      TabIndex        =   0
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Time between points (s):"
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   1200
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "Output Filename:"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   720
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Distance:"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "PumpProbe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private TimerInterval As Integer
Private PrevTime As Single
Private StartTime As Single

Private Sub Command1_Click()

    If FileExists(Text2.Text) Then
        ret = MsgBox("Are you sure you want to overwrite the file?", vbExclamation Or vbYesNo, "File Exists")
    Else
        ret = 6
    End If
    
    If ret = 6 Then
    
        Text1.Enabled = False
        Text2.Enabled = False
        Text3.Enabled = False
        Text3.Text = Mid(Str(Int(Val(Text3.Text) * 1000) / 1000), 2)
        TimerInterval = Int(Val(Text3.Text))
    
        GraphForm.GraphInit
    
        Open Text2.Text For Output As #10
    
        GPIB.ResetDeviceInterface LOCKIN_ADDR
    
        Call TimerEnable
    
        NanoStep.CallBackRedirection = 1
        NanoStep.MoveTrackWithCallback (Val(Text1.Text))
    
        'After track has finished moving
        'Timer1.Enabled = False
        NanoStep.CallBackRedirection = 0
        Text1.Enabled = True
        Text2.Enabled = True
        Text3.Enabled = True
        
        Close #10
        
    End If

End Sub

Private Sub TimerExecute()

    Dim success As Boolean
    Dim readtime

    t = -1
    success = False
    valu = SRS830_ReadChannel(LOCKIN_ADDR, 3, t, success) 'Read Magnitude

    t = t - StartTime

    If (success = True And t > -1) Then
        GraphForm.AddPointToGraph t, valu
        Print #10, Mid(Str(t), 2) + ", " + Mid(Str(valu), 2)
        DoEvents
    End If
    
End Sub

Public Sub TimerEnable()
    PrevTime = Timer
    StartTime = PrevTime
End Sub

Public Sub PPCheckTimer()
    
    t = Timer
    If t - PrevTime > TimerInterval Then
        PrevTime = t
        Call TimerExecute
    End If
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: PumpProbe.Hide

End Sub
