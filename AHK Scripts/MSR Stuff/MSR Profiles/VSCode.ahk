;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "VSCode"
;Mouse G1
;Horizontal scroll
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

;Mouse G4
F16::
return

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
;Keeb G1
^F13::return

;Keeb G2: delete line
^F14::Send, ^+k

;Keeb G3: Fold region
^F15::Send, ^+[

;Keeb G4: jump to matching bracket.
^F16::
return

;Keeb G5
^F17::return

;Keeb G6: Unfold region.
^F18::Send, ^+]

;Keeb G7
^F19::
return

;Keeb G8
^F20::

;Keeb G9
^F21::

;Keeb G10
;(Ctrl + Alt + K) Toggle bookmark on the current line.
^F22::Send, ^!k

;Keeb G11
;(Ctrl + J) Jump to previous Bookmark.
^F23::Send, ^j

;Keeb G12
;(Ctrl + L) Jump to next Bookmark.
!F23::Send, ^l

;Keeb G13: Closes a virtual desktop
!F13::Send, ^#{F4}

;Keeb G14: Creates a virtual desktop
!F14::Send, ^#{d}

;Keeb G15
!F15::
return

;Keeb G16
;Does what Win + Tab does.
!F16::Send, #{Tab}

;Keeb G17
;Goes to the virtual desktop to the left.
!F17::Send, ^#{Left}

;Keeb G18
;Goes to the virtual desktop to the right.
!F18::Send, ^#{Right}

#If