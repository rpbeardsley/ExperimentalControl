Attribute VB_Name = "RackDriver"
Option Base 0
Declare Function LoadConfig Lib "MG17_HiLevel.dll" _
(ByVal Config As String, ByVal File As String) As Long
Declare Function LoadStage Lib "MG17_HiLevel.dll" _
(ByVal File As String) As Long
Declare Function GetNanoStepConfigCount Lib "MG17_HiLevel.dll" _
() As Long
Declare Function GetPiezoConfigCount Lib "MG17_HiLevel.dll" _
() As Long
Declare Function GetNanoTrakConfigCount Lib "MG17_HiLevel.dll" _
() As Long
Declare Sub GetNanoStepConfigInfo Lib "MG17_HiLevel.dll" _
(ByVal Index As Long, ByVal SerialNumber As String, _
 ByVal Length As Long, ByVal Name As String, ByVal Length2 As Long)
Declare Sub GetPiezoConfigInfo Lib "MG17_HiLevel.dll" _
(ByVal Index As Long, ByVal SerialNumber As String, _
 ByVal Length As Long, ByVal Name As String, ByVal Length2 As Long)
Declare Sub GetNanoTrakConfigInfo Lib "MG17_HiLevel.dll" _
(ByVal Index As Long, ByVal SerialNumber As String, _
 ByVal Length As Long, ByVal Name As String, ByVal Length2 As Long)
Declare Function RegisterNanoStep Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Handle As Long, ByVal SerialNumber As Long) As Long
Declare Function RegisterPiezo Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Handle As Long, ByVal SerialNumber As String) As Long
Declare Function RegisterNanoTrak Lib "MG17_HiLevel.dll" _
(ByVal Name As String, ByRef Handle As Long, ByVal SerialNumber As String) As Long
Declare Function UnRegisterNanoStep Lib "MG17_HiLevel.dll" _
(ByVal Name As String) As Long
Declare Function UnRegisterPiezo Lib "MG17_HiLevel.dll" _
(ByVal Name As String) As Long
Declare Function UnRegisterNanoTrak Lib "MG17_HiLevel.dll" _
(ByVal Name As String) As Long
Declare Function UnRegisterAllNanoSteps Lib "MG17_HiLevel.dll" _
() As Long
Declare Function UnRegisterAllPiezos Lib "MG17_HiLevel.dll" _
() As Long
Declare Function UnRegisterAllNanoTraks Lib "MG17_HiLevel.dll" _
() As Long
Public Sub ErrorHandler(ByVal ErrorCode As Long, _
                        ByRef ErrorRoutineSource As String, _
                        ByRef ErrorDriverSource As String)
   Dim Message As String
   
   If ErrorDriverSource = "" Then
      ErrorDriverSource = "'unknown'"
   End If
   If ErrorRoutineSource = "" Then
      ErrorRoutineSource = "'unknown'"
   End If
   If ErrorCode > 8000 And ErrorCode < 9000 Then
      Message = "An error with value " & Str(ErrorCode) & _
               " occurred in file " & Err.Source _
               & " when the routine  " & _
               ErrorDriverSource & " called the low-level routine " _
               & ErrorRoutineSource
   Else
      Message = "An error with value " & Str(Err.Number) & _
               " occurred in file " & Err.Source _
               & " Possible reason :   " & _
               Err.Description
   End If
   MsgBox Message

End Sub
Public Function SetupAConfiguration(ByVal ConfigurationName As String, _
                                    ByVal RetainPreviousConfigurations As Boolean, _
                                    ByRef NanoStepNames() As String, _
                                    ByRef PiezoNames() As String, _
                                    ByRef NanoTrakNames() As String) As Long
                                    
   
   Dim ErrorCode As Long
   Dim ErrorRoutineSource As String
   Dim ErrorDriverSource As String
   Dim Index As Long
   Dim DeviceCount As Long
   Dim NanoCount As Long
   Dim DummyNames() As String
   
   ErrorDriverSource = "SetupAConfiguration"
   On Error GoTo MGErrorHandler
   If RetainPreviousConfigurations = False Then
      ErrorCode = ReleaseAConfiguration(False, DummyNames, _
                                 DummyNames, DummyNames)
   End If
   If (ErrorCode <> 0) Then
      SetupAConfiguration = ErrorCode
      ErrorRoutineSource = "ReleaseAConfiguration"
      Err.Raise ErrorCode
   End If
   ErrorCode = LoadStage(STAGES_FILE)
   DeviceCount = LoadConfig(ConfigurationName, CONFIGURATION_FILE)
   If DeviceCount = ZERO Then
      ErrorCode = UNKNOWN_CONFIGURATION
      SetupAConfiguration = ErrorCode
      ErrorRoutineSource = "LoadConfig"
      Err.Raise ErrorCode
   End If
   ErrorCode = SetupDevices(NanoStepNames, PiezoNames, NanoTrakNames)
   If (ErrorCode <> 0) Then
      SetupAConfiguration = ErrorCode
      ErrorRoutineSource = "SetupDevices"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
   
End Function
Public Function LaunchAConfiguration(ByVal ConfigurationName As String, _
                                    ByVal RetainPreviousConfigurations As Boolean) As Long
                                    
   
   Dim ErrorCode As Long
   Dim ErrorRoutineSource As String
   Dim ErrorDriverSource As String
   Dim Index As Long
   Dim DeviceCount As Long
   Dim NanoCount As Long
   Dim DummyNames() As String
   Dim NanoStepNames() As String
   Dim PiezoNames() As String
   Dim NanoTrakNames() As String
   
   ErrorDriverSource = "LaunchAConfiguration"
   On Error GoTo MGErrorHandler
   If RetainPreviousConfigurations = False Then
      ErrorCode = ReleaseAConfiguration(False, DummyNames, _
                                 DummyNames, DummyNames)
   End If
   If (ErrorCode <> 0) Then
      LaunchAConfiguration = ErrorCode
      ErrorRoutineSource = "ReleaseAConfiguration"
      Err.Raise ErrorCode
   End If
   ErrorCode = LoadStage(STAGES_FILE)
   DeviceCount = LoadConfig(ConfigurationName, CONFIGURATION_FILE)
   If DeviceCount = ZERO Then
      ErrorCode = UNKNOWN_CONFIGURATION
      LaunchAConfiguration = ErrorCode
      ErrorRoutineSource = "LoadConfig"
      Err.Raise ErrorCode
   End If
   ReDim NanoStepNames(DeviceCount - 1)
   ReDim PiezoNames(DeviceCount - 1)
   ReDim NanoTrakNames(DeviceCount - 1)
   For Index = 0 To (DeviceCount - 1)
      NanoStepNames(Index) = String(255, 0)
      PiezoNames(Index) = String(255, 0)
      NanoTrakNames(Index) = String(255, 0)
   Next Index
   ErrorCode = SetupDevices(NanoStepNames, PiezoNames, NanoTrakNames)
   If (ErrorCode <> 0) Then
      LaunchAConfiguration = ErrorCode
      ErrorRoutineSource = "SetupDevices"
      Err.Raise ErrorCode
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
   
End Function
Public Function ReleaseAConfiguration(ByVal RetainPreviousConfigurations As Boolean, _
                                      ByRef NanoStepNames() As String, _
                                      ByRef PiezoNames() As String, _
                                      ByRef NanoTrakNames() As String) As Long
                                    
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim Index As Integer
   Dim NanoStepCount As Long
   Dim PiezoCount As Long
   Dim NanoTrakCount As Long
   
   ErrorDriverSource = "ReleaseAConfiguration"
   On Error GoTo MGErrorHandler
   If (RetainPreviousConfigurations = False) Then
      ErrorCode = UnRegisterAllNanoSteps()
      If ErrorCode <> 0 Then
         ReleaseAConfiguration = ErrorCode
         ErrorRoutineSource = "UnRegisterAllNanoSteps"
         Err.Raise ErrorCode
      End If
      ErrorCode = UnRegisterAllNanoTraks()
      If ErrorCode <> 0 Then
         ReleaseAConfiguration = ErrorCode
         ErrorRoutineSource = "UnRegisterAllNanoTraks"
         Err.Raise ErrorCode
      End If
      ErrorCode = UnRegisterAllPiezos()
      If ErrorCode <> 0 Then
         ReleaseAConfiguration = ErrorCode
         ErrorRoutineSource = "UnRegisterAllPiezos"
         Err.Raise ErrorCode
      End If
   Else
      NanoStepCount = StringArraySize(NanoStepNames)
      PiezoCount = StringArraySize(PiezoNames)
      NanoTrakCount = StringArraySize(NanoTrakNames)
      For Index = 0 To (NanoStepCount - 1)
         ErrorCode = UnRegisterNanoStep(NanoStepNames(Index))
         If ErrorCode <> 0 Then
            ReleaseAConfiguration = ErrorCode
            ErrorRoutineSource = "UnRegisterNanoStep"
            Err.Raise ErrorCode
         End If
      Next Index
      For Index = 0 To (PiezoCount - 1)
         ErrorCode = UnRegisterPiezo(PiezoNames(Index))
         If ErrorCode <> 0 Then
            ReleaseAConfiguration = ErrorCode
            ErrorRoutineSource = "UnRegisterPiezo"
            Err.Raise ErrorCode
         End If
      Next Index
      For Index = 0 To (NanoTrakCount - 1)
         ErrorCode = UnRegisterNanoTrak(NanoTrakNames(Index))
         If ErrorCode <> 0 Then
            ReleaseAConfiguration = ErrorCode
            ErrorRoutineSource = "UnRegisterNanoTrak"
            Err.Raise ErrorCode
         End If
      Next Index
   End If
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
   
End Function
