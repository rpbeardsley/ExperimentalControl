VERSION 5.00
Begin VB.Form ImageForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Image"
   ClientHeight    =   8175
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7305
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8175
   ScaleWidth      =   7305
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   6120
      TabIndex        =   15
      Text            =   "15"
      Top             =   6840
      Width           =   975
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1200
      TabIndex        =   12
      Text            =   "Combo1"
      Top             =   6840
      Width           =   2295
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Command3"
      Height          =   375
      Left            =   6960
      TabIndex        =   11
      Top             =   6000
      Width           =   135
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Stop"
      Height          =   495
      Left            =   5520
      TabIndex        =   10
      Top             =   6000
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Start"
      Height          =   495
      Left            =   4200
      TabIndex        =   9
      Top             =   6000
      Width           =   1215
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   3240
      TabIndex        =   8
      Text            =   "1"
      Top             =   6240
      Width           =   735
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1200
      TabIndex        =   6
      Text            =   "1"
      Top             =   6240
      Width           =   735
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   3240
      TabIndex        =   4
      Text            =   "10"
      Top             =   5880
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1200
      TabIndex        =   2
      Text            =   "10"
      Top             =   5880
      Width           =   735
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      Height          =   5655
      Left            =   120
      ScaleHeight     =   5595
      ScaleWidth      =   6915
      TabIndex        =   0
      Top             =   120
      Width           =   6975
   End
   Begin VB.Label Label10 
      Height          =   255
      Left            =   2400
      TabIndex        =   19
      Top             =   7560
      Width           =   1335
   End
   Begin VB.Label Label9 
      Caption         =   ","
      Height          =   255
      Left            =   2280
      TabIndex        =   18
      Top             =   7560
      Width           =   495
   End
   Begin VB.Label Label8 
      Height          =   255
      Left            =   960
      TabIndex        =   17
      Top             =   7560
      Width           =   1335
   End
   Begin VB.Label Label7 
      Caption         =   "Position:"
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   7560
      Width           =   735
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   7080
      Y1              =   7320
      Y2              =   7320
   End
   Begin VB.Label Label6 
      Caption         =   "GPIB Address (where applicable):"
      Height          =   255
      Left            =   3600
      TabIndex        =   14
      Top             =   6840
      Width           =   2535
   End
   Begin VB.Label Label5 
      Caption         =   "Device:"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   6840
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "Size Y / mm:"
      Height          =   255
      Left            =   2160
      TabIndex        =   7
      Top             =   6255
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Size X / mm:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   6255
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "No. Points Y:"
      Height          =   255
      Left            =   2160
      TabIndex        =   3
      Top             =   5895
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "No. Points X:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   5895
      Width           =   1215
   End
End
Attribute VB_Name = "ImageForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private px
Private py
Private cx
Private cy
Private npx
Private npy
Private imposx
Private imposy
Private maxv
Private minv
Private pointsvals()

Private running As Boolean

Private Sub Command1_Click()

    Dim imy
    Dim imx
    Dim status As Integer
    
    Open "mirrorposrecord.dat" For Output As #2

    cx = MirrorCentreX 'Record centre mirror coords
    cy = MirrorCentreY

    npx = Int(Val(Text1.Text)) 'Number of points
    npy = Int(Val(Text2.Text))
    
    sx = Val(Text3.Text)
    sy = Val(Text4.Text)

    running = True

    For imposx = 1 To npx
    'For imposx = npx To 1 Step -1
    
        imx = (imposx - 1) * (sx / (npx - 1)) - (sx / 2) + cx
        status = Mirrors.MoveXMirror(imx)
        Pause (0.1)
        If running = False Then GoTo ext
    
        For imposy = 1 To npy
            imy = (imposy - 1) * (sy / (npy - 1)) - (sy / 2) + cy
            status = Mirrors.MoveYMirror(imy)
            Pause (0.1)
            If running = False Then GoTo ext
            v = GetPoint(imposx, imposy)
            SetPoint imposx, imposy, npx, npy, v
            Print #2, Format(imposx) + ", " + Format(imposy) + " -> " + Format(imx) + ", " + Format(imy)
        Next imposy
        
    Next imposx
        
ext:

Close #2

'Move mirrors back to positions given by mirror form
Mirrors.MoveXMirror (CurrentMirrorX)
Mirrors.MoveYMirror (CurrentMirrorY)

End Sub

Private Function GetPoint(Optional mirrx = -1, Optional mirry = -1) As Double

    Dim addr As Integer
    
    addr = Val(Text5.Text)

    If Combo1.ListIndex = 0 Then
        If mirrx > -1 And mirry > -1 Then
            v = AcquireTrace(mirrx, mirry)
        Else
            v = AcquireTrace()
        End If
    ElseIf Combo1.ListIndex = 1 Then
        v = DVM34401A.DVM34401A_GetSample(addr)
    ElseIf Combo1.ListIndex = 2 Then
        If mirrx > -1 And mirry > -1 Then
            v = AcquireEclipseTrace(mirrx, mirry)
        Else
            v = AcquireEclipseTrace()
        End If
    End If
    
        
    GetPoint = v

End Function

Private Function AcquireTrace(Optional mirrx = -1, Optional mirry = -1) As Double

If DigitiserForm.Option1.value = True Then
    BiasSwitch.SetBias (0)
ElseIf DigitiserForm.Option2.value = True Then
    BiasSwitch.SetBias (1)
End If

dat = Digitiser.GetTrace(xdata, ydata)
If DigitiserForm.Option3.value = False Then
    BiasSwitch.FlipBias
    dat2 = Digitiser.GetTrace(xdata2, ydata2)
End If

If DigitiserForm.Option3.value = False Then
For a = LBound(xdata) To UBound(xdata)
    ydata(a) = ydata(a) - ydata2(a)
Next a
End If

'Save file
If mirrx > -1 And mirry > -1 Then
    filname = "X" + Mid(Str(mirrx), 2) + "Y" + Mid(Str(mirry), 2) + ".dat"
    Open filname For Output As #1
    For a = LBound(xdata) To UBound(xdata)
        Print #1, Format(xdata(a)) + ", " + Format(ydata(a))
    Next a
    Close #1
End If

G = TraceForm.GetGates

'Mean
gate_lower = G(1)
gate_upper = G(2)
CropData xdata, ydata, gate_lower, gate_upper, newxdata, newydata
m = 0
For a = LBound(newxdata) To UBound(newxdata)
    m = m + newydata(a)
Next a
m = m / (1 + UBound(newxdata) - LBound(newxdata))

'Integrate
gate_lower = G(3)
gate_upper = G(4)
CropData xdata, ydata, gate_lower, gate_upper, newxdata, newydata
s = 0
For a = LBound(newxdata) To (UBound(newxdata) - 1)
    s = s + (newydata(a) + newydata(a + 1) - 2 * m) * (newxdata(a + 1) - newxdata(a)) * 0.5
Next a

AcquireTrace = s

End Function

Private Function AcquireEclipseTrace(Optional mirrx = -1, Optional mirry = -1) As Double

If EclipseFrm.Option1.value = True Then
    BiasSwitch.SetBias (0)
ElseIf EclipseFrm.Option2.value = True Then
    BiasSwitch.SetBias (1)
End If

Eclipse.GetEclipseTrace xdata, ydata
If EclipseFrm.Option3.value = False Then
    BiasSwitch.FlipBias
    Eclipse.GetEclipseTrace xdata2, ydata2
End If

If EclipseFrm.Option3.value = False Then
For a = LBound(xdata) To UBound(xdata)
    ydata(a) = ydata(a) - ydata2(a)
Next a
End If

'Save file
If mirrx > -1 And mirry > -1 Then
    filname = "X" + Mid(Str(mirrx), 2) + "Y" + Mid(Str(mirry), 2) + ".dat"
    Open filname For Output As #1
    For a = LBound(xdata) To UBound(xdata)
        Print #1, Format(xdata(a)) + ", " + Format(ydata(a))
    Next a
    Close #1
End If

G = TraceForm.GetGates

'Mean
gate_lower = G(1)
gate_upper = G(2)
CropData xdata, ydata, gate_lower, gate_upper, newxdata, newydata
m = 0
For a = LBound(newxdata) To UBound(newxdata)
    m = m + newydata(a)
Next a
m = m / (1 + UBound(newxdata) - LBound(newxdata))

'Integrate
gate_lower = G(3)
gate_upper = G(4)
CropData xdata, ydata, gate_lower, gate_upper, newxdata, newydata
s = 0
For a = LBound(newxdata) To (UBound(newxdata) - 1)
    s = s + (newydata(a) + newydata(a + 1) - 2 * m) * (newxdata(a + 1) - newxdata(a)) * 0.5
Next a

AcquireEclipseTrace = s

End Function

Private Sub Command2_Click()
running = False
End Sub

Private Sub Command3_Click()
For a = 1 To 3
For b = 1 To 3
SetPoint a, b, 3, 3, a * b
Next b
Next a
End Sub

Private Sub SetPoint(X, Y, mx, my, v)
    
    
    If X = 1 And Y = 1 Then
        maxv = v: minv = v
        ReDim pointsvals(0 To (mx * my - 1))
        pointsvals((Y - 1) + my * (X - 1)) = v
    Else
        pointsvals((Y - 1) + my * (X - 1)) = v
        If v > maxv Then maxv = v
        If v < minv Then minv = v
    End If
    
    Picture1.Cls
    
    For drawX = 1 To mx
    For drawY = 1 To my
    
        If ((drawY - 1) + my * (drawX - 1)) <= ((Y - 1) + my * (X - 1)) Then
    
            If Abs(maxv - minv) > 0.0000000001 Then
                drawv = 10 + 245 * (pointsvals((drawY - 1) + my * (drawX - 1)) - minv) / (maxv - minv)
            Else
                drawv = 132.5
            End If
    
            hv = 42 * (drawv / 255)
            sv = 255
            lv = drawv
            col = GetColourCodeFromHSL(hv, sv, lv)
            
            Picture1.Line ((drawX - 1) * (Picture1.ScaleWidth / mx), (drawY - 1) * (Picture1.ScaleHeight / my))-(drawX * (Picture1.ScaleWidth / mx), drawY * (Picture1.ScaleHeight / my)), col, BF
    
        End If
        
    Next drawY
    Next drawX
    
End Sub

Private Sub Form_Load()

    Combo1.Clear
    Combo1.AddItem "Digitiser"
    Combo1.AddItem "DMM"
    Combo1.AddItem "Eclipse"
    Combo1.ListIndex = 0

End Sub

