#NoEnv                      ;Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance FORCE       ;Skip invocation dialog box and silently replace previously executing instance of this script.
SendMode Input              ;Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ;Ensures a consistent starting directory.

;This script takes the useless CapsLock key, and makes it a modifier key.
;Original idea and some code: https://www.howtogeek.com/446418/how-to-use-caps-lock-as-a-modifier-key-on-windows/

SetCapsLockState, Off

;CapsLock processing. Must double tap CapsLock to toggle CapsLock mode on or off.
CapsLock::

    ;Wait forever until Capslock is released.
    KeyWait, CapsLock

    ;ErrorLevel = 1 if CapsLock not down within 0.9 seconds.
    KeyWait, CapsLock, D T0.9

    ;Is a double tap on CapsLock?
    if ((ErrorLevel = 0) && (A_PriorKey = "CapsLock") ) {

        ;Toggle the state of CapsLock, and its LED.
        SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"
    }

return

;If CapsLock somehow gets stuck in the On state, this forces it off.
#f::
SetCapsLockState, Off
return

;*******************************CAPSLOCK HOTKEYS*******************************
;Template:
;CapsLock & x::
    ;Run stuff...
;return

;Open Firefox and Google the selected text
CapsLock & g::
clipboardGet()
Run, http://www.google.com/search?q=%Clipboard%
clipboardRestore()
return

;Open Firefox and Google Images search for the selected text.
CapsLock & i::
clipboardGet()
Run, http://www.images.google.com/search?q=%Clipboard%
clipboardRestore()
return

;*******************************CAPSLOCK FUNCTIONS*******************************
clipboardGet() {
    ;Save existing Clipboard, to be restored later.
    oldClipboard := ClipboardAll
    Clipboard:= ""

    ;Copy selected text to Clipboard.
    Send, ^c
    ClipWait 0
    If ErrorLevel
        {
        MsgBox, No Text Selected!
        Return
        }
}

;Restores the Clipboard to what it originally was.
clipboardRestore() {
    Clipboard := oldClipboard
}