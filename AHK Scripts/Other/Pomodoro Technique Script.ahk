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
* The nice thing about being a programmer is that if you don't like something, you can just change it.
* Development started: 4/24/2020 ~1:00 PM
*/

;Info on the Technique: https://www.wikiwand.com/en/Pomodoro_Technique
;There are six steps in the technique:
;  1. Decide on the task to be done.
;  2. Set the pomodoro timer (traditionally to 25 minutes).
;  3. Work on the task. The script will make sure that there are no distractions ;)
;  4. End work when the timer rings and put a checkmark on a piece of paper (or in this case, the GUI).
;  5. If you have fewer than four checkmarks, take a short break (3–5 minutes), then go to step 2.
;  6. After four pomodoros, take a longer break (15–30 minutes), reset your checkmark count to zero, then go to step 1.

;Changes the icon to a little tomato!
Menu, Tray, Icon, %A_ScriptDir%\Pomodoro GUI Script Icon.png

;Window titles and IDs that won't get smote when a Pomodoro timer is running, and there isn't a break going on.
;The reason there's 2 arrays is because the script will compare if the active window title OR ID is not in the
;list of acceptable titles/IDS. For example, a music program. Its title won't stay constant, but its ID will.
;This was an annoyance with the old script.
safeWindowTitles := []
safeWindowIDs := []

;*********************CONSTANTS*********************
;So AHK and the programmer don't get confused.
MainGUI := "Pomodoro GUI Script"
OptionsGUI := "Options for Pomodoro Script"

;*********************GUI INITIALIZATION*********************
;************POMODORO PIC STUFF************
GUI, MainGUI:Add, Picture, w70 h70 x10 y10, %A_ScriptDir%\Pomodoro GUI Script Icon.png

;************

;************SHOW THE GUI************
GUI, MainGUI:+AlwaysOnTop
GUI, MainGUI:Show, w400 h300 x1450 y377,Pomodoro Technique Script





;TEMP hotkeys
F10::
Send, ************
Return

F11::
Send, GUI, MainGUI:
Return