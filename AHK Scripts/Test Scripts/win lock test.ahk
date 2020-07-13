#NoEnv
#MaxHotkeysPerInterval 999999999999999999999999999999999
#HotkeyInterval 99999999999999999999999999999999999
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

WinLockToggle := false

#Insert::WinLockToggle := !WinLockToggle

#If WinLockToggle = true

$LWin::
KeyWait, LWin, U
KeyWait, LWin, D, T0.2
If (ErrorLevel = 0)
    Send, {LWin}
return

$RWin::
KeyWait, RWin, U
KeyWait, RWin, D, T0.2
If (ErrorLevel = 0)
    Send, {RWin}
return

#If
