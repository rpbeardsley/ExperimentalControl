Attribute VB_Name = "NSDriver"
Option Base 0
Declare Function GetNanoStepHandle Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Handle As Long) As Long
Declare Function MoveNanoStepRelativeDistance Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Dir As Long, ByVal Distance As Double) As Long
Declare Function FindNanoStepHomePosition Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal LimitSwitch As Long) As Long
Declare Function GetNanoStepPosition Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Position As Double) As Long
Declare Function StartNanoStepRelativeDistance Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Dir As Long, ByVal Distance As Double) As Long
Declare Function StartNanoStepFindLmitSwitch Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal LimitSwitch As Long) As Long
Declare Function GetNanoStepZeroOffset Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Offset As Double) As Long
Declare Function GetNanoStepBacklashDistance Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Distance As Double) As Long
Declare Function SetNanoStepInitialVelocity Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal InitialVelocity As Double) As Long
Declare Function SetNanoStepAcceleration Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Acceleration As Double) As Long
Declare Function SetNanoStepFinalVelocity Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal FinalVelocity As Double) As Long
Declare Function CheckNanoStepWhenAtPosition Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long, ByRef AtPositionStatus As Long) As Long
Declare Function SetNanoStepChangeRate Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long, ByVal RateChange As Long) As Long
Public Function AtPosition(ByRef Names() As String, ByRef TravelTimes() As Double) As Long
   
   Dim ErrorCode As Long
   Dim DummyError As Long
   Dim ErrorRoutineSource As String
   Dim ErrorDriverSource As String
   Dim NameCount As Long
   Dim MaximumTravelTime As Double
   Dim StartTime As Single
   Dim TimeNow As Single
   Dim Timed As Single
   Dim Index As Long
   Dim Index2 As Long
   Dim Handle As Long
   Dim AtPositionStatus As Long
   Dim TimeoutError As Boolean
   
   ErrorDriverSource = "AtPosition"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   MaximumTravelTime = 0
   For Index = 0 To (NameCount - 1)
      If TravelTimes(Index) > MaximumTravelTime Then
         MaximumTravelTime = TravelTimes(Index)
      End If
   Next Index
   
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      If ErrorCode <> 0 Then
         AtPosition = ErrorCode
         ErrorRoutineSource = "GetNanoStepHandle"
         Err.Raise ErrorCode
      End If
      ErrorCode = RequestNanoStepWhenAtPosition(Handle)
      If ErrorCode <> 0 Then
               AtPosition = ErrorCode
               ErrorRoutineSource = "RequestNanoStepWhenAtPosition"
               Err.Raise ErrorCode
      End If
   Next Index
   
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      If ErrorCode <> 0 Then
         AtPosition = ErrorCode
         ErrorRoutineSource = "GetNanoStepHandle"
         Err.Raise ErrorCode
      End If
      StartTime = Timer
      TimeoutError = False
      AtPositionStatus = CONTROLLER_NOT_AT_POSITION
      While (AtPositionStatus <> CONTROLLER_AT_POSITION _
             And Not TimeoutError)
            ErrorCode = CheckNanoStepWhenAtPosition(Handle, _
                                 AtPositionStatus)
            If ErrorCode <> 0 Then
               AtPosition = ErrorCode
               ErrorRoutineSource = "CheckNanoStepWhenAtPosition"
               Err.Raise ErrorCode
            End If
            TimeNow = (Timer - StartTime)
            TimeoutError = TimeNow > MaximumTravelTime
      Wend
      If TimeoutError = True Then
         ErrorCode = AT_POSITION_TIMEOUT
         AtPosition = ErrorCode
         Err.Raise ErrorCode
      End If
      ErrorCode = ClearNanoStepActiveLed(Handle)
      If ErrorCode <> 0 Then
         AtPosition = ErrorCode
         ErrorRoutineSource = "ClearNanoStepActiveLed"
         Err.Raise ErrorCode
      End If
      ErrorCode = SetNanoStepUnitPower(Handle, POWER_DOWN)
      Index2 = 0
      While Index2 < 10000
        Index2 = Index2 + 1
      Wend
      If ErrorCode <> 0 Then
         AtPosition = ErrorCode
         ErrorRoutineSource = "SetNanoStepUnitPower"
         Err.Raise ErrorCode
      End If
      AtPosition = ErrorCode
   Next Index
   AtPosition = ErrorCode
   Exit Function

MGErrorHandler:
   DummyError = ClearNanoStepActiveLed(Handle)
   DummyError = SetNanoStepUnitPower(Handle, POWER_DOWN)
   Index2 = 0
   While Index2 < 10000
      Index2 = Index2 + 1
   Wend
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function GetPosition(ByRef Names() As String, ByRef Positions() As Double) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim NameCount As Long
   Dim Index As Integer
   
   ErrorDriverSource = "GetPosition"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepPosition(Names(Index), Positions(Index))
      If ErrorCode <> 0 Then
         GetPosition = ErrorCode
         ErrorRoutineSource = "GetNanoStepPosition"
         Err.Raise ErrorCode
      End If
   Next Index
   GetPosition = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function GetVelocityProfiles(ByRef Names() As String, ByRef VelocityProfiles() As Double) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim NameCount As Long
   Dim Index As Integer
   
   ErrorDriverSource = "GetVelocityProfiles"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepInitialVelocity(Names(Index), VelocityProfiles(Index, 0))
      If ErrorCode <> 0 Then
         GetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "GetNanoStepInitialVelocity"
         Err.Raise ErrorCode
      End If
      ErrorCode = GetNanoStepAcceleration(Names(Index), VelocityProfiles(Index, 1))
      If ErrorCode <> 0 Then
         GetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "GetNanoStepAcceleration"
         Err.Raise ErrorCode
      End If
      ErrorCode = GetNanoStepFinalVelocity(Names(Index), VelocityProfiles(Index, 2))
      If ErrorCode <> 0 Then
         GetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "GetNanoStepFinalVelocity"
         Err.Raise ErrorCode
     End If
      If ErrorCode <> 0 Then
         GetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "GetNanoStepFinalVelocity"
         Err.Raise ErrorCode
      End If
   Next Index
   GetVelocityProfiles = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function Halt(ByRef Names() As String, ByVal Immediate As Boolean) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim RateChange As Long
   Dim Handle As Long
   Dim NameCount As Long
   Dim Index As Integer
   
   ErrorDriverSource = "Halt"
   On Error GoTo MGErrorHandler
   If Immediate = True Then
      RateChange = 0
   Else
      RateChange = 1
   End If
   
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      If ErrorCode <> 0 Then
         Halt = ErrorCode
         ErrorRoutineSource = "GetNanoStepHandle"
         Err.Raise ErrorCode
      End If
      ErrorCode = SetNanoStepChangeRate(Handle, RateChange)
      If ErrorCode <> 0 Then
         Halt = ErrorCode
         ErrorRoutineSource = "SetNanoStepChangeRate"
         Err.Raise ErrorCode
      End If
   Next Index
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function Home(ByRef Names() As String) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim Index As Long
   Dim ZeroPosition As Double
   Dim ZeroOffset As Double
   Dim MinimumPosition As Double
   Dim DistancesToHome() As Double
   Dim NameCount As Long
   Dim TravelTimes() As Double
   Dim LimitSwitches() As Long
   
   ErrorDriverSource = "Home"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   If NameCount = 0 Then
      ErrorCode = NO_NANOSTEPS
      ErrorRoutineSource = "StringArraySize"
      Error.Raise ErrorCode
   End If
   ReDim TravelTimes(NameCount - 1)
   ReDim LimitSwitches(NameCount - 1)
   For Index = 0 To (NameCount - 1)
      LimitSwitches(Index) = NEGATIVE_LIMIT
   Next Index
   ErrorCode = MoveToLimitAndContinue(Names, LimitSwitches, _
                                      TravelTimes)
   If ErrorCode <> 0 Then
      Home = ErrorCode
      ErrorRoutineSource = "MoveToLimitAndContinue"
      Err.Raise ErrorCode
   End If
   ErrorCode = AtPosition(Names, TravelTimes)
   If ErrorCode <> 0 Then
      Home = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   ErrorCode = GetDistanceToHome(Names, DistancesToHome)
   If ErrorCode <> 0 Then
      Home = ErrorCode
      ErrorRoutineSource = "GetDistanceToHome"
      Err.Raise ErrorCode
   End If
   ErrorCode = MoveRelativeUncalibAndContinue(Names, _
                                              DistancesToHome, _
                                              TravelTimes)
   If ErrorCode <> 0 Then
      Home = ErrorCode
      ErrorRoutineSource = "MoveRelativeUncalibAndContinue"
      Err.Raise ErrorCode
   End If
   ErrorCode = AtPosition(Names, TravelTimes)
   If ErrorCode <> 0 Then
      Home = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   ErrorCode = SetZero(Names)
   If ErrorCode <> 0 Then
      Home = ErrorCode
      ErrorRoutineSource = "SetZero"
      Err.Raise ErrorCode
   End If
   ErrorCode = GetNanoStepPosition(Names(0), ZeroPosition)
   ErrorCode = GetNanoStepPosition(Names(1), ZeroPosition)
   Home = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function MoveAbsoluteAndContinue(ByRef Names() As String, _
                                        ByRef Positions() As Double, _
                                        ByRef TravelTimes() As Double) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim NameCount As Long
   Dim Index As Integer
   Dim VelocityProfile(3) As Double
   Dim CurrentPosition As Double
   Dim Travel As Double
   
   ErrorDriverSource = "MoveAbsoluteAndContinue"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepPosition(Names(Index), CurrentPosition)
      If ErrorCode <> 0 Then
         MoveAbsoluteAndContinue = ErrorCode
         ErrorRoutineSource = "GetNanoStepPosition"
         Err.Raise ErrorCode
      End If
      Travel = Abs(Positions(Index) - CurrentPosition)
      ErrorCode = SingleMoveAbsoluteAndContinue(Names(Index), _
                                                Positions(Index), _
                                                TravelTimes(Index))
      If ErrorCode <> 0 Then
         MoveAbsoluteAndContinue = ErrorCode
         ErrorRoutineSource = "SingleMoveAbsoluteAndContinue"
         Err.Raise ErrorCode
      End If
   Next Index
   MoveAbsoluteAndContinue = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function MoveAbsoluteAndWait(ByRef Names() As String, _
                                    ByRef TargetPositions() As Double, _
                                    ByRef BacklashesDisabled() As Boolean) As Long
   
   
   Dim ErrorCode As Long
   Dim Handle As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim Index As Integer
   Dim CurrentPositions() As Double
   Dim BacklashDistances() As Double
   Dim NameCount As Long
   Dim StepsToUnitsRatio As Long
   Dim Movements() As Double
   Dim TravelTime As Long
   Dim TravelTimes() As Double
   Dim DidItMoveMain() As Boolean
   Dim DidItMoveBacklash() As Boolean
   Dim DummyDirection As Long
   
   ErrorDriverSource = "MoveAbsoluteAndWait"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   ReDim CurrentPositions(NameCount - 1)
   ReDim BacklashDistances(NameCount - 1)
   ReDim TravelTimes(NameCount - 1)
   ReDim Movements(NameCount - 1)
   ReDim DidItMoveMain(NameCount - 1)
   ReDim DidItMoveBacklash(NameCount - 1)
   
   ErrorCode = GetPosition(Names, CurrentPositions)
   If ErrorCode <> 0 Then
      MoveAbsoluteAndWait = ErrorCode
      ErrorRoutineSource = "GetPosition"
      Err.Raise ErrorCode
   End If
   
   ' main move
   For Index = 0 To (NameCount - 1)
      DidItMoveMain(Index) = False
      TravelTimes(Index) = MIN_TRAVEL_TIME
      ErrorCode = GetNanoStepStepsToMotorUnitsRatio(Names(Index), StepsToUnitsRatio)
      If (Abs((TargetPositions(Index) - CurrentPositions(Index))) _
         >= (1 / StepsToUnitsRatio)) Then
         ErrorCode = GetNanoStepBacklashDistance(Names(Index), _
                                                BacklashDistances(Index))
         
         If ErrorCode <> 0 Then
            MoveAbsoluteAndWait = ErrorCode
            ErrorRoutineSource = "GetNanoStepBacklashDistance"
            Err.Raise ErrorCode
         End If
         Movements(Index) = TargetPositions(Index)
         Select Case TargetPositions(Index) - CurrentPositions(Index)
            Case Is < ZERO:
               If BacklashesDisabled(Index) = False Then
                  Movements(Index) = TargetPositions(Index) + BacklashDistances(Index)
               End If
            Case Else:
               ' Do nothing
         End Select
         ErrorCode = SingleMoveAbsoluteAndContinue(Names(Index), _
                                             Movements(Index), _
                                             TravelTimes(Index))
         DidItMoveMain(Index) = True
         If ErrorCode <> 0 Then
            MoveAbsoluteAndWait = ErrorCode
            ErrorRoutineSource = "SingleMoveAbsoluteAndContinue"
            Err.Raise ErrorCode
         End If
      End If
   Next Index
   ErrorCode = CheckPosition(Names, TravelTimes, DidItMoveMain)
   If ErrorCode <> 0 Then
      MoveAbsoluteAndWait = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   
   ' backlash move:
   For Index = 0 To (NameCount - 1)
      DidItMoveBacklash(Index) = False
      If DidItMoveMain(Index) = True Then
         Select Case TargetPositions(Index) - CurrentPositions(Index)
            Case Is < ZERO:
               If BacklashesDisabled(Index) = False Then
                  ErrorCode = StartNanoStepRelativeDistance(Names(Index), _
                                                         DummyDirection, _
                                                         Abs(BacklashDistances(Index)))
                  DidItMoveBacklash(Index) = True
                  If ErrorCode <> 0 Then
                     MoveAbsoluteAndWait = ErrorCode
                     ErrorRoutineSource = "StartNanoStepRelativeDistance"
                     Err.Raise ErrorCode
                  End If
               End If
            Case Else:
               ' Do nothing
            End Select
         MoveAbsoluteAndWait = ErrorCode
      End If
   Next Index
   
   ErrorCode = CheckPosition(Names, TravelTimes, DidItMoveBacklash)
   If ErrorCode <> 0 Then
      MoveAbsoluteAndWait = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   MoveAbsoluteAndWait = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function MoveRelativeAndContinue(ByRef Names() As String, _
                                        ByRef Distances() As Double, _
                                        ByRef TravelTimes() As Double) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim NameCount As Long
   Dim Index As Integer
   Dim VelocityProfile(3) As Double
   Dim CurrentPosition As Double
   
   ErrorDriverSource = "MoveRelativeAndContinue"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = SingleGetVelocityProfile(Names(Index), VelocityProfile)
      If ErrorCode <> 0 Then
         MoveRelativeAndContinue = ErrorCode
         ErrorRoutineSource = "SingleGetVelocityProfile"
         Err.Raise ErrorCode
      End If
      TravelTimes(Index) = GetTravelTime(Distances(Index), _
                              VelocityProfile(0), _
                              VelocityProfile(1), _
                              VelocityProfile(2))
      ErrorCode = SingleMoveRelativeAndContinue(Names(Index), _
                                                Distances(Index), _
                                                TravelTimes(Index))
      If ErrorCode <> 0 Then
         MoveRelativeAndContinue = ErrorCode
         ErrorRoutineSource = "SingleMoveRelativeAndContinue"
         Err.Raise ErrorCode
      End If
   Next Index
   MoveRelativeAndContinue = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function MoveRelativeAndWait(ByRef Names() As String, _
                                    ByRef TargetDistances() As Double, _
                                    ByRef BacklashesDisabled() As Boolean) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim DeviceHandles() As Long
   Dim Index As Integer
   Dim CurrentPositions() As Double
   Dim BacklashDistances() As Double
   Dim NameCount As Long
   Dim StepsToUnitsRatio As Long
   Dim Movements() As Double
   Dim DidItMoveMain() As Boolean
   Dim DidItMoveBacklash() As Boolean
   Dim TravelTime As Double
   Dim TravelTimes() As Double
   
   ErrorDriverSource = "MoveRelativeAndWait"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   ReDim CurrentPositions(NameCount - 1)
   ReDim BacklashDistances(NameCount - 1)
   ReDim Movements(NameCount - 1)
   ReDim DidItMoveMain(NameCount - 1)
   ReDim DidItMoveBacklash(NameCount - 1)
   ReDim TravelTimes(NameCount - 1)
   
   ErrorCode = GetPosition(Names, CurrentPositions)
   If ErrorCode <> 0 Then
      MoveRelativeAndWait = ErrorCode
      ErrorRoutineSource = "GetPosition"
      Err.Raise ErrorCode
   End If
   ' main move
   For Index = 0 To (NameCount - 1)
      DidItMoveMain(Index) = False
      TravelTimes(Index) = MIN_TRAVEL_TIME
      ErrorCode = GetNanoStepStepsToMotorUnitsRatio(Names(Index), StepsToUnitsRatio)
      If (Abs(TargetDistances(Index)) >= (1 / StepsToUnitsRatio)) Then
         ' move is nonzero
         ErrorCode = GetNanoStepBacklashDistance(Names(Index), _
                                             BacklashDistances(Index))
         If ErrorCode <> 0 Then
            MoveRelativeAndWait = ErrorCode
            ErrorRoutineSource = "GetNanoStepBacklashDistance"
            Err.Raise ErrorCode
         End If
         Movements(Index) = TargetDistances(Index)
         Select Case TargetDistances(Index)
            Case Is < ZERO:
               If BacklashesDisabled(Index) = False Then
                  Movements(Index) = TargetDistances(Index) + BacklashDistances(Index)
               End If
            Case Else:
               ' Change nothing
         End Select
         ErrorCode = SingleMoveRelativeAndContinue(Names(Index), _
                                                   Movements(Index), _
                                                   TravelTime)
         DidItMoveMain(Index) = True
         If ErrorCode <> 0 Then
            MoveRelativeAndWait = ErrorCode
            ErrorRoutineSource = "SingleMoveRelativeAndContinue"
            Err.Raise ErrorCode
         End If
         TravelTimes(Index) = TravelTime
      End If
   Next Index
   ErrorCode = CheckPosition(Names, TravelTimes, DidItMoveMain)
   If ErrorCode <> 0 Then
      MoveRelativeAndWait = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   
   ' backlash move:
   For Index = 0 To (NameCount - 1)
      DidItMoveBacklash(Index) = False
      If DidItMoveMain(Index) = True Then
         Select Case TargetDistances(Index)
            Case Is < ZERO:
               If BacklashesDisabled(Index) = False Then
                  ErrorCode = SingleMoveRelativeAndContinue(Names(Index), _
                                                         Abs(BacklashDistances(Index)), _
                                                         TravelTime)
                  DidItMoveBacklash(Index) = True
               End If
               If ErrorCode <> 0 Then
                  MoveRelativeAndWait = ErrorCode
                  ErrorRoutineSource = "SingleMoveRelativeAndContinue"
                  Err.Raise ErrorCode
               End If
            Case Else:
               ' Do nothing
         End Select
         TravelTimes(Index) = TravelTime
      End If
   Next Index
   ErrorCode = CheckPosition(Names, TravelTimes, DidItMoveBacklash)
   If ErrorCode <> 0 Then
      MoveRelativeAndWait = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function SetVelocityProfiles(ByRef Names() As String, ByRef VelocityProfiles() As Double) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim NameCount As Long
   Dim Index As Integer
   
   ErrorDriverSource = "SetVelocityProfiles"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = SetNanoStepInitialVelocity(Names(Index), VelocityProfiles(Index, 0))
      If ErrorCode <> 0 Then
         SetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "SetNanoStepInitialVelocity"
         Err.Raise ErrorCode
      End If
      ErrorCode = SetNanoStepAcceleration(Names(Index), VelocityProfiles(Index, 1))
      If ErrorCode <> 0 Then
         SetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "SetNanoStepAcceleration"
         Err.Raise ErrorCode
      End If
      ErrorCode = SetNanoStepFinalVelocity(Names(Index), VelocityProfiles(Index, 2))
      If ErrorCode <> 0 Then
         SetVelocityProfiles = ErrorCode
         ErrorRoutineSource = "SetNanoStepFinalVelocity"
         Err.Raise ErrorCode
      End If
   Next Index
   SetVelocityProfiles = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function SingleGetPosition(ByVal Name As String, ByRef Position As Double) As Long
   Dim ErrorCode As Long
   Dim Names(0) As String
   Dim Positions(0) As Double
   
   Names(0) = Name
   ErrorCode = GetPosition(Names, Positions)
   Position = Positions(0)
End Function
Public Function SingleHome(ByVal Name As String) As Long
   Dim ErrorCode As Long
   Dim Names(0) As String
   
   Names(0) = Name
   ErrorCode = Home(Names)

End Function
Public Function SingleMoveAbsoluteAndContinue(ByVal Name As String, _
                                        ByVal Position As Double, _
                                        ByRef TravelTime As Double) As Long
   
   Dim ErrorCode As Long
   Dim Handle As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim Index As Integer
   Dim CurrentPosition As Double
   Dim VelocityProfile(2) As Double
   Dim Travel As Double
   
   ErrorDriverSource = "SingleMoveAbsoluteAndContinue"
   On Error GoTo MGErrorHandler
   ErrorCode = GetNanoStepPosition(Name, CurrentPosition)
   If ErrorCode <> 0 Then
      SingleMoveAbsoluteAndContinue = ErrorCode
      ErrorRoutineSource = "GetNanoStepPosition"
      Err.Raise ErrorCode
   End If
   SingleMoveAbsoluteAndContinue = ErrorCode
   Travel = Abs(Position - CurrentPosition)
   ErrorCode = SingleGetVelocityProfile(Name, VelocityProfile)
   If ErrorCode <> 0 Then
      SingleMoveAbsoluteAndContinue = ErrorCode
      ErrorRoutineSource = "SingleGetVelocityProfile"
      Err.Raise ErrorCode
   End If
   TravelTime = GetTravelTime(Travel, _
                              VelocityProfile(0), _
                              VelocityProfile(1), _
                              VelocityProfile(2))
   ErrorCode = StartMoveNanoStepAbsolute(Name, Position)
   If ErrorCode <> 0 Then
      SingleMoveAbsoluteAndContinue = ErrorCode
      ErrorRoutineSource = "StartMoveNanoStepAbsolute"
      Err.Raise ErrorCode
   End If
   ErrorCode = GetNanoStepHandle(Name, Handle)
   If ErrorCode <> 0 Then
      SingleMoveAbsoluteAndContinue = ErrorCode
      ErrorRoutineSource = "GetNanoStepHandle"
      Err.Raise ErrorCode
   End If
   ErrorCode = RequestNanoStepWhenAtPosition(Handle)
   SingleMoveAbsoluteAndContinue = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
   
End Function
Public Function SingleMoveRelativeAndContinue(ByVal Name As String, _
                                              ByVal Distance As Double, _
                                              ByRef TravelTime As Double) As Long
   
   Dim ErrorCode As Long
   Dim Handle As Long
   Dim direction As Long   ' Direction is required
                           ' by the dll call
                           ''StartNanoStepRelativeDistance'
                           ' but the value is ignored by it
   Dim VelocityProfile(2) As Double
   
   ErrorDriverSource = "SingleMoveRelativeAndContinue"
   On Error GoTo MGErrorHandler
   ErrorCode = SingleGetVelocityProfile(Name, VelocityProfile)
   If ErrorCode <> 0 Then
      SingleMoveRelativeAndContinue = ErrorCode
      ErrorRoutineSource = "SingleGetVelocityProfile"
      Err.Raise ErrorCode
   End If
   TravelTime = GetTravelTime(Distance, _
                              VelocityProfile(0), _
                              VelocityProfile(1), _
                              VelocityProfile(2))
   ErrorCode = GetNanoStepHandle(Name, Handle)
   If ErrorCode <> 0 Then
      SingleMoveRelativeAndContinue = ErrorCode
      ErrorRoutineSource = "GetNanoStepHandle"
      Err.Raise ErrorCode
   End If
   ErrorCode = StartNanoStepRelativeDistance(Name, direction, Distance)
   If ErrorCode <> 0 Then
      SingleMoveRelativeAndContinue = ErrorCode
      ErrorRoutineSource = "StartNanoStepRelativeDistance"
      Err.Raise ErrorCode
   End If
   ErrorCode = RequestNanoStepWhenAtPosition(Handle)
   If ErrorCode <> 0 Then
      SingleMoveRelativeAndContinue = ErrorCode
      ErrorRoutineSource = "RequestNanoStepWhenAtPosition"
      Err.Raise ErrorCode
   End If
   SingleMoveRelativeAndContinue = ErrorCode
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function SingleMoveAbsoluteAndWait(ByVal Name As String, _
                                    ByVal TargetPosition As Double, _
                                    ByVal BacklashDisabled As Boolean) As Long
   
   
   Dim ErrorCode As Long
   Dim Names(0) As String
   Dim Positions(0) As Double
   Dim Backlashes(0) As Boolean
   
   ErrorDriverSource = "SingleMoveAbsoluteAndWait"
   On Error GoTo MGErrorHandler
   Names(0) = Name
   Positions(0) = TargetPosition
   Backlashes(0) = BacklashDisabled
   ErrorCode = MoveAbsoluteAndWait(Names, Positions, Backlashes)
   If ErrorCode <> 0 Then
      SingleMoveAbsoluteAndWait = ErrorCode
      ErrorRoutineSource = "MoveAbsoluteAndWait"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource

End Function
Public Function SingleMoveRelativeAndWait(ByVal Name As String, _
                                    ByVal TargetDistance As Double, _
                                    ByVal BacklashDisabled As Boolean) As Long
   
   
   Dim ErrorCode As Long
   Dim Names(0) As String
   Dim Positions(0) As Double
   Dim Backlashes(0) As Boolean
   
   ErrorDriverSource = "SingleMoveRelativeAndWait"
   On Error GoTo MGErrorHandler
   Names(0) = Name
   Positions(0) = TargetDistance
   Backlashes(0) = BacklashDisabled
   ErrorCode = MoveRelativeAndWait(Names, Positions, Backlashes)
   If ErrorCode <> 0 Then
      SingleMoveRelativeAndWait = ErrorCode
      ErrorRoutineSource = "MoveRelativeAndWait"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource

End Function


Public Function MoveRelativeAndWaitWithCallback(ByRef Names() As String, _
                                    ByRef TargetDistances() As Double, _
                                    ByRef BacklashesDisabled() As Boolean) As Long
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim DeviceHandles() As Long
   Dim Index As Integer
   Dim CurrentPositions() As Double
   Dim BacklashDistances() As Double
   Dim NameCount As Long
   Dim StepsToUnitsRatio As Long
   Dim Movements() As Double
   Dim DidItMoveMain() As Boolean
   Dim DidItMoveBacklash() As Boolean
   Dim TravelTime As Double
   Dim TravelTimes() As Double
   
   ErrorDriverSource = "MoveRelativeAndWait"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   ReDim CurrentPositions(NameCount - 1)
   ReDim BacklashDistances(NameCount - 1)
   ReDim Movements(NameCount - 1)
   ReDim DidItMoveMain(NameCount - 1)
   ReDim DidItMoveBacklash(NameCount - 1)
   ReDim TravelTimes(NameCount - 1)
   
   ErrorCode = GetPosition(Names, CurrentPositions)
   If ErrorCode <> 0 Then
      MoveRelativeAndWaitWithCallback = ErrorCode
      ErrorRoutineSource = "GetPosition"
      Err.Raise ErrorCode
   End If
   ' main move
   For Index = 0 To (NameCount - 1)
      DidItMoveMain(Index) = False
      TravelTimes(Index) = MIN_TRAVEL_TIME
      ErrorCode = GetNanoStepStepsToMotorUnitsRatio(Names(Index), StepsToUnitsRatio)
      If (Abs(TargetDistances(Index)) >= (1 / StepsToUnitsRatio)) Then
         ' move is nonzero
         ErrorCode = GetNanoStepBacklashDistance(Names(Index), _
                                             BacklashDistances(Index))
         If ErrorCode <> 0 Then
            MoveRelativeAndWaitWithCallback = ErrorCode
            ErrorRoutineSource = "GetNanoStepBacklashDistance"
            Err.Raise ErrorCode
         End If
         Movements(Index) = TargetDistances(Index)
         Select Case TargetDistances(Index)
            Case Is < ZERO:
               If BacklashesDisabled(Index) = False Then
                  Movements(Index) = TargetDistances(Index) + BacklashDistances(Index)
               End If
            Case Else:
               ' Change nothing
         End Select
         ErrorCode = SingleMoveRelativeAndContinue(Names(Index), _
                                                   Movements(Index), _
                                                   TravelTime)
         DidItMoveMain(Index) = True
         If ErrorCode <> 0 Then
            MoveRelativeAndWaitWithCallback = ErrorCode
            ErrorRoutineSource = "SingleMoveRelativeAndContinue"
            Err.Raise ErrorCode
         End If
         TravelTimes(Index) = TravelTime
      End If
   Next Index
   ErrorCode = CheckPositionWithCallback(Names, TravelTimes, DidItMoveMain)
   If ErrorCode <> 0 Then
      MoveRelativeAndWaitWithCallback = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   
   ' backlash move:
   For Index = 0 To (NameCount - 1)
      DidItMoveBacklash(Index) = False
      If DidItMoveMain(Index) = True Then
         Select Case TargetDistances(Index)
            Case Is < ZERO:
               If BacklashesDisabled(Index) = False Then
                  ErrorCode = SingleMoveRelativeAndContinue(Names(Index), _
                                                         Abs(BacklashDistances(Index)), _
                                                         TravelTime)
                  DidItMoveBacklash(Index) = True
               End If
               If ErrorCode <> 0 Then
                  MoveRelativeAndWaitWithCallback = ErrorCode
                  ErrorRoutineSource = "SingleMoveRelativeAndContinue"
                  Err.Raise ErrorCode
               End If
            Case Else:
               ' Do nothing
         End Select
         TravelTimes(Index) = TravelTime
      End If
   Next Index
   ErrorCode = CheckPositionWithCallback(Names, TravelTimes, DidItMoveBacklash)
   If ErrorCode <> 0 Then
      MoveRelativeAndWaitWithCallback = ErrorCode
      ErrorRoutineSource = "AtPosition"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function

Public Function SingleMoveRelativeAndWaitWithCallback(ByVal Name As String, _
                                    ByVal TargetDistance As Double, _
                                    ByVal BacklashDisabled As Boolean) As Long
   
   
   Dim ErrorCode As Long
   Dim Names(0) As String
   Dim Positions(0) As Double
   Dim Backlashes(0) As Boolean
   
   ErrorDriverSource = "SingleMoveRelativeAndWait"
   On Error GoTo MGErrorHandler
   Names(0) = Name
   Positions(0) = TargetDistance
   Backlashes(0) = BacklashDisabled
   ErrorCode = MoveRelativeAndWaitWithCallback(Names, Positions, Backlashes)
   If ErrorCode <> 0 Then
      SingleMoveRelativeAndWaitWithCallback = ErrorCode
      ErrorRoutineSource = "MoveRelativeAndWait"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource

End Function

