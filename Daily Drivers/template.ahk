#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the main file that links all of my other classes together, plus some other things.

Menu, Tray, Icon, shell32.dll, 174 ;Changes the icon to a keyboard; perfect for the Main Script file

;Constantly checking to see what profile you should be in
Loop {
global current_profile := AutoSelectProfiles()
}

;Linking other scripts together
;The variable %A_ScriptDir% is the full path of the directory where the script is located.

#Include, %A_ScriptDir%\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Auto Capitalize.ahk
#Include, %A_ScriptDir%\Auto Correct.ahk
#Include, %A_ScriptDir%\Default.ahk
#Include, %A_ScriptDir%\NumPad Media Control.ahk
#Include, %A_ScriptDir%\Profile Switcher.ahk
#Include, %A_ScriptDir%\SciTE4AutoHotkey Programming.ahk




;****************************************GLOBAL HOTKEYS***************************************
;These global hotkeys are hotkeys that are always running, regardless of the active window, class, or whatever
;Pushing Windows Key + P suspends all hotkeys, thus "pausing" the script. Useful for when I'm playing games or something.
#P::Suspend

;Used for reloading this script, incase something wonky happens.
^+r::
ToolTip, Reloading!
Sleep, 200
ToolTip
Reload
return


;****************************************MOUSE ACTIONS****************************************
;Function key = G# + 12
;Ex. Function key for G5 = 5 + 12 = 17


;Profile switch button (top button)
^!F23::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseProfileSwitchDefault()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

;DPI Toggle button (bottom button)
^!F24::

return

F13::

return

F14::

return

F15::

return

F16::

return

F17::

return

F18::

return

F19::

return

F20::

return

F21::

return

F22::

return

F23::
;EXAMPLE. It needs to be done like this. Because, if I do it like how I have it with Default now, but in every other file, it isn't going to like that
;~ if (current_profile = "Default") {
;~ MouseG11Default()
;~ }
return

F24::

return

;****************************************KEYBOARD ACTIONS****************************************
;Function key = G# + 12
;Ex. Function key for G5 = 5 + 12 = 17
;Ran out of function keys at ^F24, so I started over at F13 with Alt + F13. Should work just fine.

^F13::

return

^F14::

return

^F15::

return

^F16::

return

^F17::

return

^F18::

return

^F19::

return

^F20::

return

^F21::

return

^F22::
return

^F23::

return

^F24::

return

!F13::

return

!F14::

return

!F15::

return

!F16::

return

!F17::

return

!F18::

return












#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the Default class


;****************************************MOUSE ACTIONS****************************************

/*



;****************************************KEYBOARD ACTIONS****************************************
;Function key = G# + 12
;Ex. Function key for G5 = 5 + 12 = 17
;Ran out of function keys at ^F24, so I started over at F13 with Alt + F13. Should work just fine.

^F13::
Run, C:\Program Files\Mozilla Firefox\firefox.exe
return

^F14::
Run, C:\Program Files\iTunes\iTunes.exe
return

^F15::
Send, #x
Sleep, 250
Send, {Up 2}
Send, {Right}
Send, {Down}
return

^F16::
Run, notepad.exe
return

^F17::

return

;G6 runs task manager
^F18::
Run, Taskmgr.exe
return

^F19::

return

^F20::

return

;G9 does Shift + Delete
^F21::
Send, +{Delete}
return

^F22::

return

^F23::

return

^F24::

return

!F13::
Send, ^#{F4}
return

!F14::
Send, ^#d
return

!F15::

return

!F16::
Send, #{Tab}
return

!F17::
Send, ^#{Left}
return

!F18::
Send, ^#{Right}
return
*/

;****************************************METHODS***************************************


;****************************************MOUSE METHODS***************************************
MouseProfileSwitchDefault() {
;Left double click
Send, {Click 2}
return
}


MouseDPIToggleDefault() {
}

MouseG1Default() {
Send {Shift down}
}

MouseG2Default() {
}

MouseG3Default() {
}

MouseG4Default() {
}

MouseG5Default() {
}

MouseG6Default() {
;Next page in History
Send, !{Left}
}

MouseG7Default() {
}

MouseG8Default() {
}

MouseG9Default() {
;Previous page in History
Send, !{Right}
}

MouseG10Default() {
}

MouseG11Default() {
;Pushing F23 (G11) minimizes the current active window
WinMinimize, A
}

MouseG12Default() {
}


;****************************************KEYBOARD METHODS***************************************
KeyboardG1Default() {
Run, C:\Program Files\Mozilla Firefox\firefox.exe
}

KeyboardG2Default() {
Run, C:\Program Files\iTunes\iTunes.exe
}

KeyboardG3Default() {
Send, #x
Sleep, 250
Send, {Up 2}
Send, {Right}
Send, {Down}
return
}

KeyboardG4Default() {
Run, notepad.exe
}

KeyboardG5Default() {
}

KeyboardG6Default() {
Run, Taskmgr.exe
return
}

KeyboardG7Default() {
}

KeyboardG8Default() {
}

KeyboardG9Default() {
;G9 does Shift + Delete
Send, +{Delete}
return
}

KeyboardG10Default() {
;Open a new Incognito Chrome window/tab and goes to google.com (used on the Desktop or anywhere else)
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito http://www.google.com/
return
}

KeyboardG11Default() {
;This enables/disables Bluetooth.
Send, #a
Sleep, 1100
Send, {Tab 2}
Sleep 200
Send, {Down 2}
Sleep 654
Send, {Enter}
Sleep 900
Send, #a
return
}

KeyboardG12Default() {
}

KeyboardG13Default() {
;Closes a virtual desktop
Send, ^#{F4}
return
}

KeyboardG14Default() {
;Creates a virtual desktop
Send, ^#d
return
}

KeyboardG15Default() {
}

KeyboardG16Default() {
;Does what Win + Tab does
Send, #{Tab}
return
}

KeyboardG17Default() {
;Goes to the virtual desktop to the left
Send, ^#{Left}
return
}

KeyboardG18Default() {
;Goes to the virtual desktop to the right
Send, ^#{Right}
return
}
















#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the main file that links all of my other classes together, plus some other things.

Menu, Tray, Icon, shell32.dll, 174 ;Changes the icon to a keyboard; perfect for the Main Script file

;Constantly checking to see what profile you should be in
Loop {
global current_profile := AutoSelectProfiles()
}

;Linking other scripts together
;The variable %A_ScriptDir% is the full path of the directory where the script is located.

#Include, %A_ScriptDir%\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Auto Capitalize.ahk
#Include, %A_ScriptDir%\Auto Correct.ahk
#Include, %A_ScriptDir%\Default.ahk
#Include, %A_ScriptDir%\NumPad Media Control.ahk
#Include, %A_ScriptDir%\Profile Switcher.ahk
#Include, %A_ScriptDir%\SciTE4AutoHotkey Programming.ahk




;****************************************GLOBAL HOTKEYS***************************************
;These global hotkeys are hotkeys that are always running, regardless of the active window, class, or whatever
;Pushing Windows Key + P suspends all hotkeys, thus "pausing" the script. Useful for when I'm playing games or something.
#P::Suspend

;Used for reloading this script, incase something wonky happens.
^+r::
ToolTip, Reloading!
Sleep, 200
ToolTip
Reload
return


;****************************************MOUSE ACTIONS****************************************
;Function key = G# + 12
;Ex. Function key for G5 = 5 + 12 = 17


;Profile switch button (top button)
^!F23::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseProfileSwitchDefault()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

;DPI Toggle button (bottom button)
^!F24::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseDPIToggleDefault()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F13::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG1Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F14::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG2Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F15::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG3Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F16::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG4Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F17::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG5Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F18::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG6Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F19::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG7Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F20::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG8Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F21::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG9Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F22::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG10Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F23::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG11Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

F24::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	MouseG12Default()
} else if (current_profile = "Chrome") {
	return
} else if (current_profile = "iTunes") {
	return
} else if (current_profile = "SciTE4AutoHotkey") {
	return
} else if (current_profile = "Firefox_Docs") {
	return
} else if (current_profile = "Chrome_Docs") {
	return
} else {
	return
}
return

;****************************************KEYBOARD ACTIONS****************************************
;Function key = G# + 12
;Ex. Function key for G5 = 5 + 12 = 17
;Ran out of function keys at ^F24, so I started over at F13 with Alt + F13. Should work just fine.

^F13::

return

^F14::

return

^F15::

return

^F16::

return

^F17::

return

^F18::

return

^F19::

return

^F20::

return

^F21::

return

^F22::
return

^F23::

return

^F24::

return

!F13::

return

!F14::

return

!F15::

return

!F16::

return

!F17::

return

!F18::

return
