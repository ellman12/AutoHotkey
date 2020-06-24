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
DetectHiddenWindows, Off
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

;Pic of all these icons: https://diymediahome.org/wp-content/uploads/shell32_icons.jpg
Menu, Tray, Icon, shell32.dll, 233 ;Changes the icon to a cute little computer.

;******************************************AUTO-EXECUTE**************************************************
;*******************************APPLICATIONSWITCHER HELP GUI INITIALIZATION******************************
; ApplSwitchGUI := "ApplicationSwitcher Help Box GUI"

;Toggle for the hotkey to show/hide the help.
showApplSwitchGUIToggle := 0

;Basic GUI setup.
GUI, ApplSwitchGUI:+AlwaysOnTop
GUI, ApplSwitchGUI:Color, Silver

;Adding the title text.
GUI, ApplSwitchGUI:Font, underline s14
GUI, ApplSwitchGUI:Add, Text, x5 y5, Hotkey
GUI, ApplSwitchGUI:Add, Text, x115 y5, What It Does

;Adding the text for all the hotkeys and what they do.
GUI, ApplSwitchGUI:Font, norm s12
GUI, ApplSwitchGUI:Add, Text, x5 y40,Alt + a`t`tToggles between showing and hiding this help GUI.`nAlt + F6`t`tActivate windows in both the F6 and F7 array.`nAlt + F1/F2`tCreate a new Private Firefox window.`nAlt + F3`t`tCreate a new incognito Chrome window.`nAlt + F6`t`tRemoves active window from the F6 group`nCtrl + Alt + F7`tRemoves active window from the F7 group`nCtrl + F1`tCreate a new normal Firefox window.`nCtrl + F2`tCreate a new normal Firefox window.`nCtrl + F3`tCreate a new normal Chrome window.`nCtrl + F4`tCreate a new normal Chrome window.`nCtrl + F5`tRun File Explorer and switch between wins.`nCtrl + F6`tAdds active window to the F6 group`nCtrl + F7`tAdds active window to the F7 group`nCtrl + Shift + F5`tCreates a new File Explorer window (Shift + MR button).`nCtrl + Shift + F6`tRemoves nonexistent wins from the F6 array.`nCtrl + Shift + F7`tRemoves nonexistent wins from the F7 array.`nF1`t`tRuns Firefox; switches to a FF win and between tabs.`nF12`t`tActivates MS Word windows, one at a time.`nF2`t`tRuns Firefox; switches between windows.`nF3`t`tRuns Chrome; switches to a Chr win and between tabs.`nF4`t`tRuns Chrome; switches between windows.`nF6`t`tNext window in the F6 group.`nF7`t`tNext window in the F7 group.`nF9`t`tThe Back button.`nShift + F1`tSame thing as F1, but reverse order.`nShift + F3`tSame thing as F3, but reverse order.`nShift + F6`tPrevious window in the F6 group.`nShift + F7`tPrevious window in the F7 group.

;*******************************EDIT CLIPBOARD CONTENT INITIALIZATION******************************
;The ECC in the GUI commands helps differentiate these GUI things from any others.
GUI, ECC:Font, s11
GUI, ECC:Add, Text, x5 y5,Current Clipboard Contents. Type what you want to change it to.
GUI, ECC:Add, Edit, HScroll wrap x4 y30 w440 h185 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard%

GUI, ECC:Font, s12
GUI, ECC:Add, Button, gclipboardFinishButton w80 x3 y220,Finish

GUI, ECC:+AlwaysOnTop
GUI, ECC:+Resize
GUI, ECC:Color, Silver

;Toggle for showing or hiding the Clipboard GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showClipboardGUIToggle := 0

;*******************************MAIN SCRIPT CONTROL PANEL INITIALIZATION******************************
;This is a GUI for the Main Script that allows the user to change how parts of the script work.
GUI, CPanel:+AlwaysOnTop
; GUI, CPanel:Color, Silver

;Insert.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y5,Insert Hotkey Monitor Choice
GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y30 w136 vInsMonChoice, 1 (Primary Mon)||2 (Secondary Mon)

;Ctrl + Insert.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y60,Ctrl + Insert Hotkey Monitor Choice
GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y85 w136 vCtrlInsMonChoice, 1 (Primary Mon)|2 (Secondary Mon)||

;For Chromebook Typing, which monitor to send the mouse pointer too.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y115,Chromebook Typing Monitor Choice
GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y140 w136 vChrBookTypeMonChoice, 1 (Primary Mon)||2 (Secondary Mon)|

;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
global showControlPanelGUI := 0

;Default values.
global InsMonChoice := "1 (Primary Mon)"
global CtrlInsMonChoice := "2 (Secondary Mon)"
global ChrBookTypeMonChoice := "1 (Primary Mon)"

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

	;This sleep statement DRASTICALLY helps reduce the power and CPU usage of the Main Script.
	Sleep 50
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
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Video Game Stuff\Terraria.ahk

;#Include the script for my Secondary Macro Keyboard.
; #Include, %A_MyDocuments%\GitHub\AutoHotkey\Secondary Macro Keyboard\Second Keyboard Script.ahk
#Include, %A_MyDocuments%\GitHub\AutoHotkey\Secondary Macro Keyboard\Hasu USB to USB Script.ahk

;****************************************GLOBAL HOTKEYS***************************************
;These global hotkeys are hotkeys that are always running, regardless of the active window, profile, or whatever.

;Pushing Ctrl + Pause suspends all hotkeys, thus "pausing" the script.
;The reason it's ^CtrlBreak instead of ^Pause is because, according to the documentation, "While the Ctrl key is held down,
;the Pause key produces the key code of CtrlBreak and NumLock produces Pause, so use ^CtrlBreak in hotkeys instead of ^Pause."
^CtrlBreak::Suspend, Toggle

;Pushing the Pause key suspends all hotkeys for the specified number in milliseconds (in this case, 2500).
Pause::
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

;Label for ^CtrlBreak. The timer calls this label, suspends the hotkeys, sets the timer to off,
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
if (InsMonChoice = "1 (Primary Mon)")
	MouseMove, 1920, 540, 0
else if (InsMonChoice = "2 (Secondary Mon)")
	MouseMove, -1920, 540, 0
return

;Moves mouse pointer as far off the screen as possible (on second display); usually either to A, get it out of the way, or B, so I can easily find it.
^Insert::
if (CtrlInsMonChoice = "1 (Primary Mon)")
	MouseMove, 1920, 540, 0
else if (CtrlInsMonChoice = "2 (Secondary Mon)")
	MouseMove, -1920, 540, 0
return

;Moves mouse pointer back to where it was before pressing Insert or ^Insert (but not both).
!Insert::
MouseMove, mousePosX, mousePosY, 0
return

; Disables it. Use Ctrl + CapsLock to enable/disable it. This prevents accidentally pressing it.
CapsLock::return

^CapsLock::
if capsLockState := GetKeyState("CapsLock", "T")
    SetCapsLockState, Off
else
    SetCapsLockState, On
return

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
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt
SendInput, %CurrentDateTime%
return

;Same thing, but just the date.
:*:currdate::
FormatTime, CurrentDateTime,, M/d/yyyy
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
Send, ^x
return

;M3 on K95 RGB pastes to the clipboard.
!F24::
Send, ^v
return

;Shows you miscellaneous variables, toggles, etc.
^#BackSpace::
MsgBox, 0, Misc. Variables`, Toggles`, etc.,Current Main Script.ahk profile:  %currentProfile%`n`nNumPadMode: %numPadMode%`n`nChromebook Typing Toggled: %chromebookTypingToggle%`n`nautoNumPadModeToggle: %autoNumPadModeToggle%
return

#If currentProfile != "Terraria"
;Scroll down faster by holding down the G3 key on Scimitar Pro RGB.
F15 & WheelDown::
Send, {WheelDown 8}
return

;Scroll up faster by holding down the G3 key on Scimitar Pro RGB.
F15 & WheelUp::
Send, {WheelUp 8}
return

;A way to make the mouse move faster while Mouse G3 and the Right Button are held down.
;It's basically the complete opposite of the sniper button.
;I have no idea how these DllCall functions work, nor do I know where I found this stuff.
F15 & RButton::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, RButton
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

#If

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

;Keyboard shortcut originally inspired by Chrome OS; minimizes the active window.
!SC00C::
WinMinimize, A
return

;Maximizes the active window. It's supposed to be Alt + +, but it's technically !=.
!SC00D::
WinMaximize, A
return

;Open "AHK Scripts" folder in AutoHotkey GitHub repository folder on my PC.
^+f::
Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts
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

;*****************************STUFF FOR EDIT CLIPBOARD CONTENT******************************

;Toggles between showing and hiding the Clipboard GUI.
#c::
GuiControl, ECC:,clipboardBoxText, %Clipboard%

showClipboardGUIToggle := !showClipboardGUIToggle

if (showClipboardGUIToggle = 1)
	GUI, ECC:Show, w450 h255,Clipboard Edit
else
	GUI, ECC:Hide
return

;***************************LABELS***************************
;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, Alt + F4, etc.
ECCGuiClose:
    GUI, ECC:Submit, NoHide
    GuiControl, ECC:Focus, clipboardBoxText
    GUI, ECC:Hide
    showClipboardGUIToggle := !showClipboardGUIToggle
return

;Label for the text box.
clipboardTextBoxLabel:
    GUI, ECC:Submit, NoHide
return

;Label for when the user presses the Finish button.
clipboardFinishButton:
    GUI, ECC:Submit
    Clipboard := clipboardBoxText
    showClipboardGUIToggle := !showClipboardGUIToggle
return

;*****************************************MAIN SCRIPT CONTROL PANEL*********************************
;Show hide the Main Script Control Panel.
#o::
showControlPanelGUI := !showControlPanelGUI

if (showControlPanelGUI = 1)
	GUI, CPanel:Show, w280 h170,Main Script Control Panel
else
	GUI, CPanel:Hide
return

CPanelGuiClose:
CPanelGuiEscape:
GUI, CPanel:Submit
showControlPanelGUI := !showControlPanelGUI
return

;*****************************************EASY WINDOW DRAGGING (EWD)*********************************
;Normally, a window can only be dragged by clicking on its title bar.
;This extends that so that any point inside a window can be dragged.
~LButton & RButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; Only if the window isn't maximized 
	SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
	SetTimer, EWD_WatchMouse, Off
	return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
	SetTimer, EWD_WatchMouse, Off
	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
	return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return

;*****************************************EXPERIMENTAL*****************************************
\::
Send, ^+{Left}
Send, {BackSpace}
return

^BackSpace::
Send, ^+{Left}{BackSpace}
return

!Up::Send, {WheelUp}
!Down::Send, {WheelDown}

;For drawing straight lines with the pen tool in MS Word.
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

;*****************************************TEMPORARY*****************************************
;For MediaSpace for D2L for Java class.
; #If numPadMode = "Dumbed-Down"
; ;Shift minus
; $+SC00C::
; $SC00C:: ;Minus
; Send, +{SC00C}
; MouseMove, -290, 1070, 0
; Send, {Click}
; MouseMove, 5000, 540, 0 ;Like Insert.
; return

; ;Shift plus
; $+SC00D::
; $SC00D:: ;Plus
; Send, +{SC00D}
; MouseMove, -290, 1070, 0
; Send, {Click}
; MouseMove, 5000, 540, 0 ;Like Insert.
; return
; #If

;TEMP Auto-fill for distance learning attendance.
^#a::
FormatTime, attendenceMonth, A_Now, M
FormatTime, attendenceDay, A_Now, d

Send, duch_ell@students.cps.k12.mn.us{Tab}Elliott{Tab}DuCharme{Tab}
Send, %attendenceMonth%{Tab}%attendenceDay%{Tab 2}
Sleep 260
Send, {Enter}
return

;English papers.
:*:ai::AI
:*:aai::artificial intelligence
:*:AaI::Artificial Intelligence
;~ :*:bc::breast cancer

;For IntelliJ IDEA 2019.3.1.
; #IfWinActive ahk_exe idea64.exe
; :*:sln::
; Send, System.out.println("");
; Sleep 20
; Send, {Left 3}
; return

; :*:spr::
; Send, System.out.print("");
; Sleep 20
; Send, {Left 3}

; :*:sys::
; Send, System.out.print("");
; Sleep 20
; Send, {Left 3}
; return

; ;Get the mouse's current position, moves the mouse to the Run button, and clicks it.
; ;It does this so fast that if you blink, you'll miss it.
; F5::
; MouseGetPos, F5MouseX, F5MouseY
; MouseMove, 1572, 41, 0 ;X, Y, speed (0 = instant).
; ;~ Sleep 1000
; Send, {Click}
; ;~ Sleep 1000
; MouseMove, %F5MouseX%, %F5MouseY%, 0
; return

; :*:java::Java
; #If

#IfWinActive, ahk_exe EXCEL.EXE
$F2::Send, {F2}
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