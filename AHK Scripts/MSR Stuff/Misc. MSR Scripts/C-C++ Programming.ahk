;This file houses hotkeys and hotstrings for making C/C++ programming, as well as using the command prompt, that much easier.

;Adds default C stuff like stdio.h, etc. Also a header comment thing; original idea for the header comment thing from FRC programming mentor Larry Basegio. Only use if in a totally blank, brand new file with the .c extension.
:*:cnewfile::
FormatTime, formattedDateTime,, dddd, MMMM d, yyyy h:mm tt

SendRaw, ///////////////////////////////////////////////////////////////////////`n//File:`n///////////////////////////////////////////////////////////////////////`n//Purpose:
SendRaw, `n///////////////////////////////////////////////////////////////////////`n//Programmer: Elliott DuCharme`n///////////////////////////////////////////////////////////////////////
Send, `n//Comments: Created on {A_Space}%formattedDateTime%.`n
SendRaw, ///////////////////////////////////////////////////////////////////////`n#include <stdio.h>`n`nint main()`n{`n`n    return 0`;`n}
Sleep 1000
Send, {Left}+{Tab}
return

;Specifically designed for coding assignments for CSC 250 (Computer Science II) class at DSU.
:*:csnewassignment::
FormatTime, formattedDateTime,, dddd, MMMM d, yyyy h:mm tt

SendRaw, ///////////////////////////////////////////////////////////////////////`n//Purpose:`n///////////////////////////////////////////////////////////////////////`n//Programmer: Elliott DuCharme for Computer Science II (CSC 250).`n///////////////////////////////////////////////////////////////////////`n//Due Date: `n///////////////////////////////////////////////////////////////////////
Send, `n//Created: {A_Space}%formattedDateTime%.`n
SendRaw, ///////////////////////////////////////////////////////////////////////`n//Comments: `n///////////////////////////////////////////////////////////////////////`n#include <stdio.h>`n`nint main()`n{`n`n    return 0`;`n}
Sleep 1000
Send, {Left}+{Tab}
Send, {Up 2}{Tab}
return

;Specifically designed for coding examples for CSC 250 (Computer Science II) class at DSU.
:*:cscnewexample::
FormatTime, formattedDateTime,, dddd, MMMM d, yyyy h:mm tt

SendRaw, ///////////////////////////////////////////////////////////////////////`n//Purpose: In-class example.`n///////////////////////////////////////////////////////////////////////`n//Programmer: Elliott DuCharme for Computer Science II (CSC 250).`n///////////////////////////////////////////////////////////////////////
Send, `n//Created: {A_Space}%formattedDateTime%.`n
SendRaw, ///////////////////////////////////////////////////////////////////////`n#include <stdio.h>`n`nint main()`n{`n`n    return 0`;`n}
Sleep 1000
Send, {Left}+{Tab}
Send, {Up 2}{Tab}
return

;cppnewfile::
;Send, ///////////////////////////////////////////////////////////////////////`n//File: `n///////////////////////////////////////////////////////////////////////`n//Purpose: `n///////////////////////////////////////////////////////////////////////`n//Programmer: Elliott DuCharme`n///////////////////////////////////////////////////////////////////////`n//Initial release date: `n///////////////////////////////////////////////////////////////////////`n//Known issues/bugs: `n///////////////////////////////////////////////////////////////////////`n//Revisions: `n///////////////////////////////////////////////////////////////////////`n//Comments: `n///////////////////////////////////////////////////////////////////////`n
;return

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

:*:gcsc::
Send, cd C:/Users/Elliott/Documents/GitHub/DSU-CSC-250{Enter}
return

;Simpler git commands.
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

:*:gpsh::
Send, Git push{Enter}
return