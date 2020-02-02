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

;TODO First Letter, and AlT CaSe, like the Title Tool website has. Make sure the other 4 in this script work perfectly first.
;TODO Add button below text box and above DDL, where it acts as "Enter", so when I hit Enter when the text gets highlighted, it doesn't erase it.

;Script used for capitalizing and modifying titles (and other strings of text).
;I used to use this website: https://capitalizemytitle.com/
; but it takes way too long to load up every time I want to use it, so I got to work on this script.
;It works exactly like it, but faster and runs offline.
;TCT is shorthand for the script's name: Title Capitalization Tool.
;Inspiration and code for this script: https://autohotkey.com/board/topic/57888-title-case/ and https://autohotkey.com/board/topic/123994-capitalize-a-title/

;Creating and designing the GUI.
;Creating the Title Box.
GUI, Font, s14, Arial ;Font settings for the Text Box. Size 14, Arial font.
GUI, Add, Edit, r3 HScroll x15 y40 w500 h10 vTitleEditBoxText gTitleTextBoxLabel,The Title to Input ;This text box has 3 rows, allows scrolling horizontally, has a variable TitleEditBoxText, and a label TitleTextBoxLabel.

;Creating text telling the user to input the text.
GUI, Font, s15, Arial ;Font settings for everything else.
GUI, Add, Text, x16 y5, Enter Title to Modify:

;Making the GUI always on top, and giving it a Silver color.
GUI, +AlwaysOnTop
GUI, Color, Silver

;Creating GUI stuff for choosing the type of case (Title, UPPER, etc).
GUI, Add, Text, x15 y160, Choose a Title Type:
GUI, Add, DropDownList, x15 y190 vTitleChoice gTitleChoiceLabel, Title Case||UPPER CASE|lower case|Sentence case ;Creates a DropDownList (DDL), with Title Case as the default value.


;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showGUIToggle := 0

return ;End of Auto-execute.

;***************************LABELS***************************

;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, etc.
GuiClose:
  Gosub, TitleChoiceLabel
  GUI, Hide
return

;Label for getting the text the user inputted.
TitleTextBoxLabel:
  GUI, Submit, NoHide
  IsEnterPressed := GetKeyState("Enter")
  if(IsEnterPressed = true) {
    Gosub, TitleChoiceLabel
    GUI, Hide
  }
return

;This label is run when the user picks the case they want, and after they hit Enter (when they are done inputting data).
;Contains a Switch statement that modifys the text, depending on how the user wants it.
TitleChoiceLabel:

Switch TitleChoice {

  ;Converts text To Title Case.
  Case "Title Case": ;I don't understand, nor know, how this works at all.
    StringUpper, NewTitle, TitleEditBoxText, T ;Makes the title in AHK's "Title Case", which in reality just capitalizes the first letter of each word.
    head := SubStr(NewTitle, 1, 1) ;Manipulates and edits the String somehow.
    tail := SubStr(NewTitle, 2)
    ;Stores the NewTitle in the Clipboard.             This is the list of words to NOT capitalize.
    Clipboard := head RegExReplace(tail, "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")
    ;~ showGUIToggle := 0
  return
  
  ;Converts text to UPPER CASE, using a built-in AHK function.
  Case "UPPER CASE":
    StringUpper, NewTitle, TitleEditBoxText
    Clipboard := NewTitle
    ;~ showGUIToggle := 0
  return

  ;Converts text to lower case, using a built-in AHK function.
  Case "lower case":
    StringLower, NewTitle, TitleEditBoxText
    Clipboard := NewTitle
    ;~ showGUIToggle := 0
  return

  ;Converts text to Sentence case.
  Case "Sentence case":
    StringLower, NewTitle, TitleEditBoxText
    NewTitle := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")
    Clipboard := NewTitle
    ;~ showGUIToggle := 0
  return

} ;End of Switch statement.
return ;End of TitleChoiceLabel.

;Toggle between showing and hiding the TCT GUI.
#t::

showGUIToggle := !showGUIToggle

if (showGUIToggle = 1) {
  
  GUI, Show, w600 h400,Title Capitalization Tool (TCT)
  
} else if (showGUIToggle = 0) {
  GUI, Hide
  
}
return ;End of #t.