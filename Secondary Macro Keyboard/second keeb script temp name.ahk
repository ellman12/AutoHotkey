#NoEnv
SendMode Input
#InstallKeybdHook
#UseHook On
Menu, Tray, Icon, shell32.dll, 283 ;Changes the tray icon to a little keyboard.
#SingleInstance force
#MaxHotkeysPerInterval 2000

;This is my custom, modified version of this script: https://github.com/TaranVH/2nd-keyboard/tree/master/LUAMACROS

~F24::
FileRead, pressedKey, C:\Users\Elliott\Documents\keypressed.txt

MsgBox %pressedKey%

Switch (pressedKey) {

    Case "o":

    Case "p":

    Case "i":

    Case "leftbracket":

    Case "rightbracket":

    Case "y":

    Case "u":

    Case "m":

    Case "j":

    Case "n":

    Case "comma":

    Case "h":

    Case "k":

    Case "period":

    Case "slash":

    Case "singlequote":

    Case "semicolon":

    Case "l":

    Case "F6":

    Case "F7":

    Case "F8":

    Case "F9":

    Case "F10":

    Case "F11":

    Case "F12":

    Case "F5":

    Case "insert":

    Case "home": 

    Case "pageup":

    Case "delete":

    Case "end":

    Case "pagedown":

    Case "q":

    Case "w":

    Case "e":

    Case "a":

    Case "s":

    Case "d":

    Case "z":

    Case "x":

    Case "c":

    Case "minus":

    Case "equals":

    Case "r":

    Case "f":

    Case "v":

    Case "t":

    Case "g":

    Case "b":

    Case "up":

    Case "left":

    Case "down":

    Case "right":

    Case "enter":

    Case "num0": 

    Case "num1":

    Case "num2":

    Case "num3":

    Case "num4":

    Case "num5":

    Case "num6":

    Case "num7":

    Case "num8":

    Case "num9":

    Case "numDiv":

    Case "numMult":

    Default:
        MsgBox, 262160, Error. Unknown Key., Unknown key pressed. It's probably not programmed in the AHK Script.

} ;End of the Switch statement.
return