#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;Created so I can learn how to use GUIs (for Google Calendar scripts?).

#Persistent

Gui, Font, S8, Verdana
Gui, +AlwaysOnTop +HWNDGuiHWND +Delimiter`n
Gui, Add, Text,  w700, Safe Windows (CTRL+F11)


Gui, Show, Center, Anti-Distraction
