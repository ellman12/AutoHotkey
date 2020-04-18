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
; #Persistent
;OPTIMIZATIONS END

/*
* This is the ultimate Google Calendar script.
* It allows the user to easily enter many events in a user-friendly GUI,
* and the script sends all the keystrokes in a Google Calendar Firefox window to create the events, one by one.
* Development started 3/21/2020 5:10 PM.
* One important thing to note is that in Google Calendar, you can have it create premade notifications by default.
* This saves a lot of time and makes life easier for both the programmer and the user.
*
* HUGE thanks to u/Curpee89 of r/AutoHotkey for helping me with many problems I had while making this script.
* https://www.reddit.com/r/AutoHotkey/comments/fxu9gk/help_with_two_gui_problems/
*/

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

currentArrayIndex := 1

GUIActive := "true"

;************CONSTANTS************
;So AHK and the programmer don't get confused.
GCALGUI := "Google Calendar Script GUI"

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

SAME_DAY_EVENT_X := 205
SAME_DAY_EVENT_Y := ALL_DAY_EVENT_CHECKBOX_Y

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

;************SAME DAY EVENT STUFF************
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Checkbox, x%SAME_DAY_EVENT_X% y%SAME_DAY_EVENT_Y% vSameDayEventVar Checked, Same day event?

;************START DATE STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%START_DATE_TIME_TEXT_X% y%START_DATE_TIME_TEXT_Y%, Start Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x%START_DATE_DATETIME_X% y%START_DATE_DATETIME_Y% w%START_END_DATE_WIDTH% vStartDateVar, dddd MMMM d, yyyy

;************START TIME STUFF************
GUI, GCALGUI:Font, norm s14                                                                                         ;This starts it at 3:00 PM.
GUI, GCALGUI:Add, DateTime, x%START_TIME_DATETIME_X% y%START_TIME_DATETIME_Y% w%START_END_TIME_WIDTH% vStartTimeVar Choose20020418150000, h:mm tt

;************END DATE STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%END_DATE_TIME_TEXT_X% y%END_DATE_TIME_TEXT_Y%, End Date and Time

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DateTime, x%END_DATE_DATETIME_X% y%END_DATE_DATETIME_Y% w%START_END_DATE_WIDTH% vEndDateVar, dddd MMMM d, yyyy

;************END TIME STUFF************
GUI, GCALGUI:Font, norm s14                                                                                   ;This starts it at 4:00 PM.
GUI, GCALGUI:Add, DateTime, x%END_TIME_DATETIME_X% y%END_TIME_DATETIME_Y% w%START_END_TIME_WIDTH% vEndTimeVar Choose20020418160000, h:mm tt

;************EVENT COLOR STUFF************
GUI, GCALGUI:Font, underline s18
GUI, GCALGUI:Add, Text, x%EVENT_COLOR_TEXT_X% y%EVENT_COLOR_TEXT_Y%, Event Color

GUI, GCALGUI:Font, norm s14
GUI, GCALGUI:Add, DropDownList, x%EVENT_COLOR_COMBOBOX_X% y%EVENT_COLOR_COMBOBOX_Y% w%EVENT_COLOR_COMBOBOX_WIDTH% gColorDDL vEventColorChoice Sort, Red||Pink|Orange|Yellow|Light Green|Dark Green|Light Blue|Dark Blue|Lavender|Purple|Gray

;************COLOR PREVIEW STUFF************
GUI, GCALGUI:Add,Progress, x230 y339 w70 h62 BackgroundBlack cRed +Smooth vColorPreviewVal, 100

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
GUI, GCALGUI:Font, s14
GUI, GCALGUI:Add, Button, x%FINISH_BUTTON_X% y%FINISH_BUTTON_Y% w%FINISH_BUTTON_WIDTH% gFinishButtonLabel, &Finish

;************SHOW THE GUI************
GUI, GCALGUI:Show, h%GCALGUI_HEIGHT% w%GCALGUI_WIDTH%, Google Calendar Easy Event Creation GUI

;This stuff is always running while the GUI is in use. The Finish button disables it.
while (GUIActive = "true") {
    GUI, GCALGUI:Submit, NoHide

    ;The same day checkbox makes life SO much easier. It even starts out checked!
    if (ScheduledToWorkVar = 1 or SameDayEventVar = 1) {
        GuiControl, GCALGUI:,EndDateVar, %StartDateVar%
    }

    ;This sleep statement DRASTICALLY helps reduce the power and CPU usage of the script.
	Sleep 50
}
return ;End of auto-execute.

;*********************LABELS*********************
;When you toggle the All Day checkbox, this stuff is run.
AllDayCheckBoxLabel:
    ;Get the checkbox's value.
    GUI, GCALGUI:Submit, NoHide

    ;This prevents both checkboxes from being selected at the same time.
    ;This would obviously cause problems.
    if (AllDayCheckBoxVar = 1 && ScheduledToWorkVar = 1) {
        GuiControl, GCALGUI:,ScheduledToWorkVar, 0
    }

    ;If this is checked, disable the start/end time controls, because modifying them doesn't make sense.
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

    ;It also disables the Event Name and End Date controls, since there's no need to type a name/modify the end date.
    if (ScheduledToWorkVar = 1) {
        GuiControl, GCALGUI:Disable,EventNameVar
        GuiControl, GCALGUI:,EventNameVar, N/A
        GuiControl, GCALGUI:Disable,EndDateVar
    } else {
        GuiControl, GCALGUI:Enable,EventNameVar
        GuiControl, GCALGUI:Enable,EndDateVar
    }

return

;Event color DDL label.
ColorDDL:
    
GUI, GCALGUI:Submit, NoHide ;Store the control contents in their variables, and don't hide the GUI.

Switch (EventColorChoice) {
    Case "Red":previewColor := "cD50000"
    Case "Pink":previewColor := "cE67C73"
    Case "Orange":previewColor := "cF4511E"
    Case "Yellow":previewColor := "cF6BF26"
    Case "Light Green":previewColor := "c33B679"
    Case "Dark Green":previewColor := "c0B8043"
    Case "Light Blue":previewColor := "c039BE5"
    Case "Dark Blue":previewColor := "c3F51B5"
    Case "Lavender":previewColor := "c7986CB"
    Case "Purple":previewColor := "c8E24AA"
    Case "Gray":previewColor := "c616161"
}

GuiControl,+%previewColor%,ColorPreviewVal ;Change the progress bar's color.
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

    GuiControl, Focus, EventNameVar
return

;When this is pressed, start creating the Google Calendar events.
FinishButtonLabel:

    ;Store stuff in the variables, and hide the GUI (since it's no longer needed).
    GUI, GCALGUI:Submit
    setAllArrayValues()

    ;Disable the while loop in Auto-execute.
    GUIActive := "false"

    MsgBox, 262192, Start Creating Events, The script will now begin making events. Before you hit OK`, make sure that when this MsgBox closes`, it'll go into the Google Calendar window.`n`nF10 is also the emergency stop button in case the script goes haywire.

    createEvents()

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
    global ;So the arrays can be seen in this function.

    currentArrayIndex := 1
    totalArrayIndices := eventNameArray.MaxIndex()

    ;If null, make 1.
    if (totalArrayIndices = "") {
        totalArrayIndices := 1
    }

    ;This while loop is used for creating the events, and the right amount of them.
    ;While the current index for the arrays is less than the total number of events.
    ;When they equal, the script is done with its job, and terminates itself.
    while (currentArrayIndex <= totalArrayIndices) {

        ;If there isn't an event at this index, don't do anything and increment the array index by 1.
        if (eventNameArray[currentArrayIndex] != "") {

        ;Starts creating the event.
        Send, c
        Sleep, 1000

        ;Format the date and time variables properly.
        FormatTime, newStartDateVar, % startDateArray[currentArrayIndex], M/d/yyyy
        FormatTime, newStartTimeVar, % startTimeArray[currentArrayIndex], h:mm tt
        FormatTime, newEndDateVar, % endDateArray[currentArrayIndex], M/d/yyyy
        FormatTime, newEndTimeVar, % endTimeArray[currentArrayIndex], h:mm tt

        ;If this specific event is a working event (is checked),
        ;override (don't even use) the event name and instead send "Working *startTime* to *endTime*".
        if (scheduledToWorkBoolArray[currentArrayIndex] = 1) {

            Send, Working %newStartTimeVar% to %newEndTimeVar%
            
            Sleep 500
            Send, {Tab 2}
            Sleep 500

            Send, %newStartDateVar%
            Sleep 550
            Send, {Tab}

            Send, %newStartTimeVar%
            Sleep 550
            Send, {Tab}

            Send, %newEndTimeVar%
            Sleep 550

            Send, {Tab 30}
            Sleep 550
            Send, {Space}
            Sleep 850

        ;If it's not marked as a working event.
        } else {

            Send, % eventNameArray[currentArrayIndex]
            Sleep 600
            Send, {Tab 2}
            Sleep 500

            ;If an event is marked as all day.
            if (eventAllDayBoolArray[currentArrayIndex] = 1) {

                Send, %newStartDateVar%
                Sleep 400
                Send, {Tab 3}
                Sleep 600
                Send, %newEndDateVar%
                Sleep 600
                Send, {Tab 2}
                Sleep 600
                Send, {Space}
                Sleep 600
                Send, {Tab 26}
                Sleep 600
                Send, {Space}
                Sleep 600

            ;If an event is completely normal (no all day/working).
            } else {

                Send, %newStartDateVar%
                Sleep 550
                Send, {Tab}
                Sleep 550

                Send, %newStartTimeVar%
                Sleep 550
                Send, {Tab}
                Sleep 550

                Send, %newEndTimeVar%
                Sleep 550
                Send, {Tab}
                Sleep 550

                Send, %newEndDateVar%
                Sleep 550

                Send, {Tab 29}
                Sleep 550
                Send, {Space}
                Sleep 850
            }

        }

            ;Regardless of which type of event it is, this Switch statement is run.
            ;Select the right color.
            Switch (eventColorArray[currentArrayIndex]) {
                ;Case "Red": ;Do nothing, since Red is already selected.
                Case "Pink": Send, {Down 1}
                Case "Orange": Send, {Down 2}
                Case "Yellow": Send, {Down 3}
                Case "Light Green": Send, {Down 4}
                Case "Dark Green": Send, {Down 5}
                Case "Light Blue": Send, {Up 5}
                Case "Dark Blue": Send, {Up 4}
                Case "Lavender": Send, {Up 3}
                Case "Purple": Send, {Up 2}
                Case "Gray": Send, {Up 1}
            }

            Sleep 2000
            Send, {Enter}
            Sleep 2000

            ;Move to and click the save button; finish creating the event.
            ;There's less notifications to tab through when it's all day.
            if (eventAllDayBoolArray[currentArrayIndex]) {
                Send, +{Tab 29}
            } else {
                Send, +{Tab 33}
            }

            Sleep 2000
            
            ;Click the save button.
            Send, {Enter}
            Sleep 2500

        } ;End of the if empty string if statement.

        currentArrayIndex++ ;Move on to the next index.

    } ;End of the while loop.

    ExitApp ;End of the script.

} ;End of createEvents().

;Emergency stop button.
F10::
Reload
return