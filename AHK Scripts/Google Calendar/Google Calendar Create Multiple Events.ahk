#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script was made to automate putting events with different names in Google Calendar.
;It is a slightly modified version of the script called "Work Calendar Automation (Multiple).ahk".
;The only things the user has to do by hand is input the data, and pick the color for each event they want (when each event is being made).
;It can also be used for doing my work schedule, but if it's just for that, the other script would be better, as there's a tiny bit less manual work needed for that script.
;This script also allows the user to specify if an event is "all day" or not.


;********************************************VARIABLES********************************************

;Creating the arrays.
;Used for storing the dates.
dateArray := []

;Used for storing the starting and ending times, respectively.
startTimeArray := []
endTimeArray := []

;Used for storing the custom event names.
customNamesArray := []

;Used in the second Loop to assign all of the values the user inputs into the right array index.
currentArrayIndex = 1 ;Starting value.

;How many entries there are once the user finishes inputting data. Used when the script starts making the events so it knows when to stop.
totalAmountOfArrayIndexes = 1 ;Starting value.

;****************************************HOTKEYS AND HOTSTRINGS*************************************

;These hotstrings are for making my life easier when inputting data.
;They only work in the Starting and Ending Time InputBoxes.
#IfWinActive Starting Time
:*:a::AM
:*:p::PM

#IfWinActive Ending Time
:*:a::AM
:*:p::PM
#If

;Kills the script. Very, VERY useful.
F6::
Reload
return

;This is the Debug Box. It shows what values variables have. VERY useful when debugging.
F9::
MsgBox, 0, Debug Box!, currentArrayIndex: %currentArrayIndex%`ntotalAmountOfArrayIndexes: %totalAmountOfArrayIndexes%`n`n
return

;******************************************** VARIABLES ********************************************

;Pushing F10 starts the script by having the user input all of the necessary data.
F10::

;This Loop is run until the user is done inputting the data they want.
Loop {
	
	;Brings up the InputBox that allows the user to input the name of the event
	InputBox, inputBoxEventName, Event name, Enter the name of the event. Type "cancel" (it's not case sensitive) to cancel inputting data and start making the events. Previous entry was: %inputBoxEventName%., 200, 325
	
	;If the user types cancel (not case sensitive), it'll break out of this and start making the events. It warns the user before it does this.
	if (inputBoxEventName = "CANCEl") {
		break
	}
	
	;Putting data in the array.
	customNamesArray.Push(inputBoxEventName)
	
	;Brings up the thing that allows the user to input a date.
	InputBox, Scheduled_Date, Scheduled Date, Enter a month and a day. Previous entry was: %Scheduled_Date%.

	;Putting data in the array.
	dateArray.Push(Scheduled_Date)
	
	;Input the scheduled starting time for a single event.
	InputBox, Starting_Time, Starting Time, Enter the starting time for "%inputBoxEventName%" on %Scheduled_Date%. Type "all day" to mark the event as all day. Previous entry was: %Starting_Time%., 200, 430
	
	;Putting data in the array.
	startTimeArray.Push(Starting_Time)

	;If the event is marked as "all day", it won't bother bringing up the end time InputBox.
	if (Starting_Time != "All day") {
	;Input the scheduled ending time for a single event.
	InputBox, Ending_Time, Ending Time, Enter the ending time for "%inputBoxEventName%" on %Scheduled_Date%. Previous entry was: %Ending_Time%., 200, 430
	}
	
	;Putting data in the array
	endTimeArray.Push(Ending_Time)
	
	;Increment this value by 1, so the while loop later on knows how many times it needs to run.
	totalAmountOfArrayIndexes++
	
	;MsgBox asking the user if there's more events to input. If the user hits Enter (Yes), the program continues inputting data.
	;If they hit No, the program breaks out of the while loop and moves on to the next part of the program.
	MsgBox, 36, Anything else to input?, Anything else to input? Hitting No will start making the events in Google Calendar.`n`nBefore you hit No, make sure that when this MsgBox closes, it'll go into the Google Calendar window.
	IfMsgBox, No
		break ;Break out of the loop
}

;This while loop is used for creating the events, and the right amount of them.
;While the current index for the arrays is less than the total number of events.
;When they equal, the script is done with its job, and terminates itself.
while (currentArrayIndex < totalAmountOfArrayIndexes) {

;Used for each time this while loop goes through.
;These are essentially shorthand.
dateValue := dateArray[currentArrayIndex]
startTimeValue := startTimeArray[currentArrayIndex]
endTimeValue := endTimeArray[currentArrayIndex]
customNamesValue := customNamesArray[currentArrayIndex]

;The part of the script that takes the inputted data and makes the event

;Starts creating the event
Send, c
Sleep, 1000

;If the user wanted the event at this array index to be all day,
;else make a normal event.
if (startTimeValue = "all day") {

;Puts in the event name for the all day event, and marks it as "all day".
Send, %customNamesValue%
Sleep 485
Send, {Tab 2}
Sleep 485
Send, %dateValue%
Sleep 485
Send, {Tab 5}
Sleep 550
Send, {Space}
Sleep 550

;Creates the single notification: 1 day before at 9 AM.
;Could always be adjusted, or could insert more.
Send, {Tab 10}
Sleep 485
Send, {Enter}
Sleep 485

;Tabbing over to where the user picks the event color they want.
Send, {Tab 6}
Sleep 485
Send, {Space}
 
;The scripts for the user to push the "Enter" key down ("D").
;This tells it that they have chosen their desired event color.
KeyWait Enter, D

;These 19 Shift+Tabs are to get the Save button selected, and the Enter "clicks" it, thus creating the event in Google Calendar.
Send, +{Tab 19}
Sleep 2000
Send, {Enter}
Sleep 2000

;If the event type is a normal event (start and end time).
} else {

;Puts in the event name for the normal-style event.
Send, %customNamesValue% %startTimeValue% to %endTimeValue%
Sleep 1000
Send, {Tab 2}
Sleep 1000

;Inserts the date and time into the event
Send, %dateValue%
Sleep 485
Send, {Tab}
Sleep 485
Send, %startTimeValue%
Sleep 485
Send, {Tab}
Sleep 485
Send, %endTimeValue%
Sleep 485

;Tabbing over to where the user picks the event color they want.
Send, {Tab 3}
Sleep 485
Send, {Space}
Sleep 485

;The scripts for the user to push the "Enter" key down ("D").
;This tells it that they have chosen their desired event color.
KeyWait Enter, D

;These 33 Shift+Tabs are to get the Save button selected, and the Enter "clicks" it, thus creating the event in Google Calendar.
Send, +{Tab 33}
Sleep 2000
Send, {Enter}
Sleep 2000

}

;For the while loop.
currentArrayIndex++
}

return ;End of the F10 hotkey.
ExitApp ;End of the script.