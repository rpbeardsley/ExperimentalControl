VERSION 5.00
Begin VB.Form MirrorForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mirror Control"
   ClientHeight    =   7710
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7290
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7710
   ScaleWidth      =   7290
   Begin VB.HScrollBar HScroll1 
      Height          =   255
      LargeChange     =   900
      Left            =   720
      Max             =   25000
      Min             =   -25000
      SmallChange     =   45
      TabIndex        =   17
      Top             =   5280
      Width           =   6135
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   5055
      LargeChange     =   900
      Left            =   360
      Max             =   -25000
      Min             =   25000
      SmallChange     =   45
      TabIndex        =   16
      Top             =   120
      Value           =   -25000
      Width           =   255
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Clear"
      Height          =   495
      Left            =   5520
      TabIndex        =   15
      Top             =   6840
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   5520
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   5760
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Centre"
      Height          =   495
      Left            =   5520
      TabIndex        =   12
      Top             =   6240
      Width           =   1215
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   4080
      TabIndex        =   11
      Text            =   "0"
      Top             =   6960
      Width           =   1215
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   2640
      TabIndex        =   10
      Text            =   "0"
      Top             =   6960
      Width           =   1215
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   4080
      TabIndex        =   8
      Text            =   "0"
      Top             =   6600
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   2640
      TabIndex        =   7
      Text            =   "0"
      Top             =   6600
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   4080
      TabIndex        =   4
      Text            =   "0"
      Top             =   6240
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   2640
      TabIndex        =   2
      Text            =   "0"
      Top             =   6240
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   5055
      Left            =   720
      ScaleHeight     =   335
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   407
      TabIndex        =   0
      Top             =   120
      Width           =   6135
   End
   Begin VB.Label Label6 
      Caption         =   "Scale:"
      Height          =   255
      Left            =   4920
      TabIndex        =   13
      Top             =   5760
      Width           =   615
   End
   Begin VB.Label Label5 
      Caption         =   "Offset / mm:"
      Height          =   255
      Left            =   840
      TabIndex        =   9
      Top             =   6960
      Width           =   1575
   End
   Begin VB.Label Label4 
      Caption         =   "Centre / mm:"
      Height          =   255
      Left            =   840
      TabIndex        =   6
      Top             =   6600
      Width           =   1575
   End
   Begin VB.Label Label3 
      Caption         =   "Y"
      Height          =   255
      Left            =   4560
      TabIndex        =   5
      Top             =   5880
      Width           =   255
   End
   Begin VB.Label Label2 
      Caption         =   "X"
      Height          =   255
      Left            =   3120
      TabIndex        =   3
      Top             =   5880
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "Current Position / mm:"
      Height          =   255
      Left            =   840
      TabIndex        =   1
      Top             =   6240
      Width           =   1575
   End
End
Attribute VB_Name = "MirrorForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Mirror coordinates of parts of the picture box window
Private WindowTop
Private WindowLeft
Private WindowWidth
Private WindowHeight

Private HScrollIgnore As Boolean
Private VScrollIgnore As Boolean

Private Sub Combo1_Click()

    UpdateWindowBounds
    ClearMirrorWindow
    UpdateScrollBarX (CurrentMirrorX)
    UpdateScrollBarY (CurrentMirrorY)

End Sub

Private Sub Command1_Click()

    MirrorCentreX = CurrentMirrorX
    MirrorCentreY = CurrentMirrorY
    Text3.Text = Format(MirrorCentreX, "0.00000")
    Text4.Text = Format(MirrorCentreY, "0.00000")
    UpdateWindowBounds
    UpdateOffset
    ClearMirrorWindow
    
    UpdateScrollBarY (CurrentMirrorY)
    UpdateScrollBarX (CurrentMirrorX)
    
End Sub

Private Sub Command6_Click()
ClearMirrorWindow
End Sub



Private Sub Form_Click()
MirrorForm.SetFocus
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyLeft Then HScroll1.value = HScroll1.value - HScroll1.SmallChange
If KeyCode = vbKeyRight Then HScroll1.value = HScroll1.value + HScroll1.SmallChange
If KeyCode = vbKeyUp Then VScroll1.value = VScroll1.value + VScroll1.SmallChange
If KeyCode = vbKeyDown Then VScroll1.value = VScroll1.value - VScroll1.SmallChange

KeyCode = 0 'prevents controls from receiving the keypress
End Sub

Private Sub Form_Load()

    Combo1.Clear
    Combo1.AddItem ("0.5mm x 0.5mm")
    Combo1.AddItem ("1mm x 1mm")
    Combo1.AddItem ("2mm x 2mm")
    Combo1.AddItem ("5mm x 5mm")
    Combo1.AddItem ("9mm x 9mm")
    Combo1.ListIndex = 0
    
    HScrollIgnore = False
    VScrollIgnore = False
    
    Text1.Text = CurrentMirrorX
    Text2.Text = CurrentMirrorY
    Command1_Click

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    
    If UnloadMode = 0 Then Cancel = 1: MirrorForm.Hide

End Sub

Private Sub HScroll1_Change()

    Dim successX As Integer
    Dim status As Integer

    'Suppress changing anything if the change in position
    'was initiated from code
    If Not (HScrollIgnore) Then

        newX = MirrorCentreX + HScroll1.value * (GetScaleFromIndex(Combo1.ListIndex) / 25000)
    
        status = Mirrors.MoveXMirror(newX)
        If status = 0 Then NewPosX = Mirrors.GetXMirrorPos(successX)
        
        If successX = 0 Then
        
            NX = (NewPosX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
            NY = (WindowTop - CurrentMirrorY) * (Picture1.ScaleHeight / WindowHeight)
            plotpoint NX, NY
            
            Text1.Text = Format(NewPosX, "0.00000")
            
            CurrentMirrorX = NewPosX
            UpdateOffset
            
            'Update scrollbar to real position - if real position is off screen then rescale to min scale
            UpdateScrollBarX (NewPosX)
        
        ElseIf successX = 1 Then
            MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
            UpdateScrollBarX (CurrentMirrorX)
        End If
        
    End If

End Sub

Private Sub Picture1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

    Dim mirrorcoordsX As Single
    Dim mirrorcoordsY As Single
    Dim NewPosX As Single
    Dim NewPosY As Single
    Dim status As Integer
    
    mirrorcoordsX = WindowLeft + WindowWidth * (X / Picture1.ScaleWidth)
    mirrorcoordsY = WindowTop - WindowHeight * (Y / Picture1.ScaleHeight)

    status = Mirrors.MoveXMirror(mirrorcoordsX)
    If status = 0 Then status = Mirrors.MoveYMirror(mirrorcoordsY)
    If status = 0 Then NewPosX = Mirrors.GetXMirrorPos(status)
    If status = 0 Then NewPosY = Mirrors.GetYMirrorPos(status)
    
    
    If (status = 0) Then
    
        NX = (NewPosX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
        NY = (WindowTop - NewPosY) * (Picture1.ScaleHeight / WindowHeight)
   
        plotpoint NX, NY
        
        Text1.Text = Format(NewPosX, "0.00000")
        Text2.Text = Format(NewPosY, "0.00000")
        
        CurrentMirrorX = NewPosX
        CurrentMirrorY = NewPosY
        
        UpdateOffset
        UpdateScrollBarX (NewPosX)
        UpdateScrollBarY (NewPosY)
    
    ElseIf status = 1 Then
        MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
    End If

End Sub

Private Sub Text1_LostFocus()

    Dim status As Integer

    newX = Val(Text1.Text)
    status = Mirrors.MoveXMirror(newX)
    If status = 0 Then NewPosX = Mirrors.GetXMirrorPos(status)
    
    If status = 0 Then
    
        NX = (NewPosX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
        NY = (WindowTop - CurrentMirrorY) * (Picture1.ScaleHeight / WindowHeight)
        plotpoint NX, NY
        
        Text1.Text = Format(NewPosX, "0.00000")
        
        CurrentMirrorX = NewPosX
        UpdateOffset
        
        UpdateScrollBarX (NewPosX)
    
    ElseIf status = 1 Then
        MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
        Text1.Text = Format(CurrentMirrorX, "0.00000")
    End If

End Sub

Private Sub Text2_LostFocus()

    Dim status As Integer

    newY = Val(Text2.Text)
    status = Mirrors.MoveYMirror(newY)
    If status = 0 Then NewPosY = Mirrors.GetYMirrorPos(status)
    
    If status = 0 Then
    
        NX = (CurrentMirrorX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
        NY = (WindowTop - NewPosY) * (Picture1.ScaleHeight / WindowHeight)
        plotpoint NX, NY
        
        Text2.Text = Format(NewPosY, "0.00000")
        
        CurrentMirrorY = NewPosY
        UpdateOffset
        
        UpdateScrollBarY (NewPosY)
    
    ElseIf status = 1 Then
        MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
        Text2.Text = Format(CurrentMirrorY, "0.00000")
    End If

End Sub

Private Sub Text3_LostFocus()
    
    MirrorCentreX = Val(Text3.Text)

    UpdateOffset
    UpdateWindowBounds
    ClearMirrorWindow
    
    UpdateScrollBarX (CurrentMirrorX)
    
End Sub

Private Sub UpdateOffset()

    OffsetX = CurrentMirrorX - MirrorCentreX
    OffsetY = CurrentMirrorY - MirrorCentreY
    Text5.Text = Format(OffsetX, "0.00000")
    Text6.Text = Format(OffsetY, "0.00000")

End Sub

Private Sub Text4_LostFocus()

    MirrorCentreY = Val(Text4.Text)

    UpdateOffset
    UpdateWindowBounds
    ClearMirrorWindow
        
    UpdateScrollBarY (CurrentMirrorY)
    
End Sub

Private Sub UpdateWindowBounds()

    s = GetScaleFromIndex(Combo1.ListIndex)
    WindowTop = MirrorCentreY + s
    WindowHeight = 2 * s
    WindowLeft = MirrorCentreX - s
    WindowWidth = 2 * s
    
End Sub

Private Function GetScaleFromIndex(i)

    If i = 1 Then
        GetScaleFromIndex = 0.5
    ElseIf i = 2 Then
        GetScaleFromIndex = 1
    ElseIf i = 3 Then
        GetScaleFromIndex = 2.5
    ElseIf i = 4 Then
        GetScaleFromIndex = 4.5
    Else
        GetScaleFromIndex = 0.25
    End If
    
End Function

Private Sub Text5_LostFocus()
    
    Dim status As Integer
    
    newX = MirrorCentreX + Val(Text5.Text)
    status = Mirrors.MoveXMirror(newX)
    If status = 0 Then NewPosX = Mirrors.GetXMirrorPos(status)
    
    If status = 0 Then
    
        NX = (NewPosX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
        NY = (WindowTop - CurrentMirrorY) * (Picture1.ScaleHeight / WindowHeight)
        plotpoint NX, NY
        
        Text1.Text = Format(NewPosX, "0.00000")
        
        CurrentMirrorX = NewPosX
        UpdateOffset
        
        UpdateScrollBarX (NewPosX)
    
    ElseIf status = 1 Then
        MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
        UpdateOffset
    End If
    
End Sub

Private Sub Text6_LostFocus()

    Dim status As Integer

    newY = MirrorCentreY + Val(Text6.Text)
    status = Mirrors.MoveYMirror(newY)
    If status = 0 Then NewPosY = Mirrors.GetYMirrorPos(status)
    
    If status = 0 Then
    
        NX = (CurrentMirrorX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
        NY = (WindowTop - NewPosY) * (Picture1.ScaleHeight / WindowHeight)
        plotpoint NX, NY
        
        Text2.Text = Format(NewPosY, "0.00000")
        
        CurrentMirrorY = NewPosY
        UpdateOffset
        
        UpdateScrollBarY (NewPosY)
    
    ElseIf status = 1 Then
        MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
        UpdateOffset
    End If


End Sub

Private Sub ClearMirrorWindow()

    Picture1.Cls
    Picture1.DrawMode = 13
    Picture1.Line (0, Picture1.ScaleHeight / 2)-(Picture1.Width, Picture1.ScaleHeight / 2), QBColor(15)
    Picture1.Line (Picture1.ScaleWidth / 2, 0)-(Picture1.ScaleWidth / 2, Picture1.ScaleHeight), QBColor(15)
    
    'Calculate pixel coordinates of mirror limits
    leftlimit = ((-10 * MIRROR_DISTANCE_TO_VOLTAGE_RATIO) - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
    rightlimit = ((10 * MIRROR_DISTANCE_TO_VOLTAGE_RATIO) - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
    toplimit = (WindowTop - (10 * MIRROR_DISTANCE_TO_VOLTAGE_RATIO)) * (Picture1.ScaleHeight / WindowHeight)
    bottomlimit = (WindowTop + (10 * MIRROR_DISTANCE_TO_VOLTAGE_RATIO)) * (Picture1.ScaleHeight / WindowHeight)

    'Draw bounding box of mirror limits
    Picture1.Line (leftlimit, toplimit)-(rightlimit, toplimit), QBColor(2)
    Picture1.Line (leftlimit, bottomlimit)-(rightlimit, bottomlimit), QBColor(2)
    Picture1.Line (leftlimit, toplimit)-(leftlimit, bottomlimit), QBColor(2)
    Picture1.Line (rightlimit, toplimit)-(rightlimit, bottomlimit), QBColor(2)
   
End Sub

Private Sub VScroll1_Change()
 
    Dim status As Integer
 
    If Not (VScrollIgnore) Then
 
        newY = MirrorCentreY + VScroll1.value * (GetScaleFromIndex(Combo1.ListIndex) / 25000)
    
        status = Mirrors.MoveYMirror(newY)
        If status = 0 Then NewPosY = Mirrors.GetYMirrorPos(status)
        
        If status = 0 Then
        
            NX = (CurrentMirrorX - WindowLeft) * (Picture1.ScaleWidth / WindowWidth)
            NY = (WindowTop - NewPosY) * (Picture1.ScaleHeight / WindowHeight)
            plotpoint NX, NY
            
            Text2.Text = Format(NewPosY, "0.00000")
            
            CurrentMirrorY = NewPosY
            UpdateOffset
            
            UpdateScrollBarY (NewPosY)
        
        ElseIf status = 1 Then
            MsgBox "Error receiving mirror positions - positions may be unreliable.", vbExclamation, "Mirror Error"
            UpdateScrollBarY (CurrentMirrorY)
        End If

    End If

End Sub

Private Sub UpdateScrollBarX(NewPosX)

    'Update scrollbar to real position - if real position is off screen then rescale to min scale
    sbv = (NewPosX - MirrorCentreX) * (25000 / GetScaleFromIndex(Combo1.ListIndex))
    If Abs(sbv) > 25000 Then
        Combo1.ListIndex = 4
        UpdateWindowBounds
        ClearMirrorWindow
        sbv = (NewPosX - MirrorCentreX) * (25000 / GetScaleFromIndex(Combo1.ListIndex))
    End If
    
    HScrollIgnore = True
    HScroll1.value = sbv
    HScrollIgnore = False

End Sub

Public Sub UpdateScrollBarY(NewPosY)

    'Update scrollbar to real position - if real position is off screen then rescale to min scale
    sbv = (NewPosY - MirrorCentreY) * (25000 / GetScaleFromIndex(Combo1.ListIndex))
    If Abs(sbv) > 25000 Then
        Combo1.ListIndex = 4
        UpdateWindowBounds
        ClearMirrorWindow
        sbv = (NewPosY - MirrorCentreY) * (25000 / GetScaleFromIndex(Combo1.ListIndex))
    End If
    
    VScrollIgnore = True
    VScroll1.value = sbv
    VScrollIgnore = False
    
End Sub

Private Sub plotpoint(NX, NY)

        'Picture1.DrawMode = 6
        Picture1.Circle (NX, NY), 1, QBColor(14)
        'Picture1.DrawMode = 13

End Sub
