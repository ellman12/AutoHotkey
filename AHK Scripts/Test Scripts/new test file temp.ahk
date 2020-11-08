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

F11::
Loop, Files, C:\Users\Elliott\Downloads\*.*, FD ;FD = Include Files and Directories
{
    ;Loops through this directory, and if it encounters a file/folder that is newer than the previously encountered one,
    ; make that the one to potentially delete.
    if (A_LoopFileTimeModified > currentMaxCreationDate)
    {
        currentMaxCreationDate := A_LoopFileTimeModified
        fileToPotentiallyDelete := A_LoopFileName
    }
}

MsgBox, 262180, Recycle Latest File in Downloads Folder, "%fileToPotentiallyDelete%" will be recycled. Proceed?
IfMsgBox, No
    return

FileRecycle, C:\Users\Elliott\Downloads\%fileToPotentiallyDelete%
if (ErrorLevel == 0)
    MsgBox, 262160, Error, An error occurred while trying to recycle "%fileToPotentiallyDelete%".

currentMaxCreationDate := ;Free memory.
fileToPotentiallyDelete :=
return