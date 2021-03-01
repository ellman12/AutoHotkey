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

Menu, Tray, Icon, C:\Users\Elliott\Documents\GitHub\AutoHotkey\Perhaps-removebg-preview.png

GUI, Warning:Add, Picture, x70 y-32 w180 h100, C:\Users\Elliott\Documents\GitHub\AutoHotkey\Perhaps-removebg-preview.png
GUI, Warning:Add, Button, x129 w70, Yes
GUI, Warning:Add, Button, xp+73 wp, No

GUI, Warning:+AlwaysOnTop
GUI, Warning:Show, w280 h100, Warning


return ;Auto-Exec end

ScrollLock::Reload