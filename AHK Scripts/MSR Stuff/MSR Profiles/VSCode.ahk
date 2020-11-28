;This script is the VSCode profile.

;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile = "VSCode"
;Mouse G1
;"Holds" down Shift for scrolling horizontally.
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2
;(Ctrl + Tab) Jump to the Next Open Tab.
F14::Send, ^{Tab}

;Mouse G3
F15::
return

;Mouse G4
F16::
return

;Mouse G5
;Go one tab to the right
F17::Send, ^{PGDN}

;Mouse G6
F18::
return

;Mouse G7
;Close VSCode tab.
F19::Send, ^w

;Mouse G8
;Go one tab to the left.
F20::Send, ^{PGUP}

;Mouse G9
;(Ctrl + /) Comment Out Line.
F21::Send, ^/

; ;Mouse G10
; ;(Ctrl + Shift + K) Delete line.
; F22::
; Send, ^+k
; return

;Mouse G10: Alt + Tab
F22::Send, !{Tab}

;Mouse G11
;Pushing F23 (G11) minimizes the current active window.
F23::WinMinimize, A

;Mouse G12
;Reopen the last closed VSCode tab (file), and jump to it.
+F23::Send, ^+t

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
; Comment out line in VSCode.
^F13::Send, ^/

;Keeb G2
;(Ctrl + Shift + K) Delete line
^F14::Send, ^+k

;Keeb G3
;(Ctrl + Shift + [) Fold (collapse) region.
^F15::Send, ^+[

;Keeb G4
;(Ctrl + Shift + \) Jump to matching bracket.
^F16::
return

;Keeb G5
;(Ctrl + Tab) For switching between VSCode tabs.
^F17::Send, ^{Tab}

;Keeb G6
;(Ctrl + Shift + ]) Unfold (uncollapse) region.
^F18::Send, ^+]

;Keeb G7
^F19::
return

;Keeb G8
;Ctrl + Page Up (Go one Tab to the Left)
^F20::Send, ^{PGUP}

;Keeb G9
;Ctrl + Page Down (Go one Tab to the Right)
^F21::Send, ^{PGDN}

;Keeb G10
;(Ctrl + Alt + K) Toggle bookmark on the current line.
^F22::Send, ^!k

;Keeb G11
;(Ctrl + J) Jump to previous Bookmark.
^F23::Send, ^j

;Keeb G12
;(Ctrl + L) Jump to next Bookmark.
!F23::Send, ^l

;Keeb G13
;Closes a virtual desktop
!F13::Send, ^#{F4}

;Keeb G14
;Creates a virtual desktop
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