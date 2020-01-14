#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the profile to help me program in AHK in SciTE4AutoHotkey.

;****************************************MOUSE ACTIONS***************************************

#If current_profile = "SciTE4AutoHotkey"
;Mouse Profile Switch
;Left double click
^!F23::
Send, {Click 2}
return

;Mouse DPI Toggle
^!F24::
return

;Mouse G1
;"Holds" down Shift for scroling horizontally
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2
F14::
return

;Mouse G3
*F15::
;While G3 is held, make the mouse pointer faster.
;When it's not being held, it's normal speed.
;IDK how these things work, but the 17 and 10 are the mouse speeds.
;Found this stuff online somewhere.
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, F15
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;Mouse G4
;(Ctrl + O) Open a file(s)
F16::
Send, ^o
return

;Mouse G5
;Go one tab to the right
F17::
Send, ^{PGDN}
return

;Mouse G6
F18::
return

;Mouse G7
;Close current tab.
F19::
Send, ^w
return

;Mouse G8
;Go one tab to the left
F20::
Send, ^{PGUP}
return

;Mouse G9
F21::
return

;Mouse G10
F22::
return

;Mouse G11
;Pushing F23 (G11) minimizes the current active window
F23::
WinMinimize, A
return

;Mouse G12
F24::
return

;****************************************KEYBOARD ACTIONS***************************************
;Keeb G1
;Previous word part
^F13::
Send, ^/
return

;Keeb G2
;Next word part
^F14::
Send, ^\
return

;Keeb G3
;Copy
^F15::
Send, ^c
return

;Keeb G4
;Cut
^F16::
Send, ^x
return

;Keeb G5
;For switching between tabs
^F17::
Send, ^{Tab}
return

;Keeb G6
;Paste
^F18::
Send, ^v
return

;Keeb G7
;Comment out line
^F19::
Send, ^q
return

;Keeb G8
;Ctrl + Page Up (Go one Tab to the Left)
^F20::
Send, ^{PGUP}
return

;Keeb G9
;Ctrl + Page Down (Go one Tab to the Right)
^F21::
Send, ^{PGDN}
return

;Keeb G10
;Open a new Incognito Chrome window/tab and goes to google.com
^F22::
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito http://www.google.com/
return

;Keeb G11
;Previous paragraph
^F23::
Send, ^[
return

;Keeb G12
;Next paragraph
^F24::
Send, ^]
return

;Keeb G13
;Closes a virtual desktop
!F13::
Send, ^#{F4}
return

;Keeb G14
;Creates a virtual desktop
!F14::
Send, ^#{d}
return

;Keeb G15
;Line transpose (switch) with previous
!F15::
Send, ^t
return

;Keeb G16
;Does what Win + Tab does
!F16::
Send, #{Tab}
return

;Keeb G17
;Goes to the virtual desktop to the left
!F17::
Send, ^#{Left}
return

;Keeb G18
;Goes to the virtual desktop to the right
!F18::
Send, ^#{Right}
return

;****************************************MISC SCITE4AUTOHOTKEY ACTIONS***************************************
;(Ctrl + Backspace) Delete an entire word
\::
Send, ^{BackSpace}
return

;Get the mouse's current position, moves the mouse to the Run button in SciTE, and clicks it.
;This works more reliably than the janky F5 keyboard shortcut in SciTE.
;It does this so fast that if you blink, you'll miss it.
F5::
MouseGetPos, F5MouseX, F5MouseY 
MouseMove, 395, 60, 0
Send, {Click}
MouseMove, %F5MouseX%, %F5MouseY%, 0
return

#If