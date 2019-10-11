#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This script was designed to automate the creation of Google Calendar events for when I work.
;This is also the original script designed for making one event at a time.


; Pressing F10 runs this script
F10::

;Input a single date that I am scheduled for
InputBox, Scheduled_Date, Scheduled Date, Enter a month and a day

;Input the scheduled starting time for a single shift
InputBox, Starting_Time, Starting Time, Enter the starting time

;Input the scheduled ending time for a single shift
InputBox, Ending_Time, Ending Time, Enter the ending time

;Final MsgBox before the Google Calendar event is created. Useful to make sure all the data is correct, and to get everything ready.
MsgBox, 0, Press OK/Enter to start making the event, Scheduled Date: %Scheduled_Date%`n`nStarting Time: %Starting_Time%`n`nEnding Time: %Ending_Time%`n`n`nWhenever you're ready, click on the Calendar tab, then Alt + Tab back to this window, and then hit OK/Enter


;The part of the script that takes the inputted data and makes the event

; Goes to inputted date
Send, G
Sleep, 800
Send, %Scheduled_Date%
Sleep, 800
Send, {Enter}
Sleep 800
Send, D
Sleep 800

; Starts creating the event
Send, C
Sleep, 1000
Send, Working %Starting_Time% to %Ending_Time%
Sleep 1000
Send, {Tab 8}
Sleep 1000
Send, {Enter}
Sleep 2000

; Names the event
Send, ^a
Sleep 100
Send, Working %Starting_Time% to %Ending_Time%
Sleep 2000

; Creates the notifications
Send, {Tab 18}
Sleep 100
Send, 10
Sleep 100
Send, {Tab}
Sleep 100
Send, H
Sleep 100
Send, {Tab 2}
Sleep 100
Send, {Enter}
Sleep 100
Send, {Tab}
Sleep 100
Send, 5
Sleep 100
Send, {Tab}
Sleep 100
Send, H
Sleep 100
Send, {Tab 2}
Sleep 100
Send, {Enter}
Sleep 100
Send, {Tab}
Sleep 100
Send, 2
Sleep 100
Send, {Tab}
Sleep 100
Send, H
Sleep 100

; Allowing the user to pick the event color they want
Send, {Tab 3}
Sleep 100
Send, {Space}
Sleep 100

; At this point, the script waits for the user to press down (what the "D" means) Enter, thus telling the script they have picked the event color they want.
KeyWait Enter, D

; These 29 Shift+Tabs are to get the Save button selected, and the Enter "clicks" it, thus creating the event in Google Calendar.
Send, +{Tab 29}
Sleep 2000
Send, {Enter}
Sleep 2000

; Finishes up the script by returning back to month view; could possibly be removed...?
Send, M

; End of script
return



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
