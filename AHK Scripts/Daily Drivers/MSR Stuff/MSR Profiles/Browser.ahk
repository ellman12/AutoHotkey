/*
;This script is for both Firefox and Chrome.
;Since they're so similar, I just decided to combine them into one file.
;If an action is specific to only one browser, I will accommodate for that.
;The Docs and Sheets profiles are like this, too.
*/

;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile = "Firefox" or currentProfile = "Chrome"
;Mouse G1
;"Holds" down Shift for scrolling horizontally.
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2
;(Ctrl + Tab) Jump to the Next Open Tab.
F14::
Send, ^{Tab}
return

;Mouse G3
;While G3 is held, make the mouse pointer faster.
;When it's not being held, it's normal speed.
*F15::
;IDK how these things work, but the 17 and 10 are the mouse speeds.
;Found this stuff online somewhere.
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, F15
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;Mouse G4
;Open new tab.
F16::
Send, ^t
return

;Mouse G5
;Go one tab to the right.
F17::
Send, ^{PGDN}
return

;Mouse G6
;Next page in History.
F18::
Send, !{Right}
return

;Mouse G7
;Close tab.
F19::
Send, ^w
return

;Mouse G8
;Go one tab to the left.
F20::
Send, ^{PGUP}
return

;Mouse G9
;Previous page in History.
F21::
Send, !{Left}
return

;Mouse G10: Alt + Tab
F22::
Send, !{Tab}
return

;Mouse G11
;Pushing F23 (G11) minimizes the current active window.
F23::WinMinimize, A

;Mouse G12
;Reopen the last closed Browser tab, and jump to it.
+F23::
Send, ^+t
return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
^F13::
return

;Keeb G2
;Reopen the last closed tab, and jump to it
^F14::
Send, ^+t
return

;Keeb G3
;Improved Sleep Macro + Manual Enter
^F15::
Send, #x
Sleep, 250
Send, {Up 2}
Send, {Right}
Send, {Down}
return

;Keeb G5
;Pin/unpin Firefox tabs.
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
^F20::
Send, ^{PGUP}
return

;Keeb G9
;Ctrl + Page Down (Go one Tab to the Right)
^F21::
Send, ^{PGDN}
return

;Keeb G11
;Close browser tab
^F23::
Send, ^w
return

;Keeb G12
;Open browser tab
!F23::
Send, ^t
return

;Keeb G13
;Closes a virtual desktop
!F13::
Send, ^#{F4}
return

;Keeb G14
;Creates a virtual desktop
!F14::
Send, ^#{d}
return

;Keeb G15
;Meaning + Enter (for defining words on Google)
!F15::
Send, {Space}meaning{Enter}
return

;Keeb G16
;Does what Win + Tab does
!F16::
Send, #{Tab}
return

;Keeb G17
;Goes to the virtual desktop to the left
!F17::
Send, ^#{Left}
return

;Keeb G18
;Goes to the virtual desktop to the right
!F18::
Send, ^#{Right}
return

#If currentProfile = "Firefox"

;Keeb G4
;Open Incognito Window and goes to Google (Firefox)
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

#If currentProfile = "Chrome"

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