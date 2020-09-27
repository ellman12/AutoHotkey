;///////////////////////////////////////////////////////////////////////
;//File: Custom NumPad.ahk
;///////////////////////////////////////////////////////////////////////
;//Purpose: Acts as an easier way to enter numbers, symbols, etc.
;///////////////////////////////////////////////////////////////////////
;//Programmer: Elliott DuCharme.
;///////////////////////////////////////////////////////////////////////
;//Created: Saturday, September 26, 2020.
;///////////////////////////////////////////////////////////////////////
;//Comments: Originally designed for use with online math homework things
;// like Cengage WebAssingn and the like.
;///////////////////////////////////////////////////////////////////////

;TODO: Add this to Run.
;TODO: Add mult, div, add, sub, (), to either symbols or somewhere else. Probs make constants its own thing and symbols and numbers and the like below it.
;TODO: GUIclose and escape(?), etc. Close the script.

#NoEnv
#MaxHotkeysPerInterval 999999999999999999999999999999999
#HotkeyInterval 99999999999999999999999999999999999
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
DetectHiddenWindows, Off
#SingleInstance force

;****CONTROL DISTANCES REFERENCE****
;Distance between GroupBox and button: 17 pixels
;Distance between GroupBoxes: 55 pixels

Menu, Tray, Icon, %A_ScriptDir%\Custom NumPad Icon.png

;Symbols & Constants (pi, e, (), ∞, -∞).
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w288 h55 x2 y0,Symbols && Constants

GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, w40 h33 x6 y17 , &(
GUI, NumPad:Add, Button, wp hp xp+40 yp , &)
GUI, NumPad:Add, Button, wp hp xp+40 yp , inf
GUI, NumPad:Add, Button, wp hp xp+40 yp , -inf
GUI, NumPad:Add, Button, wp hp xp+40 yp , &Pi
GUI, NumPad:Add, Button, wp hp xp+40 yp , e
GUI, NumPad:Add, Button, wp hp xp+40 yp , &e^

;Exponents (x^-1, x^-2, x^y, x^2, x^3, x^4, x^5, x^6)
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w288 h55 x2 y55,Exponents

GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, w40 h33 x6 y72 , x^-&1
GUI, NumPad:Add, Button, wp hp xp+40 yp , x^-2
GUI, NumPad:Add, Button, wp hp xp+40 yp , x^&y
GUI, NumPad:Add, Button, wp hp xp+40 yp , x^&2
GUI, NumPad:Add, Button, wp hp xp+40 yp , x^&3
GUI, NumPad:Add, Button, wp hp xp+40 yp , x^&4
GUI, NumPad:Add, Button, wp hp xp+40 yp , x^&5

;Variables (x, y, z, theta, a, b, c).
; GUI, NumPad:Font, s10
; GUI, NumPad:Add, GroupBox, w288 h55 x2 y0,Symbols && Constants

; GUI, NumPad:Font, s12
; GUI, NumPad:Add, Button, w40 h33 x6 y17 ,
; GUI, NumPad:Add, Button, wp hp xp+40 yp ,
; GUI, NumPad:Add, Button, wp hp xp+40 yp ,
; GUI, NumPad:Add, Button, wp hp xp+40 yp ,
; GUI, NumPad:Add, Button, wp hp xp+40 yp ,
; GUI, NumPad:Add, Button, wp hp xp+40 yp ,
; GUI, NumPad:Add, Button, wp hp xp+40 yp ,

;Operators (+, -, ×, ÷, , √).


;Functions (sin, cos, tan, csc, sec, cot, log, ln)


GUI, NumPad:+AlwaysOnTop
GUI, NumPad:Show, w293 h400 x1203 y652

return

;*********LABELS*********
;Called when a button is pressed. The param symbol is what to send to WebAssign. E.g., put in "pi" to send pi, which it should interpret as π.
insertSymbol(symbol) {
    Send, !{Tab}
    Sleep 300
    Send, %symbol%
    Sleep 100pi
    Send, !{Tab}
}

PiButton:
insertSymbol("pi")
return