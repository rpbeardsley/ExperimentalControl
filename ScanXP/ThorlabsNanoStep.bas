Attribute VB_Name = "ThorlabsNanoStep"
Public ThorLabsStepper_Moving As Boolean

Public Sub Init()

  StepperControlForm.Show
  StepperControlForm.Hide

  ' Start system.
  StepperControlForm.MG17System1.StartCtrl

  ' Set serial number
  StepperControlForm.MG17Motor1.HWSerialNum = THORLABS_STEPPER_CONTROLLER_SERIALNUM
  
  ' Start motor control
  StepperControlForm.MG17Motor1.StartCtrl
  
  'Stop the event info box from ever popping up with stupid USB errors
  'and messing up your experiment
  ShowInfoDlgOnEventFlags = 0
  
  UpdateNanoStepPositionCounter
  UpdateNanoStepSpeed
    
  If NanoStep.CurrentPosition > 150 Or NanoStep.CurrentPosition < 0 Then
    MsgBox "Unable to obtain a sensible nanostepper position. Suggest homing track.", vbExclamation, "Warning"
  End If
  
End Sub

Public Sub UpdateNanoStepPositionCounter()

    NanoStep.CurrentPosition = StepperControlForm.MG17Motor1.GetPosition_Position(0)

End Sub

Public Sub GoToPosition(pos As Single)

    success = StepperControlForm.MG17Motor1.MoveAbsoluteEx(0, pos, 1, True)

End Sub

Public Sub MoveTrack(dist As Single)

    success = StepperControlForm.MG17Motor1.MoveRelativeEx(0, dist, 1, True)

End Sub

Public Sub MoveTrackWithCallback(dist As Single)

    success = StepperControlForm.MG17Motor1.MoveRelativeEx(0, dist, 1, False)
    ThorLabsStepper_Moving = True
    While ThorLabsStepper_Moving
    
        If NanoStep.CallBackRedirection = 1 Then
            PumpProbe.PPCheckTimer
        End If
    
    Wend
    
End Sub

Public Sub HomeTrack()

    StepperControlForm.MG17Motor1.MoveHome 0, True

End Sub

Public Sub UpdateNanoStepSpeed()

    NanoStep.CurrentSpeed = StepperControlForm.MG17Motor1.GetVelParams_MaxVel(0)

End Sub

Public Function GetSmallestNanoStep() As Double

Dim minpos As Single
Dim maxpos As Single
Dim screwPitchUnits As Long
Dim screwPitch As Single
Dim plDirSense As Long
Dim stepsPerRev As Long
Dim gearBoxRatio As Long

success = StepperControlForm.MG17Motor1.GetStageAxisInfo(0, minpos, maxpos, screwPitchUnits, screwPitch, plDirSense)
success = StepperControlForm.MG17Motor1.GetMotorParams(0, stepsPerRev, gearBoxRatio)
GetSmallestNanoStep = screwPitch / (stepsPerRev * gearBoxRatio)

End Function

