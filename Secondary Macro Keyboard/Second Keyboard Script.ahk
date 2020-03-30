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

    Case "a":

    Case "b":

    Case "c":

    Case "comma":

    ;Open the Desktop folder.
    Case "d":Run, explore %A_Desktop%

    Case "delete":

    ;Sends the normal down key, to be used in conjunction with Left and Right.
    Case "down":Send, {Down}

    Case "e":

    Case "end":

    Case "enter":

    Case "equals":

    ;Open the AHK repo folder.
    Case "f":Run, explore C:\Users\Elliott\Documents\GitHub\AutoHotkey

    Case "F10":

    Case "F11":

    Case "F12":

    Case "F5":

    Case "F6":

    Case "F7":

    Case "F8":

    Case "F9":

    Case "g":

    Case "h":

    Case "home":

    Case "i":

    Case "insert":

    Case "j":

    Case "k":

    Case "l":

    ;Ctrl + Left. Common keeb shortcut for moving between words in text.
    Case "left":Send, ^{Left}

    Case "leftbracket":

    ;Open Music folder.
    Case "m":Run, explore C:\Users\Elliott\Music

    Case "minus":

    Case "n":

    Case "num0":

    ;Shift + End.
    Case "num1":
    MsgBox num1 lol
    Send, +{End}

    Case "num2":

    Case "num3":

    ;Shift + Left.
    Case "num4":Send, +{Left}

    Case "num5":

    Case "numClear":MsgBox numClear lol

    ;Shift + Right.
    Case "num6":Send, +{Right}

    ;Shift + Home.
    Case "num7":Send, +{Home}

    Case "num8":

    Case "num9":

    Case "numDiv":

    Case "numMult":

    Case "o":

    Case "p":

    Case "pagedown":

    Case "pageup":

    Case "period":

    Case "q":

    ;Reload either the Main Script or this Script.
    Case "r":
    blankOutKeyTxtFile()
    Reload
    return

    ;Ctrl + Right. Common keeb shortcut for moving between words in text.
    ; Case "right":Send, ^{Right}

    Case "rightbracket":

    Case "s":

    Case "semicolon":

    Case "singlequote":

    ;Suspends the hotkeys of the Main Script and Advanced Window Hider. Hopefully won't/shouldn't do anything if they aren't running. Press space again to un-suspend.
    ;This is taken care of in Main Script.ahk
    Case "space":

    Case "slash":

    ;Open the Documents folder.
    Case "t":Run, explore %A_MyDocuments%

    ; Case "u":

    ;Sends the normal up key, to be used in conjunction with Left and Right.
    Case "up":Send, {Up}

    Case "v":

    Case "w":

    Case "x":

    Case "y":

    Case "z":

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