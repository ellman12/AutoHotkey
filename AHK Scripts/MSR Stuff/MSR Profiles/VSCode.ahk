;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "VSCode"
;Mouse G1: horizontal scroll
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2: Ctrl Tab
F14::Send, ^{Tab}

;Mouse G3
F15::return

;Mouse G4
F16::return

;Mouse G5: tab to the right
F17::Send, ^{PGDN}

;Mouse G6: delete line(s)
F18::Send, ^+k

;Mouse G7: close tab
F19::Send, ^w

;Mouse G8: tab to the left
F20::Send, ^{PGUP}

;Mouse G9: comment out line
F21::Send, ^/

;Mouse G10: Alt + Tab
F22::Send, !{Tab}

;Mouse G11: minimize the current active window
F23::WinMinimize, A

;Mouse G12: reopen the last closed VSCode tab (file), and jump to it.
+F23::Send, ^+t

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1: jump to matching bracket
^F13::Send, ^+\

;Keeb G2: comment out line
^F14::Send, ^/

;Keeb G3: delete line
^F15::Send, ^+k

;Keeb G4: Toggle bookmark on the current line
^F16::Send, ^!k

;Keeb G5: previous bookmark
^F17::Send, !p

;Keeb G6: next bookmark
^F18::Send, !n

;Keeb G7: Copy line up
^F19::Send, +!{Up}

;Keeb G8: Add cursor above
^F20::Send, ^!{Up}

;Keeb G9: Move line up
^F21::Send, !{Up}

;Keeb G10: copy line down
^F22::Send, +!{Down}

;Keeb G11: add cursor below
^F23::Send, ^!{Down}

;Keeb G12: Move line down
!F23::Send, !{Down}

;Keeb G13: toggle fold
!F13::Send, ^#l

;Keeb G14: outdent lines
!F14::Send, ^[

;Keeb G15: indent lines
!F15::Send, ^]

;Keeb G16: Win + Tab
!F16::Send, #{Tab}

;Keeb G17: virtual desktop to the left.
!F17::Send, ^#{Left}

;Keeb G18: virtual desktop to the right.
!F18::Send, ^#{Right}

#If