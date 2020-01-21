#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

SetTitleMatchMode, 2

;This script was made to automate putting when I work in Google Calendar.
;The only things the user has to do is input the data, and pick the color for each event they want (when each event is being made).


;******************************************** VARIABLES ********************************************
;Creating the arrays.
;Used for storing the dates.
dateArray := []

;Used for storing the starting and ending times, respectively.
startTimeArray := []
endTimeArray := []

;Used in the second Loop to assign all of the values the user inputs into the right array index.
currentArrayIndex = 1 ;Starting value.

;How many entries there are once the user finishes inputting data. Used when the script starts making the events so it knows when to stop.
totalAmountOfArrayIndexes = 1 ;Starting value.

;These 8 hotstrings are for making my life easier when inputting data; they make it so I don't have to type as much when inputting data. You only have to type either "a" or "p" and it does the rest for you.
:*:a::
Send, AM
return
:*:am::
Send, AM
return
:*:A::
Send, AM
return
:*:am::
Send, AM
return
:*:p::
Send, PM
return
:*:pm::
Send, AM
return
:*:P::
Send, PM
return
:*:pm::
Send, PM
return

;Kills the script. Very, VERY useful.
F6::
Reload
return

;This is the Debug Box. It shows what values variables have. VERY useful when debugging.
F9::
MsgBox, 0, Debug Box!, currentArrayIndex: %currentArrayIndex%`ntotalAmountOfArrayIndexes: %totalAmountOfArrayIndexes%`n`n
return

;*********************************************************ACTUAL START OF THE SCRIPT*********************************************************

;Pushing F10 starts the script by having the user input all of the necessary data.
F10::

Loop {
	
	;Brings up the thing that allows the user to input a date.
	InputBox, Scheduled_Date, Scheduled Date, Enter a month and a day. Type "cancel" (it's not case sensitive) to cancel inputting data and start making the events. Previous entry was: %Scheduled_Date%., 200, 325

	Escape()

	;Putting data in the array
	dateArray.Push(Scheduled_Date)
	
	;If the user types cancel (not case sensitive), it'll break out of this and start making the events. It warns the user before it does this.
	if (Scheduled_Date = "CANCEl") {
		break
	}
	
	;Input the scheduled starting time for a single shift
	InputBox, Starting_Time, Starting Time, Enter the starting time for the shift on %Scheduled_Date%. Previous entry was: %Starting_Time%., 200, 430

	Escape()

	;Putting data in the array
	startTimeArray.Push(Starting_Time)

	;Input the scheduled ending time for a single shift
	InputBox, Ending_Time, Ending Time, Enter the ending time for the shift on %Scheduled_Date%. Previous entry was: %Ending_Time%., 200, 430

	Escape()

	;Putting data in the array
	endTimeArray.Push(Ending_Time)
	
	totalAmountOfArrayIndexes++
	
	;MsgBox asking the user if there's more events to input. If the user hits Enter, the program continues.
	;If they hit No, the program breaks out of the while loop and moves on to the next part of the program.
	MsgBox, 36, Anything else to input?, Anything else to input? Hitting No will start making the events in Google Calendar.`n`nBefore you hit No, make sure that when this MsgBox closes, it'll go into the Google Calendar window.
	IfMsgBox, No
		break
}

WinActivate, Google Calendar - December 2019 - Mozilla Firefox

;This while loop is used for creating the events, and the right amount of them
while (currentArrayIndex < totalAmountOfArrayIndexes) {
	
dateValue := dateArray[currentArrayIndex]
startTimeValue := startTimeArray[currentArrayIndex]
endTimeValue := endTimeArray[currentArrayIndex]

;The part of the script that takes the inputted data and makes the event

; Starts creating the event
Send, c
Sleep, 1000
Send, Working %startTimeValue% to %endTimeValue%
Sleep 1000
Send, {Tab 2}
Sleep 1000

;Inserts the date and time into the event
Send, %dateValue%
Sleep 500
Send, {Tab}
Sleep 500
Send, %startTimeValue%
Sleep 500
Send, {Tab}
Sleep 500
Send, %endTimeValue%
Sleep 500

;Creates the notifications
;~ Send, {Tab 14}
Send, {Tab 30}
Sleep 500

;Allowing the user to pick the event color they want
Send, {Space}
Sleep 500

; At this point, the script waits for the user to press down (what the "D" means) Enter, thus telling the script they have picked the event color they want.
KeyWait Enter, D

; These 33 Shift+Tabs are to get the Save button selected, and the Enter "clicks" it, thus creating the event in Google Calendar.
Send, +{Tab 33}
Sleep 2000
Send, {Enter}
Sleep 2000

;For the while loop
currentArrayIndex++

}
ExitApp

;Function used for if the user presses Cancel or Escape, so the script can acutally terminate itself.
;Some of this code was taken from my Run.ahk script.
Escape() {
	;If the user presses the Cancel button in the InputBox, or the Escape key (NOT typing CANCEL),
	; the script will terminate itself.
	if (ErrorLevel = 1) {
		MsgBox, ,CANCEL/Escape was pressed., CANCEL/Escape was pressed.`n`nThe script will now exit., 0.95
		ExitApp
	} else {
		;Do nothing.
	}
}