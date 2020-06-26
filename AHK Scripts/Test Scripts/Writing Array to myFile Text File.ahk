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
DetectHiddenWindows, Off
#SingleInstance force
;OPTIMIZATIONS END

array := ["one", "two", "three"]
var := 69

FileDelete, myFile.txt

; Iterate from 1 to the end of the array:
Loop % array.Length() {
    ;~ MsgBox % array[A_Index]
	;For some reason, the newline character has to be in double quotes.
	;This is probably because it is considered text.
	FileAppend, % array[A_Index] . "`n", myFile.txt
}