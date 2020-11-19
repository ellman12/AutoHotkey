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
        GroupAdd, firefoxWins, ahk_class MozillaWindowClass
        WinActivate ahk_class MozillaWindowClass
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

;Opens a new Firefox window with Google.
#F1::
#F2::
Run, C:\Program Files\Mozilla Firefox\firefox.exe "google.com"
return

;Opens a new Chrome window with Google.
#F3::
#F4::
Run, chrome.exe "google.com"
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
        GroupAdd, firefoxWins, ahk_class MozillaWindowClass
        if WinActive("ahk_class MozillaWindowClass")
            GroupActivate, firefoxWins, R
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
F3Hotkey() {
global
    if (F3Behavior = "Google Chrome") {

        IfWinNotExist, ahk_exe chrome.exe
            Run, chrome.exe
        if WinActive("ahk_exe chrome.exe")
            Send ^{PGDN}
        else
            WinActivate ahk_exe chrome.exe

    } else if (F3Behavior = "VSCode") {

        IfWinNotExist, ahk_exe Code.exe
            Run, C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe
        if WinActive("ahk_exe Code.exe")
            Send ^{PGDN}
        else
            WinActivate ahk_exe Code.exe
    } else {
        MsgBox, 262160, F3 Hotkey Error, Undefined F3 Behavior.
    }
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

    IfWinNotExist, ahk_exe Code.exe
        Run, C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe
    if WinActive("ahk_exe Code.exe")
        Send ^{PGUP}
    else
        WinActivate ahk_exe Code.exe
} else {
        MsgBox, 262160, F3 Hotkey Error, Undefined F3 Behavior.
}
return

;If a window doesn't exist, run the program.
;If windows do exist, switch between them.
F4::
F4Hotkey() {
global
    if (F3Behavior = "Google Chrome") {
        Process, Exist, chrome.exe
        if errorLevel = 0
            Run, chrome.exe
        else {
            GroupAdd, chromeWins, ahk_class Chrome_WidgetWin_1
            if WinActive("ahk_class ahk_class Chrome_WidgetWin_1")
                GroupActivate, chromeWins, R
            else
                WinActivate ahk_class Chrome_WidgetWin_1
        }
    } else if (F3Behavior = "VSCode") {

        If WinNotExist, Code.exe
            Run, C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe
        else
        {
            GroupAdd, codeWins, ahk_exe Code.exe
            if WinActive("ahk_exe Code.exe")
                GroupActivate, codeWins, R
            else
                WinActivate ahk_exe Code.exe
        }
    } else {
        MsgBox, 262160, F4 Hotkey Error, Undefined F4 Behavior.
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
return

;Creates a new File Explorer window.
;Activated by holding down Shift and MR (Shift + Ctrl + F5).
^+F5::Run, explorer.exe

;Back button; does stuff in reverse.
;Ex. F9 in Firefox does the opposite of F1.
F9::
F9Hotkey() {
    if WinActive("ahk_exe firefox.exe")
        Send ^{PgUp}
    else if WinActive("ahk_class Chrome_WidgetWin_1")
        Send ^+{tab}
    else if WinActive("ahk_exe explorer.exe")
        Send !{left} ;alt left is the explorer shortcut to go "back" or "down" one folder level.
}
return

;Behavior is determined in #o.
;Mode				                  What It Does
;VSCode and Cmd Prompt (Default)	  Groups VSCode and Command Prompt windows together. ^F12 runs VSCode.
;Word				                  Runs Word and switches between Word windows.
;Excel				                  Runs Excel and switches between Excel windows.
;Word + Excel		                  Groups Word and Excel windows.
F12::
F12Hotkey() {
global
    Switch (F12Behavior) {

    Case "VSCode and Cmd Prompt":
    if WinExist("ahk_exe Code.exe")
        GroupAdd, VSCodeAndTerminalWins, ahk_exe Code.exe
    else
        Run, C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe

    if WinExist("ahk_exe cmd.exe")
        GroupAdd, VSCodeAndTerminalWins, ahk_exe cmd.exe
    else {
        Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Command Prompt
        Sleep 1000
        WinMaximize, Command Prompt
        WinActivate, Command Prompt
    }

    GroupActivate, VSCodeAndTerminalWins, R
    return

    Case "Word":
    if WinExist("ahk_exe WINWORD.exe") {
        GroupAdd, wordWins, ahk_exe WINWORD.exe
        if WinActive("ahk_exe WINWORD.exe")
            GroupActivate, wordWins, R
        else
            WinActivate, ahk_exe WINWORD.exe
    } else {
        Run, C:\Program Files\Microsoft Office\root\Office16\WINWORD.exe
    }
    return

    Case "Excel":
    if WinExist("ahk_exe Excel.exe") {
        GroupAdd, excelWins, ahk_exe Excel.exe
        if WinActive("ahk_exe Excel.exe")
            GroupActivate, excelWins, R
        else
            WinActivate ahk_exe Excel.exe
    } else {
        Run, C:\Program Files\Microsoft Office\root\Office16\Excel.exe
    }
    return

    Case "Word + Excel":
    if WinExist("ahk_exe WINWORD.exe")
        GroupAdd, wordAndExcelWins, ahk_exe WINWORD.exe
    else
        Run, C:\Program Files\Microsoft Office\root\Office16\WINWORD.exe

    if WinExist("ahk_exe Excel.exe")
        GroupAdd, wordAndExcelWins, ahk_exe Excel.exe
    else
        Run, C:\Program Files\Microsoft Office\root\Office16\Excel.exe
    GroupActivate, wordAndExcelWins, R
    return

    Case "Outlook":
    if WinExist("ahk_exe Outlook.exe") {
        GroupAdd, outlookWins, ahk_exe Outlook.exe
        if WinActive("ahk_exe Outlook.exe")
            GroupActivate, outlookWins, R
        else
            WinActivate, ahk_exe Outlook.exe
    } else {
        Run, C:\Program Files\Microsoft Office\root\Office16\Outlook.exe
    }
    return

    Default:
    MsgBox, 262160, F12 Hotkey Error, Undefined F12 Behavior
    return

    }
}
return ;End of F12.

;*******************HOTKEYS FOR MICROSOFT TO DO APP*******************
; #t:: In the Tasks menu, add a task and mark it due today. Or activate To Do. Or run To Do.

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
    Run, C:\Users\%A_UserName%\Documents\Microsoft To Do ;Shortcut in Documents.
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