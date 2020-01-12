#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir "C:\Users\Elliott\Documents\AHK Scripts"  ; Ensures a consistent starting directory.
#SingleInstance force

/*
;This script allows me to run and do miscellaneous things that don't deserve their own (hot)key.
;It's like the #r thing that Windows already has, but better(?). IDK it's more stuff that would
;be too impractically difficult to do in the Windows Run thing.
;E.g., I /could/ type www.google.com and do a bunch of other crap with that, or I could be more specific and say:
;"google Firefox incognito (or private); tomato tomato or whatever.
;This script is essentially a single hotkey, and a bigass Switch statement.
;NGl it's pretty sloppy and not very pretty so try your best to be able to read it.
*/

;Alt + R opens the InputBox
!r::
InputBox, RunInputBoxText, Type a Command, Type a command`, and the script will attempt to run it. Type "help" to open this sheet in the AHK spreadsheet in Chrome.

;The script decides which command to run
Switch (RunInputBoxText) {
Default: MsgBox, 4096, Command does not exist, The command entered: "%RunInputBoxText%"`, doesn't exist m8. Try again.

;***********************************************INSERT***********************************************
Case "en dash", "en": Send, –
Case "em dash", "em": Send, —

;Apparently AHK can send Unicode characters.
Case "up arrow": Send, {U+2191}
Case "right arrow": Send, {U+2192}
Case "down arrow": Send, {U+2193}
Case "left arrow": Send, {U+2190}

;***********************************************OPEN***********************************************
Case "Help": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=17759502

;Opens the Google sheet for this
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
Case "Open in Chrome", "op in chr":
Send, ^l
Sleep, 80
Send, ^c
Sleep 80
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %Clipboard%
return

;Opens the current tab in Firefox
Case "Open in Firefox", "op in ff":
Send, ^l
Sleep, 80
Send, ^c
Sleep 80
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" %Clipboard%
return

;Open thesaurus.com in Chrome and search for the inputted word
Case "Thes Chr":
InputBox, Thes_ChrInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Chrome.
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.thesaurus.com/browse/%Thes_ChrInputBox%
return

;Open thesaurus.com in Firefox and search for the inputted word
Case "Thes Ff":
InputBox, Thes_FFInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Firefox.
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/browse/%Thes_FFInputBox%
return


;Open thesaurus.com in Chrome
Case "Thesaurus Chr", "Thesaurus.com Chr": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.thesaurus.com/

;Open thesaurus.com in Firefox
Case "Thesaurus FF", "Thesaurus.com FF": Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/

;Open this website that capitalizes titles properly in Chrome
Case "TT Chr": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://capitalizemytitle.com/

;Open this website that capitalizes titles properly in Firefox (https://capitalizemytitle.com/)
Case "TT FF": Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://capitalizemytitle.com/

;Opens the TT website in Chrome, but with this you can input what you want to auto-capitalize
Case "ITT Chr":
InputBox, ITTChrInputBox, Input Your Title, Input the title you want capitalized
RunWait, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://capitalizemytitle.com/
Sleep 2300
Send, %ITTChrInputBox%
Send, {Enter}
return

;Opens the TT website in Firefox, but with this you can input what you want to auto-capitalize
Case "ITT FF":
InputBox, ITTFFInputBox, Input Your Title, Input the title you want capitalized
RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://capitalizemytitle.com/
Sleep 2300
Send, %ITTFFInputBox%
Send, {Enter}
return


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

;If the user presses Escape or Cancel
Default:
if ErrorLevel
	MsgBox, ,CANCEL/Escape was pressed., CANCEL/Escape was pressed., 0.95
else
	MsgBox, 16, Unknown Command, Command entered: "%RunInputBoxText%" does not exist


}
return