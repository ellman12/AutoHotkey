;This script allows me to run and do miscellaneous things that don't deserve their own hotkey,
;or things that would be messy and/or annoying to do via hotkeys, such as inserting symbols, dates, the time, etc.

;Put this here because I think it just fits here.
;This annoying key is disabled. However, it can be used to trigger 2nd keyboard hotkeys even without having the 2nd keeb physically in front of me.
*CapsLock::return

^CapsLock:: ;Repeats previous command. Useful when you specifically know what the previous command is.
if (runInputBoxText in z,h,sd,rs) ;Disable accidentally telling the PC to sleep.
    Tippy("Sleep macros are disabled for ^CapsLock...", 1300)
else
    runCommand(runInputBoxText)
return

;Open the command InputBox, and then does what the user entered.
!r::
if (runInputBoxText == "")
    message := "No previous command."
else
    message = Prev cmd: "%runInputBoxText%"

InputBox, runInputBoxText, Type a Command, %message%,, 200, 130,,,,, %runInputBoxText%

if (ErrorLevel == 1)
    Tippy("Cancel/Escape was pressed.", 500)
else
    runCommand(runInputBoxText)
return ;End of !r.

;***********************************FUNCTIONS***********************************
;Function used for sending yesterday's date in different formats.
getYesterdayDate() {
    global
    formattedDateTime = %a_now%
    formattedDateTime += -1, days
}

;Function used for sending tomorrow's date in different formats.
getTmrDate() {
    global
    formattedDateTime = %a_now%
    formattedDateTime += +1, days
}

;Function that runs the specified command.
runCommand(cmdToRun) {

Switch (cmdToRun) {

    Default:
    if cmdToRun = ;Mainly for the ^CapsLock command. If the user tries to repeat a command without having done a command before, it won't do anything.
        Tippy("No previous Run command.", 2000)
    else if InStr(cmdToRun, "YT")
    {
        args := SubStr(cmdToRun, 3) ;Cut out this part and pass in the rest as args.
        Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Run\YT.ahk %args%
    }
    else
    {
        MsgBox, 16, Unknown Command., Command entered: "%cmdToRun%" does not exist.
        Gosub, !r ;Have the user try again.
    }
    return

    ;***********************************************DATE***********************************************
    ;********************DATE STUFF FOR YESTERDAY********************
    Case "da y": ;9/11/20
    getYesterdayDate()
    FormatTime, formattedDateTime, %formattedDateTime%, M/d/yy ;9/12/20
    SendInput, %formattedDateTime%
    return

    Case "da sh y":
    getYesterdayDate()
    FormatTime, formattedDateTime, %formattedDateTime%, ddd, MMM d ;Sat, Sep 12
    SendInput, %formattedDateTime%
    return

    Case "da lo y":
    getYesterdayDate()
    FormatTime, formattedDateTime, %formattedDateTime%, ddd, MMM d, yyyy ;Sat, Sep 12, 2020
    SendInput, %formattedDateTime%
    return

    Case "da longer y":
    getYesterdayDate()
    FormatTime, formattedDateTime, %formattedDateTime%, dddd, MMMM d ;Saturday, September 12
    SendInput, %formattedDateTime%
    return

    Case "da longest y":
    getYesterdayDate()
    FormatTime, formattedDateTime, %formattedDateTime%, dddd, MMMM d, yyyy ;Saturday, September, 12, 2020
    SendInput, %formattedDateTime%
    return

    ;********************DATE STUFF FOR TODAY********************
    Case "dt":
    FormatTime, formattedDateTime,, M/d/yyyy h:mm tt ;9/13/2020 6:05 PM
    SendInput, %formattedDateTime%
    return

    Case "ti":
    FormatTime, formattedDateTime,, h:mm tt ;6:05 PM
    SendInput, %formattedDateTime%
    return

    Case "da":
    FormatTime, formattedDateTime,, M/d/yyyy ;9/13/2020
    SendInput, %formattedDateTime%
    return

    Case "da sh":
    FormatTime, formattedDateTime,, ddd, MMM d ;Sun, Sep 13
    SendInput, %formattedDateTime%
    return

    Case "da lo":
    FormatTime, formattedDateTime,, ddd, MMM d, yyyy ;Sun, Sep 13, 2020
    SendInput, %formattedDateTime%
    return

    Case "da longer":
    FormatTime, formattedDateTime,, dddd, MMMM d ;Sunday, September 13
    SendInput, %formattedDateTime%
    return

    Case "da longest":
    FormatTime, formattedDateTime,, dddd, MMMM d, yyyy ;Sunday, September 13, 2020
    SendInput, %formattedDateTime%
    return

    ;********************DATE STUFF FOR TOMORROW********************
    ;https://www.autohotkey.com/boards/viewtopic.php?t=10497
    Case "da t": ;9/13/20
    getTmrDate()
    FormatTime, formattedDateTime, %formattedDateTime%, M/d/yy ;9/14/20
    SendInput, %formattedDateTime%
    return

    Case "da sh t":
    getTmrDate()
    FormatTime, formattedDateTime, %formattedDateTime%, ddd, MMM d ;Mon, Sep 14
    SendInput, %formattedDateTime%
    return

    Case "da lo t":
    getTmrDate()
    FormatTime, formattedDateTime, %formattedDateTime%, ddd, MMM d, yyyy ;Mon, Sep 14, 2020
    SendInput, %formattedDateTime%
    return

    Case "da longer t":
    getTmrDate()
    FormatTime, formattedDateTime, %formattedDateTime%, dddd, MMMM d ;Monday, September 14
    SendInput, %formattedDateTime%
    return

    Case "da longest t":
    getTmrDate()
    FormatTime, formattedDateTime, %formattedDateTime%, dddd, MMMM d, yyyy ;Monday, September 14, 2020
    SendInput, %formattedDateTime%
    return

    ;**************************************************INSERT**************************************************
    ;Lots of misc. math symbols.
    Case "+-": Send, {U+00B1} ;±
    Case "-+": Send, {U+2213} ;∓
    Case "mult": Send, {U+00D7} ;×
    Case "div": Send, {U+00F7} ;÷
    Case "sqrt": Send, {U+221A} ;√
    Case "int": Send, {U+222B} ;∫
    Case "int top": Send, {U+2320} ;⌠
    Case "int bot": Send, {U+2321} ;⌡
    Case "approx": Send, {U+2248} ;≈
    Case "/=", "=/": Send, {U+2260} ;≠
    Case "<=": Send, {U+2264} ;≤
    Case ">=": Send, {U+2265} ;≥
    Case "delta": Send, {U+0394} ;Δ
    Case "pi": Send, {U+03C0} ;π
    Case "micro": Send, {U+00B5} ;µ
    Case "inf": Send, {U+221E} ;∞
    Case "...": Send, {U+2026} ;…
    Case "theta": Send, {U+03B8} ;θ

    ;Degree/temperature characters.
    Case "deg": Send, {U+00B0} ;°
    Case "degf": Send, {U+2109} ;℉
    Case "degc": Send, {U+2103} ;℃

    ;Sends either an em or en dash.
    Case "en": Send, {U+2013} ;–
    Case "em": Send, {U+2014} ;—

    ;Misc.
    Case "sec": Send, {U+00A7} ;§
    Case "check": Send, {U+2713} ;✓
    Case "x": Send, {U+2717} ;✗

    ;Emails.
    Case "2mail": Send, bobb71013@gmail.com
    Case "mail": Send, ellduc4@gmail.com

    ;Arrows.
    Case "u", "up": Send, {U+2191} ;↑
    Case "r", "right": Send, {U+2192} ;→
    Case "d", "down": Send, {U+2193} ;↓
    Case "l", "left": Send, {U+2190} ;←

    ;Titles/headers.
    Case "t":Send, {* 50}
    Case "h1":Send, {* 35}
    Case "h2":Send, {* 20}
    Case "h3":Send, {* 14}
    Case "h4":Send, {* 9}

    ;Sends the contents of the Clipboard.
    Case "paste":SendRaw, %Clipboard%

    ;**************************************************MISC**************************************************
    Case "/":Clipboard := StrReplace(Clipboard, "\", "/") ;Replace '\' in the Clipboard with '/'.
    Case "\":Clipboard := StrReplace(Clipboard, "/", "\") ;Vice versa.

    ;Get free space in GB(ish) of all the drives.
    Case "st":
        DriveGet, OutputVar, List, Fixed ; get drive letters
        Loop, Parse, OutputVar ; extract single drive letters
        {
            DriveSpaceFree, FreeSpace, %A_LoopField%:\
            FreeSpace := FreeSpace / 1000
            FreeSpace := Round(FreeSpace, 2) ;Convert to GB and round to 2 decimal places.
            Total := (Total . A_LoopField ":\     " FreeSpace " GBish free" "`n") ; create list
        }
        StringTrimRight, Total, Total, 1 ; get rid of tailing linefeed char

        MsgBox, 0, Drive Stats, Drive Stats`n`n%Total%
    return

    Case "Exit": ExitApp

    ;Sleep PC.
    Case "z":sleepPC("s")

    ;Hibernate PC.
    Case "h":sleepPC("h")

    ;Shut down PC.
    Case "sd":sleepPC("u")

    ;Restart PC.
    Case "rs":sleepPC("r")

    Case "task failed":MsgBox, 64, Windows XP, Task failed successfully. ;Yes.

    ;Look through the entire repo and recycle any .tmp files.
    Case "tmp clr", "clr tmp":
    Loop, Files, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\*, DFR
    {
        if (A_LoopFileExt == "tmp")
            FileRecycle, %A_LoopFileLongPath%
            if ErrorLevel = 1
                MsgBox, 262160, Error, Something happened while recycling a .tmp file in %A_LoopFileLongPath%
    }
    return

    Case "FAR": ;Stands for Find and Replace.
    InputBox, textToSearch, Search what?, Enter the text to search.
    if ErrorLevel = 1
        return

    InputBox, find, Find what?, Enter text to search for.
    if ErrorLevel = 1
        return

    InputBox, replace, Find what?, Enter text to replace "%find%" with, and then store to the Clipboard.
    if ErrorLevel = 1
        return

    newStr := StrReplace(textToSearch, find, replace)
    Clipboard := newStr
    return

    ; ;Usually used for swapping 2 different lines/sections/blocks of code.
    ; Case "swap":
    ; Clipboard :=
    ; ToolTip, Copy the first item(s).
    ; ClipWait
    ; firstClipboard := Clipboard

    ; Clipboard :=
    ; ToolTip, Copy the second item(s).
    ; ClipWait
    ; secondClipboard := Clipboard

    ; ToolTip, Paste the second
    ; return

    ;**************************************************OPEN**************************************************
    Case "bin": Run, ::{645ff040-5081-101b-9f08-00aa002f954e} ;Open Recycle Bin.
    Case "ctrl pan": Run, ::{21ec2020-3aea-1069-a2dd-08002b30309d} ;Open Control Panel.

    ;Opens my Math Notes album in Google Photos.
    Case "math":Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://photos.google.com/share/AF1QipPJWlaAritAARM-nFHMzvyGtSvGSkp-vcZDMFIc2IlNfaDX6-LEO6E-wVHJU-fBFg?key=S01rOFpZUmx0WGtsQ2VQdGlsM3ZIRHdsZWpOSkpR

    ;Opens Desmos graphing calculator in Firefox.
    Case "des": Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.desmos.com/calculator

    ;Opens the help .txt file for CWG.
    Case "CWG": Run, notepad.exe C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Run\Custom Window Groups Help.txt

    ;Opens the help .txt file for the MS To Do hotkeys.
    Case "todo", "to do": Run, notepad.exe C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Run\MS To Do Help.txt

    Case "30":Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\30 Clipboards Script\30 Clipboards.ahk
    Case "CN", "Num", "NumPad":Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Custom NumPad\Custom NumPad.ahk
    Case "MB":Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\MsgBox Creator.ahk

    ;Opens the current tab in Chrome.
    Case "op in chr":
    Send, ^l
    Sleep, 80
    Send, ^c
    Sleep 80
    Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %Clipboard%
    return

    ;Opens the current tab in Firefox.
    Case "op in Firefox":
    Send, ^l
    Sleep, 80
    Send, ^c
    Sleep 80
    Run, "C:\Program Files\Mozilla Firefox\firefox.exe" %Clipboard%
    return

    ;Open thesaurus.com in Chrome and search for the inputted word.
    Case "Thes Chr":
    InputBox, Thes_ChrInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Chrome.
    Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.thesaurus.com/browse/%Thes_ChrInputBox%
    Thes_ChrInputBox :=
    return

    ;Open thesaurus.com in Firefox and search for the inputted word.
    Case "Thes", "Thes ff", "thes Firefox":
    InputBox, Thes_FFInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Firefox.
    Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/browse/%Thes_FFInputBox%
    Thes_FFInputBox :=
    return

    Case "vs":Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\AutoHotkey

    Case "vs dsu":Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Computer-Science-Classes

    ;TEMP
    Case "234": Run, C:\Users\Elliott|AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Computer-Science-Classes\Year 1 Semester 2\CSC 234 Software Security
    Case "260": Run, C:\Users\Elliott|AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Computer-Science-Classes\Year 1 Semester 2\CSC 260 Object Oriented Design
    Case "300": Run, C:\Users\Elliott|AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Computer-Science-Classes\Year 1 Semester 2\CSC 300 Data Structures
    Case "328": Run, C:\Users\Elliott|AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Computer-Science-Classes\Year 1 Semester 2\CSC 328 Operating Environments

    Case "vs py": Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Python-3-Projects
    Case "vs pss": Run, C:\Users\Elliott\AppData\Local\Programs\Microsoft VS Code/Code.exe C:\Users\Elliott\Documents\GitHub\Photos-Storage-Server

    ;Open YouTube website.
    ; Case "yt", "yt ff", "yt Firefox":Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.youtube.com/
    Case "yt chr":Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.youtube.com/

    }
}