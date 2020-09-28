;This script was created on Wednesday, September 16, 2020.
;I realized that, if I combined my 2 window groups and 2 window hiders, I could have a lot more power.
;There is also the ability to toggle what the single key does. It either switches between them, or hides them.
;There is a way to do this for all of them, regardless of what mode you're in.
;By default when the script starts, F6 and F7 are the 2 window groups, and F8 and F10 are the 2 window hiders.
;This can be changed in the Main Control Panel.

;TODO: When switching/hiding windows, if win not exist, remove it from the array.
;TODO: Remove extra unnecessary parameters.
;TODO: Could use something like A_prior hotkey for eliminating unnecessary params.
;TODO: if wins hidden, prevent script from reloading.

;***********************************HOTKEYS***********************************
/*

TODO: Put these above each hotkey block.

#Fx:: Next window, regardless of mode.
#!Fx:: Previous window, regardless of mode.

^!Fx:: Remove the current window from the array.

#+Fx:: Remove all windows from the array, without closing them.
!#+Fx:: Remove all windows from the array, and close all of them.
*/

; ^Fx:: Add the current window's ID to its respective array.
^F6::addWindowFx("F6", WindowGroupF6)
^F7::addWindowFx("F7", WindowGroupF7)
^F8::addWindowFx("F8", WindowGroupF8)
^F10::addWindowFx("F10", WindowGroupF10)

; !Fx:: Add the current window's ID to the array, and hide it right away. Only works when the array is in hide mode.
!F6::addAndHideWindowFx("F6", WindowGroupF6)
!F7::addAndHideWindowFx("F7", WindowGroupF7)
!F8::addAndHideWindowFx("F8", WindowGroupF8)
!F10::addAndHideWindowFx("F10", WindowGroupF10)

; Fx:: Either next window or hide windows.
F6::nextWinOrShowHideWins("F6", WindowGroupF6, CurrentWinF6, F6ShowHideToggle)
F7::nextWinOrShowHideWins("F7", WindowGroupF7, CurrentWinF7, F7ShowHideToggle)
F8::nextWinOrShowHideWins("F8", WindowGroupF8, CurrentWinF8, F8ShowHideToggle)
F10::nextWinOrShowHideWins("F10", WindowGroupF10, CurrentWinF10, F10ShowHideToggle)

; +Fx:: Either previous window or hide windows.
+F6::prevWinOrHideWins("F6", WindowGroupF6, CurrentWinF6)
+F7::prevWinOrHideWins("F7", WindowGroupF7, CurrentWinF7)
+F8::prevWinOrHideWins("F8", WindowGroupF8, CurrentWinF8)
+F10::prevWinOrHideWins("F10", WindowGroupF10, CurrentWinF10)

;*********************************FUNCTIONS***********************************
;Fx is either F6, F7, F8, or F10. The other param is the array to use.
;Add the current window to the specified array. The Fx variable is just for the Tippy message.
addWindowFx(Fx, ByRef windowGroupArray) {

    WinGet, currentID, ID, A ;Active window ID.
    IDFound := false ;Tracks if the ID is found in the array. If not, add it to it. This prevents duplicates.

    for index, value in windowGroupArray ;Loop through all the IDs.
    {
        if (value = currentID) { ;If the current ID was found inside the array, then mark it as found and break the loop.
            IDFound = true
            break
        }
    }

    ;If the ID was never found in the array, add it to the array.
    if (IDFound = false)
        windowGroupArray.Push(currentID)

	Tippy("Added to" . A_Space . Fx . A_Space . "Group!", 100)
    return
}

;Adds the window to the array, and hides it. Only works if the Fx is in the hider mode.
addAndHideWindowFx(Fx, ByRef windowGroupArray) {

    if (Fx = "F6" AND F6Mode = "Window Hider") {
        addWindowFx(Fx, windowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    } else if (Fx = "F7" AND F7Mode = "Window Hider") {
        addWindowFx(Fx, windowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    } else if (Fx = "F8" AND F8Mode = "Window Hider") {
        addWindowFx(Fx, windowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    } else if (Fx = "F10" AND F10Mode = "Window Hider") {
        addWindowFx(Fx, windowGroupArray)
        WinHide, % "ahk_id" activeWindowID
    }

    return
}

showOrHideWindowsFx(ByRef windowGroupArray, ByRef FxShowHideToggle) {

    ;If it's 1, hide windows; if it's 0, it shows windows.
    FxShowHideToggle := !FxShowHideToggle

    if (FxShowHideToggle = 1) {

        for index, value in windowGroupArray
            WinShow, % "ahk_id " value

        WinActivate, , % "ahk_id " value

    } else {

        for index, value in windowGroupArray
            WinHide, % "ahk_id " value
    }

}

;Next window in the array.
nextWindowFx(Fx, ByRef windowGroupArray, ByRef CurrentWin) {

    if (activeWindowID != windowGroupArray[CurrentWin] AND !inArray(activeWindowID, windowGroupArray)) {
        WinActivate, % "ahk_id" windowGroupArray[CurrentWin]
        return
    }

    ;See this link for picture explanation: https://imgur.com/1Mc5B24
    if (activeWindowID = windowGroupArray[CurrentWin + 1]) {
        CurrentWin += 2 ;Skip the window that is already active.
    } else {
        CurrentWin++
    }

    ;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
    if (CurrentWin > windowGroupArray.MaxIndex()) {
        CurrentWin := windowGroupArray.MinIndex()
    }

    ;Now activate the window based on CurrentWin.
    WinActivate, % "ahk_id" windowGroupArray[CurrentWin]
    return
}

;Previous window in the array.
prevWindowFx(Fx, ByRef windowGroupArray, ByRef CurrentWin) {

    if (activeWindowID != windowGroupArray[CurrentWin] AND !inArray(activeWindowID, windowGroupArray)) {
        WinActivate, % "ahk_id" windowGroupArray[CurrentWin]
        return
    }

    ;See this link for picture explanation: https://imgur.com/1Mc5B24
    if (activeWindowID = windowGroupArray[CurrentWin - 1]) {
        CurrentWin -= 2 ;Skip the window that is already active.
    } else {
        CurrentWin--
    }

    if (CurrentWin < WindowGroup.MinIndex())
        CurrentWin := WindowGroup.MaxIndex()

    ;Now activate the window based on CurrentWin.
    WinActivate, % "ahk_id" windowGroupArray[CurrentWin]
    return
}

nextWinOrShowHideWins(Fx, ByRef windowGroupArray, ByRef CurrentWin, ByRef FxShowHideToggle) {
global

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

    return
}

prevWinOrHideWins(Fx, ByRef windowGroupArray, ByRef CurrentWin) {
global

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

    return
}