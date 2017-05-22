VERSION 5.00
Begin VB.Form frmGenConfig 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "General Configuration"
   ClientHeight    =   3435
   ClientLeft      =   3690
   ClientTop       =   2070
   ClientWidth     =   6975
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3435
   ScaleWidth      =   6975
   Begin VB.CommandButton cmdEPbrowse 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Change"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4590
      TabIndex        =   2
      Top             =   270
      Width           =   885
   End
   Begin VB.CommandButton cmdCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Cancel          =   -1  'True
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
      Height          =   315
      Left            =   3300
      TabIndex        =   1
      Top             =   2940
      Width           =   975
   End
   Begin VB.CommandButton cmdOK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "OK"
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
      Left            =   2010
      TabIndex        =   0
      Top             =   2940
      Width           =   975
   End
   Begin VB.Label labEPloc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "c:\epw\epw.exe"
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
      Left            =   2370
      TabIndex        =   4
      Top             =   270
      Width           =   2175
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Pathname of Easyplot program:"
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
      Height          =   225
      Left            =   120
      TabIndex        =   3
      Top             =   300
      Width           =   2295
   End
End
Attribute VB_Name = "frmGenConfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdCancel_Click()
Unload frmGenConfig
End Sub

Private Sub cmdEPbrowse_Click()
gDATA_TYPE = BROWSE
frmFileIO!cmdOK.Visible = True
frmFileIO!lstFileExt.List(0) = "EXE files (*.exe)"
frmFileIO!lstFileExt.List(1) = "COM files (*.com)"
frmFileIO!lstFileExt.List(2) = "All files (*.*)"
frmFileIO!lstFileExt.ListIndex = 0
frmFileIO.Show 1
If gQUIT = 0 Then labEPloc.Caption = Path + "/" + file
End Sub

Private Sub cmdOK_Click()
gEPloc = labEPloc.Caption
frmGenConfig.Hide
End Sub

