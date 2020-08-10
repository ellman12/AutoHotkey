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
#Persistent

;CONSTANTS
buttonWidth := 75
buttonHeight := 75



GUI, BedtimeGUI:Show, w%A_ScreenWidth% h%A_ScreenHeight% ;Make it cover everything.
GUI, BedtimeGUI:+AlwaysOnTop
GUI, BedtimeGUI:Add, Button

FileRead, Bedtime, %A_ScriptDir%\Bedtime.txt ;User can set the Bedtime to what they want in this file.

SetTimer, getSystemTime, 500 ;Check time every half second.

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk
return ;End of Auto-execute.

getSystemTime:
    
    ; GUI, BedtimeGUI: +AlwaysOnTop ;This window always needs to stay on top.
    ; GUI, BedtimeGUI:Show, w%A_ScreenWidth% h%A_ScreenHeight% ;Make it cover everything.
    
    FormatTime, currentTime,, Time
    
    if (currentTime = Bedtime)
        Tippy("YES", 5000)
    else
        Tippy("NO", 1)
return