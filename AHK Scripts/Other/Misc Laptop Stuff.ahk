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
DetectHiddenWindows, On
#SingleInstance force
;OPTIMIZATIONS END

;Misc stuff for my Lenovo T430 laptop.

;Pic of system32 tray icons: https://diymediahome.org/wp-content/uploads/shell32_icons.jpg
;Prevents the icon from AWH from taking over; more info in that script.
useMiscLaptopStuffIcon := true

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

;****************************************MISC VARIABLES AND STUFF*********************************
;Variables for F6 group stuff.
;Tracks all windows you want as part of your custom group.
global WindowGroupF6 := []
;Tracks the current window you're on.
global CurrentWinF6 := 1

;Variables for F7 group stuff.
;Tracks all windows you want as part of your custom group.
global WindowGroupF7 := []
;Tracks the current window you're on.
global CurrentWinF7 := 1

;Holds the F6 and F7 Window IDs.
global F6andF7WinIDArray := []
;Tracks the current window for the previous array.
global CurrentWinF6AndF7ActBoth := 1

;*******************************APPLICATIONSWITCHER HELP GUI INITIALIZATION******************************
ApplSwitchGUI := "ApplicationSwitcher Help Box GUI"

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
GUI, ApplSwitchGUI:Font, norm s11.5
GUI, ApplSwitchGUI:Add, Text, x5 y40,Alt + a`t`tToggles between showing and hiding this help GUI.`nAlt + F6`t`tActivate windows in both the F6 and F7 array.`nCtrl + Alt + F1`tRun File Explorer and switch between wins.`nCtrl + Alt + F2`tCreate a new Private Firefox window.`nCtrl + Alt + F3`tCreate a new incognito Chrome window.`nCtrl + Alt + F6`tRemoves active window from the F6 group`nCtrl + Alt + F7`tRemoves active window from the F7 group`nCtrl + F1`tCreate a new normal Firefox window.`nCtrl + F2`tCreate a new normal Firefox window.`nCtrl + F3`tCreate a new normal Chrome window.`nCtrl + F4`tCreate a new normal Chrome window.`nCtrl + F6`tAdds active window to the F6 group`nCtrl + F7`tAdds active window to the F7 group`nCtrl + Shift + F6`tRemoves nonexistent wins from the F6 array.`nCtrl + Shift + F7`tRemoves nonexistent wins from the F7 array.`nF1`t`tRuns Firefox; switches to a FF win and between tabs.`nF12`t`tActivates MS Word windows, one at a time.`nF2`t`tRuns Firefox; switches between windows.`nF3`t`tRuns Chrome; switches to a Chr win and between tabs.`nF4`t`tRuns Chrome; switches between windows.`nF6`t`tNext window in the F6 group.`nF7`t`tNext window in the F7 group.`nF9`t`tThe Back button.`nShift + F1`tSame thing as F1, but reverse order.`nShift + F3`tSame thing as F3, but reverse order.`nShift + F6`tPrevious window in the F6 group.`nShift + F7`tPrevious window in the F7 group.

;Because I don't need the entire Main Script.ahk on my laptop, I made this script, with just the essentials.
;It also #Includes a few other scripts that are really really useful on my laptop.
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Misc. Main Script.ahk Scripts\Advanced Window Hider.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Misc. Main Script.ahk Scripts\ApplicationSwitcher.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Misc. Main Script.ahk Scripts\AutoCorrect.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Misc. Main Script.ahk Scripts\Run.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Screen Clipper Script\Screen Clipper.ahk

;Pushing Ctrl + Pause suspends all hotkeys, thus "pausing" the script.
;The reason it's ^CtrlBreak instead of ^Pause is because, according to the documentation: "While the Ctrl key is held down,
;the Pause key produces the key code of CtrlBreak and NumLock produces Pause, so use ^CtrlBreak in hotkeys instead of ^Pause."
!#p::Suspend, Toggle

;Pushing the Pause key suspends all hotkeys for the specified number in milliseconds (in this case, 2500).
#p::
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

;Label for ^CtrlBreak. The timer calls this label, suspends the hotkeys, sets the timer to off,
;and then goes back to the original hotkey that then unsuspends the script hotkeys.
setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
return

^#r::Reload

;Copy.
; CapsLock::
; Send, ^c
; return

; ;Paste.
; F11::
; Send, ^v
; return


;Because Ctrl + Backspace in MSWord is kinda quirky doe.
\::
Send, ^+{Left}
Send, {BackSpace}
return

;Bring up the Thesaurus in Word.
;~ #IfWinActive "ahk_exe WINWORD.EXE"
!PGUP::
Send, {AppsKey}
Sleep 160
Send, {Up 5}
Sleep 110
Send, {Right}
Sleep 300
Send, {Down} ;Get the first word selected.
return

;Bring up the Smart Lookup thing in Word.
!PGDN::
Send, {AppsKey}
Sleep 160
Send, {Up 6}
Sleep 110
Send, {Enter}
return

$^+v::
Send, ^v
return

;~ #If


#b::
MouseMove, 1432, 885, 0
Sleep 300
Send, {Click}
return

PrintScreen::
Send, {AppsKey}
return

!PrintScreen::
Send, ^{Esc}
return

;Disables these ANNOYING things.
^WheelDown::return
^WheelUp::return

;Log volume scaling stuff for NumpadAdd and NumpadEnter. IDK where I found this, nor do I understand/know how it works.
f(x) {
return exp(6.908*x)/1000.0
}
inv(y) {
return ln(1000.0*y)/6.908
}


!Up::
;~ SoundSet, +1
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return

!Down::
;~ SoundSet, -1
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return


:*:ai::AI
:*:aai::artificial intelligence

;Commented out because it's useless.
/*
;Shows the current and exact master volume.
!\::
SoundGet, systemMasterVolume
systemMasterVolume := Round(systemMasterVolume, 2)
MsgBox, 0, Master Volume, Master volume is %systemMasterVolume% percent., 0.39
return
*/

;Get the current master volume, and add the inputted value to the current master volume.
!\::
SoundGet, systemMasterVolume
InputBox, masterVolumeAlt , Add/subtract to the master volume, Input a number to add/subtract to the current master volume. Current volume: %systemMasterVolume%., , , , , , , , %systemMasterVolume%
if (ErrorLevel = 1) {
} else if (ErrorLevel = 0) {
	systemMasterVolume += masterVolumeAlt
    SoundSet, %systemMasterVolume%
}
return

;Gets the aforementioned master volume, displays it, and allows the user to input their own exact and custom volume.
^\::
SoundGet, systemMasterVolume
InputBox, systemMasterVolume , Input Custom Volume, Input a custom volume. Current volume: %systemMasterVolume%., , , , , , , , %systemMasterVolume%
if (ErrorLevel = 1) {
} else if (ErrorLevel = 0) {
SoundSet, %systemMasterVolume%
}
return

^Space::
WinSet, AlwaysOnTop, Toggle, A
return

;For English papers
;~ #Enter::
;~ SendInput, Title: `nMcFarland Link: `n`nLink: `n`nAccessed: `nAuthor: `nSource: `nPublisher: `nInfo:{Space}
;~ return


;For Firefox
^Tab::
Send, ^{PGDN}
return

^+Tab::
Send, ^{PGUP}
return


;Move mouse off screen...
Insert::
MouseGetPos, mousePosX, mousePosY
MouseMove, 1920, 540, 0
return

;... and back to where it was initially
!Insert::
MouseMove, mousePosX, mousePosY, 0
return

;For use with my little red mouse.
;Wheel left
XButton1::
Send, ^+{Tab}
return

;Wheel right
XButton2::
Send, ^{Tab}
return

!XButton1::
Send, !{Left}
return

!XButton2::
Send, !{Right}
return

;~ RButton & XButton1::
;~ Send, !{Left}
;~ return

;~ RButton & XButton2::
;~ Send, !{Right}
;~ return

;~ $RButton::
;~ Send, {RButton}
;~ return


;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab. This scan code is for the grave accent key.
sc029::
Send, !{Tab}
return

;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `. This scan code is for the grave accent key.
^sc029::
Send, ``
return

:*:itss::it's

CapsLock::return

;Keyboard shortcut originally from Chrome OS; minimizes the active window.
!-::
WinMinimize, A
return

;Maximizes the active window. It's supposed to be Alt + +, which gave me troubles before I realized the shortcut is technically !=.
!=::
WinMaximize, A
return

;Used for auto-clicking discussion questions in D2L Grid View, to mark them as "Read".
#r::
Send, {Click}
Sleep 150
MouseMove, 0, 64, 0, R
Sleep 150
return

#IfWinActive, ahk_exe Zoom.exe
$PrintScreen::
Send, #{PrintScreen}
return
#If

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

;Used for mass copying-and-pasting stuff from Kepe to MS To-Do.
;~ #t::
;~ Loop {
;~ Send, ^a
;~ Sleep 35
;~ Send, ^c
;~ Sleep 45
;~ Send, !{Tab}
;~ Sleep 250
;~ Send, ^v
;~ Sleep 200
;~ Send, {Enter}
;~ Sleep 200
;~ Send, !{Tab}
;~ Sleep 250
;~ Send, {Down 2}
;~ Sleep 260
;~ }
;~ return

;Test for seeing if I could possibly have my main PC functions on my laptop.
;~ ^!#F1::
;~ Send, ^!#{F13}
;~ return

;~ ^!#F13::
;~ MsgBox hi
;~ return