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

;A lot of this code is taken from Taran Van Hemert from Linus Media Group.
;His video on this: https://www.youtube.com/watch?v=OqyQABySV8k
;As he calls it, this is his most useful script he's ever made.
;It's quite simple, but extremely useful and powerful.
;All of this stuff works beautifully.

;3/2/2020: something I've noticed is this example:
;Say you have 2 virtual desktops, and you have a window on each virtual desktop. If you have both in the same group, and you try to
; activate the other window on the other virtual desktop, it will not activate. It never used to do this, but now it does.
;This is actually pretty awesome.

;Toggles between showing and hiding the help GUI for ApplicationSwitcher.ahk
!a::
showApplSwitchGUIToggle := !showApplSwitchGUIToggle

if (showApplSwitchGUIToggle = 1)
	GUI, ApplSwitchGUI:Show, x600 y90 w510 h580, ApplicationSwitcher.ahk Hotkey Help Window
else
	GUI, ApplSwitchGUI:Hide
return

;If a Firefox window doesn't exist, run Firefox.
;If a Firefox window does exist, switch to Chrome.
;If Firefox is active, send ^PGDN (switch between tabs).
F1::
switchToFirefoxAndBetweenTabs() {
	IfWinNotExist, ahk_class MozillaWindowClass
		Run, firefox.exe
	if WinActive("ahk_exe firefox.exe")
			Send ^{PGDN}
	else {
		;WinRestore ahk_exe firefox.exe
		WinActivatebottom ahk_exe firefox.exe
		;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
		;the below code should fix that.
		WinGet, hWnd, ID, ahk_class MozillaWindowClass
		DllCall("SetForegroundWindow", UInt, hWnd)
	}
}
return

;Same thing as F1, but reverse order (PGUP instead of PGDN).
+F1::
switchToFirefoxAndBetweenTabsReverse() {
	IfWinNotExist, ahk_class MozillaWindowClass
		Run, firefox.exe
	if WinActive("ahk_exe firefox.exe")
			Send ^{PGUP}
	else {
		;WinRestore ahk_exe firefox.exe
		WinActivatebottom ahk_exe firefox.exe
		;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
		;the below code should fix that.
		WinGet, hWnd, ID, ahk_class MozillaWindowClass
		DllCall("SetForegroundWindow", UInt, hWnd)
	}
}
return

;If a Firefox window doesn't exist, run Firefox.
;If Firefox windows do exist, add them to a window
; group and switch between them.
F2::
switchToOtherFirefoxWindows() {
	If WinNotExist, ahk_class MozillaWindowClass
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
return

;Create a new normal Firefox window.
^F1::
Run, firefox.exe
return

;Create a new normal Firefox window.
^F2::
Run, firefox.exe
return

;Create a new Private Firefox window.
^!F2::
Run, firefox.exe -private-window
return

;If a Chrome window doesn't exist, run Chrome.
;If a Chrome window does exist, switch to Chrome.
;If Chrome is active, send ^PGDN (switch between tabs).
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

;Same thing as F3, but reverse order (PGUP instead of PGDN).
+F3::
switchToChromeAndTabsReverse()
{
IfWinNotExist, ahk_class Chrome_WidgetWin_1
	Run, chrome.exe
if WinActive("ahk_exe chrome.exe")
	Send ^{PGUP}
else
	WinActivate ahk_exe chrome.exe
}
return

;If a Chrome window doesn't exist, run Chrome.
;If Chrome windows do exist, switch between them.
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

;Create a new normal Chrome window.
^F3::
Run, chrome.exe
return

;Create a new normal Chrome window.
^F4::
Run, chrome.exe
return

;Create a new incognito Chrome window.
^!F3::
Run, chrome.exe -incognito
return

;Create a new incognito Chrome window.
^!F4::
Run, chrome.exe -incognito
return


;MR button on my K95 RGB keyboard.
;Used for activating and switching to File Explorer windows.
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

;Back button; does stuff in reverse.
;Ex. F9 in Firefox does the opposite of F1.
F9::
if WinActive("ahk_exe firefox.exe")
	Send ^{PgUp}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
return

;Switch between MS Word windows.
F12::
GroupAdd, taranwords, ahk_class OpusApp
if WinActive("ahk_class OpusApp")
	GroupActivate, taranwords, r
else
	WinActivate ahk_class OpusApp
return


;****************************************************CUSTOM GROUP STUFF****************************************************
;*************************************************F6 GROUP STUFF*************************************************
;Credits for this F6 stuff goes to GroggyOtter from the AHK subreddit:
;https://www.reddit.com/r/AutoHotkey/comments/dbil7u/add_active_window_to_group_and_push_button_to/f241ak3?utm_source=share&utm_medium=web2x
;I modified it a teeny tiny bit, plus added the F7 one. It's really nice having this for both F6 and F7.
^F6::
AddWindowF6()
return


!F6::
ActivateBothF6AndF7Windows() ;Activate windows in both the F6 and F7 array.
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

	;Quick little prompt telling the user the window was added.
	ToolTip, Added to F6 Group!
	Sleep, 200
	ToolTip

	;Get the active window's ID
	WinGet, thisIDF6, ID, A
	;Value to track if ID was found in the group
	foundF6 := false
	;Loop through all the IDs
	for indexF6, value in WindowGroupF6
	{
		;If the current ID was found inside the array
		if (value = thisIDF6) {
			;Then mark it as found and break the loop
			foundF6 = true
			break
		}
	}

	;If the ID was never found in the array
	if (foundF6 = false)
		;Add it to the array
		WindowGroupF6.Push(thisIDF6)
		F6andF7WinIDArray.Push(thisIDF6)
	return
}

;Remove the curent window from the array.
RemoveWindowF6() {
	ToolTip, Removed from F6 Group!
	Sleep, 200
	ToolTip

	WinGet, thisIDF6, ID, A
	foundF6 := false
	for indexF6, value in WindowGroupF6
	{
		;Same as the AddWindow function except if a match is found, remove it from the array
		if (value = thisIDF6) {
			WindowGroupF6.RemoveAt(indexF6)
			F6andF7WinIDArray.RemoveAt(thisIDF6)
			break
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
	WinActivate, % "ahk_id" WindowGroupF6[CurrentWinF6]
	return
}

;Activate previous window.
PrevWindowF6() {
	;Decrement the current window by 1.
	CurrentWinF6--
	;If it's lower than the lowest index, set CurrentWindow to the maxindex.
	if (CurrentWinF6 < WindowGroupF6.MinIndex())
		CurrentWinF6 := WindowGroupF6.MaxIndex()
	;Now activate that window based on CurrentWin.
	WinActivate, % "ahk_id" WindowGroupF6[CurrentWinF6]
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
			F6andF7WinIDArray.RemoveAt(thisIDF6)
		}
	}
	return

}

;*************************************************F7 GROUP STUFF*************************************************
;Identical to F6 Group Stuff, but for the F7 key. Thus, allowing me to have 2 custom window groups.
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

	;Get the active window's ID
	WinGet, thisIDF7, ID, A
	;Value to track if ID was found in the group
	foundF7 := false
	;Loop through all the IDs
	for indexF7, value in WindowGroupF7
	{
		;If the current ID was found inside the array
		if (value = thisIDF7) {
			;Then mark it as found and break the loop
			foundF7 = true
			break
		}
	}

	;If the ID was never found in the array.
	if (foundF7 = false)
		;Add it to the array.
		WindowGroupF7.Push(thisIDF7)
		F6andF7WinIDArray.Push(thisIDF7)
	return
}

RemoveWindowF7() {
	ToolTip, Removed from F7 Group!
	Sleep, 200
	ToolTip

	WinGet, thisIDF7, ID, A
	foundF7 := false
	for indexF7, value in WindowGroupF7
	{
		;Same as the AddWindow function except if a match is found, remove it from the array
		if (value = thisIDF7) {
			WindowGroupF7.RemoveAt(indexF7)
			F6andF7WinIDArray.RemoveAt(thisIDF7)
			break
		}
	}
	return
}

NextWindowF7() {
	;Increment the current window by 1
	CurrentWinF7++
	;If the current window is greater than the number of entries in the array
	if (CurrentWinF7 > WindowGroupF7.MaxIndex())
		;Then reset it to the lowest index
		CurrentWinF7 := WindowGroupF7.MinIndex()
	;Now activate the window based on CurrentWin
	WinActivate, % "ahk_id" WindowGroupF7[CurrentWinF7]
	return
}

PrevWindowF7() {
	;Decrement the current window by 1
	CurrentWinF7--
	;If it's lower than the lowest index, set CurrentWindow to the maxindex
	if (CurrentWinF7 < WindowGroupF7.MinIndex())
		CurrentWinF7 := WindowGroupF7.MaxIndex()
	;Now activate that window based on CurrentWin
	WinActivate, % "ahk_id" WindowGroupF7[CurrentWinF7]
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
			F6andF7WinIDArray.RemoveAt(thisIDF7)
		}
	}
	return

}

;*************************************************MISC F6 AND F7*************************************************
;Loop through the F6 AND F7 window arrays.
ActivateBothF6AndF7Windows() {
	;Increment the current window by 1.
	CurrentWinF6AndF7ActBoth++
	;If the current window value is greater than the number of entries in the array.
	if (CurrentWinF6AndF7ActBoth > F6andF7WinIDArray.MaxIndex())
		;Then reset it to the lowest index.
		CurrentWinF6AndF7ActBoth := F6andF7WinIDArray.MinIndex()
	;Now activate the window based on CurrentWinF6AndF7ActBoth.
	WinActivate, % "ahk_id" F6andF7WinIDArray[CurrentWinF6AndF7ActBoth]
	return
}