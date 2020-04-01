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

    ;These macros are File Explorer specific; don't want them activating in other programs.
    #IfWinActive, ahk_exe Explorer.EXE
    ;In File Explorer, size all columns to fit.
    Case "1":
    Send, !v ;Open View menu.
    Send, sf ;Alt code for sizing columns.
    return

    ;In File Explorer, sort by name.
    Case "2":
    Send, !v ;Open View menu.
    Send, o ;Alt code for opening sort by menu.
    Send, {Enter} ;Select it (cursor is on this one by default).
    return

    ;In File Explorer, sort by date modified.
    Case "3":
    Send, !v ;Open View menu.
    Send, o ;Alt code for opening sort by menu.
    Send, {Down} ;Go to this menu item.
    Send, {Enter} ;Select it.
    return

    ;In File Explorer, invert selection.
    Case "4":
    Send, !h ;Open the Home menu.
    Send, si ;Alt code for invert selection.
    return

    ;Rename an item in File Explorer.
    Case "5":
    Send, !h
    Send, r
    return

    #If

    ;Open the B: drive.
    Case "a":Run, explorer.exe "B:\"

    Case "appskey":MsgBox, %pressedKey% is unassigned.

    Case "b":MsgBox, %pressedKey% is unassigned.

    ;Sends Alt + F4.
    Case "backspace":Send, !{F4}

    Case "c":MsgBox, %kpressedKey% is unassigned.

    Case "comma":MsgBox, %pressedKey% is unassigned.

    ;Open the Desktop folder.
    Case "d":Run, explorer %A_Desktop%

    Case "delete":MsgBox, %pressedKey% is unassigned.

    ;Sends the normal down key, to be used in conjunction with Left and Right.
    Case "down":Send, {Down}

    ;Ejects the First Item in the Eject List on the Taskbar.
    Case "e":
    Send, #b
    Sleep 200
    Send, {Right}
    Sleep 200
    Send, {Enter}
    Sleep 200
    Send, {Down 2}
    Sleep 200
    Send, {Enter}
    return

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

    Case "i":MsgBox, %pressedKey% is unassigned.

    Case "insert":MsgBox, %pressedKey% is unassigned.

    ;Open the C: drive.
    Case "j":Run, explorer.exe "C:\"

    ;Open the D: drive.
    Case "k":Run, explorer.exe "D:\"

    ;Open the G: drive.
    Case "l":Run, explorer.exe "G:\"

    ;Ctrl + Left. Common keeb shortcut for moving between words in text.
    Case "left":Send, ^{Left}

    Case "leftbracket":MsgBox, %pressedKey% is unassigned.

    Case "m":MsgBox, %pressedKey% is unassigned.

    Case "minus":MsgBox, %pressedKey% is unassigned.

    ;Open Notepad.
    Case "n":Run, notepad.exe

    Case "num0":MsgBox, %pressedKey% is unassigned.

    ;Shift + End.
    Case "num1":Send, +{End}

    Case "num2":MsgBox, %pressedKey% is unassigned.

    Case "num3":MsgBox, %pressedKey% is unassigned.

    ;Shift + Left.
    Case "num4":Send, +{Left}

    Case "num5":MsgBox, %pressedKey% is unassigned.

    Case "numClear":MsgBox, %pressedKey% is unassigned.

    ;Shift + Right.
    Case "num6":Send, +{Right}

    ;Shift + Home.
    Case "num7":Send, +{Home}

    Case "num8":MsgBox, %pressedKey% is unassigned.

    Case "num9":MsgBox, %pressedKey% is unassigned.

    ;Ctrl + Shift + Left.
    Case "numDiv":Send, ^+{Left}

    ;Ctrl + Shift + Right.
    Case "numMult":Send, ^+{Right}

    Case "o":MsgBox, %pressedKey% is unassigned.

    Case "p":MsgBox, %pressedKey% is unassigned.

    Case "pagedown":MsgBox, %pressedKey% is unassigned.

    Case "pageup":MsgBox, %pressedKey% is unassigned.

    Case "period":MsgBox, %pressedKey% is unassigned.

    Case "q":MsgBox, %pressedKey% is unassigned.

    ;Reload either the Main Script or this Script.
    Case "r":
    blankOutKeyTxtFile()
    Reload
    return

    ;Ctrl + Right. Common keeb shortcut for moving between words in text.
    Case "right":Send, ^{Right}

    Case "rightbracket":MsgBox, %pressedKey% is unassigned.

    ;Open Music folder.
    Case "s":Run, explorer C:\Users\Elliott\Music

    Case "semicolon":MsgBox, %pressedKey% is unassigned.

    Case "singlequote":MsgBox, %pressedKey% is unassigned.

    ;Suspends the hotkeys of the Main Script and Advanced Window Hider. Hopefully won't/shouldn't do anything if they aren't running. Press space again to un-suspend.
    ;This is taken care of in Main Script.ahk
    Case "space":

    Case "slash":MsgBox, %pressedKey% is unassigned.

    Case "t":MsgBox, %pressedKey% is unassigned.

    Case "u":MsgBox, %pressedKey% is unassigned.

    ;Sends the normal up key, to be used in conjunction with Left and Right.
    Case "up":Send, {Up}

    Case "v":MsgBox, %pressedKey% is unassigned.

    Case "w":MsgBox, %pressedKey% is unassigned.

    ;Redo.
    Case "x":Send, ^y

    Case "y":MsgBox, %pressedKey% is unassigned.

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