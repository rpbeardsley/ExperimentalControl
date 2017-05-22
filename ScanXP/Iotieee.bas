Attribute VB_Name = "IOTIEEE"
Option Explicit

' IOTIEEE.BAS
'
'   Header for IOTSLPIB, the 32-bit IEEE488 driver DLL.
'
'   IOTech Personal488
'

'' -----------------
'' --- Constants ---
'' -----------------


'Values forTermType argument of Term function
Public Const Termin = 1      'Input Terminator
Public Const termOut = 2     'Output Terminators

'Device handle value meaning "No Device" or "Invalid Device"
Public Const NODEVICE = -1

'Byte value meaning "No Secondary Address"
Public Const NO_SEC_ADDR As Byte = &HFF

'Values for Flag argument of SPollList function
Public Const ALL = -1           'polls all device
Public Const WHILE_SRQ = -2     'poll devices until SRQ becomes unasserted
Public Const UNTIL_RSV = -3     'poll devices until RSV bit is set

'The boolean values as defined in "C"
Private Const CTrue = 1
Private Const CFalse = 0

' ControlLine Codes
Public Const clEOI = &H80          ' EOI  - End or Identify
Public Const clSRQ = &H40          ' SRQ  - Service Request
Public Const clNRFD = &H20         ' NRFD - Not Ready for Data
Public Const clNDAC = &H10         ' NDAC - Not Data Accepted
Public Const clDAV = &H8           ' DAV  - Data Valid
Public Const clATN = &H4           ' ATN  - Attention

'Completion Status Codes
Public Const ccCount = &H1         ' specified number of chars transfered
Public Const ccBuffer = &H2        ' buffer count exhausted
Public Const ccTerm = &H4          ' Terminator character(s) detected
Public Const ccEnd = &H8           ' END signal (EOI) detected
Public Const ccChange = &H10       ' unexpected change of I/O signals
Public Const ccStop = &H20         ' transfer Terminated by program command
Public Const ccDone = &H4000       ' transfer has Terminated
Public Const ccError = &H8000      '

'Arm Condition Codes
Public Const acDigMatch = &H1000   ' The digital match byte was seen.
Public Const acSRQ = &H400         ' The SRQ control line has been asserted.

'The following Arm conditions are no longer supported.  (2000-11-03)
'Public Const acError = &H800       ' A byte was lost during a write operation.
'Public Const acPeripheral = &H200  ' The interface has become a peripheral.
'Public Const acController = &H100  ' The interface has become the active controller.
'Public Const acTrigger = &H80      ' The interface received a device trigger command.
'Public Const acClear = &H40        ' The interface received a device clear command.
'Public Const acTalk = &H20         ' The interface has become a talker.
'Public Const acListen = &H10       ' The interface has become a listener.
'Public Const acIdle = &H8          ' The interface has become neither talker nor listener.
'Public Const acByteIn = &H4        ' The interface has received a byte.
'Public Const acByteOut = &H2       ' The interface has a byte to send out.
'Public Const acChange = &H1        ' The interface's address status has changed.


'Error Codes
'
'  Most functions return -1 to indicate an error.  After an error occurs
'  the function GetError can be called to return an error code and
'  an error description string.

'Most functions return one of these:
Public Const IOT_ERROR = -1                   'Error
Public Const IOT_NO_ERROR = 0                 'OK

'GetError() returns these:
Public Const IOT_NOT_ADDRESSED_LISTEN = 1     'TIME OUT - NOT ADDRESSED TO LISTEN
Public Const IOT_BUFFER_MODE_NOT = 2          'Buffer mode not supported
Public Const IOT_MODE_NOT_SUPPORTED = 3       'SYSTEM ERROR - BUFFER MODE NOT SUPPORTED
Public Const IOT_TIMEOUT_READ = 4             'TIME OUT ERROR ON DATA READ
Public Const IOT_BAD_INTERNAL_MODE = 5        'SYSTEM ERROR - INVALID INTERNAL MODE
Public Const IOT_INVALID_DMA_CHANNEL = 6      'INVALID CHANNEL FOR DMA
Public Const IOT_TIMEOUT_DMA = 7              'TIME OUT ON DMA TRANSFER
Public Const IOT_NOT_ADDRESSED_TO_TALK = 8    'TIME OUT - NOT ADDRESSED TO TALK
Public Const IOT_TIMEOUT_WRITE = 9            'TIME OUT OR BUS ERROR ON WRITE
Public Const IOT_NO_DATA = 10                 'SEQUENCE - NO DATA AVAILABLE
Public Const IOT_DATA_NOT_READ = 11           'SEQUENCE - DATA HAS NOT BEEN READ
Public Const IOT_SE_ONPEN_ON = 12             'System error, on pen is on
Public Const IOT_BAD_ONPEN_INIT = 13          '
Public Const IOT_MEM_BAD = 14                 'SYSTEM ERROR - LIKELY MEMORY CORRUPTION
Public Const IOT_SE_ONPEN_OFF = 15            '
Public Const IOT_BAD_BOARD = 16               'BOARD DOES NOT RESPOND AT SPECIFIED ADDR
Public Const IOT_TIMEOUT_MTA = 17             'TIME OUT ON COMMAND (MTA)
Public Const IOT_TIMEOUT_MLA = 18             'TIME OUT ON COMMAND (MLA)
Public Const IOT_TIMEOUT_LAG = 19             'TIME OUT ON COMMAND (LAG)
Public Const IOT_TIMEOUT_TAG = 20             'TIME OUT ON COMMAND (TAG)
Public Const IOT_TIMEOUT_UNL = 21             'TIME OUT ON COMMAND (UNL)
Public Const IOT_TIMEOUT_UNT = 22             'TIME OUT ON COMMAND (UNT)
Public Const IOT_NOT_SYS_CONTROLLER = 23      'ONLY AVAILABLE TO SYSTEM CONTROLLER
Public Const IOT_BAD_RESPONSE = 24            'RESPONSE MUST BE 0 THROUGH 15
Public Const IOT_NOT_PERIPHERAL = 25          'NOT A PERIPHERAL
Public Const IOT_SE_TINTS_ON = 26             'SYSTEM ERROR - TIMER INTS ALREADY ON
Public Const IOT_SE_TINTS_BAD = 27            'SYSTEM ERROR - INVALID TIMER INIT
Public Const IOT_SE_TINTS_OFF = 28            'SYSTEM ERROR - TIMER INTS ALREADY OFF
Public Const IOT_ADDRESS_REQUIRED = 29        'ADDRESS REQUIRED
Public Const IOT_BAD_TIMEOUT_VALUE = 30       'TIME OUT VALUE MUST BE FROM 0 TO 65535
Public Const IOT_MUSTBE_ADDRESSED_TALK = 31   'MUST BE ADDRESSED TO TALK
Public Const IOT_BAD_VALUE = 32               'VALUE MUST BE BETWEEN 0 AND 255
Public Const IOT_BAD_BASE_ADDRESS = 33        'INVALID BASE ADDRESS
Public Const IOT_BAD_BUS_ADDRESS = 34         'INVALID BUS ADDRESS
Public Const IOT_BAD_DMA_CHANNEL = 35         'BAD DMA CHAN NO. OR DMA NOT ENABLED
Public Const IOT_NOT_TO_PERIPHERAL = 36       'NOT AVAILABLE TO A PERIPHERAL
Public Const IOT_BAD_PRIMARY = 37             'INVALID PRIMARY ADDRESS
Public Const IOT_BAD_SECONDARY = 38           'INVALID SECONDARY ADDRESS
Public Const IOT_BAD_XFER_COUNT = 39          'INVALID - TRANSFER OF ZERO BYTES
Public Const IOT_NOT_LISTENER = 40            'NOT ADDRESSED TO LISTEN
Public Const IOT_SYNTAX_ERROR = 41            'COMMAND SYNTAX ERROR
Public Const IOT_CHANGE_MODE = 42             'UNABLE TO CHANGE MODE AFTER BOOTUP
Public Const IOT_TIMEOUT_ATN = 43             'TIME OUT WAITING FOR ATTENTION
Public Const IOT_DEMO = 44                    'DEMO VERSION - CAPABILITY EXHAUSTED
Public Const IOT_DEMO_ADDRESS = 45            'DEMO VERSION - ONLY ONE ADDRESS
Public Const IOT_OPTION_NOT = 46              'OPTION NOT AVAILABLE
Public Const IOT_BAD_VALUE1 = 47              'VALUE MUST BE BETWEEN 1 AND 8
Public Const IOT_TIMEOUT_CONTROL = 48         'TIME OUT - CONTROL NOT ACCEPTED
Public Const IOT_CANT_ADDRESS_SELF = 49       'UNABLE TO ADDRESS SELF TO TALK OR LISTEN
Public Const IOT_TIMEOUT_COMMAND = 50         'TIME OUT ON COMMAND
Public Const IOT_CANT_DMA_BOUNDARY = 51       'CANNOT DMA ON ODD BOUNDARY
Public Const IOT_BAD_INTERRUPT = 52           'INTERRUPT %d DOES NOT EXIST
Public Const IOT_SHARE_INTERRUPT = 53         'INTERRUPT %d IS NOT SHAREABLE
Public Const IOT_MEMORY_ALLOCATION = 54       'UNABLE TO ALLOCATE DYNAMIC MEMORY FOR INT
Public Const IOT_INTERRUPT_CHAIN = 55         'SHARED INTERRUPT %d CHAIN CORRUPTED
Public Const IOT_MANY_TIMEOUTS = 56           'TOO MANY ACTIVE TIMEOUTS
Public Const IOT_BAD_DEVICE_HANDLE = 57       'INVALID DEVICE HANDLE
Public Const IOT_OUT_OF_HANDLES = 58          'OUT OF DEVICE HANDLES
Public Const IOT_UNKNOWN_DEVICE = 59          'UNKNOWN DEVICE
Public Const IOT_DRIVER_NOT_LOADED = 60       'DRIVER NOT LOADED
Public Const IOT_BAD_DEVICE_LIST = 61         'INVALID LIST OF DEVICE HANDLES
Public Const IOT_BAD_TermS = 62               'INVALID TermINATOR STRUCTURE
Public Const IOT_BAD_DATA_POINTER = 63        'INVALID DATA POINTER
Public Const IOT_BAD_STATUS_POINTER = 64      'INVALID POINTER TO STATUS STRUCTURE
Public Const IOT_BAD_NAME_POINTER = 65        'INVALID NAME POINTER
Public Const IOT_SE_INTERNAL_POINTER = 66     'SYSTEM ERROR - INVALID INTERNAL POINTER
Public Const IOT_BAD_ERROR_STRING = 67        'INVALID STRING FOR ERROR TEXT
Public Const IOT_FIND_ERROR_CODE = 68         'UNABLE TO FIND ERROR CODE REPORTER
Public Const IOT_CANT_XLATE_ERROR = 69        'UNABLE TO TRANSLATE ERROR CODE
Public Const IOT_NO_DMA_CHANNEL = 70          'DMA CHANNEL %d DOES NOT EXIST
Public Const IOT_DMA_CHANNEL_BUSY = 71        'DMA CHANNEL %d NOT AVAILABLE
Public Const IOT_DMA_CHANNEL_USE = 72         'DMA CHANNEL %d ALREADY IN USE
Public Const IOT_MEMORY_ALLOC = 73            'UNABLE TO ALLOCATE MEMORY FOR ASYNCHRONOUS
Public Const IOT_BAD_DOS_DEVICE = 74          'UNKNOWN DOS DEVICE NAME
Public Const IOT_MEMORY_ALLOCATE = 75         'UNABLE TO ALLOCATE MEMORY FOR NEW DEVICE
Public Const IOT_BAD_SLAVE_DEVICE = 76        'UNKNOWN SLAVE DEVICE
Public Const IOT_NO_SLAVE_DEVICE = 77         'SLAVE DEVICE NOT SPECIFIED
Public Const IOT_CREATE_DOS_DEVICE = 78       'UNABLE TO CREATE DOS DEVICE NAME
Public Const IOT_CANT_INIT_DEVICE = 79        'UNABLE TO INITIALIZE DEVICE
Public Const IOT_REMOVE_SLAVE_DEVICE = 80     'ATTEMPTED TO REMOVE SLAVE DEVICE
Public Const IOT_DATA_OVERRUN = 81            'DATA OVERRUN
Public Const IOT_PARITY_ERROR = 82            'PARITY ERROR
Public Const IOT_FRAMING_ERROR = 83           'FRAMING ERROR
Public Const IOT_TIMEOUT_SERIAL = 84          'TIME OUT ON SERIAL COMMUNICATION
Public Const IOT_BAD_PARAMETER = 85           'UNKNOWN PARAMETER OF TYPE %d SPECIFIED
Public Const IOT_BUS_ERROR_LISTEN = 86        'BUS ERROR - NO LISTENERS
Public Const IOT_TIMEOUT_MONITOR = 87         'TIME OUT ON MONITOR DATA
Public Const IOT_BAD_VALUE2 = 88              'INVALID VALUE SPECIFIED
Public Const IOT_NO_Term = 89                 'NO TermINATOR SPECIFIED
Public Const IOT_NOT_8BIT_SLOT = 90           'NOT AVAILABLE IN 8-BIT SLOT
Public Const IOT_MANY_PENDING_EVENTS = 91     'TOO MANY PENDING EVENTS
Public Const IOT_BREAK_ERROR = 92             'BREAK ERROR
Public Const IOT_LINE_CHANGE = 93             'UNEXPECTED CHANGE OF CONTROL LINES
Public Const IOT_TIMEOUT_CTS = 94             'TIMEOUT ON CTS
Public Const IOT_TIMEOUT_DSR = 95             'TIMEOUT ON DSR
Public Const IOT_TIMEOUT_DCD = 96             'TIMEOUT ON DCD
Public Const IOT_EOI_WITHOUT_DATA = 97        'CANNOT SEND EOI WITHOUT DATA
Public Const IOT_ADDRESS_STATUS_CHANGE = 98   'ADDRESS STATUS CHANGE DURING TRANSFER
Public Const IOT_CANT_MAKE_DEVICE = 99        'UNABLE TO MAKE NEW DEVICE
Public Const IOT_NOT_ONE = 100                '0
Public Const IOT_COMMAND_SYNTAX = 101         'COMMAND SYNTAX ERROR
Public Const IOT_OPEN_ERROR = 102             'ERROR OPENING DEVICE
Public Const IOT_DEVICE_LOCKED = 103          'DEVICE %s CURRENTLY LOCKED BY
Public Const IOT_TIMEOUT_NETWORK = 104        'TIMEOUT ON NETWORK COMMUNICATIONS
Public Const IOT_DEVICE_OPEN_ERROR = 105      'ERROR: DEVICE IS NOT OPEN
Public Const IOT_IPX_NOT_LOADED = 106         'IPX IS NOT LOADED
Public Const IOT_INTERFACE_BUSY = 107         'INTERFACE IS BUSY
Public Const IOT_TC_INTERRUPTS = 108          'TIMER/COUNTER REQUIRES INTERRUPTS TO BE CONFIGURED
Public Const IOT_BAD_INTERRUPT_LEVEL = 109    'INVALID INTERRUPT LEVEL
Public Const IOT_REMOVE_DOS_NAME = 110        'MUST REMOVE DOS NAME FIRST
Public Const IOT_NO_WINDOW_TIMER = 111        'NO WINDOWS TIMERS AVAILABLE
Public Const IOT_OBSOLETE = 112               'Obsolete library function

'' --- 16-bit thunking layer error messages ---
Public Const IOT_THUNK_PROCADDR = 113         'Unable to get procedure address.
Public Const IOT_THUNK_MALLOC = 114           'Memory allocation error.
Public Const IOT_THUNK_BADPTR_RD = 115        'Function argument is bad read pointer.
Public Const IOT_THUNK_BADPTR_WT = 116        'Function argument is bad write pointer.
Public Const IOT_THUNK_OTHER = 117            'Other thunking-layer error.

'' --------------------------------------------

Public Const IOT_DEVICE_ALREADY_OPEN = 118    'The named device is already open.
Public Const IOT_BAD_RESALLOC = 119           'Invalid system resource settings.
Public Const IOT_PNP_NO_HARDWARE = 120        'Interface name not assigned to interface hardware.


'' -------------
'' --- Types ---
'' -------------

'' Interface status structure.  Used by the Status function to return
'' information about the current status of an interface.
Type IeeeStatusT
   reserved0 As Long  ' reserved
   reserved1 As Long  ' reserved
   srq As Long        ' (BOOL) TRUE: the SRQ line is asserted.
   reserved2 As Long  ' reserved
   reserved3 As Long  ' reserved
   reserved4 As Long  ' reserved
   reserved5 As Long  ' reserved
   reserved6 As Long  ' reserved
   reserved7 As Long  ' reserved
   reserved8 As Long  ' reserved
   reserved9 As Long  ' reserved
   PrimAddr As Byte   ' Interface's primary bus address
   reservedA As Byte  ' reserved
End Type


'Termination structure type.
Type TermT
   eoi       As Long  '(BOOL) TRUE: Enables EOI (End or Identify)
   EightBits As Long  '       reserved
   nChar     As Long  '       Number of termination characters
   Term1     As Byte  '       First termination character value.  (e.g. 0x13)
   Term2     As Byte  '       Second termination character value.  (e.g. 0x10)
End Type



' -----------------
' --- Functions ---
' -----------------
'
' NOTE: Many of the function below take "devHandle" as their first argument,
'   which is a device handle.  A device handle can refer to either an interface
'   or a device on the bus.  They are returned by calls to OpenName, MakeDevice
'   or MakeNewDevice, and should be closed by a call to ioClose.
'
'   For functions that take "devHandleList" pass the first element of an array
'   of devHandle.  For example for array declared as dim devs(1 to 9) you would
'   pass devs(1) as the first parameter.
''
'' Open / Close Functions
''
Declare Function _
OpenName Lib "IOTSLPIB.DLL" _
    (ByVal devName$) As Long

Declare Function _
ioClose Lib "IOTSLPIB.DLL" Alias "Close" _
    (ByVal devHandle&) As Long

Declare Function _
MakeDevice Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal Name$) As Long
    
Declare Function _
MakeNewDevice Lib "IOTSLPIB.DLL" ( _
    ByVal iName$, ByVal dName$, _
    ByVal primary As Byte, ByVal secondary As Byte, _
    Termin As TermT, termOut As TermT, _
    ByVal TimeOutVal& _
) As Long

''
'' Bus Configuration
''
Declare Function _
KeepDevice Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
RemoveDevice Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

''
'' Error Handling
''
Declare Function _
ioError Lib "IOTSLPIB.DLL" Alias "Error" _
    (ByVal devHandle&, ByVal display&) As Long

Declare Function _
GetError Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal errText$) As Long

Declare Function _
GetErrorList Lib "IOTSLPIB.DLL" _
    (devHandleList&, ByVal errText$, errHandle&) As Long

''
'' Device Configuration and Control
''
Declare Function _
Abort Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long
    
Declare Function _
AutoRemote Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal flag&) As Long
    
Declare Function _
BusAddress Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal primary As Byte, ByVal secondary As Byte) As Long

Declare Function _
ioClear Lib "IOTSLPIB.DLL" Alias "Clear" _
    (ByVal devHandle&) As Long

Declare Function _
ioLocal Lib "IOTSLPIB.DLL" Alias "Local" _
    (ByVal devHandle&) As Long

Declare Function _
Lol Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
Remote Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
ioReset Lib "IOTSLPIB.DLL" Alias "Reset" _
    (ByVal devHandle&) As Long

Declare Function _
term Lib "IOTSLPIB.DLL" _
    Alias "Term" (ByVal devHandle&, pTerm As TermT, ByVal termFlag&) As Long

Declare Function _
timeout Lib "IOTSLPIB.DLL" _
    Alias "TimeOut" (ByVal devHandle&, ByVal millisec&) As Long

Declare Function _
Trigger Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long


Declare Function _
ClearList Lib "IOTSLPIB.DLL" _
    (devHandleList&) As Long

Declare Function _
LocalList Lib "IOTSLPIB.DLL" _
    (devHandleList&) As Long

Declare Function _
RemoteList Lib "IOTSLPIB.DLL" _
    (devHandleList&) As Long

Declare Function _
TriggerList Lib "IOTSLPIB.DLL" _
    (devHandleList&) As Long


''
'' Device Information and Status
''
Declare Function _
CheckListener Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal primary As Byte, ByVal secondary As Byte) As Long

'listener - the first element in an array of integers, e.g. list(0)
'limit    - the number of elements in the array
Declare Function _
FindListeners Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal primary As Byte, _
    listener%, ByVal limit&) As Long

Declare Function _
Hello Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal mesage$) As Long

Declare Function _
status Lib "IOTSLPIB.DLL" _
    Alias "Status" (ByVal devHandle&, status As IeeeStatusT) As Long

'millisec - the timeout value is returned vai this ByRef parameter
Declare Function _
TimeOutQuery Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, millisec&) As Long

'term - the terminator info is returned via this ByRef parameter
Declare Function _
TermQuery Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, term As TermT, ByVal iTermType) As Long

Declare Function _
spoll Lib "IOTSLPIB.DLL" _
    Alias "SPoll" (ByVal devHandle&) As Long

Declare Function _
SPollList Lib "IOTSLPIB.DLL" _
    (devHandleList&, result As Byte, ByVal flag As Byte) As Long

Declare Function _
ppoll Lib "IOTSLPIB.DLL" _
    Alias "PPoll" (ByVal devHandle&) As Long

Declare Function _
PpollConfig Lib "IOTSLPIB.DLL" _
    Alias "PPollConfig" (ByVal devHandle&, ByVal ppresponse As Byte) As Long

Declare Function _
PpollUnconfig Lib "IOTSLPIB.DLL" _
    Alias "PPollUnconfig" (ByVal devHandle&) As Long

Declare Function _
PPollDisable Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
PPollDisableList Lib "IOTSLPIB.DLL" _
    (devHandleList&) As Long


''
'' Input / Output
''

'EnterX function for use with string buffers.
Declare Function _
EnterXdll Lib "IOTSLPIB.DLL" Alias "EnterX" _
    (ByVal devHandle&, ByVal dat$, ByVal count&, ByVal forceAddress&, _
    term As Any, ByVal async&, compStat&) As Long

'EnterX function for any data buffer type.  (NOTE: Pass strings ByVal)
Declare Function _
EnterXBdll Lib "IOTSLPIB.DLL" Alias "EnterX" _
        (ByVal devHandle&, dat As Any, ByVal count&, ByVal forceAddress&, _
    term As Any, ByVal async&, compStat&) As Long

'OutputX function for use with string buffers.
Declare Function _
OutputXdll Lib "IOTSLPIB.DLL" Alias "OutputX" _
        (ByVal devHandle&, ByVal dat$, ByVal count&, ByVal last&, ByVal forceAddress&, _
    term As Any, ByVal async&, compStat&) As Long
     
'OutputX function for any data type.   (NOTE: Pass strings ByVal)
Declare Function _
OutputXBdll Lib "IOTSLPIB.DLL" Alias "OutputX" _
    (ByVal devHandle&, dat As Any, ByVal count&, ByVal last&, ByVal forceAddress&, _
    term As Any, ByVal async&, compStat&) As Long
     
''
'' OnEvent Functions
''
Declare Function _
Arm Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal armcond%) As Long

Declare Function _
Disarm Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal armcond%) As Long


Declare Function _
OnEvent Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal hwnd&, ByVal lParam&) As Long

'func - pointer to a function declared as:
'       Sub OnEventCallback(ByVal devHandle&, ByVal mask&).
'Note: Function pointers are not supported prior to VB5.
Declare Function _
OnEventVDM Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal func&) As Long

'pdwStatus - pointer to a DWORD value to receive status
'            when the event occurs.  The buffer passed here
'            must persist for as long as events are enabled.
Declare Function _
OnEventSetup Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal uWMID&, pdwStatus&) As Long
   
''
'' Digital I/O Support
''
Declare Function _
DigRead Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
DigWrite Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal byDigData As Byte) As Long

'bLowOut, bHighOut - "C" boolean values: 0 = FALSE, non-zero = TRUE
Declare Function _
DigSetup Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal bLowOut As Long, ByVal bHighOut As Long) As Long

Declare Function _
DigArm Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal bArm As Long) As Long

Declare Function _
DigArmSetup Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal byMatchValue As Byte) As Long

Declare Function _
OnDigEvent Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal hwnd&, ByVal lParam&) As Long

'func - pointer to a function declared as:
'       Sub FuncName(ByVal devHandle&, Byval lParam&).
'Note: Function pointers are not supported prior to VB5.
Declare Function _
OnDigEventVDM Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal func As Long, ByVal lParam&) As Long

''
'' Low-Level Bus Control
''
Declare Function _
ControlLine Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long
    

Declare Function _
Listen Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal primary As Byte, ByVal secondary As Byte) As Long

Declare Function _
Talk Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, ByVal primary As Byte, ByVal secondary As Byte) As Long

Declare Function _
MyListenAddr Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
MyTalkAddr Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
UnListen Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
UnTalk Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&) As Long

Declare Function _
SendCmd Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, commands() As Byte, ByVal count&) As Long

Declare Function _
SendData Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, data() As Byte, ByVal count&) As Long

Declare Function _
SendEoi Lib "IOTSLPIB.DLL" _
    (ByVal devHandle&, data() As Byte, ByVal count&) As Long

    
' * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
'
' Obsolete library calls
'
' - For compatibility with pre-existing programs these functions still
'   exist in IOTSLPIB.DLL, but now they return IOT_ERROR (-1) and set the
'   Driver488 error code to IOT_OBSOLETE.  Any source code files that use
'   these functions will have to be edited before re-compilation.
'
' * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
'
'Declare Function _
'PassControl Lib "IOTSLPIB.DLL" _
'    (ByVal devHandle&) As Long
'
'Declare Function _
'Request Lib "IOTSLPIB.DLL" _
'    (ByVal devHandle&, ByVal spstatus As Byte) As Long
'
'Declare Function _
'Buffered Lib "IOTSLPIB.DLL" _
'    (ByVal dh&) As Long
'
'Declare Function _
'Finish Lib "IOTSLPIB.DLL" _
'    (ByVal devHandle&) As Long
'
'Declare Function _
'ioResume Lib "IOTSLPIB.DLL" Alias "Resume" _
'    (ByVal devHandle&, ByVal monitor%) As Long
'
'Declare Function _
'ioStop Lib "IOTSLPIB.DLL" Alias "Stop" _
'    (ByVal dh&) As Long
'
'Declare Function _
'ioWait Lib "IOTSLPIB.DLL" Alias "Wait" _
'    (ByVal dh&) As Long


' Short forms of the EnterX and OutputX functions.  The "I" versions take
' an integer array as the data buffer.  The Non-I version take a string as
' the data buffer.
'
' Enter      - read character data until a terminator is detected
' EnterN     - read up to N bytes of character data or until a terminator is detected
' EnterMore  - like Enter, but does not force the bus to be addressed
' EnterNMore - like EnterN, but does not force the bus to be addressed
'
' Output      - write the given string, with default terminators
' OutputN     - write the first N characters of the string, no terminators
' OutputMore  - like Output, but does not force the bus to be addressed
' OutputNMore - like OutputN, but does not force the bus to be addressed
'
' Note: "dh" is used below as a short-hand for the device handle (devHandle)
'
Public Function enter&(dh&, dat$):                  enter = EX(dh, dat, Len(dat)):                       End Function
Public Function EnterN&(dh&, dat$, count&):         EnterN = EX(dh, dat, count):                         End Function
Public Function EnterMore&(dh&, dat$):              EnterMore = EX(dh, dat, Len(dat), False):            End Function
Public Function EnterNMore&(dh&, dat$, count&):     EnterNMore = EX(dh, dat, count, False):              End Function

Public Function EnterI&(dh&, dat%()):               EnterI = EXI(dh, dat, SizeOf(dat)):                  End Function
Public Function EnterNI&(dh&, dat%(), count&):      EnterNI = EXI(dh, dat, count):                       End Function
Public Function EnterMoreI&(dh&, dat%()):           EnterMoreI = EXI(dh, dat, SizeOf(dat), False):       End Function
Public Function EnterNMoreI&(dh&, dat%(), count&):  EnterNMoreI = EXI(dh, dat, count, False):            End Function

Public Function Output&(dh&, dat$):                 Output = OX(dh, dat, Len(dat)):                      End Function
Public Function OutputN&(dh&, dat$, count&):        OutputN = OX(dh, dat, count, False):                 End Function
Public Function OutputMore&(dh&, dat$):             OutputMore = OX(dh, dat, Len(dat), True, False):     End Function
Public Function OutputNMore&(dh&, dat$, count&):    OutputNMore = OX(dh, dat, count, False, False):      End Function

Public Function OutputI&(dh&, dat%()):              OutputI = OXI(dh, dat, SizeOf(dat)):                  End Function
Public Function OutputNI&(dh&, dat%(), count&):     OutputNI = OXI(dh, dat, count, False):               End Function
Public Function OutputMoreI&(dh&, dat%()):          OutputMoreI = OXI(dh, dat, SizeOf(dat), True, False): End Function
Public Function OutputNMoreI&(dh&, dat%(), count&): OutputNMoreI = OXI(dh, dat, count, False, False):    End Function

'
' The following functions are used to implement the short forms of EnterX and
' OutputX given above.  They should not be considered part of the IEEE488 library
' interface.
'
' Several of the function arguments are optional and can be omitted.  Only the
' device handle, data buffer and count are required.  All the rest are optional
' with the following defaults:
'
'   last        : TRUE  (Outputs only, issue terminators with the transaction)
'   forceAddress: TRUE  (force the bus to be addressed)
'   async       : FALSE (function does not return until transaction completes)
'   compStat    : 0     (do not return completion status)
'
' NOTES:
'  - The Term argument is omitted.  A 0 is always passed to the DLL
'    for this argument which selects the default terminator setup.  You must
'    use the DLL calls (EnterX or Output) if you need to pass a terminator structure.
'
'  - These functions are declared private, meaning they can only be accessed
'    by functions within this module.
'

'EnterX with a string-type data buffer, optional arguments, no Term argument.
Private Function EX&(devHandle&, dat$, ByVal count&, _
    Optional forceAddress As Variant, _
    Optional async As Variant, _
    Optional compStat As Variant)
    
    'forceAddress is TRUE by default
    Dim bForceAddr&: If IsMissing(forceAddress) Then _
        bForceAddr = CTrue Else bForceAddr = IIf(forceAddress, CTrue, CFalse)
        
    'async is FALSE by default
    Dim bAsync As Boolean: If IsMissing(async) Then _
        bAsync = CFalse Else bAsync = IIf(async, CTrue, CFalse)
        
    'compStat is a DWORD
    Dim lCompStat&
    
    'DLL call that always passes a NULL pointer for the Term structure.
    EX = EnterXdll(devHandle, ByVal dat, count, bForceAddr, ByVal 0&, bAsync, lCompStat)
        
    'Return the completion status to the caller's buffer, if supplied.
    If Not IsMissing(compStat) Then compStat = lCompStat
    
End Function

'EnterX with integer array data buffer, optional arguments, no Term argument.
Private Function EXI&(devHandle&, dat() As Integer, count&, _
    Optional forceAddress As Variant, _
    Optional async As Variant, _
    Optional compStat As Variant)
    
    'forceAddress is TRUE by default
    Dim bForceAddr&: If IsMissing(forceAddress) Then _
        bForceAddr = CTrue Else bForceAddr = IIf(forceAddress, CTrue, CFalse)
        
    'async is FALSE by default
    Dim bAsync As Boolean: If IsMissing(async) Then _
        bAsync = CFalse Else bAsync = IIf(async, CTrue, CFalse)
        
    'compStat is a DWORD
    Dim lCompStat&
    
    'DLL call that always passes a NULL pointer for the Term structure.
    EXI = EnterXBdll(devHandle, dat(LBound(dat)), count, bForceAddr, ByVal 0&, bAsync, lCompStat)
        
    'Return the completion status to the caller's buffer, if supplied.
    If Not IsMissing(compStat) Then compStat = lCompStat
    
End Function

'OutputX with a string-type data buffer, optional arguments, no Term argument.
Private Function OX&(devHandle&, dat$, count&, _
    Optional last As Variant, _
    Optional forceAddress As Variant, _
    Optional async As Variant, _
    Optional compStat As Variant)
    
    'last is TRUE by default
    Dim bLast&: If IsMissing(last) Then _
        bLast = CTrue Else bLast = IIf(last, CTrue, CFalse)
        
    'forceAddress is TRUE by default
    Dim bForceAddr&: If IsMissing(forceAddress) Then _
        bForceAddr = CTrue Else bForceAddr = IIf(forceAddress, CTrue, CFalse)
        
    'async is FALSE by default
    Dim bAsync As Boolean: If IsMissing(async) Then _
        bAsync = CFalse Else bAsync = IIf(async, CTrue, CFalse)
        
    'compStat is a DWORD
    Dim lCompStat&
    
    'This call always passes a NULL pointer for the terminator structure.
    OX = OutputXdll(devHandle, ByVal dat, count, bLast, bForceAddr, ByVal 0&, bAsync, lCompStat)
        
    'Return the completion status to the caller's buffer, if supplied.
    If Not IsMissing(compStat) Then compStat = lCompStat
    
End Function

'OutputX with integer array data buffer, optional arguments, no Term argument.
Private Function OXI&(devHandle&, dat() As Integer, count&, _
    Optional last As Variant, _
    Optional forceAddress As Variant, _
    Optional async As Variant, _
    Optional compStat As Variant)
    
    'last is TRUE by default
    Dim bLast&: If IsMissing(last) Then _
        bLast = CTrue Else bLast = IIf(last, CTrue, CFalse)
        
    'forceAddress is TRUE by default
    Dim bForceAddr&: If IsMissing(forceAddress) Then _
        bForceAddr = CTrue Else bForceAddr = IIf(forceAddress, CTrue, CFalse)
        
    'async is FALSE by default
    Dim bAsync As Boolean: If IsMissing(async) Then _
        bAsync = CFalse Else bAsync = IIf(async, CTrue, CFalse)
        
    'compStat is a DWORD
    Dim lCompStat&
    
    'This call always passes a NULL pointer for the terminator structure.
    OXI = OutputXBdll(devHandle, dat(LBound(dat)), count, bLast, bForceAddr, ByVal 0&, bAsync, lCompStat)
        
    'Return the completion status to the caller's buffer, if supplied.
    If Not IsMissing(compStat) Then compStat = lCompStat
    
End Function

'Generic function for determing the size in memory of a value or array.
Private Function SizeOf(V As Variant)
    Dim siz&: siz = 0
    On Error GoTo Out
    If 0 <> (VarType(V) And vbArray) Then
        siz = Len(V(0)) * (UBound(V) - LBound(V) + 1)
    Else
        siz = Len(V)
    End If
Out:
  SizeOf = siz
End Function


