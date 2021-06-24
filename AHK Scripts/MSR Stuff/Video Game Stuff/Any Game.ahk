#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode, Input
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir, %A_ScriptDir%
SplitPath, A_ScriptName, , , , thisscriptname
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling

iniPath := "C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Video Game Stuff\Any Game.ini"

IniRead, Scim_G1, %iniPath%, Scimitar, G1
IniRead, Scim_G2, %iniPath%, Scimitar, G2
IniRead, Scim_G3, %iniPath%, Scimitar, G3
IniRead, Scim_G4, %iniPath%, Scimitar, G4
IniRead, Scim_G5, %iniPath%, Scimitar, G5
IniRead, Scim_G6, %iniPath%, Scimitar, G6
IniRead, Scim_G7, %iniPath%, Scimitar, G7
IniRead, Scim_G8, %iniPath%, Scimitar, G8
IniRead, Scim_G9, %iniPath%, Scimitar, G9
IniRead, Scim_G10, %iniPath%, Scimitar, G10
IniRead, Scim_G11, %iniPath%, Scimitar, G11
IniRead, Scim_G12, %iniPath%, Scimitar, G12
IniRead, TopFront, %iniPath%, Scimitar, TopFront
IniRead, TopBack, %iniPath%, Scimitar, TopBack

IniRead, K95_G1, %iniPath%, K95, G1
IniRead, K95_G2, %iniPath%, K95, G2
IniRead, K95_G3, %iniPath%, K95, G3
IniRead, K95_G4, %iniPath%, K95, G4
IniRead, K95_G5, %iniPath%, K95, G5
IniRead, K95_G6, %iniPath%, K95, G6
IniRead, K95_G7, %iniPath%, K95, G7
IniRead, K95_G8, %iniPath%, K95, G8
IniRead, K95_G9, %iniPath%, K95, G9
IniRead, K95_G10, %iniPath%, K95, G10
IniRead, K95_G11, %iniPath%, K95, G11
IniRead, K95_G12, %iniPath%, K95, G12
IniRead, K95_G13, %iniPath%, K95, G13
IniRead, K95_G14, %iniPath%, K95, G14
IniRead, K95_G15, %iniPath%, K95, G15
IniRead, K95_G16, %iniPath%, K95, G16
IniRead, K95_G17, %iniPath%, K95, G17
IniRead, K95_G18, %iniPath%, K95, G18

GUI, AnyGame:

;****************************************SCIMITAR RGB ACTIONS***************************************
;Mouse Profile Switch button
^!F23::Send, %TopFront%

;Mouse DPI Toggle
^+F23::Send, %TopBack%

;Mouse G1
F13::Send, %Scim_G1%

;Mouse G2
F14::Send, %Scim_G2%

;Mouse G3
F15::Send, %Scim_G3%

;Mouse G4
F16::Send, %Scim_G4%

;Mouse G5
F17::Send, %Scim_G5%

;Mouse G6
F18::Send, %Scim_G6%

;Mouse G7
F19::Send, %Scim_G7%

;Mouse G8
F20::Send, %Scim_G8%

;Mouse G9
F21::Send, %Scim_G9%

;Mouse G10
F22::Send, %Scim_G10%

;Mouse G11
F23::Send, %Scim_G11%

;Mouse G12
+F23::Send, %Scim_G12%

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
^F13::Send, %K95_G1%

;Keeb G2
^F14::Send, %K95_G2%

;Keeb G3
^F15::Send, %K95_G3%

;Keeb G4
^F16::Send, %K95_G4%

;Keeb G5
^F17::Send, %K95_G5%

;Keeb G6
^F18::Send, %K95_G6%

;Keeb G7
^F19::Send, %K95_G7%

;Keeb G8
^F20::Send, %K95_G8%

;Keeb G9
^F21::Send, %K95_G9%

;Keeb G10
^F22::Send, %K95_G10%

;Keeb G11
^F23::Send, %K95_G11%

;Keeb G12
!F23::Send, %K95_G12%

;Keeb G13
!F13::Send, %K95_G13%

;Keeb G14
!F14::Send, %K95_G14%

;Keeb G15
!F15::Send, %K95_G15%

;Keeb G16
!F16::Send, %K95_G16%

;Keeb G17
!F17::Send, %K95_G17%

;Keeb G18
!F18::Send, %K95_G18%