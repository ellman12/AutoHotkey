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
GUI, SafeWinsGUI:Show, x1460 w283 h340, Safe Windows

GUI, SafeWinsGUI:Font, norm S12
GUI, SafeWinsGUI:Add, Text, x4 y10,Safe Windows
; GUI, SafeWinsGUI:Add, ListView, x10 y35,Safe Windows

GUI, SafeWinsGUI:Font, norm S9                   ;Display grid; can't move headers around.
GUI, SafeWinsGUI:Add, ListView, x4 y34 w275 Grid -LV0x10, Icon|Title|ID|Array Index

ImageListID := IL_Create(10)


ImageListID := IL_Create(10)  ; Create an ImageList to hold 10 small icons.
LV_SetImageList(ImageListID)  ; Assign the above ImageList to the current ListView.
Loop 10  ; Load the ImageList with a series of icons from the DLL.
    IL_Add(ImageListID, "shell32.dll", A_Index) 
Loop 10  ; Add rows to the ListView (for demonstration purposes, one for each icon).
    LV_Add("Icon" . A_Index, A_Index, "n/a")
LV_ModifyCol("Hdr")  ; Auto-adjust the column widths.


return