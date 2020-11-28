;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "Excel"
;Mouse G1
;Horizontal scroll
F13 & WheelUp::Send, {WheelLeft}
F13 & WheelDown::Send, {WheelRight}

;Mouse G2
F14::
return

;Mouse G3
F15::
return

;Mouse G4: new sheet
F16::Send, +{F11}

;Mouse G5: sheet to the right
F17::Send, ^{PGDN}

;Mouse G6
F18::
return

;Mouse G7
F19::
return

;Mouse G8: sheet to the left
F20::Send, ^{PGUP}

;Mouse G9
F21::
return

;Mouse G10: Alt + Tab.
F22::Send, !{Tab}

;Mouse G11: minimize the current active window
F23::WinMinimize, A

;Mouse G12
+F23::
return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
^F13::
return

;Keeb G2
^F14::
return

;Keeb G3
^F15::
return

;Keeb G4
^F16::
return

;Keeb G5
^F17::
return

;Keeb G6
^F18::
return

;Keeb G7
^F19::
return

;Keeb G8
^F20::
return

;Keeb G9
^F21::
return

;Keeb G10
^F22::
return

;Keeb G11
^F23::
return

;Keeb G12
!F23::
return

;Keeb G13
;Closes a virtual desktop.
!F13::Send, ^#{F4}

;Keeb G14
;Creates a virtual desktop.
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

;****************************************MISC EXCEL ACTIONS***************************************
$F2::Send, {F2} ;Edit cell contents.
F5::Send, ^s ;Save document.

#If