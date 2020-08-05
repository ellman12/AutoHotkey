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
InputBox, runInputBoxText, Type a command,Cheat sheet for all of the Run.ahk commands (can also be found online by entering the command "Help").`r`rRecommended Command`tWhat It Does`t`t`t`t`t`t`tCategory`n`nDocu FF/Chr`t`tOpens the AHK documentation in either Chrome or Firefox`t`tOpen`nEm/en`t`t`tInserts either of them`t`t`t`t`t`tInsert`nExitApp`t`t`tKills the current running script`t`t`t`t`tMisc`nHelp`t`t`tOpens the Run.ahk sheet in the AHK Google Sheets workbook`t`tOpen`nOp in FF/Chr`t`tOpens the current tab in the specified browser`t`t`t`tOpen`nSec`t`t`tInserts the section symbol`t`t`t`t`t`tInsert`nThes FF/Chr`t`tOpen thesaurus.com in either browser and search for the inputted word`tOpen`nThesaurus FF/Chr`t`tOpen thesaurus.com in the chosen browser`t`t`t`tOpen`nUp/right/down/left`t`tInserts the corresponding arrow symbol`t`t`t`tInsert`nst`t`t`tGet free space of all the drives in GB.`t`t`t`t`tMisc`nYT FF/Chr`t`t`tOpens the YouTube homepage in FF/Chr`t`t`t`tOpen`nYT S FF/Chr`t`tOpens the YouTube homepage in FF/Chr and searches for the inputted text`tOpen`nYT SB FF/Chr`t`tOpens the YouTube homepage in FF/Chr and Tabs to the search bar`tOpen`n`nType a command`, and the script will attempt to run it.

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

;Opens the YouTube homepage in Chrome
Case "YT Chr": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.youtube.com

;Opens the YouTube homepage in Firefox
Case "YT FF": Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.youtube.com

;Opens the YouTube homepage in Chrome and searches for the inputted text
Case "YT S Chr":
InputBox, YT_S_ChrInputBox, What Do You Want to Search YT For?, Search YouTube in Chrome
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.youtube.com
Sleep, 2300
Send, {Tab 4}
Sleep 30
Send, %YT_S_ChrInputBox%
Sleep 30
Send, {Enter}
return

;Opens the YouTube homepage in Firefox and searches for the inputted text
Case "YT S FF":
InputBox, YT_S_FFInputBox, What Do You Want to Search YT For?, Search YouTube in Firefox
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.youtube.com
Sleep, 3000
Send, {Tab 4}
Sleep 30
Send, %YT_S_FFInputBox%
Sleep 30
Send, {Enter}
return

;Opens the YouTube homepage in Chrome and Tabs to the search bar
Case "YT SB Chr":
RunWait, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.youtube.com
Sleep, 2300
Send, {Tab 4}
return

;Opens the YouTube homepage in Firefox and Tabs to the search bar
Case "YT SB FF":
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.youtube.com
Sleep, 3000
Send, {Tab 4}
return

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

;If the user presses Escape or Cancel.
Default:
if ErrorLevel = 1
	Tippy("CANCEL/Escape was pressed.", 500)
else
	MsgBox, 16, Unknown command, Command entered: "%runInputBoxText%" does not exist.


}
return