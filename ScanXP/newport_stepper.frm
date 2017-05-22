VERSION 5.00
Begin VB.Form newport_stepper 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Newport Stepper"
   ClientHeight    =   7725
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8580
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7725
   ScaleWidth      =   8580
   Begin VB.CommandButton Command4 
      Caption         =   "SET"
      Height          =   615
      Left            =   6480
      TabIndex        =   39
      Top             =   3960
      Width           =   855
   End
   Begin VB.ComboBox Combo4 
      Height          =   315
      Left            =   3840
      TabIndex        =   38
      Text            =   "Time-constant"
      Top             =   4920
      Width           =   2055
   End
   Begin VB.ComboBox Combo3 
      Height          =   315
      Left            =   3840
      TabIndex        =   37
      Text            =   "Choose resolution"
      Top             =   4440
      Width           =   2055
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3840
      TabIndex        =   36
      Text            =   "Choose Scan Length"
      Top             =   3960
      Width           =   2055
   End
   Begin VB.CommandButton Command12 
      Caption         =   "SET DEVICE"
      Height          =   615
      Left            =   2280
      TabIndex        =   34
      Top             =   4560
      Width           =   855
   End
   Begin VB.TextBox Text12 
      Height          =   285
      Left            =   1200
      TabIndex        =   33
      Text            =   "2"
      Top             =   5040
      Width           =   735
   End
   Begin VB.TextBox Text11 
      Height          =   285
      Left            =   1200
      TabIndex        =   30
      Top             =   5760
      Width           =   7095
   End
   Begin VB.TextBox Text10 
      Height          =   285
      Left            =   1200
      TabIndex        =   29
      Text            =   "3"
      Top             =   4560
      Width           =   735
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   1440
      Style           =   2  'Dropdown List
      TabIndex        =   27
      Top             =   3840
      Width           =   1695
   End
   Begin VB.TextBox Text9 
      Height          =   285
      Left            =   4920
      TabIndex        =   25
      Text            =   "50"
      Top             =   6720
      Width           =   975
   End
   Begin VB.TextBox Text8 
      Height          =   285
      Left            =   4920
      TabIndex        =   23
      Text            =   "5"
      Top             =   6240
      Width           =   975
   End
   Begin VB.TextBox Text7 
      Height          =   285
      Left            =   1440
      TabIndex        =   20
      Text            =   "20"
      Top             =   6720
      Width           =   735
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   1440
      TabIndex        =   18
      Top             =   6240
      Width           =   735
   End
   Begin VB.CommandButton Command10 
      Caption         =   "Stop"
      Height          =   375
      Left            =   4440
      TabIndex        =   16
      Top             =   7200
      Width           =   975
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   1440
      TabIndex        =   14
      Text            =   "1"
      Top             =   7200
      Width           =   735
   End
   Begin VB.CommandButton Command9 
      Caption         =   "Scan"
      Height          =   375
      Left            =   3120
      TabIndex        =   13
      Top             =   7200
      Width           =   975
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Current Position:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   12
      Top             =   2760
      Width           =   1815
   End
   Begin VB.CommandButton Command7 
      Caption         =   "OFF"
      Height          =   615
      Left            =   2640
      TabIndex        =   10
      Top             =   240
      Width           =   975
   End
   Begin VB.CommandButton Command6 
      Caption         =   "ON"
      Height          =   615
      Left            =   1440
      TabIndex        =   9
      Top             =   240
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Set speed"
      Height          =   615
      Left            =   7080
      TabIndex        =   8
      Top             =   2640
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   375
      Left            =   5880
      TabIndex        =   7
      Text            =   "50"
      Top             =   2760
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Move"
      Height          =   375
      Left            =   4680
      TabIndex        =   6
      Top             =   2160
      Width           =   975
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   2520
      TabIndex        =   5
      Top             =   2160
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Go"
      Height          =   375
      Left            =   4680
      TabIndex        =   3
      Top             =   1440
      Width           =   975
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Top             =   1440
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Home"
      Height          =   375
      Left            =   6000
      TabIndex        =   0
      Top             =   1440
      Width           =   975
   End
   Begin VB.Label Label13 
      Height          =   495
      Left            =   6120
      TabIndex        =   44
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label Label6 
      Height          =   375
      Left            =   7320
      TabIndex        =   43
      Top             =   4800
      Width           =   1095
   End
   Begin VB.Label Label5 
      Height          =   495
      Left            =   6360
      TabIndex        =   42
      Top             =   6360
      Width           =   2055
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   "Speed (mm/s) :  (MAX 100mm/s)"
      Height          =   495
      Left            =   4320
      TabIndex        =   41
      Top             =   2760
      Width           =   1335
   End
   Begin VB.Line Line3 
      X1              =   120
      X2              =   8280
      Y1              =   5520
      Y2              =   5520
   End
   Begin VB.Label Label19 
      Height          =   375
      Left            =   6120
      TabIndex        =   40
      Top             =   4800
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "FOR LOCK-IN :"
      Height          =   255
      Left            =   3840
      TabIndex        =   35
      Top             =   3600
      Width           =   1215
   End
   Begin VB.Label Label18 
      Caption         =   "Channel:"
      Height          =   255
      Left            =   240
      TabIndex        =   32
      Top             =   5040
      Width           =   615
   End
   Begin VB.Label Label17 
      Caption         =   "Filename:"
      Height          =   255
      Left            =   120
      TabIndex        =   31
      Top             =   5760
      Width           =   855
   End
   Begin VB.Line Line4 
      X1              =   3600
      X2              =   3600
      Y1              =   3600
      Y2              =   5280
   End
   Begin VB.Label Label16 
      Caption         =   "Address:"
      Height          =   255
      Left            =   240
      TabIndex        =   28
      Top             =   4560
      Width           =   735
   End
   Begin VB.Label Label15 
      Caption         =   "Data Acquisition Device:"
      Height          =   615
      Left            =   240
      TabIndex        =   26
      Top             =   3720
      Width           =   975
   End
   Begin VB.Label Label8 
      Caption         =   "Reverse Speed (mm/s)"
      Height          =   255
      Left            =   2880
      TabIndex        =   24
      Top             =   6720
      Width           =   1815
   End
   Begin VB.Label Label14 
      Caption         =   "Scan Speed (mm/s)"
      Height          =   255
      Left            =   2880
      TabIndex        =   22
      Top             =   6240
      Width           =   1455
   End
   Begin VB.Line Line2 
      X1              =   120
      X2              =   8280
      Y1              =   3480
      Y2              =   3480
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   8280
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Label Label12 
      Caption         =   "Motor:"
      Height          =   375
      Left            =   240
      TabIndex        =   21
      Top             =   360
      Width           =   975
   End
   Begin VB.Label Label11 
      Caption         =   "End:"
      Height          =   255
      Left            =   360
      TabIndex        =   19
      Top             =   6720
      Width           =   495
   End
   Begin VB.Label Label10 
      Caption         =   "Start"
      Height          =   255
      Left            =   360
      TabIndex        =   17
      Top             =   6240
      Width           =   735
   End
   Begin VB.Label Label9 
      Caption         =   "No of loops :"
      Height          =   375
      Left            =   120
      TabIndex        =   15
      Top             =   7200
      Width           =   1095
   End
   Begin VB.Label Label7 
      Height          =   255
      Left            =   2400
      TabIndex        =   11
      Top             =   2880
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "Distance (mm) :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   2160
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "Go to position (mm):"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   1440
      Width           =   1935
   End
End
Attribute VB_Name = "newport_stepper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    GPIB.send "TSTR0", 6
    GPIB.send "REST", 6
    NanoStep.HomeTrack
    StagePosition
End Sub
Private Sub StagePosition()
Dim settings As String
Dim request As String

    settings = "921600,n,8,1"
    request = "1DP?"
    resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, request, settings)
    Label7.Caption = resp
    
End Sub
Private Sub Command10_Click()

Command10.Caption = "stopping"
GPIB.send "PAUS", 6
    
End Sub

Private Sub Command12_Click()

If Combo1.ListIndex = 0 Then

    Scope_DPO7054.SetTriggerType Val(Text10.Text)
    Scope_DPO7054.SetPulseTriggerSubType Val(Text10.Text)
    Scope_DPO7054.SetupTransitiontrigger Val(Text10.Text)
    Scope_DPO7054.SetHorizontalScale Val(Text10.Text)
    Text7.Enabled = True
    
    Else:
    If Combo1.ListIndex = 1 Then
        Text10.Text = 6
        Text12.Text = ""
        Text7.Enabled = False
    End If
    
End If
    
    
End Sub


Private Sub Command2_Click()

If Val(Text1.Text) > 600 Then
    cant = MsgBox("Too much, please enter different value", vbOKOnly + vbExclamation, "ERROR!")
    GoTo away
End If
    GPIB.send "TSTR0", 6
    NanoStep.GoToPosition Val(Text1.Text)
    StagePosition
away:
End Sub


Private Sub Command3_Click()

If Val(Text2.Text) > (600 - Val(Text1.Text)) Then
    cant = MsgBox("Too much, please enter different value", vbOKOnly, "ERROR")
    GoTo gone
End If

GPIB.send "TSTR0", 6
NanoStep.MoveTrack Val(Text2.Text)
StagePosition
    
gone:
End Sub

Private Sub Command4_Click()
Dim pts As Integer
Dim tc As Integer
Dim ScanTime As Double

If Combo1.ListIndex = 0 Then
    other = MsgBox("Please select Lock In as device and press set device", vbOKOnly, "Lock In Not Selected!")
    GoTo getout
End If

If Combo2.Text = "Choose Scan Length" Then
    other = MsgBox("Please choose scan length", vbOKOnly, "Scan length Not Selected!")
    GoTo getout
End If
If Combo3.Text = "Choose resolution" Then
    other = MsgBox("Please choose resolution", vbOKOnly, "Resolution Not Selected!")
    GoTo getout
End If
If Combo4.Text = "Time-constant" Then
    other = MsgBox("Please choose time-constant", vbOKOnly, "Time-constant Not Selected!")
    GoTo getout
End If
    
sl = Val(Combo2.Text) + (2 * 20 / 3) 'scan length intended + 2mm for start and end of stage movement
pts = (sl / Val(Combo3.Text)) * 1000 'number of points intended + 2mm for start and end of stage movement
pts2 = ((sl - (2 * 20 / 3)) / Val(Combo3.Text)) * 1000 'number of points intended
mm = (sl * 3) / 20
tc = 4

If Combo4.ListIndex = 0 Then
    SampleRate = 12 '256Hz
    sr = 256
End If
If Combo4.ListIndex = 1 Then
    SampleRate = 10 '64Hz
    sr = 64
End If
If Combo4.ListIndex = 2 Then
    SampleRate = 9 '32Hz
    sr = 32
End If
If Combo4.ListIndex = 3 Then
    SampleRate = 7  '8Hz
    sr = 8
End If
If Combo4.ListIndex = 4 Then
    SampleRate = 5  '2Hz
    sr = 2
End If
If Combo4.ListIndex = 5 Then
    SampleRate = 4  '1Hz
    sr = 1
End If
If Combo4.ListIndex = 6 Then
    SampleRate = 2  '250mHz
    sr = 0.25
End If
If Combo4.ListIndex = 7 Then
    SampleRate = 0  '62.5mHz
    sr = 0.0625
End If

tc = 4 + Int(Combo4.ListIndex)
GPIB.send "OFLT" & CStr(tc), 6
GPIB.send "SRAT" & CStr(SampleRate), 6
ScanTime = pts / sr
If ScanTime > 60 Then
    If ScanTime < 3600 Then
        timing = ScanTime / 60
        wrong = MsgBox("One scan will take " & CStr(timing) & " min(s). Continue?", vbYesNo + vbExclamation, "NOTE!")
    End If
    If ScanTime > 3600 Then
        timing = ScanTime / 3600
        wrong = MsgBox("One scan will take " & CStr(timing) & " hour(s). Continue?", vbYesNo + vbExclamation, "NOTE!")
    End If
    If wrong = vbNo Then GoTo getout
    If wrong = vbYes Then GoTo fine
End If

fine:
vstage = mm / ScanTime
If vstage > 100 Then
    other = MsgBox("maximum velocity exceeded! Please choose different time constant", vbOKOnly + vbExclamation, "Velocity Error!")
    GoTo getout
End If

If vstage > 10 Then
    wrong = MsgBox("Stage velocity more than 10 mm/s. Continue?", vbYesNo + vbExclamation, "NOTE!")
    If wrong = vbNo Then GoTo getout
End If

Label19.Caption = CStr(pts2) & " points in "
Label6.Caption = CStr(ScanTime) & " s"
Text8.Text = vstage
Text3.Text = vstage
Text7.Text = ""
Text6.BackColor = &H8000000D
Text6.Text = ""

getout:
End Sub

Private Sub Command5_Click()

Dim settings As String
Dim command As String
Dim request As String

    command = "1VA" + Text3.Text
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    request = "1VA?"
    resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, request, settings)
    Text3.Text = Val(resp)

End Sub



Private Sub Command6_Click()
Dim settings As String
Dim command As String

    command = "1MO"
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    
End Sub

Private Sub Command7_Click()
Dim settings As String
Dim command As String

    command = "1MF"
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    
End Sub

Private Sub Command8_Click()
StagePosition
End Sub

Private Sub Command9_Click()

Dim settings As String
Dim command As String
Dim n As Integer
Dim timeout
Dim motion_done As Integer
Dim resp As String
Dim timing As Integer

n = Text5.Text
settings = "921600,n,8,1"
'Sensitivity = MsgBox("Is sensitivity reasonable?", vbYesNo + vbQuestion, "sensitivity")
'If Sensitivity = vbNo Then GoTo endit

    If Combo1.ListIndex = 1 Then
        GPIB.send "TSTR0", 6    'set to NOT trigger when stage go to start pos
        command = "1PA" & CStr(Val(Text6.Text) - 1) 'go to start position before scanning
        RS232.RS232_Send Newport_Stepper_Port, settings, command
        motion_done = 0
        timing = Val(Label6.Caption)
        timeout = 10
        If timing > 1 Then
            timeout = timing + timeout
        End If
        t = Timer + timeout
        While (motion_done = 0 And Timer < t)
            command = "1MD?"
            resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, command, settings)
            motion_done = Int(Val(resp))
            Pause (0.1)
        Wend
    End If
    
    If Combo1.ListIndex = 0 Then
        command = "1PA" + Format(Val(Text6.Text)) 'go to start position before scanning
    End If
    
    command = "BO 1H" 'Set port A as output
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    command = "SB 000H" 'Set all outputs low
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    command = "1BM0, 0" 'Set bit 0 LOW as motion status
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    
    If Combo1.ListIndex = 0 Then
        Scope_DPO7054.Acquire 1, 3
    End If
        
For l = 1 To n
        Label13.Caption = ""
        If Combo1.ListIndex = 1 Then
            GPIB.send "REST", 6
            GPIB.send "TSTR1", 6    'set to trigger when stage moves
            Pause (0.1)
        End If
        
        command = "1BN 1" 'Enable motion status notification
        RS232.RS232_Send Newport_Stepper_Port, settings, command
        
        command = "1VA" + Format(Val(Text8.Text)) 'Set scan speed
        RS232.RS232_Send Newport_Stepper_Port, settings, command
        Pause (0.1)
        
        'Wait for scope ready to trigger
        If Combo1.ListIndex = 0 Then
            Scope_DPO7054.DPO_Scope_WaitForReadyToTrigger (Val(Text10.Text))
            command = "1PA" & CStr(Val(Text7.Text)) 'Move to end of scan
            Else
                If Combo1.ListIndex = 1 Then
                    command = "1PA" & CStr(Val(Text7.Text) + 1) 'Move to end of scan
                Else
                    command = "1PA" & CStr(Val(Text7.Text)) 'Move to end of scan
                End If
        End If

        RS232.RS232_Send Newport_Stepper_Port, settings, command
        
        'Wait for motion finished
        motion_done = 0
        timing = Val(Label6.Caption)
        timeout = 5
        If timing > 1 Then
            timeout = timing + timeout
        End If
        t = Timer + timeout
        While (motion_done = 0 And Timer < t)
            command = "1MD?"
            resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, command, settings)
            motion_done = Int(Val(resp))
            Pause (0.1)
        Wend
               
        If Combo1.ListIndex = 1 Then
            GPIB.send "PAUS", 6
        End If
        
        command = "1BN 0" 'Disable Notification
        RS232.RS232_Send Newport_Stepper_Port, settings, command
        command = "1VA" + Format(Val(Text9.Text)) 'Set reverse speed
        RS232.RS232_Send Newport_Stepper_Port, settings, command
        
        If Command10.Caption = "stopping" Then
            command = "1ST"
            RS232.RS232_Send Newport_Stepper_Port, settings, command
            GoTo endit
        End If
        
        If Combo1.ListIndex = 1 Then
            GetBufferData l
            If Label13.Caption = "ERROR!" Then GoTo endit
            GPIB.send "TSTR0", 6    'set to not trigger when stage moves
            command = "1PA" & CStr(Val(Text6.Text) - 1) 'Move to start of scan
            Else
            command = "1PA" + Format(Val(Text6.Text)) 'Move to start of scan
        End If
        
        RS232.RS232_Send Newport_Stepper_Port, settings, command
        
        'Wait for motion finished
        motion_done = 0
        timeout = 20
        t = Timer + timeout
        While (motion_done = 0 And Timer < t)
            command = "1MD?"
            resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, command, settings)
            motion_done = Int(Val(resp))
        Wend
        Label5.Caption = "finished " & CStr(l) & " loop(s)"
Next l
    
    'GetTraceFromScope  'use this here whenever using scope ONLY

endit:
Command10.Caption = "Stop"
good = MsgBox("Stage has stopped", vbOKOnly, "STOPPED")
If Combo1.ListIndex = 1 Then
    GPIB.send "REST", 6 'resets buffer
End If
StagePosition

End Sub

Private Sub GetTraceFromScope()
Dim addr As Integer
Dim inbuf As String

If Combo1.ListIndex = 0 Then
    Call Scope_DPO7054.DPO_StopAcquisition(Val(Text10.Text))
    Call Scope_DPO7054.DPO_ScopeTrace(tdata, sdata, Val(Text10.Text), Val(Text12.Text))
End If
    
'Plot the data
TraceForm.PlotTrace tdata, sdata
SaveData tdata, sdata
    
End Sub

Private Sub GetBufferData(V)
Dim addr As Integer
Dim datax() As Double
Dim datay() As Double
Dim yydata() As Double
Dim xxdata() As Double
Dim buffpts As String
Dim j As String
Dim k As Integer
Dim command As String
Dim numpts As Integer
Dim z As String
Dim e As String
Dim res As Double

addr = 6
buffpts = ""

try:
GPIB.send "SPTS?", addr     'queries how many points in buffer?
buffpts = GPIB.Recv(addr, 256)    'buffpts gives number of points

want = Val(Label19.Caption) 'number of points intended
't = 0
numpts = 0
k = Val(buffpts) - 1
If (k < 0 Or k > want + 1000) Then
    nopts = MsgBox("Lock-in not giving number of points", vbOKOnly, "BUFFER ERROR!")
    Label13.Caption = "ERROR!"
    GoTo finishit
End If

j = ""
If k < 130 Then
    command = "TRCA?1,0," & CStr(k)
    GPIB.send command, addr   'sends commands for buffer (channel 1, 0(from start), total to take)
    j = GPIB.Recv(addr, 2000)   'max allowed transfer in gpib is 2000 bytes
    'hah = Len(j) / 15
    GoTo looping
End If
    
stm:
If numpts < k Then
    command = "TRCA?1," & CStr(numpts) & ",130"
    GPIB.send command, addr   'sends commands for buffer (channel 1, 0(from start), total to take)
    c = GPIB.Recv(addr, 2000)   'max allowed transfer in gpib is 2000 bytes
    j = j & c
    numpts = numpts + 130
    't = t + 1
    'u = Len(j)
    'num = Len(c)
    GoTo stm
End If

'the = Len(j) / 15

If numpts > k Then
    numpts = numpts - 130
    z = k - numpts
    command = "TRCA?1," & CStr(numpts) & "," & CStr(z)
    GPIB.send command, addr   'sends commands for buffer (channel 1, 0(from start), total in buffer)
    c = GPIB.Recv(addr, 2000)   'max allowed transfer in gpib is
    j = j & c
End If

looping:

If Len(j) = 0 Then
    ohno = MsgBox("No data collected from buffer!", vbRetryCancel + vbCritical, "NO DATA")
    If ohno = vbRetry Then GoTo try
    If ohno = vbCancel Then
    Label13.Caption = "ERROR!"
    GoTo finishit
    End If
End If

If Len(j) / 14 < want Then
    ohno = MsgBox("Cannot retrieve enough data from buffer!", vbRetryCancel + vbCritical, "NO DATA")
    If ohno = vbRetry Then GoTo try
    If ohno = vbCancel Then
    Label13.Caption = "ERROR!"
    GoTo finishit
    End If
End If

ReDim datax(0 To k)
ReDim datay(0 To k)
    
res = Val(Combo3.Text)
For d = 0 To k
    b = InStr(1, j, ",") 'number of char until the comma
    If b = 0 Then GoTo ext
    inbuf = Left(j, b - 1)  'take the front point
    e = Right(j, Len(j) - b) 'cut out the front point
    'the = Len(e) / 15
    
    'Scan through the 20 char buffer (one point) and
    'separate mantissa from exponent
        
    m1 = -1
    m2 = -1
    success = True
    For a = 1 To 20
        If Mid(inbuf, a, 1) = "e" Then m1 = a
        If Mid(inbuf, a, 1) = vbLf Then m2 = a: GoTo fin
        If a = Len(inbuf) Then m2 = a + 1: GoTo fin
    Next a
fin:
    If (m1 > -1 And m2 > -1) Then
        mantissa = Val(Mid(inbuf, 1, (m1 - 1)))
        exponent = Val(Mid(inbuf, (m1 + 1), (m2 - (m1 + 1))))
        valu = mantissa * (10 ^ exponent)
    ElseIf (m1 = -1 And m2 > -1) Then
        valu = Val(Mid(inbuf, 1, (m2 - 1)))
    ElseIf (m2 = -1) Then
        success = False
    End If
    j = e
    datax(d) = (res * d) * (10 ^ -6)
    datay(d) = valu
Next d
ext:

u = res * (10 ^ -3) 'in picoseconds
points = 0
recalc:
If u < (20 / 3) Then    '6.6666667ps (calculating first 1mm of points)
    points = points + 1
    u = u * points
    GoTo recalc
End If

If V = 1 Then
    dd = want - 1  'total number of points
    ReDim ave(0 To dd)           'redimension the array
Else
    dd = UBound(ave)
    ReDim Preserve ave(0 To dd)  'preserve previous array elements while redimensioning
End If

ReDim yydata(0 To dd)
ReDim xxdata(0 To dd)

For yy = 0 To dd
    yydata(yy) = datay(points + yy)
    xxdata(yy) = datax(yy)
Next yy

For zz = 0 To dd
    ave(zz) = ((V - 1) * ave(zz) + yydata(zz)) / V
Next zz

SaveData xxdata, ave

'Plot the data
TraceForm.PlotTrace xxdata, ave

finishit:
End Sub

Public Sub SaveData(tdata, sdata)

If VarType(tdata) And vbArray Then 'Did we get the data back OK?
    If Text11.Text <> "" Then 'Do we want to save it to file?
        fnum = FreeFile
        Open Text11.Text For Output As #fnum
            For a = LBound(tdata) To UBound(tdata)
                strng = Format(tdata(a)) + "," + Format(sdata(a))
                Print #fnum, strng
            Next a
        Close #fnum
    End If
End If

End Sub
Public Sub NewportStepper_HomeTrack()

    Dim motion_done As Integer
    Dim settings As String
    Dim command As String
    Dim timeout
    Dim resp As String

    settings = "921600,n,8,1"
    command = "1OR4"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
   
    'Wait for motion finished
    motion_done = 0
    timeout = 20
    t = Timer + timeout
    While (motion_done = 0 And Timer < t)
        command = "1MD?"
        resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, command, settings)
        motion_done = Int(Val(resp))
        Pause (0.1)
    Wend
        
End Sub

Public Sub NewportStepper_MoveTrack(dist)

    Dim motion_done As Integer
    Dim settings As String
    Dim command As String
    Dim timeout
    Dim resp As String

    command = "1PR" + Format(dist)
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
   
    'Wait for motion finished
    motion_done = 0
    timeout = 20
    t = Timer + timeout
    While (motion_done = 0 And Timer < t)
        command = "1MD?"
        resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, command, settings)
        motion_done = Int(Val(resp))
        Pause (0.1)
    Wend
        
End Sub
Public Sub NewportStepper_MoveTrackAsynchronous(dist)


    Dim settings As String
    Dim command As String

    command = "1PR" + Format(dist)
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command

        
End Sub

Public Sub NewportStepper_GoToPosition(pos)

    Dim motion_done As Integer
    Dim settings As String
    Dim command As String
    Dim timeout
    Dim resp As String

    command = "1PA" + Format(pos)
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    
    'Wait for motion finished
    motion_done = 0
    timeout = 20
    t = Timer + timeout
    While (motion_done = 0 And Timer < t)
        command = "1MD?"
        resp = RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, command, settings)
        motion_done = Int(Val(resp))
        Pause (0.1)
    Wend
        
End Sub

Public Sub NewportStepper_Init(Optional velocity = 50, Optional accel = 200)

    Dim settings As String
    Dim command As String
    Dim request As String

    command = "1VA" + Format(velocity)
    settings = "921600,n,8,1"
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    command = "1AC" + Format(accel)
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    command = "1AG" + Format(accel)
    RS232.RS232_Send Newport_Stepper_Port, settings, command
    
    NanoStep.UpdateNanoStepPositionCounter
    NanoStep.UpdateNanoStepSpeed
    
End Sub

Public Sub NewportStepper_UpdateNanoStepSpeed()

    Dim settings As String
    Dim request As String

    settings = "921600,n,8,1"
    request = "1VA?"
    NanoStep.CurrentSpeed = Val(RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, request, settings))

End Sub

Public Sub NewportStepper_UpdateNanoStepPositionCounter()

    Dim settings As String
    Dim request As String

    settings = "921600,n,8,1"
    request = "1TP?"
    NanoStep.CurrentPosition = Val(RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, request, settings))

End Sub


Public Function NewportStepper_GetSmallestNanoStep() As Single

    Dim settings As String
    Dim request As String

    settings = "921600,n,8,1"
    request = "1SU?"
    NewportStepper_GetSmallestNanoStep = Val(RS232.RS232_SendRequest_and_Receive(Newport_Stepper_Port, request, settings))

End Function

Private Sub Form_Load()
    
    Combo1.Clear
    Combo1.AddItem "DPO7054"
    Combo1.AddItem "LOCK IN"
    Combo1.AddItem "OTHERS"
    Combo1.ListIndex = 0
    
    'Combo2.Clear
    Combo2.AddItem "50 ps"
    Combo2.AddItem "100 ps"
    Combo2.AddItem "200 ps"
    Combo2.AddItem "500 ps"
    Combo2.AddItem "1000 ps"
    Combo2.AddItem "2000 ps"
    'Combo2.ListIndex = 5
    
    'Combo3.Clear
    Combo3.AddItem "200 fs/point"
    Combo3.AddItem "500 fs/point"
    Combo3.AddItem "1000 fs/point"
    Combo3.AddItem "2000 fs/point"
    Combo3.AddItem "5000 fs/point"
    'Combo3.ListIndex = 0
    
    'Combo4.Clear
    Combo4.AddItem "0.001s"
    Combo4.AddItem "0.003s"
    Combo4.AddItem "0.01s"
    Combo4.AddItem "0.03s"
    Combo4.AddItem "0.1s"
    Combo4.AddItem "0.3s"
    Combo4.AddItem "1s"
    Combo4.AddItem "3s"
    'Combo4.ListIndex = 0
    
    
End Sub

Private Sub Text6_Change()

If Val(Text6.Text) > 550 Then
    cant = MsgBox("Wrong value, please give different start position", vbOKOnly, "ERROR")
    GoTo noway
End If

If Combo1.ListIndex = 1 Then
    If Text6.Text = "0" Then
        cannot = MsgBox("Must enter 1 or more in start position", vbOKOnly, "Invalid range")
        Text6.Text = ""
        GoTo noway
    End If
    scl = Val(Combo2.Text)
    Text7.Text = (((scl * 3) / 20) + Val(Text6.Text))
End If

noway:
End Sub
