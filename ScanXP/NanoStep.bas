Attribute VB_Name = "NanoStep"
Public CallBackRedirection As Integer
Public CurrentPosition
Public CurrentSpeed

Public Sub Init(cfg As String)

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.Init (cfg)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.Init
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_Init
    End If
    
End Sub

Public Sub UpdateNanoStepPositionCounter()

    
    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.UpdateNanoStepPositionCounter
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.UpdateNanoStepPositionCounter
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_UpdateNanoStepPositionCounter
    End If

End Sub

Public Sub GoToPosition(pos)

    Dim settings As String
    Dim command As String

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.GoToPosition (pos)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.GoToPosition (CSng(pos))
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_GoToPosition (pos)
    End If

End Sub

Public Sub MoveTrack(dist)

    Dim settings As String
    Dim command As String
    
    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.MoveTrack (dist)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.MoveTrack (CSng(dist))
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_MoveTrack (dist)
    End If

End Sub

Public Sub MoveTrackWithCallback(dist)

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.MoveTrackWithCallback (dist)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.MoveTrackWithCallback (CSng(dist))
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_MoveTrackAsynchronous (dist)
    End If

End Sub

Public Sub HomeTrack()

    Dim settings As String
    Dim command As String
    
    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.HomeTrack
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.HomeTrack
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_HomeTrack
    End If
    
End Sub

Public Sub UpdateNanoStepSpeed()

Dim settings As String
Dim request As String

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.UpdateNanoStepSpeed
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.UpdateNanoStepSpeed
    ElseIf NANOSTEPPER_TYPE = 3 Then
        newport_stepper.NewportStepper_UpdateNanoStepSpeed
    End If

End Sub

Public Function GetSmallestNanoStep() As Double

    Dim a As Double

    If NANOSTEPPER_TYPE = 1 Then
        a = MGNanoStep.GetSmallestNanoStep
    ElseIf NANOSTEPPER_TYPE = 2 Then
        a = ThorlabsNanoStep.GetSmallestNanoStep
    ElseIf NANOSTEPPER_TYPE = 3 Then
        a = newport_stepper.NewportStepper_GetSmallestNanoStep
    End If

    GetSmallestNanoStep = a

End Function
