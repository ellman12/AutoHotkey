#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the Default profile.


;******************************************METHODS************************************************

;****************************************MOUSE METHODS***************************************
MouseProfileSwitchDefault() {
;Left double click
Send, {Click 2}
return
}

MouseDPIToggleDefault() {
}

MouseG1Default() {
;"Holds" down Shift for scroling horizontally
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return
}

MouseG2Default() {
}

MouseG3Default() {
;While G3 is held, make the mouse pointer faster.
;When it's not being held, it's normal speed.
;IDK how these things work, but the 17 and 10 are the mouse speeds.
;Found this stuff online somewhere.
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, F15
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return
}

MouseG4Default() {
}

MouseG5Default() {
}

MouseG6Default() {
;Next page in History
Send, !{Right}
return
}

MouseG7Default() {
}

MouseG8Default() {
}

MouseG9Default() {
;Previous page in History
Send, !{Left}
return
}

MouseG10Default() {
}

MouseG11Default() {
;Pushing F23 (G11) minimizes the current active window
WinMinimize, A
return
}

MouseG12Default() {
}


;****************************************KEYBOARD METHODS***************************************
KeyboardG1Default() {
Run, C:\Program Files\Mozilla Firefox\firefox.exe
return
}

KeyboardG2Default() {
Run, C:\Program Files\iTunes\iTunes.exe
return
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
Send, ^#{d}
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