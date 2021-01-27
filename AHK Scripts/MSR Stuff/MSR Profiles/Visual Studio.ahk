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
F17::Send, ^{PGDN}

;Mouse G6
F18::return

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

;Mouse G12
+F23::return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1: Run Without Debugging
^F13::
Suspend, On
Send, ^{F5}
Suspend, Off
return

;Keeb G2: Restart Debugging
^F14::
Suspend, On ;Avoid AHK hotkey overlap
Send, ^+{F5}
Suspend, Off
return

;Keeb G3: Run With Debugging
^F15::Send, {F5}

;Keeb G4
^F16::
return

;Keeb G5
^F17::
return

;Keeb G6: Stop Program
^F18::Send, +{F5}

;Keeb G7
^F19::
return

;Keeb G8
^F20::
return

;Keeb G9: C# Print
^F21::Send, Console.WriteLine("");{Left 3}

;Keeb G10: Toggle bookmark on the current line.
^F22::Send, ^k^k

;Keeb G11: Previous bookmark
^F23::Send, ^k^p

;Keeb G12: Next bookmark
!F23::Send, ^k^n

;Keeb G13
!F13::
return

;Keeb G14
!F14::
return

;Keeb G15
!F15::
return

;Keeb G16
!F16::
return

;Keeb G17
!F17::
return

;Keeb G18
!F18::
return

;****************************************MISC VS ACTIONS***************************************
^/::Send, ^k^/{Home}

#If