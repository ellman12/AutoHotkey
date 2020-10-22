;This script was created on Wednesday, September 16, 2020.
;I realized that, if I combined my 2 window groups and 2 window hiders, I could have a lot more power.
;There is also the ability to toggle what the single key does. It either switches between them, or hides them.
;There is a way to do this for all of them, regardless of what mode you're in.
;By default when the script starts, F6 and F7 are the 2 window groups, and F8 and F10 are the 2 window hiders.
;This can be changed in the Main Control Panel.

;**************************************************HOTKEYS**************************************************
; ^Fx:: Add the current window's ID to its respective array.
^F6::addWindowFx("F6", WindowGroupF6)
^F7::addWindowFx("F7", WindowGroupF7)
^F8::addWindowFx("F8", WindowGroupF8)
^F10::addWindowFx("F10", WindowGroupF10)

; ^!Fx:: Remove the current window from the array.
^!F6::removeWindowFx("F6", WindowGroupF6)
^!F7::removeWindowFx("F7", WindowGroupF7)
^!F8::removeWindowFx("F8", WindowGroupF8)
^!F10::removeWindowFx("F10", WindowGroupF10)

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
#F6::nextWindowFx("F6", WindowGroupF6, CurrentWinF6)
#F7::nextWindowFx("F7", WindowGroupF7, CurrentWinF7)
#F8::nextWindowFx("F8", WindowGroupF8, CurrentWinF8)
#F10::nextWindowFx("F10", WindowGroupF10, CurrentWinF10)

; #+Fx:: Previous window, regardless of mode.
#+F6::prevWindowFx("F6", WindowGroupF6, CurrentWinF6)
#+F7::prevWindowFx("F7", WindowGroupF7, CurrentWinF7)
#+F8::prevWindowFx("F8", WindowGroupF8, CurrentWinF8)
#+F10::prevWindowFx("F10", WindowGroupF10, CurrentWinF10)

; ^#Fx:: Remove all windows from the array, without closing them.
^#F6::removeAllWins("F6", WindowGroupF6, CurrentWinF6)
^#F7::removeAllWins("F7", WindowGroupF7, CurrentWinF7)
^#F8::removeAllWins("F8", WindowGroupF8, CurrentWinF8)
^#F10::removeAllWins("F10", WindowGroupF10, CurrentWinF10)

; !#Fx:: Remove all windows from the array, and close all of them.
!#F6::removeAndCloseAllWins("F6", WindowGroupF6, CurrentWinF6)
!#F7::removeAndCloseAllWins("F7", WindowGroupF7, CurrentWinF7)
!#F8::removeAndCloseAllWins("F8", WindowGroupF8, CurrentWinF8)
!#F10::removeAndCloseAllWins("F10", WindowGroupF10, CurrentWinF10)

; ^+#Fx:: Shows all the window titles in each array.
^+#F6::showWinTitlesFx("F6", WindowGroupF6, CurrentWinF6)
^+#F7::showWinTitlesFx("F7", WindowGroupF7, CurrentWinF7)
^+#F8::showWinTitlesFx("F8", WindowGroupF8, CurrentWinF8)
^+#F10::showWinTitlesFx("F10", WindowGroupF10, CurrentWinF10)

;**************************************************FUNCTIONS**************************************************
;Fx is either "F6", "F7", "F8", or "F10". The other param is the array to use. The Fx variable is just for the Tippy message.
addWindowFx(Fx, ByRef WindowGroupArray) {
    WinGet, currentID, ID, A ;Active window ID.
    for index, value in WindowGroupArray ;If the current ID is already in the array, don't add it.
        if (currentID = value)
            return

    WindowGroupArray.Push(currentID) ;If duplicate isn't found, add window ID to the array.
    Tippy("Added to" . A_Space . Fx . A_Space . "Group.", 100)
}

removeWindowFx(Fx, ByRef WindowGroupArray) {
    WinGet, currentID, ID, A ;Active window ID.
    for index, value in WindowGroupArray ;Loop through list and find the value to remove.
        if (value != currentID) ;If it's not found, stop code flow because nothing needs to be added
            return
    WindowGroupArray.RemoveAt(index)
}

addAndHideWindowFx(Fx, ByRef WindowGroupArray) {

    if (Fx = "F6" AND F6Mode = "Window Hider") {
        addWindowFx(Fx, WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
        F6ShowHideToggle := 1
    } else if (Fx = "F7" AND F7Mode = "Window Hider") {
        addWindowFx(Fx, WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
        F7ShowHideToggle := 1
    } else if (Fx = "F8" AND F8Mode = "Window Hider") {
        addWindowFx(Fx, WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
        F8ShowHideToggle := 1
    } else if (Fx = "F10" AND F10Mode = "Window Hider") {
        addWindowFx(Fx, WindowGroupArray)
        WinHide, % "ahk_id" activeWindowID
        F10ShowHideToggle := 1
    }
}

showOrHideWindowsFx(ByRef WindowGroupArray, ByRef FxShowHideToggle) {
    removeNonexistentWindows(WindowGroupArray)

    ;If it's 1, hide windows; if it's 0, it shows windows.
    FxShowHideToggle := !FxShowHideToggle

    if (FxShowHideToggle = 1) {

        for index, value in WindowGroupArray
            WinShow, % "ahk_id " value
        WinActivate, , % "ahk_id " value

    } else {
        for index, value in WindowGroupArray
            WinHide, % "ahk_id " value
    }
}

nextWindowFx(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
    removeNonexistentWindows(WindowGroupArray)

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
        nextWindowFx("F6", WindowGroupF6, CurrentWinF6)
    else if ((Fx = "F6") AND (F6Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF6, F6ShowHideToggle)
    else if ((Fx = "F7") AND (F7Mode = "Window Group"))
        nextWindowFx("F7", WindowGroupF7, CurrentWinF7)
    else if ((Fx = "F7") AND (F7Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF7, F7ShowHideToggle)
    else if ((Fx = "F8") AND (F8Mode = "Window Group"))
        nextWindowFx("F8", WindowGroupF8, CurrentWinF8)
    else if ((Fx = "F8") AND (F8Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF8, F8ShowHideToggle)
    else if ((Fx = "F10") AND (F10Mode = "Window Group"))
        nextWindowFx("F10", WindowGroupF10, CurrentWinF10)
    else if ((Fx = "F10") AND (F10Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF10, F10ShowHideToggle)
}

prevWindowFx(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
    removeNonexistentWindows(WindowGroupArray)

    if (activeWindowID != WindowGroupArray[CurrentWin] AND !inArray(activeWindowID, WindowGroupArray)) {
        WinActivate, % "ahk_id" WindowGroupArray[CurrentWin]
        return
    }

    if (activeWindowID = WindowGroupArray[CurrentWin - 1])
        CurrentWin -= 2 ;Skip the window that is already active.
    else
        CurrentWin--

    if (CurrentWin < WindowGroup.MinIndex())
        CurrentWin := WindowGroup.MaxIndex()
    WinActivate, % "ahk_id" WindowGroupArray[CurrentWin] ;Now activate the window based on CurrentWin.
}

prevWinOrHideWins(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
global ;I'm not proud of this code, but it works.
    if ((Fx = "F6") AND (F6Mode = "Window Group"))
        prevWindowFx("F6", WindowGroupF6, CurrentWinF6)
    else if ((Fx = "F6") AND (F6Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF6, F6ShowHideToggle)
    else if ((Fx = "F7") AND (F7Mode = "Window Group"))
        prevWindowFx("F7", WindowGroupF7, CurrentWinF7)
    else if ((Fx = "F7") AND (F7Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF7, F7ShowHideToggle)
    else if ((Fx = "F8") AND (F8Mode = "Window Group"))
        prevWindowFx("F8", WindowGroupF8, CurrentWinF8)
    else if ((Fx = "F8") AND (F8Mode = "Window Hider"))
        showOrHideWindowsFx(WindowGroupF8, F8ShowHideToggle)
    else if ((Fx = "F10") AND (F10Mode = "Window Group"))
        prevWindowFx("F10", WindowGroupF10, CurrentWinF10)
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
    ;Blank out the array. It's that simple.
    WindowGroupArray :=
    CurrentWin := 1
    Tippy("All windows in " . A_Space . Fx . A_Space . "Group have been removed.", 100)
}

removeAndCloseAllWins(Fx, ByRef WindowGroupArray, ByRef CurrentWin) {
    DetectHiddenWindows, On
    for index, value in WindowGroupArray
        WinClose, % "ahk_id " value
    WindowGroupArray :=
    CurrentWin := 1
    Tippy("All windows in " . A_Space . Fx . A_Space . "Group have been removed and closed.", 100)
    DetectHiddenWindows, Off
}

showWinTitlesFx(Fx, WindowGroupArray, CurrentWin) {
    DetectHiddenWindows, On ;Needed for if windows are hidden (F8, etc.)

    for index, value in WindowGroupArray
    {
        WinGetTitle, currentTitle, ahk_id %value%
        message .= "Window #" . Index . " = " . currentTitle . "`n`n"
    }

    DetectHiddenWindows, Off
    MsgBox, 0, %Fx% Windows, CurrentWin%Fx% = %CurrentWin%`n`n%message%
    currentTitle := ;Free memory.
    message :=
}