#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;~ MButton::
;~ Send, ^+v
;~ return

;Activate the music-containing window
!b::
;~ WinActivate, Butterfly Tea - MEGA COMPIL | Light Elves Music - Google Chrome
WinActivate, Best of 2010 - Butterfly Reloaded | Light Elves Music - Google Chrome
;~ Sleep 50
WinActivate, Music - Google Sheets - Google Chrome
return

;Delete the blank cell things that happen occasionally
!+b::
Send, ^!-
Sleep 30
Send, !u
Sleep 30
Send, {Down}
return

;Add song name to spreadsheet
^b::
Send, ^c
Sleep 30

WinActivate, Music - Google Sheets - Google Chrome
Sleep 60

;~ Send, ^+v
SendInput, %Clipboard%
Sleep 650
Send, {Down}
Sleep 50

WinActivate, Best of 2010 - Butterfly Reloaded | Light Elves Music - Google Chrome

return

!p::
Pause
return


;Add song nameSSS to spreadsheet (MEGA COMPIL)
#b::

;~ ;TEMP
;~ BigTracks = 197

InputBox, LoopCount, How many times to loop?, How many times to loop?

Loop %LoopCount% {
;~ MouseMove, 257, 466, 0
;~ Sleep 200
Send, {Click 3}
Sleep 300
Send, ^c
Sleep 700

WinActivate, Music - Google Sheets - Google Chrome
Sleep 200

SendInput, %Clipboard%
Sleep 300
Send, {Escape}
Sleep 300
Send, {Up}
Sleep 300
;~ Send, {Left}
;~ Sleep 4000
Send, {Enter}
Sleep 300
Send, {Home}
Sleep 175
Send, {Delete 10}
Sleep 300
Send, {End}
Sleep 175
Send, +{Left 6}
Sleep 300
Send, ^x
Sleep 300
Send, {Tab}
Sleep 300
Send, ^v
Sleep 300
Send, {Enter 2}
Sleep 300

;~ WinActivate, Best of 2010 - Butterfly Reloaded | Light Elves Music - Google Chrome
WinActivate, Butterfly Tea - MEGA COMPIL | Light Elves Music - Google Chrome

;TEMP
;~ Switch (BigTracks) {
;~ 1, 2, 3, 4, 5, 18, 19, 45, 78, 93, 98, 101, 103, 122, 128, 143, 144, 148, 154, 160, 162, 174, 178, 186, 191, 192, 
;~ Case 193, 194, 195, 208, 227, 228, 234, 237, 248, 257:
;~ Send, {Down 3}
;~ Sleep 300
;~ return

;~ Default:
Send, {Down 2}
Sleep 300
;~ return

;~ }

}
return



;300 zoom in Chrome

;Add song nameSSS to spreadsheet (NOT MEGA COMPIL)
^#b::

;~ ;TEMP
;~ BigTracks2 := 1

InputBox, LoopCount2, How many times to loop?, How many times to loop?

Loop %LoopCount2% {

Send, {Click 3}
Sleep 300
Send, ^c
Sleep 700

WinActivate, Music - Google Sheets - Google Chrome
Sleep 200

SendInput, %Clipboard%
Sleep 300
Send, {Escape}
Sleep 300
Send, {Up}
Sleep 300
;~ Send, {Left}
;~ Sleep 400
Send, {Enter}
Sleep 300
/*
Send, {Home}
Sleep 175
Send, {Delete 5}
Sleep 300
Send, {End}
Sleep 175
*/
Send, +{Left 6}
Sleep 300
Send, ^x
Sleep 300
Send, {Tab}
Sleep 300
Send, ^v
Sleep 300
Send, {Enter 2}
Sleep 300

;~ WinActivate, Best of 2010 - Butterfly Reloaded | Light Elves Music - Google Chrome
;~ WinActivate, Butterfly Tea - MEGA COMPIL | Light Elves Music - Google Chrome
Send, !{Tab}
Sleep 400

;TEMP
;~ Switch (BigTracks2) {
;~ Case 2:
;~ Send, {Down 3}
;~ Sleep 300
;~ return

;~ Default:
Send, {Down 2}
Sleep 300
;~ return

;~ }

;~ BigTracks2++

}
return




;Add song nameSSS to spreadsheet (NOT MEGA COMPIL w/ long names)
^#!b::

;~ ;TEMP
BigTracks2 := 1

InputBox, LoopCount2, How many times to loop?, How many times to loop?

Loop %LoopCount2% {

Send, {Click 3}
Sleep 300
Send, ^c
Sleep 700

WinActivate, Music - Google Sheets - Google Chrome
Sleep 200

SendInput, %Clipboard%
Sleep 300
Send, {Escape}
Sleep 300
Send, {Up}
Sleep 300
;~ Send, {Left}
;~ Sleep 400
Send, {Enter}
Sleep 300
/*
Send, {Home}
Sleep 175
Send, {Delete 5}
Sleep 300
Send, {End}
Sleep 175
*/
Send, +{Left 6}
Sleep 300
Send, ^x
Sleep 300
Send, {Tab}
Sleep 300
Send, ^v
Sleep 300
Send, {Enter 2}
Sleep 300

;~ WinActivate, Best of 2010 - Butterfly Reloaded | Light Elves Music - Google Chrome
;~ WinActivate, Butterfly Tea - MEGA COMPIL | Light Elves Music - Google Chrome
Send, !{Tab}
Sleep 400

;TEMP
Switch (BigTracks2) {
Case 17, 19, 27, 43, 54, 55, 65, 67, 76, 78, 79, 93, 110, 111, 112, 113, 116, 17, 118:
Send, {Down 3}
Sleep 300
;~ return

Default:
Send, {Down 2}
Sleep 300
;~ return

}

BigTracks2++

}
return



;~ #v::
;~ SendInput, %Clipboard%
;~ MsgBox % BigTracks2
;~ Loop 17 {
	
;~ Send, {Enter}
;~ Sleep 300
;~ Send, {Home}
;~ Sleep 300
;~ Send, {Delete 5}
;~ Sleep 300
;~ Send, {Enter}
;~ Sleep 300

;~ }
return




/*
#c::
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -incognito https://lightelves.bandcamp.com/album/butterfly-tea-mega-compil
Sleep 1000
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1pAii96_tDHL-7HeZ7yaDGMiJYWecqz8RT_Q02LA18Oc/edit#gid=286211183
Sleep 2500
WinActivate, Butterfly Tea - MEGA COMPIL | Light Elves Music - Google Chrome
return



;Search YT for RS music
;~ #+o::
F10::
SendInput, ^c
Sleep 100
SendInput, ^t
Sleep 600
SendInput, youtube.com{Tab}
Sleep 600
SendInput, %Clipboard% OSRS music
Sleep 600
SendInput, {Enter}
;~ Sleep 600
;~ SendInput, ^1
;~ Sleep 600
;~ SendInput, {Down}
;~ Sleep 600
return


;Search YT for RS remix
!o::
SendInput, ^c
Sleep 600
SendInput, ^t
Sleep 600
SendInput, youtube.com{Tab}
Sleep 600
SendInput, %Clipboard% OSRS remix
Sleep 600
SendInput, {Enter}
Sleep 600
;~ SendInput, ^1
;~ Sleep 600
;~ SendInput, {Down}
;~ Sleep 600
return


;Search YT playlist for RS music
;~ #o::
PrintScreen::
SendInput, {Left}
Sleep 35
SendInput, ^c
Sleep 600
WinActivate, Music - YouTube - Google Chrome
;~ SendInput, ^t
;~ Sleep 600
;~ SendInput, youtube.com{Tab}
Sleep 800
SendInput, ^f
Sleep 400
SendInput, %Clipboard%
Sleep 600
Send, {Enter}
Sleep 800
Send, {Enter}
Sleep 800
Send, {Enter}
Sleep 800
Send, {Enter}
Sleep 800
WinActivate, Music - Google Sheets - Google Chrome
Sleep 1000
Send, {Right}
;~ SendInput, {Enter}
;~ Sleep 600
;~ SendInput, ^1
;~ Sleep 600
;~ SendInput, {Down}
;~ Sleep 600
return

;Yes 4x
Pause::
SendInput, y{Tab}{Tab}
Sleep 25
SendInput, y{Tab}
Sleep 25
SendInput, y{Tab}
Sleep 25
SendInput, y{Enter}
return

;Yes, No, N/A
F12::
SendInput, y{Tab}{Tab}
Sleep 20
SendInput, n{Tab}
Sleep 20
SendInput, N/A{Enter}
return

;Trap No, N/A 3x
F11::
SendInput, n{Tab}
Sleep 20
SendInput, N/A{Tab}
Sleep 20
SendInput, N/A{Tab}
Sleep 20
SendInput, N/A{Enter}
;~ Sleep 20
;~ SendInput, {Left}
return

:*:ny::Not yet

;NOT YET, Yes, Yes, Not yet
F9::
SendInput, Not yet{Tab}{Tab}
Sleep 30
SendInput, y{Tab}
Sleep 30
SendInput, y{Tab}
Sleep 30
SendInput, Not yet{Enter}
return
*/

F6::
Reload
return

/*
;Mass rename Mega Compil song names
#r::

Loop 260 {

Send, {Enter}
Sleep 60
Send, {Home}
Sleep 40
Send, {Delete 10}
Sleep 60
Send, {Enter}

}

return
*/