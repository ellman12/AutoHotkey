#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling
; DetectHiddenWindows, On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag

Directory := "C:\Users\Elliott\Downloads"
return

F11::
Newest := 0
NewestFile := ""
loop,%Directory%\*.* ;loop through all files in directory checking for newest
{
	if (A_LoopFileTimeCreated > Newest) { ;if this file is newer continue
		Newest := A_LoopFileTimeCreated ;reset variable to higher value
		NewestFile := A_LoopFileLongPath ;reset varaible to newest file
	}
}
Msgbox % "Newest file = " NewestFile
FileRecycle, %NewestFile%
return