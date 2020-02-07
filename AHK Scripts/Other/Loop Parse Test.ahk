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


;Test for alt case, starting with lower case.

;Toggle for if the alt case starts lower or not.
; 0 = do not start lower (start upper case); 1 = start lower.
altCaseToggle := 1

;Array for piecing together chars.
; charArray := [1]

return ;End of Auto-exe.

#e::

Send, ^c
Sleep 50

Loop, Parse, Clipboard
{
    if (altCaseToggle = "1") {
        StringLower, idkvar, A_LoopField
        Clipboard := . idkvar
        altCaseToggle := !altCaseToggle
        MsgBox, 1 A_LoopField: %A_LoopField% + altCaseToggle: %altCaseToggle% + idkvar: %idkvar%
    } else if (altCaseToggle = "0") {
        StringUpper, idkvar, A_LoopField
        Clipboard := . idkvar
        altCaseToggle := !altCaseToggle
        MsgBox, 0 %A_LoopField% + %altCaseToggle% + idkvar: %idkvar%
    }
}
MsgBox, %Clipboard%
return