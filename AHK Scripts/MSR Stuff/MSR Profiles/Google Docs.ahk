;****************************************SCIMITAR RGB ACTIONS***************************************
#If currentProfile == "Docs"
;Mouse G1
;Horizontal scroll
F13::
Send, {Shift down}
KeyWait, F13
Send, {Shift up}
return

;Mouse G2
;(Ctrl + Tab) Jump to the Next Open Tab
F14::
Send, ^{Tab}
return

;Mouse G3
F15::
return

;Mouse G4
;New browser tab
F16::
Send, ^t
return

;Mouse G5
;Go one tab to the right
F17::
Send, ^{PGDN}
return

;Mouse G6
;Next page in History
F18::
Send, !{Right}
return

;Mouse G7: Close browser tab
F19::Gosub, $^w

;Mouse G8
;Go one tab to the left
F20::
Send, ^{PGUP}
return

;Mouse G9
;Previous page in History
F21::
Send, !{Left}
return

;Mouse G10: Alt + Tab
F22::
Send, !{Tab}
return

;Mouse G11
;Pushing F23 (G11) minimizes the current active window
F23::WinMinimize, A

;Mouse G12
;Reopen the last closed tab, and jump to it
+F23::
Send, ^+t
return

;****************************************K95 RGB ACTIONS***************************************
;Keeb G1
^F13::
return

;Keeb G2
;Reopen the last closed tab, and jump to it
^F14::
Send, ^+t
return

;Keeb G3
^F15::
return

;Keeb G4
;Open Incognito Window and goes to Google
^F16::
if InStr(activeWindowTitle, "Mozilla Firefox") {
	Send, ^+p
	Sleep 500
	Send, google.com{Enter}
	Send, #{Up}
	return
} else if InStr(activeWindowTitle, "Google Chrome") {
	Send, ^+n
	Sleep 500
	Send, google.com{Enter}
	Send, #{Up}
	return
}
return

;Keeb G5
;Paste without formatting
^F17::
Send, ^+v
return

;Keeb G6
;Automatic Google Lookup
^F18::
Send, ^c
Sleep 80
Send, ^t
Send, ^v{Enter}
return

;Keeb G7
;Open New Tab with Google
^F19::
Send, ^t
Send, google.com{Enter}
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
;Automatic Google Lookup in Incognito
^F22::
if InStr(activeWindowTitle, "Mozilla Firefox") {
	Send, ^c
	Sleep 80
	Send, ^+p
	Sleep 200
	Send, ^v{Enter}
	return
} else if InStr(activeWindowTitle, "Google Chrome") {
	Send, ^c
	Sleep 80
	Send, ^+n
	Sleep 200
	Send, ^v{Enter}
	return
}
return

;Keeb G11
;Search the menus in Docs and Sheets
^F23::
Send, !/
return

;Keeb G12
;Open the Dictionary
!F23::
Send, ^+y
Sleep 80
Send, {Tab 2}
return

;Keeb G13
;Undo
!F13::
Send, ^z
return

;Keeb G14
;Redo
!F14::
Send, ^y
return

;Keeb G15
!F15::
return

;Keeb G16
;Does what Win + Tab does
!F16::
Send, #{Tab}
return

!F17::return
!F18::return

;****************************************MISC DOCS ACTIONS***************************************
;Correct to.
RAlt::
Send, {AppsKey}{Down}{Enter}
return

;Always correct to.
RWin::
Send, {AppsKey}{Up 3}{Enter}
return

;Disabling these 2 annoying keyboard shortcuts: Ctrl + +/- (zooming in/out).
^SC00D::return ;00D	is the scan code for the +/= key.
^-::return

#If