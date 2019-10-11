#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;A lot of this code is taken from Taran Van Hemert from Linus Media Group
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
switchToOtherFirefoxWindows(){
Process, Exist, firefox.exe
	If errorLevel = 0
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
	{
	WinGetClass, class, A
if WinActive("ahk_exe chrome.exe")
	Send ^{PGDN}
else
	{
	WinActivateBottom ahk_exe chrome.exe
	WinGet, hWnd, ID, ahk_class Chrome_WidgetWin_1
	DllCall("SetForegroundWindow", UInt, hWnd)
	}
	
  }	

}

F4::
switchToOtherChromeWindows()
{
Process, Exist, chrome.exe
	If errorLevel = 0
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

F9::
if WinActive("ahk_exe firefox.exe")
	Send ^{PgUp}
if WinActive("ahk_class Chrome_WidgetWin_1")
	Send ^+{tab}
if WinActive("ahk_exe explorer.exe")
	Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
return



;*******************************CUSTOM GROUP STUFF*******************************
;Credits for this F6 stuff goes to this guy on Reddit: 
;https://www.reddit.com/r/AutoHotkey/comments/dbil7u/add_active_window_to_group_and_push_button_to/f241ak3?utm_source=share&utm_medium=web2x
;I don't really know how it works, but it's fantastic. Thanks m8.
^F6::
AddWindow()
return
^!F6::
RemoveWindow()
return
F7::
NextWindow()
return
F6::
PrevWindow()
return


AddWindow(){
	ToolTip, Added to Group!
	Sleep, 200
	ToolTip
	
	; Get the active window's ID
	WinGet, thisID, ID, A
	; Value to track if ID was found in the group
	found := False
	; Loop through all the IDs
	for index, value in WindowGroup
	{
		; If the current ID was found inside the array
		If (value = thisID){
			; Then mark it as found and break the loop
			found = True
			Break
		}
	}
	
	; If the ID was never found in the array
	If (found = False)
		; Add it to the array
		WindowGroup.Push(thisID)
	Return
}

RemoveWindow(){
	ToolTip, Removed from Group!
	Sleep, 200
	ToolTip
	
	WinGet, thisID, ID, A
	found := False
	for index, value in WindowGroup
	{
		; Same as the AddWindow function except if a match is found, remove it from the array
		If (value = thisID){
			WindowGroup.RemoveAt(index)
			Break
		}
	}
	Return
}

NextWindow(){
	; Increment the current window by 1
	CurrentWin++
	; If the current window is greater than the number of entries in the array
	If (CurrentWin > WindowGroup.MaxIndex())
		; Then reset it to the lowest index
		CurrentWin := WindowGroup.MinIndex()
	; Now activate the window based on CurrentWin
	WinActivate, % "ahk_id " WindowGroup[CurrentWin]
	Return
}

PrevWindow(){
	; Decrement the current window by 1
	CurrentWin--
	; If it's lower than the lowest index, set CurrentWindow to the maxindex
	If (CurrentWin < WindowGroup.MinIndex())
		CurrentWin := WindowGroup.MaxIndex()
	; Now activate that window based on CurrentWin
	WinActivate, % "ahk_id " WindowGroup[CurrentWin]
	Return
}



;*********************************************COMMENTED OUT GARBAGE***********************************************
;~ F6::
;~ switchToExplorer(){
;~ IfWinNotExist, ahk_class CabinetWClass
	;~ Run, explorer.exe
;~ GroupAdd, taranexplorers, ahk_class CabinetWClass
;~ if WinActive("ahk_exe explorer.exe")
	;~ GroupActivate, taranexplorers, r
;~ else
	;~ WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
;~ }