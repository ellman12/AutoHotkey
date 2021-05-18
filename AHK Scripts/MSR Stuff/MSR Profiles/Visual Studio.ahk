;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "Visual Studio"
;Mouse G1
;Horizontal scroll
F13 & WheelUp::Send, {WheelLeft}
F13 & WheelDown::Send, {WheelRight}

;Mouse G2: Ctrl Tab
F14::Send, ^{Tab}

;Mouse G3
F15::return

;Mouse G4
F16::return

;Mouse G5: tab to the right
F17::Send, ^!{PGDN}

;Mouse G6
F18::return

;Mouse G7: close tab
F19::Gosub, $^w

;Mouse G8: tab to the left
F20::Send, ^!{PGUP}

;Mouse G9: comment out line
F21::Send, ^/

;Mouse G10: Alt + Tab
F22::Send, !{Tab}

;Mouse G11: minimize the current active window
F23::WinMinimize, A

;Mouse G12
+F23::return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1: Next Bookmark
^F13::Send, !n

;Keeb G2: comment out line
^F14::Send, ^/

;Keeb G3: delete line
^F15::Send, ^+k

;Keeb G4: Previous bookmark
^F16::Send, !p

;Keyboard G5: Ctrl Tab
^F17::Send, ^{Tab}

;Keeb G6: Format code
^F18::Send, !+f

;Keeb G7: Copy line up
^F19::Send, +!{Up}

;Keeb G8: Move line up
^F20::Send, !{Up}

;Keeb G9: C# Print
^F21::Send, Console.WriteLine("");{Left 3}

^F22::Send, +!{Down} ;Keeb G10: Copy line down
^F23::Send, !{Down} ;Keeb G11: Move line down

;Keeb G12
!F23::return

;Keeb G13: Add {}, format, and add newline before line
!F13::
Send, {End}+{Home}
SendRaw, {
Send, !+f

Sleep 100
Send, {End}{Up}{End}{Enter} ;Add new line after {
return

+!F13:: ;Same thing but new line after
Send, {End}+{Home}
SendRaw, {
Send, !+f

Sleep 100
Send, {End}{End}{Enter} ;Add new line before }
return

;Keeb G14: outdent lines
!F14::Send, ^[

;Keeb G15: indent lines
!F15::Send, ^]

;Keeb G16: Jump to either the next bracket or matching bracket
!F16::Send, ^+\

;Comment out block
!F17::Send, !+{Right 4}^/

;Clear line
!F18::Send, {Home}+{End}{Delete}
#If