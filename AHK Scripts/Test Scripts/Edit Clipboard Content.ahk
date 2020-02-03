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

;Script that shows a GUI containing the current clipboard contents, and allows me to edit it.
;idk if this will actually be useful or not.

GUI, Font, s14, Arial ;Font settings for the Text Box.
GUI, Add, Edit, HScroll wrap r9 x15 y40 w560 h200 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard%

;Creating the GUI button for the Finish button: when the user is done editing the clipboard contents.
GUI, Add, Button, w100 gclipboardFinishButton,Finish

GUI, Font, s15, Arial ;Font settings for everything else.
GUI, Add, Text, x16 y5, Current Clipboard contents. Type what you want to change it to. ;Text instructing the user what to do.

;Making the GUI always on top, and giving it a Silver color.
GUI, +AlwaysOnTop
GUI, Color, Silver

;Toggle for showing or hiding the Clipboard GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showClipboardGUIToggle := 0

return ;End of Auto-execute.

;Opens (shows) GUI to edit Clipboard.
#c::
GUI, Show, w600 h400,Clipboard Edit
return


;***************************LABELS***************************
;Activates when the GUI is closed. E.g., pressing the red x button, manually exiting the script, Alt + F4, etc.
GuiClose:
    GUI, Submit, NoHide
    GuiControl, Focus, clipboardBoxText
    GUI, Hide
    showClipboardGUIToggle := !showClipboardGUIToggle
return

;Label for the text box.
clipboardTextBoxLabel:
    GUI, Submit, NoHide
    Clipboard := clipboardBoxText
return

;Label for when the user presses the Done button.
;This button is exactly like the Finish button in TCT, where it stores the text in the Clipboard variable.
clipboardFinishButton:
    Clipboard := clipboardBoxText
    Gui, Hide
    GuiControl, Focus, clipboardBoxText
return