;Credit for  this script: u/AutoHotYeet of the r/AutoHotkey subreddit.
;https://www.reddit.com/r/AutoHotkey/comments/eoay4f/need_help_with_antidistraction_script/feecalp?utm_source=share&utm_medium=web2x
;I origianlly had the idea, but couldn't figure out how to do it.
;This amazing person helped me out by making this whole script.
;IDK how the GUI stuff works, but otherwise it's pretty simple.
;I made some slight modifications: the ^w or !F4 stuff, and also
; I added some comments.

;This script is for helping me to focus, and preventing me from getting distracted.
;If it detects an active window title that is not in the list of accepted window
; titles, it smites it by sending ^w if it's a browser, or Alt + F4 otherwise.
;Thus keeping me off of and away from the distraction.

#NoEnv
SetBatchLines -1
SendMode Input 
SetWorkingDir %A_ScriptDir%
#SingleInstance Force

SafeWindows := []

Gui, Font, S8, Verdana
Gui, +AlwaysOnTop +HWNDGuiHWND +Delimiter`n
Gui, Add, Text,  w225, Safe Windows (CTRL+F11)
Gui, Add, Listbox, hwndSafeWindowsLB AltSubmit vSelectedSafeWindow h200 wp
Gui, Add, Button, wp gDelete, Delete Selected Item from List
Gui, Add, Button, wp hwndStartStop gStartStop, Enable Anti-Distraction

Gui, Show, , Anti-Distraction

;Used for showing/hiding the GUI.
GuiVisible := 1

Return

SetTitleMatchMode, 2


StartStop:
	SetTimer, AntiDistraction, % (Toggle := !Toggle) ? 1000 : "OFF"
	GuiControl,, % StartStop, % (Toggle) ? "Disable Anti-Distraction" : "Enable Anti-Distraction"
Return

AntiDistraction:
	WinGetTitle, Title, A
	WinGet, HWND, ID, A

	;If the window is not in the accepted list, close it.
	;Either sends ^w or !F4, depepnding on if it's a browser tab or not.
	If !InArray(Title, SafeWindows) AND (HWND != GUIHwnd) {
		
		if InStr(Title, "Mozilla Firefox") {
			Send, ^w
			SoundPlay, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Nope Sound Effect.mp3
			return
		} else if InStr(Title, "Google Chrome") {
			Send, ^w
			SoundPlay, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Nope Sound Effect.mp3
			return
		} else if InStr(Title, "Shut Down Windows") {
			Send, {Escape}
			return
		} else {
			Send, !{F4}
			SoundPlay, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Nope Sound Effect.mp3
			return
		}
	}
Return

;Add items to the ListBox (list of windows that are OK).
^F11::
	WinGetTitle, Title, A

	If InArray(Title, SafeWindows){
		MessageBox("This item is already in the Safe Windows list")
		Return
	}

	SafeWindows.Push(Title)

	ArrayToLB(SafeWindows, SafeWindowsLB)
return

;Show/hide the GUI.
!F11::

;Toggle the variable.
GuiVisible := !GuiVisible

	if GuiVisible {
		Gui, Hide
		return
	} else {
		Gui, Show
		return
	}
return

;Checks if an item is already in an array
InArray(Value, Array){
	For k, v in Array
		If (v == Value)
			Return True
	Return False
}

;Updates a ListBox to be set to the value of an array
ArrayToLB(Array, LB){
	For Key, Value in Array
		LBItems .= Value "`n"

	GuiControl,, % LB, % "`n"
	GuiControl,, % LB, % LBItems
}

;Delete items from the ListBox
Delete:
	Gui, Submit, NoHide

	If !(SelectedSafeWindow){
		MessageBox("Please select an item to Delete")
		Return
	}
	
	SafeWindows.Remove(SelectedSafeWindow)
	ArrayToLB(SafeWindows, SafeWindowsLB)
Return

MessageBox(Message){
	Gui -AlwaysOnTop +Disabled
	MsgBox % Message
	Gui +AlwaysOnTop -Disabled
}

GuiClose:
	ExitApp
Return