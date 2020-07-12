#NoEnv
#singleinstance force

CurrentMode := 0 ; 0 = Off, 1 = working, 2 = break

;********************MAIN GUI********************
Gui, Add, Text, x2 w163 Center vModeTxt
Gui, Add, Button, x2 y42 w80 h20 gPause, &Pause
Gui, Add, Button, x82 y42 w80 h20 gReset, &Reset
Gui, Add, Text, x53 y22 w60 h20 Center E0x20 vTimeText
Gui, Add, Button, x2 y62 w160 h20 gStart Center, &Start / Stop
Gui, Add, Button, x2 y82 w160 h20 gBlackWhiteListButton Center, &Blacklist / Whitelist Windows
Gui -AlwaysOnTop -MinimizeBox
Gui, Show, h105 w165, Flowtime

SetMode(0)

;********************BLACK/WHITELIST GUI********************
BlackWhiteListGUI := "Black/Whitelist GUI"

;Make the GUI (and then make it AlwaysOnTop).
GUI, BlackWhiteListGUI:New
GUI, BlackWhiteListGUI:+AlwaysOnTop

GUI, BlackWhiteListGUI:Font, norm S12
GUI, BlackWhiteListGUI:Add, Text, x3 y4, Ctrl + F11: Add Windows

;Delete button.
GUI, BlackWhiteListGUI:Font, norm S10
GUI, BlackWhiteListGUI:Add, Button, x3 y27 w192 gLVDeleteButton, Delete Selected Item

;ListView.
GUI, BlackWhiteListGUI:Font, norm S9           ;Display ↓ grid; ↓ can't move headers around (but can resize).
GUI, BlackWhiteListGUI:Add, ListView, x4 y58 w190 h205 Grid -LV0x10, Title|ID

;Icons.
SafeWinsImageListID := IL_Create() ;Initially create an ImageList to store icons in. It grows automatically.
LV_SetImageList(SafeWinsImageListID) ;sets the image list for the ListView to use the ImageList created in the line above

;Set column widths.
LV_ModifyCol(1, 160) ;Title.
LV_ModifyCol(2, 30) ;ID.

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\Tippy.ahk
; return

; While (CurrentMode == 1) {
; 	MsgBox
; }
return

BlackWhiteListButton:
showBlackWhiteListToggle := !showBlackWhiteListToggle

if (showBlackWhiteListToggle = true)
    GUI, BlackWhiteListGUI:Show, w200 h270, Safe Windows
else
    GUI, BlackWhiteListGUI:Hide

return

;Deletes a single window from the ListView.
LVDeleteButton:
    ;Not a clue how this works; all credits go to u/trashdigger.
    LV_GetText(text, LV_GetNext(), 1)
    DeleteIndex := LV_GetNext()
    LV_Delete(DeleteIndex)
    DllCall("ComCtl32.dll\ImageList_Remove", "Ptr", SafeWinsImageListID, "Int", DeleteIndex - 1, "UInt") ;-1 because range of ListView start from 1 but ImageList starts from 0.
            
    ;Because the ImageList has changed, we must reorder the icons attached to items in the ListView to match the new indexing of the ImageList.
    Loop % LV_GetCount() {
        LV_Modify(A_Index, "Icon" . A_Index)
    }

	titleFound := false
    IDFound := false

    for index, title in safeWindowIDs {
        ;If the current ID was found inside the array, remove it.
		if (title = text) {
			titleFound := true
            safeWindowTitles.RemoveAt(index)
			break
		}
    }

    if (titleFound = false) {
        MsgBox idk
    }

    for index, ID in safeWindowIDs {
        ;If the current title was found inside the array, remove it.
		if (ID = text) {
			IDFound := true
            safeWindowTitles.RemoveAt(index)
			break
		}
    }

    if (titleFound = false) {
        MsgBox idk2
    }

return

SetMode(mode) {
	
	global CurrentMode, ModeTxt, StartTime, EndPause
	GoSub, StopTimers

	if (mode == 0) {
		
		; Off
		SetTime(0)
		GuiControl, , ModeTxt, Off
		
	} else if (mode == 1) {
		
		; Work Mode
		SetTime(0)
		GuiControl, , ModeTxt, Time this session
		StartTime := A_TickCount
		Settimer, UpdateWorkTime, 1000
		
	} else {
		
		; Break Mode
		GuiControl, , ModeTxt, Time until end of break
		t := (A_TickCount - StartTime)*.4 ; length of break
		SetTime(t)
		EndPause := t + A_TickCount
		SetTimer, UpdatePauseTime, 1000
		SetTimer, BackToWork, % "-" t
	}
	CurrentMode := mode
}

Start:
	if (CurrentMode == 1) {
		SetMode(0)
	} else if (CurrentMode == 0) {
		SetMode(1)
	}
return

Pause:
	if (CurrentMode == 1){
		SetMode(2)
	}
return

Reset:
	SetMode(1)
return

UpdateWorkTime:
	SetTime(A_TickCount - StartTime)
return

UpdatePauseTime:
	t := EndPause - A_TickCount
	SetTime(t)
return

BackToWork:
    SoundBeep, 500, 1000
	msgbox BREAK OVER, BACK TO WORK!!!
	SetMode(1)
return

StopTimers:
	Settimer, UpdateWorkTime, Off
	SetTimer, UpdatePauseTime, Off
	SetTimer, BackToWork, Off
return

MillisecToTime(msec) {
    secs := floor(mod((msec / 1000),60))
    mins := floor(mod((msec / (1000 * 60)), 60) )
    hour := floor(mod((msec / (1000 * 60 * 60)) , 24))
    return Format("{:02}:{:02}:{:02}",hour,mins,secs)
}

SetTime(t) {
    global TimeText, CurrentMode
    GuiControl, , TimeText ,  % MillisecToTime(t)

	if (CurrentMode = 1) {
		Tippy("Work work work", 50)
	}
}

GuiClose:
ExitApp
return