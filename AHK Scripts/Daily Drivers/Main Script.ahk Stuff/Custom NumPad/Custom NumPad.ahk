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
;TODO: GroupBoxes?
;TODO: Labels for the buttons. Probs just send <symbol> for most.
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

Menu, Tray, Icon, %A_ScriptDir%\Custom NumPad Icon.png

;Symbols & Constants (pi, e, etc).
GUI, Numpad:Font, s10
GUI, Numpad:Add, GroupBox, w145 h57 x5 y0,Symbols && Constants

GUI, Numpad:Font, s12
GUI, Numpad:Add, Button, w40 h33 x10 y17,&Pi
GUI, Numpad:Add, Button, wp hp xp+40 yp,e
GUI, Numpad:Add, Button, wp hp xp+40 yp,&e^

;Variables (x, y, z, a, b, c).
GUI, Numpad:Font, s10
GUI, Numpad:Add, GroupBox, w145 h57 x5 y0,Symbols && Constants

GUI, Numpad:Font, s12
GUI, Numpad:Add, Button, w40 h33 x10 y17,&Pi
GUI, Numpad:Add, Button, wp hp xp+40 yp,e
GUI, Numpad:Add, Button, wp hp xp+40 yp,&e^





GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:
GUI, Numpad:

GUI, Numpad:+AlwaysOnTop
GUI, NumPad:Show, w280 h400 x1203 y652