;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DetectHiddenWindows, Off
#SingleInstance force
;OPTIMIZATIONS END

;Tippy is such a useful function I made it its own file that can be #Included in other files.
;Kinda like C Header Files.

;Used for making the use of ToolTips a lot simpler and easier.
Tippy(Text, Duration) {
	ToolTip, %Text%
	Sleep %Duration%
	ToolTip ;Remove the ToolTip.
}