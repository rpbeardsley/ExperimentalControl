VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form RS232 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RS232 Communications"
   ClientHeight    =   4815
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6570
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4815
   ScaleWidth      =   6570
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   2040
      TabIndex        =   6
      Text            =   "1VA?"
      Top             =   3480
      Width           =   4095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Go"
      Height          =   495
      Left            =   480
      TabIndex        =   5
      Top             =   3480
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Read"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   1320
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   1080
      TabIndex        =   1
      Top             =   360
      Width           =   2895
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Send"
      Height          =   495
      Left            =   4440
      TabIndex        =   0
      Top             =   360
      Width           =   1215
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   240
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.Label Label3 
      Caption         =   "Newport Stage Send Request and Receive Response"
      Height          =   255
      Left            =   480
      TabIndex        =   7
      Top             =   3000
      Width           =   4095
   End
   Begin VB.Label Label2 
      Height          =   495
      Left            =   1560
      TabIndex        =   4
      Top             =   2040
      Width           =   4695
   End
   Begin VB.Label Label1 
      Height          =   375
      Left            =   1680
      TabIndex        =   3
      Top             =   1440
      Width           =   4575
   End
End
Attribute VB_Name = "RS232"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

MSComm1.CommPort = 1
MSComm1.DTREnable = 1
MSComm1.EOFEnable = False
MSComm1.settings = "19200,n,8,2"

MSComm1.PortOpen = True

MSComm1.Output = Text1.Text + vbCr

MSComm1.PortOpen = False

End Sub

Public Function RS232_Send(port As Integer, settings As String, command As String)

MSComm1.CommPort = port
MSComm1.DTREnable = 1
MSComm1.EOFEnable = False
MSComm1.settings = settings

MSComm1.PortOpen = True

MSComm1.Output = command + vbCr

MSComm1.PortOpen = False

End Function

Private Sub Command2_Click()

timout = 1

MSComm1.CommPort = 1
MSComm1.DTREnable = True
MSComm1.EOFEnable = False
MSComm1.settings = "19200,O,8,2"
MSComm1.Handshaking = comXOnXoff
MSComm1.RThreshold = 0 'Do not generate OnComm event when characters arrive
MSComm1.InputLen = 0 'Read whole buffer each time input is queried
MSComm1.RTSEnable = False


MSComm1.PortOpen = True

t = Timer + timout
stat = -2
buff = ""
While stat = -2

    If Timer > t Then stat = -1
    
    If MSComm1.InBufferCount > 0 Then
        tmpbuff = MSComm1.Input
        
        'Ignore character 255
        'tmp2buff = ""
        'For a = 1 To Len(tmpbuff)
        '    If Asc(Mid(tmpbuff, a, 1)) <> 255 Then
        '        tmp2buff = tmp2buff + Mid(tmpbuff, a, 1)
        '    End If
        'Next a
        'tmpbuff = tmp2buff
        
        'Stop checking when we get carriage return character
        For a = 1 To Len(tmpbuff)
            If Asc(Mid(tmpbuff, a, 1)) = 13 Then
                buff = buff + Mid(tmpbuff, 1, a - 1)
                stat = Len(buff)
                GoTo nxt
            End If
        Next a
        
        If stat < 0 Then buff = buff + tmpbuff
nxt:
    End If
    
    DoEvents
    
Wend


If stat > -1 Then
    Label1.Caption = buff
Else
    Label1.Caption = "Timeout"
End If

    Label2.Caption = ""
For a = 1 To Len(Label1.Caption)
    Label2.Caption = Label2.Caption + Format(Asc(Mid(Label1.Caption, a, 1))) + ", "
Next a

MSComm1.PortOpen = False

End Sub

Public Function RS232_SendRequest_and_Receive(port As Integer, request As String, settings As String) As String

MSComm1.CommPort = port
MSComm1.DTREnable = 1
MSComm1.EOFEnable = False
MSComm1.settings = settings
MSComm1.Handshaking = 2

MSComm1.RThreshold = 0 'Do not generate OnComm event when characters arrive
MSComm1.InputLen = 0 'Read whole buffer each time input is queried
MSComm1.RTSEnable = True

MSComm1.PortOpen = True

MSComm1.Output = request + vbCr

timout = 1

t = Timer + timout
stat = -2
buff = ""
While stat = -2

    If Timer > t Then stat = -1
    
    If MSComm1.InBufferCount > 0 Then
        tmpbuff = MSComm1.Input
        
        
        'Stop checking when we get carriage return character
        For a = 1 To Len(tmpbuff)
            If Asc(Mid(tmpbuff, a, 1)) = 13 Then
                buff = buff + Mid(tmpbuff, 1, a - 1)
                stat = Len(buff)
                GoTo nxt
            End If
        Next a
        
        If stat < 0 Then buff = buff + tmpbuff
nxt:
    End If
    
    DoEvents
    
Wend

MSComm1.PortOpen = False


If stat > -1 Then
    RS232_SendRequest_and_Receive = buff
Else
    Label1.Caption = ""
    MsgBox "Timeout Waiting for RS232 device to respond.", vbOKOnly Or vbExclamation, "Error"
End If



End Function

Private Sub Command3_Click()

Dim port As Integer
Dim request As String
Dim settings As String

port = 3
settings = "921600,n,8,1"
request = Text2.Text

resp = RS232_SendRequest_and_Receive(port, request, settings)

Label1.Caption = resp

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then
        Cancel = 1
        RS232.Hide
    End If

End Sub


