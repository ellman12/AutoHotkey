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
#SingleInstance force
;OPTIMIZATIONS END

;Pic of all these icons: https://diymediahome.org/wp-content/uploads/shell32_icons.jpg
Menu, Tray, Icon, shell32.dll, 233 ;Changes the icon to a little keyboard.

;This script is a more advanced version of an old script called "WindowHider.ahk" script.
;That script kinda sucked, so I got inspired to make this improved version.
;It gives me incredible control over hiding and showing windows.
;Before I started writing this script, I did a Google search for any similar scripts that had what I was looking for.
;I found this script on r/AHK by GroggyOtter: https://www.reddit.com/r/AutoHotkey/comments/6fesyf/hide_windows/dii587h?utm_source=share&utm_medium=web2x
;I copied that script, and improved it.
;I also paraphrased some code from the old "WindowHider.ahk" script, and I got a lot of the functionality of this script from there.

;On 2/09/2020 I added an exact copy of the F8 hotkeys, albeit with F10. That way, I can have 2 sets of hidden windows, akin to F6 and F7.

;WARNING! BEFORE YOU EDIT THIS SCRIPT--AND THUS RELOAD IT--MAKE SURE ALL OF YOUR WINDOWS ARE UNHIDDEN! OR ELSE THEY'LL BE GONE FOREVER!

;*******************************ADVANCED WINDOW HIDER HELP GUI INITIALIZATION******************************
AdvWinHider := "Advanced Window Hider Help Box GUI"

;Toggle for the hotkey to show/hide the help.
showAdvWinHiderGUIToggle := 0

;Basic GUI setup.
GUI, AdvWinHider:+AlwaysOnTop
GUI, AdvWinHider:Color, Silver

;Adding the title text.
GUI, AdvWinHider:Font, underline s14
GUI, AdvWinHider:Add, Text, x5 y5, Hotkey
GUI, AdvWinHider:Add, Text, x115 y5, What It Does

;Adding the text for all the hotkeys and what they do.
GUI, AdvWinHider:Font, norm s11.5
GUI, AdvWinHider:Add, Text, x5 y40,Alt + w`t`tToggles between showing and hiding this help GUI.`nAlt + F10`tAdd the window to F8 the array and hide.`nAlt + F8`t`tAdd the window to F8 the array and hide.`n^!+F10`t`tRemove all windows from the F10 group, without closing them.`n^!+F8`t`tRemove all windows from the F8 group, without closing them.`n^!+#F10`tClose all windows in the F10 list (array).`n^!+#F8`t`tClose all windows in the F8 list (array).`nCtrl + F10`tAdd the current window's title and ID to the F10 list (array).`nCtrl + F8`tAdd the current window's title and ID to the F8 list (array).`nShift + F10`tRemove the current window from F10 group.`nShift + F8`tRemove the current window from F10 group.`nF10`t`tShow/hide F10 windows.`nF8`t`thow/hide F10 windows.`nShift + Pause`tHotkey for suspending AWH hotkeys.`nWin + F10`tShows hidden F10 wins list. 1-9 to unhide that window.`nWin + F8`tShows hidden F8 wins list. 1-9 to unhide that window.

;***********************************HOTKEYS***********************************
; ^F8:: Add the current window's title and ID to the list (array).
; !F8:: Add the current window's title and ID to the list (array), and hide it right away.
; F8:: Toggle between showing and hiding all the windows in the list (array).
; #F8:: Display a list of hidden windows with their index next to it. If the user presses 1–9, it will show and activate the window with that index.
; +F8:: Remove the current window's ID and title from the list (array).
; ^!+F8:: Remove all windows from the group, without closing them.
; ^!+#F8:: Close all windows in the list (array).

; ^F10:: Add the current window's title and ID to the list (array).
; !F10:: Add the current window's title and ID to the list (array), and hide it right away.
; F10:: Toggle between showing and hiding all the windows in the list (array).
; #F10:: Display a list of hidden windows with their index next to it. If the user presses 1–9, it will show and activate the window with that index.
; +F10:: Remove the current window's ID and title from the list (array).
; ^!+F10:: Remove all windows from the group, without closing them.
; ^!+#F10:: Close all windows in the list (array).

;Declare arrays to track window IDs.
F8WinIDArray := []
F10WinIDArray := []

;Declare arrays to track window titles.
F8WinTitleArray := []
F10WinTitleArray := []

;Decalre F8ShowHideToggle and F10showHideToggle as 1 so the first time you press F8, it hides everything.
;If it's 1, hide windows; if it's 0, show windows.
F8ShowHideToggle := 1
F10ShowHideToggle := 1
return ;End of Auto-execute section.

;Suspend hotkeys.
+Pause::
Suspend, Toggle
return

;Toggles between showing and hiding the help GUI for Advanced Window Hider.ahk
!w::
showAdvWinHiderGUIToggle := !showAdvWinHiderGUIToggle

if (showAdvWinHiderGUIToggle = 1)
	GUI, AdvWinHider:Show, x600 y90 w560 h370, Advanced Window Hider.ahk Hotkey Help Window
else
	GUI, AdvWinHider:Hide
return

;***************************************F8 HOTKEYS***************************************
;Add the current window's title and ID to the list (array).
^F8::

    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
    if (NumHiddenWindowsF8 = "") ;If the number of hidden windows doesn't exist?
		NumHiddenWindowsF8 := 0 ;Set it to 0.
	NumHiddenWindowsF8 := NumHiddenWindowsF8 + 1 ;Add to total number of hidden windows to be used for later.

    WinGetTitle F8ActiveWinTitle, A ;Get active window title.

    ;Put the number of hidden windows in an array to be used for later.
	F8WinTitleArray%NumHiddenWindowsF8% := F8ActiveWinTitle

    ;Get ID of current active window.
    WinGet, F8ActiveWinID, ID, A

    ;Loop through list and make sure there's no duplicate IDs.
    ;Index is array index, and value is the value at that index (I think).
    for index, value in F8WinIDArray

    if (F8ActiveWinID = value) ;If duplicate is found...
        ;...stop code flow because nothing needs to be added, and break out of the hotkey.
    return

    ;If duplicate isn't found, add window to the array.
    F8WinIDArray.Push(F8ActiveWinID)

    ;Notify user add was sucessful.
    ToolTip, Added to F8 AWH Group!
    Sleep, 200
    ToolTip
return ;End of ^F8.

;Add the current window's title and ID to the list (array), and hide it right away.
;If it's already in the list, hide it anyway (in case the user accidentally does ^F8 first, or for any other reason).
!F8::

    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
    if (NumHiddenWindowsF8 = "") ;If the number of hidden windows doesn't exist?
		NumHiddenWindowsF8 := 0 ;Set it to 0.
	NumHiddenWindowsF8 := NumHiddenWindowsF8 + 1 ;Add to total number of hidden windows to be used for later.

    WinGetTitle F8ActiveWinTitle, A ;Get active window title.

    ;Put the number of hidden windows in an array to be used for later.
	F8WinTitleArray%NumHiddenWindowsF8% := F8ActiveWinTitle

    ;Get ID of current active window.
    WinGet, F8ActiveWinID, ID, A

    ;Loop through list and make sure there's no duplicate IDs.
    ;Index is array index, and value is the value at that index (I think).
    for index, value in F8WinIDArray

    if (F8ActiveWinID = value) ;IDK about this.
        WinHide, % "ahk_id " F8ActiveWinID

    ;If duplicate isn't found, add window ID to the array.
    F8WinIDArray.Push(F8ActiveWinID)

    ;Hide the window after putting it in the list (array).
    WinHide, % "ahk_id " F8ActiveWinID
return ;End of !F8.

;Remove the active window from the list.
+F8::
    ;Get ID of current active window.
    WinGet, F8ActiveWinID, ID, A
    
    ;Loop through list and find the value to remove.
    for index, value in F8WinIDArray

    if (value != F8ActiveWinID) ;If it's not found...
        ;...stop code flow because nothing needs to be added
    return

    ;Remove the ID from array.
    F8WinIDArray.RemoveAt(index)

    ;Remove the title from the array.
    F8WinTitleArray.RemoveAt(index)

    ;Notify user removal was sucessful.
    ToolTip, Removed from F8 Group!
    Sleep, 200
    ToolTip
return ;End of +F8.

;Toggle between showing and hiding all the windows.
F8::
    ;Change F8ShowHideToggle to opposite of F8ShowHideToggle.
    ;1 becomes 0. 0 becomes 1.
    ;If it's 1, hide windows; if it's 0, it shows windows.
    F8ShowHideToggle := !F8ShowHideToggle
    
    ;If F8ShowHideToggle = 1
    if (F8ShowHideToggle = 1) {
        ;Loop through the array...
        for index, value in F8WinIDArray
        ;...and show everything
        WinShow, % "ahk_id " value
        WinActivate, , % "ahk_id " value
    ;If F8ShowHideToggle does not = 1
    } else {
        ;Loop through the array...
        for index, value in F8WinIDArray
        ;...and hide everything
        WinHide, % "ahk_id " value
    }
return ;End of F8.

;Display a list of hidden windows with their index next to it. If the user presses 1-9, it will show and activate the window with that index.
#F8::
    ;If F8ShowHideToggle is 1, hide windows; if it's 0, show windows.
    ;If there aren't any hidden windows.
    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
	if (NumHiddenWindowsF8 = "" or NumHiddenWindowsF8 <= 0) {
		MsgBox, There are no hidden windows at this time.
		return
	}

    ;Used for the Progress GUI thing.
    F8ProgressWindowList = 
	Loop %NumHiddenWindowsF8% {
		if (A_Index >= 10)
			F8ProgressWindowList := F8ProgressWindowList . "...The Following windows cannot be reached directly through this...`n"
		F8CurrentWindow := F8WinTitleArray%A_Index%
		;WinShow %F8CurrentWindow%
		F8ProgressWindowList := F8ProgressWindowList . A_Index . ") " . F8CurrentWindow . "`n"
	}

    ;The GUI-type thing that appears when you press the hotkey.
    ;IDK how it works.
    Progress, m zh0 fs12 c00 WS550 W750, %F8ProgressWindowList%, , Window List - Select the number (1 through 9) that you want to unhide.

    ;Get the input from the user and store it in the variable Prog1to9Var. L1 is the character limit (can only type 1 character).
	Input, Prog1to9Var, L1
	progress, Off ;Turn off/remove the progress GUI.

    ;If the user inputs a number between 1 and 9, show that window.
	if (Prog1to9Var >= 1 and Prog1to9Var <= 9) {
		F8WinToShow := F8WinTitleArray%Prog1to9Var%
		WinShow %F8WinToShow% ;Show and activate the window.
		WinActivate %F8WinToShow%

        ;If the inputted character (number) is less than the total number of hidden windows.
		if (Prog1to9Var < NumHiddenWindowsF8) {
			;The number of times to loop equals the total number of hidden windows, minus the inputted character (IDK why).
            NumLoops := NumHiddenWindowsF8 - Prog1to9Var

        ;Not sure about the following code; it was copied from the old script, which was kinda crappy.
            Loop %NumLoops% {
				IndexToEdit := Prog1to9Var + A_Index - 1
				IndexToCopy := IndexToEdit + 1
				F8WinTitleArray%IndexToEdit% := F8WinTitleArray%IndexToCopy%
			}
			NumHiddenWindowsF8 := NumHiddenWindowsF8 - 1		
		}
		else {
			NumHiddenWindowsF8 := NumHiddenWindowsF8 - 1
			F8ActiveWinTitle := F8WinTitleArray%NumHiddenWindowsF8%
		}
		
	}
return ;End of #F8.

;Remove all windows from the group, without closing them.
^!+F8::

    ;Blank out the arrays.
    F8WinIDArray := 
    F8WinTitleArray := 

return ;End of ^!+F8.

;Close all windows in the list (array).
^!+#F8::

    ;For-loops through the array, closing each window along the way.
    for index, value in F8WinIDArray
    WinClose, % "ahk_id " value

return ;End of ^!+#F8.


;***************************************F10 HOTKEYS**************************************
;Add the current window's title and ID to the list (array).
^F10::

    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
    if (NumHiddenWindowsF10 = "") ;If the number of hidden windows doesn't exist?
		NumHiddenWindowsF10 := 0 ;Set it to 0.
	NumHiddenWindowsF10 := NumHiddenWindowsF10 + 1 ;Add to total number of hidden windows to be used for later.

    WinGetTitle F10ActiveWinTitle, A ;Get active window title.

    ;Put the number of hidden windows in an array to be used for later.
	F10WinTitleArray%NumHiddenWindowsF10% := F10ActiveWinTitle

    ;Get ID of current active window.
    WinGet, F10ActiveWinID, ID, A

    ;Loop through list and make sure there's no duplicate IDs.
    ;Index is array index, and value is the value at that index (I think).
    for index, value in F10WinIDArray

    if (F10ActiveWinID = value) ;If duplicate is found...
        ;...stop code flow because nothing needs to be added, and break out of the hotkey.
    return

    ;If duplicate isn't found, add window to the array.
    F10WinIDArray.Push(F10ActiveWinID)

    ;Notify user add was sucessful.
    ToolTip, Added to F10 AWH Group!
    Sleep, 200
    ToolTip
return ;End of ^F10.

;Add the current window's title and ID to the list (array), and hide it right away.
;If it's already in the list, hide it anyway (in case the user accidentally does ^F10 first, or for any other reason).
!F10::

    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
    if (NumHiddenWindowsF10 = "") ;If the number of hidden windows doesn't exist?
		NumHiddenWindowsF10 := 0 ;Set it to 0.
	NumHiddenWindowsF10 := NumHiddenWindowsF10 + 1 ;Add to total number of hidden windows to be used for later.

    WinGetTitle F10ActiveWinTitle, A ;Get active window title.

    ;Put the number of hidden windows in an array to be used for later.
	F10WinTitleArray%NumHiddenWindowsF10% := F10ActiveWinTitle

    ;Get ID of current active window.
    WinGet, F10ActiveWinID, ID, A

    ;Loop through list and make sure there's no duplicate IDs.
    ;Index is array index, and value is the value at that index (I think).
    for index, value in F10WinIDArray

    if (F10ActiveWinID = value) ;IDK about this.
        WinHide, % "ahk_id " F10ActiveWinID

    ;If duplicate isn't found, add window ID to the array.
    F10WinIDArray.Push(F10ActiveWinID)

    ;Hide the window after putting it in the list (array).
    WinHide, % "ahk_id " F10ActiveWinID
return ;End of !F10.

;Remove the active window from the list.
+F10::
    ;Get ID of current active window.
    WinGet, F10ActiveWinID, ID, A
    
    ;Loop through list and find the value to remove.
    for index, value in F10WinIDArray

    if (value != F10ActiveWinID) ;If it's not found...
        ;...stop code flow because nothing needs to be added
    return

    ;Remove the ID from array.
    F10WinIDArray.RemoveAt(index)

    ;Remove the title from the array.
    F10WinTitleArray.RemoveAt(index)

    ;Notify user removal was sucessful.
    ToolTip, Removed from F10 Group!
    Sleep, 200
    ToolTip
return ;End of +F10.

;Toggle between showing and hiding all the windows.
F10::
    ;Change F10ShowHideToggle to opposite of F10ShowHideToggle.
    ;1 becomes 0. 0 becomes 1.
    ;If it's 1, hide windows; if it's 0, it shows windows.
    F10ShowHideToggle := !F10ShowHideToggle
    
    ;If F10ShowHideToggle = 1
    if (F10ShowHideToggle = 1) {
        ;Loop through the array...
        for index, value in F10WinIDArray
        ;...and show everything
        WinShow, % "ahk_id " value
        WinActivate, , % "ahk_id " value
    ;If F10ShowHideToggle does not = 1
    } else {
        ;Loop through the array...
        for index, value in F10WinIDArray
        ;...and hide everything
        WinHide, % "ahk_id " value
    }
return ;End of F10.

;Display a list of hidden windows with their index next to it. If the user presses 1-9, it will show and activate the window with that index.
#F10::
    ;If F10ShowHideToggle is 1, hide windows; if it's 0, show windows.
    ;If there aren't any hidden windows.
    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
	if (NumHiddenWindowsF10 = "" or NumHiddenWindowsF10 <= 0) {
		MsgBox, There are no hidden windows at this time.
		return
	}

    ;Used for the Progress GUI thing.
    F10ProgressWindowList = 
	Loop %NumHiddenWindowsF10% {
		if (A_Index >= 10)
			F10ProgressWindowList := F10ProgressWindowList . "...The Following windows cannot be reached directly through this...`n"
		F10CurrentWindow := F10WinTitleArray%A_Index%
		;WinShow %F10CurrentWindow%
		F10ProgressWindowList := F10ProgressWindowList . A_Index . ") " . F10CurrentWindow . "`n"
	}

    ;The GUI-type thing that appears when you press the hotkey.
    ;IDK how it works.
    Progress, m zh0 fs12 c00 WS550 W750, %F10ProgressWindowList%, , Window List - Select the number (1 through 9) that you want to unhide.

    ;Get the input from the user and store it in the variable Prog1to9Var. L1 is the character limit (can only type 1 character).
	Input, Prog1to9Var, L1
	progress, Off ;Turn off/remove the progress GUI.

    ;If the user inputs a number between 1 and 9, show that window.
	if (Prog1to9Var >= 1 and Prog1to9Var <= 9) {
		F10WinToShow := F10WinTitleArray%Prog1to9Var%
		WinShow %F10WinToShow% ;Show and activate the window.
		WinActivate %F10WinToShow%

        ;If the inputted character (number) is less than the total number of hidden windows.
		if (Prog1to9Var < NumHiddenWindowsF10) {
			;The number of times to loop equals the total number of hidden windows, minus the inputted character (IDK why).
            NumLoops := NumHiddenWindowsF10 - Prog1to9Var

        ;Not sure about the following code; it was copied from the old script, which was kinda crappy.
            Loop %NumLoops% {
				IndexToEdit := Prog1to9Var + A_Index - 1
				IndexToCopy := IndexToEdit + 1
				F10WinTitleArray%IndexToEdit% := F10WinTitleArray%IndexToCopy%
			}
			NumHiddenWindowsF10 := NumHiddenWindowsF10 - 1		
		}
		else {
			NumHiddenWindowsF10 := NumHiddenWindowsF10 - 1
			F10ActiveWinTitle := F10WinTitleArray%NumHiddenWindowsF10%
		}
		
	}
return ;End of #F10.

;Remove all windows from the group, without closing them.
^!+F10::

    ;Blank out the arrays.
    F10WinIDArray := 
    F10WinTitleArray := 

return ;End of ^!+F10.

;Close all windows in the list (array).
^!+#F10::

    ;For-loops through the array, closing each window along the way.
    for index, value in F10WinIDArray
    WinClose, % "ahk_id " value

return ;End of ^!+#F10.