#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;Keeps script running.
#Persistent

;This script is for helping me to focus, and preventing me from getting distracted.
;If it detects an active window title that is not in the group of accepted window
; titles, it smites it by sending ^w if it's a browser, or Alt + F4 otherwise.
;Thus keeping me off of and away from the distraction.



;DEFINITELY NOT FINISHED!!!

;According to the documentation: "2: A window's title can contain WinTitle anywhere inside it to be a match."
SetTitleMatchMode, 2

;Title of active window.
WinGetActiveTitle, activeWindowTitle ;AD = Anti-distraction.


;TEMP HOTKEYS?
;ADGoodGroup is the window group of windows that are OK.
^PrintScreen::
GroupAdd, ADGoodGroup, %activeWindowTitle%
return

;ADBadGroup is the window group of windows that are not OK
; and that will be smote as soon as they are spotted by the script.
^F10::
GroupAdd, ADBadGroup, %activeWindowTitle%
return

^!F10::
GroupClose, ADBadGroup, A
return