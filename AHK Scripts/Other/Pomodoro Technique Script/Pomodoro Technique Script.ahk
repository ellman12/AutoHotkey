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

;TODO have all 4 edit boxes available to edit whenever (gray out after prev pom is done?), but the 2-4 check boxes default to grayed out.
;TODO pom/break length can't change while the session is ongoing
;TODO a clear button when the long break is ready to activate.
;TODO break buttons start out as disabled.

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
;  5. If you have fewer than four checkmarks, take a short break (3-5 minutes), then go to step 2.
;  6. After four pomodoros, take a longer break (15-30 minutes), reset your checkmark count to zero, then go to step 1.

;Changes the icon to a little tomato!
Menu, Tray, Icon, %A_ScriptDir%\Pomodoro GUI Script Icon.png

;Window titles and IDs that won't get smote when a Pomodoro timer is running, and there isn't a break going on.
;The reason there's 2 arrays is because the script will compare if the active window title OR ID is not in the
;list of acceptable titles/IDS. For example, a music program. Its title won't stay constant, but its ID will.
;This was an annoyance with the old script.
safeWindowTitles := []
safeWindowIDs := []

;Toggle for showing/hiding all the other GUIs.
showStatsGUIToggle := false
showOptionsGUIToggle := false
showSafeWinsGUIToggle := false

;******************CONSTANTS******************
;So AHK and the programmer don't get confused.
MainGUI := "Pomodoro GUI Script"
OptionsGUI := "Options for Pomodoro Script"
SafeWinsGUI := "Safe windows for Pomodoro Script"
StatsGUI := "Stats for Pomodoro Script"

;******************GUI INITIALIZATION******************
;************POMODORO PICTURE************
GUI, MainGUI:Add, Picture, w70 h70 x10 y10, %A_ScriptDir%\Pomodoro GUI Script Icon.png

;************WORDS OF ENCOURAGEMENT************
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x10 y90 w100 h75, You can do it!

;************START A NEW TASK!************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x123 y10 w191 h150, Start a new task!

;******POMODORO BUTTON******
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Button, x133 y38, Start &Pomodoro

;******SHORT BREAK BUTTON******
GUI, MainGUI:Add, Button, x133 y78, &Short Break

;******LONG BREAK BUTTON******
GUI, MainGUI:Add, Button, x133 y118, &Long Break

;******TIMER PROGRESS******
GUI, MainGUI:Add, Progress, x126 y173 w189 h20 cEB3834 vTimerProgress, 100

;************TASKS************
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x327 y10 w150 h155, Tasks

GUI, MainGUI:Font, norm s12

;******CHECKBOX1******
GUI, MainGUI:Add, Checkbox, x335 y38 vCheckbox1, &1
GUI, MainGUI:Add, Edit, x368 y34 w100 h26 vCheck1EditBox

;******CHECKBOX2******
GUI, MainGUI:Add, Checkbox, x335 y68 vCheckbox2 , &2
GUI, MainGUI:Add, Edit, x368 y64 w100 h26 vCheck2EditBox

;******CHECKBOX3******
GUI, MainGUI:Add, Checkbox, x335 y98 vCheckbox3, &3
GUI, MainGUI:Add, Edit, x368 y94 w100 h26 vCheck3EditBox

;******CHECKBOX4******
GUI, MainGUI:Add, Checkbox, x335 y129 vCheckbox4 , &4
GUI, MainGUI:Add, Edit, x368 y125 w100 h26 vCheck4EditBox

;************WHAT NEXT?************
;Helps the user by telling them what to do next.
GUI, MainGUI:Font, bold s14
GUI, MainGUI:Add, GroupBox, x327 y171 w150 h85, What's Next?

GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Text, x333 y195 w140 h50, Start a new task! ;Starting text.

;************OTHER GUI GROUPBOX************
GUI, MainGUI:Add, GroupBox, x3 y130 w121 h127, Other GUIs

;******SAFE WINDOWS******
GUI, MainGUI:Font, norm s12
GUI, MainGUI:Add, Button, x4 y150 gSafeWindowsButton, Sa&fe Windows

;******STATS******
GUI, MainGUI:Add, Button, x4 y185 gStatsButton, S&tats

;******OPTIONS******
GUI, MainGUI:Add, Button, x4 y220 gOptionsButton, &Options

;************SHOW THE GUI************
GUI, MainGUI:+AlwaysOnTop
GUI, MainGUI:Show, w490 h292 x1350 y377, Pomodoro Technique Script

;Disable until the first one is checked.
;~ GuiControl, MainGUI:Disable, Checkbox2
; GuiControl, MainGUI:Disable, Check2EditBox
;~ GuiControl, MainGUI:Disable, Checkbox3
; GuiControl, MainGUI:Disable, Check3EditBox
;~ GuiControl, MainGUI:Disable, Checkbox4
; GuiControl, MainGUI:Disable, Check4EditBox

;Other GUIs used for this script.
#Include, %A_ScriptDir%\Pom Script Options GUI.ahk
#Include, %A_ScriptDir%\Pom Script Safe Windows GUI.ahk
#Include, %A_ScriptDir%\Pom Script Stats GUI.ahk
return ;End of Auto-execute.

;*********************LABELS*********************
MainGUIGuiClose:
ExitApp
return

OptionsGUIGuiClose:
showOptionsGUIToggle := !showOptionsGUIToggle
GUI, OptionsGUI:Hide
return

SafeWinsGUIGuiClose:
showSafeWinsGUIToggle := !showSafeWinsGUIToggle
GUI, SafeWinsGUI:Hide
return

StatSGUIGuiClose:
showStatsGUIToggle := !showStatsGUIToggle
GUI, StatsGUI:Hide
return

;Toggles between showing and hiding the safe windows menu.
SafeWindowsButton:
showSafeWinsGUIToggle := !showSafeWinsGUIToggle

if (showSafeWinsGUIToggle = true)
    GUI, SafeWinsGUI:Show, w300 h500, Safe Windows
else
    GUI, SafeWinsGUI:Hide
return

;Toggles between showing and hiding the stats menu.
StatsButton:
showStatsGUIToggle := !showStatsGUIToggle

if (showStatsGUIToggle = true)
    GUI, StatsGUI:Show, w250 h110, Stats
else
    GUI, StatsGUI:Hide
return

;Toggles between showing and hiding the safe windows menu.
OptionsButton:
showOptionsGUIToggle := !showOptionsGUIToggle

if (showOptionsGUIToggle = true)
    GUI, OptionsGUI:Show, w250 h110, Options
else
    GUI, OptionsGUI:Hide
return

;TEMP hotkeys
F10::
Send, ************
return

F11::
; Send, GUI, MainGUI:
Send, GUI, StatsGUI:
return

F9::
Send, ^!s
Reload
return