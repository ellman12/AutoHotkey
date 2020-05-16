;This is a GUI for the Main Script that allows the user to change how parts of the script work.

; GUI, CPanel:+AlwaysOnTop
; GUI, CPanel:Color, Silver

;Insert
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y5,Insert Hotkey Monitor Choice

GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y30 w136 vInsMonChoice, 1 (Primary Mon)|2 (Secondary Mon)
;TODO make them default to their normal values.
;Ctrl + Insert
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y5,Ctrl + Insert Hotkey Monitor Choice

GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y30 w136 vInsMonChoice, 1 (Primary Mon)|2 (Secondary Mon)


GUI, CPanel:Show, w340 h400,Main Script Control Panel



;TODO Temp hotkeys.
F10::Send, GUI, CPanel: