;OPTIMIZATIONS START
#NoEnv
; #MaxHotkeysPerInterval 99000000
; #HotkeyInterval 99000000
; #KeyHistory 0
; ListLines Off
; Process, Priority, , A
; SetBatchLines, -1
; SetKeyDelay, -1, -1
; SetMouseDelay, -1
; SetDefaultMouseSpeed, 0
; SetWinDelay, -1
; SetControlDelay, -1
SendMode Input
#SingleInstance force
;OPTIMIZATIONS END

; testString = ishouldbeinallcaps

; MsgBox, %testString%

; ;A_Index is the current loop index; A_LoopField is the char at that iteration.

; Loop, parse, testString
; {
;     ;MsgBox, 4, , Iteration %A_Index% is %A_LoopField%.
;     charToMakeUpperCase := %A_Index%
;     StringUpper, upperCaseChar, charToMakeUpperCase
; }

; MsgBox, %%

;try alt case

^+f::
Send, ^c
Sleep 60
testString := Clipboard
StringUpper, testString, testString
MsgBox %testString%
Return