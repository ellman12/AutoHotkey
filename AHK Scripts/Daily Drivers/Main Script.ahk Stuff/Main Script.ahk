;OPTIMIZATIONS START
#NoEnv
; #MaxHotkeysPerInterval 99000000
; #HotkeyInterval 99000000
; #KeyHistory 0
; ListLines Off
; Process, Priority, , A
; SetBatchLines, -1
; SetKeyDelay, -1, -1
; SetMouseDelay, -1
; SetDefaultMouseSpeed, 0
; SetWinDelay, -1
; SetControlDelay, -1
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

Menu, Tray, Icon, shell32.dll, 174 ;Changes the icon to a keyboard; perfect for the Main Script file. IDK where I found this...

;******************************************AUTO-EXECUTE**************************************************
;*******************************EDIT CLIPBOARD CONTENT INITIALIZATION******************************
;Check the Reddit post in the script for an explanation as to why this code needs to be in Main.
GUI, 1:Font, s14, Arial ;Font settings for the Text Box.
GUI, 1:Add, Edit, HScroll wrap r9 x15 y40 w560 h200 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard% ;Creates an edit box for inputting the clipboard. AHK GUI Documentation explains the r, x, etc. stuff.

;Creating the GUI button for the Finish button: when the user is done editing the clipboard contents.
GUI, 1:Add, Button, w100 gclipboardFinishButton,Finish

GUI, 1:Font, s15, Arial ;Font settings for everything else.
GUI, 1:Add, Text, x16 y5, Current Clipboard contents. Type what you want to change it to. ;Text instructing the user what to do.

;Making the GUI always on top, and giving it a Silver color.
GUI, 1:+AlwaysOnTop
GUI, 1:Color, Silver

;Toggle for showing or hiding the Clipboard GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showClipboardGUIToggle := 0

;*****************************TITLE CAPITALIZATION TOOL INITIALIZATION****************************
;Check the Reddit post in the script for an explanation as to why this code needs to be in Main.
;Creating and designing the GUI.
;Creating the Title Box.
GUI, 2:Font, s14, Arial ;Font settings for the Text Box. Size 14, Arial font.
GUI, 2:Add, Edit, r3 HScroll x15 y40 w500 h10 vTitleEditBoxText gTitleTextBoxLabel,The Title to Input ;This text box has 3 rows, allows scrolling horizontally, has a variable TitleEditBoxText, and a label TitleTextBoxLabel.

;Creating text telling the user to input the text.
GUI, 2:Font, s15, Arial ;Font settings.
GUI, 2:Add, Text, x16 y5, Enter Title to Modify:

;Making the GUI always on top, and giving it a Silver color.
GUI, 2:+AlwaysOnTop
GUI, 2:Color, Silver

;Adding the Finish button below the text box and above the DDL.
;The reason it's above the DDL is because 99.99% of the time, I will be using Title Case, which is obviously the default value.
;That just makes it easier to do because I have to do less keystrokes.
GUI, 2:Add, Button, x15 y150 w80 h40 gTitleFinishButton,Finish

;GUI stuff for text above DDL.
GUI, 2:Font, s15 Arial ;Font settings.
GUI, 2:Add, Text, x15 y200, Choose a Title Type:

;Creating GUI stuff for choosing the type of case (Title, UPPER, etc).
GUI, 2:Font, S14 Arial
GUI, 2:Add, DropDownList, x15 y230 vTitleChoice gTitleChoiceLabel, Title Case||UPPER CASE|lower case|Sentence case|First Letter ;Creates a DropDownList (DDL), with Title Case as the default value.

;Toggle for showing or hiding the title GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showTitleGUIToggle := 0

;****************************************MISC VARIABLES AND STUFF*********************************
;Variables for F6 group stuff.
;Tracks all windows you want as part of your custom group.
Global WindowGroupF6 := []
;Tracks the current window you're on.
Global CurrentWinF6 := 1

;Variables for F7 group stuff.
;Tracks all windows you want as part of your custom group.
Global WindowGroupF7 := []
;Tracks the current window you're on.
Global CurrentWinF7 := 1

;Used for the step values for NumPad2 and NumPad8 in NumPad Media Control.
global Num2And8Step := 3

;The stuff in this loop needs to be running constantly.
Loop {


;Constantly checking to see what profile you should be in.
global current_profile := AutoSelectProfiles()

;The script checks if NumLock is enabled or not, so it can do different things depending on if it is enabled or not. The variable is either 1 or 0.
global NumLockToggled := GetKeyState("NumLock", "T")

;The script checks if ScrollLock is enabled or not, so it can do different things depending on if it is enabled or not. The variable is either 1 or 0.
global ScrollLockToggled := GetKeyState("ScrollLock", "T")

;This works so much better than having a bunch of ugly NumLockToggled = 1 and ScrollLockToggled = 0 things everywhere.
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

;******************************************END OF AUTO-EXECUTE*******************************************
return

;Linking other scripts together.
;Similar to but not exactly like you would in something like Java.
;The variable %A_ScriptDir% is the full path of the directory where the script is located.

;~ #Include, %A_ScriptDir%\Advanced Window Hider.ahk
#Include, %A_ScriptDir%\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\AutoCapitalize.ahk
;~ #Include, %A_ScriptDir%\AutoCorrect.ahk
#Include, %A_ScriptDir%\Browser.ahk
#Include, %A_ScriptDir%\Chromebook Typing.ahk
#Include, %A_ScriptDir%\Default.ahk
; #Include, %A_ScriptDir%\Edit Clipboard Content.ahk
#Include, %A_ScriptDir%\Google Docs.ahk
#Include, %A_ScriptDir%\Google Sheets.ahk
#Include, %A_ScriptDir%\Microsoft Word.ahk
#Include, %A_ScriptDir%\NumPad Media Control.ahk
#Include, %A_ScriptDir%\OSRS (RuneLite).ahk
#Include, %A_ScriptDir%\Profile Switcher.ahk
#Include, %A_ScriptDir%\Run.ahk
#Include, %A_ScriptDir%\SciTE4AutoHotkey Programming.ahk
; #Include, %A_ScriptDir%\Title Capitalization Tool.ahk

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
^F2::
Send, ^c
return

;M2 on K95 RGB  cuts to the clipboard.
#F2::
Send ^x
return

;M3 on K95 RGB pastes to the clipboard.
!F2::
Send ^v
return

;Shows you what profile you're currently in. Can also be used for debugging.
^#BackSpace::
MsgBox, 0, Current Profile and NumPad Mode, Current profile: %current_profile%`n`nNumPadMode: %NumPadMode%
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

;Keyboard shortcut originally from Chrome OS; minimizes the active window.
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

  Send, ^v ;Paste the new title.
return ;End of ^!+u.

;Converts text to lower case, using a built-in AHK function.
^!+l::
  ;Copy text, and wait a bit so it can actually process that.
  Send, ^c
  Sleep 45

  ;Make the title lower case, using a built-in AHK function.
  StringLower, NewTitle, Clipboard

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
  
  Send, ^v ;Paste the new title.
return ;End of ^!+s.

;Converts text to First Letter Capitalization, using a built-in AHK function.
^!+f::
  StringUpper, NewTitle, Clipboard, T
  
  Send, ^v ;Paste the new title.
return ;End of ^!+f.

  Case "First Letter":
    StringUpper, NewTitle, TitleEditBoxText, T
    Clipboard := NewTitle
    GuiControl,, 2:TitleEditBoxText,The Title to Input
    GuiControl, 2:Focus, TitleEditBoxText
  return
  

  ;*******************************HOTKEYS FOR EDITING CLIPBOARD CONTENT*****************************


;----------------------------------------------------------------------
;*****************************EXPERIMENTAL*****************************
;----------------------------------------------------------------------

;~ ;If Scroll Lock is on, Up and Down send Up and Down 10 times per each keystroke.
;~ #If ScrollLockToggled = 1
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
;Anything in this section is temporary, and was added in to perform a simple and quick task.
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

F5::
Send, ^+{F10}
return

:*:java::Java
#If


;-------------------------------------------------------------------------------------------
;*****************************STUFF FOR EDIT CLIPBOARD CONTENT******************************
;-------------------------------------------------------------------------------------------
;Toggles between showing and hiding the Clipboard GUI.
#c::
GUI, 1:Show, w600 h400,Clipboard Edit
return


;***************************LABELS***************************
;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, Alt + F4, etc.
1GuiClose:
    GUI, 1:Submit, NoHide
    GuiControl, 1:Focus, clipboardBoxText
    GUI, 1:Hide
    showClipboardGUIToggle := !showClipboardGUIToggle
return

;Label for the text box.
clipboardTextBoxLabel:
    GUI, 1:Submit, NoHide
    Clipboard := clipboardBoxText
return

;Label for when the user presses the Done button.
;This button is exactly like the Finish button in TCT, where it stores the text in the Clipboard variable.
clipboardFinishButton:
    Clipboard := clipboardBoxText
    GUI, 1:Hide
    GuiControl, 1:Focus, clipboardBoxText
return


;-------------------------------------------------------------------------------------------
;******************************STUFF FOR TITLE CAPITALIZATION TOOL**************************
;-------------------------------------------------------------------------------------------
;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, Alt + F4, etc.
2GuiClose:
  GUI, 2:Submit, NoHide
  GUI, 2:Hide
  showTitleGUIToggle := !showTitleGUIToggle
return

;Label used for when the user has finished inputting the title and the type of case.
;Activates when the "Finish" button is pressed.
TitleFinishButton:
  GUI, 2:Hide
  Gosub, TitleChoiceLabel
  showTitleGUIToggle := !showTitleGUIToggle
return

;Label for getting the text the user inputted.
;The user can either hit the Enter key on the keyboard—which unfortunately causes there to be an Enter in the final String—or they can Tab over to the Finish button (recommended).
TitleTextBoxLabel:
  GUI, 2:Submit, NoHide ;NoHide prevents the GUI window from being hidden, even after pressing 1 single character key.
  IsEnterPressed := GetKeyState("Enter")
  if(IsEnterPressed = true) {
    Gosub, TitleChoiceLabel
    GUI, 2:Hide
  }
return

;This label is run when the user picks the case they want, and after they hit Enter (when they are done inputting data).
;Contains a Switch statement that modifys the text, depending on how the user wants it.
TitleChoiceLabel:

Switch TitleChoice {

  ;Converts text To Title Case.
  Case "Title Case": ;I don't understand, nor know, how this works at all.
    StringUpper, NewTitle, TitleEditBoxText, T ;Makes the title in AHK's "Title Case", which in reality just capitalizes the first letter of each word. Not sure why this line needs to be here.
    head := SubStr(NewTitle, 1, 1) ;Manipulates and edits the String somehow.
    tail := SubStr(NewTitle, 2)
    ;Stores the NewTitle in the Clipboard.             This is the list of words to NOT capitalize.
    Clipboard := head RegExReplace(tail, "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")
    GuiControl,, 2:TitleEditBoxText,The Title to Input ;Resets the variable containing the inputted title, so that the next time you go to open the GUI, the text isn't the previous text.
    GuiControl, 2:Focus, TitleEditBoxText ;Puts that GUI element in focus, so it's ready to edit the next time the user wants to use it.
  return
  
  ;Converts text to UPPER CASE, using a built-in AHK function.
  Case "UPPER CASE":
    Sleep, 800
    StringUpper, NewTitle, TitleEditBoxText
    Sleep, 800
    Clipboard := NewTitle
    GuiControl,, 2:TitleEditBoxText,The Title to Input
    GuiControl, 2:Focus, TitleEditBoxText
  return

  ;Converts text to lower case, using a built-in AHK function.
  Case "lower case":
    StringLower, NewTitle, TitleEditBoxText
    Clipboard := NewTitle
    GuiControl,, 2:TitleEditBoxText,The Title to Input
    GuiControl, 2:Focus, TitleEditBoxText
  return

  ;Converts text to Sentence case.
  Case "Sentence case":
    StringLower, NewTitle, TitleEditBoxText
    NewTitle := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")
    Clipboard := NewTitle
    GuiControl,, 2:TitleEditBoxText,The Title to Input
    GuiControl, 2:Focus, TitleEditBoxText
  return

  ;Converts text to First Letter.
  Case "First Letter":
    StringUpper, NewTitle, TitleEditBoxText, T
    Clipboard := NewTitle
    GuiControl,, 2:TitleEditBoxText,The Title to Input
    GuiControl, 2:Focus, TitleEditBoxText
  return

} ;End of Switch statement.
return ;End of TitleChoiceLabel.

;Toggle between showing and hiding the TCT GUI.
#t::

showTitleGUIToggle := !showTitleGUIToggle

if (showTitleGUIToggle = 1) {
  
  GUI, 2:Show, w600 h400,Title Capitalization Tool (TCT)
  
} else if (showTitleGUIToggle = 0) {
  GUI, 2:Hide
  
}
return ;End of #t.
