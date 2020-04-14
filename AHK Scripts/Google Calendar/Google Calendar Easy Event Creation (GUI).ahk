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
DetectHiddenWindows, On
#SingleInstance force
#Persistent
;OPTIMIZATIONS END

/*
* This is the ultimate Google Calendar script.
* It allows the user to easily enter many events in a user-friendly GUI,
* and the script sends all the keystrokes in a Google Calendar Firefox window to create the events, one by one.
* Development started 3/21/2020 5:10 PM.
*/

;HUGE thanks to u/Curpee89 of r/AutoHotkey for helping me with many problems I had while making this script.
;https://www.reddit.com/r/AutoHotkey/comments/fxu9gk/help_with_two_gui_problems/

;TODO:
;Big green FINISH button with a check mark symbol or something, and it either destroys the GUI, or grays out parts of it.
;Have a button/Hotkey to pause the script, and maybe tell the user what part it's on, and allow the user to restart that part?
;Default to working event checked?
;If an index is missing any value besides color and description, ignore it when actually creating the events.
;After clicking the UpDown, focus the event name thing.

;Arrays for tracking all of the user-inputted data.
eventNameArray := []
eventAllDayBoolArray := []
scheduledToWorkBoolArray := []
startDateArray := []
startTimeArray := []
endDateArray := []
endTimeArray := []
eventColorArray := []
eventDescriptionArray := []

;************CONSTANTS************
;So AHK and the programmer don't get confused.
GCALGUI := "Google Calendar Script GUI"

;The following are all the x and y values, control widths, etc.
PIXELS_BETWEEN_CONTROL_AND_NEXT_SECTION := 35
PIXELS_BETWEEN_SECTION_TITLE_AND_FIRST_CONTROL := 50

EVENT_NAME_TEXT_X := 5
EVENT_NAME_TEXT_Y := 5
EVENT_NAME_EDIT_X := 3
EVENT_NAME_EDIT_Y := 40
EVENT_NAME_EDIT_WIDTH := 425

ALL_DAY_EVENT_CHECKBOX_X := 5
ALL_DAY_EVENT_CHECKBOX_Y := 85

WORKING_THIS_DAY_X := 5
WORKING_THIS_DAY_Y := 115

START_DATE_TIME_TEXT_X := 5
START_DATE_TIME_TEXT_Y := 160
START_DATE_DATETIME_X := 3
START_DATE_DATETIME_Y := 195
START_TIME_DATETIME_X := 305
START_TIME_DATETIME_Y := START_DATE_DATETIME_Y

END_DATE_TIME_TEXT_X := 5
END_DATE_TIME_TEXT_Y := 245
END_DATE_DATETIME_X := 3
END_DATE_DATETIME_Y := 280

END_TIME_DATETIME_X := START_TIME_DATETIME_X
END_TIME_DATETIME_Y := END_DATE_DATETIME_Y
START_END_DATE_WIDTH := 300
START_END_TIME_WIDTH := 135

EVENT_COLOR_TEXT_X := 5
EVENT_COLOR_TEXT_Y := 325
EVENT_COLOR_COMBOBOX_X := 3
EVENT_COLOR_COMBOBOX_Y := 360
EVENT_COLOR_COMBOBOX_WIDTH := 127

DESCRIPTION_TEXT_X := 5
DESCRIPTION_TEXT_Y := 405
DESCRIPTION_EDIT_BOX_X := 5
DESCRIPTION_EDIT_BOX_Y := 440
DESCRIPTION_EDIT_BOX_ROW_NUM := 3
DESCRIPTION_EDIT_BOX_WIDTH := 425

NEXT_PREV_UPDOWN_WIDTH := 70
NEXT_PREV_UPDOWN_X := 130
NEXT_PREV_UPDOWN_Y := 542

CURRENT_PAGE_TEXT_X := 5
CURRENT_PAGE_TEXT_Y := NEXT_PREV_UPDOWN_Y + 1 ;This makes them line up just right.

FINISH_BUTTON_X := 340
FINISH_BUTTON_Y := 535
FINISH_BUTTON_WIDTH := 100

GCALGUI_HEIGHT := 580
GCALGUI_WIDTH := 445

;*********************GUI INITIALIZATION*********************
;************MISC GUI STUFF************
GUI, GCALGUI:+AlwaysOnTop
GUI, GCALGUI:Color, Silver

;************EVENT NAME STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%EVENT_NAME_TEXT_X% y%EVENT_NAME_TEXT_Y%, Event Name

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, Edit, w%EVENT_NAME_EDIT_WIDTH% x%EVENT_NAME_EDIT_X% y%EVENT_NAME_EDIT_Y% vEventNameVar

;************ALL DAY EVENT STUFF************
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Checkbox, x%ALL_DAY_EVENT_CHECKBOX_X% y%ALL_DAY_EVENT_CHECKBOX_Y% gAllDayCheckBoxLabel vAllDayCheckBoxVar, All day event?

;************WORKING THIS DAY STUFF************
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Checkbox, x%WORKING_THIS_DAY_X% y%WORKING_THIS_DAY_Y% gScheduledToWorkLabel vScheduledToWorkVar, Working this day?

;************START DATE STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%START_DATE_TIME_TEXT_X% y%START_DATE_TIME_TEXT_Y%, Start Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x%START_DATE_DATETIME_X% y%START_DATE_DATETIME_Y% w%START_END_DATE_WIDTH% vStartDateVar, dddd MMMM d, yyyy

;************START TIME STUFF************
GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x%START_TIME_DATETIME_X% y%START_TIME_DATETIME_Y% w%START_END_TIME_WIDTH% vStartTimeVar, h:mm tt

;************END DATE STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%END_DATE_TIME_TEXT_X% y%END_DATE_TIME_TEXT_Y%, End Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x%END_DATE_DATETIME_X% y%END_DATE_DATETIME_Y% w%START_END_DATE_WIDTH% vEndDateVar, dddd MMMM d, yyyy

;************END TIME STUFF************
GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x%END_TIME_DATETIME_X% y%END_TIME_DATETIME_Y% w%START_END_TIME_WIDTH% vEndTimeVar, h:mm tt

;************EVENT COLOR STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%EVENT_COLOR_TEXT_X% y%EVENT_COLOR_TEXT_Y%, Event Color

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DropDownList, x%EVENT_COLOR_COMBOBOX_X% y%EVENT_COLOR_COMBOBOX_Y% w%EVENT_COLOR_COMBOBOX_WIDTH% vEventColorChoice Sort, Red||Pink|Orange|Yellow|Light Green|Dark Green|Light Blue|Dark Blue|Lavender|Purple|Gray

;************DESCRIPTION STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%DESCRIPTION_TEXT_X% y%DESCRIPTION_TEXT_Y%, Event Description (Optional)

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, Edit, r%DESCRIPTION_EDIT_BOX_ROW_NUM% w%DESCRIPTION_EDIT_BOX_WIDTH% x%DESCRIPTION_EDIT_BOX_X% y%DESCRIPTION_EDIT_BOX_Y% vDescriptionEditBoxVar +Wrap

;************NEXT/PREV PAGE STUFF************
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Edit, x%NEXT_PREV_UPDOWN_X% y%NEXT_PREV_UPDOWN_Y% w%NEXT_PREV_UPDOWN_WIDTH%
GUI, GCALGUI:Add, UpDown, x%NEXT_PREV_UPDOWN_X% y%NEXT_PREV_UPDOWN_Y% w%NEXT_PREV_UPDOWN_WIDTH% gPrevNextPageLabel vcurrentGUIPage Range1-100, 1

;************CURRENT PAGE (INDEX) TEXT************
GUI, GCALGUI:Add, Text, x%CURRENT_PAGE_TEXT_X% y%CURRENT_PAGE_TEXT_Y%, Current Page: %NextPrevPageVar%

;************FINISH BUTTON STUFF************
GUI, GCALGUI:Font, s14 c008000
GUI, GCALGUI:Add, Button, x%FINISH_BUTTON_X% y%FINISH_BUTTON_Y% w%FINISH_BUTTON_WIDTH% gFinishButtonLabel, &Finish

;************SHOW THE GUI STUFF************
GUI, GCALGUI:Show, h%GCALGUI_HEIGHT% w%GCALGUI_WIDTH%, Google Calendar Easy Event Creation GUI

GUI, GCALGUI:Submit, NoHide
return ;End of auto-execute.

;*********************LABELS*********************
;When the GUI is closed (Red x button, etc).
GuiClose:
ExitApp
return

;When you toggle the All Day checkbox, this stuff is run.
AllDayCheckBoxLabel:
    ;Get the checkbox's value.
    GUI, GCALGUI:Submit, NoHide

    ;This prevents both checkboxes from being selected at the same time.
    ;This would obviously cause problems.
    if (AllDayCheckBoxVar = 1 && ScheduledToWorkVar = 1) {
        GuiControl, GCALGUI:,ScheduledToWorkVar, 0
    }

    ;If this is checked, disable the start/end time controls because modifying them doesn't make sense.
    if (AllDayCheckBoxVar = 1) {
        GuiControl, GCALGUI:Disable,StartTimeVar
        GuiControl, GCALGUI:Disable,EndTimeVar
    } else {
        GuiControl, GCALGUI:Enable,StartTimeVar
        GuiControl, GCALGUI:Enable,EndTimeVar
    }

return

;Label for the "Working this day?" CheckBox.
ScheduledToWorkLabel:
    ;Get the checkbox's value.
    GUI, GCALGUI:Submit, NoHide

    ;This prevents both checkboxes from being selected at the same time.
    ;This would obviously cause problems.
    if (ScheduledToWorkVar = 1 && AllDayCheckBoxVar = 1) {
        GuiControl, GCALGUI:,AllDayCheckBoxVar, 0
    }

return

;Label for the UpDown.
PrevNextPageLabel:
;If this variable doesn't exist/is null, initialize it to 1.
;Basically the array and page index variables are separate because the page index is changed
;by +/- 1 before this label stuff is run, thus stuff is stored in the desired array index + 1 = not what I want.
    if (currentArrayIndex = "")
        currentArrayIndex := 1
    GUI, GCALGUI:Submit, NoHide ;Store the control contents in their variables, and don't hide the GUI.
    setAllArrayValues()
    setGUIControlValues()
    currentArrayIndex := currentGUIPage
return

;When this is pressed, start creating the Google Calendar events.
FinishButtonLabel:

    ;Store stuff in the variables, and hide the GUI (since it's no longer needed).
    GUI, GCALGUI:Submit

return

;*********************FUNCTIONS*********************
;Retrieves the array contents at the current array index, and puts them in the controls.
setGUIControlValues() {
	global ;So the arrays can be seen in this function.

    ;Check if this index has already been defined.
    ;Basically, if the page doesn't have an event name, you can't do anything.
    ;In Google Calendar, every event needs an event name.
    if (eventNameArray[currentGUIPage] = "") {
        ;Initialize any of the objects that need default values here.
        eventAllDayBoolArray[currentGUIPage] := 0 ;defaults to unchecked
        scheduledToWorkBoolArray[currentGUIPage] := 0 ;defaults to checked
    }

    GuiControl,GCALGUI:,EventNameVar, % eventNameArray[currentGUIPage]
    GuiControl,GCALGUI:,AllDayCheckBoxVar, % eventAllDayBoolArray[currentGUIPage]
    GuiControl,GCALGUI:,ScheduledToWorkVar, % scheduledToWorkBoolArray[currentGUIPage]
    GuiControl,GCALGUI:,StartDateVar, % startDateArray[currentGUIPage]
    GuiControl,GCALGUI:,StartTimeVar, % startTimeArray[currentGUIPage]
    GuiControl,GCALGUI:,EndDateVar, % endDateArray[currentGUIPage]
    GuiControl,GCALGUI:,EndTimeVar, % endTimeArray[currentGUIPage]
    GuiControl,GCALGUI:ChooseString,EventColorChoice, % eventColorArray[currentGUIPage]
    GuiControl,GCALGUI:,DescriptionEditBoxVar, % eventDescriptionArray[currentGUIPage]
}

;At the current array index (the current page number), store the control's contents.
setAllArrayValues() {
	global ;So the arrays can be seen in this function.
    eventNameArray[currentArrayIndex] := EventNameVar
    eventAllDayBoolArray[currentArrayIndex] := AllDayCheckBoxVar
    scheduledToWorkBoolArray[currentArrayIndex] := ScheduledToWorkVar
    startDateArray[currentArrayIndex] := StartDateVar
    startTimeArray[currentArrayIndex] := StartTimeVar
    endDateArray[currentArrayIndex] := EndDateVar
    endTimeArray[currentArrayIndex] := EndTimeVar
    eventColorArray[currentArrayIndex] := EventColorChoice
    eventDescriptionArray[currentArrayIndex] := DescriptionEditBoxVar
}

;*********************ACTUALLY CREATING THE EVENTS*********************
;This is what actually takes the user data at each index and makes the GCal events.
createEvents() {

    MsgBox hi

    currentArrayIndex := 1

    ;This while loop is used for creating the events, and the right amount of them.
    ;While the current index for the arrays is less than the total number of events.
    ;When they equal, the script is done with its job, and terminates itself.
    while (currentArrayIndex < EventDataMatrix.MaxIndex()) {
        
        ;Starts creating the event
        ; Send, c
        ; Sleep, 1000

        if ()









        currentArrayIndex++ ;Move on to the next index.
    }

}