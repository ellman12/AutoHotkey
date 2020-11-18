#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Persistent


wordGroup := []
currentWin := 0

WinGet, wordWins, List, ahk_exe WINWORD.EXE

Loop % wordWins
{
	WinGetTitle, currWordWin, % "ahk_id" wordWins%A_Index%
    wordGroup.push(wordWins%A_Index%)
}

#F5::
currentWin++
WinActivate, % "ahk_id" wordGroup[currentWin]
return

#r::Reload