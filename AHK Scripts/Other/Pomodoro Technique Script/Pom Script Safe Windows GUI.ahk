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
;Make the GUI (and then make it AlwaysOnTop).
GUI, SafeWinsGUI:New
GUI, SafeWinsGUI:+AlwaysOnTop

GUI, SafeWinsGUI:Font, norm S12
GUI, SafeWinsGUI:Add, Text, x3 y4, Ctrl + F11: Add Windows

;Delete button.
GUI, SafeWinsGUI:Font, norm S10
GUI, SafeWinsGUI:Add, Button, x3 y27 w192 gDeleteButton, Delete Selected Item

;ListView.
GUI, SafeWinsGUI:Font, norm S9           ;Display ↓ grid; ↓ can't move headers around (but can resize).
GUI, SafeWinsGUI:Add, ListView, x4 y58 w190 h205 Grid -LV0x10, Title|ID

;Icons.
SafeWinsImageListID := IL_Create() ;Initially create an ImageList to store icons in. It grows automatically.
LV_SetImageList(SafeWinsImageListID) ;sets the image list for the ListView to use the ImageList created in the line above

;Set column widths.
LV_ModifyCol(1, 160) ;Title.
LV_ModifyCol(2, 30) ;ID.