VERSION 5.00
Begin VB.Form frmImageColoursSetup 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Image display setup"
   ClientHeight    =   6675
   ClientLeft      =   2940
   ClientTop       =   2340
   ClientWidth     =   6990
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
   HelpContextID   =   280
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6675
   ScaleWidth      =   6990
   Begin VB.CommandButton cmdUpdate 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Update"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   5160
      TabIndex        =   48
      Top             =   6240
      Width           =   1275
   End
   Begin VB.HScrollBar HScroll3 
      Height          =   240
      Left            =   1830
      TabIndex        =   43
      Top             =   3900
      Width           =   1425
   End
   Begin VB.HScrollBar HScroll2 
      Height          =   240
      Left            =   1830
      TabIndex        =   42
      Top             =   6030
      Width           =   1425
   End
   Begin VB.HScrollBar HScroll1 
      Height          =   240
      Left            =   1830
      TabIndex        =   41
      Top             =   1800
      Width           =   1425
   End
   Begin VB.CheckBox chk3colour 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Use 3 base colours"
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
      Height          =   315
      Left            =   1890
      TabIndex        =   40
      Top             =   2310
      Width           =   2175
   End
   Begin VB.PictureBox picMedColour 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1425
      Left            =   3510
      ScaleHeight     =   1395
      ScaleWidth      =   1455
      TabIndex        =   35
      Top             =   2700
      Width           =   1485
   End
   Begin VB.TextBox txtMedBlue 
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
      Left            =   2640
      TabIndex        =   34
      Text            =   "Text3"
      Top             =   3510
      Width           =   615
   End
   Begin VB.TextBox txtMedGreen 
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
      Left            =   2640
      TabIndex        =   33
      Text            =   "Text2"
      Top             =   3120
      Width           =   615
   End
   Begin VB.TextBox txtMedRed 
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
      Left            =   2640
      TabIndex        =   32
      Text            =   "Text1"
      Top             =   2730
      Width           =   615
   End
   Begin VB.HScrollBar hsMedBlue 
      Height          =   255
      Left            =   720
      TabIndex        =   31
      Top             =   3540
      Width           =   1815
   End
   Begin VB.HScrollBar hsMedGreen 
      Height          =   255
      Left            =   720
      TabIndex        =   30
      Top             =   3150
      Width           =   1815
   End
   Begin VB.HScrollBar hsMedRed 
      Height          =   255
      Left            =   720
      TabIndex        =   29
      Top             =   2760
      Width           =   1815
   End
   Begin VB.PictureBox picKey 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   3465
      Left            =   5370
      ScaleHeight     =   150.838
      ScaleMode       =   0  'User
      ScaleWidth      =   645
      TabIndex        =   25
      Top             =   2640
      Width           =   675
   End
   Begin VB.TextBox txtMinBlue 
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
      Left            =   2640
      TabIndex        =   24
      Text            =   "Text1"
      Top             =   5640
      Width           =   615
   End
   Begin VB.TextBox txtMinGreen 
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
      Left            =   2640
      TabIndex        =   23
      Text            =   "Text1"
      Top             =   5250
      Width           =   615
   End
   Begin VB.TextBox txtMinRed 
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
      Left            =   2640
      TabIndex        =   22
      Text            =   "Text1"
      Top             =   4860
      Width           =   615
   End
   Begin VB.TextBox txtMaxBlue 
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
      Left            =   2640
      TabIndex        =   21
      Text            =   "Text1"
      Top             =   1410
      Width           =   615
   End
   Begin VB.TextBox txtMaxGreen 
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
      Left            =   2640
      TabIndex        =   20
      Text            =   "Text1"
      Top             =   1020
      Width           =   615
   End
   Begin VB.TextBox txtMaxRed 
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
      Left            =   2640
      TabIndex        =   19
      Text            =   "Text1"
      Top             =   630
      Width           =   615
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
      Height          =   495
      Left            =   5430
      TabIndex        =   18
      Top             =   1230
      Width           =   1365
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
      Height          =   495
      Left            =   5400
      TabIndex        =   17
      Top             =   510
      Width           =   1365
   End
   Begin VB.PictureBox picMinColour 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1425
      Left            =   3510
      ScaleHeight     =   1395
      ScaleWidth      =   1455
      TabIndex        =   16
      Top             =   4800
      Width           =   1485
   End
   Begin VB.HScrollBar hsMinBlue 
      Height          =   255
      Left            =   720
      TabIndex        =   15
      Top             =   5670
      Width           =   1815
   End
   Begin VB.HScrollBar hsMinGreen 
      Height          =   255
      Left            =   720
      TabIndex        =   14
      Top             =   5280
      Width           =   1815
   End
   Begin VB.HScrollBar hsMinRed 
      Height          =   255
      Left            =   720
      TabIndex        =   13
      Top             =   4860
      Width           =   1815
   End
   Begin VB.PictureBox picMaxColour 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      FillColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      ForeColor       =   &H00FFFFFF&
      Height          =   1425
      Left            =   3480
      ScaleHeight     =   1395
      ScaleWidth      =   1455
      TabIndex        =   7
      Top             =   600
      Width           =   1485
   End
   Begin VB.HScrollBar hsMaxBlue 
      Height          =   255
      Left            =   720
      TabIndex        =   6
      Top             =   1440
      Width           =   1815
   End
   Begin VB.HScrollBar hsMaxGreen 
      Height          =   255
      Left            =   720
      TabIndex        =   5
      Top             =   1050
      Width           =   1815
   End
   Begin VB.HScrollBar hsMaxRed 
      Height          =   255
      Left            =   720
      TabIndex        =   4
      Top             =   660
      Width           =   1815
   End
   Begin VB.Label Label17 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Scale:"
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
      Left            =   5400
      TabIndex        =   44
      Top             =   2280
      Width           =   525
   End
   Begin VB.Label Label20 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Relative intensity:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   360
      TabIndex        =   47
      Top             =   6030
      Width           =   1455
   End
   Begin VB.Label Label19 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Relative intensity:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   360
      TabIndex        =   46
      Top             =   3900
      Width           =   1455
   End
   Begin VB.Label Label18 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Relative intensity:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   360
      TabIndex        =   45
      Top             =   1800
      Width           =   1455
   End
   Begin VB.Label Label16 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "B"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   39
      Top             =   3540
      Width           =   255
   End
   Begin VB.Label Label15 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "G"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   38
      Top             =   3150
      Width           =   255
   End
   Begin VB.Label Label14 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   37
      Top             =   2760
      Width           =   255
   End
   Begin VB.Label Label13 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Mid colour:"
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
      TabIndex        =   36
      Top             =   2340
      Width           =   1095
   End
   Begin VB.Label Label12 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "50%"
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
      Height          =   195
      Left            =   6120
      TabIndex        =   26
      Top             =   4290
      Width           =   375
   End
   Begin VB.Label Label11 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "MIN"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   6090
      TabIndex        =   27
      Top             =   5970
      Width           =   405
   End
   Begin VB.Label Label10 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "MAX"
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
      Height          =   195
      Left            =   6090
      TabIndex        =   28
      Top             =   2610
      Width           =   405
   End
   Begin VB.Label Label9 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "B"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   12
      Top             =   5670
      Width           =   255
   End
   Begin VB.Label Label8 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "G"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   11
      Top             =   5280
      Width           =   255
   End
   Begin VB.Label Label7 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   10
      Top             =   4860
      Width           =   255
   End
   Begin VB.Label Label6 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Min colour:"
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
      Left            =   330
      TabIndex        =   9
      Top             =   4410
      Width           =   1095
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Sample:"
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
      Left            =   3480
      TabIndex        =   8
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "B"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   1440
      Width           =   255
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "G"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   1050
      Width           =   255
   End
   Begin VB.Label Label2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   660
      Width           =   255
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Max colour:"
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
      TabIndex        =   0
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "frmImageColoursSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub chk3colour_Click()

If chk3colour.Value = 1 Then

 hsMedRed.Enabled = True

 hsMedGreen.Enabled = True

 hsMedBlue.Enabled = True

 txtMEDRED.Enabled = True

 txtMEDGREEN.Enabled = True

 txtMEDBLUE.Enabled = True

Else

 hsMedRed.Enabled = False

 hsMedGreen.Enabled = False

 hsMedBlue.Enabled = False

 txtMEDRED.Enabled = False

 txtMEDGREEN.Enabled = False

 txtMEDBLUE.Enabled = False

End If

UpdateKey

End Sub



Private Sub cmdCancel_Click()

Unload frmImageColoursSetup

End Sub



Private Sub cmdOK_Click()



' update global variables



gCOL_MAXRED = Val(txtMAXRED.Text)

gCOL_MAXGREEN = Val(txtMAXGREEN.Text)

gCOL_MAXBLUE = Val(txtMAXBLUE.Text)

gCOL_MINRED = Val(txtMINRED.Text)

gCOL_MINGREEN = Val(txtMINGREEN.Text)

gCOL_MINBLUE = Val(txtMINBLUE.Text)

gCOL_MEDRED = Val(txtMEDRED.Text)

gCOL_MEDGREEN = Val(txtMEDGREEN.Text)

gCOL_MEDBLUE = Val(txtMEDBLUE.Text)

gNUM_BASECOLS = chk3colour.Value + 2



MakeColourArray

Unload frmImageColoursSetup

End Sub



Private Sub cmdUpdate_Click()

UpdateKey

End Sub



Private Sub Form_Activate()

If gCOLOURS <= 256 Then

picKey.Picture = LoadPicture("c:\tmp\palette.bmp")

End If

UpdateKey

If gCOLOURS <= 256 Then cmdUpdate.Enabled = True

End Sub



Private Sub Form_Load()

CentreForm Me



picKey.ScaleHeight = 256

picKey.ScaleWidth = 5

picKey.DrawWidth = 1



hsMaxRed.max = 255

hsMaxRed.min = 0

hsMaxGreen.max = 255

hsMaxGreen.min = 0

hsMaxBlue.max = 255

hsMaxBlue.min = 0



hsMinRed.max = 255

hsMinRed.min = 0

hsMinGreen.max = 255

hsMinGreen.min = 0

hsMinBlue.max = 255

hsMinBlue.min = 0



hsMedRed.max = 255

hsMedRed.min = 0

hsMedGreen.max = 255

hsMedGreen.min = 0

hsMedBlue.max = 255

hsMedBlue.min = 0



hsMaxRed.LargeChange = 15

hsMaxRed.SmallChange = 1

hsMaxGreen.LargeChange = 15

hsMaxGreen.SmallChange = 1

hsMaxBlue.LargeChange = 15

hsMaxBlue.SmallChange = 1



hsMinRed.LargeChange = 15

hsMinRed.SmallChange = 1

hsMinGreen.LargeChange = 15

hsMinGreen.SmallChange = 1

hsMinBlue.LargeChange = 15

hsMinBlue.SmallChange = 1



hsMedRed.LargeChange = 15

hsMedRed.SmallChange = 1

hsMedGreen.LargeChange = 15

hsMedGreen.SmallChange = 1

hsMedBlue.LargeChange = 15

hsMedBlue.SmallChange = 1



hsMaxRed.Value = gCOL_MAXRED

hsMaxGreen.Value = gCOL_MAXGREEN

hsMaxBlue.Value = gCOL_MAXBLUE

hsMinRed.Value = gCOL_MINRED

hsMinGreen.Value = gCOL_MINGREEN

hsMinBlue.Value = gCOL_MINBLUE

hsMedRed.Value = gCOL_MEDRED

hsMedGreen.Value = gCOL_MEDGREEN

hsMedBlue.Value = gCOL_MEDBLUE

chk3colour.Value = gNUM_BASECOLS - 2



txtMAXRED.Text = Str$(hsMaxRed.Value)

txtMAXGREEN.Text = Str$(hsMaxGreen.Value)

txtMAXBLUE.Text = Str$(hsMaxBlue.Value)

txtMINRED.Text = Str$(hsMinRed.Value)

txtMINGREEN.Text = Str$(hsMinGreen.Value)

txtMINBLUE.Text = Str$(hsMinBlue.Value)

txtMEDRED.Text = Str$(hsMedRed.Value)

txtMEDGREEN.Text = Str$(hsMedGreen.Value)

txtMEDBLUE.Text = Str$(hsMedBlue.Value)



colr = RGB(hsMaxRed.Value, hsMaxGreen.Value, hsMaxBlue.Value)

picMaxColour.BackColor = colr

colr = RGB(hsMinRed.Value, hsMinGreen.Value, hsMinBlue.Value)

picMinColour.BackColor = colr

colr = RGB(hsMedRed.Value, hsMedGreen.Value, hsMedBlue.Value)

picMedColour.BackColor = colr



chk3colour_Click



End Sub



Private Sub hsMaxBlue_Change()

Dim colour As Long

txtMAXBLUE.Text = Str$(hsMaxBlue.Value)

colour = RGB(Val(txtMAXRED.Text), Val(txtMAXGREEN.Text), Val(txtMAXBLUE.Text))

picMaxColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMaxGreen_Change()

Dim colour As Long

txtMAXGREEN.Text = Str$(hsMaxGreen.Value)

colour = RGB(Val(txtMAXRED.Text), Val(txtMAXGREEN.Text), Val(txtMAXBLUE.Text))

picMaxColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMaxRed_Change()

Dim colour As Long

txtMAXRED.Text = Str$(hsMaxRed.Value)

colour = RGB(Val(txtMAXRED.Text), Val(txtMAXGREEN.Text), Val(txtMAXBLUE.Text))

picMaxColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMedBlue_Change()

Dim colour As Long

txtMEDBLUE.Text = Str$(hsMedBlue.Value)

colour = RGB(Val(txtMEDRED.Text), Val(txtMEDGREEN.Text), Val(txtMEDBLUE.Text))

picMedColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMedGreen_Change()

Dim colour As Long

txtMEDGREEN.Text = Str$(hsMedGreen.Value)

colour = RGB(Val(txtMEDRED.Text), Val(txtMEDGREEN.Text), Val(txtMEDBLUE.Text))

picMedColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey



End Sub



Private Sub hsMedRed_Change()

Dim colour As Long

txtMEDRED.Text = Str$(hsMedRed.Value)

colour = RGB(Val(txtMEDRED.Text), Val(txtMEDGREEN.Text), Val(txtMEDBLUE.Text))

picMedColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMinBlue_Change()

Dim colour As Long

txtMINBLUE.Text = Str$(hsMinBlue.Value)

colour = RGB(Val(txtMINRED.Text), Val(txtMINGREEN.Text), Val(txtMINBLUE.Text))

picMinColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMinGreen_Change()

Dim colour As Long

txtMINGREEN.Text = Str$(hsMinGreen.Value)

colour = RGB(Val(txtMINRED.Text), Val(txtMINGREEN.Text), Val(txtMINBLUE.Text))

picMinColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub hsMinRed_Change()

Dim colour As Long

txtMINRED.Text = Str$(hsMinRed.Value)

colour = RGB(Val(txtMINRED.Text), Val(txtMINGREEN.Text), Val(txtMINBLUE.Text))

picMinColour.BackColor = colour

If gCOLOURS > 256 Then UpdateKey

End Sub



Private Sub UpdateKey()



For i% = 0 To 100 Step 2

picKey.ForeColor = G_BLACK

picKey.FillStyle = 0



' define the multipliers to base colours

' to form the image colour for intensity of i%

If chk3colour.Value = 1 Then

' 3 base colour case

max = (i% > 50) * (50 - i%) * 2

min = (i% < 50) * (i% - 50) * 2

med = (50 - Abs(i% - 50)) * 2



Else

' if only using 2 base colours

max = i%: min = 100 - i%: med = 0

End If



r = Int((hsMaxRed.Value * max + hsMinRed.Value * min + hsMedRed.Value * med) / 100)

G = Int((hsMaxGreen.Value * max + hsMinGreen.Value * min + hsMedGreen.Value * med) / 100)

B = Int((hsMaxBlue.Value * max + hsMinBlue.Value * min + hsMedBlue.Value * med) / 100)



picKey.ForeColor = RGB(r, G, B)

picKey.Line (0, 101 - i%)-(5, 99 - i%), , BF

Next



End Sub



