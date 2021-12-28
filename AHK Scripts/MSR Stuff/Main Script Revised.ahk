;///////////////////////////////////////////////////////////////////////
;File: Main Script Revised.ahk
;///////////////////////////////////////////////////////////////////////
;Programmer: Elliott DuCharme
;///////////////////////////////////////////////////////////////////////
/*
* Important Acronyms, Contractions, Etc.:
* MRS: Main Script Revised
* TC: Title Capitalization
* YT: YouTube
* Keeb: keyboard
* CWG: Custom Window Groups
* ApplSwitch: ApplicationSwitcher
* Chr Typing: Chromebook Typing
* MP: Matching Pairs

* Conventions for the number of * for a title/header. These can be inserted via Run.ahk
* Title:    50 **************************************************
* Header 1: 35 ***********************************
* Header 2: 20 ********************
* Header 3: 14 **************
* Header 4: 9  *********
*/
;///////////////////////////////////////////////////////////////////////

;Pic of all these icons: https://diymediahome.org/wp-content/uploads/shell32_icons.jpg
Menu, Tray, Icon, shell32.dll, 233 ;Changes the icon to a cute little computer.

#NoEnv
#UseHook
#MaxHotkeysPerInterval 999999999999999999999999999999999
#HotkeyInterval 99999999999999999999999999999999999
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DetectHiddenWindows, Off
#SingleInstance force

OnExit, onExitLabel ;Dump groups to a .tmp file with a timestamp in case needed later.

;**************************************************AUTO-EXECUTE**************************************************
;***********************************WIN B AND WIN W INITIALIZATION***********************************
if (A_ComputerName = "Elliott-Laptop") {
    usingALaptop := true
	laptopBatteryIconX := 1432
	laptopBatteryIconY := 885
} else if (A_ComputerName = "Elliott-DSU-Lap") {
	usingALaptop := true
	laptopBatteryIconX := 1664
	laptopBatteryIconY := 1049
} else if (A_ComputerName = "Elliott-PC") {
	usingALaptop := false
} else {
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. Computer/laptop name is: %A_ComputerName%
}

if (A_ComputerName = "Elliott-Laptop") {
	WinWX := "UNKNOWN"
	WinWY := "UNKNOWN"
} else if (A_ComputerName = "Elliott-DSU-Lap") {
	WinWX := 1704
	WinWY := 1051
} else if (A_ComputerName = "Elliott-PC") {
	WinWX := 1763
	WinWY := 1056
} else {
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. A_ComputerName is: %A_ComputerName%.
}

;***********************************AUTOCORRECT GUI***********************************
;This GUI is a greatly improved version of a similar feature originally in the original script.
;If it's 1, show the GUI; if it's 0, hide it.
global ACGUIToggle := 0

global ACGUI_WIDTH := 284
global ACGUI_HEIGHT := 173

GUI, ACGUI:Color, Silver
GUI, ACGUI:+AlwaysOnTop

GUI, ACGUI:Font, s13
GUI, ACGUI:Add, Text, x4 y4, Incorrect Word
GUI, ACGUI:Add, Text, x145 yp, Correct Word
GUI, ACGUI:Add, Text, x4 y60, Hotstring Options

GUI, ACGUI:Add, Edit, x4 y25 vIncorrectEdit w130
GUI, ACGUI:Add, Edit, x145 yp vCorrectEdit w130

GUI, ACGUI:Font, s11 q5
GUI, ACGUI:Add, Checkbox, x4 y83 vStarCheck, *: Ending char not needed.
GUI, ACGUI:Add, Checkbox, x4 yp+18 vQuestionCheck, ?: Trigger when inside another word.
GUI, ACGUI:Add, Checkbox, x4 yp+18 vXCheck, X: Execute text instead of replace.

GUI, ACGUI:Font, s13 q5
GUI, ACGUI:Add, Button, x4 yp+22 w55 h29 gACFinishButton, &Finish

GUI, ACGUI:Font, s9 q5
GUI, ACGUI:Add, Edit, xp+58 yp+4 w107 vACOptions, Extra Options ;Additional, rarely-used Hotstring options like 'C', etc.
GUI, ACGUI:Add, Edit, xp+110 yp w107 vtmpStringComment, Temporary?

;***********************************CUSTOM WINDOW GROUPS***********************************
;Tracks all the window IDs for the custom groups.
global WindowGroupF6 := [] ;Stores Window IDs.
global CurrentWinF6 := 1 ;Tracks the current window you're on.
global WindowGroupF7 := []
global CurrentWinF7 := 1
global WindowGroupF8 := []
global CurrentWinF8 := 1
global WindowGroupF10 := []
global CurrentWinF10 := 1

;Declare these as 1 so the first time you press F8, it hides everything.
;If it's 1, hide windows; if it's 0, show windows.
global F6ShowHideToggle := 0
global F7ShowHideToggle := 0
global F8ShowHideToggle := 0
global F10ShowHideToggle := 0

;Load the files so user doesn't have to if there's stuff in them.
readGroupFromFile("F6", WindowGroupF6, 1)
readGroupFromFile("F7", WindowGroupF7, 1)
readGroupFromFile("F8", WindowGroupF8, 1)
readGroupFromFile("F10", WindowGroupF10, 1)

;Used for Ctrl W.ahk
global ctrlWTitles := []
global ctrlWIDs := []

readCtrlWFile("Ctrl W Titles", ctrlWTitles, "`n", 1)
readCtrlWFile("Ctrl W IDs", ctrlWIDs, "`n", 1)

;***********************************EDIT CLIPBOARD CONTENT INITIALIZATION***********************************
GUI, ECC:Font, s12
GUI, ECC:Add, Button, gclipboardFinishButton x4 y2 w80,&Finish

GUI, ECC:Font, s11
GUI, ECC:Add, Edit, HScroll wrap x4 y36 w640 h355 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard%

GUI, ECC:+AlwaysOnTop
GUI, ECC:+Resize
GUI, ECC:Color, Silver

;Toggle for showing or hiding the Clipboard GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appears when the user wants it.
showClipboardGUIToggle := 0

;***********************************SCREEN CLIPPER.AHK INITIALIZATION STUFF***********************************
Hotkey, #s, CreateCapWindow, On ;Take a screen clip with the Screen Clipper script.
SaveToFile := 1 ;Set this to 1 to save all clips with a unique name , Set it to 0 to overwrite the saved clip every time a new clip is made.
ShowCloseButton := 1 ;Set this to 1 to show a small close button in the top right corner of the clip. Set this to 0 to keep the close button, but not show it.
CoordMode, Mouse , Screen ;Use the screen as the reference to get positions from.

IfNotExist, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;if there is no folder for saved clips...
	FileCreateDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;create the folder.
SetWorkingDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;Set the saved clips folder as the working dir.
Handles := [] ;Create an array to hold the name of the different gui's.
Index := 0 ;Used as the name of the current gui cap window.

;***********************************QUICK CODE INITIALIZATION***********************************
global QuickCodeGUIVisibility := 0 ;0 = hidden, 1 = shown

GUI, QuickCodeGUI:+AlwaysOnTop
GUI, QuickCodeGUI:Font, s9
GUI, QuickCodeGUI:Add, Text, x3 y3, Enter code to run:
GUI, QuickCodeGUI:Add, Edit, vQuickCodeEdit xp-2 y20 w196 h189
GUI, QuickCodeGUI:Add, Button, xp y212 gQuickCodeDoneButton, &Done

;***********************************MSR CONTROL PANEL INITIALIZATION***********************************
;This is a GUI for MSR that allows the user to change how parts of the script work at runtime.
;File path for config .ini file.
global MSR_CONFIG_PATH := "C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\MSRConfig.ini"

readConfigFile() ;Read in the values so the controls will know what to be on start-up.

GUI, CPanel:+AlwaysOnTop
GUI, CPanel:Color, Silver
GUI, CPanel:Margin, 3, 1

;Insert, Ctrl + Insert, and Chromebook Typing.
GUI, CPanel:Font, s9 q5
GUI, CPanel:Add, Text, xm+1 ym, Insert Monitor Choice
GUI, CPanel:Add, DDL, xm ym+14 w100 vInsMonChoice, Primary Mon|Secondary Mon
GuiControl, CPanel:ChooseString, InsMonChoice, %InsMonChoice% ;These GuiControls are necessary to assign the GUI controls the values from the ini file.

GUI, CPanel:Add, Text, xp+150 ym, Ctrl + Insert Monitor Choice
GUI, CPanel:Add, DDL, xp-1 ym+14 w100 vCtrlInsMonChoice, Primary Mon|Secondary Mon|
GuiControl, CPanel:ChooseString, CtrlInsMonChoice, %CtrlInsMonChoice%

GUI, CPanel:Add, Text, xm+1 yp+27, Chromebook Typing Monitor
GUI, CPanel:Add, DDL, xm yp+14 w100 vChrBookTypeMonChoice, Primary Mon|Secondary Mon|
GuiControl, CPanel:ChooseString, ChrBookTypeMonChoice, %ChrBookTypeMonChoice%

;F3/F4 Behavior.
GUI, CPanel:Add, Text, x153 yp-14, F3/F4 Behavior
GUI, CPanel:Add, DDL, x152 y56 w100 vF3Behavior, Google Chrome|VSCode
GuiControl, CPanel:ChooseString, F3Behavior, %F3Behavior%

;Custom Window Groups.
GUI, CPanel:Add, Text, xm yp+30, F6:
GUI, CPanel:Add, Text, xm+120 yp, F7:
GUI, CPanel:Add, DDL, xm+17 yp-3 vF6Mode w94, Window Group|Window Hider
GuiControl, CPanel:ChooseString, F6Mode, %F6Mode%

GUI, CPanel:Add, Text, xm yp+26, F8:
GUI, CPanel:Add, Text, xm+120 yp, F10:
GUI, CPanel:Add, DDL, xm+17 yp-3 vF8Mode w94, Window Group|Window Hider|
GuiControl, CPanel:ChooseString, F8Mode, %F8Mode%

GUI, CPanel:Add, DDL, xm+143 yp-23 vF7Mode w94, Window Group|Window Hider
GuiControl, CPanel:ChooseString, F7Mode, %F7Mode%

GUI, CPanel:Add, DDL, xp yp+23 vF10Mode w94, Window Group|Window Hider|
GuiControl, CPanel:ChooseString, F10Mode, %F10Mode%

;Front and Back Top Mouse Buttons Behavior
GUI, CPanel:Add, Text, xm yp+27, Front and Back Top Mouse Buttons Behavior
GUI, CPanel:Add, DDL, xm yp+17 w87 vFrontMouseButtonBehavior, Double Click|Triple Click|F1|F2|F3|F4|F6|F7|F8|F10|F12
GuiControl, CPanel:ChooseString, FrontMouseButtonBehavior, %FrontMouseButtonBehavior%

GUI, CPanel:Add, DDL, xm+90 yp w87 vBackMouseButtonBehavior, Double Click|Triple Click|F1|F2|F3|F4|F6|F7|F8|F10|F12
GuiControl, CPanel:ChooseString, BackMouseButtonBehavior, %BackMouseButtonBehavior%

;F12 Behavior
GUI, CPanel:Add, Text, xm yp+28, F12 Behavior:
GUI, CPanel:Add, DDL, xp+68 yp-3 w146 vF12Behavior, Word|VSCode and Cmd Prompt|Excel|Word + Excel|Outlook|
GuiControl, CPanel:ChooseString, F12Behavior, %F12Behavior%

;G3 Scrolls Per Hotkey
GUI, CPanel:Add, Text, xm yp+28, G3 Scrolls Per Hotkey:
GUI, CPanel:Add, Edit, xm+108 yp-1 w20 h17 vG3Scrolls, %G3Scrolls%

;Double Slash hotstringsActiveToggle
GUI, CPanel:Add, Checkbox, xp+25 yp+2 vdoubleSlashToggled, // -> ? \n
GuiControl, CPanel:, doubleSlashToggled, %doubleSlashToggled%

;Temp suspend Tippy message
GUI, CPanel:Add, Checkbox, xp+57 yp vsuspendTippyToggled, #P Tippy Toggle
GuiControl, CPanel:, suspendTippyToggled, %suspendTippyToggled%

;Matching Pairs
GUI, CPanel:Add, Checkbox, xm yp+24 vmatchPairsToggled, Toggle Matching Pairs
GuiControl, CPanel:, matchPairsToggled, %matchPairsToggled%

GUI, CPanel:Font, s8 q5
GUI, CPanel:Add, Button, xp+130 yp-3 gMatchPairsButton, Matching Pairs Toggles
GUI, CPanel:Font, s9 q5

;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appears when the user wants it.
global controlPanelGUIToggle := 0

global CONTROL_PANEL_WIDTH := 291
global CONTROL_PANEL_HEIGHT := 250

;Used for testing and adding new #o stuff. Commented out normally because it doesn't need to appear at startup. Makes testing easier.
; GUI, CPanel:Show, w%CONTROL_PANEL_WIDTH% h%CONTROL_PANEL_HEIGHT% x1300,MSR Control Panel

global currentWinOMode := 1
global WIN_O_MAX_MODE := 3 ;How many modes (-1) are actually defined in the Switch statement.

;***********************************MATCHING PAIRS GUI***********************************
;This is technically part of MSR Control Panel
global MP_GUI_WIDTH := 133
global MP_GUI_HEIGHT := 123

GUI, MP:+AlwaysOnTop
GUI, MP:Color, Silver
GUI, MP:Margin, 3, 1
GUI, MP:+AlwaysOnTop

GUI, MP:Font, s8 q5
GUI, MP:Add, Button, x1 ym gCheckAllButton, Check All
GUI, MP:Add, Button, xp+60 ym gUncheckAllButton, Uncheck All

GUI, MP:Font, s10 q5
GUI, MP:Add, Checkbox, xm yp+22 vsingleQuotesToggled, ' ' Single Quotes
GuiControl, MP:, singleQuotesToggled, %singleQuotesToggled%

GUI, MP:Add, Checkbox, xm yp+20 vdoubleQuotesToggled, " " Double Quotes
GuiControl, MP:, doubleQuotesToggled, %doubleQuotesToggled%

GUI, MP:Add, Checkbox, xm yp+20 vparenthesesToggled, () Parentheses
GuiControl, MP:, parenthesesToggled, %parenthesesToggled%

GUI, MP:Add, Checkbox, xm yp+20 vsquareBracketsToggled, [] Square Brackets
GuiControl, MP:, squareBracketsToggled, %squareBracketsToggled%

GUI, MP:Add, Checkbox, xm yp+20 vcurlyBracketsToggled, {} Curly Brackets
GuiControl, MP:, curlyBracketsToggled, %curlyBracketsToggled%

global matchPairsGUIToggled := 0

;****************************************MISC VARIABLES, INITIALIZATION, ETC*********************************
global activeWindowTitle, activeWindowID

global Num2And8Step := 3 ;When Num2 or Num8 pressed, how much to increase/decrease volume.
global autoNumPadModeToggle := true ;If true, switch NumPad modes automatically. If false user manually controls it.
global savedNumMinusVol ;For NumPadSub hotkey

global programmingMode := false ;Toggle for Programming Mode: disabling certain hotkeys/hotstrings to make programming easier. ^!Insert is the hotkey.
global hotstringsActiveToggle := true ;Determines if AutoCorrect hotstrings are active or not. Active by default, obviously. ^#Insert is the hotkey.

;Used for F9 F12 on 2nd keeb for showing/hiding these programs. 1 = visible; 0 = not visible.
global OutlookVisibilityToggle := 1
global MusicBeeVisibilityToggle := 1

;If a long process is running, don't allow any sleep macros to run because that will potentially interrupt the process. 0 = not running; 1 = running.
global preventSleepToggle := 0

;Toggle if typing // sends ?{Enter} (useful for messaging services).
global doubleSlashToggled := true

;Toggle Tippy that appears when temporarily suspending hotkeys
global suspendTippyToggled := true

global matchPairsToggled := false

;The stuff in this loop needs to be running constantly.
Loop {
	WinGetActiveTitle, activeWindowTitle
	WinGet, activeWindowID, ID, A

	if InStr(activeWindowTitle, "Mozilla Firefox") ;Some profiles, like Firefox, Chrome, and VSCode have "sub modes", like Docs, Sheets, etc.
		if InStr(activeWindowTitle, " - Google Docs")
			currentProfile := "Docs"
		else if InStr(activeWindowTitle, " - Google Sheets")
			currentProfile := "Sheets"
		else
			currentProfile := "Firefox"

	else if InStr(activeWindowTitle, "Google Chrome")
		if InStr(activeWindowTitle, " - Google Docs")
			currentProfile := "Docs"
		else if InStr(activeWindowTitle, " - Google Sheets")
			currentProfile := "Sheets"
		else
			currentProfile := "Chrome"

	else if Instr(activeWindowTitle, " - Visual Studio Code")
		if InStr(activeWindowTitle, ".ahk")
			currentProfile := "AutoHotkey VSCode"
		else if InStr(activeWindowTitle, ".cpp")
			currentProfile := "C++ VSCode"
		else if InStr(activeWindowTitle, ".c")
			currentProfile := "C VSCode"
		else if InStr(activeWindowTitle, ".py")
			currentProfile := "Python VSCode"
		else if InStr(activeWindowTitle, ".cs")
			currentProfile := "C# VSCode"
		else
			currentProfile := "Generic VSCode"

	else if Instr(activeWindowTitle, "Microsoft Visual Studio")
		currentProfile := "Visual Studio"
	else if InStr(activeWindowTitle, " - Excel")
		currentProfile := "Excel"
	else if InStr(activeWindowTitle, " - Word")
		currentProfile := "Word"
	else if InStr(activeWindowTitle, "Discord")
		currentProfile := "Discord"
	else if Instr(activeWindowTitle, "Minecraft 1.1")
		currentProfile := "Minecraft"
	else if Instr(activeWindowTitle, "Terraria")
		currentProfile := "Terraria"
	else
		currentProfile := "Default"

	;********************FOR THE NUMPAD STUFF********************
	;If the auto-numpad toggle is true, set the toggles automatically.
	if (autoNumPadModeToggle = true) {
		if InStr(activeWindowTitle, "- YouTube") {
			SetNumLockState, On
			SetScrollLockState, On
		} else { ;Set it to MusicBee mode: the default (and also most commonly used) mode.
			SetNumLockState, Off
			SetScrollLockState, Off
		}
	}
	Sleep 100 ;This sleep statement DRASTICALLY helps reduce the power and CPU usage of MSR.
}

;Other files with many different hotkeys, hotstrings, and other things in them.
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\Header Files\booleanToggle.ahk
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\Header Files\inArray.ahk
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\Header Files\Tippy.ahk
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\Header Files\toggleGUI.ahk

#Include, %A_ScriptDir%\MSR Profiles\Browser.ahk
#Include, %A_ScriptDir%\MSR Profiles\Default.ahk
#Include, %A_ScriptDir%\MSR Profiles\Discord.ahk
#Include, %A_ScriptDir%\MSR Profiles\Google Docs.ahk
#Include, %A_ScriptDir%\MSR Profiles\Google Sheets.ahk
#Include, %A_ScriptDir%\MSR Profiles\Microsoft Excel.ahk
#Include, %A_ScriptDir%\MSR Profiles\Microsoft Word.ahk
#Include, %A_ScriptDir%\MSR Profiles\Visual Studio.ahk
#Include, %A_ScriptDir%\MSR Profiles\VSCode.ahk

#Include, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\Custom Window Groups.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Quick Code\Quick Code.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Run\Run.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Add Chars Around Text.ahk

#Include, %A_ScriptDir%\Misc. MSR Scripts\AutoCorrect.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Temp Hotstrings.ahk
#If ;See the end of the AutoCorrect file. This needs to be here to end the giant #If block in there. Moved to here to avoid messing up when the #h hotkey appends to that file.

#Include, %A_ScriptDir%\Misc. MSR Scripts\C-C++ Programming.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\Ctrl W.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Easy Window Dragging.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Matching Pairs.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\NumPad Media Control.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Print Screen Modifier Key.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Title Capitalization.ahk

#Include, %A_ScriptDir%\Screen Clipper Script\Screen Clipper.ahk

#Include, %A_ScriptDir%\Video Game Stuff\Minecraft.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Terraria.ahk

#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\Secondary Macro Keyboard\Hasu USB to USB Script.ahk

;This is after the 2nd keeb script because if it is #Included before it and it's enabled it breaks the keys like j, k, l, a, etc.
#Include, %A_ScriptDir%\Misc. MSR Scripts\Chromebook Typing.ahk

;****************************************MISC HOTKEYS***************************************
^#r::reloadMSR()

+#r::deleteConfigFile() ;Delete .ini file. To restart MSR with the default config values, do this and then ^#r.

^!r:: ;Delete the CWG files and then reload script (basically what ^#r used to be). Useful if I want to restart the script without restoring the CWG arrays.
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F6 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F7 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F8 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F10 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\Ctrl W Titles.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Ctrl W\Ctrl W IDs.tmp
Reload
return

;Shows you miscellaneous variables, toggles, etc.
^#BackSpace::MsgBox, 0, Misc. Variables`, Toggles`, etc., MSR Profile: %currentProfile%`n`nautoNumPadModeToggle: %autoNumPadModeToggle%

^CtrlBreak:: ;Technically Ctrl + Pause. Read about this here: https://www.autohotkey.com/docs/KeyList.htm#other
#!p::
Suspend
return

Pause:: ;Pause key or Win + p suspends all hotkeys for the specified number in milliseconds.
#p::
if (suspendTippyToggled = 1)
	ToolTip, Suspended...
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
ToolTip
return

^\::Send, \ ;This key normally deletes a word. This hotkey allows you to insert a \ without having to suspend hotkeys.

#n::Run, Notepad ;Open Notepad.

sc029::Send, !{Tab} ;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab.
^sc029::Send, `` ;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `.

!SC00C::WinMinimize, A ;Alt + -
!SC00D::WinMaximize, A ;Alt + +.

;Toggle programming mode. Disables hotkeys/hotstrings that can be annoying when programming.
^!Insert::booleanToggle(programmingMode, "Programming Mode ON", "Programming Mode Off")

;Since Windows 10 annoyingly doesn't allow you to rearrange individual windows for a program on the Taskbar when their icons are expanded out (how I always have it), I made this fantastic workaround.
;It will move the active window to the end of the "stack(?)" of windows.
;E.g., you have 2 MSWord windows open: win1 and win2. By doing this, win1 would move to be after win2. Windows 10 doesn't allow this natively.
#m::
WinHide, A
WinShow, A
return

!Insert::MouseMove, mousePosX, mousePosY, 0 ;Moves mouse pointer back to where it was before pressing Insert or ^Insert (but not both).

Insert:: ;Moves mouse pointer as far off the screen as possible (on main display).
MouseGetPos, mousePosX, mousePosY
if (InsMonChoice = "Primary Mon")
	MouseMove, 1920, 540, 0
else if (InsMonChoice = "Secondary Mon")
	MouseMove, -1920, 540, 0
return

^Insert:: ;Moves mouse pointer as far off the screen as possible (on second display).
if (CtrlInsMonChoice = "Primary Mon")
	MouseMove, 1920, 540, 0
else if (CtrlInsMonChoice = "Secondary Mon")
	MouseMove, -1920, 540, 0
return

~$RShift:: ;A "sniper" button, which slows the mouse pointer speed down to a crawl and still outputs the RShift key.
Send, {RShift}
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,1)
KeyWait, RShift
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

#w:: ;Opens Wi-Fi/network menu.
MouseGetPos, originalX, originalY
MouseMove, %WinWX%, %WinWY%, 0
Sleep 200
Send, {Click}
MouseMove, originalX, originalY
return

^+g:: ;Calculate percent grade on a homework assignment or whatever, then show result and letter grade equivalent. So, for something like 40/50, you'd enter 40 and then 50.
InputBox, firstNum, Grade Percent Utility, What is the first number?,, 200, 150
InputBox, secondNum, Grade Percent Utility, What is the second number?,, 200, 150

result := round((firstNum/secondNum) * 100, 2)
MsgBox, 0, Grade, You got %result%`%.`n`nA+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59
return

;Shows just the letter/number grades part of the MsgBox from ^+g.
!+g::MsgBox, 0, Letter/Number Grade Chart, A+`t97-100`nA`t94-96`nA-`t90-93`nB+`t87-89`nB`t84-86`nB-`t80-83`nC+`t77-79`nC`t74-76`nC-`t70-73`nD+`t67-69`nD`t64-66`nD-`t60-63`nF`t0-59

;Make active window AlwaysOnTop, and tell the user if it is or not.
^Space::
WinSet, AlwaysOnTop, Toggle, A
WinGet, onTop, ExStyle, A
if (onTop & 0x8) { ; 0x8 is WS_EX_TOPMOST.
	message := activeWindowTitle . " is AlwaysOnTop"
	Tippy(message, 1000)
} else {
	message := activeWindowTitle . " is no longer on top"
	Tippy(message, 1000)
}
return

;Easily switch the mode for the 2 top mouse buttons, without having to open the GUI.
!#Right::
currentWinOMode++
if (currentWinOMode > WIN_O_MAX_MODE)
	currentWinOMode := 1
switchWinOMode()
return

!#Left:: ;TODO: this doesn't really work... :/
currentWinOMode--
if (WIN_O_MAX_MODE > currentWinOMode)
	currentWinOMode := WIN_O_MAX_MODE
switchWinOMode()
return

;Used for !#Right and !#Left.
switchWinOMode() {
global
	Switch (currentWinOMode)
	{
		Case 1:
		GuiControl, CPanel:ChooseString, FrontMouseButtonBehavior, Double Click
		GuiControl, CPanel:ChooseString, BackMouseButtonBehavior, F6
		FrontMouseButtonBehavior := "Double Click"
		BackMouseButtonBehavior := "F6"
		Tippy("Double Click and F6", 290)
		return

		Case 2:
		GuiControl, CPanel:ChooseString, FrontMouseButtonBehavior, F6
		GuiControl, CPanel:ChooseString, BackMouseButtonBehavior, F7
		FrontMouseButtonBehavior := "F6"
		BackMouseButtonBehavior := "F7"
		Tippy("F6 and F7", 290)
		return

		Case 3:
		GuiControl, CPanel:ChooseString, FrontMouseButtonBehavior, F2
		GuiControl, CPanel:ChooseString, BackMouseButtonBehavior, F12
		FrontMouseButtonBehavior := "F2"
		BackMouseButtonBehavior := "F12"
		Tippy("F2 and F12", 290)
		return
	}
}

;***********************************DISABLE/ENABLE SLEEP MACROS***********************************
!+s::booleanToggle(preventSleepToggle, "Sleep macros disabled", "Sleep macros enabled", 900)

;Check if the user has disabled sleep macros in MSR because a long process is running and they don't want to accidentally sleep and thus interrupt said process.
;The parameter is the single character corresponding to the different options in the #x menu.
sleepPC(winXAltChar := "")
{
	global
	if (preventSleepToggle == 1)
    {
        MsgBox, 262160, Error. Cannot put PC to sleep at this time., If there are no long processes running`, disable the toggle with (Alt + s) to allow the PC to sleep, shutdown, hibernate, etc.
        return
    }
    Send, #x
    Sleep, 250
    Send, {Up 2}
    Send, {Right}%winXAltChar%
}

;****************************************GLOBAL iCUE HOTKEYS***************************************
;These 3 hotkeys are sent by the iCUE software, which AutoHotkey detects.
+F24::Send, ^c ;M1 on K95 RGB copies to the clipboard.
+F21::Send, ^x ;M2 on K95 RGB cuts to the clipboard.
+F22::Send, ^v ;M3 on K95 RGB pastes the clipboard.
; +F22::
; Send, %Clipboard%
; return

^!F23::topMouseButtons(FrontMouseButtonBehavior) ;Top Front Mouse Button on Scimitar RGB.
^+F23::topMouseButtons(BackMouseButtonBehavior) ;Top Back Mouse Button on Scimitar RGB.

;Called by top 2 mouse button hotkeys.
topMouseButtons(buttonMode) {
global

	if (buttonMode = "Double Click")
		Send, {Click 2}
	else if (buttonMode = "Triple Click")
		Send, {Click 3}
	else if (buttonMode = "F1")
		switchToFirefoxAndBetweenTabs()
	else if (buttonMode = "F2")
		switchToOtherFirefoxWindows()
	else if (buttonMode = "F3")
		F3Hotkey()
	else if (buttonMode = "F4")
		F4Hotkey()
	else if (buttonMode = "F6")
		nextWinOrShowHideWins("F6", WindowGroupF6, CurrentWinF6)
	else if (buttonMode = "F7")
		nextWinOrShowHideWins("F7", WindowGroupF7, CurrentWinF7)
	else if (buttonMode = "F8")
		nextWinOrShowHideWins("F8", WindowGroupF8, CurrentWinF8)
	else if (buttonMode = "F10")
		nextWinOrShowHideWins("F10", WindowGroupF10, CurrentWinF10)
	else if (buttonMode = "F12")
		F12Hotkey()
}

;****************************************CONTEXT-SENSITIVE HOTKEYS***************************************
#If, doubleSlashToggled = 1
; :*?X://::Send, ?{Enter}

#IfWinActive Search ;When Cortana/Search is open.
!s::Send, {Space}meaning

RWin::
Send, {LWin}
Sleep 300
Send, {LWin}
return

#If currentProfile != "Terraria" ;Terraria profile uses G3 (F15) for quick mana.

;Scroll up/down faster by holding down the G3 key on Scimitar Pro RGB.
; F15 & WheelDown::Send, {WheelDown %G3Scrolls%} ;Set this in #o.
; F15 & WheelUp::Send, {WheelUp %G3Scrolls%}
#If GetKeyState("F15", "P")
$WheelDown::Send, {WheelDown %G3Scrolls%} ;Set this in #o.
$WheelUp::Send, {WheelUp %G3Scrolls%}

;A way to make the mouse move faster while Mouse G3 and the Right Button are held down.
;It's basically the complete opposite of the sniper button.
; F15 & RButton::
RButton::
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,17, Int,1)
KeyWait, RButton
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

#If usingALaptop = true
#b:: ;Open battery menu.
MouseGetPos, originalX, originalY
MouseMove, %laptopBatteryIconX%, %laptopBatteryIconY%, 0
Sleep 200
Send, {Click}
MouseMove, originalX, originalY
return

!PGUP::SoundSet, +1
!PGDN::SoundSet, -1

#If !WinActive("ahk_exe explorer.exe") AND usingALaptop = true ;Really only useful for laptops.
!Up::changeVolume(1)
!Down::changeVolume(-1)
#If

;***********************************RARELY USED BUT STILL USEFUL***********************************
^!+d:: ;Used for deleting videos from YouTube playlist. Asks you how many to delete and then it starts doing its thing.
InputBox, numVidsToDelete, How many videos do you want to delete?, As soon as you hit enter`, the script will start deleting videos. Please position cursor over the first video's x button.

Loop %numVidsToDelete% {
	Send, {Escape} ;Get rid of stupid annoying pop-up from YouTube.
	Sleep 500
	Send, {Click}
	Sleep 500
}
return

#+d::deleteMostRecentItemInFolder("Downloads") ;Recycle the most recently created file or folder in the Downloads folder.
^#+d::deleteMostRecentItemInFolder("Desktop") ;Same thing but for Desktop folder.

deleteMostRecentItemInFolder(folderName)
{
	Loop, Files, C:\Users\%A_UserName%\%folderName%\*.*, FD ;FD = Include Files and Directories
	{
		;Loops through this directory, and if it encounters a file/folder that is newer than the previously encountered one,
		; make that the one to potentially delete.
		if ((A_LoopFileTimeModified > currentMaxCreationDate) AND (A_LoopFileName != ".tmp.drivedownload"))
		{
			currentMaxCreationDate := A_LoopFileTimeModified
			thingToDelete := A_LoopFileName
			thingToDeleteFileExt := A_LoopFileExt
		}
	}

	if (thingToDelete == "") ;If the folder is empty.
	{
		MsgBox, 262160, Error., No more items in %folderName% folder. The current thread will now exit.
		return
	}

	if (thingToDeleteFileExt == "") ;If it's a folder, don't tack on an extension thing in the prompt asking if you for sure want to delete it.
		message = Recycle folder "%thingToDelete%"?
	else
		message = Recycle file "%thingToDelete%"?

	MsgBox, 262180, Recycle Latest Thing in %folderName% Folder?, %message%
	IfMsgBox, No
		return

	FileRecycle, C:\Users\%A_UserName%\%folderName%\%thingToDelete%
	if (ErrorLevel == 1)
		MsgBox, 262160, Error, An error occurred while trying to recycle "%thingToDelete%".
}

/*
Used for mass downloading music tracks from this website: https://downloads.khinsider.com/
These coordinates only work with Asus monitor at home.
Here's how to use it:
1. Use the Snap Links extension to open several tabs at once
2. Test and make sure the screen coordinates are all correct (test a single track at a time)
3. That's it. Just don't open too many tabs at once, or else it won't work properly because your browser will seriously slow down.
*/
; RAlt::
; InputBox, loopAmt, Num of tabs, Enter num of tabs,, 200, 130,,,,, 13
; Sleep 600
; Loop %loopAmt% {
; 	; MouseClick, Right, 751, 347 ;FLAC
; 	MouseClick, Right, 742, 313 ;MP3
; 	Sleep 300
; 	Send, k
; 	Sleep 1550
; 	; Send, {Home}{Delete 5}
; 	; Sleep 1200
; 	MouseClick, Left, 1086, 822 ;Click "Save" button
; 	; Sleep 1050
; 	Send, ^w
; 	Sleep 900
; }
; return

;*****************************AUTOCORRECT GUI BEHAVIOR******************************
#h::
originalClipboard := ClipboardAll
Clipboard := ;Must start off blank for detection to work.
Send ^c

toggleGUI(ACGUIToggle, "ACGUI", ACGUI_WIDTH, ACGUI_HEIGHT, "New AC Hotstring")

if (Clipboard = "")
	GuiControl, ACGUI: Focus, IncorrectEdit
else {
	GuiControl, ACGUI:, IncorrectEdit, %Clipboard%
	GuiControl, ACGUI: Focus, CorrectEdit
}

WinActivate, New AC Hotstring

Clipboard := originalClipboard
return

ACGUIGUIClose:
ACGUIGUIEscape:
toggleGUI(ACGUIToggle, "ACGUI", ACGUI_WIDTH, ACGUI_HEIGHT, "New AC Hotstring")
return

ACFinishButton: ;Where the hotstring is created and added to the script.
	GUI, ACGUI:Submit

	if (IncorrectEdit == "") OR (CorrectEdit == "")
	{
		MsgBox, 262160, Both the Incorrect and Correct fields are required, Both the Incorrect and Correct fields are required. Please fill in both fields to create a new hotstring.
		return
	}

	NewHotstring := ":" ;Start of the new hotstring.

	if (StarCheck = 1)
		NewHotstring := NewHotstring . "*"

	if (QuestionCheck = 1)
		NewHotstring := NewHotstring . "?"

	if (XCheck = 1)
		NewHotstring := NewHotstring . "X"

	if (ACOptions != "Extra Options") ;If there's actually stuff in this.
		NewHotstring := NewHotstring . ACOptions

	NewHotstring := NewHotstring . ":" . IncorrectEdit . "::" . CorrectEdit

	if (tmpStringComment = "Temporary?")
		FileAppend, %NewHotstring%`n, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\AutoCorrect.ahk ; Put a `n at the beginning in case file lacks a blank line at its end.
	else
	{
		FormatTime, formattedDateTime,, ddd, MMM d, yyyy h:mm tt
		msg := ";" . tmpStringComment . " " . formattedDateTime
		FileAppend, %NewHotstring% %msg%`n, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\MSR Stuff\Misc. MSR Scripts\Temp Hotstrings.ahk
	}
	reloadMSR() ;Apply the new hotstring.
return

;*****************************EDIT CLIPBOARD CONTENT GUI BEHAVIOR******************************
;Toggles between showing and hiding the Clipboard GUI.
#c::
GuiControl, ECC:,clipboardBoxText, %Clipboard%
GuiControl, ECC:Focus, clipboardBoxText
toggleGUI(showClipboardGUIToggle, "ECC", 650, 400, "Clipboard Edit")
return

ECCGuiClose:
GUI, ECC:Submit, NoHide
GuiControl, ECC:Focus, clipboardBoxText
GUI, ECC:Hide
showClipboardGUIToggle := !showClipboardGUIToggle
return

clipboardTextBoxLabel:
GUI, ECC:Submit, NoHide
return

clipboardFinishButton:
GUI, ECC:Submit
Clipboard := clipboardBoxText
showClipboardGUIToggle := !showClipboardGUIToggle
return

;*****************************************MSR CONTROL PANEL GUI BEHAVIOR*********************************
#o:: ;Show/hide the MSR Control Panel.
controlPanelGUIToggle := !controlPanelGUIToggle

if (controlPanelGUIToggle = 1)
	GUI, CPanel:Show, w%CONTROL_PANEL_WIDTH% h%CONTROL_PANEL_HEIGHT%,MSR Control Panel
else {
	GUI, CPanel:Hide
	writeConfigFile() ;Put these values in the ini file.
}
return

CPanelGuiClose:
CPanelGuiEscape:
	GUI, CPanel:Submit

	writeConfigFile()

	controlPanelGUIToggle := !controlPanelGUIToggle
return

MatchPairsButton:
	toggleGUI(matchPairsToggled, "MP", MP_GUI_WIDTH, MP_GUI_HEIGHT, "Matching Pairs Toggles")
return

;*****************************************MATCHING PAIRS GUI BEHAVIOR*********************************
MPGuiClose:
MPGuiEscape:
GuiControl, MP:Focus, Check All
GUI, MP:Submit
matchPairsGUIToggled := !matchPairsGUIToggled
return

checkMPBoxes(bool) {
	GuiControl, MP:, singleQuotesToggled, %bool%
	GuiControl, MP:, doubleQuotesToggled, %bool%
	GuiControl, MP:, parenthesesToggled, %bool%
	GuiControl, MP:, squareBracketsToggled, %bool%
	GuiControl, MP:, curlyBracketsToggled, %bool%
}

CheckAllButton:
checkMPBoxes(1)
return

UncheckAllButton:
checkMPBoxes(0)
return

;**************************************************MSR FUNCTIONS AND LABELS**************************************************
onExitLabel:
if A_ExitReason not in Reload ;When the script exits in any way besides Reloading, generate dump files. Think like a Blue Screen of Death: that creates a dump of the memory for later use.
	dumpAllGroups() ;The reason for the "not in Reload" is so the user doesn't get that Tippy every single time when Reloading.
ExitApp

;Create a dump of the CWG IDs.
dumpAllGroups() {
	winGroupBackupDump("F6", WindowGroupF6)
	winGroupBackupDump("F7", WindowGroupF7)
	winGroupBackupDump("F8", WindowGroupF8)
	winGroupBackupDump("F10", WindowGroupF10)

	ctrlWGroupBackup("Ctrl W Titles", ctrlWTitles, "`n")
	ctrlWGroupBackup("Ctrl W IDs", ctrlWIDs, "`n")
	Tippy("Group dump files have been created", 1300)
}
return

;Used for the Reload hotkey ^#r, and also for #h when it reloads the script after creating a new hotstring.
;Writes CWG groups to disk to guarantee they won't be lost if they're hidden and the script reloads. Also for convenience whilst editing the script, etc. so that the groups are automatically repopulated.
reloadMSR() {
	writeGroupToFile("F6", WindowGroupF6, 1)
	writeGroupToFile("F7", WindowGroupF7, 1)
	writeGroupToFile("F8", WindowGroupF8, 1)
	writeGroupToFile("F10", WindowGroupF10, 1)

	ctrlWGroupToFile("Ctrl W Titles", ctrlWTitles, 1, "`n")
	ctrlWGroupToFile("Ctrl W IDs", ctrlWIDs, 1, "`n")
	Reload
}

writeConfigFile() { ;Writes #o values to the config file.
global
	IniWrite, %InsMonChoice%, %MSR_CONFIG_PATH%, MonitorChoices, InsMonChoice
	IniWrite, %CtrlInsMonChoice%, %MSR_CONFIG_PATH%, MonitorChoices, CtrlInsMonChoice
	IniWrite, %ChrBookTypeMonChoice%, %MSR_CONFIG_PATH%, MonitorChoices, ChrBookTypeMonChoice

	IniWrite, %F3Behavior%, %MSR_CONFIG_PATH%, Fx, F3Behavior
	IniWrite, %F6Mode%, %MSR_CONFIG_PATH%, Fx, F6Mode
	IniWrite, %F7Mode%, %MSR_CONFIG_PATH%, Fx, F7Mode
	IniWrite, %F8Mode%, %MSR_CONFIG_PATH%, Fx, F8Mode
	IniWrite, %F10Mode%, %MSR_CONFIG_PATH%, Fx, F10Mode
	IniWrite, %F12Behavior%, %MSR_CONFIG_PATH%, Fx, F12Behavior

	IniWrite, %FrontMouseButtonBehavior%, %MSR_CONFIG_PATH%, MouseButtons, FrontMouseButtonBehavior
	IniWrite, %BackMouseButtonBehavior%, %MSR_CONFIG_PATH%, MouseButtons, BackMouseButtonBehavior
	IniWrite, %G3Scrolls%, %MSR_CONFIG_PATH%, MouseButtons, G3Scrolls

	IniWrite, %savedNumMinusVol%, %MSR_CONFIG_PATH%, Miscellaneous, savedNumMinusVol
	IniWrite, %doubleSlashToggled%, %MSR_CONFIG_PATH%, Miscellaneous, doubleSlashToggled
	IniWrite, %suspendTippyToggled%, %MSR_CONFIG_PATH%, Miscellaneous, suspendTippyToggled

	IniWrite, %matchPairsToggled%, %MSR_CONFIG_PATH%, Matching Pairs, matchPairsToggled
	IniWrite, %singleQuotesToggled%, %MSR_CONFIG_PATH%, Matching Pairs, singleQuotesToggled
	IniWrite, %doubleQuotesToggled%, %MSR_CONFIG_PATH%, Matching Pairs, doubleQuotesToggled
	IniWrite, %parenthesesToggled%, %MSR_CONFIG_PATH%, Matching Pairs, parenthesesToggled
	IniWrite, %squareBracketsToggled%, %MSR_CONFIG_PATH%, Matching Pairs, squareBracketsToggled
	IniWrite, %curlyBracketsToggled%, %MSR_CONFIG_PATH%, Matching Pairs, curlyBracketsToggled
}

readConfigFile() { ;Reads values from the ini file for #o (really only for the script startup).
global
	;Last parameter is default value if key can't be read (their default values basically).
	IniRead, InsMonChoice, %MSR_CONFIG_PATH%, MonitorChoices, InsMonChoice, Primary Mon
	IniRead, CtrlInsMonChoice, %MSR_CONFIG_PATH%, MonitorChoices, CtrlInsMonChoice, Secondary Mon
	IniRead, ChrBookTypeMonChoice, %MSR_CONFIG_PATH%, MonitorChoices, ChrBookTypeMonChoice, Primary Mon

	IniRead, F3Behavior, %MSR_CONFIG_PATH%, Fx, F3Behavior, VSCode
	IniRead, F6Mode, %MSR_CONFIG_PATH%, Fx, F6Mode, Window Group
	IniRead, F7Mode, %MSR_CONFIG_PATH%, Fx, F7Mode, Window Group
	IniRead, F8Mode, %MSR_CONFIG_PATH%, Fx, F8Mode, Window Hider
	IniRead, F10Mode, %MSR_CONFIG_PATH%, Fx, F10Mode, Window Hider
	IniRead, F12Behavior, %MSR_CONFIG_PATH%, Fx, F12Behavior, Word

	IniRead, FrontMouseButtonBehavior, %MSR_CONFIG_PATH%, MouseButtons, FrontMouseButtonBehavior, Double Click
	IniRead, BackMouseButtonBehavior, %MSR_CONFIG_PATH%, MouseButtons, BackMouseButtonBehavior, F6
	IniRead, G3Scrolls, %MSR_CONFIG_PATH%, MouseButtons, G3Scrolls, 8

	IniRead, savedNumMinusVol, %MSR_CONFIG_PATH%, Miscellaneous, savedNumMinusVol
	IniRead, doubleSlashToggled, %MSR_CONFIG_PATH%, Miscellaneous, doubleSlashToggled, false
	IniRead, suspendTippyToggled, %MSR_CONFIG_PATH%, Miscellaneous, suspendTippyToggled, false
	IniRead, runInputBoxText, %MSR_CONFIG_PATH%, Miscellaneous, runInputBoxText

	IniRead, matchPairsToggled, %MSR_CONFIG_PATH%, Matching Pairs, matchPairsToggled, false
	IniRead, singleQuotesToggled, %MSR_CONFIG_PATH%, Matching Pairs, singleQuotesToggled, false
	IniRead, doubleQuotesToggled, %MSR_CONFIG_PATH%, Matching Pairs, doubleQuotesToggled, false
	IniRead, parenthesesToggled, %MSR_CONFIG_PATH%, Matching Pairs, parenthesesToggled, false
	IniRead, squareBracketsToggled, %MSR_CONFIG_PATH%, Matching Pairs, squareBracketsToggled, false
	IniRead, curlyBracketsToggled, %MSR_CONFIG_PATH%, Matching Pairs, curlyBracketsToggled, false
}

;Used if you want to reset the config file. Because IniRead allows you to set default values in case there's an error, those default values will be used, allowing this to actually work really easily.
deleteConfigFile() {
	FileDelete, %MSR_CONFIG_PATH%
	if (ErrorLevel != 0)
		MsgBox, 262160, Something Happened, An error occurred while trying to delete the config file. Most likely the file doesn't exist and thus you tried to delete something that doesn't exist.
	else
		Tippy("Config File has been deleted.", 950)
}

;**************************************************EXPERIMENTAL**************************************************
;Volume wheel up/down on K95 RGB does log volume scaling.
^!F22::changeVolume(1)
^+F22::changeVolume(-1)

$*ScrollLock:: ;If a modifier key is stuck, send the key up signal
Send, {CtrlUp}{AltUp}{LWinUp}{RWinUp}{ShiftUp}
return

;**************************************************TEMPORARY**************************************************
:*X:pw::Send, csc-285{Enter}
:*X:apw::Send, Administrator{Tab}csc-285{Enter} ;Signing into VM.

#If WinActive("ahk_exe Zoom.exe")
; RAlt::Send, #+s ;Snip & Sketch.
; RCtrl::Send, #+s ;Snip & Sketch.

$PrintScreen::Send, #{PrintScreen}

$CapsLock:: ;"Hide" the mouse pointer, and hide the Zoom meeting controls.
MouseGetPos, mousePosX, mousePosY
MouseMove, 1920, 540, 0
Send, {LAlt}
return
#If

; #If WinActive("ahk_exe Zoom.exe") && usingALaptop = true
; ; For taking Screenshots during Calculus and other online classes. Snip and Sketch has to already be in Window snip mode, though.
; RCtrl::
; Send, #+s
; Sleep 800
; MouseMove, 2, 2, 0, R
; Send, {Click}
; Sleep 1000
; MouseMove, 1762, 914, 0
; Sleep 1000
; Send, {Click}
; Sleep 1000
; Send, ^s
; Sleep 1000
; Send, {Enter}
; Sleep 1000
; Send, !{F4}
; return
; #If

#If WinActive("pgAdmin 4")
^/::Send, ^+/
#If