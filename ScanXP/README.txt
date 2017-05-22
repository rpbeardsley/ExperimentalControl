Things you have to install
--------------------------
Eclipse Software - Install CD

Melles Griot Software - Install CAN Card driver from CD1 (file named setup), install card, Put in dongle, Switch on - Windows will auto-detect and install 
In device manager go to National Instruments PCI-CAN properties
In Settings tab put Name: CAN0
Run NI-CAN diagnostics from start menu
Select CAN0 and run 'test one'
Put in CD2 (The nanopositioning stage CD)
Run CDROM/Hardlock/dk12wn32.exe
Reboot
Run CDROM/Melhost V5.4.x/Setup.exe - follow instructions
Reboot
Run Modular Electronics Host Configuration Utility to check communications


GPIB card software
------------------
National Instruments GPIB Card Software - Install CD
Keithley CEC GPIB Cards - Get software version 8.2 from their website and install. Does ISA/PCI/USB and all operating system versions


Digital Signal Averager Interface DLL - Copy scan97.dll to C:\windows\system32
(The source files for compiling this are in the 'Digitiser DLL' directory. Open with Microsoft VC++ 4.0)

VB4 for Graph32.ocx graphics control - Install CD, use custom install and only install the Custom Controls
THEN
VB5CCE to properly register VB5 components - Install EXE file
THEN
COpy accross VB5 Learning Edition into Program Files directiory

Device Driver for user-mode access to ports (usually forbidden in windows NT based Operating systems leading to a program halt)
Copy giveio.sys to c:\windows\system32
Go to the directory with instdrv.exe in it and type "instdrv giveio c:\windows\system32\giveio.sys"
Reboot
Run Device Manager
Show Hidden Devices
Find giveio under non-plug&play drivers and select properties
Go to driver tab and select automatic
Reboot

User Level
----------
Globals.bas - User defined settings




Multi-Device Layer
------------------
(These have code that points job requests to the right card. e.g. there may be two modules
for sending IEEE488 data on two different cards. A module in this layer provides a function
which decides which card is the one in the machine and then invokes the function in the
appropriate module)

GPIB.bas - Calls for doing IEEE488 related things (these then call functions in NI144_2.bas or whichever is the right module for the card in the machine)



Device-layer
------------
(Provide simple calls for doing jobs on a particular device e.g. send data on the NI488 GPIB card)

NI144_2.bas - Simple calls for doing jobs on the NI488 GPIB-PCI Card
SRS830.bas - functions for setting things on the SRS830 Lock-in Amplifier
NanoStep - The Melles-Griot Nanopositioning stage and rack


API Level
----------

Niglobal.bas - Supplied with National Instruments NI-488.2 GPIB-PCI Card - API level
Vbib-32.bas - Supplied with National Instruments NI-488.2 GPIB-PCI Card - API level
NSDriver.bas - Melles Griot Nanopositioning stage routines
NSUtils - Melles Griot Nanopositioning stage routines
RackDriver.bas - Melles Griot Nanopositioning stage routines
RackUtils.bas - Melles Griot Nanopositioning stage routines
Ieeevb.bas - GPIB Routines for Keithley CEC IEEE 488 Cards. Get driver version 8.2 from their website.


Acknowledgements
----------------
