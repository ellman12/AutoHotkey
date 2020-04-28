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
DetectHiddenWindows, Off
#SingleInstance force
;OPTIMIZATIONS END

;This script is part of the main Pomodoro Technique Script.
;This is for the options GUI, that's it.
;This is to help keep the main file from becoming a cluttered mess.

;******************GUI INITIALIZATION******************
GUI, OptionsGUI:+AlwaysOnTop

;************POMODORO LENGTH************
GUI, OptionsGUI:Font, norm s12
GUI, OptionsGUI:Add, Text, x10 y10,Pomodoro Length:
GUI, OptionsGUI:Add, Edit, x135 y7 w50 vPomLengthEditBox,