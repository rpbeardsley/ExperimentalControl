VERSION 5.00
Object = "{B16553C3-06DB-101B-85B2-0000C009BE81}#1.0#0"; "SPIN32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmXYsetup 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "X-Y plot"
   ClientHeight    =   5115
   ClientLeft      =   1200
   ClientTop       =   1725
   ClientWidth     =   7560
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
   HelpContextID   =   260
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5115
   ScaleWidth      =   7560
   Begin VB.CommandButton cmdNewPreset 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Define New"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   4890
      TabIndex        =   8
      Top             =   1020
      Width           =   1305
   End
   Begin VB.ComboBox cmbPresets 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   4860
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   600
      Width           =   2535
   End
   Begin VB.Frame Frame3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Hardware devices for input"
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
      Height          =   1575
      Left            =   210
      TabIndex        =   25
      Top             =   270
      Width           =   4485
      Begin VB.CommandButton cmdXsetup 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Setup"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   5
         Top             =   990
         Width           =   1575
      End
      Begin VB.CommandButton cmdYsetup 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Setup"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2490
         TabIndex        =   6
         Top             =   1020
         Width           =   1575
      End
      Begin VB.ComboBox Ydevlist 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2370
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   540
         Width           =   1815
      End
      Begin VB.ComboBox Xdevlist 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Left            =   150
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   570
         Width           =   1815
      End
      Begin VB.TextBox Text2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
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
         Height          =   225
         Left            =   2340
         TabIndex        =   27
         Text            =   "Y-source:"
         Top             =   330
         Width           =   915
      End
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
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
         Height          =   225
         Left            =   150
         TabIndex        =   26
         Text            =   "X-source:"
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.CommandButton cmdHelp 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Help"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   720
      TabIndex        =   1
      Top             =   4380
      Width           =   1785
   End
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Scaling factors:"
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
      Height          =   1815
      Left            =   210
      TabIndex        =   22
      Top             =   2160
      Width           =   2415
      Begin VB.ComboBox cmbDVMy 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1320
         Width           =   2175
      End
      Begin VB.ComboBox cmbDVMx 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   600
         Width           =   2175
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Y-source DVM reads:"
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
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "X-source DVM reads:"
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
         Height          =   255
         Left            =   120
         TabIndex        =   23
         Top             =   360
         Width           =   2055
      End
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Take readings:"
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
      Height          =   1875
      Left            =   2910
      TabIndex        =   17
      Top             =   2160
      Width           =   3945
      Begin VB.TextBox Text4 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   1320
         MultiLine       =   -1  'True
         TabIndex        =   18
         Text            =   "FRMXYSET.frx":0000
         Top             =   1470
         Width           =   1575
      End
      Begin VB.TextBox Text3 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   225
         Left            =   1320
         MultiLine       =   -1  'True
         TabIndex        =   19
         Text            =   "FRMXYSET.frx":0010
         Top             =   1140
         Width           =   1575
      End
      Begin VB.TextBox txtXend 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2910
         TabIndex        =   16
         Top             =   1440
         Width           =   780
      End
      Begin VB.TextBox txtXbegin 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2910
         TabIndex        =   15
         Top             =   1110
         Width           =   780
      End
      Begin VB.TextBox txtDeltaX 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2850
         TabIndex        =   14
         Text            =   "0.05"
         Top             =   720
         Width           =   855
      End
      Begin VB.TextBox txtTimeInterval 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   840
         TabIndex        =   12
         Text            =   "0"
         Top             =   360
         Width           =   735
      End
      Begin Spin.SpinButton Spin1 
         Height          =   315
         Left            =   2370
         TabIndex        =   29
         Top             =   720
         Width           =   255
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   556
         _StockProps     =   73
         BackColor       =   -2147483643
      End
      Begin Threed.SSOption OptDeltaX 
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   750
         Width           =   2265
         _Version        =   65536
         _ExtentX        =   3995
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Upon an X-value change of"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optTimed 
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   360
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Every"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label labPlusMinus 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   2610
         TabIndex        =   21
         Top             =   720
         Width           =   255
         WordWrap        =   -1  'True
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "seconds"
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
         Height          =   255
         Left            =   1620
         TabIndex        =   20
         Top             =   390
         Width           =   825
      End
   End
   Begin VB.CommandButton cmdCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   2880
      TabIndex        =   2
      Top             =   4380
      Width           =   1785
   End
   Begin VB.CommandButton cmdGo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Go >>"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   5070
      TabIndex        =   0
      Top             =   4380
      Width           =   1785
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Preset experiments:"
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
      Height          =   225
      Left            =   4890
      TabIndex        =   28
      Top             =   360
      Width           =   1785
   End
End
Attribute VB_Name = "frmXYsetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
    Dim inter& ' interval in milliseconds for timer
    Dim olddata ' previous x (time) data in timed mode
    Dim xdat, ydat As Single ' data read in from IEEE devices
    Dim xtarget, deltaX, dirn% ' reqd for DeltaX mode
    Dim x_ok, y_ok ' flags determining whether
                   ' x, y devices present

    Dim dvsstep As Single

Private Sub cmdCancel_Click()
Unload frmXYsetup
End Sub

Private Sub cmdGo_Click()

' Determine graph caption and X/Y IEEE device numbers
Select Case Ydevlist.Text
Case "Digitiser"
    frmXYDisplay.Caption = "Digitiser"
Case "Scope"
    frmXYDisplay.Caption = "Scope": ydev = ieeeaddr(scop)
Case "Boxcar"
    frmXYDisplay.Caption = "XY plot": ydev = ieeeaddr(bxcr)
Case "Lock-in"
    frmXYDisplay.Caption = "XY plot": ydev = ieeeaddr(lckn)
Case "Dvm1"
    frmXYDisplay.Caption = "XY plot": ydev = ieeeaddr(dmm1)
Case "Dvm2"
    frmXYDisplay.Caption = "XY plot": ydev = ieeeaddr(dmm2)
End Select

Select Case Xdevlist.Text
Case "Dvm1"
   xdev = ieeeaddr(dmm1)
Case "Dvm2"
   xdev = ieeeaddr(dmm2)
Case "B-field sweep"
   xdev = ieeeaddr(bxcr)
Case "Voltage sweep"
   xdev = ieeeaddr(dvs)
Case "time"
   xdev = 0
End Select

mode = TAKEDATA
frmDataGrid!chkplot(0).Value = 1
frmXYDisplay.Caption = "XY Plot: " & Ydevlist.Text & " as a function of " & Xdevlist.Text & "."

frmXYDisplay!Timer1.Enabled = False

If optTimed.Value = True Then
   frmXYDisplay!PanelMode.Caption = "Timed mode (" & txtTimeInterval.Text & " sec)"
   inter& = Val(txtTimeInterval.Text) * 1000
   frmXYDisplay!Timer1.Interval = inter&
End If

If frmXYsetup!Xdevlist.Text = "B-field sweep" Then
 SendIEEECmd (Str$(xdev))
 SendIEEEdata ("MR")
 SendIEEEdata ("I4")
 frmXYDisplay!PanelMode.Caption = "Field sweep (start=" & frmFieldSweep!txtFieldStart & "T  end=" & frmFieldSweep!txtFieldEnd & "T)"
 xdat = Val(frmFieldSweep!txtFieldStart) - (Val(frmFieldSweep!txtFieldStep) / 1000)
End If

If OptDeltaX.Value = True Then
 deltaX = Val(txtDeltaX.Text): xtarget = Val(txtXbegin.Text)
 If txtXbegin.Text = "" Then xtarget = -9000000000#
 frmXYDisplay!PanelMode.Caption = "Delta-X mode (step=" & txtDeltaX.Text & ")"
 dirn% = 1: If labPlusMinus.Caption = "-" Then dirn% = -1
End If


If Xdevlist.Text = "Dvm1" Then
SendIEEECmd (Str(xdev))
z$ = "CONF:VOLT:DC DEF,DEF"
SendIEEEdata z$
z$ = "TRIG:SOUR IMM"
SendIEEEdata z$
z$ = "VOLT:DC:NPLCycles 1"
SendIEEEdata z$
End If

If Xdevlist.Text = "Dvm2" Then
SendIEEECmd (Str(xdev))
z$ = "CONF:VOLT:DC DEF,DEF"
SendIEEEdata z$
SendIEEECmd (Str(xdev))
z$ = "TRIG:SOUR IMM"
SendIEEEdata z$
SendIEEECmd (Str(xdev))
z$ = "VOLT:DC:NPLCycles 1"
SendIEEEdata z$
End If

If Ydevlist.Text = "Dvm1" Then
'MsgBox (Str(ydev))
SendIEEECmd (Str(ydev))
z$ = "CONF:VOLT:DC DEF,DEF"
SendIEEEdata z$
SendIEEECmd (Str(ydev))
z$ = "TRIG:SOUR IMM"
SendIEEEdata z$
SendIEEECmd (Str(ydev))
z$ = "VOLT:DC:NPLCycles 1"
SendIEEEdata z$
End If

If Ydevlist.Text = "Dvm2" Then
SendIEEECmd (Str(ydev))
z$ = "CONF:VOLT:DC DEF,DEF"
SendIEEEdata z$
SendIEEECmd (Str(ydev))
z$ = "TRIG:SOUR IMM"
SendIEEEdata z$
SendIEEECmd (Str(ydev))
z$ = "VOLT:DC:NPLCycles 1"
SendIEEEdata z$
End If

'MsgBox ("hello")
frmXYDisplay.Show 1
End Sub

Private Sub cmdHelp_Click()
txt$ = "This screen enables the user to define the parameters for an XY plot, namely the devices to read, and the method of acquiring data from these devices." + NL + NL
txt$ = txt$ + "1. Timed mode: computer reads the input devices at regular intervals, writing to both file and screen "
txt$ = txt$ + "for each one." + NL
txt$ = txt$ + "2. 'Delta-X' mode: computer reads X-device continually, and when the value read reaches a certain value, "
txt$ = txt$ + "the Y-device is read and a point plotted, with the new X 'target' being incremented/decremented by a preset stepped "
txt$ = txt$ + "quantity." + NL + NL
txt$ = txt$ + "Continual mode has been removed due to unreliable meter readings - timed mode, used with a quick interval (eg 0.5 sec) will provide the same functionality while allowing the IEEE bus to recover between readings." + NL + NL
txt$ = txt$ + "Additionally, this screen enables the user to instruct the computer to scale the output of a DVM to read out "
txt$ = txt$ + "in units of temperature (Kelvin), pressure (Pa) or magnetic field (Tesla), according to predefined scaling equations." + NL + NL
txt$ = txt$ + "Note that the 'Go' and 'Setup' buttons will be disabled if a valid device has not been selected for each axis."
frmPad!txtPad = txt$
frmPad.Tag = "show:X-Y Plot Setup Help"
frmPad.Show 1
End Sub

Private Sub cmdNewPreset_Click()
expt$ = InputBox("Enter a short description of experiment:", "Save Experiment Settings to Hotlist")
End Sub

Private Sub cmdXsetup_Click()
Select Case Xdevlist.Text
Case "time"

Case "Dvm1"
dmm% = 1: dev% = dmm1
frmDvm1Setup.Show 1
Case "Dvm2"
dmm% = 2: dev% = dmm2
frmDvm1Setup.Show 1
Case "B-field sweep"
frmFieldSweep.Show 1

Case "Voltage sweep"
frmdvs.Show 1
End Select
End Sub

Private Sub cmdYsetup_Click()
Select Case Ydevlist.Text
Case "Digitiser"
frmDigSetup.Show 1
Case "Dvm1"
dmm% = 1: dev% = dmm1
frmDvm1Setup.Show 1
Case "Dvm2"
dmm% = 2: dev% = dmm2
frmDvm1Setup.Show 1
Case "Lock-in"
dev% = lckn
frmLockIn.Show 1
Case "Boxcar"
dev% = bxcr
 MsgBox "Setup device manually.", MB_OK + MB_EXCLAMATION, "Information"
End Select
End Sub

Private Sub Form_Activate()

If cmdGo.Enabled = True Then cmdGo.SetFocus
End Sub

Private Sub Form_Load()
CentreForm Me
' set up y source combo box

Ydevlist.AddItem "Dvm1"
Ydevlist.AddItem "Dvm2"
Ydevlist.AddItem "Lock-in"
Ydevlist.AddItem "Boxcar"
Ydevlist.AddItem "Digitiser"
Ydevlist.ListIndex = 0

' set up x source combo box

Xdevlist.AddItem "Dvm1"
Xdevlist.AddItem "Dvm2"
Xdevlist.AddItem "B-field sweep"
Xdevlist.AddItem "Voltage sweep"
Xdevlist.AddItem "time"
Xdevlist.ListIndex = 1

' set up DVM1/2 scaling combo boxes
cmbDVMx.AddItem "Volts (no scaling)"
cmbDVMx.AddItem "Pressure (Pa)"
cmbDVMx.AddItem "Temperature (K)"
cmbDVMx.AddItem "Magnetic field (T)"
cmbDVMx.ListIndex = 0

cmbDVMy.AddItem "Volts (no scaling)"
cmbDVMy.AddItem "Pressure (Pa)"
cmbDVMy.AddItem "Temperature (K)"
cmbDVMy.AddItem "Magnetic field (T)"
cmbDVMy.ListIndex = 0

txtTimeInterval.Text = "1"
optTimed.Value = True

x_ok = True: y_ok = True
End Sub

Private Sub ShowWarnMessage(x_ok, y_ok)
mess$ = ""
If x_ok = False Then mess$ = "Cannot proceed: X device is not connected."
If y_ok = False Then mess$ = "Cannot proceed: Y device is not connected."
If x_ok = False And y_ok = False Then mess$ = "Cannot proceed: both X and Y devices not connected."
frmSCAN!panelInfo.Caption = mess$
End Sub

Private Sub Spin1_SpinDown()
labPlusMinus.Caption = "-"
End Sub

Private Sub Spin1_SpinUp()
labPlusMinus.Caption = "+"
End Sub

Private Sub txtDeltaX_Change()
deltaX = Val(txtDeltaX.Text)
End Sub

Private Sub txtDeltaX_KeyPress(keyAscii As Integer)
If InStr(gNUMBERS, Chr$(keyAscii)) Then
    ' do nothing
ElseIf keyAscii = 8 Then
    ' do nothing
Else
    keyAscii = 0
End If
End Sub

Private Sub txtTimeInterval_Change()
inter& = 1000 * Val(txtTimeInterval.Text)
End Sub

Private Sub txtXbegin_KeyPress(keyAscii As Integer)
If InStr(gNUMBERS, Chr$(keyAscii)) Then
    ' do nothing
ElseIf keyAscii = 8 Then
    ' do nothing
Else
    keyAscii = 0
End If
End Sub

Private Sub txtXEnd_Change()
If InStr(gNUMBERS, Chr$(keyAscii)) Then
    ' do nothing
ElseIf keyAscii = 8 Then
    ' do nothing
Else
    keyAscii = 0
End If
End Sub

Private Sub Xdevlist_Click()

Select Case Xdevlist.ListIndex
Case 2, 3, 4
 OptDeltaX.Enabled = False
 optTimed.Value = True
 txtXbegin.Enabled = False: txtXEnd.Enabled = False
 txtDeltaX.Enabled = False
Case Else
 OptDeltaX.Enabled = True
 optTimed.Enabled = True
 txtXbegin.Enabled = True: txtXEnd.Enabled = True
 txtDeltaX.Enabled = True
 End Select

dev% = Xdevlist.ListIndex
If dev% = 4 Then dev% = -1
If dev% = 3 Then dev% = dvs
If dev% = -1 Then
 cmdXsetup.Enabled = True: x_ok = True
Else
 Pol% = Spoll(dev%)
  If Pol% = 0 Then
   x_ok = False: cmdGo.Enabled = False: cmdXsetup.Enabled = False
  Else
   x_ok = True: cmdXsetup.Enabled = True: If y_ok = True Then cmdGo.Enabled = True
  End If
End If

ShowWarnMessage x_ok, y_ok

If InStr(Xdevlist.Text, "Dvm") Then
 cmbDVMx.Enabled = True
Else
 cmbDVMx.Enabled = False
End If
End Sub

Private Sub Ydevlist_Click()
dev% = Ydevlist.ListIndex
If dev% = 3 Then
dev% = bxcr
End If
If dev% = 2 Then
dev% = lckn
End If
Pol% = Spoll(dev%)

If Pol% = 0 Then
 y_ok = False: cmdYsetup.Enabled = False: cmdGo.Enabled = False
Else
 y_ok = True: cmdYsetup.Enabled = True: If x_ok = True Then cmdGo.Enabled = True
End If

ShowWarnMessage x_ok, y_ok

If InStr(Ydevlist.Text, "Dvm") > 0 Then
cmbDVMy.Enabled = True
Else
 cmbDVMy.Enabled = False
End If
End Sub

