#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk

QuickCodeGUIVisibility := 0 ;0 = hidden, 1 = shown

GUI, +AlwaysOnTop
GUI, Font, s9
GUI, Add, Text, x3 y3, Enter code to run:
GUI, Add, Edit, vQuickCodeEdit xp-2 y20 w196 h190
GUI, Add, Button, xp y215 gQuickCodeDoneButton, &Done
return ;Auto-execute end.

QuickCodeDoneButton:
    QuickCodeGUIVisibility := 0
    GUI, Submit ;Get text from edit box.
    if (QuickCodeEdit == "") ;Don't run the empty file.
        Tippy("Nothing entered in Quick Code GUI.", 1000)
    else
    {
        FileDelete, Temp Script.ahk ;Reset file.
        FileAppend, %QuickCodeEdit%, Temp Script.ahk
        Run, Temp Script.ahk
    }
return

#q::
    FileRead, tempScriptContents, Temp Script.ahk
    GuiControl,, QuickCodeEdit, %tempScriptContents%
    QuickCodeGUIVisibility := !QuickCodeGUIVisibility
    if (QuickCodeGUIVisibility == 1)
        GUI, Show, w200 h238, Quick Code
    else
        GUI, Hide
return

#!q:: ;Close Temp Script.ahk. https://www.autohotkey.com/docs/commands/PostMessage.htm#ExPID
    SetTitleMatchMode, 2
    DetectHiddenWindows, On
    SendMessage, 0x44, 0x405, 0, , Temp Script.ahk - AutoHotkey v
    WinClose, ahk_pid %ErrorLevel%
return