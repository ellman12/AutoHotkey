;Turning the almost useless Print Screen key into an extra modifier key.
;Only works (I think?) when it is the first key pressed. I.e., press PrtScn, then other keys.

#If GetKeyState("PrintScreen", "P")
PrintScreen::return ;Disables its normal functionality.

;My commonly used emojis.
t::Send, {U+1F914} ;🤔
u::Send, {U+1F44D} ;👍
#If