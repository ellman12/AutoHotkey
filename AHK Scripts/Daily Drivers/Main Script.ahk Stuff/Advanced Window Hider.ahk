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

;This script is a more advanced version of an old script called "WindowHider.ahk" script.
;That script kinda sucked, so I got inspired to make this improved version.
;It gives me incredible control over hiding and showing windows.
;Before I started writing this script, I did a Google search for any similar scripts that had what I was looking for.
;I found this script on r/AHK by GroggyOtter: https://www.reddit.com/r/AutoHotkey/comments/6fesyf/hide_windows/dii587h?utm_source=share&utm_medium=web2x
;I copied that script, and improved it.
;I also paraphrased some code from the old "WindowHider.ahk" script, and I got a lot of the functionality of this script from there.

;WARNING! BEFORE YOU EDIT THIS SCRIPT—AND THUS RELOAD IT—MAKE SURE ALL OF YOUR WINDOWS ARE UNHIDDEN! OR ELSE THEY'LL BE GONE FOREVER!

;***********************************HOTKEYS***********************************
; ^F8:: Add the current window's title and ID to the list (array).
; !F8:: Add the current window's title and ID to the list (array), and hide it right away.
; +F8:: Show previously hidden window.
; F8:: Toggle between showing and hiding all the windows in the list (array).
; #F8:: Display a list of hidden windows with their index next to it. If the user presses 1â€“9, it will show and activate the window with that index.
; ^+F8:: Remove the current window's ID and title from the list (array).
; ^!+F8:: Remove all windows from the group, without closing them.
; ^!+#F8:: Close all windows in the list (array).

;Suspend hotkeys.
+#p::
Suspend
return

;Declare array to track window IDs.
F8WinIDArray := []

;Declare array to track window titles.
F8WinTitleArray := []

;Decalre F8ShowHideToggle as 1 so the first time you press F8, it hides everything.
;If it's 1, hide windows; if it's 0, show windows.
F8ShowHideToggle := 1
return ;End of Auto-execute section.

;Add the current window's title and ID to the list (array).
^F8::

    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
    if (NumHiddenWindows = "") ;If the number of hidden windows doesn't exist?
		NumHiddenWindows := 0 ;Set it to 0.
	NumHiddenWindows := NumHiddenWindows + 1 ;Add to total number of hidden windows to be used for later.

    WinGetTitle F8ActiveWinTitle, A ;Get active window title.

    ;Put the number of hidden windows in an array to be used for later.
	F8WinTitleArray%NumHiddenWindows% := F8ActiveWinTitle

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
    ToolTip, Added to F8 Group!
    Sleep, 200
    ToolTip
return ;End of ^F8.

;Add the current window's title and ID to the list (array), and hide it right away.
;If it's already in the list, hide it anyway (in case the user accidentally does ^F8 first, or for any other reason).
!F8::

    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
    if (NumHiddenWindows = "") ;If the number of hidden windows doesn't exist?
		NumHiddenWindows := 0 ;Set it to 0.
	NumHiddenWindows := NumHiddenWindows + 1 ;Add to total number of hidden windows to be used for later.

    WinGetTitle F8ActiveWinTitle, A ;Get active window title.

    ;Put the number of hidden windows in an array to be used for later.
	F8WinTitleArray%NumHiddenWindows% := F8ActiveWinTitle

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

;Show previously hidden window.
+F8::

    SetTitleMatchMode, 3
    ;If the title of the last hidden window is NOT blank: show, restore, and activate the previously hidden window.
    ;Aso decrement the total number of windows by 1 each time.
    if (F8ActiveWinTitle != "") {
        WinShow, %F8ActiveWinTitle%
        WinRestore %PreviousHiddenWindow%
		WinActivate %PreviousHiddenWindow%
		NumHiddenWindows := %NumHiddenWindows% - 1
		PreviousHiddenWindow := HiddenWindows%NumHiddenWindows%
    }
return ;End of +F8.

;Remove the active window from the list.
^+F8::
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
return ;End of ^+F8.

;Toggle between showing and hiding all the windows.
F8::
    ;Change F8ShowHideToggle to opposite of F8ShowHideToggle.
    ;1 becomes 0. 0 becomes 1.
    ;If it's 1, hide windows; if it's 0, it shows windows.
    F8ShowHideToggle := !F8ShowHideToggle
    
    ;If F8ShowHideToggle = 1
    if (F8ShowHideToggle = 1)
        ;Loop through the array...
    for index, value in F8WinIDArray
        ;...and show everything
    WinShow, % "ahk_id " value
    ;If F8ShowHideToggle does not = 1
    else
        ;Loop through the array...
    for index, value in F8WinIDArray
        ;...and hide everything
    WinHide, % "ahk_id " value
return

;Display a list of hidden windows with their index next to it. If the user presses 1-9, it will show and activate the window with that index.
#F8::
    ;If F8ShowHideToggle is 1, hide windows; if it's 0, show windows.
    ;If there aren't any hidden windows.
    SetTitleMatchMode, 3 ;Set it so that a window's title must exactly match WinTitle to be a match.
	if (NumHiddenWindows = "" or NumHiddenWindows <= 0) {
		MsgBox, There are no hidden windows at this time.
		return
	}

    ;Used for the Progress GUI thing.
    F8ProgressWindowList = 
	Loop %NumHiddenWindows% {
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
		if (Prog1to9Var < NumHiddenWindows) {
			;The number of times to loop equals the total number of hidden windows, minus the inputted character (IDK why).
            NumLoops := NumHiddenWindows - Prog1to9Var

        ;Not sure about the following code; it was copied from the old script, which was kinda crappy.
            Loop %NumLoops% {
				IndexToEdit := Prog1to9Var + A_Index - 1
				IndexToCopy := IndexToEdit + 1
				F8WinTitleArray%IndexToEdit% := F8WinTitleArray%IndexToCopy%
			}
			NumHiddenWindows := NumHiddenWindows - 1		
		}
		else {
			NumHiddenWindows := NumHiddenWindows - 1
			F8ActiveWinTitle := F8WinTitleArray%NumHiddenWindows%
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