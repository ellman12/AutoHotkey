;****************************************SCIMITAR RGB ACTIONS***************************************
;Actions regardless of open file type.
#If currentProfile == "Generic VSCode" OR currentProfile == "AutoHotkey VSCode" OR currentProfile == "C VSCode" OR currentProfile == "C++ VSCode" OR currentProfile == "Python VSCode" OR currentProfile == "C# VSCode"
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

;Mouse G6: forward in history
F18::Send, !{Right}

;Mouse G7: close tab
F19::Gosub, $^w

;Mouse G8: tab to the left
F20::Send, ^{PGUP}

;Mouse G9: backwards in history
F21::Send, !{Left}

;Mouse G10: Alt + Tab
F22::Send, !{Tab}

;Mouse G11: minimize the current active window
F23::WinMinimize, A

;Mouse G12: reopen the last closed VSCode tab (file), and jump to it.
+F23::Send, ^+t

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

;Keeb G9: Print functions for different languages
^F21::
switch (currentProfile) {
    case "AutoHotkey VSCode":Send, MsgBox`,{Space}
    case "C++ VSCode":Send, cout <<  << endl;{Left 9}
    case "C VSCode":Send, printf("");{Left 3}
    case "Python VSCode":Send, print(""){Left 2}
    Case "C# VSCode":Send, Console.WriteLine("");{Left 3}
    default:MsgBox, 262160, Unknown VSCode Sub Profile, This current language is not defined for this hotkey.
}
return

^F22::Send, +!{Down} ;Keeb G10: Copy line down
^F23::Send, !{Down} ;Keeb G11: Move line down

;Keeb G12: Input functions for different languages
!F23::
Switch (currentProfile) {
    Case "AutoHotkey VSCode":Send, InputBox`,{Space}
    case "C++ VSCode":Send, cin >> `;{Left}
    Case "C VSCode":Send, scanf("`%");{Left 3}
    Case "Python VSCode":Send, input(""){Left 2}
    Case "C# VSCode":Send, Console.ReadLine();{Left 2}
    default:MsgBox, 262160, Unknown VSCode Sub Profile, This current language is not defined for this hotkey.
}
return

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

!/:: ;Adds comment character(s) at current cursor position.
Switch (currentProfile) {
    Case "AutoHotkey VSCode":Send, `;{Space}
    Case "C VSCode", "C++ VSCode":Send, //{Space}
    Case "Python VSCode":Send, {#}{Space}
    default:MsgBox, 262160, Unknown VSCode Sub Profile, This current language is not defined for this hotkey.
}
return

#/:: ;Same thing as !/, but adds an extra space before the comment character(s).
Switch (currentProfile) {
    Case "AutoHotkey VSCode":Send, {Space}`;{Space}
    Case "C VSCode", "C++ VSCode":Send, {Space}//{Space}
    Case "Python VSCode":Send, {Space}{#}{Space}
    default:MsgBox, 262160, Unknown VSCode Sub Profile, This current language is not defined for this hotkey.
}
return

#If currentProfile == "Python VSCode"
; F5::Send, #{F5} ;C and Python sharing this shortcut should hopefully work....
+Enter::Send, `:{Enter}

#If currentProfile == "C VSCode" OR currentProfile == "C++ VSCode"
; F5::Send, #{F5} ;For compiling C code.
:*:null::NULL

:X:pr::Send, printf("");{Left 3}
:X:pln::Send, printf("\n");{Left 5}
:X:sc::Send, scanf("`%");{Left 3}

::fr::
SendRaw, for (int i = 0; i < `; i`+`+)
Send, {Left 6}
return

#If programmingMode = false
\::
Send, ^+{Left}
Send, {BackSpace}
return

#If programmingMode = false AND !(currentProfile == "Generic VSCode" OR currentProfile == "AutoHotkey VSCode" OR currentProfile == "C VSCode" OR currentProfile == "C++ VSCode" OR currentProfile == "Python VSCode")
::i::I
#If