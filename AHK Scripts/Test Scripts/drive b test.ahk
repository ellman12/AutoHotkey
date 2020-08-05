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

BackupDriveMaxGB := 

DriveGet, usedInMB, Capacity, B:\
usedInGB := Floor(usedInMB / 1000)

DriveSpaceFree, freeInMB, B:\
freeInGB := Floor(freeInMB / 1000)

MsgBox, 0, Backup Drive (B:\) Stats,%usedInMB% MB in use`n%usedInGB% GB in use`n`n%usedInMB% MB free`n%freeinGB% GB free

if (usedInGB >= )