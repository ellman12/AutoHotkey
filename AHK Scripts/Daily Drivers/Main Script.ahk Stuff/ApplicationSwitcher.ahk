﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;A lot of this code is taken from Taran Van Hemert from Linus Media Group.
;His video on this: https://www.youtube.com/watch?v=OqyQABySV8k
;As he calls it, this is his most useful script he's ever made
;It's quite simple, but extremely useful and powerful
;I took his code for the window saver thing, which only saves one window, and made it able to do multiple windows
;All of this stuff works beautifully
;The code is stupid simple and it was incredibly easy to do

F1::
SwitchToFirefoxAndTabs() {
IfWinNotExist, ahk_class MozillaWindowClass
	Run, firefox.exe
if WinActive("ahk_exe firefox.exe")
	{
	WinGetClass, class, A
	if (class = "Mozillawindowclass1")
		msgbox, this is a notification
	}
if WinActive("ahk_exe firefox.exe")
	Send ^{PGDN}
else
	{
	;WinRestore ahk_exe firefox.exe
	WinActivatebottom ahk_exe firefox.exe
	;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
	;the below code should fix that.
	WinGet, hWnd, ID, ahk_class MozillaWindowClass
	DllCall("SetForegroundWindow", UInt, hWnd) 
	}
}

F2::
switchToOtherFirefoxWindows() {
Process, Exist, firefox.exe
	if errorLevel = 0
		Run, firefox.exe
	else
	{
	GroupAdd, taranfirefoxes, ahk_class MozillaWindowClass
	if WinActive("ahk_class MozillaWindowClass")
		GroupActivate, taranfirefoxes, r
	else
		WinActivate ahk_class MozillaWindowClass
	}
}

F3::
switchToChromeAndTabs()
{
IfWinNotExist, ahk_class Chrome_WidgetWin_1
	Run, chrome.exe
if WinActive("ahk_exe chrome.exe")
	Send ^{PGDN}
else
	WinActivate ahk_exe chrome.exe
}

F4::
switchToOtherChromeWindows()
{
Process, Exist, chrome.exe
	if errorLevel = 0
		Run, chrome.exe
	else
	{
	GroupAdd, taranchromes, ahk_class Chrome_WidgetWin_1
	if WinActive("ahk_class ahk_class Chrome_WidgetWin_1")
		GroupActivate, taranchromes, r
	else
		WinActivate ahk_class Chrome_WidgetWin_1
	}
}

;MR button on my keyboard
^!F1::
switchToExplorer() {
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

F9::
if WinActive("ahk_exe firefox.exe")
	Send ^{PgUp}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
return



;****************************************************CUSTOM GROUP STUFF****************************************************
;*************************************************F6 GROUP STUFF*************************************************
;Credits for this F6 stuff goes to GroggyOtter from the AHK subreddit:
;https://www.reddit.com/r/AutoHotkey/comments/dbil7u/add_active_window_to_group_and_push_button_to/f241ak3?utm_source=share&utm_medium=web2x
;I don't really know how it works, but it's fantastic. Thanks m8.
;I modified it a teeny tiny bit, plus added the F7 one. It's really nice having this for both F6 and F7.
^F6::
AddWindowF6()
return
!F6::
ActivateNeitherF6NorF7Windows()
return
^!F6::
RemoveWindowF6()
return
F6::
NextWindowF6()
return
+F6::
PrevWindowF6()
return
^+F6::
RemoveNonexistentWindowsF6()
return

;Add the current window to the array.
AddWindowF6() {
	ToolTip, Added to F6 Group!
	Sleep, 200
	ToolTip
	
	; Get the active window's ID
	WinGet, thisIDF6, ID, A
	; Value to track if ID was found in the group
	foundF6 := False
	; Loop through all the IDs
	for indexF6, value in WindowGroupF6
	{
		; If the current ID was found inside the array
		if (value = thisIDF6) {
			; Then mark it as found and break the loop
			foundF6 = True
			Break
		}
	}
	
	; If the ID was never found in the array
	if (foundF6 = False)
		; Add it to the array
		WindowGroupF6.Push(thisIDF6)
	return
}

;Remove the curent window from the array.
RemoveWindowF6() {
	ToolTip, Removed from F6 Group!
	Sleep, 200
	ToolTip
	
	WinGet, thisIDF6, ID, A
	foundF6 := False
	for indexF6, value in WindowGroupF6
	{
		; Same as the AddWindow function except if a match is found, remove it from the array
		if (value = thisIDF6) {
			WindowGroupF6.RemoveAt(indexF6)
			Break
		}
	}
	return
}

;Activates the next window.
NextWindowF6() {
	;Increment the current window by 1.
	CurrentWinF6++
	;If the current window is greater than the number of entries in the array.
	if (CurrentWinF6 > WindowGroupF6.MaxIndex())
		;Then reset it to the lowest index.
		CurrentWinF6 := WindowGroupF6.MinIndex()
	;Now activate the window based on CurrentWin.
	WinActivate, % "ahk_id " WindowGroupF6[CurrentWinF6]
	return
}

;Activate previous window.
PrevWindowF6() {
	; Decrement the current window by 1.
	CurrentWinF6--
	; If it's lower than the lowest index, set CurrentWindow to the maxindex.
	if (CurrentWinF6 < WindowGroupF6.MinIndex())
		CurrentWinF6 := WindowGroupF6.MaxIndex()
	; Now activate that window based on CurrentWin.
	WinActivate, % "ahk_id " WindowGroupF6[CurrentWinF6]
	return
}

;Removes windows that don't exist anymore—and their IDs—from the array.
;E.g., if you close a window, and its ID is still in the array,
;loop through the array and remove any IDs for windows that don't exist.
RemoveNonexistentWindowsF6() {
	;Loop through the F6 ID array.
	for indexF6, value in WindowGroupF6
	{
		;If the window with the ID of "value" at the current index doesn't exist...
		if !WinExist("ahk_id" value)
		{
			;Remove it from the array.
			WindowGroupF6.RemoveAt(indexF6)	
		}
	}
	return

}

;*************************************************F7 GROUP STUFF*************************************************
^F7::
AddWindowF7()
return
^!F7::
RemoveWindowF7()
return
F7::
NextWindowF7()
return
+F7::
PrevWindowF7()
return
^+F7::
RemoveNonexistentWindowsF7()
return

AddWindowF7() {
	ToolTip, Added to F7 Group!
	Sleep, 200
	ToolTip
	
	; Get the active window's ID
	WinGet, thisIDF7, ID, A
	; Value to track if ID was found in the group
	foundF7 := False
	; Loop through all the IDs
	for indexF7, value in WindowGroupF7
	{
		; If the current ID was found inside the array
		if (value = thisIDF7) {
			; Then mark it as found and break the loop
			foundF7 = True
			Break
		}
	}
	
	; If the ID was never found in the array
	if (foundF7 = False)
		; Add it to the array
		WindowGroupF7.Push(thisIDF7)
	return
}

RemoveWindowF7() {
	ToolTip, Removed from F7 Group!
	Sleep, 200
	ToolTip
	
	WinGet, thisIDF7, ID, A
	foundF7 := False
	for indexF7, value in WindowGroupF7
	{
		; Same as the AddWindow function except if a match is found, remove it from the array
		if (value = thisIDF7) {
			WindowGroupF7.RemoveAt(indexF7)
			Break
		}
	}
	return
}

NextWindowF7() {
	; Increment the current window by 1
	CurrentWinF7++
	; If the current window is greater than the number of entries in the array
	if (CurrentWinF7 > WindowGroupF7.MaxIndex())
		; Then reset it to the lowest index
		CurrentWinF7 := WindowGroupF7.MinIndex()
	; Now activate the window based on CurrentWin
	WinActivate, % "ahk_id " WindowGroupF7[CurrentWinF7]
	return
}

PrevWindowF7() {
	; Decrement the current window by 1
	CurrentWinF7--
	; If it's lower than the lowest index, set CurrentWindow to the maxindex
	if (CurrentWinF7 < WindowGroupF7.MinIndex())
		CurrentWinF7 := WindowGroupF7.MaxIndex()
	; Now activate that window based on CurrentWin
	WinActivate, % "ahk_id " WindowGroupF7[CurrentWinF7]
	return
}

RemoveNonexistentWindowsF7() {
	;Loop through the F7 ID array.
	for indexF7, value in WindowGroupF7
	{
		;If the window with the ID of "value" at the current index doesn't exist...
		if !WinExist("ahk_id" value)
		{
			;Remove it from the array.
			WindowGroupF7.RemoveAt(indexF7)	
		}
	}
	return

}