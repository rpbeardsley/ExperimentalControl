VERSION 5.00
Begin VB.Form EclipseFrm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Eclipse"
   ClientHeight    =   2565
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7155
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2565
   ScaleWidth      =   7155
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   2520
      TabIndex        =   13
      Text            =   "Combo1"
      Top             =   1920
      Width           =   1815
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   1200
      TabIndex        =   10
      Text            =   "0"
      Top             =   1920
      Width           =   495
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   5400
      TabIndex        =   7
      Text            =   "0"
      Top             =   1440
      Width           =   615
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Save"
      Height          =   495
      Left            =   1800
      TabIndex        =   6
      Top             =   960
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Caption         =   "Bias Subtraction"
      Height          =   855
      Left            =   3360
      TabIndex        =   2
      Top             =   360
      Width           =   2655
      Begin VB.OptionButton Option1 
         Caption         =   "+ve"
         Height          =   495
         Left            =   240
         TabIndex        =   5
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton Option2 
         Caption         =   "-ve"
         Height          =   495
         Left            =   960
         TabIndex        =   4
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Off"
         Height          =   495
         Left            =   1680
         TabIndex        =   3
         Top             =   240
         Value           =   -1  'True
         Width           =   735
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Init"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   360
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Acquire"
      Height          =   495
      Left            =   1800
      TabIndex        =   0
      Top             =   360
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "ns"
      Height          =   255
      Left            =   4680
      TabIndex        =   12
      Top             =   1920
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "to"
      Height          =   255
      Left            =   1920
      TabIndex        =   11
      Top             =   1920
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "Save From"
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   1920
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Pause after bias flip:"
      Height          =   255
      Left            =   3480
      TabIndex        =   8
      Top             =   1440
      Width           =   1695
   End
End
Attribute VB_Name = "EclipseFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private numpoints
Private datx() As Double
Private daty() As Double

Private Sub Command1_Click()

    If Option1.value = True Then
        BiasSwitch.SetBias (0)
        If Val(Text1.Text) > 0 Then Pause (Val(Text1.Text))
    ElseIf Option2.value = True Then
        BiasSwitch.SetBias (1)
        If Val(Text1.Text) > 0 Then Pause (Val(Text1.Text))
    End If
    
    Eclipse.GetEclipseTrace xdata, ydata
    If Option3.value = False Then
        BiasSwitch.FlipBias
        If Val(Text1.Text) > 0 Then Pause (Val(Text1.Text))
        Eclipse.GetEclipseTrace xdata2, ydata2
    End If
    
    ReDim datx(0 To (UBound(xdata) - LBound(xdata)))
    ReDim daty(0 To (UBound(xdata) - LBound(xdata)))
    
    If Option3.value = False Then
    For a = LBound(xdata) To UBound(xdata)
        ydata(a) = ydata(a) - ydata2(a)
    Next a
    End If
    
    b = 0
    For a = LBound(xdata) To UBound(xdata)
        datx(b) = xdata(a)
        daty(b) = ydata(a)
        b = b + 1
    Next a

    TraceForm.Show
    TraceForm.PlotTrace xdata, ydata
   
    
End Sub


Private Sub Command2_Click()
    Eclipse.Init
End Sub

Private Sub Command3_Click()

    a = Globals.SaveDialog
    If a <> "" Then
        Open a For Output As #1
        
        spoint = LBound(datx) + Int(2 * Val(Text2.Text))
        If spoint < 0 Then spoint = 0
        If Mid(LCase(Combo1.Text), 1, 3) = "end" Then
            fpoint = UBound(datx)
        Else
            fpoint = Int(2 * Val(Combo1.Text))
            If fpoint > UBound(datx) Then fpoint = UBound(datx)
        End If
        If spoint > fpoint Then
            tmppoint = fpoint: fpoint = spoint: spoint = tmppoint
        End If
        
        For a = spoint To fpoint
            Print #1, Format(datx(a)) + ", " + Format(daty(a))
        Next a
        Close #1
    End If

End Sub

Private Sub Form_Load()
    Combo1.Clear
    Combo1.AddItem "5120"
    Combo1.AddItem "end"
    Combo1.ListIndex = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Unload EclipseFrm
    '
    ' Un-subclass the form.
    '
    Call Eclipse.pUnhook

End Sub
