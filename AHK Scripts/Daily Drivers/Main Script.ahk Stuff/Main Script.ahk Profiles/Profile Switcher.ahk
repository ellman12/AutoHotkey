;This script is for Main Script.ahk.
;It is used for getting the active window title and putting you in the right profile

;According to the documentation: "2: A window's title can contain WinTitle anywhere inside it to be a match."
;I don't know when, nor why, I put this here.
SetTitleMatchMode, 2

;This needs to be global so other scripts can see it and access it.
;Doing this is how I was able to do the Sheets/Docs G4 and G10 stuff.
global activeWindowTitle

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
	else
		currentProfile = Default

	return currentProfile
}