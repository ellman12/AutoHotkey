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

; ;******************GUI INITIALIZATION******************
; GUI, SafeWinsGUI:+AlwaysOnTop
; ; GUI, SafeWinsGUI:Show, x1460 w283 h340, Safe Windows

; GUI, SafeWinsGUI:Font, norm S12
; GUI, SafeWinsGUI:Add, Text, x4 y10,Safe Windows

; GUI, SafeWinsGUI:Font, norm S9                   ;Display grid; can't move headers around.
; GUI, SafeWinsGUI:Add, ListView, r15 x4 y34 w275 Grid -LV0x10, Title|ID|Array Index

gui, add, ListView,, Title|Window ID
ImageListID := IL_Create() ;Initially create an ImageList to store icons in. It grows automatically.
LV_SetImageList(ImageListID) ;sets the image list for the listview to use the ImageList created in the line above
gui, show, w300 h300, Pom
GUI, +AlwaysOnTop
return


^F11::

;get active window's title and ID
WinGetActiveTitle, WindowTitle
WinGet, WindowID, ID, A

;Get the icon of the program
WInGet, ProcessPathVar, ProcessPath, A

;Put the Icon of the program into the ImageList for use with the list
IL_Add(ImageListID, ProcessPathVar)

;add title and ID to the ListView, add the Icon using the option "Icon1" "Icon2" etc. Icon number is defined by "LV_GetCount() + 1" which gets the number of rows in before adding and adds one.
LV_Add("Icon" LV_GetCount() + 1, WindowTitle, WindowID)
; LV_ModifyCol()

;refresh the gui to refresh the listview - maybe there's a better way of doing this
gui, show
return