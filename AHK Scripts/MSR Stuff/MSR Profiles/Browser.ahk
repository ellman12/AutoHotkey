;This script is for both Firefox and Chrome.
;Since they're so similar, I just decided to combine them into one file.
;If an action is specific to only one browser, I will accommodate for that.

;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "Firefox" or currentProfile == "Chrome"
;Mouse G1: Horizontal scroll
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2: Ctrl Tab
F14::Send, ^{Tab}

;Mouse G3
F15::
return

;Mouse G4: Open new tab.
F16::Send, ^t

;Mouse G5: Go one tab to the right.
F17::Send, ^{PGDN}

;Mouse G6: Next page in History.
F18::Send, !{Right}

;Mouse G7: Close tab.
F19::Gosub, $^w

;Mouse G8: Go one tab to the left.
F20::Send, ^{PGUP}

;Mouse G9: Previous page in History.
F21::Send, !{Left}

;Mouse G10: Alt + Tab
F22::Send, !{Tab}

;Mouse G11: minimize the current active window
F23::WinMinimize, A

;Mouse G12: Reopen the last closed Browser tab, and jump to it.
+F23::Send, ^+t

;****************************************K95 RGB ACTIONS***************************************
;Keeb G2
;Reopen the last closed tab, and jump to it
^F14::Send, ^+t

;Keeb G3: show/hide bookmarks bar
^F15::Send, ^+b

;Keeb G5
;Pin/unpin tab(s).
^F17::
if WinActive("ahk_exe firefox.exe") {
    Send, !d
    Sleep 100
    Send, +{Tab 3}
    Sleep 100
    Send, {AppsKey}
    Sleep 100
    Send, p
} else if WinActive("ahk_exe chrome.exe") {
    Suspend, On ;So my F6 hotkey doesn't get triggered.
    Sleep 2000
    Send, {F6 2}
    Sleep 2000
    Send, {AppsKey}
    Sleep 2000
    Send, p
    Suspend, Off
}
return

;Keeb G6
;Automatic Google Lookup
^F18::
Send, ^c
Sleep 80
Send, ^t
Send, ^v{Enter}
return

;Keeb G7
;Open New Tab with Google
^F19::
Send, ^t
Send, google.com{Enter}
return

;Keeb G8
;Ctrl + Page Up (Go one Tab to the Left)
^F20::Send, ^{PGUP}

;Keeb G9
;Ctrl + Page Down (Go one Tab to the Right)
^F21::Send, ^{PGDN}

;Keeb G11
;Close browser tab
^F23::Send, ^w

;Keeb G12
;New browser tab
!F23::Send, ^t

;Keeb G13: Closes a virtual desktop
!F13::Send, ^#{F4}

;Keeb G14: Creates a virtual desktop
!F14::Send, ^#{d}

;Keeb G15
;Meaning + Enter (for defining words on Google)
!F15::Send, {Space}meaning{Enter}

;Keeb G16: Does what Win + Tab does
!F16::Send, #{Tab}

!F17::return
!F18::return

#If currentProfile == "Firefox"
;Keeb G1: Close multiple tabs.
;This relies on a Firefox extension for this. Find it here: https://addons.mozilla.org/en-US/firefox/addon/close-tabs-shortcuts/
; ^F13::Send, +!{F2} ;If no modifiers, close tabs to the right.
; ^+F13::Send, +!{F1} ;If Shift pressed, close tabs to the left.
; ^!F13::Send, +!{F3} ;If Alt pressed, close other tabs. This was changed by me from its default shortcut.

;https://autohotkey.com/board/topic/28635-triple-click/?p=183227
;Keeb G1: Close tabs to the right. Double tap = tabs to the left. Triple tap = other tabs.
^F13::
if ((A_ThisHotkey = A_PriorHotkey) AND (A_TimeSincePriorHotkey < 250))
	numOfTaps++
else ;If no extra taps.
	numOfTaps = 1

SetTimer, determineNumOfTapsBrowserG1, 250
return

determineNumOfTapsBrowserG1:
SetTimer, determineNumOfTapsBrowserG1, Off

if (numOfTaps == 1)
{
    Send, +!{F2} ;Close tabs to the right.
    Tippy("Close tabs to the right", 900)
}
else if (numOfTaps == 2)
{
    Send, +!{F1} ;Close tabs to the left.
    Tippy("Close tabs to the left", 900)
}
else if (numOfTaps == 3)
{
    Send, +!{F3} ;Close other tabs. This was changed by me from its default shortcut.
    Tippy("Close other tabs", 900)
}
return

; ;Keeb G3: show/hide bookmarks bar. https://support.mozilla.org/en-US/questions/800789
; ^F15::
; Send, !v
; Sleep 30
; Send, t
; Sleep 30
; Send, b
; Sleep 30
; return

;Keeb G4: Open Incognito Window and goes to Google (Firefox)
^F16::
Send, ^+p
Sleep 500
Send, google.com{Enter}
Send, #{Up}
return

;Keeb G10 (Firefox)
;Automatic Google Lookup in Incognito (Firefox)
^F22::
Send, ^c
Sleep 80
Send, ^+p
Sleep 200
Send, ^v{Enter}
return

#If currentProfile == "Chrome"
; ;Keeb G3: show/hide bookmarks bar
; ^F15::Send, ^+b

;Keeb G4 (Chrome)
;Open Incognito Window and goes to Google (Chrome)
^F16::
Send, ^+n
Sleep 500
Send, google.com{Enter}
Send, #{Up}
return

;Keeb G10 (Chrome)
;Automatic Google Lookup in Incognito (Chrome)
^F22::
Send, ^c
Sleep 80
Send, ^+n
Sleep 200
Send, ^v{Enter}
return

#If