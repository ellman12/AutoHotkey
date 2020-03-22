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

/*
* This is the ultimate Google Calendar script.
* It allows the user to easily enter many events in a user-friendly GUI,
* and the script sends all the keystrokes in a Google Calendar Firefox window to create the events, one by one.
* Development started 3/21/2020 5:10 PM.
*/

;TODO:
;Big green FINISH button with a check mark symbol or something, and it either destroys the GUI, or grays out parts of it.
;Have a button/Hotkey to pause the script, and maybe tell the user what part it's on, and allow the user to restart that part?
;Default to working event checked?
;GroupBoxes? https://www.autohotkey.com/docs/commands/GuiControls.htm#GroupBox

;Arrays for tracking all of the user-inputted data.
startDateArray := []
endDateArray := []
startTimeArray := []
endTimeArray := []
eventAllDayBoolArray := []
eventDescriptionArray := []

;Index for the array "pages" (individual array indices).
;Starts at 1, to line up with the page numbers in the GUI.
currentArrayIndex := 1

;So AHK and the programmer don't get confused.
GCALGUI := "Google Calendar Script GUI"

;**************GUI INITIALIZATION**************
;************MISC GUI STUFF************
GUI, GCALGUI:+AlwaysOnTop
GUI, GCALGUI:Color, Silver

;************EVENT NAME STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x5 y5, Event Name

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, Edit, w425 x5 y40

;************ALL DAY EVENT STUFF************
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Checkbox, x5 y85 vAllDayCheckBoxVar, All day event?

;************WORKING THIS DAY STUFF************
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Checkbox, x5 y115 vScheduledToWorkVar, Working this day?

;************START DATE AND TIME STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x5 y160, Start Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x3 y195 w425 vStartDateAndTime, dddd MMMM d, yyyy h:mm:ss tt

;************END DATE AND TIME STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x5 y245, End Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x3 y280 w425 vEndDateAndTime, dddd MMMM d, yyyy h:mm:ss tt

;************DESCRIPTION STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x5 y325, Event Description (Optional)

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, Edit, r3 w425 x5 y360 +Wrap

;************NEXT/PREV PAGE STUFF************
;The & allows the user to push something like
; Alt + __ (the first letter), and it acts as a shortcut key.
GUI, GCALGUI:Add, Button, x333 y460 w100 gNextButtonLabel, &Next Page
GUI, GCALGUI:Add, Button, x230 y460 w100 gPrevButtonLabel, &Prev Page

;************FINISH BUTTON STUFF************
GUI, GCALGUI:Add, Button, x333 y505 w100 gFinishButtonLabel, &Finish

;After the GUI initialization stuff, show the GUI and define its height and width.
GUI, GCALGUI:Show, h580 w445, Google Calendar Easy Event Creation GUI
return ;End of auto-execute.

;************LABELS************
;Takes you to the next page (increments array index by 1).
NextButtonLabel:
MsgBox, hi
return

;Takes you to the previous page (decrements array index by 1).
PrevButtonLabel:
MsgBox hi 2
return

;For when the user is done entering data and is ready to
; start creating the events in Google Calendar.
FinishButtonLabel:
MsgBox hello
return

;TEMP
F10::
Send, GUI, GCALGUI:
Return
F11::
Send, ************
Return
^F11::
Send, ******
Return