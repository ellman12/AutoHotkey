#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetWorkingDir, %A_ScriptDir%
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling
; DetectHiddenWindows, On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag

;Test script trying to combine the numerous different virtual desktop hotkeys into a more unified system.

currentVD := 1 ;The one the user is on at the moment.
totalVDs := 1 ;Start at one since there's always guaranteed to be 1.
;TODO: add this to an ini file.

$^#Right::
currentVD++
if (currentVD > totalVDs)
{
    Send, ^#d
    totalVDs++
}
else
    Send, ^#{Right}
return

;Still retain their normal function, but integrate it into this.
~^#F4::totalVDs--

~^#d::
totalVDs++
currentVD := totalVDs ;Assign the current one to the max amount.
return


; ^#Left::
; originalVDAmount := currentVDAmount
; currentVDAmount--

; if (currentVDAmount == 1) ;Don't "remove" a VD that doesn't exist.
;     return

; if (currentVDAmount < originalVDAmount)
; {
;     Send, ^#{F4}
; }
; else
;     Send, ^#{Left}

; MsgBox, %currentVDAmount%
; originalVDAmount :=
; return