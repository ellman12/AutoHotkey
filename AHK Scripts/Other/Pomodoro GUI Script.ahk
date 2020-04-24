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

/*
* This script is a HUGE upgrade from an old script called "Anti-Distraction.ahk".
* That script worked ok, but it had problems and many annoyances that I didn't like.
* This is a custom-built Pomodoro script.
* I've never really liked Pomodoro apps and browser extensions; they don't really do all that much tbh.
* The nice thing about being a programmer is that if you don't like something, you can just change it to how you like it.
* Development started: 4/24/2020 ~1:00 PM
*/

;Window titles and IDs that won't get smote when a Pomodoro timer is running, and there isn't a break going on.
;The reason there's 2 arrays is because the script will compare if the active window title OR ID is not in the
;list of acceptable titles/IDS. For example, a music program. Its title won't stay constant, but its ID will.
;This was an annoyance with the old script.
safeWindowTitles := []
safeWindowIDs := []

;*********************GUI INITIALIZATION*********************
;************MISC GUI STUFF************
