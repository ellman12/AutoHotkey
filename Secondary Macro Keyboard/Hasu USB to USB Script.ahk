;These things are not by me, but I'm not sure if they're needed, so I'm keeping them in.
#InstallKeybdHook
#UseHook On
#MaxHotkeysPerInterval 2000

#HotkeyModifierTimeout 60 ; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm
; #KeyHistory 200 ; https://autohotkey.com/docs/commands/_KeyHistory.htm ; useful for debugging.
#MenuMaskKey vk07 ;https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;prevent taskbar flashing.

#if (GetKeyState("F24", "P")) OR (GetKeyState("CapsLock", "P")) ;Only allow these hotkeys if a 2nd keyboard key is pressed OR CapsLock is pressed down.
F24::return ;This line is mandatory for proper functionality.

;Saving mouse pointer locations and returning to saved spots.
+F1::
MouseGetPos, mousePosX1, mousePosY1
Tippy("F1 pointer saved", 1300)
return

+F2::
MouseGetPos, mousePosX2, mousePosY2
Tippy("F2 pointer saved", 1300)
return

+F3::
MouseGetPos, mousePosX3, mousePosY3
Tippy("F3 pointer saved", 1300)
return

+F4::
MouseGetPos, mousePosX4, mousePosY4
Tippy("F4 pointer saved", 1300)
return

F1::F1ThruF4MouseMove("F1", mousePosX1, mousePosY1)
F2::F1ThruF4MouseMove("F2", mousePosX2, mousePosY2)
F3::F1ThruF4MouseMove("F3", mousePosX3, mousePosY3)
F4::F1ThruF4MouseMove("F4", mousePosX4, mousePosY4)

F6::altTabGroupAdd(WindowGroupF6)
F7::altTabGroupAdd(WindowGroupF7)
F8::altTabGroupAdd(WindowGroupF8)
F10::altTabGroupAdd(WindowGroupF10)

^F9::Run, C:\Program Files\Microsoft Office\root\Office16\Outlook.exe
^F11::Run, C:\Users\Elliott\AppData\Local\Discord\Update.exe --processStart Discord.exe
^F12:: Run, C:\Program Files (x86)\MusicBee\MusicBee.exe

F9:: ;Show/hide Outlook.
DetectHiddenWindows, On
SetTitleMatchMode, 2 ;A window's title can contain WinTitle anywhere inside it to be a match.
if (WinExist("- Outlook")) AND (!WinActive("- Outlook"))
    WinActivate, - Outlook
else if !WinExist("- Outlook") AND (!WinActive("- Outlook"))
    Run, C:\Program Files\Microsoft Office\root\Office16\Outlook.exe
else
{
    OutlookVisibilityToggle := !OutlookVisibilityToggle
    if (OutlookVisibilityToggle = 1) {
        WinHide, - Outlook
        Send, !{Tab} ;Go back to the previous window.
    } else {
        WinShow, - Outlook
        WinActivate, - Outlook
    }
}
return

F11:: ;Activate, and show/hide Discord.
DetectHiddenWindows, On
SetTitleMatchMode, 2 ;A window's title can contain WinTitle anywhere inside it to be a match.
WinGet, Style, Style, Discord ;0x10000000 is WS_VISIBLE. https://www.autohotkey.com/board/topic/58933-how-to-check-if-a-window-is-hidden/
if (WinExist("Discord")) AND (!WinActive("Discord") AND not Style & 0x10000000)
{
    WinShow, Discord
    WinActivate, Discord
}
else if !WinExist("Discord") AND (!WinActive("Discord"))
    Run, C:\Users\Elliott\AppData\Local\Discord\Update.exe --processStart Discord.exe
else
{
    WinHide, Discord
    Send, !{Tab} ;Go back to the previous window.
}
return

F12:: ;Activate, and show/hide MusicBee.
SetTitleMatchMode, 2 ;A window's title can contain WinTitle anywhere inside it to be a match.
if (WinExist("- MusicBee")) AND (!WinActive("- MusicBee"))
    WinActivate, - MusicBee
else
{
    MusicBeeVisibilityToggle := !MusicBeeVisibilityToggle

    if (MusicBeeVisibilityToggle = 0) {
        WinHide, - MusicBee
        Send, !{Tab} ;Go back to the previous window.
    } else {
        WinShow, - MusicBee
        WinActivate, - MusicBee
    }
}
return

;Equivalent to Win + S.
,::Gosub, CreateCapWindow

;Equivalent to Alt + Win + S.
!,::openOrShowClipsFolder()

;In File Explorer, size all columns to fit.
;In Firefox/Chrome go to tabs 1-8, or last tab (9).
1::
    IfWinActive, ahk_exe Explorer.exe
    {
        Send, !v ;Open View menu.
        Send, sf ;Alt code for sizing columns.
    }
    else IfWinActive, ahk_exe Firefox.exe
        Send, ^1
    else IfWinActive, ahk_exe chrome.exe
        Send, ^1
return

;In File Explorer, sort by name.
2::
    IfWinActive, ahk_exe Explorer.exe
    {
        Send, !v ;Open View menu.
        Send, o ;Alt code for opening sort by menu.
        Send, {Enter} ;Select it (cursor is on this one by default).
    }
    else IfWinActive, ahk_exe Firefox.exe
        Send, ^2
    else IfWinActive, ahk_exe chrome.exe
        Send, ^2
return

;In File Explorer, sort by date modified.
3::
IfWinActive, ahk_exe Explorer.exe
    {
    Send, !v ;Open View menu.
    Send, o ;Alt code for opening sort by menu.
    Send, {Down} ;Go to this menu item.
    Send, {Enter} ;Select it.
    }
    else IfWinActive, ahk_exe Firefox.exe
        Send, ^3
    else IfWinActive, ahk_exe chrome.exe
        Send, ^3
return

;In File Explorer, invert selection.
4::
IfWinActive, ahk_exe Explorer.exe
{
    Send, !h ;Open the Home menu.
    Send, si ;Alt code for invert selection.
}
else IfWinActive, ahk_exe Firefox.exe
    Send, ^4
else IfWinActive, ahk_exe chrome.exe
    Send, ^4
return

;Rename an item in File Explorer.
5::
IfWinActive, ahk_exe Explorer.exe
{
    Send, !h
    Send, r
}
else IfWinActive, ahk_exe Firefox.exe
    Send, ^5
else IfWinActive, ahk_exe chrome.exe
    Send, ^5
return

6::
IfWinActive, ahk_exe Firefox.exe
    Send, ^6
else IfWinActive, ahk_exe chrome.exe
    Send, ^6
return

7::
IfWinActive, ahk_exe Firefox.exe
    Send, ^7
else IfWinActive, ahk_exe chrome.exe
    Send, ^7
return

8::
IfWinActive, ahk_exe Firefox.exe
    Send, ^8
else IfWinActive, ahk_exe chrome.exe
    Send, ^8
return

9::
IfWinActive, ahk_exe Firefox.exe
    Send, ^9
else IfWinActive, ahk_exe chrome.exe
    Send, ^9
return

;Reset zoom.
0::
if (currentProfile = "Docs") {
    Send, !/zoom 100
    Sleep 420
    Send, {Enter}
}
else if (currentProfile = "VSCode")
    Send, ^!0
else
    Send, ^0
return

;Zoom in.
SC00D::
if (currentProfile = "Docs" || currentProfile = "VSCode")
    Send, ^!= ;Technically it's ^!+, but sending + is technically +=... It just works ;)
else
    Send, ^=
return

;Zoom out.
SC00C::
if (currentProfile = "Docs" || currentProfile = "VSCode")
    Send, ^!-
else
    Send, ^-
return

; q::Send, ^#{Left}
; w::Send, ^#{Right}

q::
Send, {Ctrl Up}
Send, ^c
return

w::
Send, {Ctrl Up}
Send, ^v
return

a::Send, ^a

$^a:: ;Selects all and does Title Case thing from TC.
Send, ^a
GoSub, ^!t
return

BackSpace::Send, !{F4}

d::Run, explorer %A_Desktop% ;Open the Desktop folder.

;Open AHK Documentation
e::
RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
Sleep 1000
Send, !s
return

Enter::Send, Kind regards`,{Enter 2}Elliott DuCharme
!Enter::Send, Thank you.{Enter 2}Kind regards`,{Enter 2}Elliott DuCharme
+Enter::Send, Hello`,{Enter 4}Kind regards`,{Enter 2}Elliott DuCharme{Up 4}

Escape::Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\Everything AutoHotkey.xlsx ;Open the "Everything AutoHotkey" spreadsheet.

f::Run, explorer C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey ;Open the AHK repo folder.

g::Run, explorer %A_MyDocuments% ;Open the Documents folder.

h::Run, explorer C:\Users\%A_UserName%\ ;Open my user folder.

i::Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://images.google.com/ ;Create a new Private Firefox window w/ Google Images.

j::Run, explorer.exe "C:\" ;Open the C: drive.

k::Run, explorer.exe "C:\Users\%A_UserName%\Downloads" ;Open the Downloads folder.
!k::Run, explorer.exe "C:\Users\%A_UserName%\Videos" ;Open the Videos folder.

l::Run, explorer.exe "G:\" ;Open the G:\ drive.

!l::Run, explorer.exe "B:\" ;Open the B:\ drive.

SC027:: ; ;/: key copies the selected word/text, and searches for it on Thesaurus.com. Doesn't work with multi-word things like "a lot".
Send, ^c
Sleep 50
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/browse/%Clipboard%
return

SC028:: ;" key opens thesaurus.com in Firefox and searches for the inputted word.
InputBox, Thes_FFInputBox, Search for This Word on Thesaurus.com, Type the word you want to search for on Thesaurus.com in Firefox.,, 300, 160
if (Thes_FFInputBox = "") ;If user presses Escape/Cancel, or enters nothing.
    return
Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/browse/%Thes_FFInputBox%
Thes_FFInputBox :=
return

;Ctrl + Left. Common keeb shortcut for moving between words in text.
Left::Send, ^{Left}

;Left bracket -> Google Images Search for selected text in Private Firefox.
SC01A::
BlockInput, on
prevClipboard = %clipboard%
clipboard =
Send, ^c
BlockInput, off
ClipWait, 0.2
if ErrorLevel = 0
{
    searchQuery=%clipboard%
    GoSub, GoogleImagesSearch
}
else ;If can't find text just do what i does.
    Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://images.google.com/
clipboard = %prevClipboard%
return

m::sleepPC() ;Open Windows sleep, hibernate, etc. menu.

;Open Google Calendar.
n::Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://calendar.google.com/calendar/u/0/r

;Shift + End.
NumPad1::Send, +{End}
NumpadEnd::Send, +{End}

;Ctrl + Shift + Left.
NumPad4::Send, ^+{Left}
NumpadLeft::Send, ^+{Left}

;Ctrl + Shift + Right.
NumPad6::Send, ^+{Right}
NumpadRight::Send, ^+{Right}

;Shift + Home.
NumPad7::Send, +{Home}
NumpadHome::Send, +{Home}

;Shift + Left.
NumpadDiv::Send, +{Left}

;Shift + Right.
NumpadMult::Send, +{Right}

;;=========== Unassigned NumPad Keys on 2nd Keeb ==============;;
NumPad0::Send, ^#{Left} ;Virtual Desktop to the Left.
NumpadIns::Send, ^#{Left}

NumpadDot::Send, ^#{Right}
NumpadDel::Send, ^#{Right}

;Send Ctrl + O.
o::Send, ^o

;Create a new Private Firefox window w/ Google.
p::Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/

;(Shift + Win + Right) Period moves active window to primary monitor.
SC034::Send, +#{Right}

r::reloadMSR()

;Ctrl + Right. Common keeb shortcut for moving between words in text.
Right::Send, ^{Right}

;Right bracket -> Google Search for selected text in Private Firefox.
SC01B::
BlockInput, on
prevClipboard = %clipboard%
clipboard =
Send, ^c
BlockInput, off
ClipWait, 0.2
if ErrorLevel = 0
{
    searchQuery = %clipboard%
    GoSub, GoogleSearch
}
else ;If can't find text just do what p does.
    Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/
clipboard = %prevClipboard%
return

s::Run, explorer C:\Users\%A_UserName%\Music ;Open Music folder.
^s::Run, explorer C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\Other\Memes ;Opens memes folder.

Space:: ;Suspends all hotkeys for the specified number in milliseconds.
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

;Unzip a single .zip file in File Explorer.
u::
Send, {Alt}jza
Sleep 900
Send, !e
return

;Redo.
x::Send, ^y

;Undo.
z::Send, ^z

;***************TEMP***************
/::SendRaw, elliott.ducharme@trojans.dsu.edu
^/::SendRaw, elliott.ducharme
Insert::
SendRaw, @dsu.edu
Send, {Enter}
Sleep, 1000
SendRaw, elliott.ducharme@trojans.dsu.edu
Send, {Tab}
FileRead, passwd, C:\Users\Elliott\Videos\passwd
SendRaw, %passwd%
Send, {Enter}
return

;On PC, open Google Drive where school stuff is
AppsKey::Run, explorer G:\Other computers\My PC\DSU Year 2 Semester 1

#if

;Allowing the 2nd keyboard to use Shift for hotkeys. E.g., Shift + F1.
;IDK if Ctrl, Alt, and/or Win Key will work...
;"Note that some of the QMK changes only work for key UP, rather than key down and up, so not all modifier key re-remappings will necessarily work."
;https://youtu.be/GZEoss4XIgc
;LShift -to-> SC070-International 2 -back-to-> LShift.
SC070::Lshift
SC07D::Rshift

;***************FUNCTIONS AND LABELS FOR THE 2ND KEEB***************
F1ThruF4MouseMove(Fx, mousePosX, mousePosY)
{
    if ((mousePosX == "") AND (mousePosY == "")) {
        MsgBox, 262160, Error. You must save %Fx%'s X and Y first., Use Shift + %Fx% to save the X and Y for %Fx%.
        return
    } else
        MouseMove, mousePosX, mousePosY, 0
}

GoogleSearch:
   StringReplace, searchQuery, searchQuery, `r`n, %A_Space%, All
   Loop
   {
      noExtraSpaces=1
      StringLeft, leftMost, searchQuery, 1
      IfInString, leftMost, %A_Space%
      {
         StringTrimLeft, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      StringRight, rightMost, searchQuery, 1
      IfInString, rightMost, %A_Space%
      {
         StringTrimRight, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      If (noExtraSpaces=1)
        break
   }
   StringReplace, searchQuery, searchQuery, \, `%5C, All
   StringReplace, searchQuery, searchQuery, %A_Space%, +, All
   StringReplace, searchQuery, searchQuery, `%, `%25, All
   IfInString, searchQuery, .
   {
      IfInString, searchQuery, +
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window http://www.google.com/search?hl=en&q=%searchQuery%
      else
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window %searchQuery%
   }
   else
      Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window http://www.google.com/search?hl=en&q=%searchQuery%
return

GoogleImagesSearch:
   StringReplace, searchQuery, searchQuery, `r`n, %A_Space%, All
   Loop
   {
      noExtraSpaces=1
      StringLeft, leftMost, searchQuery, 1
      IfInString, leftMost, %A_Space%
      {
         StringTrimLeft, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      StringRight, rightMost, searchQuery, 1
      IfInString, rightMost, %A_Space%
      {
         StringTrimRight, searchQuery, searchQuery, 1
         noExtraSpaces=0
      }
      If (noExtraSpaces=1)
         break
   }
   StringReplace, searchQuery, searchQuery, \, `%5C, All
   StringReplace, searchQuery, searchQuery, %A_Space%, +, All
   StringReplace, searchQuery, searchQuery, `%, `%25, All
   IfInString, searchQuery, .
   {
      IfInString, searchQuery, +
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?tbm=isch&q=%searchQuery%
      else
         Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window %searchQuery%
   }
   else
      Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?tbm=isch&q=%searchQuery%
return