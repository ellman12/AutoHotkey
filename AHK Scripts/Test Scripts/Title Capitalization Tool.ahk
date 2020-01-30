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

;GUI tutorial: https://youtu.be/TFWDZ4FAETg?list=PLPI5C2_hIGGx1hqSvNzCLawaDvGF0k9-Y&t=1307

;Create the GUI
;  GUI, Font, s15, Veranda,
;  GUI, Add, Text, x27 y27,Enter title:
;  GUI, +AlwaysOnTop
;  GUI, Color, Silver
; ~ GUI, Add, Edit

;  GUI, Show, w400 h400 ,Title Capitalization Tool (TCT)
;  return


;GUI Layout
;--------------
;-------------------------



GUI, Font, s14, Arial ;Font settings for the Text Box.
GUI, Add, Edit, r3 HScroll x15 y40 w500 h10 vtitleBox gtitleBoxLabel,The Title to Input ;Create the Text Box, with 3 rows, located at x15, y40, width of 375 and height of 50. Has a variable named titleBox.
GUI, Color, Silver

GUI, Font, s15, Arial ;Font settings for everything else.
GUI, Add, Text, x16 y5, Enter Title to Modify:

;TODO: FIGURE OUT RADIO BUTTONS.

GUI, +AlwaysOnTop
GUI, Color, Silver
GUI, Show, w600 h400,Title Capitalization Tool (TCT)
return

;Labels
;---------------------
;------------------------------

;Activates when the GUI is closed. E.g., pressing the red x button,
; manually exiting the script, etc.
;~ GuiClose:
;~ ExitApp
;~ return

titleBoxLabel:
GUI, Submit, NoHide
IsEnterPressed := GetKeyState("Enter")
if(IsEnterPressed = true)
MsgBox, %titleBox%
return




;https://autohotkey.com/board/topic/123994-capitalize-a-title/
;https://autohotkey.com/board/topic/57888-title-case/

;Script used for capitalizing and modifying titles (and other strings of text).
;I really like this website, 
; but it takes way too long to load up every time I want to use it.
;So, I got to work on this script.
;It works exactly like it, but faster and runs offline.





^!+A::                ; Convert TEXT to UPPER
 Send, ^x
 sleep, 150
 StringUpper Clipboard, Clipboard
 Send %Clipboard%
RETURN

^!+S::            ; Sentence case
          ; but the ! disapears; have not foud solution for that
  Send, ^x
  sleep, 150
  StringLower, Clipboard, Clipboard
  Clipboard := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")
  Send %Clipboard%
RETURN

^!+D::                ; Convert text to lower
 Send, ^x
 sleep, 150
 StringLower Clipboard, Clipboard
 Send %Clipboard%
RETURN

^!+f::                ; Convert Text To Title Capitalization
Send, ^c
Sleep 55
StringUpper str, Clipboard, T
head := SubStr( str, 1 , 1 )
tail := SubStr( str, 2 )
Clipboard := head RegExReplace( tail , "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")
Send ^v
RETURN