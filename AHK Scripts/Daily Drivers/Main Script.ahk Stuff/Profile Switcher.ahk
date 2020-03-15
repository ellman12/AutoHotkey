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

autoSelectProfiles() {
	WinGetActiveTitle, activeWindowTitle
	;What this does: If this string contains the thing in quotes, set the current profile to that. Else, go to Default (hence the Else).
	if InStr(activeWindowTitle, "Mozilla Firefox")
		if InStr(activeWindowTitle, " - Google Docs")
			currentProfile = Docs
		else if InStr(activeWindowTitle, " - Google Sheets")
			currentProfile = Sheets
		else
			currentProfile = Firefox
	; else if InStr(activeWindowTitle, "MusicBee")
		; currentProfile = MusicBee
	else if InStr(activeWindowTitle, "Google Chrome")
		if InStr(activeWindowTitle, " - Google Docs")
			currentProfile = Docs
		else if InStr(activeWindowTitle, " - Google Sheets")
			currentProfile = Sheets
		else
			currentProfile = Chrome
	else if InStr(activeWindowTitle, "SciTE4AutoHotkey")
		currentProfile = SciTE4AutoHotkey
	else if InStr(activeWindowTitle, "RuneLite") or InStr(activeWindowTitle, "RuneScape")
		currentProfile = RuneScape
	else if InStr(activeWindowTitle, " - Word")
		currentProfile = MSWord
	else if Instr(activeWindowTitle, " - Visual Studio Code")
		currentProfile = VSCode
	; else if Instr(activeWindowTitle, "DOOM") ;TODO Switch to Any Game or something...
		; currentProfile = DOOM
	else
		currentProfile = Default

	return currentProfile
}