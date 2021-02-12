;Automate compiling and running command line C/C++ code.
;TODO:
;Show/hide GUI and change stuff in runtime
;Do more testing before adding to MSR.
#SingleInstance, force

GUI, gccgpp:+AlwaysOnTop
GUI, gccgpp:Color, Silver
GUI, gccgpp:Margin, 3, 3

GUI, gccgpp:Font, s10
GUI, gccgpp:Add, Text,, File 1 (AppsKey) (.c or .cpp)
GUI, gccgpp:Add, Edit, vFile1 w170
GUI, gccgpp:Add, Text,, File 2 (Optional) (Alt + AppsKey)
GUI, gccgpp:Add, Edit, vFile2 w170

GUI, gccgpp:Add, Radio, vusingExe yp+29 Group, exe ;Windows. Doesnt even send this cuz Windows is smart and doesn't need it
GUI, gccgpp:Add, Radio, vusingOut Checked, out ;Linux. Making default (for now?) since right now I use that more. Current defaults could def change in the future.

GUI, gccgpp:Add, Radio, vusinggcc yp xp+70 y97 Group, gcc
GUI, gccgpp:Add, Radio, vusinggpp Checked, g++

GUI, gccgpp:Add, Radio, vusingVSCode xp-70 yp+25 Checked Group, VSCode Terminal
GUI, gccgpp:Add, Radio, vUsingExternal, External Terminal

GUI, gccgpp:Add, Button, xp+140 yp-10 gDoneButton, &Done

GUI, gccgpp:Show, w195 h180 x1300,gcc g++
return

DoneButton:
gccgppGUIClose:
gccgppGUIEscape:
GUI, gccgpp:Submit
return

AppsKey::compileAndRun(File1)
!AppsKey::compileAndRun(File2)

compileAndRun(filename)
{
global
    if (usingExe = "1")
        runWhat := "a"
    else if (usingOut = "1")
        runWhat := "./a.out"

    if (usinggcc = "1")
        compileWith := "gcc"
    else if (usinggpp = "1")
        compileWith := "g++"
        
    if (usingVSCode = "1")
    {
        MouseMove, 900, A_ScreenHeight - 100, 0
        SendInput, {Click}
        SendInput, {Raw}%compileWith% "%filename%" && %runWhat%
        Send, {Enter}
    }
    else if (usingExternal = "1")
    {
        SendInput, {Raw}%compileWith% "%filename%" && %runWhat%
        Send, {Enter}
    }
}