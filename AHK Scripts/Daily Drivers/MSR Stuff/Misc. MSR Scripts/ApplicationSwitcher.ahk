;A lot of this code is taken from Taran Van Hemert from Linus Media Group. His video on this: https://www.youtube.com/watch?v=OqyQABySV8k

;If a Firefox window doesn't exist, run Firefox.
;If a Firefox window does exist, switch to Chrome.
;If Firefox is active, send ^PGDN (switch between tabs).
F1::
    switchToFirefoxAndBetweenTabs() {
        IfWinNotExist, ahk_class MozillaWindowClass
            Run, C:\Program Files\Mozilla Firefox\firefox.exe
        if WinActive("ahk_exe firefox.exe")
            Send ^{PGDN}
        else {
            ;WinRestore ahk_exe firefox.exe
            WinActivatebottom ahk_exe firefox.exe
            ;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
            ;the below code should fix that.
            WinGet, hWnd, ID, ahk_class MozillaWindowClass
            DllCall("SetForegroundWindow", UInt, hWnd)
        }
    }
return

;Same thing as F1, but reverse order (PGUP instead of PGDN).
+F1::
    switchToFirefoxAndBetweenTabsReverse() {
        IfWinNotExist, ahk_class MozillaWindowClass
            Run, C:\Program Files\Mozilla Firefox\firefox.exe
        if WinActive("ahk_exe firefox.exe")
            Send ^{PGUP}
        else {
            ;WinRestore ahk_exe firefox.exe
            WinActivatebottom ahk_exe firefox.exe
            ;sometimes winactivate is not enough. the window is brought to the foreground, but not put into FOCUS.
            ;the below code should fix that.
            WinGet, hWnd, ID, ahk_class MozillaWindowClass
            DllCall("SetForegroundWindow", UInt, hWnd)
        }
    }
return

;If a Firefox window doesn't exist, run Firefox.
;If Firefox windows do exist, add them to a window
; group and switch between them.
F2::
    switchToOtherFirefoxWindows() {
        If WinNotExist, ahk_class MozillaWindowClass
            Run, C:\Program Files\Mozilla Firefox\firefox.exe
        else
        {
            GroupAdd, taranfirefoxes, ahk_class MozillaWindowClass
            if WinActive("ahk_class MozillaWindowClass")
                GroupActivate, taranfirefoxes, r
            else
                WinActivate ahk_class MozillaWindowClass
        }
    }
return

;Create a new normal Firefox window.
^F1::
^F2::
Run, C:\Program Files\Mozilla Firefox\firefox.exe
return

;Create a new Private Firefox window.
!F1::
!F2::
Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window
return

F3::
switchToVSAndTabs()
{
IfWinNotExist, ahk_class Chrome_WidgetWin_1
	Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code\Code.exe
if WinActive("ahk_exe Code.exe")
	Send ^{PGDN}
else
	WinActivate ahk_exe Code.exe
}

F4::
switchToOtherVSWindows()
{
Process, Exist, Code.exe
	If errorLevel = 0
		Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code\Code.exe
	else
	{
	GroupAdd, taranCodes, ahk_exe Code.exe
	if WinActive("ahk_exe Code.exe")
		GroupActivate, taranCodes, r
	else
		WinActivate ahk_exe Code.exe
	}
}

/*
;If a Chrome window doesn't exist, run Chrome.
;If a Chrome window does exist, switch to Chrome.
;If Chrome is active, send ^PGDN (switch between tabs).
F3::
    switchToChromeAndTabs()
    {
        IfWinNotExist, ahk_class Chrome_WidgetWin_1
            Run, chrome.exe
        if WinActive("ahk_exe chrome.exe")
            Send ^{PGDN}
        else
            WinActivate ahk_exe chrome.exe
    }

;Same thing as F3, but reverse order (PGUP instead of PGDN).
+F3::
    switchToChromeAndTabsReverse()
    {
        IfWinNotExist, ahk_class Chrome_WidgetWin_1
            Run, chrome.exe
        if WinActive("ahk_exe chrome.exe")
            Send ^{PGUP}
        else
            WinActivate ahk_exe chrome.exe
    }
return

;If a Chrome window doesn't exist, run Chrome.
;If Chrome windows do exist, switch between them.
F4::
    switchToOtherChromeWindows()
    {
        Process, Exist, chrome.exe
        if errorLevel = 0
            Run, chrome.exe
        else
        {
            GroupAdd, taranchromes, ahk_class Chrome_WidgetWin_1
            if WinActive("ahk_class ahk_class Chrome_WidgetWin_1")
                GroupActivate, taranchromes, r
            else
                WinActivate ahk_class Chrome_WidgetWin_1
        }
    }

;Create a new normal Chrome window.
^F3::
Run, chrome.exe
return

;Create a new normal Chrome window.
^F4::
Run, chrome.exe
return

;Create a new incognito Chrome window.
!F3::
Run, chrome.exe -incognito
return
*/

;MR button on my K95 RGB keyboard.
;Used for activating and switching to File Explorer windows.
^F5::
    switchToExplorer() {
        IfWinNotExist, ahk_class CabinetWClass
            Run, explorer.exe
        GroupAdd, taranexplorers, ahk_class CabinetWClass
        if WinActive("ahk_exe explorer.exe")
            GroupActivate, taranexplorers, r
        else
            WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
    }

    ;Creates a new File Explorer window.
    ;Activated by holding down Shift and MR (Shift + Ctrl + F5).
^+F5::
    Run, explorer.exe
return

;Back button; does stuff in reverse.
;Ex. F9 in Firefox does the opposite of F1.
F9::
    if WinActive("ahk_exe firefox.exe")
        Send ^{PgUp}
    if WinActive("ahk_class Chrome_WidgetWin_1")
        Send ^+{tab}
    if WinActive("ahk_exe explorer.exe")
        Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
return

;Run Word if not exist, and then switch between windows.
$F12::
    if WinExist("ahk_class OpusApp") {
        GroupAdd, taranwords, ahk_class OpusApp
        if WinActive("ahk_class OpusApp")
            GroupActivate, taranwords, r
        else
            WinActivate ahk_class OpusApp
    } else {
        Run, C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE
    }
return

;*******************HOTKEYS FOR MICROSOFT TO DO APP*******************
; #t:: In the Tasks menu, add a task and mark it due today. Or activate it. Or run it.

;*****HOTKEYS FOR THE TASKS MENU*****
; !#t:: Add a task and mark it due tomorrow.
; +#t:: Add a task and mark it due today.

;*****HOTKEYS FOR THE MY DAY MENU*****
; +#t:: Add a task and mark it due today.
; !+#t:: Add a task and mark it due tomorrow.

#t::
Sleep 200
if WinActive("Microsoft To Do") { ;In the Tasks menu, add a task and mark it due today.
    createMSToDoTask(1, 0)
} else if WinExist("Microsoft To Do") ;Activate it.
    WinActivate
else {
    Run, C:\Users\Elliott\Documents\Microsoft To Do ;Shortcut in Documents.
}
return

#IfWinActive, Microsoft To Do
;*****HOTKEYS FOR THE TASKS MENU*****
;Add a task and mark it due tomorrow.
!#t::createMSToDoTask(1, 1)

;*****HOTKEYS FOR THE MY DAY MENU*****
;Add a task and mark it due today.
+#t::createMSToDoTask(2, 0)

;Add a task and mark it due tomorrow.
!+#t::createMSToDoTask(2, 1)
#If

;Used for creating tasks in MS To Do.
;This function only works in/for the Tasks or My Day view.
createMSToDoTask(numberOfTabs, numberOfDowns) {
    Sleep 250
    Send, {Tab %numberOfTabs%}
    Sleep 230
    Send, {Space}
    Sleep 230
    Send, {Down %numberOfDowns%}
    Sleep 230
    Send, {Space}
    Sleep 230
    Send, +{Tab %numberOfTabs%}{Enter}
}

;****************************************************CUSTOM GROUP STUFF****************************************************
;*************************************************F6 GROUP STUFF*************************************************

/*
^F6::AddWindowF6()

^!F6::RemoveWindowF6()

F6::NextWindowF6()

+F6::PrevWindowF6()

^+F6::RemoveNonexistentWindowsF6()

;Add the current window to the array.
AddWindowF6() {

    ;Quick little prompt telling the user the window was added.
    ToolTip, Added to F6 Group!
    Sleep, 200
    ToolTip

    WinGet, thisIDF6, ID, A
    ;Value to track if ID was found in the group
    foundF6 := false
    ;Loop through all the IDs
    for indexF6, value in WindowGroupF6
    {
        ;If the current ID was found inside the array
        if (value = thisIDF6) {
            ;Then mark it as found and break the loop
            foundF6 = true
            break
        }
    }

    ;If the ID was never found in the array
    if (foundF6 = false) {
        ;Add it to the array
        WindowGroupF6.Push(thisIDF6)
    }
    return
}

;Remove the curent window from the array.
RemoveWindowF6() {
    ToolTip, Removed from F6 Group!
    Sleep, 200
    ToolTip

    WinGet, thisIDF6, ID, A
    foundF6 := false
    for indexF6, value in WindowGroupF6
    {
        ;Same as the AddWindow function except if a match is found, remove it from the array
        if (value = thisIDF6) {
            WindowGroupF6.RemoveAt(indexF6)
            break
        }
    }
    return
}

;Activates the next window.
; NextWindowF6() {

    if (activeWindowID != WindowGroupF6[CurrentWinF6] AND !inArray(activeWindowID, WindowGroupF6)) {
        WinActivate, % "ahk_id" WindowGroupF6[CurrentWinF6]
        return
    }

    ;See this link for picture explanation: https://imgur.com/1Mc5B24
    if (activeWindowID = WindowGroupF6[CurrentWinF6 + 1]) {
        CurrentWinF6 += 2 ;Skip the window that is already active.
    } else {
        CurrentWinF6++
    }

    ;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
    if (CurrentWinF6 > WindowGroupF6.MaxIndex()) {
        CurrentWinF6 := WindowGroupF6.MinIndex()
    }

    ;Now activate the window based on CurrentWin.
    WinActivate, % "ahk_id" WindowGroupF6[CurrentWinF6]
    return
}

;Activate previous window.
PrevWindowF6() {

    if (activeWindowID != WindowGroupF6[CurrentWinF6] AND !inArray(activeWindowID, WindowGroupF6)) {
        WinActivate, % "ahk_id" WindowGroupF6[CurrentWinF6]
        return
    }

    ;See this link for picture explanation, it's just backwards: https://imgur.com/1Mc5B24
    if (activeWindowID = WindowGroupF6[CurrentWinF6 - 1]) {
        CurrentWinF6 -= 2
    } else {
        CurrentWinF6--
    }

    if (CurrentWinF6 < WindowGroupF6.MinIndex())
        CurrentWinF6 := WindowGroupF6.MaxIndex()
    ;Now activate that window based on CurrentWin.
    WinActivate, % "ahk_id" WindowGroupF6[CurrentWinF6]
    return
}

;Removes windows that don't exist anymore—and their IDs—from the array.
;E.g., if you close a window, and its ID is still in the array,
;loop through the array and remove any IDs for windows that don't exist.
RemoveNonexistentWindowsF6() {
    ;Loop through the F6 ID array.
    for indexF6, value in WindowGroupF6
    {
        ;If the window with the ID of "value" at the current index doesn't exist...
        if !WinExist("ahk_id" value)
        {
            ;Remove it from the array.
            WindowGroupF6.RemoveAt(indexF6)
        }
    }
    return

}

;Dumps all the IDs in the array into a .txt file. They can then be loaded in for later use. The old file is deleted and replaced with the current one.
; SaveIDsToTxtFileF6() {
; 	FileDelete, testF6.txt
; 	Loop % WindowGroupF6.Length()
; 		FileAppend, % WindowGroupF6[A_Index] . "`n", testF6.txt
; 	Tippy("Finished saving F6 IDs to disk", 1500)
; 	return
; }

;Restores saved IDs to the F6 array. Overwrites what is in it all ready.
; restoreSavedIDsF6() {
; 	Tippy("Loading the F6 file", 800)

; 	;This should theoretically blank this out.
; 	WindowGroupF6 := ""

; 	F6ArrayIndex := 1

; 	FileRead, F6TxtFileIDs, testF6.txt

; 	MsgBox % F6TxtFileIDs

; 	Loop, Parse, F6TxtFileIDs, `n
; 	{
; 		if (A_LoopField = "`n") {
; 			continue
; 		} else {
; 			MsgBox, 0, , A_LoopField = %A_LoopField%
; 			WindowGroupF6[F6ArrayIndex] := A_LoopField
; 			F6ArrayIndex++
; 		}
; 	}

; 	while (A_Index < WindowGroupF6.MaxIndex()) {
; 		MsgBox % WindowGroupF6[A_Index]
; 	}
; 	return
; }

;*************************************************F7 GROUP STUFF*************************************************
;Identical to F6 Group Stuff, but for the F7 key. Thus, allowing me to have 2 custom window groups.
^F7::AddWindowF7()

^!F7::RemoveWindowF7()

F7::NextWindowF7()

+F7::PrevWindowF7()

^+F7::RemoveNonexistentWindowsF7()

AddWindowF7() {
    ToolTip, Added to F7 Group!
    Sleep, 200
    ToolTip

    ;Get the active window's ID
    WinGet, thisIDF7, ID, A
    ;Value to track if ID was found in the group
    foundF7 := false
    ;Loop through all the IDs
    for indexF7, value in WindowGroupF7
    {
        ;If the current ID was found inside the array
        if (value = thisIDF7) {
            ;Then mark it as found and break the loop
            foundF7 = true
            break
        }
    }

    ;If the ID was never found in the array.
    if (foundF7 = false) {
        ;Add it to the array.
        WindowGroupF7.Push(thisIDF7)
    }
    return
}

RemoveWindowF7() {
    ToolTip, Removed from F7 Group!
    Sleep, 200
    ToolTip

    WinGet, thisIDF7, ID, A
    foundF7 := false
    for indexF7, value in WindowGroupF7
    {
        ;Same as the AddWindow function except if a match is found, remove it from the array
        if (value = thisIDF7) {
            WindowGroupF7.RemoveAt(indexF7)
            break
        }
    }
    return
}

;Activates the next window.
NextWindowF7() {

    if (activeWindowID != WindowGroupF7[CurrentWinF7] AND !inArray(activeWindowID, WindowGroupF7)) {
        WinActivate, % "ahk_id" WindowGroupF7[CurrentWinF7]
        return
    }

    ;See this link for picture explanation: https://imgur.com/1Mc5B24
    if (activeWindowID = WindowGroupF7[CurrentWinF7 + 1]) {
        CurrentWinF7 += 2 ;Skip the window that is already active.
    } else {
        CurrentWinF7++
    }

    ;If the current window is greater than the number of entries in the array, then reset it to the lowest index.
    if (CurrentWinF7 > WindowGroupF7.MaxIndex()) {
        ; Tippy("Overflow", 600)
        CurrentWinF7 := WindowGroupF7.MinIndex()
    }

    ;Now activate the window based on CurrentWin.
    WinActivate, % "ahk_id" WindowGroupF7[CurrentWinF7]

    return
}

;Activate previous window.
PrevWindowF7() {

    ;See this link for picture explanation, it's just backwards: https://imgur.com/1Mc5B24
    if (activeWindowID = WindowGroupF7[CurrentWinF7 - 1]) {
        CurrentWinF7 -= 2
    } else {
        CurrentWinF7--
    }

    if (CurrentWinF7 < WindowGroupF7.MinIndex())
        CurrentWinF7 := WindowGroupF7.MaxIndex()
    ;Now activate that window based on CurrentWin.
    WinActivate, % "ahk_id" WindowGroupF7[CurrentWinF7]
    return
}

RemoveNonexistentWindowsF7() {
    ;Loop through the F7 ID array.
    for indexF7, value in WindowGroupF7
    {
        ;If the window with the ID of "value" at the current index doesn't exist...
        if !WinExist("ahk_id" value)
        {
            ;Remove it from the array.
            WindowGroupF7.RemoveAt(indexF7)
        }
    }
    return

}
*/