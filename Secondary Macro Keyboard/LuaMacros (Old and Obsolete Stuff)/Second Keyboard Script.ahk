#NoEnv
SendMode Input
#InstallKeybdHook
#UseHook On
; Menu, Tray, Icon, shell32.dll, 283 ;Changes the tray icon to a little keyboard.
#SingleInstance force
#MaxHotkeysPerInterval 2000

;This is my custom, modified version of this script: https://github.com/TaranVH/2nd-keyboard/tree/master/LUAMACROS
;It has been heavily improved and customized to work with my needs, and my secondary macro keyboard.

;Get this virtual key press from LuaMacros, and read the file that it wrote text to.
F24::

FileRead, pressedKey, %keypressedTxtFileDir%

; MsgBox %pressedKey%

;See which key was pressed, and act on that.
Switch (pressedKey) {


    ;In File Explorer, size all columns to fit.
    ;In Firefox/Chrome go to tabs 1–8, or last tab (9).
    Case "1":
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
    Case "2":
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
    Case "3":
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
    Case "4":
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
    Case "5":
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

    Case "6":
    IfWinActive, ahk_exe Firefox.exe
        Send, ^6
    else IfWinActive, ahk_exe chrome.exe
        Send, ^6
    return

    Case "7":
    IfWinActive, ahk_exe Firefox.exe
        Send, ^7
    else IfWinActive, ahk_exe chrome.exe
        Send, ^7
    return

    Case "8":
    IfWinActive, ahk_exe Firefox.exe
        Send, ^8
    else IfWinActive, ahk_exe chrome.exe
        Send, ^8
    return

    Case "9":
    IfWinActive, ahk_exe Firefox.exe
        Send, ^9
    else IfWinActive, ahk_exe chrome.exe
        Send, ^9
    return

    ;Reset zoom.
    Case "0":
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
    Case "equals":
    if (currentProfile = "Docs" || currentProfile = "VSCode")
        Send, ^!= ;Technically it's ^!+, but sending + is technically +=... It just works ;)
    else
        Send, ^=
    return

    ;Zoom out.
    Case "minus":
    if (currentProfile = "Docs" || currentProfile = "VSCode")
        Send, ^!-
    else
        Send, ^-
    return

    ;Send Ctrl + A.
    Case "a":Send, ^a

    Case "appskey":MsgBox, %pressedKey% is unassigned.

    ;Sends the current time.
    Case "b":
    FormatTime, CurrentDateTime,, h:mm tt
    SendInput, %CurrentDateTime%
    return

    ;Sends Alt + F4.
    Case "backspace":Send, !{F4}

    ;Sends the current date and time.
    Case "c":
    FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt
    SendInput, %CurrentDateTime%
    return

    ;(Shift + Win + Left) Move active window to 2nd monitor.
    Case "comma":Send, +#{Left}

    ;Open the Desktop folder.
    Case "d":Run, explorer %A_Desktop%

    Case "delete":MsgBox, %pressedKey% is unassigned.

    ;Sends the normal down key, to be used in conjunction with Left and Right.
    Case "down":Send, {Down}

    Case "e":MsgBox, %pressedKey% is unassigned.

    ;Normal End.
    Case "end":Send, {End}

    ;Kind Regards Macro.
    Case "enter":Send, Kind regards`,{Enter 2}Elliott DuCharme

    ;Open the spreadsheet.
    Case "escape":Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=711563356

    Case "equals":MsgBox, %pressedKey% is unassigned.

    ;Open the AHK repo folder.
    Case "f":Run, explorer C:\Users\Elliott\Documents\GitHub\AutoHotkey

    Case "F10":MsgBox, %pressedKey% is unassigned.

    Case "F11":MsgBox, %pressedKey% is unassigned.

    Case "F12":MsgBox, %pressedKey% is unassigned.

    Case "F5":MsgBox, %pressedKey% is unassigned.

    Case "F6":MsgBox, %pressedKey% is unassigned.

    Case "F7":MsgBox, %pressedKey% is unassigned.

    Case "F8":MsgBox, %pressedKey% is unassigned.

    Case "F9":MsgBox, %pressedKey% is unassigned.

    ;Open the Documents folder.
    Case "g":Run, explorer %A_MyDocuments%

    ;Open my user folder.
    Case "h":Run, explorer C:\Users\Elliott\

    ;Normal Home.
    Case "home":Send, {Home}

    ;Create a new Private Firefox window w/ Google Images.
    Case "i":Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://images.google.com/

    Case "insert":MsgBox, %pressedKey% is unassigned.

    ;Open the C: drive.
    Case "j":Run, explorer.exe "C:\"

    ;Open the Downloads folder.
    Case "k":Run, explorer.exe "C:\Users\Elliott\Downloads"

    ;Open the G: drive.
    Case "l":Run, explorer.exe "G:\"

    ;Ctrl + Left. Common keeb shortcut for moving between words in text.
    Case "left":Send, ^{Left}

    ;Google Images Search for selected text in Private Firefox.
    Case "leftbracket":
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

    Case "m":MsgBox, %pressedKey% is unassigned.

    Case "minus":MsgBox, %pressedKey% is unassigned.

    ;Open Notepad.
    Case "n":Run, notepad.exe

    Case "num0":MsgBox, %pressedKey% is unassigned.

    ;Shift + End.
    Case "num1":Send, +{End}

    Case "num2":MsgBox, %pressedKey% is unassigned.

    Case "num3":MsgBox, %pressedKey% is unassigned.

    ;Ctrl + Shift + Left.
    Case "num4":Send, ^+{Left}

    Case "num5":MsgBox, %pressedKey% is unassigned.

    Case "numClear":MsgBox, %pressedKey% is unassigned.

    ;Ctrl + Shift + Right.
    Case "num6":Send, ^+{Right}

    ;Shift + Home.
    Case "num7":Send, +{Home}

    Case "num8":MsgBox, %pressedKey% is unassigned.

    Case "num9":MsgBox, %pressedKey% is unassigned.

    ;Shift + Left.
    Case "numDiv":Send, +{Left}

    ;Shift + Right.
    Case "numMult":Send, +{Right}

    ;Send Ctrl + O.
    Case "o":Send, ^o

    ;Create a new Private Firefox window w/ Google.
    Case "p":Run, C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/

    Case "pagedown":MsgBox, %pressedKey% is unassigned.

    Case "pageup":MsgBox, %pressedKey% is unassigned.

    ;(Shift + Win + Right) Move active window to primary monitor.
    Case "period":Send, +#{Right}

    Case "q":MsgBox, %pressedKey% is unassigned.

    ;Reload either the Main Script or this Script.
    Case "r":
    blankOutKeyTxtFile()
    Reload
    return

    ;Ctrl + Right. Common keeb shortcut for moving between words in text.
    Case "right":Send, ^{Right}

    ;Google Search for selected text in Private Firefox.
    Case "rightbracket":
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
    Case "s":Run, explorer C:\Users\Elliott\Music

    Case "semicolon":MsgBox, %pressedKey% is unassigned.

    Case "singlequote":MsgBox, %pressedKey% is unassigned.

    ;Suspends the hotkeys of the Main Script and Advanced Window Hider. Hopefully won't/shouldn't do anything if they aren't running. Press space again to un-suspend.
    ;This is taken care of in Main Script.ahk
    Case "space":

    Case "slash":MsgBox, %pressedKey% is unassigned.

    Case "t":MsgBox, %pressedKey% is unassigned.

    ;Unzip a single .zip file in File Explorer.
    Case "u":
    Send, {Alt}jza
    Sleep 900
    Send, !e
    return

    ;Sends the normal up key, to be used in conjunction with Left and Right.
    Case "up":Send, {Up}

    ;Sends the current date.
    Case "v":
    FormatTime, CurrentDateTime,, M/d/yyyy
    SendInput, %CurrentDateTime%
    return

    Case "w":MsgBox, %pressedKey% is unassigned.

    ;Redo.
    Case "x":Send, ^y

    ;Paste a link in Gmail, and make it blue and clickable too.
    Case "y":
    Send, ^k
    Sleep 150
    Send, ^v
    Sleep 150
    Send, {Tab 2}
    Sleep 150
    Send, ^v
    Sleep 150
    Send, {Enter}
    return

    ;Undo.
    Case "z":Send, ^z

    ;Error message if a key isn't in this Switch statement block.
    Default:
        MsgBox, 262160, Error. Unknown Key., %pressedKey% is an unknown key. It's probably not programmed in the AHK Script.

} ;End of the Switch statement.
return

;***************FUNCTIONS FOR THE 2ND KEEB***************
;This resets the txt file after each key press on the 2nd keeb.
blankOutKeyTxtFile() {
    FileDelete, %keypressedTxtFileDir%
    FileAppend, , %keypressedTxtFileDir%
}

blankOutNumPadTxtFile() {
    FileDelete, %numPadToggleFileDir%
    FileAppend, , %numPadToggleFileDir%
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