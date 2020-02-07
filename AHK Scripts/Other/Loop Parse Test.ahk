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
;0 = (start, if applicable) lower case, or else convert the char to lower
;1 = do not start lower (start upper case), or else convert the char to upper.

;TODO Have 2 different hotkeys for starting lower, and starting upper, and have it set the var accordingly.
altCaseToggle := 0

;Array for piecing together chars.
; charArray := [1]

return ;End of Auto-exe.

#e::

Send, ^c
Sleep 50

;TODO if first time running, concatenate strLw.. and strLw..., then delete one of them, OR just not have it chop any of that off.
;The reason the Clipboard gets fucked is because the final time it's run, it's the concatenation of the 2 vars.

Loop, Parse, Clipboard
{
    if (altCaseToggle = 0) {
        StringLower, strLwUpOutput, A_LoopField
        finalString := finalString . strLwUpOutput
        altCaseToggle := !altCaseToggle
        MsgBox, 1 A_LoopField: %A_LoopField% + altCaseToggle: %altCaseToggle% + strLwUpOutput: %strLwUpOutput%
    } else if (altCaseToggle = 1) {
        StringUpper, strLwUpOutput, A_LoopField
        finalString := finalString . strLwUpOutput
        altCaseToggle := !altCaseToggle
        MsgBox, 0 %A_LoopField% + %altCaseToggle% + strLwUpOutput: %strLwUpOutput%
    }
}
MsgBox, %finalString%
return