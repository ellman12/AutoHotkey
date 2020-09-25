; #Include C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Test Scripts\VA.ahk
#Include C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Test Scripts\volume thing idk.ahk
; #Include C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Test Scripts\ISimpleAudioVolume.ahk

; When F1 is pressed reduce chrome's volume by 10%
F1::
WinGet, ChromePIDVariable, PID, ahk_exe chrome.exe
VA_SetAppVolume(ChromePIDVariable, VA_GetAppVolume(ChromePIDVariable)-10)
return

; When F2 is pressed raise chrome's volume by 10%
F2::
WinGet, ChromePIDVariable, PID, ahk_exe chrome.exe
VA_SetAppVolume(ChromePIDVariable, VA_GetAppVolume(ChromePIDVariable)+10)
return

; When F3 is pressed reduce Spotify's volume by 10%
F3::
VA_SetAppVolume("SpotifyProcessName.exe", VA_GetAppVolume("SpotifyProcessName.exe")-10)
return

; When F4 is pressed raise Spotify's volume by 10%
F4::
VA_SetAppVolume("SpotifyProcessName.exe", VA_GetAppVolume("SpotifyProcessName.exe")+10)
return

; When F5 is pressed reduce the active application's volume by 10%
F5::
WinGet, ActivePID, PID, A ; A means Active here
VA_SetAppVolume(ActivePID, VA_GetAppVolume(ActivePID)-10)
return

; When F6 is pressed raise the active application's volume by 10%
F6::
WinGet, ActivePID, PID, A ; A means Active here
VA_SetAppVolume(ActivePID, VA_GetAppVolume(ActivePID)+10)
return