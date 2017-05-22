VERSION 5.00
Begin VB.Form TraceForm 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   8385
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10560
   ClipControls    =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   MousePointer    =   2  'Cross
   ScaleHeight     =   559
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   704
   Begin VB.TextBox Text8 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0FF&
      Height          =   285
      Left            =   1320
      TabIndex        =   13
      Text            =   "0"
      Top             =   855
      Width           =   1095
   End
   Begin VB.TextBox Text7 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0FF&
      Height          =   285
      Left            =   2520
      TabIndex        =   12
      Text            =   "0"
      Top             =   855
      Width           =   1095
   End
   Begin VB.TextBox Text6 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFF80&
      Height          =   285
      Left            =   4920
      MousePointer    =   3  'I-Beam
      TabIndex        =   11
      Text            =   "0"
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox Text5 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFF80&
      Height          =   285
      Left            =   3720
      MousePointer    =   3  'I-Beam
      TabIndex        =   10
      Text            =   "0"
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox Text4 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Height          =   285
      Left            =   2520
      MousePointer    =   3  'I-Beam
      TabIndex        =   9
      Text            =   "0"
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox Text3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Height          =   285
      Left            =   1320
      MousePointer    =   3  'I-Beam
      TabIndex        =   7
      Text            =   "0"
      Top             =   480
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Unzoom"
      Height          =   375
      Left            =   8880
      MousePointer    =   1  'Arrow
      TabIndex        =   6
      Top             =   600
      Width           =   1455
   End
   Begin VB.CheckBox Check1 
      BackColor       =   &H00000000&
      Caption         =   "Auto Scale"
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   4440
      MousePointer    =   1  'Arrow
      TabIndex        =   5
      Top             =   68
      Value           =   1  'Checked
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Refresh"
      Height          =   375
      Left            =   8880
      MousePointer    =   1  'Arrow
      TabIndex        =   4
      Top             =   120
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   3600
      MousePointer    =   3  'I-Beam
      TabIndex        =   3
      Text            =   "1000"
      Top             =   113
      Width           =   495
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1440
      MousePointer    =   3  'I-Beam
      TabIndex        =   1
      Text            =   "200"
      Top             =   113
      Width           =   615
   End
   Begin VB.Label Label4 
      BackColor       =   &H00000000&
      Caption         =   "Mouse Position:"
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   120
      TabIndex        =   14
      Top             =   870
      Width           =   1575
   End
   Begin VB.Label Label3 
      BackColor       =   &H00000000&
      Caption         =   "Gate Positions:"
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   120
      TabIndex        =   8
      Top             =   495
      Width           =   1575
   End
   Begin VB.Label Label2 
      BackColor       =   &H00000000&
      Caption         =   "Y-Scale (mV/div):"
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   2280
      TabIndex        =   2
      Top             =   128
      Width           =   1575
   End
   Begin VB.Label Label1 
      BackColor       =   &H00000000&
      Caption         =   "X-Scale (ns/div):"
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   120
      TabIndex        =   0
      Top             =   135
      Width           =   1575
   End
End
Attribute VB_Name = "TraceForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public NumberOfGridLines As Integer
Private CurrentPlotXData() As Double
Private CurrentPlotYData() As Double

Private region_top
Private region_left
Private region_bottom
Private region_right
Private zoom_mode As Integer

Private zoom_minx
Private zoom_miny
Private zoom_maxx
Private zoom_maxy

Private c_minx
Private c_miny
Private c_maxx
Private c_maxy

Private setgate_mode As Integer
Private TraceFormGatePos(1 To 4)

Public Function PlotTrace(x, y, Optional opt = 1)

    lowerbound = LBound(x)
    upperbound = UBound(x)
    
    If lowerbound = upperbound Then GoTo ext
    
    'Normally we clear the storage arrays to make way for new data
    'When refreshing, however, we don't as we are reading from the
    'very same arrays!
    If opt = 1 Then
        ReDim CurrentPlotXData(lowerbound To upperbound)
        ReDim CurrentPlotYData(lowerbound To upperbound)
    End If

    TraceForm.Cls
    TraceForm.ForeColor = QBColor(2)

    'Find axes limits
    minx = x(lowerbound)
    miny = y(lowerbound)
    maxx = x(upperbound)
    maxy = y(upperbound)
    For a = lowerbound To upperbound
    
          If x(a) > maxx Then maxx = x(a)
          If x(a) < minx Then minx = x(a)
          If y(a) > maxy Then maxy = y(a)
          If y(a) < miny Then miny = y(a)
          
          CurrentPlotXData(a) = x(a)
          CurrentPlotYData(a) = y(a)
          
    Next a
    
    'Check for a user-defined zoom window and adjust the min and max x and y values if there is one
    If zoom_mode = 2 Then
        maxx = zoom_maxx
        maxy = zoom_maxy
        minx = zoom_minx
        miny = zoom_miny
        Check1.value = 1
    End If
    
    'Check for manual or auto-scaling
    If Check1.value = 1 Then
        'Update Text Boxes
        Text1.Text = Format((maxx - minx) / NumberOfGridLines, "0.00e-00")
        Text2.Text = Format((maxy - miny) / NumberOfGridLines, "0.00e-00")
    ElseIf (Check1.value = 0) Then
        'Adjust Axes limits according to values in text boxes
        maxy = miny + Val(Text2.Text) * NumberOfGridLines
        maxx = minx + Val(Text1.Text) * NumberOfGridLines
    End If
        
    'Check for stupid values
    If maxy = miny Then maxy = miny + 1
    If maxx = minx Then maxx = minx + 1
    
    'Save current max and min values
    c_maxx = maxx
    c_maxy = maxy
    c_minx = minx
    c_miny = miny
        
    'Draw grid and labels
    'Vertical lines
    For a = 0 To NumberOfGridLines
        gridlineval = minx + a * (maxx - minx) / NumberOfGridLines
        gridlinepos = PixelFromValueX(gridlineval, minx, maxx)
        textpos = gridlinepos + 2
        TraceForm.Line (gridlinepos, PixelFromValueY(miny, miny, maxy))-(gridlinepos, PixelFromValueY(maxy, miny, maxy)), QBColor(2)
    
        TraceForm.CurrentX = textpos
        If (miny <= 0 And maxy >= 0) Then 'If x-axis is visible put the labels under it. If not put them at the bottom
            TraceForm.CurrentY = PixelFromValueY(0, miny, maxy)
        Else
            TraceForm.CurrentY = PixelFromValueY(miny, miny, maxy)
        End If
        TraceForm.Print Format(gridlineval, "0.00")
    Next a
    
    'Horizontal grid lines
    For a = 0 To NumberOfGridLines
        gridlineval = miny + a * (maxy - miny) / NumberOfGridLines
        gridlinepos = PixelFromValueY(gridlineval, miny, maxy)
        TraceForm.Line (PixelFromValueX(minx, minx, maxx), gridlinepos)-(PixelFromValueX(maxx, minx, maxx), gridlinepos), QBColor(2)
    Next a
    
    'Draw Axes
    TraceForm.Line (PixelFromValueX(0, minx, maxx), PixelFromValueY(miny, miny, maxy))-(PixelFromValueX(0, minx, maxx), PixelFromValueY(maxy, miny, maxy)), QBColor(10)
    TraceForm.Line (PixelFromValueX(minx, minx, maxx), PixelFromValueY(0, miny, maxy))-(PixelFromValueX(maxx, minx, maxx), PixelFromValueY(0, miny, maxy)), QBColor(10)
    
    'Calculates the x data step equivalent to one pixel
    delta = Abs((maxx - minx) / (w - 80))
    
    'Draw Data
    lastX = x(lowerbound)
    lastY = y(lowerbound)
    For a = lowerbound + 1 To upperbound
    
        If Abs(x(a) - lastX) > delta Then 'Only plot if step is big enough to see - saves time
            TraceForm.Line (PixelFromValueX(lastX, minx, maxx), PixelFromValueY(lastY, miny, maxy))-(PixelFromValueX(x(a), minx, maxx), PixelFromValueY(y(a), miny, maxy)), QBColor(15)
            lastX = x(a)
            lastY = y(a)
        End If
          
    Next a

    'Black out areas outside axes.
    TraceForm.Line (0, 0)-(TraceForm.ScaleWidth, PixelFromValueY(maxy, miny, maxy) - 5), QBColor(0), BF
    TraceForm.Line (0, TraceForm.ScaleHeight)-(TraceForm.ScaleWidth, PixelFromValueY(miny, miny, maxy) + TraceForm.TextHeight("1234567890.") + 2), QBColor(0), BF
    TraceForm.Line (0, 0)-(PixelFromValueX(minx, minx, maxx) - 5, TraceForm.ScaleHeight), QBColor(0), BF
    TraceForm.Line (TraceForm.ScaleWidth, 0)-(PixelFromValueX(maxx, minx, maxx) + 5, TraceForm.ScaleHeight), QBColor(0), BF

    'Vertical axis labels
    For a = 0 To NumberOfGridLines
        textval = miny + a * (maxy - miny) / NumberOfGridLines
        textpos = PixelFromValueY(textval, miny, maxy)
        txt = Format(textval, "0.00e-00")
        TraceForm.CurrentY = textpos
        If (minx <= 0 And maxx >= 0) Then 'If x-axis is visible put the labels under it. If not put them at the bottom
            TraceForm.CurrentX = PixelFromValueX(0, minx, maxx) - (TraceForm.TextWidth(txt) + 2)
        Else
            TraceForm.CurrentX = PixelFromValueX(minx, minx, maxx) - (TraceForm.TextWidth(txt) + 2)
        End If
        TraceForm.Print txt
    Next
 
ext:
 
End Function

Private Function PixelFromValueX(v, minx, maxx)

    w = TraceForm.ScaleWidth
    
    axislength = w - 100
    
    PixelFromValueX = 60 + ((v - minx) / (maxx - minx)) * axislength

End Function

Private Function PixelFromValueY(v, miny, maxy)

    H = TraceForm.ScaleHeight
    
    axislength = H - (40 + 100) 'Top is at 100 pixels.
    
    PixelFromValueY = (H - 40) - ((v - miny) / (maxy - miny)) * axislength

End Function

Private Function ValueFromPixelY(p, miny, maxy)

    H = TraceForm.ScaleHeight
    
    axislength = H - (40 + 100)
    
    ValueFromPixelY = (miny - maxy) * ((40 + p - H) / axislength) + miny

End Function

Private Function ValueFromPixelX(p, minx, maxx)

    w = TraceForm.ScaleWidth
    
    axislength = w - 100
    
    ValueFromPixelX = ((p - 60) / axislength) * (maxx - minx) + minx

End Function

Private Sub Command1_Click()
PlotTrace CurrentPlotXData, CurrentPlotYData, 0
End Sub

Private Sub Command2_Click()
zoom_mode = 0
PlotTrace CurrentPlotXData, CurrentPlotYData, 0
End Sub

Private Sub Command3_Click()
TraceForm.DrawMode = 7
TraceForm.Line (0, 0)-(200, 200), QBColor(11), BF
TraceForm.DrawMode = 13
End Sub

Private Sub Form_Load()
NumberOfGridLines = 10
zoom_mode = 0

c_maxx = 1
c_minx = 0
c_maxy = 1
c_miny = 0

TraceFormGatePos(1) = 155
TraceFormGatePos(2) = 175
TraceFormGatePos(3) = 185
TraceFormGatePos(4) = 585

End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    If (Button And 1 > 0) Then
    
        If setgate_mode = 0 Then
            TraceForm.DrawMode = 6
            region_top = y
            region_left = x
            region_bottom = y
            region_right = x
            zoom_mode = 1
            TraceForm.Line (region_left, region_top)-(region_right, region_bottom), , B
        Else
            SetGatePos x, y
        End If
        
    End If
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    
    Text8.Text = Format(ValueFromPixelX(x, c_minx, c_maxx), "0.00") + " ns"
    Text7.Text = Format(ValueFromPixelY(y, c_miny, c_maxy), "0.00e-00") + " mV"
    
    If zoom_mode = 1 Then
        TraceForm.Line (region_left, region_top)-(region_right, region_bottom), , B
        region_bottom = y
        region_right = x
        TraceForm.Line (region_left, region_top)-(region_right, region_bottom), , B
    End If
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    If zoom_mode = 1 Then
        TraceForm.Line (region_left, region_top)-(region_right, region_bottom), , B
        region_bottom = y
        region_right = x
        
        If ((region_bottom <> region_top) And (region_left <> region_right)) Then
        
            zoom_mode = 2
            TraceForm.DrawMode = 13
            
            If region_left > region_right Then
                a = region_left
                region_left = region_right
                region_right = a
            End If
            
            If region_top > region_bottom Then
                a = region_top
                region_top = region_bottom
                region_bottom = a
            End If
            
            zoom_minx = ValueFromPixelX(region_left, c_minx, c_maxx)
            zoom_maxx = ValueFromPixelX(region_right, c_minx, c_maxx)
            zoom_miny = ValueFromPixelY(region_bottom, c_miny, c_maxy)
            zoom_maxy = ValueFromPixelY(region_top, c_miny, c_maxy)
            
            PlotTrace CurrentPlotXData, CurrentPlotYData, 0
        
        Else
            zoom_mode = 0
        End If
        
    End If
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: TraceForm.Hide
    
End Sub

Private Sub Text3_Click()

    If setgate_mode = 0 Then ShowGates

    If setgate_mode <> 1 Then
        setgate_mode = 1
        Text3.BackColor = QBColor(15)
        Text4.BackColor = &HC0C0C0
        Text5.BackColor = &HFFFF80
        Text6.BackColor = &HFFFF80
    Else
        setgate_mode = 0
        Text3.BackColor = &HC0C0C0
        PlotTrace CurrentPlotXData, CurrentPlotYData, 0
    End If
End Sub

Private Sub Text4_Click()

    If setgate_mode = 0 Then ShowGates

    If setgate_mode <> 2 Then
        setgate_mode = 2
        Text4.BackColor = QBColor(15)
        Text3.BackColor = &HC0C0C0
        Text5.BackColor = &HFFFF80
        Text6.BackColor = &HFFFF80
    Else
        setgate_mode = 0
        Text4.BackColor = &HC0C0C0
        PlotTrace CurrentPlotXData, CurrentPlotYData, 0
    End If
        
End Sub

Private Sub Text5_Click()

    If setgate_mode = 0 Then ShowGates

    If setgate_mode <> 3 Then
        setgate_mode = 3
        Text5.BackColor = QBColor(15)
        Text3.BackColor = &HC0C0C0
        Text4.BackColor = &HC0C0C0
        Text6.BackColor = &HFFFF80
    Else
        setgate_mode = 0
        Text5.BackColor = &HFFFF80
        PlotTrace CurrentPlotXData, CurrentPlotYData, 0
    End If
End Sub

Private Sub Text6_Click()

    If setgate_mode = 0 Then ShowGates

    If setgate_mode <> 4 Then
        setgate_mode = 4
        Text6.BackColor = QBColor(15)
        Text3.BackColor = &HC0C0C0
        Text4.BackColor = &HC0C0C0
        Text5.BackColor = &HFFFF80
    Else
        setgate_mode = 0
        Text6.BackColor = &HFFFF80
        PlotTrace CurrentPlotXData, CurrentPlotYData, 0
    End If
End Sub

Private Sub SetGatePos(x, y)

    If setgate_mode > 0 And setgate_mode < 5 Then
        If setgate_mode < 3 Then col = &HC0C0C0 Else col = &HFFFF80
        TraceForm.DrawMode = 7
        TraceForm.Line (PixelFromValueX(TraceFormGatePos(setgate_mode), c_minx, c_maxx), PixelFromValueY(c_miny, c_miny, c_maxy))-(PixelFromValueX(TraceFormGatePos(setgate_mode), c_minx, c_maxx), PixelFromValueY(c_maxy, c_miny, c_maxy)), col
        a = ValueFromPixelX(x, c_minx, c_maxx)
        TraceFormGatePos(setgate_mode) = a
        TraceForm.Line (PixelFromValueX(TraceFormGatePos(setgate_mode), c_minx, c_maxx), PixelFromValueY(c_miny, c_miny, c_maxy))-(PixelFromValueX(TraceFormGatePos(setgate_mode), c_minx, c_maxx), PixelFromValueY(c_maxy, c_miny, c_maxy)), col
        TraceForm.DrawMode = 13
    Else
        setgate_mode = 0
    End If
    
    If setgate_mode = 1 Then Text3.Text = Format(a, "0.00")
    If setgate_mode = 2 Then Text4.Text = Format(a, "0.00")
    If setgate_mode = 3 Then Text5.Text = Format(a, "0.00")
    If setgate_mode = 4 Then Text6.Text = Format(a, "0.00")
    
End Sub

Private Sub ShowGates()

    TraceForm.DrawMode = 7
    col = &HC0C0C0
    a = 1
    TraceForm.Line (PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_miny, c_miny, c_maxy))-(PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_maxy, c_miny, c_maxy)), col
    a = 2
    TraceForm.Line (PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_miny, c_miny, c_maxy))-(PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_maxy, c_miny, c_maxy)), col
    col = &HFFFF80
    a = 3
    TraceForm.Line (PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_miny, c_miny, c_maxy))-(PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_maxy, c_miny, c_maxy)), col
    a = 4
    TraceForm.Line (PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_miny, c_miny, c_maxy))-(PixelFromValueX(TraceFormGatePos(a), c_minx, c_maxx), PixelFromValueY(c_maxy, c_miny, c_maxy)), col
    TraceForm.DrawMode = 13

End Sub

Public Function GetGates()

    '1 = Lower baseline
    '2 = Upper baseline
    '3 = Lower signal
    '4 = upper Signal

    Dim a(1 To 4)
    
    a(1) = TraceFormGatePos(1)
    a(2) = TraceFormGatePos(2)
    a(3) = TraceFormGatePos(3)
    a(4) = TraceFormGatePos(4)
    
    GetGates = a

End Function

