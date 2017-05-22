Attribute VB_Name = "MGNanoStep"
Public DriveFirst As Boolean
Public NanoStepNames(10) As String
Public PiezoNames(10) As String
Public NanoTrakNames(10) As String
Public VelocityProfiles(10, 2) As Double

Public Sub Init(cfg As String)

   Dim ErrorCode As Long
   Dim Index As Long
   
   pth = App.Path
   If Right(pth, 1) <> "\" Then pth = pth + "\"
   
   CONFIGURATION_FILE = pth + "MG17_CFG.INI"
   STAGES_FILE = pth + "MG17_STAGES.INI"

   If cfg = "" Then cfg = "NS_1000"
   
   For Index = 0 To UBound(PiezoNames)
      NanoStepNames(Index) = String(255, 0)
      PiezoNames(Index) = String(255, 0)
      NanoTrakNames(Index) = String(255, 0)
   Next Index
   
      ErrorCode = SetupAConfiguration(cfg, True, _
                                NanoStepNames, _
                                PiezoNames, _
                                NanoTrakNames)
                                
    UpdateNanoStepPositionCounter
    UpdateNanoStepSpeed
    
    If NanoStep.CurrentPosition > 150 Or NanoStep.CurrentPosition < 0 Then
        MsgBox "Unable to obtain a sensible nanostepper position. Suggest homing track.", vbExclamation, "Warning"
    End If
    
End Sub

Public Sub UpdateNanoStepPositionCounter()

    Dim CurrentPositions(10) As Double

    ErrorCode = SingleGetPosition(NanoStepNames(0), CurrentPositions(0))
    NanoStep.CurrentPosition = CurrentPositions(0)

End Sub

Public Sub GoToPosition(pos)

   Dim ErrorCode As Long
   Dim Index As Long
   
   Dim Distances(10) As Double
   Dim CurrentPositions(10) As Double
   Dim BacklashesDisabled(10) As Boolean
   
   For Index = 0 To 10
      Distances(Index) = pos
   Next Index
      ErrorCode = SingleMoveAbsoluteAndWait(NanoStepNames(0), Distances(0), BacklashesDisabled(0))
      ErrorCode = SingleGetPosition(NanoStepNames(0), CurrentPositions(0))

    NanoStep.CurrentPosition = CurrentPositions(0)



End Sub

Public Sub MoveTrack(dist)

   Dim ErrorCode As Long
   Dim Index As Long
   
   Dim Distances(10) As Double
   Dim CurrentPositions(10) As Double
   Dim BacklashesDisabled(10) As Boolean
   
   For Index = 0 To 10
      Distances(Index) = dist
   Next Index
      ErrorCode = SingleMoveRelativeAndWait(NanoStepNames(0), Distances(0), BacklashesDisabled(0))
      ErrorCode = SingleGetPosition(NanoStepNames(0), CurrentPositions(0))

    NanoStep.CurrentPosition = CurrentPositions(0)

End Sub

Public Sub MoveTrackWithCallback(dist)

   Dim ErrorCode As Long
   Dim Index As Long
   
   Dim Distances(10) As Double
   Dim CurrentPositions(10) As Double
   Dim BacklashesDisabled(10) As Boolean
   
   For Index = 0 To 10
      Distances(Index) = dist
   Next Index
      ErrorCode = SingleMoveRelativeAndWaitWithCallback(NanoStepNames(0), Distances(0), BacklashesDisabled(0))
      ErrorCode = SingleGetPosition(NanoStepNames(0), CurrentPositions(0))

    NanoStep.CurrentPosition = CurrentPositions(0)

End Sub

Public Sub HomeTrack()

    Dim ErrorCode As Long
    ErrorCode = Home(NanoStepNames)
    NanoStep.CurrentPosition = 0

End Sub

Public Sub NanoStepperCallback()

    'Called repeatedly one Nanostepper is set into
    'motion with NSDriver.MoveRelativeAndWaitWithCallback
    
    'Do not use Doevents calls inside this function or
    'any others called by it.
    
    'The call of this function is invoked in NSUtils.CheckPositionsWithCallback

    If NanoStep.CallBackRedirection = 1 Then
        PumpProbe.PPCheckTimer
    End If

End Sub

Public Sub UpdateNanoStepSpeed()

Dim VelocityProfiles(0 To 2) As Double

SingleGetVelocityProfile NanoStepNames(0), VelocityProfiles
NanoStep.CurrentSpeed = VelocityProfiles(2)

End Sub

Public Function GetSmallestNanoStep() As Double

ErrorCode = GetNanoStepStepsToMotorUnitsRatio(NanoStepNames(0), StepsToUnitsRatio)
GetSmallestNanoStep = 1 / StepsToUnitsRatio

End Function

