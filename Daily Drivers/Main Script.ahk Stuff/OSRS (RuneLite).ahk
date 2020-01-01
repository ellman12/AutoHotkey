#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the OSRS (RuneLite) profile.
;This script is a copy-and-paste of the old iCUE profile.

;****************************************MOUSE ACTIONS***************************************

#If current_profile = "OSRS"
;Mouse Profile Switch
^!F23::
return

;Mouse DPI Toggle
^!F24::
return

;Mouse G1
;G1 to 1 (for talking to NPCs)
F13::
Send, 1
return

;Mouse G2
;G2 to 2 (for talking to NPCs)
F14::
Send, 2
return

;Mouse G3
;G3 to 3 (for talking to NPCs)
F15::
Send, 3
return

;Mouse G4
;Ctrl +  Left Click (sprint to that point).
F16::
Send, ^{Click}
return

;Mouse G5
;G5 to Middle Mouse Button
;Where I found this: https://autohotkey.com/board/topic/97983-how-to-hold-mouse-middle-mouse-button-down-keyboard-key/
F17::
While (Getkeystate("F17","P"))
{   Send, {MButton down}
    sleep 100
}
Send, {MButton up}
Sleep 100
return

;Mouse G6
;G6 to Space Bar (for Click here to continue)
F18::
Send, {Space}
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
F23::
return

;Mouse G12
F24::
return

;****************************************KEYBOARD ACTIONS***************************************
;Keeb G1
;Open OSRS wiki
^F13::
Run, https://oldschool.runescape.wiki/
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

#If