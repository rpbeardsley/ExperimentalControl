VERSION 5.00
Begin VB.Form LinescanForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form2"
   ClientHeight    =   3015
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6375
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   6375
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   1200
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   240
      Width           =   2295
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1320
      TabIndex        =   5
      Text            =   "10"
      Top             =   720
      Width           =   735
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1320
      TabIndex        =   4
      Text            =   "1"
      Top             =   1080
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Start"
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Stop"
      Height          =   495
      Left            =   1560
      TabIndex        =   2
      Top             =   2040
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   3360
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   720
      Width           =   2295
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   4800
      TabIndex        =   0
      Text            =   "15"
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "Direction:"
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   240
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "No. Points:"
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   735
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Size X / mm:"
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   1095
      Width           =   1215
   End
   Begin VB.Label Label5 
      Caption         =   "Device:"
      Height          =   255
      Left            =   2280
      TabIndex        =   10
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label6 
      Caption         =   "GPIB Address (where applicable):"
      Height          =   255
      Left            =   2280
      TabIndex        =   9
      Top             =   1080
      Width           =   2535
   End
   Begin VB.Label Label7 
      Caption         =   "Position:"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   1560
      Width           =   735
   End
   Begin VB.Label Label8 
      Height          =   255
      Left            =   1080
      TabIndex        =   7
      Top             =   1560
      Width           =   1335
   End
   Begin VB.Label Label10 
      Height          =   255
      Left            =   2520
      TabIndex        =   6
      Top             =   1560
      Width           =   1335
   End
End
Attribute VB_Name = "LinescanForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
    Dim xpoints() As Double
    Dim ypoints() As Double
    Dim status As Integer
    
    Open "mirrorposrecord.dat" For Output As #2

    cx = MirrorCentreX 'Record centre mirror coords
    cy = MirrorCentreY

    npx = Int(Val(Text1.Text)) 'Number of points
    npy = Int(Val(Text1.Text))
    
    sx = Val(Text3.Text)
    sy = Val(Text3.Text)

    npoints = -1

    running = True
               
    If Combo2.ListIndex = 0 Then
    imposy = 0
        For imposx = 1 To npx
            imx = (imposx - 1) * (sx / (npx - 1)) - (sx / 2) + cx
            status = Mirrors.MoveXMirror(imx)
            Pause (0.1)
            If running = False Then GoTo ext
            V = GetPoint(imposx, imposy)
            npoints = npoints + 1
            ReDim Preserve xpoints(0 To npoints)
            ReDim Preserve ypoints(0 To npoints)
            xpoints(npoints) = imx
            ypoints(npoints) = V
            TraceForm.PlotTrace xpoints, ypoints
            Print #2, Format(imx) + ", " + Format(V)
        Next imposx
    End If
    
    If Combo2.ListIndex = 1 Then
    imposx = 0
        For imposy = 1 To npy
            imy = (imposy - 1) * (sy / (npy - 1)) - (sy / 2) + cy
            status = Mirrors.MoveYMirror(imy)
            Pause (0.1)
            If running = False Then GoTo ext
            V = GetPoint(imposx, imposy)
            npoints = npoints + 1
            ReDim Preserve xpoints(0 To npoints)
            ReDim Preserve ypoints(0 To npoints)
            xpoints(npoints) = imy
            ypoints(npoints) = V
            TraceForm.PlotTrace xpoints, ypoints
            Print #2, Format(imy) + ", " + Format(V)
        Next imposy
     End If
        
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
            V = AcquireTrace(mirrx, mirry)
        Else
            V = AcquireTrace()
        End If
    ElseIf Combo1.ListIndex = 1 Then
        V = DVM34401A.DVM34401A_GetSample(addr)
    ElseIf Combo1.ListIndex = 1 Then
        If mirrx > -1 And mirry > -1 Then
            V = AcquireEclipseTrace(mirrx, mirry)
        Else
            V = AcquireEclipseTrace()
        End If
    End If
    
        
    GetPoint = V

End Function

Private Function AcquireTrace(Optional mirrx = -1, Optional mirry = -1) As Double

If EclipseFrm.Option1.value = True Then
    BiasSwitch.SetBias (0)
ElseIf EclipseFrm.Option2.value = True Then
    BiasSwitch.SetBias (1)
End If

dat = Digitiser.GetTrace(xdata, ydata)
If EclipseFrm.Option3.value = False Then
    BiasSwitch.FlipBias
    dat2 = Digitiser.GetTrace(xdata2, ydata2)
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

AcquireTrace = s

End Function

Private Function AcquireEclipseTrace(Optional mirrx = -1, Optional mirry = -1) As Double

If DigitiserForm.Option1.value = True Then
    BiasSwitch.SetBias (0)
ElseIf DigitiserForm.Option2.value = True Then
    BiasSwitch.SetBias (1)
End If

Eclipse.GetEclipseTrace xdata, ydata
If DigitiserForm.Option3.value = False Then
    BiasSwitch.FlipBias
    Eclipse.GetEclipseTrace xdata2, ydata2
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

AcquireEclipseTrace = s

End Function

Private Sub Command2_Click()
running = False
End Sub

Private Sub Form_Load()

    Combo1.Clear
    Combo1.AddItem "Digitiser"
    Combo1.AddItem "DMM"
    Combo1.ListIndex = 0

    Combo2.Clear
    Combo2.AddItem "X"
    Combo2.AddItem "Y"
    Combo2.ListIndex = 0
    
End Sub
