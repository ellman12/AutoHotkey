﻿;OPTIMIZATIONS START
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

;consider removing these optimizations, but only if this thing is used in Main.

;This script is the profile used for games.
;As of right now, it's just used for DOOM.
;TODO https://www.autohotkey.com/docs/commands/GuiControls.htm#Hotkey

;****************************************MOUSE ACTIONS***************************************

#If currentProfile = "DOOM"
;Mouse Profile Switch
^!F23::
return

;Mouse DPI Toggle
^+F23::
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
F23::
return

;Mouse G12
+F23::
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
!F23::
return

;Keeb G13
!F13::
return

;Keeb G14
!F14::
return

;Keeb G15
!F15::
return

;Keeb G16
!F16::
return

;Keeb G17
!F17::
return

;Keeb G18
!F18::
return

#If