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

#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk

GUI, BedtimeGUI:Font, S36
GUI, BedtimeGUI:Add, Text,,IT'S BEDTIME!!

GUI, BedtimeGUI:Font, S20
GUI, BedtimeGUI:Add, Text,,Go to bed now, and you will have a good morning tomorrow.

GUI, BedtimeGUI:Font, S11
GUI, BedtimeGUI:Add, Button, w250 h50 gExtraTimeButton, Five extra minutes to close stuff, etc.

GUI, BedtimeGUI:+AlwaysOnTop

SetTimer, Bedtime, 500 ;Check time every half second.

return ;End of Auto-execute.

Bedtime:
    ReadFiles()

    GUI, BedtimeGUI: +AlwaysOnTop ;This window always needs to stay on top.
    
    FormatTime, CurrentTime,, Time
    
    if (currentTime >= BedtimeValue AND currentTime <= WakeUpTime) ;If the current time is between bedtime and wake up time, start the thing.
        GUI, BedtimeGUI:Show, w%A_ScreenWidth% h%A_ScreenHeight% ;Make it cover the whole screen.
return

ExtraTimeButton:
    GuiControl, BedtimeGUI:Hide, Five
    GUI, BedtimeGUI:Hide
    SetTimer, Bedtime, Off
    Sleep 300000 ;5 minutes
    GUI, BedtimeGUI:Show, w%A_ScreenWidth% h%A_ScreenHeight% ;Show the GUI again.
    SetTimer, Bedtime, On
return

;Read the data from the Bedtime and WakeUpTime files.
ReadFiles() {

    FileRead, BedtimeValue, %A_ScriptDir%\Bedtime.txt ;User can set the Bedtime to what they want in this file.
    if (ErrorLevel = 1) {
        MsgBox, 16, Something went wrong., Something went wrong while reading the "Bedtime" file. The script will now exit.
        ExitApp, -2
    }

    FileRead, WakeUpTime, %A_ScriptDir%\WakeUpTime.txt ;When to turn the thing off.
    if (ErrorLevel = 1) {
        MsgBox, 16, Something went wrong., Something went wrong while reading the "WakeUpTime" file. The script will now exit.
        ExitApp, -3
    }
}