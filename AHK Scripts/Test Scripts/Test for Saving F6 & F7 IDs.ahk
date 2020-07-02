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

;This script is a test for being able to save array contents to a .txt file on disk; more specifically, for F12/F7 and AWH.
;Development started 6/29/2020; as of 7:23 PM it's working great.
;TODO: try this thing with the actual F6/F7 group stuff.

CurrentWinF12 := 1

WindowGroupF12 := []

;Add active window ID to array.
^F12::
WinGet, F12ID, ID, A
Tippy(F12ID, 500)
WindowGroupF12.Push(F12ID)
return

;Dump the array to the .txt file.
#F12::
FileDelete, arrayTest.txt
Tippy("Win F12", 1000)
Loop % WindowGroupF12.Length() {
    FileAppend, % WindowGroupF12[A_Index] . "`n", arrayTest.txt
}
return

;Load the IDs into the script.
!F12::
Tippy("Loading the file", 790)

currentArrayIndex := 1

FileRead, TxtFileIDs, arrayTest.txt

MsgBox % TxtFileIDs

Loop, Parse, TxtFileIDs, `n
{
	if (A_LoopField = "`n") {
		continue
	} else {
		MsgBox, 0, , A_LoopField = %A_LoopField%
		WindowGroupF12[currentArrayIndex] := A_LoopField
		currentArrayIndex++
	}
}

while (A_Index < WindowGroupF12.MaxIndex()) {
	MsgBox % WindowGroupF12[A_Index]
}
return


;Activates the next window.
F12::
NextWindowF12() {
	;Increment the current window by 1.
	CurrentWinF12++
	;If the current window is greater than the number of entries in the array.
	if (CurrentWinF12 > WindowGroupF12.MaxIndex())
		;Then reset it to the lowest index.
		CurrentWinF12 := WindowGroupF12.MinIndex()
	;Now activate the window based on CurrentWin.
	WinActivate, % "ahk_id" WindowGroupF12[CurrentWinF12]
}
return

;Used for making the use of ToolTips a lot simpler and easier.
Tippy(Text, Duration) {
	ToolTip, %Text%
	Sleep %Duration%
	ToolTip ;Remove the ToolTip.
}