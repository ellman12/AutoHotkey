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

;altCaseToggle is a toggle for if the alt case starts in lower case or not.
;A_LoopField is the single character at that point in the Parse Loop.
;0 = convert the char (A_LoopField) to lower...
;...1 = convert the char to UPPER.

return ;End of Auto-execute.

;Convert text to aLt CaSe, with the first letter being lower case.
^!+a::

;Blank out this String.
;Basically resetting it so it doesn't contain the old text as well as the new stuff.
finalString := 

 ;Set it to 0 because it needs to start lower (see comment at the top of the script).
altCaseToggle := 0

;Copy the text, and wait a bit so it can actually get a change to store it in the Clipboard.
Send, ^c
Sleep, 50

;Loop through the contents of the Clipboard, and toggle between cases.
Loop, Parse, Clipboard
{
    if (altCaseToggle = 0) {
        if (A_LoopField = A_Space) {
            ;If the current char is a space, don't toggle the var and just concatenate it to the finalString.
            finalString := finalString . A_Space
        } else {
            StringLower, strLwUpOutput, A_LoopField
            finalString := finalString . strLwUpOutput
            altCaseToggle := !altCaseToggle
        }
    } else if (altCaseToggle = 1) {
        if (A_LoopField = A_Space) {
            finalString := finalString . A_Space
        } else {
            StringUpper, strLwUpOutput, A_LoopField
            finalString := finalString . strLwUpOutput
            altCaseToggle := !altCaseToggle
        }
    }
}

;Store the final aLt CaSe String in the Clipboard.
Clipboard := finalString

;Paste the final String.
Send, ^v

return ;End of ^!+a.

;Convert text to AlT cAsE, with the first letter being UPPER case.
^!+#a::

;Blank out this String.
;Basically resetting it so it doesn't contain the old text as well as the new stuff.
finalString := 

 ;Set it to 0 because it needs to start lower (see comment at the top of the script).
altCaseToggle := 1

;Copy the text, and wait a bit so it can actually get a change to store it in the Clipboard.
Send, ^c
Sleep, 50

;Loop through the contents of the Clipboard, and toggle between cases.
Loop, Parse, Clipboard
{
    if (altCaseToggle = 0) {
        if (A_LoopField = A_Space) {
            finalString := finalString . A_Space
        } else {
            StringLower, strLwUpOutput, A_LoopField
            finalString := finalString . strLwUpOutput
            altCaseToggle := !altCaseToggle
        }
    } else if (altCaseToggle = 1) {
        if (A_LoopField = A_Space) {
            finalString := finalString . A_Space
        } else {
            StringUpper, strLwUpOutput, A_LoopField
            finalString := finalString . strLwUpOutput
            altCaseToggle := !altCaseToggle
        }
    }
}

;Store the final aLt CaSe String in the Clipboard.
Clipboard := finalString

;Paste the final String.
Send, ^v

return ;End of ^!+a.