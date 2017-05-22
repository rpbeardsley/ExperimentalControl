VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.MDIForm MDIForm1 
   BackColor       =   &H8000000C&
   Caption         =   "Scan XP"
   ClientHeight    =   4830
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   6450
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin ComctlLib.ProgressBar ProgressBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   4455
      Width           =   6450
      _ExtentX        =   11377
      _ExtentY        =   661
      _Version        =   327682
      Appearance      =   1
   End
   Begin VB.Menu menu_view 
      Caption         =   "Experiments"
      Begin VB.Menu menu_view_basicpp 
         Caption         =   "Basic Pump-Probe"
      End
      Begin VB.Menu menu_view_sspp 
         Caption         =   "Step-by-Step Pump-Probe"
      End
      Begin VB.Menu menu_view_boltrans 
         Caption         =   "Bolometer Transition"
      End
      Begin VB.Menu menu_view_calibration 
         Caption         =   "Thermometer Calibration"
      End
      Begin VB.Menu menu_view_image 
         Caption         =   "Phonon Image"
      End
      Begin VB.Menu menu_view_linescan 
         Caption         =   "Linescan"
      End
      Begin VB.Menu menu_experiments_IVSweep 
         Caption         =   "IV Sweep"
      End
   End
   Begin VB.Menu menu_instruments 
      Caption         =   "Instruments"
      Begin VB.Menu menu_view_dvs 
         Caption         =   "DVS"
      End
      Begin VB.Menu menu_view_digitiser 
         Caption         =   "Digitiser"
      End
      Begin VB.Menu menu_view_eclipse 
         Caption         =   "Eclipse"
      End
      Begin VB.Menu menu_view_nanostep 
         Caption         =   "NanoStepper"
      End
      Begin VB.Menu menu_view_gpib 
         Caption         =   "GPIB"
      End
      Begin VB.Menu menu_instruments_RS232 
         Caption         =   "RS232"
      End
      Begin VB.Menu menu_instruments_tempcontrol 
         Caption         =   "Temperature Control"
      End
      Begin VB.Menu menu_instruments_regulatetemp 
         Caption         =   "Regulate Temperature"
      End
      Begin VB.Menu menu_instruments_lockin 
         Caption         =   "Lockin"
      End
      Begin VB.Menu menu_instruments_mirrors 
         Caption         =   "Mirrors"
      End
      Begin VB.Menu menu_instruments_bias 
         Caption         =   "Bias Switch"
      End
      Begin VB.Menu menu_instruments_DVM 
         Caption         =   "DVM 34401A"
      End
   End
   Begin VB.Menu menu_analysis 
      Caption         =   "Analysis"
      Begin VB.Menu menu_traceanalysis 
         Caption         =   "Trace Analysis"
      End
      Begin VB.Menu menu_view_tracegraph 
         Caption         =   "View Trace Graph"
      End
      Begin VB.Menu menu_view_pointgraph 
         Caption         =   "View Point Graph"
      End
      Begin VB.Menu vis 
         Caption         =   "MG17"
      End
   End
End
Attribute VB_Name = "MDIForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub MDIForm_Terminate()
    Globals.Cleanup
    End
End Sub

Private Sub menu_experiments_IVSweep_Click()
IVSweepForm.Show
End Sub

Private Sub menu_instruments_bias_Click()
BiasForm.Show
End Sub

Private Sub menu_instruments_DVM_Click()
    DVM.Show
End Sub

Private Sub menu_instruments_lockin_Click()
    LockinForm.Show
End Sub

Private Sub menu_instruments_mirrors_Click()
MirrorForm.Show
End Sub

Private Sub menu_instruments_regulatetemp_Click()
    PIDTempControl.Show
End Sub

Private Sub menu_instruments_RS232_Click()
    RS232.Show
End Sub

Private Sub menu_instruments_tempcontrol_Click()
    TempControl.Show
End Sub

Private Sub menu_traceanalysis_Click()
    TraceAnalysis.Show
End Sub

Private Sub menu_view_basicpp_Click()
    PumpProbe.Show
End Sub

Private Sub menu_view_boltrans_Click()
    TransitionForm.Show
End Sub

Private Sub menu_view_digitiser_Click()
    DigitiserForm.Show
End Sub

Private Sub menu_view_dvs_Click()
    DVSForm.Show
End Sub

Private Sub menu_view_eclipse_Click()
    EclipseFrm.Show
End Sub

Private Sub menu_view_gpib_Click()
    Form1.Show
End Sub

Private Sub menu_view_image_Click()
    ImageForm.Show
End Sub

Private Sub menu_view_linescan_Click()
    LinescanForm.Show
End Sub

Private Sub menu_view_nanostep_Click()
    StepperControlForm.Show
End Sub

Private Sub menu_view_pointgraph_Click()
    GraphForm.Show
End Sub

Private Sub menu_view_sspp_Click()
    PumpProbeAccurate.Show
End Sub

Private Sub menu_view_tracegraph_Click()
    TraceForm.Show
End Sub

Private Sub menu_view_calibration_Click()
    Calibration.Show
End Sub

Private Sub vis_Click()

    If StepperControlForm.MG17Motor1.Visible = False Then
        StepperControlForm.MG17Motor1.Visible = True
    Else
        StepperControlForm.MG17Motor1.Visible = False
    End If

End Sub
