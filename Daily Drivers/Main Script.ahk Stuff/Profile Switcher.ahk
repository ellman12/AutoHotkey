#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;Gets the active window title and puts you in the right profile

;According to the documentation: "2: A window's title can contain WinTitle anywhere inside it to be a match."
;I don't know when, nor why, I put this here.
SetTitleMatchMode, 2

;This needs to be global so other scripts can see it and access it.
;Doing this is how I was able to do the Sheets/Docs G4 and G10 stuff.
global activeWindowTitle

AutoSelectProfiles() {
WinGetActiveTitle, activeWindowTitle
;What this does: If this string contains the thing in quotes, set the current profile to that. Else, go to Default (hence the Else).
if InStr(activeWindowTitle, "Mozilla Firefox")
	if InStr(activeWindowTitle, " - Google Docs")
		current_profile = Docs
	else if InStr(activeWindowTitle, " - Google Sheets")
		current_profile = Sheets
	else
		current_profile = Firefox
;~ else if InStr(activeWindowTitle, "MusicBee")
	;~ current_profile = MusicBee
else if InStr(activeWindowTitle, "Google Chrome")
	if InStr(activeWindowTitle, " - Google Docs")
		current_profile = Docs
	else if InStr(activeWindowTitle, " - Google Sheets")
		current_profile = Sheets
	else
		current_profile = Chrome
else if InStr(activeWindowTitle, "SciTE4AutoHotkey")
	current_profile = SciTE4AutoHotkey
else if InStr(activeWindowTitle, "RuneLite") or InStr(activeWindowTitle, "RuneScape")
	current_profile = RuneScape
else
	current_profile = Default
return current_profile
}