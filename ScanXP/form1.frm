VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Direct GPIB Control"
   ClientHeight    =   8835
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8250
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8835
   ScaleWidth      =   8250
   Begin VB.CommandButton Command7 
      Caption         =   "Command7"
      Height          =   1575
      Left            =   4320
      TabIndex        =   14
      Top             =   4560
      Width           =   2175
   End
   Begin VB.ListBox preamlist 
      Height          =   2205
      ItemData        =   "form1.frx":0000
      Left            =   360
      List            =   "form1.frx":001F
      TabIndex        =   13
      Top             =   4320
      Width           =   3495
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Command6"
      Height          =   495
      Left            =   240
      TabIndex        =   12
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "G.E.T"
      Height          =   495
      Left            =   1560
      TabIndex        =   10
      Top             =   2400
      Width           =   1215
   End
   Begin VB.TextBox Text3 
      Height          =   495
      Left            =   1440
      TabIndex        =   6
      Top             =   1560
      Width           =   2895
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Receive Response"
      Height          =   495
      Left            =   4560
      TabIndex        =   5
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Send IFC"
      Height          =   495
      Left            =   240
      TabIndex        =   4
      Top             =   2400
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Reset Device Interface"
      Height          =   495
      Left            =   4560
      TabIndex        =   3
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Send Command"
      Height          =   495
      Left            =   4560
      TabIndex        =   2
      Top             =   840
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      Height          =   495
      Left            =   1440
      TabIndex        =   1
      Top             =   120
      Width           =   2895
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   1440
      TabIndex        =   0
      Top             =   840
      Width           =   2895
   End
   Begin VB.Label Label4 
      Caption         =   "Note: 'Reset Device Interface' and 'Group Execute Trigger' (G.E.T) will be sent to all devices if the address is set to -1"
      Height          =   855
      Left            =   3240
      TabIndex        =   11
      Top             =   2400
      Width           =   2415
   End
   Begin VB.Label Label3 
      Caption         =   "Response:"
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   1680
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Command:"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   960
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "GPIB Address:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim da() As Byte
Dim datbl(0 To 6000) As Integer
Private Sub Command1_Click()
    
    Dim addr As Integer
    
    addr = Val(Text2.Text)

    GPIB.send Text1.Text, addr
    
    Text3.Text = ""
    
End Sub

Private Sub Command2_Click()
a = Val(Text2.Text)
If Text2.Text = "" Then a = -1
GPIB.ResetDeviceInterface (a)
End Sub

Private Sub Command3_Click()
GPIB.IFC
End Sub

Private Sub Command4_Click()
Text3.Text = GPIB.Recv(Val(Text2.Text), 256)
End Sub

Private Sub Command5_Click()
GPIB.GroupExecuteTrigger (Val(Text2.Text))
End Sub

Private Sub Command6_Click()

'DVM34401A_Read (OutBuffer)

s = ""
'For a = LBound(OutBuffer) To UBound(OutBuffer)
'    s = s + Format(OutBuffer(a)) + " "
'Next a

'Text3.Text = DVM34401A_GetSample


End Sub

Private Sub Command7_Click()
    For i = 0 To preamlist.ListCount - 1
        a = GPIB.send(preamlist.List(i), 1, True)
    Next i
        
        a = GPIB.send("Curve?", 1, True)
        dac = GPIB.Recv(1, 10000, True)
        
        da = StrConv(dac, vbFromUnicode)
        'datbl = CInt(dac)
        
    For i = 0 To 5000 - 1
        datbl(i) = da(i * 2) & da((i * 2) + 1)
   Next i
        
        
        
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

    If UnloadMode = 0 Then Cancel = 1: Form1.Hide

End Sub
