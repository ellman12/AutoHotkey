#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir "C:\Users\Elliott\Documents\AHK Scripts"  ; Ensures a consistent starting directory.
#SingleInstance force

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
InputBox, runInputBoxText, Type a command,Cheat sheet for all of the Run.ahk commands (can also be found online by entering the command "Help").`r`rRecommended Command`tWhat It Does`t`t`t`t`t`t`tCategory`n`nDocu FF/Chr`t`tOpens the AHK documentation in either Chrome or Firefox`t`tOpen`nEm/en`t`t`tInserts either of them`t`t`t`t`t`tInsert`nExitApp`t`t`tKills the current running script`t`t`t`t`tMisc`nHelp`t`t`tOpens the Run.ahk sheet in the AHK Google Sheets workbook`t`tOpen`nOp in FF/Chr`t`tOpens the current tab in the specified browser`t`t`t`tOpen`nThes FF/Chr`t`tOpen thesaurus.com in either browser and search for the inputted word`tOpen`nThesaurus FF/Chr`t`tOpen thesaurus.com in the chosen browser`t`t`t`tOpen`nUp/right/down/left arrow`tInserts an arrow symbol`t`t`t`t`t`tInsert`nYT FF/Chr`t`t`tOpens the YouTube homepage in FF/Chr`t`t`t`tOpen`nYT S FF/Chr`t`tOpens the YouTube homepage in FF/Chr and searches for the inputted text`tOpen`nYT SB FF/Chr`t`tOpens the YouTube homepage in FF/Chr and Tabs to the search bar`tOpen`n`nType a command`, and the script will run it.,, 700, 420

;The script decides which command to run.
Switch (runInputBoxText) {

;***********************************************INSERT***********************************************
;AHK can apparently send Unicode characters.
Case "en": Send, {U+2013}
Case "em": Send, {U+2014}

Case "up arrow": Send, {U+2191}
Case "right arrow": Send, {U+2192}
Case "down arrow": Send, {U+2193}
Case "left arrow": Send, {U+2190}

;***********************************************OPEN***********************************************
Case "Help": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=17759502

;Opens the Google spreadsheet for this script, which contains all of the commands in a table.
Case "Help": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=17759502


;Open the documentation in either Firefox or Chrome
Case "Docu FF", "Docu Firefox", "Documentation FF", "Documentation Firefox":
RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
Send, https://www.autohotkey.com/docs/AutoHotkey.htm {Enter}
Sleep 1000
Send, !s
return

Case "Docu Chr", "Docu Chrome", "Documentation Chr", "Documentation Chrome":
RunWait, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
Sleep 1000
Send, !s
return

;Allows you to open any Daily Driver script. Other scripts won't work :( *shrug*
Case "open script", "edit script", "os":
InputBox, openScriptFunctionText, Open Script to Edit, What script do you want to open?
Run, edit %openScriptFunctionText%
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
Case "exit script", "exitapp": ExitApp

;If the user presses Escape or Cancel.
Default:
if ErrorLevel = 1
	MsgBox, ,CANCEL/Escape was pressed., CANCEL/Escape was pressed., 0.3
else
	MsgBox, 16, Unknown command, Command entered: "%runInputBoxText%" does not exist.


}
return