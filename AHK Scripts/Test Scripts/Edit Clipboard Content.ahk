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
GUI, Add, Edit, r3 HScroll x15 y40 w375 h50 vclipboardBoxText gclipboardBoxLabel,%Clipboard% ;Create the Text Box, with 3 rows, located at x15, y40, width of 375 and height of 50. Has a variable named clipboardBoxText.
GUI, Color, Silver

GUI, Font, s15, Arial ;Font settings for everything else.
GUI, Add, Text, x16 y5, Current Clipboard contents. Type what you want to change it to.

GUI, +AlwaysOnTop
GUI, Color, Silver


;Open GUI to edit Clipboard.
#c::
GUI, Show, w600 h400,Clipboard Edit
return


;GUI LABELS
clipboardBoxLabel:
GUI, Submit, NoHide

isEnterPressed := GetKeyState("Enter")
    if(isEnterPressed = true) {
    Clipboard := clipboardBoxText
    Reload
    }
return

GuiClose:
Reload
return