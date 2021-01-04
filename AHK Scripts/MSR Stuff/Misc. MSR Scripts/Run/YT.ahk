#NoEnv
#MaxHotkeysPerInterval 999999999999999999999999999999999
#HotkeyInterval 99999999999999999999999999999999999
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

;Specifying just "YT" should make the command behave like it used to.
;1 controls if new tab/window, 2 controls private window or not, 3 is a search term.
;TODO: consider making the search term the first arg

if (A_Args[1] = "t") AND (A_Args[2] = "p")
{
    mode := "-private-window"
}
else if (A_Args[1] = "t") AND (A_Args[2] = "n") ;I think this works
{
    mode := "-new-tab"
}
else if (A_Args[1] = "w") AND (A_Args[2] = "p")
{
    mode := "-private-window"

}
else if (A_Args[1] = "w") AND (A_Args[2] = "n") ;works perfectly
{
    mode := "-new-window"
}


if (A_Args.Length() = 3)
{
    StringReplace, searchQuery, 3, %A_Space%, +, All
    url := "https://www.youtube.com/results?search_query=" . searchQuery
}
else
{
    url := "https://www.youtube.com/"
}

Run, C:\Program Files\Mozilla Firefox\firefox.exe %mode% %url%