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
SetTitleMatchMode, 2
#SingleInstance force

;TODO: Could add a 2nd button next to ln or something. I want a way to add the other 3 trig functions (sec, csc, tan).

;****CONTROL DISTANCES REFERENCE****
;Distance between GroupBox and button: 17 pixels
;Distance between GroupBoxes: 55 pixels

Menu, Tray, Icon, %A_ScriptDir%\Custom NumPad Icon.png

;Symbols & Constants (pi, e, (), ∞, -∞).
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w288 h55 x2 y0,Symbols && Constants

GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, w40 h33 x6 y17 gButtonPress, &(
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &)
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &inf
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, -inf
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &Pi
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, e
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &e^

;Exponents (x^-1, x^-2, x^y, x^2, x^3, x^4, x^5, x^6)
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w288 h55 x2 y55,Exponents

GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, w40 h33 x6 y72 gButtonPress, x^-&1
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, x^-2
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, x^&y
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, x^&2
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, x^&3
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, x^&4
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, x^&5

;Variables (x, y, z, theta, a, b, c).
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w288 h55 x2 y110,Variables

GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, w40 h33 x6 y127 gButtonPress, &x
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &y
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &z
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &theta
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &a
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &b
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &c

;Operators (+, -, *, ÷, , √).
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w248 h55 x2 y165,Operators

GUI, NumPad:Font, s13
GUI, NumPad:Add, Button, w40 h33 x6 y182 gButtonPress, +
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, -
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, *
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, /
GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, sqrt
GUI, NumPad:Font, s13
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, ,

;Functions (sin, cos, tan, log, ln)
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w208 h55 x2 y220,Functions

GUI, NumPad:Font, s11
GUI, NumPad:Add, Button, w40 h33 x6 y237 gButtonPress, &sin
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &cos
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &tan
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &log
GUI, NumPad:Add, Button, wp hp xp+40 yp gButtonPress, &ln

;Tabs for when ready to submit answer(s).
GUI, NumPad:Font, s8
GUI, NumPad:Add, GroupBox, w288 h55 x2 y275, Number of buttons to tab through to reach submit button. ;Basically num of tabs = num of buttons + 1.

GUI, NumPad:Font, s8
GUI, NumPad:Add, Button, w50 h33 x6 y292 gButtonPress, 1 Tab
GUI, NumPad:Add, Button, wp hp xp+50 yp gButtonPress, 1 Button
GUI, NumPad:Add, Button, wp+5 hp xp+50 yp gButtonPress, 2 Buttons
GUI, NumPad:Add, Button, wp+5 hp xp+55 yp gButtonPress, 3 Buttons
GUI, NumPad:Add, Button, wp+5 hp xp+60 yp gButtonPress, 4 Buttons

GUI, NumPad:+AlwaysOnTop
GUI, NumPad:Show, w293 h332 x1203 y652
return ;End of auto-execute.

NumPadGuiClose:
NumPadGuiEscape:
ExitApp
return

;Called when a button is pressed. The param "symbol" is what to send to WebAssign or wherever else.
;E.g., put in "pi" to send pi, which WebAssign should interpret as π.
insertSymbol(symbol, amtOfRightsToSend := 0) {
    WinActivate, | WebAssign
    Sleep 300
    Send, {Text}%symbol%
    Sleep 300
    Send, {Right amtOfRightsToSend}
    WinActivate, Custom NumPad.ahk
}

;when ready to submit answer, will tab through this many buttons to get to the submit button, then click it. numOfTabs = num of buttons + 1.
tabAndSubmit(numOfTabs) {
    WinActivate, | WebAssign
    Sleep 3000
    Send, {Tab %numOfTabs%}
    Sleep 3000
    Send, {Space}
    Sleep 3000
    WinActivate, Custom NumPad.ahk
}

;Called whenever any button is pressed. This big brain idea simplifies the code and makes it so there's only 1 label: not a crap ton more basically doing the same thing.
ButtonPress:
;Determine which button was pressed, and enter the corresponding character/string of characters.
Switch (A_GuiControl) {

    ;Symbols & Constants.
    Case "&(":insertSymbol("(")
    Case "&)":insertSymbol(")")
    Case "&inf":insertSymbol("inf")
    Case "-inf":insertSymbol("-inf")
    Case "&Pi":insertSymbol("Pi")
    Case "e":insertSymbol("e")
    Case "&e^":insertSymbol("e^")

    ;Exponents.
    Case "x^-&1":insertSymbol("^-1")
    Case "x^-2":insertSymbol("^-2")
    Case "x^&y":insertSymbol("^")
    Case "x^&2":insertSymbol("^2")
    Case "x^&3":insertSymbol("^3")
    Case "x^&4":insertSymbol("^4")
    Case "x^&5":insertSymbol("^5")

    ;Variables.
    Case "&x":insertSymbol("x")
    Case "&y":insertSymbol("y")
    Case "&z":insertSymbol("z")
    Case "&theta":insertSymbol("theta")
    Case "&a":insertSymbol("a")
    Case "&b":insertSymbol("b")
    Case "&c":insertSymbol("c")

    ;Operators.
    Case "+":insertSymbol("+")
    Case "-":insertSymbol("-")
    Case "*":insertSymbol("*")
    Case "/":insertSymbol("/")
    Case "sqrt":insertSymbol("sqrt")
    Case ",":insertSymbol(",")

    ;Functions.
    Case "&sin":insertSymbol("sin")
    Case "&cos":insertSymbol("cos")
    Case "&tan":insertSymbol("tan")
    Case "&log":insertSymbol("log")
    Case "&ln":insertSymbol("ln")

    Case "1 Tab":tabAndSubmit(1)
    Case "1 Button":tabAndSubmit(2)
    Case "2 Buttons":tabAndSubmit(3)
    Case "3 Buttons":tabAndSubmit(4)
    Case "4 Buttons":tabAndSubmit(5)

    Default:MsgBox, 16, This is an error message for the Custom NumPad Script., Error. Unknown Button.,
}
return