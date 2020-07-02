;This script is the VSCode profile.

;****************************************MOUSE ACTIONS***************************************
#If currentProfile = "VSCode"
;Mouse Profile Switch
;Left double click (front button on top of mouse).
^!F23::
Send, {Click 2}
return

;Mouse DPI Toggle (back button on top of mouse).
^+F23::
return

;Mouse G1
;"Holds" down Shift for scroling horizontally.
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
F16::
return

;Mouse G5
;Go one tab to the right
F17::
Send, ^{PGDN}
return

;Mouse G6
F18::
return

;Mouse G7
;Close VSCode tab.
F19::
Send, ^w
return

;Mouse G8
;Go one tab to the left.
F20::
Send, ^{PGUP}
return

;Mouse G9
;(Ctrl + /) Comment Out Line.
F21::
Send, ^/
return

;Mouse G10
;(Ctrl + Shift + K) Delete line.
F22::
Send, ^+k
return

;Mouse G11
;Pushing F23 (G11) minimizes the current active window.
F23::
WinMinimize, A
return

;Mouse G12
;Reopen the last closed VSCode tab (file), and jump to it.
+F23::
Send, ^+t
return

;****************************************KEYBOARD ACTIONS***************************************
;Keeb G1
; Comment out line in VSCode.
^F13::
Send, ^/
return

;Keeb G2
;(Ctrl + Shift + K) Delete line
^F14::
Send, ^+k
return

;Keeb G3
;(Ctrl + Shift + [) Fold (collapse) region.
^F15::
Send, ^+[
return

;Keeb G4
;(Ctrl + Shift + \) Jump to matching bracket.
^F16::
return

;Keeb G5
;(Ctrl + Tab) For switching between VSCode tabs.
^F17::
Send, ^{Tab}
return

;Keeb G6
;(Ctrl + Shift + ]) Unfold (uncollapse) region.
^F18::
Send, ^+]
return

;Keeb G7
^F19::
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

;Keeb G10
;(Ctrl + Alt + K) Toggle bookmark on the current line.
^F22::
Send, ^!k
return

;Keeb G11
;(Ctrl + J) Jump to previous Bookmark.
^F23::
Send, ^j
return

;Keeb G12
;(Ctrl + L) Jump to next Bookmark.
!F23::
Send, ^l
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
!F15::
return

;Keeb G16
;Does what Win + Tab does.
!F16::
Send, #{Tab}
return

;Keeb G17
;Goes to the virtual desktop to the left.
!F17::
Send, ^#{Left}
return

;Keeb G18
;Goes to the virtual desktop to the right.
!F18::
Send, ^#{Right}
return

#If