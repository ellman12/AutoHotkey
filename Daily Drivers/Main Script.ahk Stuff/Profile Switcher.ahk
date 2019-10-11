#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

;This script is for automatically switching to the appropriate profile.


;~ ;Gets the active window title and puts you in the right profile
AutoSelectProfiles() {
WinGetActiveTitle, activeWindowTitle
;What this does: If this string contains the thing in quotes, set the current profile to that. Else, go to Default (hence the Else).
if InStr(activeWindowTitle, "Mozilla Firefox")
	if InStr(activeWindowTitle, "Google Docs")
		current_profile = Docs
	else
		current_profile = Firefox
else if InStr(activeWindowTitle, "iTunes") or InStr(activeWindowTitle, "MiniPlayer")
	current_profile = iTunes
else if InStr(activeWindowTitle, "Google Chrome")
	if InStr(activeWindowTitle, "Google Docs")
		current_profile = Docs
	else
		current_profile = Chrome
else if InStr(activeWindowTitle, "SciTE4AutoHotkey")
	current_profile = SciTE4AutoHotkey
else
	current_profile = Default
return current_profile
}

;~ ;MsgBox that tells you what profile you're in.
;~ ^F17::
;~ MsgBox, %current_profile%
;~ return