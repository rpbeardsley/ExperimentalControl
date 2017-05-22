Attribute VB_Name = "RackUtils"
Option Base 0
Global Const UNKNOWN_CONFIGURATION = 8769&
Global Const INVALID_DEVICE_HANDLE = 8772&
Global Const CANT_REGISTER_DEVICE = 8774&
Global Const SERIAL_NUMBER_STRING_LENGTH = 255&
Global Const NAME_STRING_LENGTH = 255&
Global Const ZERO = 0&
Global Const DEFAULT_DOUBLE = 0#

Global CONFIGURATION_FILE As String
Global STAGES_FILE As String

Public ErrorRoutineSource As String
Public ErrorDriverSource As String


Declare Function GetConfigCount Lib "MG17_HiLevel.dll" _
(ByVal szConfigFile As String) As Long
Declare Function GetConfigName Lib "MG17_HiLevel.dll" _
(ByVal File As String, ByVal Index As Long, _
 ByVal Name As String, ByVal Length As Long) As Long
Public Function SetupDevices(ByRef NanoStepNames() As String, _
                             ByRef PiezoNames() As String, _
                             ByRef NanoTrakNames() As String) As Long
                                    
   
   Dim ErrorCode As Long
   Dim Index As Long
   Dim SerialNumber As String
   Dim NumericSerialNumber As Long
   Dim NameLength As Long
   Dim NanoStepCount As Long
   Dim PiezoCount As Long
   Dim NanoTrakCount As Long
   Dim Handle As Long
   
   SerialNumber = String(255, 0)
   NanoStepCount = GetNanoStepConfigCount
   For Index = 0 To NanoStepCount - 1
      Call GetNanoStepConfigInfo(Index + 1, SerialNumber, _
                                 SERIAL_NUMBER_STRING_LENGTH, _
                                 NanoStepNames(Index), _
                                 NAME_STRING_LENGTH)
      NumericSerialNumber = Val(SerialNumber)
      ErrorCode = RegisterNanoStep(NanoStepNames(Index), Handle, NumericSerialNumber)
      If ErrorCode <> 0 Then
         SetupDevices = ErrorCode
      End If
   Next Index
   PiezoCount = GetPiezoConfigCount
   For Index = 0 To PiezoCount - 1
      Call GetPiezoConfigInfo(Index + 1, SerialNumber, _
                              SERIAL_NUMBER_STRING_LENGTH, _
                              PiezoNames(Index), _
                              NAME_STRING_LENGTH)
      NumericSerialNumber = Val(SerialNumber)
      ErrorCode = RegisterPiezo(PiezoNames(Index), Handle, SerialNumber)
      If ErrorCode <> 0 Then
         SetupDevices = ErrorCode
      End If
   Next Index
   NanoTrakCount = GetNanoTrakConfigCount
   For Index = 0 To NanoTrakCount - 1
      Call GetNanoTrakConfigInfo(Index + 1, SerialNumber, _
                              SERIAL_NUMBER_STRING_LENGTH, _
                              NanoTrakNames(Index), _
                              NAME_STRING_LENGTH)
      ErrorCode = RegisterNanoTrak(NanoTrakNames(Index), Handle, SerialNumber)
      If ErrorCode <> 0 Then
         SetupDevices = ErrorCode
      End If
   Next Index
   
End Function
Public Function GetConfigurationList(ByRef ConfigurationNames() As String, _
                                     ByRef ListLength As Long) As Long
                                    
   
   Dim ErrorCode As Long
   Dim Index As Long
   
   ListLength = GetConfigCount(CONFIGURATION_FILE)
   ReDim ConfigurationNames(ListLength - 1) As String
   For Index = 1 To ListLength
      ConfigurationNames(Index - 1) = String(255, 0)
      ErrorCode = GetConfigName(CONFIGURATION_FILE, Index, _
                           ConfigurationNames(Index - 1), NAME_STRING_LENGTH)
      If ErrorCode <> 0 Then
         GetConfigurationList = ErrorCode
      End If
   Next Index
End Function
Public Function RetrieveDevices(ByVal Configuration As String, _
                                ByRef NanoStepNames() As String, _
                                ByRef PiezoNames() As String, _
                                ByRef NanoTrakNames() As String) As Long
                                    
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim Index As Long
   Dim SerialNumber As String
   Dim NameLength As Long
   Dim DeviceCount As Long
   Dim NanoStepCount As Long
   Dim PiezoCount As Long
   Dim NanoTrakCount As Long
   
   ErrorDriverSource = "RetrieveDevices"
   On Error GoTo MGErrorHandler
   ErrorCode = LoadStage(STAGES_FILE)
   DeviceCount = LoadConfig(Configuration, CONFIGURATION_FILE)
   If DeviceCount = ZERO Then
      ErrorCode = UNKNOWN_CONFIGURATION
      RetrieveDevices = ErrorCode
      ErrorRoutineSource = "LoadConfig"
      Err.Raise ErrorCode
   End If
   SerialNumber = String(255, 0)
   NanoStepCount = GetNanoStepConfigCount
   For Index = 0 To NanoStepCount - 1
      Call GetNanoStepConfigInfo(Index + 1, SerialNumber, _
                                 SERIAL_NUMBER_STRING_LENGTH, _
                                 NanoStepNames(Index), _
                                 NAME_STRING_LENGTH)
      If ErrorCode <> ZERO Then
         RetrieveDevices = ErrorCode
         ErrorRoutineSource = "GetNanoStepConfigInfo"
         Err.Raise ErrorCode
      End If
   Next Index
   PiezoCount = GetPiezoConfigCount
   For Index = 0 To PiezoCount - 1
      Call GetPiezoConfigInfo(Index + 1, SerialNumber, _
                              SERIAL_NUMBER_STRING_LENGTH, _
                              PiezoNames(Index), _
                              NAME_STRING_LENGTH)
      If ErrorCode <> ZERO Then
         RetrieveDevices = ErrorCode
         ErrorRoutineSource = "GetPiezoConfigInfo"
         Err.Raise ErrorCode
      End If
   Next Index
   NanoTrakCount = GetNanoTrakConfigCount
   For Index = 0 To NanoTrakCount - 1
      Call GetNanoTrakConfigInfo(Index + 1, SerialNumber, _
                              SERIAL_NUMBER_STRING_LENGTH, _
                              NanoTrakNames(Index), _
                              NAME_STRING_LENGTH)
      If ErrorCode <> ZERO Then
         RetrieveDevices = ErrorCode
         ErrorRoutineSource = "GetNanoTrakConfigInfo"
         Err.Raise ErrorCode
      End If
   Next Index
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function
Public Function RetrieveAllDevices(ByVal Configuration As String, _
                                ByRef DeviceNames() As String)
   
   Dim ErrorCode As Long
   Dim ErrorDriverSource As String
   Dim ErrorRoutineSource As String
   Dim Index As Long
   Dim CumulIndex As Long
   Dim SerialNumber As String
   Dim NameLength As Long
   Dim DeviceCount As Long
   Dim NanoStepCount As Long
   Dim PiezoCount As Long
   Dim NanoTrakCount As Long
   
   ErrorDriverSource = "RetrieveAllDevices"
   On Error GoTo MGErrorHandler
   ErrorCode = LoadStage(STAGES_FILE)
   DeviceCount = LoadConfig(Configuration, CONFIGURATION_FILE)
   If DeviceCount = ZERO Then
      ErrorCode = UNKNOWN_CONFIGURATION
      RetrieveAllDevices = ErrorCode
      ErrorRoutineSource = "LoadConfig"
      Err.Raise ErrorCode
   End If
   SerialNumber = String(255, 0)
   NanoStepCount = GetNanoStepConfigCount
   CumulIndex = 0
   For Index = 0 To NanoStepCount - 1
      Call GetNanoStepConfigInfo(Index + 1, SerialNumber, _
                                 SERIAL_NUMBER_STRING_LENGTH, _
                                 DeviceNames(CumulIndex), _
                                 NAME_STRING_LENGTH)
      If ErrorCode <> ZERO Then
         RetrieveAllDevices = ErrorCode
         ErrorRoutineSource = "GetNanoStepConfigInfo"
         Err.Raise ErrorCode
      End If
      CumulIndex = CumulIndex + 1
   Next Index
   PiezoCount = GetPiezoConfigCount
   For Index = 0 To PiezoCount - 1
      Call GetPiezoConfigInfo(Index + 1, SerialNumber, _
                              SERIAL_NUMBER_STRING_LENGTH, _
                              DeviceNames(CumulIndex), _
                              NAME_STRING_LENGTH)
      If ErrorCode <> ZERO Then
         RetrieveAllDevices = ErrorCode
         ErrorRoutineSource = "GetPiezoConfigInfo"
         Err.Raise ErrorCode
      End If
      CumulIndex = CumulIndex + 1
   Next Index
   NanoTrakCount = GetNanoTrakConfigCount
   For Index = 0 To NanoTrakCount - 1
      Call GetNanoTrakConfigInfo(Index + 1, SerialNumber, _
                              SERIAL_NUMBER_STRING_LENGTH, _
                              DeviceNames(CumulIndex), _
                              NAME_STRING_LENGTH)
      If ErrorCode <> ZERO Then
         RetrieveAllDevices = ErrorCode
         ErrorRoutineSource = "GetNanoTrakConfigInfo"
         Err.Raise ErrorCode
      End If
      CumulIndex = CumulIndex + 1
   Next Index
   Exit Function
MGErrorHandler:
   ErrorHandler ErrorCode, ErrorRoutineSource, ErrorDriverSource
End Function


Public Function StringArraySize(ByRef Source() As String) As Long
   
   Dim Index As Integer
   Dim InitialSize As Long
   
   StringArraySize = 0
   InitialSize = UBound(Source)
   For Index = 0 To InitialSize
      If Left(Source(Index), 1) Like "[0-9A-Za-z]" Then
         StringArraySize = StringArraySize + 1
      End If
   Next Index
   
FinalLine:
End Function

