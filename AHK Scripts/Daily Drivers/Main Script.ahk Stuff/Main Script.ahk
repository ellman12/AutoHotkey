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

/*
* This script is the main file that links all of my other scripts together, plus some other things.
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

Menu, Tray, Icon, shell32.dll, 174 ;Changes the icon to a keyboard.

;******************************************AUTO-EXECUTE**************************************************
;*******************************EDIT CLIPBOARD CONTENT INITIALIZATION******************************
;The ECC in the GUI commands helps differentiate these GUI things from any others.
GUI, ECC:Font, s14, Arial ;Font settings for the Text Box.
GUI, ECC:Add, Edit, HScroll wrap r9 x15 y40 w560 h200 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard% ;Creates an edit box for inputting the clipboard. AHK GUI Documentation explains the r, x, etc. stuff.

;Creating the GUI button for the Finish button: when the user is done editing the clipboard contents.
GUI, ECC:Add, Button, w100 gclipboardFinishButton,Finish

GUI, ECC:Font, s15, Arial ;Font settings for everything else.
GUI, ECC:Add, Text, x16 y5, Current Clipboard contents. Type what you want to change it to. ;Text instructing the user what to do.

;Making the GUI always on top, and giving it a Silver color.
GUI, ECC:+AlwaysOnTop
GUI, ECC:Color, Silver

;Toggle for showing or hiding the Clipboard GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showClipboardGUIToggle := 0

;****************************************MISC VARIABLES, INITIALIZATION, ETC*********************************
;Variables for F6 group stuff.
;Tracks all windows you want as part of your custom group.
;Stores Window IDs.
global WindowGroupF6 := []
;Tracks the current window you're on.
global CurrentWinF6 := 1

;Variables for F7 group stuff.
;Tracks all windows you want as part of your custom group.
;Stores Window IDs.
global WindowGroupF7 := []
;Tracks the current window you're on.
global CurrentWinF7 := 1

;Holds the F6 and F7 Window IDs for ActivateBothF6AndF7Windows() in ApplicationSwitcher.ahk.
global F6andF7WinIDArray := []
;Tracks the current window for the previous array.
global CurrentWinF6AndF7ActBoth := 1

;Holds the F6 and F7 Window IDs for ActivateBothF6AndF7Windows() in ApplicationSwitcher.ahk.
; global F6andF7WinIDArray := []
; ;Tracks the current window for the previous array.
; global CurrentWinF6AndF7ActBoth := 1

;Used for the step values for NumPad2 and NumPad8 in NumPad Media Control.
global Num2And8Step := 3

;Toggle for if the NumPad switches modes automatically or not; starts out at true, for convenience.
global autoNumPadModeToggle := true

;*************Screen Clipper.ahk Initialization Stuff************
;************************************************
Hotkey, #s , CreateCapWindow , On ;Take a screen clip with the Screen Clipper script.
;************************************************
SaveToFile := 1 ;Set this to 1 to save all clips with a unique name , Set it to 0 to overwrite the saved clip every time a new clip is made.
;************************************************
ShowCloseButton := 1 ;Set this to 1 to show a small close button in the top right corner of the clip. Set this to 0 to keep the close button, but not show it.
;************************************************

CoordMode, Mouse , Screen ;Use the screen as the refrence to get positions from.

IfNotExist, %A_ScriptDir%\Screen Clipper Script\Saved Clips ; if there is no folder for saved clips
	FileCreateDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ; create the folder.
SetWorkingDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;Set the saved clips folder as the working dir.
Handles := [] ; Create an array to hold the name of the different gui's.
Index := 0 ;Used as the name of the current gui cap window.

;The stuff in this loop needs to be running constantly.
Loop {

	;Constantly checking to see what profile the script should put the user in.
	global currentProfile := autoSelectProfiles()

	;For the NumPad stuff.
	global numLockToggled := GetKeyState("NumLock", "T")
	global scrollLockToggled := GetKeyState("ScrollLock", "T")

	;Get the active window title; used only in this Loop for the numPadMode stuff.
	WinGetActiveTitle, mainLoopActWinTitle

	;If the auto-numpad toggle is true, sets the numPadMode automatically.
	;Else, leave it to the user to do it manually.
	if (autoNumPadModeToggle = true) {

		if InStr(mainLoopActWinTitle, "- YouTube") {
			SetNumLockState, On
			SetScrollLockState, On
			global numPadMode = "YouTube"
		} else if InStr(mainLoopActWinTitle, "- MediaSpace") {
			SetNumLockState, Off
			SetScrollLockState, On
			global numPadMode = "Dumbed-Down"
		} else {
			SetNumLockState, On
			SetScrollLockState, Off
			global numPadMode = "MusicBee"
		}

	} else {

		;This works so much better than having a bunch of ugly numLockToggled = 1 and scrollLockToggled = 0 things everywhere.
		;These variables are used in NumPad Media Control.ahk.
		if (numLockToggled = 1 and scrollLockToggled = 0) {
			global numPadMode = "MusicBee"
		} else if (numLockToggled = 1 and scrollLockToggled = 1) {
			global numPadMode = "YouTube"
		} else if (numLockToggled = 0 and scrollLockToggled = 0) {
			global numPadMode = "Normal"
		} else if (numLockToggled = 0 and scrollLockToggled = 1) {
			global numPadMode = "Dumbed-Down"
		} else {
			global numPadMode = "Normal"
		}

	}

	;This sleep statement DRASTICALLY helps reduce the power usage of the Main Script.
	Sleep 100

}

;Linking other scripts together.
;#Include is lterally like pasting those script contents in that exact spot.
;The variable %A_ScriptDir% is the full path of the directory where the script is located; makes code neater and simpler.

#Include, %A_ScriptDir%\Main Script.ahk Profiles\Browser.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\Default.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\Google Docs.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\Google Sheets.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\Microsoft Word.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\OSRS (RuneLite).ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\Profile Switcher.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\SciTE4AutoHotkey Programming.ahk
#Include, %A_ScriptDir%\Main Script.ahk Profiles\VSCode.ahk
; #Include, %A_ScriptDir%\Misc. Main Script.ahk Scripts\Advanced Window Hider.ahk
#Include, %A_ScriptDir%\Misc. Main Script.ahk Scripts\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Misc. Main Script.ahk Scripts\AutoCorrect.ahk
#Include, %A_ScriptDir%\Misc. Main Script.ahk Scripts\Chromebook Typing.ahk
#Include, %A_ScriptDir%\Misc. Main Script.ahk Scripts\NumPad Media Control.ahk
#Include, %A_ScriptDir%\Misc. Main Script.ahk Scripts\Run.ahk
#Include, %A_ScriptDir%\Screen Clipper Script\Screen Clipper.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Any Game.ahk

;****************************************GLOBAL HOTKEYS***************************************
;These global hotkeys are hotkeys that are always running, regardless of the active window, class, or whatever.
;Pushing Windows Key + P suspends all hotkeys, thus "pausing" the script.
#!p::Suspend, Toggle

;TODO TEMP
F10::
Send, GUI, GCALGUI:
Return
F11::
Send, ************
Return
^F11::
Send, ******
Return

;Pushing Win + Alt + p suspends all hotkeys for the specified number in milliseconds (in this case, 2500).
#p::
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

;Label for #!p. The timer calls this label, suspends the hotkeys, sets the timer to off,
;and then goes back to the original hotkey that then unsuspends the script hotkeys.
setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
return

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
; CapsLock::return

; ^CapsLock::
; if capsLockState := GetKeyState("CapsLock", "T")
;     SetCapsLockState, Off
; else
;     SetCapsLockState, On
; return

;Keyboard shortcut that either enables or disables the active window as AlwaysOnTop
^Space::
WinSet, AlwaysOnTop, Toggle, A
return

;Reloads the script. Useful for "recompiling" the script.
^#r::
Reload
return

;Sends the current date and time in this format: 10/31/2019 07:43 PM.
:*:datetime::
FormatTime, CurrentDateTime,, M/dd/yyyy h:mm tt
SendInput, %CurrentDateTime%
return

;Same thing, but just the date.
:*:currdate::
FormatTime, CurrentDateTime,, M/dd/yyyy
SendInput, %CurrentDateTime%
return

;Same thing, but just the time.
:*:currtime::
FormatTime, CurrentDateTime,, h:mm tt
SendInput, %CurrentDateTime%
return

;When Cortana/Search is open, RWin does LWin twice.
#IfWinActive Cortana
RWin::
Send, {LWin}
Sleep 300
Send, {LWin}
return

;Sends a Space and "meaning" when the Windows 10 Search Bar window is active (Cortana).
;Equivalent to G15 in Browser.
!s::
Send, {Space}meaning
return
#If

;Open Window Spy.
^#s::
Run, C:\Program Files\AutoHotkey\WindowSpy.ahk
return

;M1 on K95 RGB copies to the clipboard.
+F24::
Send, ^c
return

;M2 on K95 RGB cuts to the clipboard.
#F24::
Send ^x
return

;M3 on K95 RGB pastes to the clipboard.
!F24::
Send ^v
return

;Shows you miscellaneous variables, toggles, etc.
^#BackSpace::
MsgBox, 0, Misc. Variables`, Toggles`, etc.,Current Main Script.ahk profile:  %currentProfile%`n`nNumPadMode: %numPadMode%`n`nChromebook Typing Toggled: %chromebookTypingToggle%`n`nautoNumPadModeToggle: %autoNumPadModeToggle%
return



;Scroll down faster by holding down the G3 key on Scimitar Pro RGB.
F15 & WheelDown::
Send, {WheelDown 8}
return

;Scroll up faster by holding down the G3 key on Scimitar Pro RGB.
F15 & WheelUp::
Send, {WheelUp 8}
return

;A "sniper" button, more or less, that slows the mouse pointer speed down to a crawl.
;Pressing this key also sends out the normal RShift key, somehow. I added ~ to the hotkey after looking at this forum post:
;https://www.autohotkey.com/boards/viewtopic.php?t=40770
; and it somehow made it work perfectly.
;I have no idea how these DllCall functions work, nor do I know where I found this stuff.
~$RShift::
Send, {RShift}
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,1)
KeyWait, RShift
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;A way to make the mouse move faster while Mouse G3 and the Right Button are held down.
;It's basically the complete opposite of the sniper button.
;I have no idea how these DllCall functions work, nor do I know where I found this stuff.
F15 & RButton::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, RButton
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;Keyboard shortcut originally inspired by Chrome OS; minimizes the active window.
!-::
WinMinimize, A
return

;Maximizes the active window. It's supposed to be Alt + +, which gave me troubles before I realized the shortcut is technically !=.
!=::
WinMaximize, A
return

;Open "AHK Scripts" folder in AutoHotkey GitHub repository folder on my PC.
^+f::
Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts
return

;Moves the active window to the primary display (first monitor).
#Home::
WinMove, %mainLoopActWinTitle%,, 500, 300
return

;Moves the active window to the secondary display (second monitor).
#End::
WinMove, %mainLoopActWinTitle%,, -1400, 300
return

;*****************************************HOTKEYS FOR TITLE STUFF*********************************
;These hotkeys allow the user to adjust and modify text in whatever way they want.
;Can be used for titles or whatever you want.

;I used to use this website: https://capitalizemytitle.com/, but it takes way too long to
; load up every time I want to use it, so I got to work on this script.
;It works exactly like it, but faster and runs offline.
;TCT is shorthand for Title Capitalization Tool.
;Inspiration and code for this script: https://autohotkey.com/board/topic/57888-title-case/ and https://autohotkey.com/board/topic/123994-capitalize-a-title/

;Converts text to Title Case, using a custom thing I found on r/AutoHotkey.
^!t::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;Makes the title in AHK's "Title Case", which in reality just capitalizes the first letter of each word. Not sure why this line needs to be here.
  StringUpper, NewTitle, Clipboard, T
  head := SubStr(NewTitle, 1, 1) ;Manipulates and edits the String somehow.
  tail := SubStr(NewTitle, 2)

  ;Stores the NewTitle in the Clipboard.             This is the list of words to NOT capitalize.
  Clipboard := head RegExReplace(tail, "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")

  Send ^v ;Paste the new title.
return ;End of ^!t.

;Converts text to UPPER CASE, using a built-in AHK function.
^!u::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;Make the title UPPER CASE, using a built-in AHK function.
  StringUpper, NewTitle, Clipboard

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!u.

;Converts text to lower case, using a built-in AHK function.
^!l::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;Make the title lower case, using a built-in AHK function.
  StringLower, NewTitle, Clipboard

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!l.

;Converts text to Sentence case.
;I don't really know how it works; I found this on r/AHK, too.
^!s::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;I don't have a clue how this works.
  StringLower, NewTitle, Clipboard
  NewTitle := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!s.

;Converts text to First Letter Capitalization, using a built-in AHK function.
^!f::

  Send, ^c
  Sleep 45

  StringUpper, NewTitle, Clipboard, T

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!f.

;altCaseToggle is a toggle for if the alt case starts in lower case or not.
;A_LoopField is the single character at that point in the Parse Loop.
;0 = convert the char (A_LoopField) to lower...
;...1 = convert the char to UPPER.

;Convert text to aLt CaSe, with the first letter being lower case.
^!a::

	;Blank out this String.
	;Basically resetting it so it doesn't contain the old text as well as the new stuff.
	finalString :=

	;Set it to 0 because it needs to start lower (see comment at the top of the script).
	altCaseToggle := 0

	;Copy the text, and wait a bit so it can actually get a change to store it in the showoard.
	Send, ^c
	Sleep, 50

	;Loop through the contents of the Clipboard, and toggle between cases.
	Loop, Parse, Clipboard
	{
		if (altCaseToggle = 0) {
			if (A_LoopField = A_Space) {
				;If the current char is a space, don't toggle the var and just concatenate it to the finalString.
				finalString := finalString . A_Space
			} else {
				StringLower, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		} else if (altCaseToggle = 1) {
			if (A_LoopField = A_Space) {
				finalString := finalString . A_Space
			} else {
				StringUpper, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		}
	}

	;Store the final aLt CaSe String in the Clipboard.
	Clipboard := finalString

	;Paste the final String.
	Send, ^v

return ;End of ^!a.

;Convert text to AlT cAsE, with the first letter being UPPER case.
^!+a::

	;Blank out this String.
	;Basically resetting it so it doesn't contain the old text as well as the new stuff.
	finalString :=

	;Set it to 0 because it needs to start lower (see comment at the top of the script).
	altCaseToggle := 1

	;Copy the text, and wait a bit so it can actually get a change to store it in the Clipboard.
	Send, ^c
	Sleep, 50

	;Loop through the contents of the Clipboard, and toggle between cases.
	Loop, Parse, Clipboard
	{
		if (altCaseToggle = 0) {
			if (A_LoopField = A_Space) {
				finalString := finalString . A_Space
			} else {
				StringLower, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		} else if (altCaseToggle = 1) {
			if (A_LoopField = A_Space) {
				finalString := finalString . A_Space
			} else {
				StringUpper, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		}
	}

	;Store the final aLt CaSe String in the Clipboard.
	Clipboard := finalString

	;Paste the final String.
	Send, ^v

return ;End of ^!a.

;-------------------------------------------------------------------------------------------
;*****************************STUFF FOR EDIT CLIPBOARD CONTENT******************************
;-------------------------------------------------------------------------------------------
;Toggles between showing and hiding the Clipboard GUI.
#c::
GUI, ECC:Show, w600 h400,Clipboard Edit
return

;***************************LABELS***************************
;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, Alt + F4, etc.
1GuiClose:
    GUI, ECC:Submit, NoHide
    GuiControl, ECC:Focus, clipboardBoxText
    GUI, ECC:Hide
    showClipboardGUIToggle := !showClipboardGUIToggle
return

;Label for the text box.
clipboardTextBoxLabel:
    GUI, ECC:Submit, NoHide
    Clipboard := clipboardBoxText
return

;Label for when the user presses the Done button.
;This button is exactly like the Finish button in TCT, where it stores the text in the Clipboard variable.
clipboardFinishButton:
    Clipboard := clipboardBoxText
    GUI, ECC:Hide
    GuiControl, ECC:Focus, %clipboardBoxText%
return

;----------------------------------------------------------------------
;*****************************EXPERIMENTAL*****************************
;----------------------------------------------------------------------

\::
Send, ^+{Left}
Send, {BackSpace}
return

^BackSpace::
Send, ^+{Left}{BackSpace}
return

;For drawing straight lines in MS Word.
; ^!Up::
; Send, {Click up}
; return

; ^!Down::
; Send, {Click down}
; return

; ^!Left::
; MouseMove, -10, 0, 0, R
; return

; ^!Right::
; MouseMove, 10, 0, 0, R
; return

;~ ;If Scroll Lock is on, Up and Down send Up and Down 10 times per each keystroke.
;~ #If scrollLockToggled = 1
;~ Up::
;~ Send, {Up 10}
;~ return

;~ Down::
;~ Send, {Down 10}
;~ return
;~ #If

;~ #IfWinActive "Calculator"
;~ WinSet, AlwaysOnTop, On, Calculator
; WinSet, AlwaysOnTop, Toggle, Calculator ; Toggle the always-on-top status of Calculator.
;~ return

;-------------------------------------------------------------------------------------------
;Anything in this section is temporary.
;-------------------------------------------------------------------------------------------

;English papers.
:*:aai::artificial intelligence
:*:AaI::Artificial Intelligence

;For IntelliJ IDEA 2019.3.1.
#IfWinActive ahk_exe idea64.exe
:*:sln::
Send, System.out.println("");
Sleep 20
Send, {Left 3}
return

:*:spr::
Send, System.out.print("");
Sleep 20
Send, {Left 3}

:*:sys::
Send, System.out.print("");
Sleep 20
Send, {Left 3}
return

;Comment out a line, but not the intelli-gay way.
$^/::
Send, {Home}//{Space}
return

;Comment out normally.
^!/::
Send, ^/
return

;Get the mouse's current position, moves the mouse to the Run button, and clicks it.
;It does this so fast that if you blink, you'll miss it.
F5::
MouseGetPos, F5MouseX, F5MouseY
MouseMove, 1572, 41, 0 ;X, Y, speed (0 = instant).
;~ Sleep 1000
Send, {Click}
;~ Sleep 1000
MouseMove, %F5MouseX%, %F5MouseY%, 0
return

:*:java::Java
#If


;~ ;Temp for moving single tracks to new folder
;~ #y::
;~ MsgBox, Alt Tab stupid ass! Make sure pointer is in the right spot dummy!
;~ Sleep 1000
;~ Loop 54 {
;~ Send, {Enter}
;~ Sleep 400
;~ Send, ^a
;~ Sleep 80
;~ Send, ^c
;~ Sleep 80
;~ Send, !{Tab}
;~ Sleep 705
;~ Send, ^v
;~ Sleep 470
;~ Send, !{Tab}
;~ Sleep 460
;~ Send, !{Up}
;~ Sleep 600
;~ Send, {Delete}
;~ Sleep 450

;~ ;Get cursor to the next folder
;~ Send, {Down}
;~ Sleep 700
;~ Send, {Up}
;~ Sleep 700


;~ Send, {Click}
;~ SLeep 550
;~ }
;~ return

;Temp for mass renaming in MusicBee
;~ #y::

;~ Loop 15 {
;~ Send, {End}
;~ Sleep 200
;~ Send, {BackSpace 4}
;~ Send, {Click}
;~ Sleep 240

;~ Send,  - Mario Kart Wii

;~ }

;~ return

;Used for mass-deleting 2,904 videos from Watch later on YouTube.
;~ #y::

;~ Loop 2879 {

	;~ IfWinActive, Watch later - YouTube - Mozilla Firefox
	;~ {
	;~ MouseMove, 1483, 244, 0

	;~ Sleep 500

	;~ Send, {Click}

	;~ MouseMove, 1481, 381, 0

	;~ Sleep 500

	;~ Send, {Click}
	;~ }

;~ }
;~ return