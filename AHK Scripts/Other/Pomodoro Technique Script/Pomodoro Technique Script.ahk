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

;TODO have all 4 edit boxes available to edit whenever (gray out after prev pom is done?), but the 2-4 check boxes default to grayed out.
;TODO pom/break length can't change while the session is ongoing
;TODO a clear button when the long break is ready to activate.
;TODO break buttons start out as disabled.

/*
* This script is a HUGE upgrade from an old script called "Anti-Distraction.ahk".
* That script worked ok, but it had problems and many annoyances that I didn't like.
* This is a custom-built Pomodoro script.
* I've never really liked Pomodoro apps and browser extensions; they don't really do all that much tbh.
* The nice thing about being a programmer is that if you don't like something, you can just change it.
* Development started: 4/24/2020 ~1:00 PM
*
* The ListView in the Safe Windows GUI would not have been possible without u/trashdigger of the AutoHotKey subreddit.
* HUGE shout-out to them. https://www.reddit.com/r/AutoHotkey/comments/gad2bh/how_to_use_listview_for_gui/
*/

;Info on the Technique: https://www.wikiwand.com/en/Pomodoro_Technique
;There are six steps in the technique:
;  1. Decide on the task to be done.
;  2. Set the pomodoro timer (traditionally to 25 minutes).
;  3. Work on the task. The script will make sure that there are no distractions ;)
;  4. End work when the timer rings and put a checkmark on a piece of paper (or in this case, the GUI).
;  5. If you have fewer than four checkmarks, take a short break (3-5 minutes), then go to step 2.
;  6. After four pomodoros, take a longer break (15-30 minutes), reset your checkmark count to zero, then go to step 1.

;Changes the icon to a little tomato!
Menu, Tray, Icon, %A_ScriptDir%\Pomodoro GUI Script Icon.png

;Window titles and IDs that won't get smote when a Pomodoro timer is running, and there isn't a break going on.
;The reason there's 2 arrays is because the script will compare if the active window title OR ID is not in the
;list of acceptable titles/IDs. For example, a music program. Its title won't stay constant, but its ID will.
;This was an annoyance with the old script.
safeWindowTitles := []
safeWindowIDs := []

;Toggle for showing/hiding all the other GUIs.
showStatsGUIToggle := false
showOptionsGUIToggle := false
showSafeWinsGUIToggle := false

;******************CONSTANTS******************
;So AHK and the programmer don't get confused.
MainGUI := "Pomodoro GUI Script"
OptionsGUI := "Options for Pomodoro Script"
SafeWinsGUI := "Safe windows for Pomodoro Script"
StatsGUI := "Stats for Pomodoro Script"

;******************GUI INITIALIZATION******************
;************POMODORO PICTURE************
GUI, MainGUI:Add, Picture, w70 h70 x10 y10, %A_ScriptDir%\Pomodoro GUI Script Icon.png

;************WORDS OF ENCOURAGEMENT************
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x10 y90 w100 h75, You can do it!

;************START A NEW TASK!************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x123 y10 w191 h150, Start a new task!

;******POMODORO BUTTON******
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Button, x133 y38 gStartPomButton vPomButtonVar, Start &Pomodoro

;******SHORT BREAK BUTTON******
GUI, MainGUI:Add, Button, x133 y78 gSBButton vSBButtonVar, &Short Break

;******LONG BREAK BUTTON******
GUI, MainGUI:Add, Button, x133 y118 gLBButton vLBButtonVar, &Long Break

;******TIMER PROGRESS******
GUI, MainGUI:Add, Progress, x126 y173 w189 h20 cEB3834 vTimerProgress, 100

;************TASKS************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x327 y10 w150 h155, Tasks

GUI, MainGUI:Font, norm s12

;******CHECKBOX1******
GUI, MainGUI:Add, Checkbox, x335 y38 vCheckbox1, &1
GUI, MainGUI:Add, Edit, x368 y34 w100 h26 vCheck1EditBox

;******CHECKBOX2******
GUI, MainGUI:Add, Checkbox, x335 y68 vCheckbox2 , &2
GUI, MainGUI:Add, Edit, x368 y64 w100 h26 vCheck2EditBox

;******CHECKBOX3******
GUI, MainGUI:Add, Checkbox, x335 y98 vCheckbox3, &3
GUI, MainGUI:Add, Edit, x368 y94 w100 h26 vCheck3EditBox

;******CHECKBOX4******
GUI, MainGUI:Add, Checkbox, x335 y129 vCheckbox4 , &4
GUI, MainGUI:Add, Edit, x368 y125 w100 h26 vCheck4EditBox

;************WHAT NEXT?************
;Helps the user by telling them what to do next.
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x327 y171 w150 h85, What's Next?

GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x333 y195 w140 h50, Start a new task! ;Starting text.

;************OTHER GUI GROUPBOX************
GUI, MainGUI:Add, GroupBox, x3 y130 w121 h127, Other GUIs

;******SAFE WINDOWS******
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Button, x4 y150 gSafeWindowsButton, Sa&fe Windows

;******STATS******
GUI, MainGUI:Add, Button, x4 y185 gStatsButton, S&tats

;******OPTIONS******
GUI, MainGUI:Add, Button, x4 y220 gOptionsButton, &Options

;************SHOW THE GUI************
GUI, MainGUI:+AlwaysOnTop
GUI, MainGUI:Show, w490 h292 x1350 y377, Pomodoro Technique Script

;Disable until the first one is checked.
GuiControl, MainGUI:Disable, Checkbox2
; GuiControl, MainGUI:Disable, Check2EditBox
GuiControl, MainGUI:Disable, Checkbox3
; GuiControl, MainGUI:Disable, Check3EditBox
GuiControl, MainGUI:Disable, Checkbox4
; GuiControl, MainGUI:Disable, Check4EditBox

;Other GUIs used for this script.
#Include, %A_ScriptDir%\Pom Script Options GUI.ahk
#Include, %A_ScriptDir%\Pom Script Safe Windows GUI.ahk
#Include, %A_ScriptDir%\Pom Script Stats GUI.ahk
return ;End of Auto-execute.

;******************LABELS & HOTKEYS******************
MainGUIGuiClose:
ExitApp
return

OptionsGUIGuiClose:
showOptionsGUIToggle := !showOptionsGUIToggle
GUI, OptionsGUI:Hide
return

SafeWinsGUIGuiClose:
showSafeWinsGUIToggle := !showSafeWinsGUIToggle
GUI, SafeWinsGUI:Hide
return

StatSGUIGuiClose:
showStatsGUIToggle := !showStatsGUIToggle
GUI, StatsGUI:Hide
return

;Toggles between showing and hiding the safe windows menu.
SafeWindowsButton:
showSafeWinsGUIToggle := !showSafeWinsGUIToggle

if (showSafeWinsGUIToggle = true)
    GUI, SafeWinsGUI:Show, x1460 w200 h270, Safe Windows
else
    GUI, SafeWinsGUI:Hide
return

;Toggles between showing and hiding the stats menu.
StatsButton:
showStatsGUIToggle := !showStatsGUIToggle

if (showStatsGUIToggle = true)
    GUI, StatsGUI:Show, w250 h110, Stats
else
    GUI, StatsGUI:Hide
return

;Toggles between showing and hiding the safe windows menu.
OptionsButton:
showOptionsGUIToggle := !showOptionsGUIToggle

if (showOptionsGUIToggle = true)
    GUI, OptionsGUI:Show, w250 h110, Options
else
    GUI, OptionsGUI:Hide
return

;Deletes a single window from the ListView.
DeleteButton:
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

;Adds windows to the Safe Windows arrays.
^F11::
    ;https://www.autohotkey.com/docs/commands/ListView.htm#BuiltIn
    GUI, SafeWinsGUI:Default

    ;Get the active window title, ID, and the window icon.
    WinGetTitle, activeWinTitle, A
    WinGet, activeWinID, ID, A
    WInGet, activeWinProcPath, ProcessPath, A

    ;Boolean to track if the active title was found in the array.
    ;If it was, don't add it (duplicate it); if it wasn't, add it to the array.
	; found := false

    ;Check if the title is already included in the array.
    ;There can (and probably will) be multiple window IDs. E.g., multiple titles (tabs), 1 ID for Firefox.
    ; for index, title in safeWindowTitles {
	; 	;If the current title was found inside the array
	; 	if (title = activeWinTitle) {
	; 		;Then mark it as found, inform the user, and break the loop.
    ;         MsgBox, 48, Already in the Array, This window title is already in the array.
	; 		found := true
	; 		break
	; 	}
	; }

	;If the title was never found in the array.
	; if (found = false) {
		;Add it to the array.
		safeWindowTitles.Push(activeWinTitle)
        safeWindowIDs.Push(activeWinID)

        ;Put the Icon of the program into the ImageList for use with the ListView.
        IL_Add(SafeWinsImageListID, activeWinProcPath)

        ;Add the Title and ID to the ListView, and add the Icon using the option "Icon1" "Icon2" etc.
        ;Icon number is defined by "LV_GetCount() + 1" which gets the number of rows in before adding and adds one.
        LV_Add("Icon" LV_GetCount() + 1, activeWinTitle, activeWinID)
	; }
return

StartPomButton:
    GuiControl, MainGUI:Disable, SBButtonVar
    GuiControl, MainGUI:Disable, LBButtonVar
    SetTimer, AntiDistraction, 500
return

SBButton:
; MsgBox, 1
return

LBButton:
; MsgBox
return

;When a pomodoro is running.
AntiDistraction:

    ;Get the active window title, and ID.
    WinGetTitle, activeWinTitle, A
    WinGet, activeWinID, ID, A

    ;If the window (or browser tab) is not in the accepted list, close it.
    if !inArray(activeWinTitle, safeWindowTitles) OR !inArray(activeWinID, safeWindowIDs) {

        if (InStr(activeWinTitle, "Mozilla Firefox")) OR (InStr(activeWinTitle, "Google Chrome")) {
			Send, ^w
		} else if (activeWinTitle = "Safe Windows") OR (activeWinTitle = "Pomodoro Technique Script") {
            return ;Don't want these windows to get closed...
        } else {
			WinClose, %activeWinTitle%
		}

    }
return

;Checks if an item is already in an array.
inArray(Value, Array) {
	For k, v in Array
		If (v == Value)
			Return True
	Return False
}

;TODO
F11::Reload