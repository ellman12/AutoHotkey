#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script was used for the Work Calendar Automation stuff so I could learn how to use arrays (in AHK)


; Creating the array
dateArray := []

F11::
dateArray := ["one", "two", "three", 17]
InputBox, ArrayLocation
ArrayValue := dateArray[ArrayLocation]
MsgBox, %ArrayValue%

F10::

while whilevar < 5 {
	
InputBox, Scheduled_Date, Scheduled Date, Enter a month and a day
	
	;Putting data in the array
	dateArray.Push(Scheduled_Date)
	
	;dateArray := [Scheduled_Date]
	
	whilevar++
	
	while whilevar > 4 {
		
		InputBox, ArrayLocation
		ArrayValue := dateArray[ArrayLocation]
		MsgBox, %ArrayValue%
		
	}

}