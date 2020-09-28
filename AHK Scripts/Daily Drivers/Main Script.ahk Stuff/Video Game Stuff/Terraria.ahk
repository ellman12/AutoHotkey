;This script is the Terraria profile.
;Terraria is... Weird. It doesn't except hotkeys like this: Send, q.
;You have to do it a different way.

;****************************************MOUSE ACTIONS***************************************

#If currentProfile = "Terraria"
;;Mouse Profile Switch button
^!F23::
; NextWindowF6()
return

;Mouse DPI Toggle
^+F23::
; NextWindowF7()
return

;Mouse G1.
;Quick Buff.
F13::
Send, {b down}
KeyWait, F13
Send, {b up}
return

;Mouse G2.
;Quick Heal.
F14::
Send, {h down}
KeyWait, F14
Send, {h up}
return

;Mouse G3.
;Quick Mana.
F15::
Send, {j down}
KeyWait, F15
Send, {j up}
return

/*
;Mouse G4.
;Grapple.
F16::
Send, {e down}
KeyWait, F16
Send, {e up}
return

;Mouse G5.
;Open Inventory
F17::
Send, {q down}
KeyWait, F17
Send, {q up}
return
*/

;Mouse G4.
;Inventory. (I changed Esc to q in the game settings).
F16::
Send, {q down}
KeyWait, F16
Send, {q up}
return

;Mouse G5.
;Grapple.
F17::
Send, {e down}
KeyWait, F17
Send, {e up}
return

;Mouse G6.
F18::
return

;Mouse G7
F19::
return

;Mouse G8
F20::
return

;Mouse G9
F21::
return

;Mouse G10
F22::
return

;Mouse G11
F23::
return

;Mouse G12
+F23::
return

;****************************************KEYBOARD ACTIONS***************************************
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

#If
