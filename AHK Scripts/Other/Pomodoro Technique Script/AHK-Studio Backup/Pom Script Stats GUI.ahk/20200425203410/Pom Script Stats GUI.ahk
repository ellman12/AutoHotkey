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
;This is for the stats GUI, that's it.
;This is to help keep the main file from becoming a cluttered mess.

;******************GUI INITIALIZATION******************
GUI, StatsGUI:+AlwaysOnTop



return ;End of auto-execute.

;*********************LABELS*********************
StatsGUIGuiClose:
GUI, StatsGUI:Flash
GUI, StatsGUI:Hide
return