Attribute VB_Name = "PulseAttenuator"
Sub SetAttenuator(level As Integer, addr As Integer)
    'SendIEEECmd (Str$(ieeeaddr(bxcr)))
    'pause 10 ' just to make sure the boxcar is
    '          ready for instruction
    'SendIEEEdata ("SD=" + Format$(level, "#0"))

    'new code because switch unit runs off DAC
    'Out PIOaddr, (255 - level)

    ' new code (SC) as atten runs off Ians new GPIB device

    ' convert no to Hex using Hex fn
    'MsgBox (Chr$(level))
    
    's = "G" + (Chr$(0)) + (Chr$(level))
    GPIB.send "G" + (Chr$(0)) + (Chr$(level)), addr
    
    'SendIEEECmd "16"
    'SendIEEEdata "G" + (Chr$(0)) + (Chr$(level))
    'frmTrace!mnuAttenuate.Caption = "&Attenuator (" + Format$(level, "#0") + " dB)"
End Sub
