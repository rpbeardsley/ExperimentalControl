VERSION 5.00
Begin VB.Form TraceAnalysis 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Trace Analysis"
   ClientHeight    =   4350
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7650
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4350
   ScaleWidth      =   7650
   Begin VB.CommandButton Command7 
      Caption         =   "Center On Zero"
      Height          =   495
      Left            =   1440
      TabIndex        =   7
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Crop"
      Height          =   495
      Left            =   120
      TabIndex        =   6
      Top             =   1920
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Save Trace"
      Height          =   495
      Left            =   1560
      TabIndex        =   5
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "DFT"
      Height          =   495
      Left            =   4320
      TabIndex        =   4
      Top             =   1920
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Hamming Window"
      Height          =   495
      Left            =   3000
      TabIndex        =   3
      Top             =   1920
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Browse"
      Height          =   375
      Left            =   5520
      TabIndex        =   2
      Top             =   120
      Width           =   1335
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   5295
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Open Trace"
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   1215
   End
End
Attribute VB_Name = "TraceAnalysis"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private AX()
Private AY()
Private AE()

Private Sub Command1_Click()

    Dim c As String
    Dim a As String

    a = Text1.Text
    
    If a <> "" And FileExists(a) Then
    
        b = FreeFile
        Open a For Input As #b
            Line Input #b, datatype
        Close #b
    
        If datatype = ";Averaged Step-by-step Pump-Probe data" Then
            LoadAveragedPPData (a)
        ElseIf datatype = ";Raw Step-by-step Pump-Probe data" Then
            LoadRawPPData (a)
        Else
            MsgBox "Unrecognised data type", vbExclamation, "Error"
        End If
    
        TraceForm.PlotTrace AX, AY
    
    End If
    
End Sub

Private Sub Command2_Click()
    a = Globals.OpenDialog
    If a <> "" Then Text1.Text = a
End Sub

Private Sub Command3_Click()

    Dim tmp()
    
    ReDim tmp(LBound(AY) To UBound(AY))

    success = Globals.HammingWindow(AY, tmp)
    For a = LBound(tmp) To UBound(tmp)
        AY(a) = tmp(a)
        AE(a) = 0
    Next a

    TraceForm.PlotTrace AX, AY

End Sub

Private Sub Command5_Click()

    If FileExists(Text1.Text) Then
        ret = MsgBox("Are you sure you want to overwrite the file?", vbExclamation Or vbYesNo, "File Exists")
    Else
        ret = 6
    End If

    If ret = 6 Then
    
        b = FreeFile
        Open Text1.Text For Output As #b
    
        strng = "/td" + vbTab + Chr(34) + "xye" + Chr(34) + vbTab + vbTab + ";define the columns"
        Print #b, strng
        
        For a = LBound(AY) To UBound(AY)
            Print #b, Format(AX(a)) + ", " + Format(AY(a)) + ", " + Format(AE(a))
        Next a
        
        Close #b
    
    End If


End Sub


Private Sub Command6_Click()

    Dim croppedX()
    Dim croppedY()
    Dim croppedE()
    
    G = TraceForm.GetGates
    
    ReDim croppedX(0 To UBound(AX))
    ReDim croppedY(0 To UBound(AY))
    ReDim croppedE(0 To UBound(AE))
    
    CropData AX, AY, G(3), G(4), croppedX, croppedY

    ReDim AX(0 To (1 + UBound(croppedX) - LBound(croppedX)))
    ReDim AY(0 To (1 + UBound(croppedX) - LBound(croppedX)))
    ReDim AE(0 To (1 + UBound(croppedX) - LBound(croppedX)))
    
    For a = 0 To (1 + UBound(croppedX) - LBound(croppedX))
        AX(a) = croppedX(a)
        AY(a) = croppedY(a)
        AE(a) = croppedE(a)
    Next a
    
    TraceForm.PlotTrace AX, AY

End Sub

Private Sub Command7_Click()

s = 0
er = 0
For a = LBound(AY) To UBound(AY)

    s = s + AY(a)
    er = er + Abs(AE(a))

Next a

s = s / (1 + UBound(AY) - LBound(AY))
er = er / (1 + UBound(AY) - LBound(AY))

For a = LBound(AY) To UBound(AY)

    AY(a) = AY(a) - s
    AE(a) = AE(a) + er

Next a

TraceForm.PlotTrace AX, AY

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: TraceAnalysis.Hide

End Sub

Private Sub LoadRawPPData(a)

    b = FreeFile
    Open a For Input As #b
    
    While Not EOF(b)
    Wend
    
    Close #b

End Sub

Private Sub LoadAveragedPPData(a)

        Dim c As String

        b = FreeFile
        Open a For Input As #b

        ReDim AX(0 To 0)
        ReDim AY(0 To 0)
        ReDim AE(0 To 0)
        
        n = 0
        While Not EOF(b)
        
            Line Input #b, c
            If Left(c, 1) <> "/" And Left(c, 1) <> ";" Then
                ReDim Preserve AX(0 To n)
                ReDim Preserve AY(0 To n)
                ReDim Preserve AE(0 To n)
                
                split_delimited_string c, ",", out
                AX(n) = Val(out(0))
                AY(n) = Val(out(1))
                AE(n) = Val(out(2))
                n = n + 1
            End If
            
        Wend
        Close #b

End Sub
