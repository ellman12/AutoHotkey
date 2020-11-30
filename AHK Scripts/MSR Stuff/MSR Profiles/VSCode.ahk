;****************************************SCIMITAR RGB ACTIONS***************************************
;Actions regardless of open file type.
#If currentProfile == "Generic VSCode" OR currentProfile == "AutoHotkey VSCode" OR currentProfile == "C VSCode" OR currentProfile == "Python VSCode"
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
;Keeb G1: Single tap for Git Push; double tap for Git Pull.
^F13::
if ((A_ThisHotkey = A_PriorHotkey) AND (A_TimeSincePriorHotkey < 250))
	numOfTaps++
else ;If no extra taps.
	numOfTaps = 1

SetTimer, determineNumOfTapsVSCodeG1, 250
return

determineNumOfTapsVSCodeG1:
SetTimer, determineNumOfTapsVSCodeG1, Off

if (numOfTaps == 1)
    Send, ^{Enter}
else if (numOfTaps == 2)
{
    Send, ^!p
    Tippy("Git Push", 900)
}
else if (numOfTaps == 3)
{
    Send, ^!p
    Tippy("Git Pull", 900)
}
return

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

;Keeb G8: Move line up
^F20::Send, !{Up}

;Keeb G9: Print functions for different languages
^F21::
switch (currentProfile) {
    case "AutoHotkey VSCode":Send, MsgBox`,{Space}
    case "C VSCode":Send, printf("");{Left 3}
    case "Python VSCode":Send, print(""){Left 2}
    default:MsgBox, 262160, Unknown VSCode Sub Profile, This current language is not defined for this hotkey.
}
return

^F22::Send, +!{Down} ;Keeb G10: Copy line down
^F23::Send, !{Down} ;Keeb G11: Move line down

;Keeb G12: Input functions for different languages
!F23::
switch (currentProfile) {
    case "AutoHotkey VSCode":Send, InputBox`,{Space}
    case "C VSCode":Send, scanf("`%");{Left 3}
    case "Python VSCode":Send, input(""){Left 2}
    default:MsgBox, 262160, Unknown VSCode Sub Profile, This current language is not defined for this hotkey.
}
return

;Keeb G13: toggle fold
!F13::Send, ^#l

;Keeb G14: outdent lines
!F14::Send, ^[

;Keeb G15: indent lines
!F15::Send, ^]

;Keeb G16: Jump to either the next bracket or matching bracket
!F16::Send, ^+\

;Keeb G17: virtual desktop to the left.
!F17::Send, ^#{Left}

;Keeb G18: virtual desktop to the right.
!F18::Send, ^#{Right}

#If