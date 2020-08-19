;This file houses hotkeys and hotstrings for making C/C++ programming, as well as using the command prompt, that much easier.

;Adds default C stuff like stdio.h, etc. Also a header comment thing; original idea for the header comment thing from FRC programming mentor Larry Basegio. Only use if in a totally blank, brand new file with the .c extension.
:*:cnewfile::
Send, ///////////////////////////////////////////////////////////////////////`n//File: `n///////////////////////////////////////////////////////////////////////`n//Purpose: `n///////////////////////////////////////////////////////////////////////`n//Programmer: Elliott DuCharme`n///////////////////////////////////////////////////////////////////////`n//Initial release date: `n///////////////////////////////////////////////////////////////////////`n//Known issues/bugs: `n///////////////////////////////////////////////////////////////////////`n//Revisions: `n///////////////////////////////////////////////////////////////////////`n//Comments: `n///////////////////////////////////////////////////////////////////////`n
SendRaw, #include <stdio.h>`n`nint main()`n{`n`n}
Sleep 100
Send, {BackSpace 2}
Sleep 100
Send, {Tab}{Enter}return 0;
Sleep 100
Send, {Tab}{Up}{Tab}{Up 18}
Sleep 100
Send, {End}
return

;cppnewfile::
;Send, ///////////////////////////////////////////////////////////////////////`n//File: `n///////////////////////////////////////////////////////////////////////`n//Purpose: `n///////////////////////////////////////////////////////////////////////`n//Programmer: Elliott DuCharme`n///////////////////////////////////////////////////////////////////////`n//Initial release date: `n///////////////////////////////////////////////////////////////////////`n//Known issues/bugs: `n///////////////////////////////////////////////////////////////////////`n//Revisions: `n///////////////////////////////////////////////////////////////////////`n//Comments: `n///////////////////////////////////////////////////////////////////////`n
;return

#if gameModeActive = false
;Stuff for making Git cmd line stuff less repetitive.
;Used for cding to different GitHub repo folders.
:*:gahk::
Send, cd C:/Users/%A_Username%/Documents/GitHub/AutoHotkey{Enter}
return

:*:glrnc::
Send, cd C:/Users/%A_Username%/Documents/GitHub/Learning-C-CPP{Enter}
return

:*:gnxt::
Send, cd C:/Users/%A_Username%/Documents/GitHub/LEGO-Mindstorms-NXT{Enter}
return

:*:gev3::
Send, cd C:/Users/%A_Username%/Documents/GitHub/LEGO-Mindstorms-EV3{Enter}
return

:*:gshstf::
Send, cd C:/Users/%A_Username%/Documents/GitHub/Shared-Stuff{Enter}
return

:*:gst::
Send, Git status{Enter}
return

:*:gad::
Send, Git add -A{Enter}
return

:*:gmt::
Send, Git commit -m ""{Left}
return

:*:gpl::
:*:gpul::
Send, Git pull{Enter}
return

:*:gpus::
:*:gpsh::
Send, Git push{Enter}
return

;C programming stuff for use with VScode and the gcc compiler in just the command prompt.
#!c::
InputBox, ccompFileName, Enter the C file name, Enter the C file name without the .c extension to then be used with the cc hotstring.,,,,,,,,main
return

;Same thing, but for C++.
#^c::
InputBox, cppcompFileName, Enter the C file name, Enter the C file name without the .cpp extension to then be used with the pp hotstring.,,,,,,,,main
return

;Does the gcc command in command prompt and runs the a.exe file automatcally: gcc <file name.c>, and send a.exe (the compiled file).
:*:cc::
Send, gcc %ccompFileName%.c{Enter}a.exe{Enter}
return

;Same thing, but for C++ with the g++ compiler.
:*:pp::
SendRaw, g++ %cppcompFileName%.cpp
Sleep 100
Send, {Enter}
Sleep 100
Send, a{Enter}
return

;This is really only useful for my folder setup in the Learning-C-CPP repo folder in command prompt.
#+c::
InputBox, firstFolderName, Enter the exact 1st folder name, Enter the 1st folder name (or at least enough to autocomplete) to cd into. You should first be in the main repo folder.,,,,,,,,"Elliott's Stuff"
InputBox, secondFolderName, Enter the 2nd folder name, Enter the exact 2nd folder name. This is choosing either my stuff or Larry's stuff.,,,,,,,,"My Stuff"
InputBox, thirdFolderName, Enter the 3rd folder name, Enter either C or C++/CPP.,,,,,,,,C
InputBox, fourthFolderName, Enter the 4th folder name, Enter the 4th folder name (or at least enough to autocomplete) to cd into. This is the project folder for a single program.,,,,,,,,
return

;The hotstring that actually cd's into the right folder.
:*:cdd::
Send, cd %firstFolderName%{Tab}{Enter}
Sleep 1000
Send, cd %secondFolderName%{Enter}
Sleep 1000

if (thirdFolderName = "C") {
    Send, cd "C Stuff"{Enter}
} else if (thirdFolderName = "C++" or thirdFolderName = "CPP") {
    SendRaw, cd "C++ Stuff"
    Send, {Enter}
} else {
    MsgBox, Error
}

Sleep 1000
Send, cd %fourthFolderName%{Tab}{Enter}
Sleep 1000
return

#If