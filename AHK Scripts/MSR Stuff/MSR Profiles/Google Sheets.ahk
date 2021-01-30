;****************************************SCIMITAR RGB ACTIONS***************************************

#If currentProfile == "Sheets"
    ;Mouse G1
;For scrolling horizontally
F13 & WheelUp:: ; Scroll left.
    ControlGetFocus, fcontrol, A
    SendMessage, 0x114, 0, 0, %fcontrol%, A ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.
return

F13 & WheelDown:: ; Scroll right.
    ControlGetFocus, fcontrol, A
    SendMessage, 0x114, 1, 0, %fcontrol%, A ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINERIGHT.
return

;Mouse G2
;(Ctrl + Tab) Jump to the Next Open Tab
F14::
    Send, ^{Tab}
return

;Mouse G3
F15::
return

;Mouse G4
;New browser tab
F16::
    Send, ^t
return

;Mouse G5
;Go one tab to the right
F17::
    Send, ^{PGDN}
return

;Mouse G6
;Next page in History
F18::
    Send, !{Right}
return

;Mouse G7: Close browser tab
F19::Gosub, $^w

;Mouse G8
;Go one tab to the left
F20::
    Send, ^{PGUP}
return

;Mouse G9
;Previous page in History
F21::
    Send, !{Left}
return

;Mouse G10
;Previous sheet
F22::
    Send, ^+{PGUP}
return

;Mouse G11
;Next sheet
F23::
    Send, ^+{PGDN}
return

;Mouse G12
;Reopen the last closed tab, and jump to it
+F23::
    Send, ^+t
return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
;Open delete menu
^F13::Send, ^!-

;Keeb G2
;Reopen the last closed tab, and jump to it
^F14::Send, ^+t

;Keeb G3
^F15::
return

;Keeb G4
;Open Incognito Window and goes to Google
^F16::
    if InStr(activeWindowTitle, "Mozilla Firefox") {
        Send, ^+p
        Sleep 500
        Send, google.com{Enter}
        Send, #{Up}
        return
    } else if InStr(activeWindowTitle, "Google Chrome") {
        Send, ^+n
        Sleep 500
        Send, google.com{Enter}
        Send, #{Up}
        return
    }
return

;Keeb G5
;Paste without formatting
^F17::Send, ^+v

;Keeb G6
;Automatic Google Lookup
^F18::
    Send, ^c
    Sleep 80
    Send, ^t
    Send, ^v{Enter}
return

;Keeb G7
;Open insert menu
^F19::Send, ^!=

;Keeb G8
;Ctrl + Page Up (Go one Tab to the Left)
^F20::Send, ^{PGUP}

;Keeb G9
;Ctrl + Page Down (Go one Tab to the Right)
^F21::Send, ^{PGDN}

;Keeb G10
;Automatic Google Lookup in Incognito
^F22::
    if InStr(activeWindowTitle, "Mozilla Firefox") {
        Send, ^c
        Sleep 80
        Send, ^+p
        Sleep 200
        Send, ^v{Enter}
        return
    } else if InStr(activeWindowTitle, "Google Chrome") {
        Send, ^c
        Sleep 80
        Send, ^+n
        Sleep 200
        Send, ^v{Enter}
        return
    }
return

;Keeb G11
;Search the menus in Docs and Sheets
^F23::Send, !/

;Keeb G12
;New browser tab
!F23::Send, ^t

;Keeb G13
!F13::
return

;Keeb G14
;Previous sheet
!F14::Send, ^+{PGUP}

;Keeb G15
;Next sheet
!F15::Send, ^+{PGDN}

;Keeb G16: Does what Win + Tab does
!F16::Send, #{Tab}

!F17::return
!F18::return

#If