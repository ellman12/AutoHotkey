#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

;A test to try and group windows falling under a certain rule in a better way than GroupAdd.

wordGroup := []
currentWin := 1

#!F5::
SetTitleMatchMode, 2
WinGetTitle, activeTitle, A
WinGet, windowList, List, ahk_exe activeTitle

MsgBox, %windowList%
Loop % windowList ;Put the items from the pseudo-array into an actual array. This works because the pseudo-array without ny %% is equal to how many elements there are in it: https://www.autohotkey.com/docs/misc/Arrays.htm#pseudo
{
    wordGroup.push(windowList%A_Index%)
    ; windowList := ;Free because it's no longer needed.
}
return

#F5::
currentWin++
;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
if (CurrentWin > wordGroup.MaxIndex())
    CurrentWin := wordGroup.MinIndex()
WinActivate, % "ahk_id" wordGroup[currentWin]
return

#r::Reload