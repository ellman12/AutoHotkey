#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling
SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag

;Simple utility script that moves mouse pointer back and forth 1 pixel every 2 minutes to prevent PC from falling asleep.
GUI, +AlwaysOnTop
GUI, Color, Silver
GUI, Margin, 3, 3

GUI, Font, s12
GUI, Add, Checkbox, w239 vToggled, Toggle
GuiControl,, Toggled, 1

GUI, Show, w73 h25, Keep PC Awake

Loop
{
    GuiControlGet, Toggled,, Toggled
    if (Toggled == 1)
    {
        MouseMove, 1, 0, 100, R
        Sleep, 120000
        MouseMove, -1, 0, 100, R
    }
}

GuiClose:
ExitApp
return