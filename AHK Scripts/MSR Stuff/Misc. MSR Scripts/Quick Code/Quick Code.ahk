;GUI initialization is in MSR.
;Let's say you want to make a quick and temporary hotkey/hotstring or two, or run some other code stuff, but you don't want to go digging through MSR or another file.
;This stuff allows you to enter in stuff that will be written to a temp .ahk file, which is then ran by using the Run command.

QuickCodeDoneButton:
    QuickCodeGUIVisibility := 0
    GUI, QuickCodeGUI:Submit ;Get text from edit box.
    if (QuickCodeEdit == "") ;Don't run the empty file.
        Tippy("Nothing entered in Quick Code GUI.", 1000)
    else
    {
        FileDelete, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Quick Code\Temp Script.ahk ;Reset (overwrite) the file.
        FileAppend, %QuickCodeEdit%, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Quick Code\Temp Script.ahk

        GoSub, #+q ;Close the script to avoid the annoying thing about an instance already running.
        Run, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Quick Code\Temp Script.ahk
    }
return

;Show the GUI, and whatever is already in the file, fill in the Edit control.
#q::
    FileRead, tempScriptContents, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Quick Code\Temp Script.ahk
    GuiControl, QuickCodeGUI:, QuickCodeEdit, %tempScriptContents%

    QuickCodeGUIVisibility := !QuickCodeGUIVisibility
    if (QuickCodeGUIVisibility == 1)
        GUI, QuickCodeGUI:Show, w200 h238, Quick Code
    else
        GUI, QuickCodeGUI:Hide
return

#+q:: ;Close Temp Script.ahk. https://www.autohotkey.com/docs/commands/PostMessage.htm#ExPID
    SetTitleMatchMode, 2
    DetectHiddenWindows, On
    SendMessage, 0x44, 0x405, 0, , Temp Script.ahk - AutoHotkey v
    WinClose, ahk_pid %ErrorLevel%
return