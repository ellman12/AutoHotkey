#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;TODO: add other 2 files

global CRGUIVisibility := 0

global CR_GUI_WDTH := 415
global CR_GUI_HEIGHT := 200

;CR = Compile and Run
GUI, CR:+AlwaysOnTop
GUI, CR:Color, Silver
GUI, CR:Margin, 4, 1

GUI, CR:Show, w%CR_GUI_WDTH% h%CR_GUI_HEIGHT% x1200 y700, Compile and Run

;Compiler
GUI, CR:Font, s10 q5
GUI, CR:Add, Text, xm ym, Compiler
GUI, CR:Add, ComboBox, xp yp+18 w50 vcompChoice1, gcc|g++||
; GUI, CR:Add, ComboBox, xp yp+25 w50 vcompChoice2, gcc|g++||
; GUI, CR:Add, ComboBox, xp yp+25 w50 vcompChoice3, gcc|g++||

;Filename
GUI, CR:Add, Text, xp+63 ym, Filename
GUI, CR:Add, Edit, xp yp+18 w63 vfilename1
; GUI, CR:Add, Edit, xp yp+25 w63 vfilename2
; GUI, CR:Add, Edit, xp yp+25 w63 vfilename3

;Extension
GUI, CR:Font, s29 q5
GUI, CR:Add, Text, xp+63 ym+6, .
GUI, CR:Font, s10 q5
GUI, CR:Add, Text, xp+10 ym, Ext
GUI, CR:Font, s10 q5
GUI, CR:Add, Edit, xp yp+18 w36 vfileExt1, cpp
; GUI, CR:Add, Edit, xp yp+25 w36 vfileExt2
; GUI, CR:Add, Edit, xp yp+25 w36 vfileExt3

;&&
GUI, CR:Font, s12 q5
GUI, CR:Add, Text, xp+38 ym+20, &&&&

;Program (Executable) Name and Extension
GUI, CR:Font, s10 q5
GUI, CR:Add, Text, xp+23 ym, Prgm Name and Ext
GUI, CR:Add, Edit, xp yp+18 w63 vprgmName1, a
GUI, CR:Font, s29 q5
GUI, CR:Add, Text, xp+63 ym+6, .
GUI, CR:Font, s10 q5
GUI, CR:Add, ComboBox, xp+10 yp+13 w49 vprgmExt1, out||exe

;Environment
GUI, CR:Add, Text, xp+59 ym, Environment
GUI, CR:Add, DDL, xp yp+18 w76 vEnvDDL1, VSCode||External Terminal


^r::Reload