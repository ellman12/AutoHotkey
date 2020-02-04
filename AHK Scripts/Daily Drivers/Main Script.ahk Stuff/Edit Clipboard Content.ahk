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

;Script that shows a GUI containing the current clipboard contents, and allows the user to edit it.
;Useful once in a blue moon.

;Commented out on 2/03/2020 at 8:11 PM because: https://www.reddit.com/r/AutoHotkey/comments/eyfvk8/after_including_2_other_files_guis_become_blank/
;The GUI stuff needs to be created in the Main Script for some weird reason.

;The reason there is a 1: with each GUI command is because I #Include this script in "Main Script.ahk", and that helps keep the GUIs seperated.

; GUI, 1:Font, s14, Arial ;Font settings for the Text Box.
; GUI, 1:Add, Edit, HScroll wrap r9 x15 y40 w560 h200 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard% ;Creates an edit box for inputting the clipboard. AHK GUI Documentation explains the r, x, etc. stuff.

; Creating the GUI button for the Finish button: when the user is done editing the clipboard contents.
; GUI, 1:Add, Button, w100 gclipboardFinishButton,Finish

; GUI, 1:Font, s15, Arial ;Font settings for everything else.
; GUI, 1:Add, Text, x16 y5, Current Clipboard contents. Type what you want to change it to. ;Text instructing the user what to do.

; Making the GUI always on top, and giving it a Silver color.
; GUI, 1:+AlwaysOnTop
; GUI, 1:Color, Silver

; Toggle for showing or hiding the Clipboard GUI.
; If it's 1, show the GUI; if it's 0, hide it.
; Starts out as 0, so it only appers when the user wants it.
; showClipboardGUIToggle := 0

; return ;End of Auto-execute.


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