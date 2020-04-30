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

safeWindowTitles := []
safeWindowIDs := []
currentArrayIndex := 1

;******************GUI INITIALIZATION******************
;Make the GUI (and then make it AlwaysOnTop).
GUI, SafeWinsGUI:New
GUI, SafeWinsGUI:+AlwaysOnTop

GUI, SafeWinsGUI:Font, norm S12
GUI, SafeWinsGUI:Add, Text, x4 y4, Ctrl + F11 to add windows to the list.

GUI, SafeWinsGUI:Font, norm S9           ;Display ↓ grid; ↓ can't move headers around (but can resize).
GUI, SafeWinsGUI:Add, ListView, x4 y34 w260 h300 Grid -LV0x10, Title|ID|Array Index

SafeWinsImageListID := IL_Create() ;Initially create an ImageList to store icons in. It grows automatically.
LV_SetImageList(SafeWinsImageListID) ;sets the image list for the ListView to use the ImageList created in the line above

;Set column widths.
LV_ModifyCol(1, 150) ;Title.
LV_ModifyCol(2, 40) ;ID.
LV_ModifyCol(3, 65) ;Array Index.

GUI, SafeWinsGUI:Show, x1460 w270 h340, Safe Windows
return

;Adds windows to the Safe Windows arrays.
^F11::
    ;https://www.autohotkey.com/docs/commands/ListView.htm#BuiltIn
    GUI, SafeWinsGUI:Default

    ;Get the active title, ID, and the window icon.
    WinGetTitle, safeWinsActiveTitle, A
    WinGet, safeWinsActiveID, ID, A
    WInGet, activeWinProcPath, ProcessPath, A

    ;Value to track if ID was found in the array.
	found := false

    ;Check if the title is already included in the array.
    ;There can (and probably will) be multiple window IDs. E.g., multiple titles (tabs), 1 ID for Firefox.
    for index, value in safeWindowTitles {
		;If the current title was found inside the array
		if (value = safeWinsActiveTitle) {
			;Then mark it as found and break the loop.
			found := true
			break
		}
	}

	;If the title was never found in the array.
	if (found = false) {
		;Add it to the array.
		safeWindowTitles.Push(safeWinsActiveTitle)

        ;Put the Icon of the program into the ImageList for use with the ListView.
        IL_Add(SafeWinsImageListID, activeWinProcPath)

        ;Add the Title and ID to the ListView, and add the Icon using the option "Icon1" "Icon2" etc.
        ;Icon number is defined by "LV_GetCount() + 1" which gets the number of rows in before adding and adds one.
        LV_Add("Icon" LV_GetCount() + 1, safeWinsActiveTitle, safeWinsActiveID)
	}

return