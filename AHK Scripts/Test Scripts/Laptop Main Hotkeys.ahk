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
DetectHiddenWindows, On
#SingleInstance force
;OPTIMIZATIONS END

;This script allows me to send any Main Script.ahk hotkey for my K95 keyboard and Scimitar mouse on my laptop.
;All I have to do is type Gx, or Mx, and it'll send the hotkey and do the corresponding
; command, based on the current running application.
;X in this case is the number on the physical key: G1–G18 for keyboard, and M1-M14 for mouse.
;M13 and M14 are the Profile Switch and DPI Toggle buttons, respectively (front and back mouse buttons).

;Alt + a opens the InputBox, which allows the user to type the Main Script.ahk hotkey they want to send.
!a::

InputBox, laptopMainInputBoxText,Type a Main Script.ahk hotkey,Type the Main Script.ahk hotkey you want to send.

;The script decides which hotkey to send.
Switch (laptopMainInputBoxText) {


Case "G1":
    Send, ^{F13}
return

; Case "G2": Send, ^{F14}
; Case "G3": Send, ^{F15}
; Case "G4": Send, ^{F16}
; Case "G5": Send, ^{F17}
; Case "G6": Send, ^{F18}
; Case "G7": Send, ^{F19}
; Case "G8": Send, ^{F20}
; Case "G9": Send, ^{F21}
; Case "G10": Send, ^{F22}
; Case "G11": Send, ^{F23}
; Case "G12": Send, ^{+F23}
; Case "G13": Send, !{F13}
; Case "G14": Send, !{F14}
; Case "G15": Send, !{F15}
; Case "G16": Send, !{F16}
; Case "G17": Send, !{F17}
; Case "G18": Send, !{F18}
}
return