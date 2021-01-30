;This script allows you to add windows to a special group so that if you press ^w or !F4 they won't be closed.

$^w::
$!F4::
if (!inArray(activeWindowTitle, ctrlWTitles)) OR (!inArray(activeWindowID, ctrlWIDs))
    Send, %A_ThisHotkey%
return

^#w:: ;Add to arrays
if (!inArray(activeWindowTitle, ctrlWTitles))
    ctrlWTitles.Push(activeWindowTitle)

; if (!inArray(activeWindowID, ctrlWIDs))
ctrlWIDs.Push(activeWindowID)
return

!#w:: ;Remove from arrays
for index, value in ctrlWTitles
    if (value == activeWindowTitle)
        ctrlWTitles.RemoveAt(index)

for index, value in ctrlWIDs
    if (value == activeWindowID)
        ctrlWIDs.RemoveAt(index)
return

+#w:: ;Empty the arrays
ctrlWTitles :=
ctrlWIDs :=
return

; !+#w:: ;Close all wins and empty the array

; Gosub, +#w
; return

^+w::
DetectHiddenWindows, On ;Needed for if windows are hidden (F8, etc.)

if ((ctrlWTitles.Length() == 0) AND (ctrlWIDs.Length() == 0))
    message := "There are no Ctrl W windows."
else
{
    for index, value in ctrlWTitles
    {
        message .= value . " (" . ctrlWIDs[index] . ")`n`n"
    }
}

MsgBox, 0, Ctrl W Windows, %message%
message := ;Empty this when done.
return