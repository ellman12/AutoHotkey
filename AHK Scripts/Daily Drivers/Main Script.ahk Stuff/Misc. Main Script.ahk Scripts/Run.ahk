/*
;This script allows me to run and do miscellaneous things that don't deserve their own (hot)key.
;It's like the #r thing that Windows already has.
;E.g., I /could/ type www.google.com and do a bunch of other crap with that, or I could be more specific and say:
;"google Firefox incognito (or private); tomato tomato or whatever.
;This script is essentially a single hotkey, and a bigass Switch statement.
;NGl it's pretty sloppy and not very pretty so try your best to be able to read it.
*/

;Alt + R opens the InputBox, which allows the user to type a command. It also contains a cheat sheet of all of the commands, in alphabetical order.
;This one single line is astronomically enormous, so Word Wrap is recommended.
!r::
InputBox, runInputBoxText, Type a command,Recommended Command`tWhat It Does`t`t`t`t`t`t`tCategory`nDocu FF/Chr`t`tOpens the AHK documentation in either Chrome or Firefox.`t`tOpen`nEm/en`t`t`tInserts either of them.`t`t`t`t`t`tInsert`nExitApp`t`t`tKills the current running script.`t`t`t`t`tMisc`nGM`t`t`tToggles Game Mode`, disabling hotkeys/strings that interrupt gaming.`tMisc`nHelp`t`t`tOpens the Run.ahk sheet in the AHK Google Sheets workbook.`t`tOpen`nMB`t`t`tOpens the MsgBox Creator script.`t`t`t`t`tOpen`nOp in FF/Chr`t`tOpens the current tab in the specified browser`t`t`t`tOpen`nSec`t`t`tInserts the section symbol.`t`t`t`t`t`tInsert`nThes FF/Chr`t`tOpen thesaurus.com in either browser and search for the inputted word.`tOpen`nThesaurus FF/Chr`t`tOpen thesaurus.com in the chosen browser.`t`t`t`tOpen`nUp/right/down/left`t`tInserts the corresponding arrow symbol.`t`t`t`tInsert`nst`t`t`tGet free space of all the drives in GB.`t`t`t`t`tMisc,, 698, 330

;The script decides which command to run.
Switch (runInputBoxText) {

;***********************************************INSERT***********************************************
;AHK can apparently send Unicode characters.
Case "en": Send, {U+2013}
Case "em": Send, {U+2014}

Case "Sec", "Section": Send, {U+00A7}

Case "up": Send, {U+2191}
Case "right": Send, {U+2192}
Case "down": Send, {U+2193}
Case "left": Send, {U+2190}

;***********************************************OPEN***********************************************
Case "Help": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=17759502

;Opens the Google spreadsheet for this script, which contains all of the commands in a table.
Case "Help": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=17759502

Case "MsgBox Creator", "MsgBox", "Msg", "MB":Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Misc. Main Script.ahk Scripts\MsgBox Creator.ahk

;Open the documentation in either Firefox or Chrome
Case "Docu FF", "Docu Firefox", "Documentation FF", "Documentation Firefox":
RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
Sleep 1000
Send, !s
return

Case "Docu Chr", "Docu Chrome", "Documentation Chr", "Documentation Chrome":
RunWait, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
Sleep 1000
Send, !s
return

;Opens the current tab in Chrome
Case "Open in Chrome", "op in chr", "op in Chrome":
Send, ^l
Sleep, 80
Send, ^c
Sleep 80
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %Clipboard%
return

;Opens the current tab in Firefox
Case "Open in Firefox", "op in ff", "op in Firefox":
Send, ^l
Sleep, 80
Send, ^c
Sleep 80
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" %Clipboard%
return

;Open thesaurus.com in Chrome and search for the inputted word
Case "Thes Chr", "Thes Chrome":
InputBox, Thes_ChrInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Chrome.
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.thesaurus.com/browse/%Thes_ChrInputBox%
return

;Open thesaurus.com in Firefox and search for the inputted word
Case "Thes ff", "Thes Firefox":
InputBox, Thes_FFInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Firefox.
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/browse/%Thes_FFInputBox%
return


;Open thesaurus.com in Chrome.
Case "Thesaurus Chr", "Thesaurus.com Chr": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.thesaurus.com/

;Open thesaurus.com in Firefox.
Case "Thesaurus FF", "Thesaurus.com FF": Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/

;***********************************************MISC***********************************************
;Get free space in GB of all the drives.
Case "drive stat", "dr st", "st":
	DriveGet, OutputVar, List, Fixed ; get drive letters
	Loop, Parse, OutputVar ; extract single drive letters
	{
		DriveSpaceFree, FreeSpace, %A_LoopField%:\
		FreeSpace := FreeSpace / 1000
		FreeSpace := Round(FreeSpace, 2) ;Convert to GB and round to 2 decimal places.
		Total := (Total . A_LoopField ":\     " FreeSpace " GBish free" "`n") ; create list
	}
	StringTrimRight, Total, Total, 1 ; get rid of tailing linefeed char

	MsgBox, 0, Drive Stats, Drive Stats`n`n%Total%
return

Case "exit script", "exitapp": ExitApp

Case "Game Mode", "GM":
gameModeActive := !gameModeActive

if (gameModeActive = true)
	Tippy("Game Mode activated!", 1200)
else
	Tippy("Game Mode disabled!", 1200)
return

;If the user presses Escape or Cancel.
Default:
if ErrorLevel = 1
	Tippy("CANCEL/Escape was pressed.", 500)
else
	MsgBox, 16, Unknown command, Command entered: "%runInputBoxText%" does not exist.

}
return