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

;Switch to a window and go through tabs.
F3::
if (F3Behavior = "Google Chrome") {

    IfWinNotExist, ahk_exe chrome.exe
        Run, chrome.exe
    if WinActive("ahk_exe chrome.exe")
        Send ^{PGDN}
    else
        WinActivate ahk_exe chrome.exe

} else if (F3Behavior = "VSCode") {

    IfWinNotExist, ahk_exe chrome.exe
        Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code\Code.exe
    if WinActive("ahk_exe Code.exe")
        Send ^{PGDN}
    else
        WinActivate ahk_exe Code.exe
}
return

;Same thing as F3, but reverse order (PGUP instead of PGDN).
+F3::
    if (F3Behavior = "Google Chrome") {

    IfWinNotExist, ahk_class Chrome_WidgetWin_1
        Run, chrome.exe
    if WinActive("ahk_exe chrome.exe")
        Send ^{PGUP}
    else
        WinActivate ahk_exe chrome.exe

} else if (F3Behavior = "VSCode") {

    IfWinNotExist, ahk_class Chrome_WidgetWin_1
        Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code\Code.exe
    if WinActive("ahk_exe Code.exe")
        Send ^{PGUP}
    else
        WinActivate ahk_exe Code.exe
}
return

;If a window doesn't exist, run the program.
;If windows do exist, switch between them.
F4::
    if (F3Behavior = "Google Chrome") {
        Process, Exist, chrome.exe
        if errorLevel = 0
            Run, chrome.exe
        else {
            GroupAdd, taranchromes, ahk_class Chrome_WidgetWin_1
            if WinActive("ahk_class ahk_class Chrome_WidgetWin_1")
                GroupActivate, taranchromes, r
            else
                WinActivate ahk_class Chrome_WidgetWin_1
        }
    } else if (F3Behavior = "VSCode") {
        If errorLevel = 0
            Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code\Code.exe
        else {
            GroupAdd, taranCodes, ahk_exe Code.exe
            if WinActive("ahk_exe Code.exe")
                GroupActivate, taranCodes, r
            else
                WinActivate ahk_exe Code.exe
        }
    }
return

;Create a new normal Chrome window.
^F3::
^F4::
Run, chrome.exe
return

;Create a new incognito Chrome window.
!F3::Run, chrome.exe -incognito

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