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

;"Constant" values.
GCALGUI := "Google Calendar Script GUI"
GUI_WIDTH = 600
GUI_HEIGHT = 600

;**************GUI INITIALIZATION**************
;************MISC GUI STUFF************
GUI, GCALGUI:+AlwaysOnTop
GUI, GCALGUI:Color, Silver

;************EVENT NAME STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x5 y5, Event Name

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, Edit, h30 w550 x5 y45

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
GUI, GCALGUI:Add, DateTime, x3 y195 h30 w425 vStartDateAndTime, dddd MMMM d, yyyy h:mm:ss tt

;************END DATE AND TIME STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x5 y245, End Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x3 y280 h30 w425 vEndDateAndTime, dddd MMMM d, yyyy h:mm:ss tt

;After the GUI initialization stuff, show the GUI and defint its height and width.
GUI, GCALGUI:Show, w%GUI_WIDTH% h%GUI_HEIGHT% x1310 y430, Google Calendar Easy Event Creation GUI





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