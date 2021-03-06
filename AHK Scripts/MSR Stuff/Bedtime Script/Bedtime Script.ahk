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
#NoTrayIcon
#Persistent

Menu, Tray, Icon, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Bedtime Script\Sleeping Emoji.png

GUI, BedtimeGUI:Font, S36
GUI, BedtimeGUI:Add, Text,,IT'S BEDTIME!!

GUI, BedtimeGUI:Font, S20
GUI, BedtimeGUI:Add, Text,,Go to bed now, and you will have a good morning tomorrow.

GUI, BedtimeGUI:Font, S20
GUI, BedtimeGUI:Add, Button, w250 h50 gExtraTimeButton, Five Extra Minutes

GUI, BedtimeGUI:Add, Text,, Number of times button pressed:
GUI, BedtimeGUI:Add, Edit, xp+200 yp-2 vnumOfButtonPresses w100, 0

numOfButtonPresses := 0

Loop {
    Bedtime()
    Sleep 1000
}

Bedtime() {

    FileRead, BedtimeValue, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Bedtime Script\Bedtime.txt ;User can set the Bedtime to what they want in this file.
    if (ErrorLevel = 1)
        MsgBox, 16, Something went wrong., Something went wrong while reading the "Bedtime" file.

    FileRead, WakeUpTime, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Bedtime Script\WakeUpTime.txt ;When to turn the thing off.
    if (ErrorLevel = 1)
        MsgBox, 16, Something went wrong., Something went wrong while reading the "WakeUpTime" file.

    GUI, BedtimeGUI: +AlwaysOnTop ;This window always needs to stay on top.
    FormatTime, CurrentTime,, H:mm

    if (CurrentTime >= BedtimeValue AND CurrentTime <= WakeUpTime) ;If the current time is between bedtime and wake up time, start the thing.
        GUI, BedtimeGUI:Show, w%A_ScreenWidth% h%A_ScreenHeight% ;Make it cover the whole screen.
    else
        GUI, BedtimeGUI:Hide
}

ExtraTimeButton:
    GUI, BedtimeGUI:Hide
    SetTimer, Bedtime, Off
    Sleep 300000 ;5 minutes
    GUI, BedtimeGUI:Show, w%A_ScreenWidth% h%A_ScreenHeight% ;Show the GUI again.
    numOfButtonPresses++
    GuiControl, BedtimeGUI:,numOfButtonPresses, %numOfButtonPresses%

    if (numOfButtonPresses >= 5)
    {
        MsgBox, Last one before script forces you to go to bed!
    }

    if (numOfButtonPresses >= 6)
    {
        GuiControl, BedtimeGUI:Hide, numOfButtonPresses
    }
return