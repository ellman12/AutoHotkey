#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script is the main file that links all of my other scripts together, plus some other things.

/*
* Main Script.ahk and the rest are all a simple spell but quite unbreakable.
* On my K95 keyboard and my Scimitar mouse, I have 18 and 12 G keys, respectively.
* In the garbage iCUE software, I have assigned each of them some keeb shortcuts to send.
* They all involve F13-F24, since 99.9% of keyboards don't have those physical keys, but Windows can still accept them as inputs.
* Keeb G keys 1-12 send ^F13-F24; 13-18 send !F13-F18; and Scimitar G1-12 sends F13-F18 (no modifiers, since there's no need).
* This surprisingly works perfectly.
* I tried doing some stuff with iCUE sending weird language key things, and AHK trying to detect those scan codes, but I couldn't get
it working. *Shrug*
* This file is mainly for generic keeb shortcuts and things that are used everywhere, and to house the iCUE keeb shortcuts (look at the
bottom of the file). Changed on 10/27/2019. Now, all the respective files house their respective actions and stuff. It makes way more sense
to do it this way.
* Some of the others like Browser, Docs, Sheets, are used to house the actions that pertain to that current profile (which I define as
the set of actions that are done by the G keys depending on the current active window/program).
* Hopefully this explains it well enough.
*/

Menu, Tray, Icon, shell32.dll, 174 ;Changes the icon to a keyboard; perfect for the Main Script file. IDK where I found this...

;****************************************MISCELLANEOUS VARIABLES AND STUFF****************************************
;Variables for F6 group stuff
;Tracks all windows you want as part of your custom group
Global WindowGroupF6 := []
;Tracks the current window you're on
Global CurrentWinF6 := 1

;Variables for F7 group stuff
;Tracks all windows you want as part of your custom group
Global WindowGroupF7 := []
;Tracks the current window you're on
Global CurrentWinF7 := 1

;Used for the step values for NumPad2 and NumPad8 in NumPad Media Control
global Num2And8Step := 3

;The stuff in this loop needs to be running constantly.
Loop {
;Constantly checking to see what profile you should be in.
global current_profile := AutoSelectProfiles()

;The script checks if NumLock is enabled or not, so it can do different things depending on if it is enabled or not. The variable is either 1 or 0.
global NumLockToggled := GetKeyState("NumLock", "T")

;The script checks if ScrollLock is enabled or not, so it can do different things depending on if it is enabled or not. The variable is either 1 or 0.
global ScrollLockToggled := GetKeyState("ScrollLock", "T")

;This works so much better than having a bunch of ugly NumLockToggled = 1 and ScrollLockToggled = 0 things everywhere
if (NumLockToggled = 1 and ScrollLockToggled = 0) {
	global NumPadMode = "MusicBee"
} else if (NumLockToggled = 1 and ScrollLockToggled = 1) {
	global NumPadMode = "YouTube"
} else if (NumLockToggled = 0 and ScrollLockToggled = 0) {
	global NumPadMode = "Normal"
} else if (NumLockToggled = 0 and ScrollLockToggled = 1) {
	global NumPadMode = "Dumbed-Down"
} else {
	global NumPadMode = "Normal"
}

}

;Linking other scripts together.
;Similar to but not exactly like you would in something like Java.
;The variable %A_ScriptDir% is the full path of the directory where the script is located.

#Include, %A_ScriptDir%\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\AutoCapitalize.ahk
#Include, %A_ScriptDir%\AutoCorrect.ahk
#Include, %A_ScriptDir%\Browser.ahk
#Include, %A_ScriptDir%\Chromebook Typing.ahk
#Include, %A_ScriptDir%\Default.ahk
#Include, %A_ScriptDir%\Google Docs.ahk
#Include, %A_ScriptDir%\Google Sheets.ahk
#Include, %A_ScriptDir%\NumPad Media Control.ahk
#Include, %A_ScriptDir%\OSRS (RuneLite).ahk
#Include, %A_ScriptDir%\Profile Switcher.ahk
#Include, %A_ScriptDir%\Run.ahk
#Include, %A_ScriptDir%\SciTE4AutoHotkey Programming.ahk
#Include, %A_ScriptDir%\WindowHider.ahk

;Sooo many #Includes... ;)

;****************************************GLOBAL HOTKEYS***************************************
;These global hotkeys are hotkeys that are always running, regardless of the active window, class, or whatever
;Pushing Windows Key + P suspends all hotkeys, thus "pausing" the script. Useful for when I'm playing games or something.
#p::Suspend

;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab. This scan code is for the grave accent key.
sc029::
Send, !{Tab}
return

;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `. This scan code is for the grave accent key.
^sc029::
Send, ``
return

;Holding Ctrl and Shift and pushing the grave accent key inserts the tilde symbol: ~.
^+sc029::
Send, ~
return


;Moves mouse pointer as far off the screen as possible (on main display); usually either to A, get it out of the way, or B, so I can easily find it.
Insert::
MouseGetPos, mousePosX, mousePosY
MouseMove, 5000, 540, 0
return

;Moves mouse pointer as far off the screen as possible (on second display); usually either to A, get it out of the way, or B, so I can easily find it.
^Insert::
MouseGetPos, mousePosX, mousePosY
MouseMove, -1920, 540, 0
return

;Moves mouse pointer back to where it was before pressing Insert or ^Insert (but not both).
!Insert::
MouseMove, mousePosX, mousePosY, 0
return


;Disables it. Use Ctrl + CapsLock to enable/disable it. This prevents accidentally pressing it.
CapsLock::
return

^CapsLock::
if state := GetKeyState("CapsLock", "T")
    SetCapsLockState, Off
else
    SetCapsLockState, On
return

;Keyboard shortcut that either enables or disables the active window as AlwaysOnTop
^Space::
WinSet, AlwaysOnTop, Toggle, A
return

;Reloads the script. Useful for "recompiling" the script.
;This hotkey also brings back any previously hidden windows.
;This prevents windows from getting hidden indefinitely,
; without being able to restore them.
^#r::
ShowAllHiddenWindows()
Reload
return

;Saves the current file and saves and runs Main Script.ahk (or whatever the first file is in SciTE). Then it returns to the previous file.
!#r::
Send, ^s
Sleep 100
Send, !1
Sleep 100
Send, ^s
Sleep 100
Send, !t
Sleep 100
Send, r
Sleep 50
Send, ^{Tab}
return

;Sends all 4 modifier keys, so I don't have to press them automatically if one gets stuck
*Pause::
Send, {Ctrl}
Sleep 50
Send, {Alt}
Sleep 50
Send, {Shift}
Sleep 50
Send, {LWin}
Sleep 50
return

;Sends the current date and time in this format: 10/31/2019 07:43 PM
:*:datetime::
FormatTime, CurrentDateTime,, M/dd/yyyy h:mm tt
SendInput, %CurrentDateTime%
return

;Same thing, but just the date
:*:currdate::
FormatTime, CurrentDateTime,, M/dd/yyyy
SendInput, %CurrentDateTime%
return

;Same thing, but just the time
:*:currtime::
FormatTime, CurrentDateTime,, h:mm tt
SendInput, %CurrentDateTime%
return

#IfWinActive Cortana
;When Cortana/Search is open, RWin does LWin twice.
RWin::
Send, {LWin}
Sleep 300
Send, {LWin}
return

;Sends a Space and "meaning" when the Windows 10 Search Bar window is active (Cortana).
!s::
Send, {Space}meaning
return
#If

;Open Window Spy
^#s::
Run, C:\Program Files\AutoHotkey\WindowSpy.ahk
return

;M1 copies
^F2::
Send, ^c
return

;M2 cuts
#F2::
Send ^x
return

;M3 pastes
!F2::
Send ^v
return


;Shows you what profile you're currently in. Can also be used for debugging.
^#BackSpace::
MsgBox, 0, Current Profile, Current profile: %current_profile%`n`nNumPadMode: %NumPadMode%
return

;----------------------------------------------------------------------
;*****************************EXPERIMENTAL*****************************
;----------------------------------------------------------------------
;Scroll down faster
F15 & WheelDown::
Send, {WheelDown 8}
return

;Scroll up faster
F15 & WheelUp::
Send, {WheelUp 8}
return

;A "sniper" button, more or less.
RShift::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,1)
KeyWait, RShift
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;A way to make the mouse move faster while Mouse G3 and the Right Button are held down
F15 & RButton::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, RButton
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;~ ;If Scroll Lock is on, Up and Down send Up and Down 10 times per each keystroke.
;~ #If ScrollLockToggled = 1
;~ Up::
;~ Send, {Up 10}
;~ return

;~ Down::
;~ Send, {Down 10}
;~ return
;~ #If

;-------------------------------------------------------------------------------------------
;Anything in this section is temporary, and was added in to perform a simple and quick task.
;-------------------------------------------------------------------------------------------
:*:aai::artificial intelligence
:*:AaI::Artificial Intelligence

;Factorio mods
;~ #n::
;~ Send, ^c
;~ Sleep 80
;~ Send, ^t
;~ Sleep 80
;~ Send, Factorio ^v
;~ Sleep 30
;~ Send, {Enter}
;~ return

;~ #d::
;~ Send, ^l
;~ Sleep 80
;~ Send, ^c
;~ Sleep 200
;~ Send, ^w
;~ Sleep 80
;~ Send, ^w
;~ Sleep 80
;~ Send, {Tab}
;~ Sleep 80
;~ Send, ^v
;~ Sleep 80
;~ Send, {Down}
;~ return

;~ ;Uncommented only when necessary
;~ PrintScreen::
;~ Send, #{PrintScreen}
;~ return

;~ ;For Sociology quizzes
;~ #c::
;~ Send, {Enter}
;~ Sleep 800
;~ Send, ^a
;~ Sleep 800
;~ Send, ^c
;~ Sleep 800
;~ Send, !{Tab}
;~ Sleep 800
;~ Send, ^v
;~ Sleep 800
;~ Send, !{Tab}
;~ Sleep 800
;~ Send, !{Left}
;~ Sleep 800
;~ Send, {Down}
;~ return

;-----------------------------------------------------------------------------------
;Anything below this point was added to the script by the user via the Win+H hotkey.
;-----------------------------------------------------------------------------------
;~ ::am::AM
::pm::PM
:*:ai::AI
::mathces::matches
:*:asap::ASAP
:*:caledonia::Caledonia
:*:kt::KT
:*:kwik trip::Kwik Trip

::its::it's
::itss::its
::git::Git
:*:github::GitHub
:*:frc::FRC
:*:elliott::Elliott
:*:ducharme::DuCharme