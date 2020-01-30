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
#SingleInstance force
;OPTIMIZATIONS END

;This script is a more advanced version of an old script called "WindowHider.ahk" script.
;That script kinda sucked, so I got inspired to make this improved version.
;It gives me incredible control over hiding and showing windows.
;Inspired by this script by GroggyOtter on r/AHK: https://www.reddit.com/r/AutoHotkey/comments/6fesyf/hide_windows/dii587h?utm_source=share&utm_medium=web2x
;I copied that script, and improved it.

;******************************Hotkeys******************************
; ^F8:: Add the current window's ID to the list (array).
; ^+F8:: Remove the current window's ID from the list (array).
; F8:: Toggle to show/hide all windows.
; TODO #F8:: Display a list of hidden windows with their index next to it. If user presses 1-9, it will show and activate the window with that index.
; ^!+#F8:: Close all windows in the list (array).
; Remove all windows from the group, without closing them.
; TODO OnExit, restore all hidden windows

;Declare array to track windows.
F8WinHideArray := []

;Decalre toggle as 1 so the first time you press F8, it hides everything.
toggle := 1
return

;Add window to hide list.
^F8::
    ;Get ID of current active window.
    WinGet, F8WinID, ID, A
    
    ;Loop through list and make sure there's no duplicates.
    for index, value in F8WinHideArray
        ;If duplicate is found
    if (F8WinID = value)
        ;Stop code flow because nothing needs to be added.
return

;If duplicate isn't found, add window.
F8WinHideArray.Push(F8WinID)

;Get title of window for tray tip.
WinGetActiveTitle, thisTitle

;Notify user add was sucessful.
ToolTip, Added to F8 Group!
Sleep, 200
ToolTip
return

;Remove window from hide list.
^+F8::
    ;Get ID of current active window.
    WinGet, F8WinID, ID, A
    
    ;Loop through list and find the value to remove.
    for index, value in F8WinHideArray
        ;If it's not found
    if (value != F8WinID)
        ;Stop code flow because nothing needs to be added
return

;Remove entry from array
F8WinHideArray.RemoveAt(index)

;Get title of window for tray tip
WinGetActiveTitle, thisTitle

;Notify user remove was successful
TrayTip, % "Window Removed", % thisTitle, 1

;Notify user removal was sucessful.
ToolTip, Added to F8 Group!
Sleep, 200
ToolTip
return

;Hide/show all the windows.
F8::
    
    ;Change toggle to opposite of toggle
    ;1 becomes 0. 0 becomes 1.
    toggle	:= !toggle
    
    ;If toggle = 1
    if (toggle = 1)
        ;Loop through the array...
    for index, value in F8WinHideArray
        ;...and show everything
    WinShow, % "ahk_id " value
    ;If toggle does not = 1
    Else
        ;Loop through the array...
    for index, value in F8WinHideArray
        ;...and hide everything
    WinHide, % "ahk_id " value
return

;Close all windows in the list (array).
^!+#F8::

;For-loops through the array, closing each window along the way.
for index, value in F8WinHideArray
WinClose, % "ahk_id " value

return

; Remove all windows from the group, without closing them.
^!+F8::
F8WinHideArray := 
return