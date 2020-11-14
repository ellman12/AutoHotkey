;This script was created on Wednesday, September 16, 2020.
;I realized that, if I combined my 2 window groups and 2 window hiders, I could have a lot more power.
;There is also the ability to toggle what the single key does. It either switches between them, or hides them.
;There is a way to do this for all of them, regardless of what mode you're in.
;By default when the script starts, F6 and F7 are the 2 window groups, and F8 and F10 are the 2 window hiders.
;This can be changed in the Main Control Panel.

;**************************************************HOTKEYS**************************************************
; ^Fx:: Add the current window's ID to its respective array.
^F6::addWindowFx(WindowGroupF6)
^F7::addWindowFx(WindowGroupF7)
^F8::addWindowFx(WindowGroupF8)
^F10::addWindowFx(WindowGroupF10)

; ^!Fx:: Remove the current window from the array.
^!F6::removeWindowFx(WindowGroupF6)
^!F7::removeWindowFx(WindowGroupF7)
^!F8::removeWindowFx(WindowGroupF8)
^!F10::removeWindowFx(WindowGroupF10)

; !Fx:: Add the current window's ID to the array, and hide it right away. Only works when the array is in hide mode.
!F6::addAndHideWindowFx("F6", WindowGroupF6)
!F7::addAndHideWindowFx("F7", WindowGroupF7)
!F8::addAndHideWindowFx("F8", WindowGroupF8)
!F10::addAndHideWindowFx("F10", WindowGroupF10)

; Fx:: Either next window or hide windows.
F6::nextWinOrShowHideWins("F6", WindowGroupF6, CurrentWinF6)
F7::nextWinOrShowHideWins("F7", WindowGroupF7, CurrentWinF7)
F8::nextWinOrShowHideWins("F8", WindowGroupF8, CurrentWinF8)
F10::nextWinOrShowHideWins("F10", WindowGroupF10, CurrentWinF10)

; +Fx:: Either previous window or hide windows.
+F6::prevWinOrHideWins("F6", WindowGroupF6, CurrentWinF6)
+F7::prevWinOrHideWins("F7", WindowGroupF7, CurrentWinF7)
+F8::prevWinOrHideWins("F8", WindowGroupF8, CurrentWinF8)
+F10::prevWinOrHideWins("F10", WindowGroupF10, CurrentWinF10)

; #Fx:: Next window, regardless of mode.
#F6::nextWindowFx(WindowGroupF6, CurrentWinF6)
#F7::nextWindowFx(WindowGroupF7, CurrentWinF7)
#F8::nextWindowFx(WindowGroupF8, CurrentWinF8)
#F10::nextWindowFx(WindowGroupF10, CurrentWinF10)

; #+Fx:: Previous window, regardless of mode.
#+F6::prevWindowFx(WindowGroupF6, CurrentWinF6)
#+F7::prevWindowFx(WindowGroupF7, CurrentWinF7)
#+F8::prevWindowFx(WindowGroupF8, CurrentWinF8)
#+F10::prevWindowFx(WindowGroupF10, CurrentWinF10)

; ^+Fx:: Shows all the window titles in each array.
^+F6::showWinTitlesFx("F6", WindowGroupF6, CurrentWinF6, F6ShowHideToggle)
^+F7::showWinTitlesFx("F7", WindowGroupF7, CurrentWinF7, F7ShowHideToggle)
^+F8::showWinTitlesFx("F8", WindowGroupF8, CurrentWinF8, F8ShowHideToggle)
^+F10::showWinTitlesFx("F10", WindowGroupF10, CurrentWinF10, F10ShowHideToggle)

; ^#Fx:: Writes all the window IDs to the corresponding .txt file.
^#F6::writeGroupToFile("F6", WindowGroupF6, 0)
^#F7::writeGroupToFile("F7", WindowGroupF7, 0)
^#F8::writeGroupToFile("F8", WindowGroupF8, 0)
^#F10::writeGroupToFile("F10", WindowGroupF10, 0)

; !#Fx:: Reads the IDs from the corresponding .txt file.
!#F6::readGroupFromFile("F6", WindowGroupF6)
!#F7::readGroupFromFile("F7", WindowGroupF7)
!#F8::readGroupFromFile("F8", WindowGroupF8)
!#F10::readGroupFromFile("F10", WindowGroupF10)

; ^+#Fx:: Remove all windows from the array, without closing them.
^+#F6::removeAllWins("F6", WindowGroupF6, CurrentWinF6)
^+#F7::removeAllWins("F7", WindowGroupF7, CurrentWinF7)
^+#F8::removeAllWins("F8", WindowGroupF8, CurrentWinF8)
^+#F10::removeAllWins("F10", WindowGroupF10, CurrentWinF10)

; !#Fx:: Remove all windows from the array, and close all of them.
!+#F6::removeAndCloseAllWins("F6", WindowGroupF6, CurrentWinF6)
!+#F7::removeAndCloseAllWins("F7", WindowGroupF7, CurrentWinF7)
!+#F8::removeAndCloseAllWins("F8", WindowGroupF8, CurrentWinF8)
!+#F10::removeAndCloseAllWins("F10", WindowGroupF10, CurrentWinF10)

;**************************************************FUNCTIONS**************************************************
;Fx is either "F6", "F7", "F8", or "F10". The other param is the array to use. The Fx variable is just for the Tippy message.
addWindowFx(ByRef WindowGroupArray) {
    WinGet, currentID, ID, A ;Active window ID.
    for index, value in WindowGroupArray ;If the current ID is already in the array, don't add it.
        if (currentID = value)
            return
    WindowGroupArray.Push(currentID) ;If duplicate isn't found, add window ID to the array.
}

removeWindowFx(ByRef WindowGroupArray) {
    WinGet, currentID, ID, A ;Active window ID.
    for index, value in WindowGroupArray
        if (value = currentID)
            WindowGroupArray.RemoveAt(index)
}

addAndHideWindowFx(Fx, ByRef WindowGroupArray) {

    if (Fx = "F6" AND F6Mode = "Window Hider")
    {
        addWindowFx(WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    }
    else if (Fx = "F7" AND F7Mode = "Window Hider")
    {
        addWindowFx(WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    }
    else if (Fx = "F8" AND F8Mode = "Window Hider")
    {
        addWindowFx(WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    }
    else if (Fx = "F10" AND F10Mode = "Window Hider")
    {
        addWindowFx(WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    }
}

showOrHideWindowsFx(ByRef WindowGroupArray, ByRef FxShowHideToggle) {
    removeNonexistentWindows(WindowGroupArray)

    ;If it's 1, hide windows; if it's 0, it shows windows.
    FxShowHideToggle := !FxShowHideToggle

    if (FxShowHideToggle = 1) {

        for index, value in WindowGroupArray
            WinShow, % "ahk_id " value
        WinActivate, % "ahk_id " value

    } else {
        for index, value in WindowGroupArray
            WinHide, % "ahk_id " value
    }
}

nextWindowFx(ByRef WindowGroupArray, ByRef CurrentWin) {
    removeNonexistentWindows(WindowGroupArray)

    ;Checks if there's 2 windows in the array. If so, acts like !Tab.
    if (WindowGroupArray.MaxIndex() = 2)
    {
        if (activeWindowID != WindowGroupArray[CurrentWin] AND inArray(activeWindowID, WindowGroupArray)) {
            WinActivate, % "ahk_id" WindowGroupArray[CurrentWin]
            return
        }
    }

    ;If you switch to a different window that is not in the group, and you push the button to go to the next window, it'll take you back to the last window.
    ;This is what the R thing with AHK's built-in groups does.
    if (activeWindowID != WindowGroupArray[CurrentWin] AND !inArray(activeWindowID, WindowGroupArray)) {
        WinActivate, % "ahk_id" WindowGroupArray[CurrentWin]
        return
    }

    ;See this link for picture explanation: https://imgur.com/1Mc5B24
    if (activeWindowID = WindowGroupArray[CurrentWin + 1])
        CurrentWin += 2 ;Skip the window that is already active.
    else
        CurrentWin++

    ;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
    if (CurrentWin > WindowGroupArray.MaxIndex())
        CurrentWin := WindowGroupArray.MinIndex()
    WinActivate, % "ahk_id" WindowGroupArray[CurrentWin] ;Now activate the window based on CurrentWin.
}

nextWinOrShowHideWins(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
global ;I'm not proud of this code, but it works.
    if ((Fx = "F6") AND (F6Mode = "Window Group"))
        nextWindowFx(WindowGroupF6, CurrentWinF6)
    else if ((Fx = "F6") AND (F6Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF6, F6ShowHideToggle)
    else if ((Fx = "F7") AND (F7Mode = "Window Group"))
        nextWindowFx(WindowGroupF7, CurrentWinF7)
    else if ((Fx = "F7") AND (F7Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF7, F7ShowHideToggle)
    else if ((Fx = "F8") AND (F8Mode = "Window Group"))
        nextWindowFx(WindowGroupF8, CurrentWinF8)
    else if ((Fx = "F8") AND (F8Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF8, F8ShowHideToggle)
    else if ((Fx = "F10") AND (F10Mode = "Window Group"))
        nextWindowFx(WindowGroupF10, CurrentWinF10)
    else if ((Fx = "F10") AND (F10Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF10, F10ShowHideToggle)
}

prevWindowFx(ByRef WindowGroupArray, ByRef CurrentWin) {
    removeNonexistentWindows(WindowGroupArray)

    ;Checks if there's 2 windows in the array. If so, acts like !Tab.
    if (WindowGroupArray.MaxIndex() = 2)
    {
        if (activeWindowID != WindowGroupArray[CurrentWin] AND inArray(activeWindowID, WindowGroupArray)) {
            WinActivate, % "ahk_id" WindowGroupArray[CurrentWin]
            return
        }
    }

    if (activeWindowID != WindowGroupArray[CurrentWin] AND !inArray(activeWindowID, WindowGroupArray)) {
        WinActivate, % "ahk_id" WindowGroupArray[CurrentWin]
        return
    }

    if (activeWindowID = WindowGroupArray[CurrentWin - 1])
        CurrentWin -= 2 ;Skip the window that is already active.
    else
        CurrentWin--

    if (CurrentWin < WindowGroupArray.MinIndex())
        CurrentWin := WindowGroupArray.MaxIndex()
    WinActivate, % "ahk_id" WindowGroupArray[CurrentWin] ;Now activate the window based on CurrentWin.
}

prevWinOrHideWins(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
global ;I'm not proud of this code, but it works.
    if ((Fx = "F6") AND (F6Mode = "Window Group"))
        prevWindowFx(WindowGroupF6, CurrentWinF6)
    else if ((Fx = "F6") AND (F6Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF6, F6ShowHideToggle)
    else if ((Fx = "F7") AND (F7Mode = "Window Group"))
        prevWindowFx(WindowGroupF7, CurrentWinF7)
    else if ((Fx = "F7") AND (F7Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF7, F7ShowHideToggle)
    else if ((Fx = "F8") AND (F8Mode = "Window Group"))
        prevWindowFx(WindowGroupF8, CurrentWinF8)
    else if ((Fx = "F8") AND (F8Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF8, F8ShowHideToggle)
    else if ((Fx = "F10") AND (F10Mode = "Window Group"))
        prevWindowFx(WindowGroupF10, CurrentWinF10)
    else if ((Fx = "F10") AND (F10Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF10, F10ShowHideToggle)
}

removeNonexistentWindows(ByRef WindowGroupArray) {
    DetectHiddenWindows, On
    for index, value in WindowGroupArray
        if !WinExist("ahk_id" value)
            WindowGroupArray.RemoveAt(index)
    DetectHiddenWindows, Off
}

removeAllWins(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
    FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx%.txt ;Reset/overwrite file.
    WindowGroupArray := [] ;Blank out the array. It's that simple.
    CurrentWin := 1
    Tippy("All windows in " . Fx . " Group have been removed.", 4000)
}

removeAndCloseAllWins(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
    FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx%.txt ;Reset/overwrite file.
    DetectHiddenWindows, On
    for index, value in WindowGroupArray
        WinClose, % "ahk_id " value
    WindowGroupArray :=
    CurrentWin := 1
    Tippy("All windows in " . Fx . " Group have been removed and closed.", 4000)
}

showWinTitlesFx(Fx, WindowGroupArray, CurrentWin, FxShowHideToggle) {
    DetectHiddenWindows, On ;Needed for if windows are hidden (F8, etc.)

    if ((WindowGroupArray.Length() = 0))
        message := "There are no windows in the " . Fx . " Group."
    else ;List all the windows.
    {
        for index, value in WindowGroupArray
        {
            WinGetTitle, currentTitle, ahk_id %value%
            if (currentTitle = "") ;Skips windows that are in the array but that don't exist.
                continue
            message .= "Window #" . Index . " = " . currentTitle . "`n`n"
        }
    }

    MsgBox, 0, %Fx% Windows, CurrentWin%Fx% = %CurrentWin%`n`n%Fx%ShowHideToggle = %F6ShowHideToggle%`n`n%message%
    currentTitle := ;Free memory.
    message :=
}

;Stores a group in a .txt file for later use. calledOnExit is used for the Reload function so the user isn't bombarded with MsgBoxes on every reload. 0 = false; 1 = true.
writeGroupToFile(Fx, WindowGroupArray, calledOnExit) {

    if ((WindowGroupArray.Length() = 0) AND (calledOnExit = 0)) {
        MsgBox, 262160, Error, This array has no elements in it.
        return
    }

    FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Group.tmp ;Reset/overwrite file.

    for index, value in WindowGroupArray ;Append values to the file.
    {
        valueToAppend := value . A_Space
        FileAppend, %valueToAppend%, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Group.tmp
    }

    if (calledOnExit = 0)
        Tippy("The " . Fx . " Group has been saved to disk.", 1000)
    valueToAppend := ;Free.
}

;Dump the window group array in a .tmp file with the Fx, date, and time as the file name.
winGroupBackupDump(Fx, WindowGroupArray) {
global
    FormatTime, formattedDateTime,, M-d-yyyy h;mm;ss tt ;Part of the file name.

    for index, value in WindowGroupArray ;Append values to the file.
    {
        valueToAppend := value . A_Space ;Space is the delimiter here.
        FileAppend, %valueToAppend%, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Dumps\%Fx% Group %formattedDateTime%.tmp
    }

    valueToAppend := "" ;Free.
    formattedDateTime := ""
}

;Retrieves that group from the file. Added calledOnStartup so when the script starts up and calls this 4 times, those Tippys aren't there every single time. Similar to calledOnExit; optional parameter as well.
readGroupFromFile(Fx, ByRef WindowGroupArray, calledOnStartup := 1) {

    FileRead, groupFileContents, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\%Fx% Group.txt
    WindowGroupArray := StrSplit(groupFileContents, A_Space) ;Split up the file and store in the passed-in array. The delimiter is spaces because they're easiest to work with.
    groupFileContents := ;Free.

    if (calledOnStartup = 0)
        Tippy("The " . Fx . " Group has been restored from disk.", 1000)
}