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

;Script used for capitalizing and modifying titles (and other strings of text).
;I used to use this website: https://capitalizemytitle.com/
; but it takes way too long to load up every time I want to use it.
;So, I got to work on this script.
;It works exactly like it, but faster and runs offline.
;TCT is shorthand for the script's name: Title Capitalization Tool.

;Creating and designing the GUI.
;Creating the Title Box.
GUI, Font, s14, Arial ;Font settings for the Text Box. Size 14, Arial font.
GUI, Add, Edit, r3 HScroll x15 y40 w500 h10 vTitleBoxEdit gTitleTextBoxLabel,The Title to Input ;This text box has 3 rows, allows scrolling horizontally, has a variable TitleBoxEdit, and a label TitleTextBoxLabel.

;Creating text telling the user to input the text.
GUI, Font, s15, Arial ;Font settings for everything else.
GUI, Add, Text, x16 y5, Enter Title to Modify:

;Making the GUI always on top, and giving it a Silver color.
GUI, +AlwaysOnTop
GUI, Color, Silver

;Creating GUI stuff for the type of case (Title, UPPER, etc).
GUI, Add, Text, x15 y160, Choose a Title Type:
GUI, Add, DropDownList, x15 y190 vTitleChoice gTitleChoiceLabel, Title Case||UPPER CASE|lower case|Sentence case


;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showGUIToggle := 0

return ;End of Auto-execute.

;***************************LABELS***************************

;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, etc.
GuiClose:
GUI, Hide
return

TitleTextBoxLabel:
  GUI, Submit, NoHide
  IsEnterPressed := GetKeyState("Enter")
  if(IsEnterPressed = true)
  ; MsgBox, % TitleChoice
return

;Label for when the user picks the case they want.
TitleChoiceLabel:

Switch TitleChoice {

  Case "Title Case":
    MsgBox 1
    return
  
  Case "UPPER CASE":
    MsgBox 2
    return

  Case "lower case":
    MsgBox 3
    return

  Case "Sentence case":
    MsgBox 4
    return

} ;End of Switch statement.

;Toggle between showing and hiding the TCT GUI.
#t::

showGUIToggle := !showGUIToggle

if (showGUIToggle = 1) {
  
  GUI, Show, w600 h400,Title Capitalization Tool (TCT)
  
} else if (showGUIToggle = 0) {
  GUI, Hide
  
}
return ;End of #t.







;make hotkeys labels, and if/switch calls them.


; ^!+A::
;Convert text to UPPER CASE.
textToUpper:
 Send, ^x
 sleep, 150
 StringUpper Clipboard, Clipboard
 Send %Clipboard%
return


; but the ! disapears; have not foud solution for that
;Sentence case
; ^!+S::
textToSentenceCase:
  Send, ^x
  sleep, 150
  StringLower, Clipboard, Clipboard
  Clipboard := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")
  Send %Clipboard%
return

; ^!+D::
;Convert text to lower case.
textToLowerCase:
 Send, ^x
 sleep, 150
 StringLower Clipboard, Clipboard
 Send %Clipboard%
return

; ^!+f::
;Convert Text To Title Case.
textToTitleCase:
Send, ^c
Sleep 55
StringUpper str, Clipboard, T
head := SubStr( str, 1 , 1 )
tail := SubStr( str, 2 )
Clipboard := head RegExReplace( tail , "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")
Send ^v
return