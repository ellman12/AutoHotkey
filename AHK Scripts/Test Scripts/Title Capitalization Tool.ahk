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

;GUI tutorial: https://www.youtube.com/watch?v=7GYGXNSpUds&list=PLPI5C2_hIGGx1hqSvNzCLawaDvGF0k9-Y&index=4

;Create the GUI
;~ GUI, Font, s15, Veranda,
;~ GUI, Add, Text, x27 y27,Enter title:
;~ GUI, +AlwaysOnTop
;~ GUI, Color, Silver
;~ GUI, Add, Edit

;~ GUI, Show, w400 h400 ,Title Capitalization Tool (TCT)
;~ return


;GUI Layout
;--------------
;-------------------------

GUI, Font, s14, Arial ;Font settings for the Text Box.
GUI, Add, Edit, r3 HScroll x15 y200 w375 h50,The Title to Input ;Create the Text Box.

GUI, Font, s15, Arial ;Font settings for everything else.
;~ GUI, Add, Text, x27 y27, Enter Title to Modify:
GUI, Add, Text, x27 y27, Push this chonky button lol

GUI, Add, Button, x30 y100 w300 h75 gButton, Press Me!

GUI, +AlwaysOnTop
GUI, Color, Silver
GUI, Show, x1300 y50 w600 h400,Title Capitalization Tool (TCT)
return

;Labels
;---------------------
;------------------------------

;Activates when the GUI is closed. E.g., pressing the red x button,
; manually exiting the script, etc.
GuiClose:
ExitApp
return

;Button I created.
Button:
a := 5
b := 8
c := add(a,b)
MsgBox, a + b = %c%
return

;Functions
;---------------
;----------------------
add(x,y) {
return x + y
}



;https://autohotkey.com/board/topic/123994-capitalize-a-title/
;https://autohotkey.com/board/topic/57888-title-case/

;Script used for capitalizing and modifying titles (and other strings of text).
;I really like this website, 
; but it takes way too long to load up every time I want to use it.
;So, I got to work on this script.
;It works exactly like it, but faster and runs offline.

/*
^u::                                                                 ; Convert text to upper
 StringUpper Clipboard, Clipboard
 Send %Clipboard%
RETURN

^l::                                                                 ; Convert text to lower
 StringLower Clipboard, Clipboard
 Send %Clipboard%
RETURN

+^k::                                                                ; Convert text to capitalized
 StringUpper Clipboard, Clipboard, T
 Send %Clipboard%
RETURN

^k::                                                                 ; Convert text to inverted
 Lab_Invert_Char_Out:= ""
 Loop % Strlen(Clipboard) {
    Lab_Invert_Char:= Substr(Clipboard, A_Index, 1)
    if Lab_Invert_Char is upper
       Lab_Invert_Char_Out:= Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) + 32)
    else if Lab_Invert_Char is lower
       Lab_Invert_Char_Out:= Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) - 32)
    else
       Lab_Invert_Char_Out:= Lab_Invert_Char_Out Lab_Invert_Char
 }
 Send %Lab_Invert_Char_Out%
 
#w::
Send ^c
ClipWait ; Wait for the clipboard to contain text.
SC := ChangeCase(Clipboard)

ChangeCase(str) {
    PrepList =
    ( Join
    \b(a|aboard|about|above|absent|across|after|against|along|alongside|amid|amidst|among|amongst|an|and|around|as|as|aslant|astride|at|athwart|atop|barring|be|before|behind|below|beneath|beside|besides|between|beyond|but|but|by|by|despite|down|during|except|failing|following|for|for|from|in|in|inside|into|like|mid|minus|near|next|nor|notwithstanding|of|of|off|on|on|onto|opposite|or|out|outside|over|past|per|plus|regarding|round|save|since|so|than|the|through|throughout|till|times|to|to|toward|towards|under|underneath|unlike|until|up|upon|via|vs.|when|with|within|without|worth|yet)\b
    )

    Return RegExReplace(RegExReplace(str,"\w+","$T0"),"i)(" PrepList ")","$L1")
}

Send %SC%
return
*/
