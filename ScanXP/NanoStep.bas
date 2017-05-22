Attribute VB_Name = "NanoStep"
Public CallBackRedirection As Integer
Public CurrentPosition
Public CurrentSpeed

Public Sub Init(cfg As String)

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.Init (cfg)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.Init
    End If
    
End Sub

Public Sub UpdateNanoStepPositionCounter()

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.UpdateNanoStepPositionCounter
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.UpdateNanoStepPositionCounter
    End If

End Sub

Public Sub GoToPosition(pos)

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.GoToPosition (pos)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.GoToPosition (CSng(pos))
    End If

End Sub

Public Sub MoveTrack(dist)

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.MoveTrack (dist)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.MoveTrack (CSng(dist))
    End If

End Sub

Public Sub MoveTrackWithCallback(dist)

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.MoveTrackWithCallback (dist)
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.MoveTrackWithCallback (CSng(dist))
    End If

End Sub

Public Sub HomeTrack()

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.HomeTrack
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.HomeTrack
    End If
    
End Sub

Public Sub UpdateNanoStepSpeed()

    If NANOSTEPPER_TYPE = 1 Then
        MGNanoStep.UpdateNanoStepSpeed
    ElseIf NANOSTEPPER_TYPE = 2 Then
        ThorlabsNanoStep.UpdateNanoStepSpeed
    End If

End Sub

Public Function GetSmallestNanoStep() As Double

    Dim a As Double

    If NANOSTEPPER_TYPE = 1 Then
        a = MGNanoStep.GetSmallestNanoStep
    ElseIf NANOSTEPPER_TYPE = 2 Then
        a = ThorlabsNanoStep.GetSmallestNanoStep
    End If

    GetSmallestNanoStep = a

End Function
