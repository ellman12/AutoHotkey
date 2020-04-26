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

;************TOTAL POMODOROS************
GUI, OptionsGUI:Font, norm s12
GUI, OptionsGUI:Add, Text, x10 y10,jhjkshdjkshjkdsk
; GUI, OptionsGUI:Add, Edit, x190 y7 w50 vTotalPomStatsEditBox,0

;************TOTAL SHORT BREAKS************
; GUI, OptionsGUI:Add, Text, x10 y40,Total Total Short Breaks:
; GUI, OptionsGUI:Add, Edit, x190 y37 w50 vShBreakStatsEditBox,0

;************TOTAL LONG BREAKS************
; GUI, OptionsGUI:Add, Text, x10 y70,Total Long Breaks:
; GUI, OptionsGUI:Add, Edit, x190 y67 w50 vLoBreakStatsEditBox,0

return ;End of auto-execute.

;*********************LABELS*********************
OptionsGUIGuiClose:
showOptionsGUIToggle := !showOptionsGUIToggle
GUI, OptionsGUI:Hide
return