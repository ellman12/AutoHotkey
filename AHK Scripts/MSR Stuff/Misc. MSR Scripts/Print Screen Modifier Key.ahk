;Turning the almost useless Print Screen key into an extra modifier key.
;Only works (I think?) when it is the first key pressed. I.e., press PrtScn, then other keys.

#If GetKeyState("PrintScreen", "P")
PrintScreen::return
CapsLock::MsgBox
^!t::MsgBox
#If