;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "Discord"
    ;Mouse G1
;Horizontal scroll
F13::
    Send, {Shift down}
    KeyWait, F13
    Send, {Shift up}
return

;Mouse G2
F14::
return

;Mouse G3
F15::
return

;Mouse G4: Up in the server list
F16::Send, ^!{Up}

;Mouse G5: Up in the channels list
F17::Send, !{Up}

;Mouse G6: Navigate up in unread text channels
F18::Send, !+{Up}

;Mouse G7: Down in the server list
F19::Send, ^!{Down}

;Mouse G8: Down in the channels list
F20::Send, !{Down}

;Mouse G9: Navigate down in unread text channels
F21::Send, !+{Down}

;Mouse G10: Alt + Tab
F22::Send, !{Tab}

;Mouse G11: minimize the current active window
F23::WinMinimize, A

;Mouse G12
+F23::
return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1: Mark server as read
^F13::Send, +{Esc}

;Keeb G2: Mark channel as read
^F14::Send, {Esc}

;Keeb G3: Toggle between last server and DMs
^F15::Send, ^!{Right}

;Keeb G4
^F16::
return

;Keeb G5
^F17::
return

;Keeb G6
^F18::
return

;Keeb G7: Up in the server list
^F19::Send, ^!{Up}

;Keeb G8: Up in the channels list
^F20::Send, !{Up}

;Keeb G9: Navigate up in unread text channels
^F21::Send, !+{Up}

;Keeb G10: Down in the server list
^F22::Send, ^!{Down}

;Keeb G11: Down in the channels list
^F23::Send, !{Down}

;Keeb G12: Navigate down in unread text channels
!F23::Send, !+{Down}

;Keeb G13: Closes a virtual desktop
!F13::Send, ^#{F4}

;Keeb G14: Creates a virtual desktop
!F14::Send, ^#{d}

;Keeb G15: Meaning + Enter (for defining words on Google)
!F15::Send, {Space}meaning{Enter}

;Keeb G16: Does what Win + Tab does
!F16::Send, #{Tab}

!F17::return
!F18::return

#If
