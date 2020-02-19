#SingleInstance force
SendMode, Input

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
global CurrentWinF6AndF7 := 1

;Because I don't need the entire Main Script.ahk on my laptop, I made this script, with just the essentials.
;It also #Includes a few other scripts that are really really useful on my laptop.
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Advanced Window Hider.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\ApplicationSwitcher.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\AutoCorrect.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Run.AHK

^#r::
Reload
return

PrintScreen::
Send, {AppsKey}
return

!PrintScreen::
Send, ^{Esc}
return




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
SoundGet, master_volume
master_volume := Round(master_volume, 2)
MsgBox, 0, Master Volume, Master volume is %master_volume% percent., 0.39
return
*/

;Get the current master volume, and add the inputted value to the current master volume.
!\::
SoundGet, master_volume
InputBox, master_volume_alt , Add/subtract to the master volume, Input a number to add/subtract to the current master volume. Current volume: %master_volume%., , , , , , , , %master_volume%
if (ErrorLevel = 1) {
} else if (ErrorLevel = 0) {
	master_volume += master_volume_alt
    SoundSet, %master_volume%
}
return

;Gets the aforementioned master volume, displays it, and allows the user to input their own exact and custom volume.
^\::
SoundGet, master_volume
InputBox, master_volume , Input Custom Volume, Input a custom volume. Current volume: %master_volume%., , , , , , , , %master_volume%
if (ErrorLevel = 1) {
} else if (ErrorLevel = 0) {
SoundSet, %master_volume%
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

#p::
Suspend
return

:*:itss::it's

CapsLock::
return

;Keyboard shortcut originally from Chrome OS; minimizes the active window.
!-::
WinMinimize, A
return

;Maximizes the active window. It's supposed to be Alt + +, which gave me troubles before I realized the shortcut is technically !=.
!=::
WinMaximize, A
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
^!+t::
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
return ;End of ^!+t.

;Converts text to UPPER CASE, using a built-in AHK function.
^!+u::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;Make the title UPPER CASE, using a built-in AHK function.
  StringUpper, NewTitle, Clipboard

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!+u.

;Converts text to lower case, using a built-in AHK function.
^!+l::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;Make the title lower case, using a built-in AHK function.
  StringLower, NewTitle, Clipboard

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!+l.

;Converts text to Sentence case.
;I don't really know how it works; I found this on r/AHK, too.
^!+s::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;I don't have a clue how this works.
  StringLower, NewTitle, Clipboard
  NewTitle := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle
  
  Send, ^v ;Paste the new title.
return ;End of ^!+s.

;Converts text to First Letter Capitalization, using a built-in AHK function.
^!+f::

  Send, ^c
  Sleep 45
  
  StringUpper, NewTitle, Clipboard, T

  ;Store the Clipboard as the NewTitle.
  Clipboard := NewTitle

  Send, ^v ;Paste the new title.
return ;End of ^!+f.

;altCaseToggle is a toggle for if the alt case starts in lower case or not.
;A_LoopField is the single character at that point in the Parse Loop.
;0 = convert the char (A_LoopField) to lower...
;...1 = convert the char to UPPER.

;Convert text to aLt CaSe, with the first letter being lower case.
^!+a::

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

return ;End of ^!+a.

;Convert text to AlT cAsE, with the first letter being UPPER case.
^!+#a::

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

return ;End of ^!+a.



;Test for seeing if I could possibly have my main PC functions on my laptop.
;~ ^!#F1::
;~ Send, ^!#{F13}
;~ return

;~ ^!#F13::
;~ MsgBox hi
;~ return