;This script allows me to run and do miscellaneous things that don't deserve their own (hot)key,
; or things that would be messy and/or annoying to do via (hot)keys.

;Alt + R opens the InputBox, which allows the user to type a command. It also contains a cheat sheet of all of the commands, in alphabetical order.
;This one single line is astronomically enormous, so Word Wrap is recommended.
!r::
InputBox, runInputBoxText, Type a Command,,, 200, 100

;The script decides which command to run.
Switch (runInputBoxText) {

    ;***********************************************DATE***********************************************
    ;************DATE STUFF FOR YESTERDAY************
    Case "da y": ;9/11/200
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

    ;************DATE STUFF FOR TODAY************
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

    ;************DATE STUFF FOR TOMORROW************
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

    ;***********************************************INSERT***********************************************
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
    Case "deg": Send, {U+00B0} ;°
    Case "micro": Send, {U+00B5} ;µ
    Case "inf": Send, {U+221E} ;∞
    Case "...": Send, {U+2026} ;…
    Case "theta": Send, {U+03B8} ;θ

    ;Sends either an em or en dash.
    Case "en": Send, {U+2013} ;–
    Case "em": Send, {U+2014} ;—

    ;Misc.
    Case "sec": Send, {U+00A7} ;§
    Case "check": Send, {U+2713} ;✓
    Case "x": Send, {U+2717} ;✗

    ;Emails.
    Case "2mail": Send, bobb71013@gmail.com
    Case "DSU": Send, Elliott.DuCharme@trojans.dsu.edu
    Case "mail": Send, ellduc4@gmail.com

    ;Arrows.
    Case "u", "up": Send, {U+2191} ;↑
    Case "r", "right": Send, {U+2192} ;→
    Case "d", "down": Send, {U+2193} ;↓
    Case "l", "left": Send, {U+2190} ;←

    ;***********************************************MISC***********************************************
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
    Case "z":
    Send, #x
    Sleep, 250
    Send, {Up 2}
    Send, {Right}s
    return

    ;Hibernate PC.
    Case "zz":
    Send, #x
    Sleep, 250
    Send, {Up 2}
    Send, {Right}h
    return

    ;Shut down PC.
    Case "sd":
    Send, #x
    Sleep, 250
    Send, {Up 2}
    Send, {Right}u
    return

    ;Restart PC.
    Case "rs":
    Send, #x
    Sleep, 250
    Send, {Up 2}
    Send, {Right}r
    return

    ;If the user presses Escape or Cancel.
    Default:
    if ErrorLevel = 1
        Tippy("Cancel/Escape was pressed.", 500)
    else
        MsgBox, 16, Unknown command, Command entered: "%runInputBoxText%" does not exist.

    ;***********************************************OPEN***********************************************
    ;Opens Desmos graphing calculator.
    Case "des": Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.desmos.com/calculator

    ;Opens the Google spreadsheet for this script in Chrome, which contains all of the commands in a table.
    Case "Help", "Help Sheet", "Sheet Help": Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://docs.google.com/spreadsheets/d/1vGHwAVQwkmzGGpM_xQJ86RGXfsBiBxDD089cu1u02eA/edit#gid=17759502

    ;Help <category> things.
    Case "Help Date", "Date Help":
    return

    Case "Help Insert", "Insert Help":
    return

    Case "Help Misc", "Help Misc.", "Misc Help", "Misc. Help":
    return

    Case "Help Open", "Open Help":
    return

    Case "MB":Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\MSR Stuff\Misc. MSR Scripts\MsgBox Creator.ahk
    Case "CN", "Num", "NumPad":Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\MSR Stuff\Custom NumPad\Custom NumPad.ahk

    ;Open the documentation in either Firefox or Chrome
    Case "docu", "docu ff":
    RunWait, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
    Sleep 1000
    Send, !s
    return

    Case "docu chr":
    RunWait, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.autohotkey.com/docs/AutoHotkey.htm
    Sleep 1000
    Send, !s
    return

    ;Opens the current tab in Chrome
    Case "op in chr":
    Send, ^l
    Sleep, 80
    Send, ^c
    Sleep 80
    Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %Clipboard%
    return

    ;Opens the current tab in Firefox
    Case "op in Firefox":
    Send, ^l
    Sleep, 80
    Send, ^c
    Sleep 80
    Run, "C:\Program Files\Mozilla Firefox\firefox.exe" %Clipboard%
    return

    ;Open thesaurus.com in Chrome and search for the inputted word
    Case "Thes Chr":
    InputBox, Thes_ChrInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Chrome.
    Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" https://www.thesaurus.com/browse/%Thes_ChrInputBox%
    return

    ;Open thesaurus.com in Firefox and search for the inputted word
    Case "Thes", "Thes ff", "thes Firefox":
    InputBox, Thes_FFInputBox, Search for This Word on Thesaurus.com, Type the word you want to search on Thesaurus.com in Firefox.
    Run, "C:\Program Files\Mozilla Firefox\firefox.exe" https://www.thesaurus.com/browse/%Thes_FFInputBox%
    return

    ;***********************************************TEMPORARY???***********************************************
    Case "kre":Send, Kind regards,{Enter 2}Elliott
    Case "kred":Send, Kind regards,{Enter 2}Elliott DuCharme
    Case "fwd":Send, m{Tab}d{Tab}{Enter}

    ;Searches for the selected text in a private Firefox window with Google Images.
    ;This is taken from the 2nd keeb script.
    Case "pr i":
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

    ;Searches for the selected text in a private Firefox window with Google.
    ;This is taken from the 2nd keeb script.
    Case "pr", "pr g":
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

}

return

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