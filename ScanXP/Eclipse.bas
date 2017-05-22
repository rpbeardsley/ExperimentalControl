Attribute VB_Name = "Eclipse"
  Private EclipseXData() As Double
  Private EclipseYData() As Double
  Private GettingDataStatus As Integer

  Private Const STARTF_USESHOWWINDOW As Long = &H1&
  Private Const STARTF_USESIZE As Long = &H2&
  Private Const STARTF_USEPOSITION As Long = &H4&
  Private Const STARTF_USECOUNTCHARS As Long = &H8&
  Private Const STARTF_USEFILLATTRIBUTE As Long = &H10&
  Private Const STARTF_RUNFULLSCREEN As Long = &H20&       '  ignored for non-x86 platforms
  Private Const STARTF_FORCEONFEEDBACK As Long = &H40&
  Private Const STARTF_FORCEOFFFEEDBACK As Long = &H80&
  Private Const STARTF_USESTDHANDLES As Long = &H100&

  ' ShowWindow() Commands
  Private Const SW_HIDE = 0
  Private Const SW_SHOWNORMAL = 1
  Private Const SW_NORMAL = 1
  Private Const SW_SHOWMINIMIZED = 2
  Private Const SW_SHOWMAXIMIZED = 3
  Private Const SW_MAXIMIZE = 3
  Private Const SW_SHOWNOACTIVATE = 4
  Private Const SW_SHOW = 5
  Private Const SW_MINIMIZE = 6
  Private Const SW_SHOWMINNOACTIVE = 7
  Private Const SW_SHOWNA = 8
  Private Const SW_RESTORE = 9
  Private Const SW_SHOWDEFAULT = 10
  Private Const SW_MAX = 10

Public Type COPYDATASTRUCT
    dwData As Long
    cbData As Long
    lpData As Long
End Type

  Private Type STARTUPINFO
    cb As Long
    lpReserved As Long
    lpDesktop As Long
    lpTitle As String
    dwX As Long
    dwY As Long
    dwXSize As Long
    dwYSize As Long
    dwXCountChars As Long
    dwYCountChars As Long
    dwFillAttribute As Long
    dwFlags As Long
    wShowWindow As Integer
    cbReserved2 As Integer
    lpReserved2 As Long
    hStdInput As Long
    hStdOutput As Long
    hStdError As Long
  End Type

  Private Type PROCESS_INFORMATION
    hProcess As Long
    hThread As Long
    dwProcessId As Long
    dwThreadId As Long
  End Type

'  dwCreationFlag values  CREATE_NEW_PROCESS_GROUP
  Private Const CREATE_DEFAULT_ERROR_MODE As Long = &H4000000
  Private Const CREATE_NEW_CONSOLE = &H10
  Private Const CREATE_NEW_PROCESS_GROUP = &H200
  Private Const CREATE_SEPARATE_WOW_VDM As Long = &H800&
  Private Const CREATE_SHARED_WOW_VDM As Long = &H1000&
  Private Const CREATE_SUSPENDED = &H4
  Private Const CREATE_UNICODE_ENVIRONMENT As Long = &H400&
  Private Const DEBUG_PROCESS = &H1
  Private Const DEBUG_ONLY_THIS_PROCESS = &H2
  Private Const DETACHED_PROCESS = &H8

  'Sendmessage constants
  Public Const WM_COMMAND = &H111
  Public Const WM_USER = &H400
  Public Const WM_COPYDATA = &H4A

  'Window hooking constants
  Public Const GWL_WNDPROC = (-4)
  
  Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
  Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long

  Private Declare Function CreateProcess Lib "kernel32" Alias "CreateProcessA" (ByVal lpApplicationName As String, ByVal lpCommandLine As String, ByVal lpProcessAttributes As Long, ByVal lpThreadAttributes As Long, ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, lpEnvironment As Any, ByVal lpCurrentDirectory As String, lpStartupInfo As STARTUPINFO, lpProcessInformation As PROCESS_INFORMATION) As Long
  Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
  Private Declare Function EnumThreadWindows Lib "user32" (ByVal dwThreadId As Long, ByVal lpfn As Long, ByVal lParam As Long) As Long
  Private Declare Function AttachThreadInput Lib "user32" (ByVal idAttach As Long, ByVal idAttachTo As Long, ByVal fAttach As Long) As Long
  Private Declare Function EnableWindow Lib "user32.dll" (ByVal hwnd As Long, ByVal fEnable As Long) As Long
  Private Declare Function GetCurrentThreadId Lib "kernel32" () As Long
  Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
    
  Declare Function GetWindowText Lib "user32.dll" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
  Declare Function GetWindowTextLength Lib "user32.dll" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long

  Public Declare Function GlobalAlloc Lib "kernel32.dll" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
  Public Declare Function GlobalLock Lib "kernel32.dll" (ByVal hMem As Long) As Long
  Public Declare Function GlobalUnlock Lib "kernel32.dll" (ByVal hMem As Long) As Long
  Public Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
  
  Public ClientWindowHandle As Long
  Public lpPrevWndProc As Long
  Public lHwnd         As Long

Public Sub GetEclipseTrace(xdata, ydata)

    Dim success As Long
    Dim hMem As Long
    Dim hLockedMem As Long
      
    success = SendMessage(ClientWindowHandle, 1025, EclipseFrm.hwnd, 0)
    If success = 0 Then GettingDataStatus = 1
    
    t = Timer + 20
    While GettingDataStatus < 3
        DoEvents
        If Timer > t Then MsgBox ("Timeout Waiting for Eclipse to return Y data."): GoTo ext
    Wend


    xdata = EclipseXData
    ydata = EclipseYData
    
ext:

    GettingDataStatus = 0

End Sub

Public Sub Init()

    Dim PI As PROCESS_INFORMATION
    Dim success As Long

    'Create Easyplot Process
    MakeProc PI
    
    t = Timer + 1
    While (Timer < t)
        DoEvents
    Wend
    
    'Enumerate Windows created by process to get thread ID
    success = EnumThreadWindows(PI.dwThreadId, AddressOf EnumThreadWndProc, 0)
    
    If success > 0 Then
        'ClientWindowHandle variable now contains the window handle
        
        'Attach current input thread to Easyplot input thread
        'Attaching input threads lets us send messages to the EasyPlot window
        success = AttachThreadInput(PI.dwThreadId, GetCurrentThreadId, 1)
        success = EnableWindow(ClientWindowHandle, 0)
        
    End If
    
    Load EclipseFrm
    ' Get this form's handle.
    ' Subclass this form to trap Windows messages
    ' so we know when a message is send from the
    ' sending application.
    '
    lHwnd = EclipseFrm.hwnd
    Call pHook
    
    GettingDataStatus = 0

End Sub

Public Function EnumThreadWndProc(ByVal hwnd As Long, ByVal lParam As Long) As Long
  
  Dim txt As String
  Dim lentxt As Long
  
  'This function is called repetetively by windows once EnumThreadWindows has been called and given this function's address
  'It is called once for each window associated with a thread
  'hwnd gives the window's handle, lParam is the value of lParam passed to EnumThreadWindows
  'You should get this function to return zero when you want to stop enumerating windows
  'otherwise it will keep going until there aren't any left.

  'Check text in window title - if this is the one saying "Easyplot" then its the right window!
  lentxt = GetWindowTextLength(hwnd) 'Check length of string
  txt = Space(lentxt + 1) 'Create text buffer of appropriate size
  s = GetWindowText(hwnd, txt, Len(txt)) 'Get window text
  txt = Left(txt, s) 'Extract actual text, minus terminating characters etc
  If Len(txt) >= 18 Then
    If Left(txt, 18) = "Untitled - Eclipse" Then
        ClientWindowHandle = hwnd
        EnumThreadWndProc = 0 'Stop enumerating windows - we've found the right one
    Else
        EnumThreadWndProc = 1
    End If
  Else
    EnumThreadWndProc = 1
  End If

End Function
Public Function MakeProc(ByRef PI As PROCESS_INFORMATION)

    Dim i As Long
    Dim sGetEnvVar As Long
    Dim asEnvString() As String
    Dim sExePath As String
    Dim SI As STARTUPINFO

  
    SI.cb = Len(SI)
    SI.lpTitle = vbNullChar
    SI.dwFlags = STARTF_USESHOWWINDOW
    SI.wShowWindow = SW_SHOWDEFAULT
  
    'Pass any environment variables
    ' IMPORTANT NOTE:  according to the Win32 SDK documentation, the environment
    ' variables that are passed to the child process must be in alphabetical order
    ' (case insensitive).
    'sGetEnvVar = sGetEnvVar & env_variable1$ & vbNullChar
    'sGetEnvVar = sGetEnvVar & env_variable2$ & vbNullChar
    '.
    '.
    'sGetEnvVar = sGetEnvVar & vbNullChar & vbNullChar
    
    exec = ECLIPSE_PROG_PATH
    H = CreateProcess(vbNullString, exec, 0, 0, 0, DETACHED_PROCESS, ByVal StrPtr(sGetEnvVar), App.Path, SI, PI)
    

End Function

Public Sub pHook()
'
' Sub class the form to trap for Windows messages.
'
lpPrevWndProc = SetWindowLong(lHwnd, GWL_WNDPROC, AddressOf fWindowProc)

End Sub
Sub pReceiveMsg(lParam As Long)

    Dim sString       As String
    Dim l             As Long
    Dim lnumEls       As Long
    Dim bfailed       As Boolean
    Dim pb            As New PropertyBag
    Dim cds           As COPYDATASTRUCT
    Dim buf(1 To 255) As Byte
    Dim aDoubles() As Double
    
    If GettingDataStatus = 1 Then
    
        ' Copy the data sent to this application into a local structure.
        Call CopyMemory(cds, ByVal lParam, Len(cds))
        
        'Get the number of items.
        lnumEls = cds.cbData \ 8
                
        ReDim aDoubles(0 To lnumEls - 1) As Double
        Call CopyMemory(aDoubles(0), ByVal cds.lpData, cds.cbData) 'Copy Data into Array
                
        ReDim EclipseXData(0 To (UBound(aDoubles) - LBound(aDoubles)))
        ReDim EclipseYData(0 To (UBound(aDoubles) - LBound(aDoubles)))
        c = 0
        For l = LBound(aDoubles) To UBound(aDoubles)
            EclipseYData(c) = aDoubles(l)
            c = c + 1
        Next
            
        GettingDataStatus = 2
        
    ElseIf GettingDataStatus = 2 Then
    
        ' Copy the data sent to this application into a local structure.
        Call CopyMemory(cds, ByVal lParam, Len(cds))
        
        'Get the number of items.
        lnumEls = cds.cbData \ 8
                
        ReDim aDoubles(0 To lnumEls - 1) As Double
        Call CopyMemory(aDoubles(0), ByVal cds.lpData, cds.cbData) 'Copy Data into Array
                
        c = 0
        For l = LBound(aDoubles) To UBound(aDoubles)
            EclipseXData(c) = aDoubles(l)
            c = c + 1
        Next
            
        GettingDataStatus = 3
        
    End If
    
End Sub
Public Sub pUnhook()
'
' Remove the subclassing.
'
Call SetWindowLong(lHwnd, GWL_WNDPROC, lpPrevWndProc)
End Sub
Function fWindowProc(ByVal hw As Long, ByVal uMsg As Long, _
         ByVal wParam As Long, ByVal lParam As Long) As Long
'
' This callback routine is called by Windows whenever
' a message is sent to this form.  If it is the copy
' message call our procedure to receive the message.
'
If uMsg = WM_COPYDATA Then Call pReceiveMsg(lParam)
'
' Call the original window procedure associated with this form.
'
fWindowProc = CallWindowProc(lpPrevWndProc, hw, uMsg, wParam, lParam)
End Function




