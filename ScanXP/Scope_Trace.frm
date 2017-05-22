VERSION 5.00
Begin VB.Form Scope_Trace 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Scope trace"
   ClientHeight    =   5085
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6540
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5085
   ScaleWidth      =   6540
   Begin VB.CommandButton Command1 
      Caption         =   "Get Single Trace"
      Height          =   495
      Left            =   4560
      TabIndex        =   14
      Top             =   4440
      Width           =   1575
   End
   Begin VB.TextBox txtAddr 
      Height          =   285
      Left            =   2880
      TabIndex        =   13
      Text            =   "6"
      Top             =   1680
      Width           =   375
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Use with the lock-in on address"
      Height          =   375
      Left            =   240
      TabIndex        =   12
      Top             =   1680
      Value           =   1  'Checked
      Width           =   2775
   End
   Begin VB.TextBox txtAvgs 
      Height          =   315
      Left            =   2520
      TabIndex        =   11
      Text            =   "20"
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3360
      Top             =   960
   End
   Begin VB.Frame Frame1 
      Caption         =   "Status"
      Height          =   1215
      Left            =   4200
      TabIndex        =   8
      Top             =   240
      Width           =   2055
      Begin VB.Label Label5 
         Height          =   495
         Left            =   120
         TabIndex        =   9
         Top             =   480
         Width           =   1815
      End
   End
   Begin VB.TextBox text_Address 
      Height          =   315
      Left            =   1440
      TabIndex        =   7
      Text            =   "3"
      Top             =   1080
      Width           =   855
   End
   Begin VB.ComboBox combo_ScopeType 
      Height          =   315
      Left            =   1440
      TabIndex        =   4
      Top             =   360
      Width           =   2295
   End
   Begin VB.TextBox text_DataLocation 
      Height          =   285
      Left            =   1320
      TabIndex        =   1
      Top             =   3000
      Width           =   4815
   End
   Begin VB.CommandButton cmd_Save 
      Caption         =   "Save"
      Height          =   495
      Left            =   4560
      TabIndex        =   0
      Top             =   3720
      Width           =   1575
   End
   Begin VB.Label Label6 
      Caption         =   "Number of Averages (see manual for allowed values)"
      Height          =   495
      Left            =   240
      TabIndex        =   10
      Top             =   2280
      Width           =   2055
   End
   Begin VB.Label Label4 
      Caption         =   "Scope address"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1080
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Scope type"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   360
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   $"Scope_Trace.frx":0000
      Height          =   855
      Left            =   120
      TabIndex        =   3
      Top             =   3720
      Width           =   3735
   End
   Begin VB.Label Label1 
      Caption         =   "Save as"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   3000
      Width           =   735
   End
End
Attribute VB_Name = "Scope_Trace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function PlaySound Lib "winmm.dll" Alias "PlaySoundA" (ByVal lpszName As String, ByVal hModule As Long, ByVal dwFlags As Long) As Long

Private Sub Command1_Click()

        Call Scope_DPO7054.DPO_StopAcquisition(Val(text_Address.Text))
        Call Scope_DPO7054.DPO_ScopeTrace(tdata, sdata, Val(text_Address.Text), 2)
    
        If VarType(tdata) And vbArray Then 'Did we get the data back OK?
                       
            If text_DataLocation.Text <> "" Then 'Do we want to save it to file?
            fnum = FreeFile
            Open text_DataLocation.Text For Output As #fnum
                For a = LBound(tdata) To UBound(tdata)
                    strng = Format(tdata(a)) + "," + Format(sdata(a))
                    Print #fnum, strng
                Next a
            Close #fnum
            End If
                       
               
            'Plot the data
            TraceForm.PlotTrace tdata, sdata
            
        End If

ext:

End Sub

Private Sub Form_Load()
    
    combo_ScopeType.AddItem "HP-54501A"
    combo_ScopeType.AddItem "Tektronix DPO 7054"
    combo_ScopeType.ListIndex = 1

End Sub

Private Sub cmd_Save_Click()
    
    Dim fname As String
    Dim ret As Integer
    Dim ScpAddr As Integer
    Dim strng8 As String
    Dim Comma As Integer
    Dim SetAvgs As Single
    
    ScpAddr = Val(text_Address.Text)
    SetAvgs = Val(txtAvgs.Text)
    
    If Check1.value = 1 Then
        Sensitivity = SRS830.SRS830_GetSensitivity(Val(txtAddr.Text))
    Else
        Sensitivity = 10
    End If
    
    'Disable all fields, buttons and change caption
    combo_ScopeType.Enabled = False
    text_Address.Enabled = False
    txtAvgs.Enabled = False
    text_DataLocation.Enabled = False
    cmd_Save.Enabled = False
    Check1.Enabled = False
    
    'Check to see if the file already exists and exit if required
    fname = text_DataLocation + ".dat"
    If FileExists(fname) Then
        ret = MsgBox("Are you sure you want to overwrite the file?", vbExclamation Or vbYesNo, "File Exists")
    Else
        ret = 6
    End If
    
    If ret <> 6 Then GoTo ext
    
    Timer1.Enabled = True
    
    'Check which scope is being used (currently only one) and get the data + preamble
    If combo_ScopeType.ListIndex = 0 Then
        PreamBuff = Scope_HP_54501A.HP_54501A_GetTracePreamble(ScpAddr)
        InBuffer = Scope_HP_54501A.HP_54501A_GetTrace(ScpAddr, SetAvgs)
    ElseIf combo_ScopeType.ListIndex = 1 Then
        AvgTrace = Scope_DPO7054.DPO_ScopeAverageTrace(xdata, ydata, ScpAddr, SetAvgs)
    Else
        ret2 = MsgBox("Select your oscilloscope", vbOKOnly, "Input Error")
        GoTo ext
    End If
       
    Timer1.Enabled = False
    Label5.Caption = "Saving data..."
    
    If combo_ScopeType.ListIndex = 0 Then   'process and save the data if the HP-54501A is being used
        'Parse the preamble
        PreamCounter = 0
        Do
            PreamComma = InStr(PreamBuff, Chr(44))
            If PreamComma > 0 Then
                PreamCounter = PreamCounter + 1
        
                PreamRead = Left$(PreamBuff, PreamComma - 1)
                PreamBuff = Mid$(PreamBuff, PreamComma + 1)
            ElseIf PreamComma = 0 Then
                PreamCounter = 10
                PreamRead = PreamBuff
            End If
        
            If PreamCounter = 1 Then
                strDataFormat = PreamRead '0=ASCII,1=BYTE,2=WORD,4=COMPRESSED
                DataFormat = Val(strDataFormat)
            ElseIf PreamCounter = 2 Then
                strMeasType = PreamRead '1=NORMAL,2=AVERAGED,3=ENVELOPE
                MeasType = Val(strMeasType)
            ElseIf PreamCounter = 3 Then
                strNumPts = PreamRead
                NumPts = Val(strNumPts)
            ElseIf PreamCounter = 4 Then
                strAverages = PreamRead
                Averages = Val(strAverages)
            ElseIf PreamCounter = 5 Then
                strXincr = PreamRead
                XIncr = Val(strXincr)
            ElseIf PreamCounter = 6 Then
                strXorig = PreamRead
                Xorig = Val(strXorig)
            ElseIf PreamCounter = 7 Then
                strXref = PreamRead
                Xref = Val(strXref)
            ElseIf PreamCounter = 8 Then
                strYincr = PreamRead
                Yincr = Val(strYincr)
            ElseIf PreamCounter = 9 Then
                strYorig = PreamRead
                Yorig = Val(strYorig)
            ElseIf PreamCounter = 10 Then
                strYref = PreamBuff
                Yref = Val(strYref)
                PreamCounter = 11
            End If
        Loop While PreamCounter < 11
       
        'Create a file to save the data in
        Open fname For Output As #1
        Print #1, ";Raw data for Oscilloscope trace"
        Print #1, ";Number of points taken = " + strNumPts
        Print #1, ";Number of averages made = " + strAverages
        Print #1, ";Preamble" + PreamBuff
    
        'Parse the data and Save it
        Comma = InStr(InBuffer, Chr(44))
        Counter = 0
        Do
            If Comma > 0 Then
                Counter = Counter + 1
        
                strVltgeMltiplier = Left$(InBuffer, Comma - 1)
                VltgeMltiplier = Val(strVltgeMltiplier)
                InBuffer = Mid$(InBuffer, Comma + 1)
                MeasTime = ((Counter - Xref) * XIncr) + Xorig
                voltage = (((VltgeMltiplier - Yref) * Yincr) + Yorig) * Sensitivity / 10
                   
                Print #1, Format(MeasTime) + ", " + Format(voltage)
            End If
        Loop While Counter < NumPts
    
        If Check1.value = 1 Then
            Print #1, "/et    x ""Time From scope (Sec)""           ;axis title"
            Print #1, "/et    y "" Lockin signal (V) ""                ;axis title"
        Else
            Print #1, "/et    x ""Time (Sec)""           ;axis title"
            Print #1, "/et    y ""Voltage(V)""                ;axis title"
        End If
    Else
        Open fname For Output As #1
        ydata2 = ydata
        For H = 1 To (UBound(xdata) - LBound(xdata))
            ydata2(H) = ydata(H) * Sensitivity / 10
            Print #1, xdata(H), ydata(H), Format(ydata2(H), "Scientific")
        Next H
        
        TraceForm.Show
        TraceForm.PlotTrace xdata, ydata
    End If

    Close #1
    
ext:
    a = PlaySound("SHRTALRM.wav", 0, 0)
    
    'Enable all fields, the button, and re-caption
    Label5.Caption = "Your data is ready"
    combo_ScopeType.Enabled = True
    text_Address.Enabled = True
    txtAvgs.Enabled = True
    text_DataLocation.Enabled = True
    cmd_Save.Enabled = True
    Check1.Enabled = True
              
End Sub

Private Sub Timer1_Timer()

    Label5.Caption = "SCOPE IS AVERAGING"
    Globals.Pause (1)
    Label5.Caption = ""
    
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: Scope_Trace.Hide

End Sub


