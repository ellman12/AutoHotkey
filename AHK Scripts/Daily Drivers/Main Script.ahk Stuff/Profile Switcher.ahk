;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
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
#SingleInstance force
;OPTIMIZATIONS END

;This script is for Main Script.ahk.
;It is used for getting the active window title and putting you in the right profile

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
else if InStr(activeWindowTitle, " - Word")
	current_profile = MSWord
else
	current_profile = Default
return current_profile
}