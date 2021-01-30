;This script allows you to add windows to a special group so that if you press ^w or !F4 they won't be closed.

ctrlWGroupToFile(groupName, ctrlWGroup, calledOnExit, delimiter)
{	
	if ((ctrlWGroup.Length() == 0) AND (calledOnExit == 0)) {
        MsgBox, 262160, Error, This array has no elements in it.
        return
    }

    FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\%groupName%.tmp ;Reset/overwrite file.

    for index, value in ctrlWGroup ;Append values to the file.
    {
        if (value == "") ;Skip blank values
            continue
        valueToAppend := value . delimiter
        FileAppend, %valueToAppend%, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\%groupName%.tmp
    }

    if (calledOnExit == 0)
        Tippy("The " . groupName . " has been saved to disk.", 1000)
}
	
readCtrlWFile(groupName, ByRef ctrlWGroup, delimiter, calledOnStartup := 1)
{
    FileRead, groupFileContents, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\%groupName%.tmp
    ctrlWGroup := StrSplit(groupFileContents, delimiter) ;Split up the file and store in the passed-in array.
    groupFileContents := ;Free.

    if (calledOnStartup == 0)
        Tippy("The " . groupName . " has been restored from disk.", 1000)
}

ctrlWGroupBackup(groupName, ctrlWGroup, delimiter)
{
    for index, value in ctrlWGroup ;Append values to the file.
    {
        if (value == "") ;Skip blank values
            continue
        valueToAppend := value . delimiter
        FileAppend, %valueToAppend%, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\%groupName% Dump.tmp
    }
}

$^w::
if (!inArray(activeWindowTitle, ctrlWTitles)) OR (!inArray(activeWindowID, ctrlWIDs))
    Send, ^w
return

$!F4::
if (!inArray(activeWindowTitle, ctrlWTitles)) OR (!inArray(activeWindowID, ctrlWIDs))
    Send, !{F4}
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
        message .= value . "`n"
    }
}

MsgBox, 0, Ctrl W Windows, %message%
message := ;Empty this when done.
return