#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;TODO: add other 2 files

;toggle GUI

global CRGUIVisibility := 0

global CR_GUI_WDTH := 396
global CR_GUI_HEIGHT := 45

;CR = Compile and Run
GUI, CR:+AlwaysOnTop +Resize ;Resize the left side of the GUI to expose optional controls
GUI, CR:Color, Silver
GUI, CR:Margin, 4, 1

;***********************************FILE1***********************************
;Compiler
GUI, CR:Font, s10 q5
GUI, CR:Add, Text, xm ym, Compiler
GUI, CR:Add, ComboBox, xp yp+18 w56 vcompChoice1, gcc|g++||

;Filename
GUI, CR:Add, Text, xp+58 ym, Filename
GUI, CR:Add, Edit, xp yp+18 w63 vfilename1, AppsKey

;Extension
GUI, CR:Font, s10 q5
GUI, CR:Add, Text, xp+65 ym, Ext
GUI, CR:Font, s10 q5
GUI, CR:Add, Edit, xp+1 yp+18 w36 vfileExt1, cpp

;&&
GUI, CR:Font, s12 q5
GUI, CR:Add, Text, xp+38 ym+20, &&&&

;Program (Executable) Name and Extension
GUI, CR:Font, s10 q5
GUI, CR:Add, Text, xp+22 ym, Prgm Name and Ext
GUI, CR:Add, Edit, xp+1 yp+18 w63 vprgmName1, a
GUI, CR:Add, ComboBox, xp+65 yp w55 vprgmExt1, out||exe

;Environment
GUI, CR:Add, Text, xp+60 ym, Environment
GUI, CR:Add, DDL, xp yp+19 w76 vEnvDDL1, VSCode||External Terminal

;***********************************FILE2***********************************
;Compiler
GUI, CR:Add, ComboBox, xm yp+25 w56 vcompChoice2, gcc|g++||

;Filename
GUI, CR:Add, Edit, xp+58 yp w63 vfilename2, ^AppKey

;Extension
GUI, CR:Add, Edit, xp+65 yp w36 vfileExt2, cpp

;&&
GUI, CR:Font, s12 q5
GUI, CR:Add, Text, xp+38 yp, &&&&

;Program (Executable) Name and Extension
GUI, CR:Font, s10 q5
GUI, CR:Add, Edit, xp+24 yp w63 vprgmName2, a
GUI, CR:Add, ComboBox, xp+65 yp w55 vprgmExt2, out||exe

; ;Environment
GUI, CR:Add, DDL, xp+60 yp w76 vEnvDDL2, VSCode||External Terminal

;***********************************FILE3***********************************
;Compiler
GUI, CR:Add, ComboBox, xm yp+25 w56 vcompChoice3, gcc|g++||

;Filename
GUI, CR:Add, Edit, xp+58 yp w63 vfilename3, !AppKey

;Extension
GUI, CR:Add, Edit, xp+65 yp w36 vfileExt3, cpp

;&&
GUI, CR:Font, s12 q5
GUI, CR:Add, Text, xp+38 yp, &&&&

;Program (Executable) Name and Extension
GUI, CR:Font, s10 q5
GUI, CR:Add, Edit, xp+24 yp w63 vprgmName3, a
GUI, CR:Add, ComboBox, xp+65 yp w55 vprgmExt3, out||exe

; ;Environment
GUI, CR:Add, DDL, xp+60 yp w76 vEnvDDL3, VSCode||External Terminal

GUI, CR:Show, w%CR_GUI_WDTH% h%CR_GUI_HEIGHT% x1200 y700, Compile and Run
F5::Reload
^r::Reload