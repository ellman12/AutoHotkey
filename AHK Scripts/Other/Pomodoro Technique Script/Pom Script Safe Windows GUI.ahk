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
;This is for the safe windows GUI, that's it.
;This is to help keep the main file from becoming a cluttered mess.

;******************GUI INITIALIZATION******************
GUI, SafeWinsGUI:+AlwaysOnTop
; GUI, SafeWinsGUI:Show, x1460 w283 h340, Safe Windows

GUI, SafeWinsGUI:Font, norm S12
GUI, SafeWinsGUI:Add, Text, x4 y10,Safe Windows

GUI, SafeWinsGUI:Font, norm S9                   ;Display grid; can't move headers around.
GUI, SafeWinsGUI:Add, ListView, r15 x4 y34 w275 Grid -LV0x10, Title|ID|Array Index