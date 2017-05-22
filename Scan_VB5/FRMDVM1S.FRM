VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmDvm1Setup 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Dvm1 Setup"
   ClientHeight    =   4890
   ClientLeft      =   1365
   ClientTop       =   2205
   ClientWidth     =   5730
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4890
   ScaleWidth      =   5730
   Begin Threed.SSFrame frameTestDVM 
      Height          =   1035
      Left            =   270
      TabIndex        =   15
      Top             =   3720
      Width           =   5055
      _Version        =   65536
      _ExtentX        =   8916
      _ExtentY        =   1826
      _StockProps     =   14
      Caption         =   "DVM output"
      ForeColor       =   16711680
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.Frame Frame2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   675
         Left            =   120
         TabIndex        =   18
         Top             =   210
         Width           =   2985
         Begin VB.PictureBox picLCD 
            Appearance      =   0  'Flat
            BackColor       =   &H00000000&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000FF&
            Height          =   525
            Left            =   30
            ScaleHeight     =   525
            ScaleWidth      =   2910
            TabIndex        =   19
            Top             =   120
            Width           =   2912
         End
      End
      Begin VB.CommandButton cmdIEEECommand 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "IEEE command"
         Height          =   345
         Left            =   3330
         TabIndex        =   17
         Top             =   180
         Width           =   1575
      End
      Begin VB.CommandButton cmdStartStop 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Start"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   3330
         TabIndex        =   16
         Top             =   600
         Width           =   1575
      End
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "DMM type"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   1095
      Left            =   360
      TabIndex        =   12
      Top             =   2400
      Width           =   1935
      Begin VB.OptionButton optBlackStar 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "BlackStar 4503"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   720
         Width           =   1695
      End
      Begin VB.OptionButton optSolartron 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Solartron 7150"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   360
         Width           =   1695
      End
   End
   Begin VB.ComboBox cmbMeasurement 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   360
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   600
      Width           =   1935
   End
   Begin VB.CheckBox Check2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Check2"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3240
      TabIndex        =   8
      Top             =   3240
      Width           =   255
   End
   Begin VB.CheckBox Check1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Check1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3240
      TabIndex        =   7
      Top             =   2760
      Width           =   255
   End
   Begin VB.CheckBox chkFilter 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Check1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3240
      TabIndex        =   5
      Top             =   2280
      Width           =   255
   End
   Begin VB.CommandButton cmdCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   495
      Left            =   3480
      TabIndex        =   4
      Top             =   900
      Width           =   1455
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "OK"
      Height          =   495
      Left            =   3480
      TabIndex        =   3
      Top             =   210
      Width           =   1455
   End
   Begin VB.TextBox txtRange 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   360
      TabIndex        =   0
      Top             =   1680
      Width           =   1575
   End
   Begin Spin.SpinButton Spin1 
      Height          =   255
      Left            =   2040
      TabIndex        =   20
      Top             =   1680
      Width           =   255
      _Version        =   65536
      _ExtentX        =   450
      _ExtentY        =   450
      _StockProps     =   73
      BackColor       =   -2147483643
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Measurement:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   360
      TabIndex        =   11
      Top             =   240
      Width           =   1335
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Some other option"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3720
      TabIndex        =   10
      Top             =   3240
      Width           =   1575
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Hi-res"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3720
      TabIndex        =   9
      Top             =   2760
      Width           =   615
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Filter"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3690
      TabIndex        =   6
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Range:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   1320
      Width           =   735
   End
End
Attribute VB_Name = "frmDvm1Setup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim range As Integer, testing As Integer



Private Sub chkFilter_Click()

If chkFilter.Value = 1 Then

SendIEEEdata ("I4")

Else

SendIEEEdata ("I3")

End If

End Sub



Private Sub cmdCancel_Click()

testing = 0

frmDvm1Setup.Hide

End Sub



Private Sub cmdIEEECommand_Click()

cm$ = InputBox$("Command to send to IEEE bus")

SendIEEECmd (cm$)

End Sub



Private Sub cmdOK_Click()

testing = 0

' Output setup status to DMM



Do: a% = Spoll(dev%): Loop Until a% <> 0



If optBlackStar.Value = True Then

' Blackstar commands follow..



 If range = 0 Then

 SendIEEEdata ("A")

 Else

 SendIEEEdata ("R" + Format$(range, "0"))

 End If

 

 ' output measurement mode

Select Case cmbMeasurement.ListIndex

 Case 0

 SendIEEEdata ("F1")

 Case 1

 SendIEEEdata ("F5")

 Case 2

 SendIEEEdata ("F3")

End Select

 

Else

' insert Solartron commands here

' Output measurement mode

Select Case cmbMeasurement.ListIndex

 Case 0

 SendIEEEdata ("M0")

 Case 1

 SendIEEEdata ("M3")

 Case 2

 SendIEEEdata ("M2")

End Select



' Output range

 SendIEEEdata ("R" + Format$(range, "0"))





End If

frmDvm1Setup.Hide

End Sub



Private Sub cmdStartStop_Click()

'picLCD.Tag = -1

'picLCD.Cls
'sc rem out until end sub
'testing = testing Xor 1



'If testing = 1 Then cmdStartStop.Caption = "STOP" Else cmdStartStop.Caption = "Start"



'Do While testing = 1

'DoEvents

'Inp$ = Left$(recvIEEEdata(20), 9)

'displayLCD Inp$, frmDvm1Setup!picLCD, &HFF

'Loop

End Sub



Private Sub Form_Activate()

cmdOK.SetFocus

Caption = "DVM " + Str$(dmm%) + " setup"

SendIEEECmd (Str$(ieeeaddr(dev%)))



' attempt to ID DMM type if we don't already know it

Rem If gDMM_TYPE(dmm%) < 1 Or gDMM_TYPE(dmm%) > 2 Then

SendIEEECmd ("SPOLL")

recv$ = String(255, 0)

ret% = Pro488ReadCtrl(recv$)

DoEvents

Pol% = Val(Mid$(recv$, 28, 3))

Select Case Pol%

Case 0

gDMM_TYPE(dmm%) = 1

Case 13

gDMM_TYPE(dmm%) = 0

Case Else

gDMM_TYPE(dmm%) = 2

End Select



Do: a% = Spoll(dev%): Loop Until a% <> 0



Select Case gDMM_TYPE(dmm%)

Case 1

 optBlackStar.Value = 1

 SendIEEEdata ("W6")

 ' interrogate mode

 SendIEEEdata ("G?")



 pause 30

 Do

 X$ = recvIEEEdata(255)

 Loop Until InStr(X$, "F") > 0

 

 posn = InStr(X$, "F")

 mode = Val(Mid$(X$, posn + 1, 1))

 posn = InStr(X$, "R")

 range = Val(Mid$(X$, posn + 1, 1))

 If range > 6 Then range = 0



 Select Case mode

  Case 5

  cmbMeasurement.ListIndex = 1

  Case 3

  cmbMeasurement.ListIndex = 2

  Case Else

  cmbMeasurement.ListIndex = 0

 End Select



 ShowRange



Case 2

 optSolartron.Value = 1

 SendIEEEdata ("U3")

 ' interrogate mode

 SendIEEEdata ("M?R?")



 pause 30

 X$ = recvIEEEdata(20)

 mode = Val(Mid$(X$, 2, 1))



 X$ = recvIEEEdata(20)

 range = Val(Mid$(X$, 2, 1))



 Select Case mode

  Case 3

  cmbMeasurement.ListIndex = 1

  Case 2

  cmbMeasurement.ListIndex = 2

  Case Else

  cmbMeasurement.ListIndex = 0

 End Select



 If range > 8 Then range = range - 8

 ShowRange





End Select



End Sub



Private Sub Form_Load()

gQUIT = 0

cmbMeasurement.AddItem "Volts", 0

cmbMeasurement.AddItem "milliAmps", 1

cmbMeasurement.AddItem "kiloOhms", 2

cmbMeasurement.ListIndex = 0



configureLCD picLCD, 8

CentreForm Me



End Sub



Private Sub optBlackStar_Click()

SendIEEEdata ("W6")

' no available function to control filter function

' remotely when using Black Star

chkFilter.Enabled = False: Label2.Caption = "Filter (n/a)"

End Sub



Private Sub optSolartron_Click()

SendIEEEdata ("U3")

' Solartron supports remote filter control

chkFilter.Enabled = True: Label2.Caption = "Filter"

End Sub



Private Sub ShowRange()

 If range = 0 Then

  txtRange.Text = "Autoranging"

 Else

  

  If optSolartron.Value = True Then

   txtRange.Text = Str$(0.02 * 10 ^ range)

  Else

   txtRange.Text = Str$(0.04 * 10 ^ range)

  End If



 End If

End Sub



Private Sub Spin1_SpinDown()



If range > 0 Then

range = range - 1

If optSolartron.Value = True Then

 If cmbMeasurement.ListIndex = 2 And range < 3 Then range = 0

 If cmbMeasurement.ListIndex = 1 And range < 5 Then range = 0

End If

ShowRange

End If

End Sub



Private Sub Spin1_SpinUp()

If range < 6 Then

range = range + 1

If optSolartron.Value = True Then

 If cmbMeasurement.ListIndex <> 2 And range = 6 Then range = 5

 If cmbMeasurement.ListIndex = 1 And range < 5 Then range = 5

 If cmbMeasurement.ListIndex = 2 And range < 3 Then range = 3

End If

ShowRange

End If

End Sub



