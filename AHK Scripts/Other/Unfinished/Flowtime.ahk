#NoEnv
#singleinstance force

/*
* This script is a huge upgrade from an old script called "Anti-Distraction.ahk".
* That script worked ok, but it had problems and many annoyances that I didn't like.
* This script combines that with The Flowtime Technique
* https://medium.com/@lightsandcandy/the-flowtime-technique-7685101bd191
*
* The ListView in the WindowsGUI would not have been possible without u/trashdigger of the AutoHotKey subreddit.
* HUGE shout-out to them. https://www.reddit.com/r/AutoHotkey/comments/gad2bh/how_to_use_listview_for_gui/
*/

;TODO
;Disable the ^F11 hotkey while working...?
;Try removing/adding windows some more with the LV thing.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Only check title (after ID check) in FF/Chr...............?

CurrentMode := 0 ; 0 = Off, 1 = Working, 2 = Break

;These arrays store window titles for BOTH the black and whitelist modes.
WindowTitles := []
WindowIDs := []

;********************MAIN GUI********************
GUI, MainGUI: Add, Text, x2 w163 Center vModeTxt
GUI, MainGUI: Add, Button, x2 y42 w80 h20 gPause, &Pause
GUI, MainGUI: Add, Button, x82 y42 w80 h20 gReset, &Reset
GUI, MainGUI: Add, Text, x53 y22 w60 h20 Center E0x20 vTimeText
GUI, MainGUI: Add, Button, x2 y62 w160 h20 gStart Center, &Start / Stop
GUI, MainGUI: Add, Button, x2 y82 w160 h20 gBlackWhiteListButton Center, &Blacklist / Whitelist Windows
GUI, MainGUI: +AlwaysOnTop -MinimizeBox
GUI, MainGUI: Show, h105 w165, Flowtime

SetMode(0)

;********************BLACK/WHITELIST GUI********************
WindowsGUI := "Black/Whitelist GUI"

;Make the GUI (and then make it AlwaysOnTop).
GUI, WindowsGUI:New
GUI, WindowsGUI:+AlwaysOnTop -MinimizeBox

GUI, WindowsGUI:Font, norm S10
GUI, WindowsGUI:Add, Text, x3 y4, ^F11: Add Windows

;Radio buttons for toggling between blacklist/whitelist modes.
GUI, WindowsGUI:Add, Radio, x127 y4 gRadioButtonLabel vWhitelistRadio Checked, Whitelist
GUI, WindowsGUI:Add, Radio, x127 y22 gRadioButtonLabel vBlacklistRadio, Blacklist

;Delete button.
GUI, WindowsGUI:Font, norm S9
GUI, WindowsGUI:Add, Button, x3 y27 w120 gLVDeleteButton, Delete Selected Item

;ListView.
GUI, WindowsGUI:Add, ListView, x4 y58 w190 h205 Grid -LV0x10, Title|ID

;Icons.
SafeWinsImageListID := IL_Create() ;Initially create an ImageList to store icons in. It grows automatically.
LV_SetImageList(SafeWinsImageListID) ;sets the image list for the ListView to use the ImageList created in the line above

;Set column widths.
LV_ModifyCol(1, 160) ;Title.
LV_ModifyCol(2, 30) ;ID.

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\inArray().ahk

return

BlackWhiteListButton:
	showBlackWhiteListToggle := !showBlackWhiteListToggle

	if (showBlackWhiteListToggle = true)
		GUI, WindowsGUI:Show, w200 h270, Windows GUI
	else
		GUI, WindowsGUI:Hide
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

    for index, title in WindowTitles {
        ;If the current ID was found inside the array, remove it.
		if (title = text) {
            WindowTitles.RemoveAt(index)
            WindowIDs.RemoveAt(index)
			break
		}
    }
return

;Gets the values from the radio buttons.
RadioButtonLabel:
GUI, WindowsGUI:Submit, NoHide
return

;Adds windows to the arrays.
^F11::

    ;https://www.autohotkey.com/docs/commands/ListView.htm#BuiltIn
    GUI, WindowsGUI:Default

    ;Get the active window title, ID, and the window icon.
    WinGetTitle, ActiveWinTitle, A
    WinGet, ActiveWinID, ID, A
    WInGet, activeWinProcPath, ProcessPath, A

    ;Boolean to track if the active title was found in the array.
    ;If it was, don't add it (duplicate it); if it wasn't, add it to the array.
	found := false

    ;Check if the title is already included in the array.
    ;There can (and probably will) be multiple window IDs. E.g., multiple titles (tabs), 1 ID for Firefox. Thus checking for duplicate IDs wouldn't work.
    for index, title in WindowTitles {
		;If the current title was found inside the array
		if (title = ActiveWinTitle) {
			;Then mark it as found, inform the user, and break the loop.
            MsgBox, 48, Already in the Array, This window title is already in the array.
			found := true
			break
		}
	}

	;If the title was never found in the array.
	if (found = false) {
		;Add it to the array.
		WindowTitles.Push(ActiveWinTitle)
        WindowIDs.Push(ActiveWinID)

        ;Put the Icon of the program into the ImageList for use with the ListView.
        IL_Add(SafeWinsImageListID, activeWinProcPath)

        ;Add the Title and ID to the ListView, and add the Icon using the option "Icon1" "Icon2" etc.
        ;Icon number is defined by "LV_GetCount() + 1" which gets the number of rows in before adding and adds one.
        LV_Add("Icon" LV_GetCount() + 1, ActiveWinTitle, ActiveWinID)

		Tippy("Window ID and Title added.", 600)
	}
return

;For setting what mode you're in for the Flowtime GUI.
SetMode(mode) {

	global CurrentMode, ModeTxt, StartTime, EndPause
	GoSub, StopTimers

	if (mode == 0) {

		;Off
		SetTime(0)
		GuiControl, MainGUI:, ModeTxt, Off
		SetTimer, AntiDistraction, Off
		Hotkey, ^F11, On

	} else if (mode == 1) {

		;Work Mode
		SetTime(0)
		GuiControl, MainGUI:, ModeTxt, Time this session
		StartTime := A_TickCount
		Hotkey, ^F11, Off
		SetTimer, UpdateWorkTime, 1000
		SetTimer, AntiDistraction, 1000

	} else {

		;Break Mode
		Hotkey, ^F11, On
		GuiControl, MainGUI:, ModeTxt, Time until end of break
		t := (A_TickCount - StartTime)*.4 ;Length of break.
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
	if (CurrentMode == 1) {
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
	MsgBox, BREAK OVER, BACK TO WORK!!!
	SetMode(1)
return

StopTimers:
	SetTimer, UpdateWorkTime, Off
	SetTimer, UpdatePauseTime, Off
	SetTimer, BackToWork, Off
return

MillisecToTime(msec) {
    secs := floor(mod((msec / 1000),60))
    mins := floor(mod((msec / (1000 * 60)), 60) )
    hour := floor(mod((msec / (1000 * 60 * 60)) , 24))
    return Format("{:02}:{:02}:{:02}",hour,mins,secs)
}

;I think this updates the timer in the GUI.
SetTime(t) {
    global TimeText, CurrentMode
    GuiControl, MainGUI:, TimeText ,  % MillisecToTime(t)
}

;Runs when working.
AntiDistraction:

	SetTitleMatchMode, 2 ;A window's title can contain WinTitle anywhere inside it to be a match.

	GUI, WindowsGUI:Submit, NoHide ;Gets the values from the radio buttons.

    ;Get the active window title and ID.
    WinGetTitle, ActiveWinTitle, A
    WinGet, ActiveWinID, ID, A

	if (WhitelistRadio = 1) {

		if (ActiveWinTitle = "Flowtime") or (ActiveWinTitle = "Windows GUI") {

			Tippy("Can't close this window because it's part of the script.", 1000)

		} else if ActiveWinTitle contains MusicBee

			Tippy("Won't close this window.", 1000)

		else if (inArray(ActiveWinID, WindowIDs)) {

			Tippy("ID in array, window staying open...", 1000)

			if (inArray(ActiveWinTitle, WindowTitles)) {

				Tippy("ID AND title in array, both staying open...", 1000)

			} else {

				Tippy("Title not in array, closing tab...", 1000)
				; WinMinimize %ActiveWinTitle%

			}

		} else {
			Tippy("ID NOT in array, closing...", 1000)
			; WinMinimize %ActiveWinTitle%
		}

	} else if (BlacklistRadio = 1) {

		if (inArray(ActiveWinID, WindowIDs)) {

			Tippy("ID in blacklist array, closing...", 1000)

			if (inArray(ActiveWinTitle, WindowTitles)) {

				Tippy("ID AND title in blacklist array, both closing...", 1000)

			} else {

				Tippy("Title NOT in array, tab staying open...", 1000)

			}

		} else {

			Tippy("ID NOT in array, window staying open...", 1000)

		}

	}

return

F11::Reload