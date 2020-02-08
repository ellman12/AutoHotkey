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
;I put a lot more effort into this then I probably should have.
;0 = convert the char to lower...
;...1 = convert the char to UPPER.

return ;End of Auto-execute.

^#r::
Reload
return


;Convert text to aLt CaSe, with the first letter being lower case.
^!+a::

 ;Set it to 0 because it needs to start lower (see comment at the top of the script).
altCaseToggle := 0

;Copy the text.
Send, ^c
Sleep, 50

;Loop through the contents of the Clipboard, and toggle between cases.
Loop, Parse, Clipboard
{
    if (altCaseToggle = 0) {
        IfNotInString, A_LoopField, {Space}
            StringLower, strLwUpOutput, A_LoopField
            finalString := finalString . strLwUpOutput
            altCaseToggle := !altCaseToggle
    } else if (altCaseToggle = 1) {
        IfInString, A_LoopField, {Space}
            StringUpper, strLwUpOutput, A_LoopField
            finalString := finalString . strLwUpOutput
            altCaseToggle := !altCaseToggle
    }
}

Clipboard := finalString

Send, ^v

; MsgBox, %finalString% ;Temp for test.

return ;End of ^!+a.

;Convert text to AlT cAsE, with the first letter being UPPER case.
^!+#a::

return ;End of ^!+a.