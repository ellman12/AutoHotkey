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

FileList := ""
FileArray := []
LowestCreationTime := ""

Loop, Files, C:\Users\Elliott\Downloads\*.*, FD  ; Include Files and Directories
{
    FileList .= A_LoopFileTimeModified . A_LoopFileName "`n"
}

Sort, FileList, N R ; Sort by date.
MsgBox, %FileList%

FileArray := StrSplit(FileList, "`n")
fileName := SubStr(FileArray, StartingPos [, Length])

for index, value in FileArray
{
    MsgBox %index% at %value%
    fileName :=
    FileRecycle, %value%
    if ErrorLevel = 1
        MsgBox, Error
}