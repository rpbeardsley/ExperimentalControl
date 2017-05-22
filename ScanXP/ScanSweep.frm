VERSION 5.00
Begin VB.Form ScanSweep 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Scan Delay"
   ClientHeight    =   2835
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   3495
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2835
   ScaleWidth      =   3495
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   120
      TabIndex        =   10
      Top             =   1200
      Width           =   3255
   End
   Begin VB.TextBox Text3 
      Height          =   225
      Left            =   1440
      TabIndex        =   8
      Text            =   "6"
      Top             =   600
      Width           =   735
   End
   Begin VB.TextBox Text2 
      Height          =   225
      Left            =   1440
      TabIndex        =   5
      Text            =   "15"
      Top             =   210
      Width           =   735
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   2520
      Top             =   360
   End
   Begin VB.TextBox Text1 
      Height          =   225
      Left            =   1800
      TabIndex        =   1
      Text            =   "5"
      Top             =   1770
      Width           =   735
   End
   Begin VB.CommandButton cmdMeasure 
      Caption         =   "Measure"
      Height          =   495
      Left            =   600
      TabIndex        =   0
      Top             =   2160
      Width           =   2295
   End
   Begin VB.Label Label6 
      Caption         =   "Save file as :"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   960
      Width           =   1095
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   3360
      Y1              =   1560
      Y2              =   1560
   End
   Begin VB.Label Label5 
      Caption         =   "Lock-in address :"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   600
      Width           =   1335
   End
   Begin VB.Label Label4 
      Caption         =   "Label4"
      Height          =   15
      Left            =   1560
      TabIndex        =   6
      Top             =   240
      Width           =   15
   End
   Begin VB.Label Label3 
      Caption         =   "DVM address :"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   240
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Seconds"
      Height          =   255
      Left            =   2640
      TabIndex        =   3
      Top             =   1800
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Time of measurement :"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   1800
      Width           =   1815
   End
End
Attribute VB_Name = "ScanSweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private xdata()
Private ydata()

Private Sub cmdMeasure_Click()
    
    Dim DVMaddr As Integer
    Dim Lckinaddr As Integer
    Dim success As Boolean
    Dim strng As String
    Dim DidItWork As Boolean
    
    Text1.Enabled = False
    Text2.Enabled = False
    Text3.Enabled = False
    Text4.Enabled = False
    cmdMeasure.Enabled = False
    
    MeasTime = Val(Text1.Text)
    DVMaddr = Val(Text2.Text)
    Lckinaddr = Val(Text3.Text)
    fname = Text4.Text

    t = Timer
    b = t
    a = 1
    ReDim xdata(0 To 0)
    ReDim ydata(0 To 0)
    
    While (Timer < b + (MeasTime))
        'Read DVM
        Position = DVM34401A.DVM34401A_GetSample(DVMaddr)
        'Read Lock-in
        Signal = SRS830.SRS830_ReadChannel(Lckinaddr, 1, t, success)
        'Write to the x any y arrays
        ReDim Preserve xdata(0 To a - 1)
        ReDim Preserve ydata(0 To a - 1)
        xdata(a - 1) = Position
        ydata(a - 1) = Signal
        a = a + 1
    Wend
      
    TraceForm.PlotTrace xdata, ydata
    
    'Open fname For Output As #1
    'For i = 0 To a - 1
        'Print #1, Format(xdata(i)) + ", " + Format(ydata(i))
        'i = i + 1
    'Next
    'Close #1
    
    Text1.Enabled = True
    Text2.Enabled = True
    Text3.Enabled = True
    Text4.Enabled = True
    cmdMeasure.Enabled = True
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        ScanSweep.Hide
    End If

End Sub
