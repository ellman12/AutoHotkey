#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\Header Files\toggleGUI.ahk

;TODO
;toggle GUI
;hotkeys + stuff they do

global CR_GUI_WDTH := 574
global CR_GUI_HEIGHT := 96
global CRGUIVisibility := 0

;CR = Compile and Run
GUI, CR:+AlwaysOnTop
GUI, CR:Color, Silver
GUI, CR:Margin, 2, 1

;***********************************FILE1 + HEADER***********************************
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
GUI, CR:Add, Edit, xp yp+18 w36 vfileExt1, cpp

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

;Compiler and Program Args (Both Optional)
; GUI, CR:Add, Checkbox, xp+84 ym vcompArgsToggled, Comp Args
GUI, CR:Add, Text, xp+84 ym, Comp Args
GUI, CR:Add, Edit, xp yp+18 w85 vcomp1Args

; GUI, CR:Add, Checkbox, xp+90 ym vprogArgsToggled, Prog Args
GUI, CR:Add, Text, xp+90 ym, Prog Args
GUI, CR:Add, Edit, xp yp+18 w85 vprog1Args

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
GUI, CR:Add, Edit, xp+23 yp w63 vprgmName2, a
GUI, CR:Add, ComboBox, xp+65 yp w55 vprgmExt2, out||exe

; ;Environment
GUI, CR:Add, DDL, xp+60 yp w76 vEnvDDL2, VSCode||External Terminal

;Compiler and Program Args (Both Optional)
GUI, CR:Add, Edit, xp+84 yp w85 vcomp2Args
GUI, CR:Add, Edit, xp+90 yp w85 vprog2Args

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
GUI, CR:Add, Edit, xp+23 yp w63 vprgmName3, a
GUI, CR:Add, ComboBox, xp+65 yp w55 vprgmExt3, out||exe

; ;Environment
GUI, CR:Add, DDL, xp+60 yp w76 vEnvDDL3, VSCode||External Terminal

;Compiler and Program Args (Both Optional)
GUI, CR:Add, Edit, xp+84 yp w85 vcomp3Args
GUI, CR:Add, Edit, xp+90 yp w85 vprog3Args

GUI, CR:Show, w%CR_GUI_WDTH% h%CR_GUI_HEIGHT% x1100 y700, Compile and Run


F5::Reload
^r::Reload

#AppsKey::toggleGUI(CRGUIVisibility, "CR", CR_GUI_WDTH, CR_GUI_HEIGHT, "Compile and Run")