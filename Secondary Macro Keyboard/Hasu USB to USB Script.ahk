#NoEnv
SendMode Input
#InstallKeybdHook
;#InstallMouseHook ;<--You'll want to use this if you have scripts that use the mouse.
#UseHook On
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000

;;The lines below are optional. Delete them if you need to.
#HotkeyModifierTimeout 60 ; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm
; #KeyHistory 200 ; https://autohotkey.com/docs/commands/_KeyHistory.htm ; useful for debugging.
#MenuMaskKey vk07 ;https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;prevent taskbar flashing.

;The Hasu USB to USB Controller Converter somehow separates the 2nd keyboard from the others.
#if (GetKeyState("F24", "P")) ;<--Everything after this line will only happen on the secondary keyboard that uses F24.
F24::return ;This line is mandatory for proper functionality.

;Saving mouse pointer locations and returning to saved spots.
F1::MouseMove, mousePosX1, mousePosY1, 0

+F1::
MouseGetPos, mousePosX1, mousePosY1
Tippy("F1 pointer saved", 1300)
return

F2::MouseMove, mousePosX2, mousePosY2, 0

+F2::
MouseGetPos, mousePosX2, mousePosY2
Tippy("F2 pointer saved", 1300)
return

F3::MouseMove, mousePosX3, mousePosY3, 0

+F3::
MouseGetPos, mousePosX3, mousePosY3
Tippy("F3 pointer saved", 1300)
return

F4::MouseMove, mousePosX4, mousePosY4, 0

+F4::
MouseGetPos, mousePosX4, mousePosY4
Tippy("F4 pointer saved", 1300)
return

;Run/activate Outlook.
F9::
OutlookVisibilityToggle := 1 ;Because it's visible now,

if !WinExist("ahk_exe Outlook.exe")
    Run, C:\Program Files\Microsoft Office\root\Office16\Outlook.exe
else if !WinActive("ahk_exe Outlook.exe")
    WinActivate ahk_exe Outlook.exe
return

;Show/hide Outlook.
^F9::
OutlookVisibilityToggle := !OutlookVisibilityToggle

if (OutlookVisibilityToggle = "1") {
    WinHide, ahk_exe Outlook.exe
} else if (OutlookVisibilityToggle = "0") {
    WinShow, ahk_exe Outlook.exe
}
return

;Run/show MS To Do.
F10::
Run, C:\Users\Elliott\Documents\Microsoft To Do
return

;Run/show Discord.
F11::
DiscordVisibilityToggle := 1 ;Because it's visible now,

if !WinExist("ahk_exe Discord.exe")
    Run, C:\Users\Elliott\AppData\Local\Discord\app-0.0.308\Discord.exe
else if !WinActive("ahk_exe Discord.exe")
    WinActivate ahk_exe Discord.exe
return

;Show/hide Discord.
^F11::
DiscordVisibilityToggle := !DiscordVisibilityToggle

if (DiscordVisibilityToggle = "1") {
    WinHide, ahk_exe Discord.exe
} else if (DiscordVisibilityToggle = "0") {
    WinShow, ahk_exe Discord.exe
}
return

;In File Explorer, size all columns to fit.
;In Firefox/Chrome go to tabs 1-8, or last tab (9).
1::
    IfWinActive, ahk_exe Explorer.EXE
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
    IfWinActive, ahk_exe Explorer.EXE
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
IfWinActive, ahk_exe Explorer.EXE
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
IfWinActive, ahk_exe Explorer.EXE
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
IfWinActive, ahk_exe Explorer.EXE
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

q::Send, ^#{Left}
w::Send, ^#{Right}

;Send Ctrl + A.
a::Send, ^a

;Sends the current time.
b::
FormatTime, formattedDateTime,, h:mm tt
SendInput, %formattedDateTime%
return

;Sends Alt + F4.
backspace::Send, !{F4}

;Sends the current date and time.
c::
FormatTime, formattedDateTime,, M/d/yyyy h:mm tt
SendInput, %formattedDateTime%
return

;(Shift + Win + Left) Comma moves active window to 2nd monitor.
SC033::Send, +#{Left}

;Open the Desktop folder.
d::Run, explorer %A_Desktop%

;Open AHK Documentation
e::
RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
Sleep 1000
Send, !s
return

;Kind Regards Macro.
enter::Send, Kind regards`,{Enter 2}Elliott DuCharme

;Open the spreadsheet.
escape::Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=711563356

;Open the AHK repo folder.
f::Run, explorer C:\Users\Elliott\Documents\GitHub\AutoHotkey

;Open the Documents folder.
g::Run, explorer %A_MyDocuments%

;Open my user folder.
h::Run, explorer C:\Users\Elliott\

;Create a new Private Firefox window w/ Google Images.
i::Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://images.google.com/

;Open the C: drive.
j::Run, explorer.exe "C:\"

;Open the Downloads folder.
k::Run, explorer.exe "C:\Users\Elliott\Downloads"

;Open the G: drive.
l::Run, explorer.exe "G:\"

;Ctrl + Left. Common keeb shortcut for moving between words in text.
left::Send, ^{Left}

;Left bracket -> Google Images Search for selected text in Private Firefox.
SC01A::
    ; Send, ^c
    ; Sleep 200
    ; Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?tbm=isch&q=%Clipboard%
    BlockInput, on
    prevClipboard = %clipboard%
    clipboard =
    Send, ^c
    BlockInput, off
    ClipWait, 2
    if ErrorLevel = 0
    {
        searchQuery=%clipboard%
        GoSub, GoogleImagesSearch
    }
    clipboard = %prevClipboard%
return

;Sleep PC (+ manual Enter).
m::
Send, #x
Sleep, 250
Send, {Up 2}
Send, {Right}
Send, {Down}
return

;Open Notepad.
n::Run, notepad.exe

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
numpad0::Tippy(Unassigned, 1300)
NumpadIns::Tippy(Unassigned, 1300)

NumpadDot::Tippy(Unassigned, 1300)
NumpadDel::Tippy(Unassigned, 1300)

numpad2::Tippy(Unassigned, 1300)
NumpadDown::Tippy(Unassigned, 1300)

numpad3::Tippy(Unassigned, 1300)
NumpadPgdn::Tippy(Unassigned, 1300)

numpad5::Tippy(Unassigned, 1300)
NumpadClear::Tippy(Unassigned, 1300)

numpad8::Tippy(Unassigned, 1300)
NumpadUp::Tippy(Unassigned, 1300)

numpad9::Tippy(Unassigned, 1300)
NumpadPgup::Tippy(Unassigned, 1300)

NumpadEnter::Tippy(Unassigned, 1300)
NumpadAdd::Tippy(Unassigned, 1300)
NumpadSub::Tippy(Unassigned, 1300)

;Send Ctrl + O.
o::Send, ^o

;Create a new Private Firefox window w/ Google.
p::Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/

;(Shift + Win + Right) Period moves active window to primary monitor.
SC034::Send, +#{Right}

r::reloadMSR()

;Ctrl + Right. Common keeb shortcut for moving between words in text.
right::Send, ^{Right}

;Right bracket Google Searches for selected text in Private Firefox.
SC01B::
    ; Send, ^c
    ; Sleep 200
    ; Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window http://www.google.com/search?q=`%22%clipboard%`%22
    BlockInput, on
    prevClipboard = %clipboard%
    clipboard =
    Send, ^c
    BlockInput, off
    ClipWait, 2
    if ErrorLevel = 0
    {
        searchQuery=%clipboard%
        GoSub, GoogleSearch
    }
    clipboard = %prevClipboard%
return

;Open Music folder.
s::Run, explorer C:\Users\Elliott\Music

;Suspends hotkeys in MSR.
Space::Suspend

;Open Terraria Wiki
t::
RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://terraria.gamepedia.com/Terraria_Wiki
Sleep 2000
Send, !+f ;Open the search bar.
return

;Unzip a single .zip file in File Explorer.
u::
Send, {Alt}jza
Sleep 900
Send, !e
return

;Sends the current date.
v::
FormatTime, formattedDateTime,, M/d/yyyy
SendInput, %formattedDateTime%
return

;Redo.
x::Send, ^y

;Paste a link in Gmail, and make it blue and clickable too.
;7/18/2020 1:26 PM removed because Gmail does this automatically (I think?) after sending an email.
; y::
; Send, ^k
; Sleep 150
; Send, ^v
; Sleep 150
; Send, {Tab 2}
; Sleep 150
; Send, ^v
; Sleep 150
; Send, {Enter}
; return

;Undo.
z::Send, ^z

; #if (GetKeyState("F24", "P")) AND (GetKeyState("Space", "P"))
; F24::return

#if

;Allowing the 2nd keyboard to use Shift for hotkeys. E.g., Shift + F1.
;IDK if Ctrl, Alt, and/or Win Key will work...
;"Note that some of the QMK changes only work for key UP, rather than key down and up, so not all modifier key re-remappings will necessarily work."
;https://youtu.be/GZEoss4XIgc
;LShift -to-> SC070-International 2 -back-to-> LShift.
SC070::Lshift
SC07D::Rshift

;***************FUNCTIONS FOR THE 2ND KEEB***************
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