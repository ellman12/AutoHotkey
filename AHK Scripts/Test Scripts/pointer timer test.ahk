#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir, %A_ScriptDir%
SplitPath, A_ScriptName, , , , thisscriptname
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling
; DetectHiddenWindows, On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk

; thing that after certain amount of time moves mouse pointer off screen. If it's moved by user put back to where it was. Have a #o thing to customize delay
;TODO: make sure it's actually working, and also have it return back to it's original position if the user nudges the mouse a bit.

mouseAutoMoveDelay := 5000

Loop {
    MouseGetPos, firstMouseX, firstMouseY
    Sleep, %mouseAutoMoveDelay%
    MouseGetPos, secondMouseX, secondMouseY

    ;Basically, if the user has not moved the mouse during that delay, or it's only moved a tiny bit, move the pointer out of the way.
    if (((firstMouseX = secondMouseX) OR (firstMouseX = (secondMouseX + 15)) OR (firstMouseX = (secondMouseX - 15))) AND ((firstMouseY = secondMouseY) OR (firstMouseY = (secondMouseY + 15)) OR (firstMouseY = (secondMouseY - 15)))) {
        Tippy("Moving", 1000)
        MouseGetPos, originalMouseX, originalMouseY
        MouseMove, 1920, 1080
    } else {
        Tippy("Not moving", 1000)
    }
}




; if ((firstMouseX = secondMouseX) AND (firstMouseY = secondMouseY)) {
    ;If the mouse has not moved for that delay, and thus the user is not using the mouse, move the pointer.
