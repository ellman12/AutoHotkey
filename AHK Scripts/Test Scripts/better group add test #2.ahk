#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent

;A test to try and group windows falling under a certain rule in a better way than GroupAdd.

#!F5:: ;Add windows to a custom group (array) by doing this hotkey in a window. E.g., do this in Word and you'll group Word windows.
wordGroup := [] ;Reallocate this array, since the
CurrentWin := 0

WinGet, activeProcessName, ProcessName, A ;Get the name of the window's .exe

WinGet, windowList, List, ahk_exe %activeProcessName% ;Get pseudo-array of window IDs. https://www.autohotkey.com/docs/commands/WinGet.htm#List

Loop % windowList ;Put the items from the pseudo-array into an actual array. This works because the pseudo-array without any % is equal to how many elements there are in it: https://www.autohotkey.com/docs/misc/Arrays.htm#pseudo
{
    wordGroup.push(windowList%A_Index%)
}
windowList := ;Free because it's no longer needed.
return

#F5::
currentWin++
;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
if (CurrentWin > wordGroup.MaxIndex())
    CurrentWin := wordGroup.MinIndex()
WinActivate, % "ahk_id" wordGroup[currentWin]
return

#r::Reload