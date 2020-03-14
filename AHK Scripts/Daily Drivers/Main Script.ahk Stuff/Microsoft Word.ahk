;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
#SingleInstance force
;OPTIMIZATIONS END

;This script is the Microsoft Word profile.


;****************************************MOUSE ACTIONS***************************************

#If currentProfile = "MSWord"
;Mouse Profile Switch
^!F23::
return

;Mouse DPI Toggle
^!F24::
return

;Mouse G1
F13::
return

;Mouse G2
F14::
return

;Mouse G3
F15::
return

;Mouse G4
F16::
return

;Mouse G5
F17::
return

;Mouse G6
F18::
return

;Mouse G7
F19::
return

;Mouse G8
F20::
return

;Mouse G9
F21::
return

;Mouse G10
F22::
return

;Mouse G11
;Pushing F23 (G11) minimizes the current active window
F23::
WinMinimize, A
return

;Mouse G12
F24::
return

;****************************************KEYBOARD ACTIONS***************************************
;Keeb G1
^F13::
return

;Keeb G2
^F14::
return

;Keeb G3
^F15::
return

;Keeb G4
^F16::
return

;Keeb G5
^F17::
return

;Keeb G6
^F18::
return

;Keeb G7
^F19::
return

;Keeb G8
^F20::
return

;Keeb G9
^F21::
return

;Keeb G10
^F22::
return

;Keeb G11
^F23::
return

;Keeb G12
^F24::
return

;Keeb G13
;Closes a virtual desktop
!F13::
Send, ^#{F4}
return

;Keeb G14
;Creates a virtual desktop
!F14::
Send, ^#{d}
return

;Keeb G15
!F15::
return

;Keeb G16
;Does what Win + Tab does
!F16::
Send, #{Tab}
return

;Keeb G17
;Goes to the virtual desktop to the left
!F17::
Send, ^#{Left}
return

;Keeb G18
;Goes to the virtual desktop to the right
!F18::
Send, ^#{Right}
return

;****************************************MISC MSWORD ACTIONS***************************************
;(Ctrl + Backspace) Delete an entire word.
\::
Send, ^+{Left}
Send, {BackSpace}
return

;(Ctrl + S) save document.
F5::
Send, ^s
return

#If