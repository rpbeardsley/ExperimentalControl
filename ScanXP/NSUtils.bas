Attribute VB_Name = "NSUtils"
Option Base 0
Global Const CONTROLLER_NOT_AT_POSITION = 0&
Global Const CONTROLLER_AT_POSITION = 1&
Global Const AT_POSITION_TIMEOUT = 8773&
Global Const NEGATIVE_LIMIT = 0&
Global Const COUNTER_CENTRE = &H80000000
Global Const POWER_DOWN = 4
Global Const TRAVEL_TIME_SCALER = 1.75
Global Const MIN_TRAVEL_TIME = 5#
Global Const NO_NANOSTEPS = 8778&
Declare Function ClearNanoStepActiveLed Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long) As Long
Declare Function StartNanoStepFindLmitSwitch Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal LimitSwitch As Long) As Long
Declare Function GetNanoStepInitialVelocity Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef InitialVelocity As Double) As Long
Declare Function GetNanoStepAcceleration Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Acceleration As Double) As Long
Declare Function GetNanoStepMinimumSpeed Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef MinimumSpeed As Double) As Long
Declare Function GetNanoStepMaximumSpeed Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef MaximumSpeed As Double) As Long
Declare Function GetNanoStepFinalVelocity Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef FinalVelocity As Double) As Long
Declare Function SetNanoStepInitialVelocity Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef InitialVelocity As Double) As Long
Declare Function SetNanoStepAcceleration Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Acceleration As Double) As Long
Declare Function SetNanoStepCurrentAbsolutePosition Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long, ByVal AbsolutePosition As Long) As Long
Declare Function SetNanoStepFinalVelocity Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef FinalVelocity As Double) As Long
Declare Function GetNanoStepZeroOffset Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Offset As Double) As Long
Declare Function GetNanoStepMinimumPosition Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef MinPosition As Double) As Long
Declare Function GetNanoStepMaximumPosition Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef MaxPosition As Double) As Long
Declare Function GetNanoStepHandle Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Handle As Long) As Long
Declare Function RequestNanoStepWhenAtPosition Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long) As Long
Declare Function StartMoveNanoStepAbsolute Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Position As Double) As Long
Declare Function StartNanoStepFindLimitSwitch Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal LimitSwitch As Long) As Long
Declare Function StartNanoStepRelativeUncalib Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Distance As Double) As Long
Declare Function StartNanoStepRelativeDistance Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByVal Dir As Long, ByVal Distance As Double) As Long
Declare Function GetNanoStepStepsToMotorUnitsRatio Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef StepsToUnits As Long) As Long
Declare Function SetNanoStepActiveLed Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long) As Long
Declare Function SetNanoStepUnitPower Lib "MG17_LoLevel.dll" _
(ByVal Handle As Long, ByVal PowerMode As Long) As Long
Public Function CheckPosition(ByRef Names() As String, ByRef TravelTimes() As Double, DidItMove() As Boolean) As Long
   
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
   
   ErrorDriverSource = "CheckPosition"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   MaximumTravelTime = 0
   
   For Index = 0 To (NameCount - 1)
      If TravelTimes(Index) > MaximumTravelTime Then
         MaximumTravelTime = TravelTimes(Index)
      End If
   Next Index
   
   For Index = 0 To (NameCount - 1)
        If DidItMove(Index) = True Then
            ErrorCode = GetNanoStepHandle(Names(Index), Handle)
            If ErrorCode <> 0 Then
                CheckPosition = ErrorCode
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
                    CheckPosition = ErrorCode
                    ErrorRoutineSource = "CheckNanoStepWhenAtPosition"
                    Err.Raise ErrorCode
                End If
                TimeNow = (Timer - StartTime)
                TimeoutError = TimeNow > MaximumTravelTime
                
            Wend
            If TimeoutError = True Then
                ErrorCode = AT_POSITION_TIMEOUT
                CheckPosition = ErrorCode
                Err.Raise ErrorCode
            End If
            ErrorCode = ClearNanoStepActiveLed(Handle)
            If ErrorCode <> 0 Then
                CheckPosition = ErrorCode
                ErrorRoutineSource = "ClearNanoStepActiveLed"
                Err.Raise ErrorCode
             End If
            ErrorCode = SetNanoStepUnitPower(Handle, POWER_DOWN)
            Index2 = 0
            While Index2 < 10000
                Index2 = Index2 + 1
            Wend
            If ErrorCode <> 0 Then
                CheckPosition = ErrorCode
                ErrorRoutineSource = "SetNanoStepUnitPower"
                Err.Raise ErrorCode
            End If
            CheckPosition = ErrorCode
        End If
   Next Index
   CheckPosition = ErrorCode
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
Public Function SetZero(ByRef Names() As String) As Long
   
   Dim ErrorCode As Long
   Dim Handle As Long
   Dim NameCount As Long
   Dim Index As Integer
   
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      If ErrorCode <> 0 Then
         SetZero = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = SetNanoStepCurrentAbsolutePosition(Handle, COUNTER_CENTRE)
      If ErrorCode <> 0 Then
         SetZero = ErrorCode
         GoTo FinalLine
      End If
   Next Index
   SetZero = ErrorCode

FinalLine:
End Function
Public Function SingleGetVelocityProfile(ByVal Name As String, ByRef VelocityProfile() As Double) As Long
   
   Dim ErrorCode As Long
   Dim NameCount As Long
   Dim Index As Integer
   
   ErrorCode = GetNanoStepInitialVelocity(Name, VelocityProfile(0))
   If ErrorCode <> 0 Then
      SingleGetVelocityProfile = ErrorCode
      GoTo FinalLine
   End If
   ErrorCode = GetNanoStepAcceleration(Name, VelocityProfile(1))
   If ErrorCode <> 0 Then
      SingleGetVelocityProfile = ErrorCode
      GoTo FinalLine
   End If
   ErrorCode = GetNanoStepFinalVelocity(Name, VelocityProfile(2))
   If ErrorCode <> 0 Then
      SingleGetVelocityProfile = ErrorCode
      GoTo FinalLine
   End If
   SingleGetVelocityProfile = ErrorCode

FinalLine:
End Function
Public Function GetDistanceToHome(ByRef Names() As String, _
                                  ByRef DistancesToHome() As Double) As Long
   
   Dim ErrorCode As Long
   Dim NameCount As Long
   Dim Index As Integer
   Dim MinimumPosition As Double
   Dim ZeroOffset As Double
   
   NameCount = StringArraySize(Names)
   ReDim DistancesToHome(NameCount - 1)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepZeroOffset(Names(Index), ZeroOffset)
      If ErrorCode <> 0 Then
         GetDistanceToHome = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = GetNanoStepMinimumPosition(Names(Index), MinimumPosition)
      If ErrorCode <> 0 Then
         GetDistanceToHome = ErrorCode
         GoTo FinalLine
      End If
      DistancesToHome(Index) = ZeroOffset + MinimumPosition
      If ErrorCode <> 0 Then
         GetDistanceToHome = ErrorCode
         GoTo FinalLine
      End If
   Next Index
   GetDistanceToHome = ErrorCode
   
FinalLine:
End Function
Public Function MoveToLimitAndContinue(ByRef Names() As String, _
                                       ByRef LimitSwitches() As Long, _
                                       ByRef TravelTimes() As Double) As Long
   
   Dim ErrorCode As Long
   Dim NameCount As Long
   Dim Index As Integer
   Dim Handle As Long
   Dim Travel As Double
   Dim TravelTime As Double
   Dim CurrentPosition As Double
   Dim VelocityProfile(2) As Double
   Dim Position As Double
   Dim MinimumSpeed As Double
  
   NameCount = StringArraySize(Names)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = GetNanoStepMaximumPosition(Names(Index), Travel)
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = GetNanoStepMinimumSpeed(Names(Index), MinimumSpeed)
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = SingleGetVelocityProfile(Names(Index), VelocityProfile)
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
      TravelTimes(Index) = GetTravelTime(Travel, _
                              VelocityProfile(0), _
                              VelocityProfile(1), _
                              MinimumSpeed)
   Next Index
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      ErrorCode = SetNanoStepActiveLed(Handle)
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = StartNanoStepFindLimitSwitch(Names(Index), LimitSwitches(Index))
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = RequestNanoStepWhenAtPosition(Handle)
      If ErrorCode <> 0 Then
         MoveToLimitAndContinue = ErrorCode
         GoTo FinalLine
      End If
   Next Index
   MoveToLimitAndContinue = ErrorCode
   
FinalLine:
End Function
Public Function MoveRelativeUncalibAndContinue(ByRef Names() As String, _
                                               ByRef Distances() As Double, _
                                               ByRef TravelTimes() As Double) As Long
   
   Dim ErrorCode As Long
   Dim NameCount As Long
   Dim Index As Integer
   Dim Handle As Long
   Dim Travel As Double
   Dim CurrentPosition As Double
   Dim DistancesToHome() As Double
   Dim VelocityProfile(2) As Double
   Dim Position As Double
   
   
   NameCount = StringArraySize(Names)
   ReDim DistancesToHome(NameCount)
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      If ErrorCode <> 0 Then
         MoveRelativeUncalibAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = SingleGetVelocityProfile(Names(Index), VelocityProfile)
      If ErrorCode <> 0 Then
         MoveRelativeUncalibAndContinue = ErrorCode
         GoTo FinalLine
      End If
      TravelTimes(Index) = GetTravelTime(Distances(Index), _
                              VelocityProfile(0), _
                              VelocityProfile(1), _
                              VelocityProfile(2))
   Next Index
   For Index = 0 To (NameCount - 1)
      ErrorCode = GetNanoStepHandle(Names(Index), Handle)
      ErrorCode = StartNanoStepRelativeUncalib(Names(Index), Distances(Index))
      If ErrorCode <> 0 Then
         MoveRelativeUncalibAndContinue = ErrorCode
         GoTo FinalLine
      End If
      ErrorCode = RequestNanoStepWhenAtPosition(Handle)
      If ErrorCode <> 0 Then
         MoveRelativeUncalibAndContinue = ErrorCode
         GoTo FinalLine
      End If
   Next Index
   MoveRelativeUncalibAndContinue = ErrorCode
   
FinalLine:
End Function
Public Function GetTravelTime(ByVal Travel As Double, _
                              ByVal InitialVelocity As Double, _
                              ByVal Acceleration As Double, _
                              ByVal FinalVelocity As Double) As Double
   
   Dim InitialTime As Double
   Dim MiddleTime As Double
   Dim InitialDistance As Double
   Dim MiddleDistance As Double
   
   Acceleration = Acceleration * 4
   Travel = Abs(Travel)
   If Travel <> 0 Then
      If Acceleration <> 0 Then
         InitialDistance = ((FinalVelocity ^ 2) - (InitialVelocity ^ 2)) / _
                            (2 * Acceleration)
         MiddleDistance = Abs(Travel) - (2 * InitialDistance)
         MiddleTime = MiddleDistance / FinalVelocity
         If MiddleDistance <= 0 Then
            MiddleTime = 0
            FinalVelocity = Sqr((InitialVelocity ^ 2) + (Acceleration * Travel))
         End If
         InitialTime = (FinalVelocity - InitialVelocity) / _
                        Acceleration
         GetTravelTime = MiddleTime + (2 * InitialTime)
      Else
         GetTravelTime = Abs(Travel) / InitialVelocity
      End If
   Else
      GetTravelTime = MIN_TRAVEL_TIME
   End If
   GetTravelTime = GetTravelTime * TRAVEL_TIME_SCALER
   If GetTravelTime < MIN_TRAVEL_TIME Then
        GetTravelTime = MIN_TRAVEL_TIME
   End If
End Function

Public Function CheckPositionWithCallback(ByRef Names() As String, ByRef TravelTimes() As Double, DidItMove() As Boolean) As Long
   
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
   
   ErrorDriverSource = "CheckPosition"
   On Error GoTo MGErrorHandler
   NameCount = StringArraySize(Names)
   MaximumTravelTime = 0
   
   For Index = 0 To (NameCount - 1)
      If TravelTimes(Index) > MaximumTravelTime Then
         MaximumTravelTime = TravelTimes(Index)
      End If
   Next Index
   
   For Index = 0 To (NameCount - 1)
        If DidItMove(Index) = True Then
            ErrorCode = GetNanoStepHandle(Names(Index), Handle)
            If ErrorCode <> 0 Then
                CheckPositionWithCallback = ErrorCode
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
                    CheckPositionWithCallback = ErrorCode
                    ErrorRoutineSource = "CheckNanoStepWhenAtPosition"
                    Err.Raise ErrorCode
                End If
                TimeNow = (Timer - StartTime)
                TimeoutError = TimeNow > MaximumTravelTime
                
                Call NanoStepperCallback
                
            Wend
            If TimeoutError = True Then
                ErrorCode = AT_POSITION_TIMEOUT
                CheckPositionWithCallback = ErrorCode
                Err.Raise ErrorCode
            End If
            ErrorCode = ClearNanoStepActiveLed(Handle)
            If ErrorCode <> 0 Then
                CheckPositionWithCallback = ErrorCode
                ErrorRoutineSource = "ClearNanoStepActiveLed"
                Err.Raise ErrorCode
             End If
            ErrorCode = SetNanoStepUnitPower(Handle, POWER_DOWN)
            Index2 = 0
            While Index2 < 10000
                Index2 = Index2 + 1
            Wend
            If ErrorCode <> 0 Then
                CheckPositionWithCallback = ErrorCode
                ErrorRoutineSource = "SetNanoStepUnitPower"
                Err.Raise ErrorCode
            End If
            CheckPositionWithCallback = ErrorCode
        End If
   Next Index
   CheckPositionWithCallback = ErrorCode
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


