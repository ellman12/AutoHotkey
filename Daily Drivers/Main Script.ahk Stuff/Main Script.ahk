#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the main file that links all of my other scripts together, plus some other things.

Menu, Tray, Icon, shell32.dll, 174 ;Changes the icon to a keyboard; perfect for the Main Script file

;Variables for F6 group stuff
;Tracks all windows you want as part of your custom group
Global WindowGroup := []
;Tracks the current window you're on
Global CurrentWin := 1

;Constantly checking to see what profile you should be in
Loop {
global current_profile := AutoSelectProfiles()
#Include, %A_ScriptDir%\NumPad Media Control.ahk ;For some reason this file only works when put in this loop...? *Shrug*
}

;Linking other scripts together
;The variable %A_ScriptDir% is the full path of the directory where the script is located.

#Include, %A_ScriptDir%\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Auto Capitalize.ahk
#Include, %A_ScriptDir%\Auto Correct.ahk
#Include, %A_ScriptDir%\Default.ahk
#Include, %A_ScriptDir%\Profile Switcher.ahk
#Include, %A_ScriptDir%\SciTE4AutoHotkey Programming.ahk


;****************************************GLOBAL HOTKEYS***************************************
;These global hotkeys are hotkeys that are always running, regardless of the active window, class, or whatever
;Pushing Windows Key + P suspends all hotkeys, thus "pausing" the script. Useful for when I'm playing games or something.
#p::Suspend

;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab. This scan code is for the grave accent key.
sc029::
Send, !{Tab}
return

;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `. This scan code is for the grave accent key.
^sc029::
Send, ``
return

;Moves mouse pointer as far off the screen as possible (on main display); usually either to A, get it out of the way, or B, so I can easily find it.
Insert::
MouseMove, 5000, 540, 0
return

;Moves mouse pointer as far off the screen as possible (on second display); usually either to A, get it out of the way, or B, so I can easily find it.
^Insert::
MouseMove, -1920, 540, 0
return

;Disables it. Use Ctrl + CapsLock to enable/disable it. This prevents accidentally pressing it.
CapsLock::
return

^CapsLock::
if state := GetKeyState("CapsLock", "T")
    SetCapsLockState, Off
else
    SetCapsLockState, On
return

;Disables this ANNOYING keyboard shortcut. It does Win + Tab for some unknown reason...?
^#Backspace::
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
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG1Default()
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

^F14::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG2Default()
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

^F15::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG3Default()
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

^F16::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG4Default()
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

^F17::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG5Default()
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

^F18::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG6Default()
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

^F19::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG7Default()
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

^F20::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG8Default()
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

^F21::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG9Default()
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

^F22::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG10Default()
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

^F23::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG11Default()
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

^F24::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG12Default()
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

!F13::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG13Default()
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

!F14::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG14Default()
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

!F15::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG15Default()
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

!F16::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG16Default()
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

!F17::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG17Default()
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

!F18::
if (current_profile = "Firefox") {
	return
} else if (current_profile = "Default") {
	KeyboardG18Default()
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