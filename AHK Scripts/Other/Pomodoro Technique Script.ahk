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

;************WORDS OF ENCOURAGEMENT************
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x10 y90 w100 h75, You can do it!

;************START A NEW TASK!************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x123 y10 w191 h200, Start a new task!

;************DONE TASKS STUFF************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x327 y10 w150 h135, Done Tasks

GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Checkbox, x335 y39 vCheckbox1, Task &1
GUI, MainGUI:Add, Checkbox, x335 y65 vCheckbox2, Task &2
GUI, MainGUI:Add, Checkbox, x335 y91 vCheckbox3, Task &3
GUI, MainGUI:Add, Checkbox, x335 y117 vCheckbox4, Task &4

;************TASK EDIT BOX************
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x133 y51,Task:
GUI, MainGUI:Add, Edit, x179 y48 w130 vTaskName

;************POMODORO BUTTON************
GUI, MainGUI:Add, Button, x133 y85, Start &Pomodoro

;************SHORT BREAK BUTTON************
GUI, MainGUI:Add, Button, x133 y125, &Short Break

;************LONG BREAK BUTTON************
GUI, MainGUI:Add, Button, x133 y165, &Long Break

;************WHAT NEXT?************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x327 y149 w150 h85, What's Next?

GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x336 y180 w140 h50, Start a new task! ;Starting text.

;************OTHER GUI GROUPBOX************
GUI, MainGUI:Add, GroupBox, x3 y130 w121 h127, Other GUIs

;************SAFE WINDOWS************
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Button, x4 y150, Safe Windows

;************STATS************
GUI, MainGUI:Add, Button, x4 y185, Stats

;************OPTIONS************
GUI, MainGUI:Add, Button, x4 y220, Options

;************TIMER PROGRESS************
GUI, MainGUI:Add, Progress, x126 y215 w189 h20 cEB3834 vTimerProgress, 100

;************SHOW THE GUI************
GUI, MainGUI:+AlwaysOnTop
GUI, MainGUI:Show, w490 h292 x1350 y377, Pomodoro Technique Script
return ;End of auto-execute.

;*********************LABELS*********************
MainGUIGuiClose:

return

;TEMP hotkeys
F10::
Send, ************
return

F11::
Send, GUI, MainGUI:
return