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

;This script is the Default profile.

;****************************************MOUSE ACTIONS***************************************
#If currentProfile = "Default"
;Mouse Profile Switch.
;Left double click.
^!F23::
Send, {Click 2}
return

;Mouse DPI Toggle.
^+F23::
return

;Mouse G1
;"Holds" down Shift for scroling horizontally.
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2
;(Alt + Up) Go up one folder in File Explorer.
F14::
Send, !{Up}
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
;Open new tab.
F16::
Send, ^t
return

;Mouse G5
;Go one tab to the right.
F17::
Send, ^{PGDN}
return

;Mouse G6
;Next page in History.
F18::
Send, !{Right}
return

;Mouse G7
;Close tab.
F19::
Send, ^w
return

;Mouse G8
;Go one tab to the left.
F20::
Send, ^{PGUP}
return

;Mouse G9
;Previous page in History.
F21::
Send, !{Left}
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
;Reopen the last closed Browser tab, and jump to it.
+F23::
Send, ^+t
return

;****************************************KEYBOARD ACTIONS***************************************
;Keeb G1
^F13::
return

;Keeb G2
^F14::
return

;Keeb G3
;Improved Sleep Macro + Manual Enter
^F15::
Send, #x
Sleep, 250
Send, {Up 2}
Send, {Right}
Send, {Down}
return

;Keeb G4
;Open Notepad
^F16::
Run, notepad.exe
return

;Keeb G5
^F17::
return

;Keeb G6
;Open Task Manager
^F18::
Run, Taskmgr.exe
return

;Keeb G7
;(Ctrl + Shift + N) Create new folder in File Explorer
^F19::
Send, ^+n
return

;Keeb G8
^F20::
return

;Keeb G9
;G9 does Shift + Delete
^F21::
Send, +{Delete}
return

;Keeb G10
;Open a new Incognito Chrome window/tab and goes to google.com
^F22::
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito http://www.google.com/
return

;Keeb G11
;This enables/disables Bluetooth.
^F23::
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

;Keeb G12
!F23::
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
!F15::
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

#If