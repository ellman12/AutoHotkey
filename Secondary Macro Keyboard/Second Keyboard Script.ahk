#NoEnv
SendMode Input
#InstallKeybdHook
#UseHook On
Menu, Tray, Icon, shell32.dll, 283 ;Changes the tray icon to a little keyboard.
#SingleInstance force
#MaxHotkeysPerInterval 2000

;This is my custom, modified version of this script: https://github.com/TaranVH/2nd-keyboard/tree/master/LUAMACROS
;It has been heavily improved and customized to work with my needs, and my secondary macro keyboard.

;Get this virtual key press from LuaMacros, and read the file that it wrote text to.
~F24::
FileRead, pressedKey, C:\Users\Elliott\Documents\keypressed.txt

;See which key was pressed, and act on that.
Switch (pressedKey) {

    Case "a":

    Case "b":

    Case "c":

    Case "comma":

    Case "d":

    Case "delete":

    Case "down":

    Case "e":

    Case "end":

    Case "enter":

    Case "equals":

    Case "f":

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

    Case "left":

    Case "leftbracket":

    Case "m":

    Case "minus":

    Case "n":

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

    Case "o":

    Case "p":

    Case "pagedown":

    Case "pageup":

    Case "period":

    Case "q":

    Case "r":

    Case "right":

    Case "rightbracket":

    Case "s":

    Case "semicolon":

    Case "singlequote":

    Case "space":

    Case "slash":

    Case "t":

    Case "u":

    Case "up":

    Case "v":

    Case "w":

    Case "x":

    Case "y":

    Case "z":

    Default:
        MsgBox, 262160, Error. Unknown Key., %pressedKey% is an unknown key. It's probably not programmed in the AHK Script.

} ;End of the Switch statement.
return