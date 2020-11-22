;///////////////////////////////////////////////////////////////////////
;File: Main Script Revised.ahk
;///////////////////////////////////////////////////////////////////////
;Programmer: Elliott DuCharme
;///////////////////////////////////////////////////////////////////////
;Comments: Development started on Thursday, September 24, 2020.
/*
* Fed up with the mess that was my original Main Script.ahk file, I
* decided to revise and improve it.
* This new script seeks to keep all the good of the old file (good
* organization via sections, etc), and get rid of the bad.
* There are less #Includes, which ironically makes the code easier to
* maintain and add to. The #Include statement in AutoHotkey is
* extremely weird and doesn't work that great in my opinion. This is probably
* because, according to the documentation: "A script behaves as though the
* included file's contents are physically present at the exact position of
* the #Include directive (as though a copy-and-paste were done from the
* included file). Consequently, it generally cannot merge two isolated
* scripts together into one functioning script." I wish I had realized this
* when I started the script...

* Trying to have code like GUI creation, hotkeys, etc. in a separate file is
* very unpredictable and often doesn't work and wastes my time trying to
* figure out why it doesn't work. The only #Includes are the things that work
* best in separate files: the long files with (context-sensitive) hotkeys, as well as 'header' files.
* The best things to have in other files are hotkeys, and that's it. This isn't too annoying TBH.

* Important Acronyms, Contractions, Etc.:
* MRS: Main Script Revised
* TC: Title Capitalization
* YT: YouTube
* Keeb: keyboard
* CWG: Custom Window Groups
* ApplSwitch: ApplicationSwitcher
* Chr Typing: Chromebook Typing.

* Conventions for the number of * for a title/header. These can be inserted via Run.ahk.
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

OnExit, onExitLabel ;Dump CWG groups to a .tmp file with a timestamp in case needed later.

;**************************************************AUTO-EXECUTE**************************************************
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
GUI, QuickCodeGUI:Add, Edit, vQuickCodeEdit xp-2 y20 w196 h190
GUI, QuickCodeGUI:Add, Button, xp y215 gQuickCodeDoneButton, &Done

;***********************************MSR CONTROL PANEL INITIALIZATION***********************************
;This is a GUI for MSR that allows the user to change how parts of the script work.
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

;F3 Behavior.
GUI, CPanel:Add, Text, x153 yp-14, F3 Behavior
GUI, CPanel:Add, DDL, x152 y56 w100 vF3Behavior, Google Chrome|VSCode
GuiControl, CPanel:ChooseString, F3Behavior, %F3Behavior%

;Default screen X and Y of battery icons; user can change them later in #o.
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
	laptopBatteryIconX := "INVALID"
	laptopBatteryIconY := "INVALID"
} else {
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. Computer/laptop name is: %A_ComputerName%
}

;X choice for the #b hotkey.
GUI, CPanel:Add, Text, xm yp+27, #B Screen X
GUI, CPanel:Add, Edit, xm yp+14 w62 vlaptopBatteryIconX, %laptopBatteryIconX%

;Y choice for the #b hotkey.
GUI, CPanel:Add, Text, xp+67 yp-14, #B Screen Y
GUI, CPanel:Add, Edit, xp yp+14 w62 vlaptopBatteryIconY, %laptopBatteryIconY%

;Default screen X and Y of network icon; user can change them later in #o.
if (A_ComputerName = "Elliott-Laptop") {
	WinWX := "UNKNOWN"
	WinWY := "UNKNOWN"
} else if (A_ComputerName = "Elliott-DSU-Lap") {
	WinWX := 1704
	WinWY := 1051
} else if (A_ComputerName = "Elliott-PC") {
	WinWX := 1443
	WinWY := 1174
} else {
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. A_ComputerName is: %A_ComputerName%.
}

;X choice for the #w hotkey.
GUI, CPanel:Add, Text, xp+75 yp-14, #W Screen X
GUI, CPanel:Add, Edit, xp yp+14 w66 vWinWX, %WinWX%

;Y choice for the #w hotkey.
GUI, CPanel:Add, Text, xp+71 yp-14, #W Screen Y
GUI, CPanel:Add, Edit, xp yp+14 w66 vWinWY, %WinWY%

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

GUI, CPanel:Add, Text, xm yp+27, Front and Back Top Mouse Buttons Behavior
GUI, CPanel:Add, DDL, xm yp+17 w87 vFrontMouseButtonBehavior, Double Click|F1|F2|F3|F4|F6|F7|F8|F9|F10|F12
GuiControl, CPanel:ChooseString, FrontMouseButtonBehavior, %FrontMouseButtonBehavior%

GUI, CPanel:Add, DDL, xm+90 yp w87 vBackMouseButtonBehavior, Double Click|F1|F2|F3|F4|F6|F7|F8|F9|F10|F12
GuiControl, CPanel:ChooseString, BackMouseButtonBehavior, %BackMouseButtonBehavior%

GUI, CPanel:Add, Text, xm yp+27, F12 Behavior
GUI, CPanel:Add, DDL, xm yp+17 w146 vF12Behavior, Word|VSCode and Cmd Prompt|Excel|Word + Excel|Outlook|
GuiControl, CPanel:ChooseString, F12Behavior, %F12Behavior%

;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appears when the user wants it.
global controlPanelGUIToggle := 0

global CONTROL_PANEL_WIDTH := 286
global CONTROL_PANEL_HEIGHT := 260

;Used for testing and adding new #o stuff.
; GUI, CPanel:Show, w%CONTROL_PANEL_WIDTH% h%CONTROL_PANEL_HEIGHT% x1400,MSR Control Panel

;****************************************MISC VARIABLES, INITIALIZATION, ETC*********************************
global Num2And8Step := 3 ;When Num2 or Num8 pressed, how much to increase/decrease volume.
global autoNumPadModeToggle := true ;If true, switch NumPad modes automatically. If false user manually controls it.
global systemMasterVolume ;Used for NumPad Media Control stuff.

global programmingMode := false ;Toggle for Programming Mode: disabling certain hotkeys/hotstrings to make programming easier. ^!Insert is the hotkey.
global hotstringsActiveToggle := true ;Determines if AutoCorrect hotstrings are active or not. Active by default, obviously. ^#Insert is the hotkey.

;Used for F9, F11, and F12 on 2nd keeb for showing/hiding these programs. 1 = visible; 0 = not visible.
global OutlookVisibilityToggle := 1
global DiscordVisibilityToggle := 1
global MusicBeeVisibilityToggle := 1

global currentWinOMode := 1
global WIN_O_MAX_MODE := 3 ;How many modes (-1) are actually defined in the Switch statement.

;The stuff in this loop needs to be running constantly.
Loop {
	global activeWindowTitle
	WinGetActiveTitle, activeWindowTitle

	global activeWindowID
	WinGet, activeWindowID, ID, A

	if InStr(activeWindowTitle, "Mozilla Firefox")
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

	else if InStr(activeWindowTitle, " - Excel")
		currentProfile := "Excel"
	else if InStr(activeWindowTitle, " - Word")
		currentProfile := "Word"
	else if Instr(activeWindowTitle, " - Visual Studio Code")
		currentProfile := "VSCode"
	; else if InStr(activeWindowTitle, "Discord")
		; currentProfile := "Discord"
	else if Instr(activeWindowTitle, "Factorio 1.")
		currentProfile := "Factorio"
	else if Instr(activeWindowTitle, "Minecraft 1.1")
		currentProfile := "Minecraft"
	else if Instr(activeWindowTitle, "Terraria")
		currentProfile := "Terraria"
	else
		currentProfile := "Default"

	;For the NumPad stuff.
	global numLockToggled := GetKeyState("NumLock", "T")
	global scrollLockToggled := GetKeyState("ScrollLock", "T")

	;If the auto-numpad toggle is true, sets the numPadMode automatically.
	;Else, leave it to the user to do it manually.
	if (autoNumPadModeToggle = true) {

		if InStr(activeWindowTitle, "- YouTube") {
			SetNumLockState, On
			SetScrollLockState, On
			global numPadMode := "YouTube"
		} else if InStr(activeWindowTitle, "- MediaSpace") {
			SetNumLockState, Off
			SetScrollLockState, On
			global numPadMode := "Dumbed-Down"
		} else {
			SetNumLockState, On
			SetScrollLockState, Off
			global numPadMode := "MusicBee"
		}

	} else {

		;This works so much better than having a bunch of ugly numLockToggled = 1 and scrollLockToggled = 0 things everywhere.
		;These variables are used in NumPad Media Control.ahk.
		if (numLockToggled = 1 and scrollLockToggled = 0)
			global numPadMode := "MusicBee"
		else if (numLockToggled = 1 and scrollLockToggled = 1)
			global numPadMode := "YouTube"
		else if (numLockToggled = 0 and scrollLockToggled = 0)
			global numPadMode := "Normal"
		else if (numLockToggled = 0 and scrollLockToggled = 1)
			global numPadMode := "Dumbed-Down"
		else
			global numPadMode := "Normal"
	}
	Sleep 100 ;This sleep statement DRASTICALLY helps reduce the power and CPU usage of the MSR.
}

;Other files with many different hotkeys and hotstrings and other things in them.
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\BooleanToggle.ahk
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\inArray.ahk
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk

#Include, %A_ScriptDir%\MSR Profiles\Browser.ahk
#Include, %A_ScriptDir%\MSR Profiles\Default.ahk
#Include, %A_ScriptDir%\MSR Profiles\Google Docs.ahk
#Include, %A_ScriptDir%\MSR Profiles\Google Sheets.ahk
#Include, %A_ScriptDir%\MSR Profiles\Microsoft Excel.ahk
#Include, %A_ScriptDir%\MSR Profiles\Microsoft Word.ahk
#Include, %A_ScriptDir%\MSR Profiles\VSCode.ahk

#Include, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\Custom Window Groups.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Quick Code\Quick Code.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Run\Run.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\AutoCorrect.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\C-C++ Programming.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Easy Window Dragging.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\NumPad Media Control.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Title Capitalization.ahk

#Include, %A_ScriptDir%\Screen Clipper Script\Screen Clipper.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Factorio.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Minecraft.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Terraria.ahk

#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\Secondary Macro Keyboard\Hasu USB to USB Script.ahk

;This is after the 2nd keeb script because if it is #Included before it and it's enabled it breaks the keys like j, k, l, a, etc.
#Include, %A_ScriptDir%\Misc. MSR Scripts\Chromebook Typing.ahk

;****************************************MISC HOTKEYS***************************************
^#r::reloadMSR()

!#r::Reload ;Force Reload the script.

+#r::deleteConfigFile() ;Delete .ini file. To restart MSR with the default config values, do this and then ^#r.

^!r:: ;Delete the CWG files and then reload script (basically what ^#r used to be). Useful if I want to restart the script without restoring the CWG arrays.
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F6 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F7 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F8 Group.tmp
FileDelete, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups\F10 Group.tmp
Reload
return

;Shows you miscellaneous variables, toggles, etc.
^#BackSpace::MsgBox, 0, Misc. Variables`, Toggles`, etc., MSR Profile: %currentProfile%`n`nnumPadMode: %NumPadMode%`n`nautoNumPadModeToggle: %autoNumPadModeToggle%

^#s::Run, C:\Program Files\AutoHotkey\WindowSpy.ahk ;Run Window Spy.

^CtrlBreak:: ;Technically Ctrl + Pause. Read about this here: https://www.autohotkey.com/docs/KeyList.htm#other
#!p::
Suspend
return

Pause:: ;Pause key or Win + p suspends all hotkeys for the specified number in milliseconds.
#p::
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
return

^\::Send, \ ;This key normally deletes a word. This hotkey allows you to insert a \ without having to suspend hotkeys.

sc029::Send, !{Tab} ;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab.

^sc029::Send, `` ;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `.

^+sc029::Send, ~ ;Holding Ctrl and Shift and pushing the grave accent key inserts the tilde symbol: ~.

!SC00C::WinMinimize, A ;Alt + -

!SC00D::WinMaximize, A ;Alt + +.

#n::Run, Notepad ;Open Notepad.

;Toggle programming mode. Disables hotkeys/hotstrings that can be annoying when programming.
^!Insert::BooleanToggle(programmingMode, "Programming Mode ON", "Programming Mode Off")

#+d::deleteMostRecentItemInFolder("Downloads") ;Recycle the most recently created file or folder in the Downloads folder.
^#+d::deleteMostRecentItemInFolder("Desktop") ;Same thing but for Desktop folder.

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

#w:: ;Opens Wi-Fi menu.
MouseGetPos, originalX, originalY
MouseMove, %WinWX%, %WinWY%, 0
Sleep 200
Send, {Click}
MouseMove, originalX, originalY
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

^!+d:: ;Used for deleting videos from YouTube playlist. Asks you how many times to do it and then it starts doing its thing.
InputBox, numVidsToDelete, How many videos do you want to delete?, As soon as you hit enter`, the script will start deleting videos. Please position cursor over the first video's x button.

Loop %numVidsToDelete% {
	Send, {Escape} ;Get rid of stupid annoying pop-up from YouTube.
	Sleep 500
	Send, {Click}
	Sleep 500
}
return

^+g:: ;Calculate percent grade on a homework assignment or whatever, then show result and letter grade equivalent. So, for something like 40/50, you'd enter 40 and then 50.
InputBox, firstNum, Grade Percent Utility, What is the first number?,, 200, 150
InputBox, secondNum, Grade Percent Utility, What is the second number?,, 200, 150

result := round((firstNum/secondNum) * 100, 2)
MsgBox, 0, Grade, You got %result%`%.`n`nLetter Grade`tNumerical Grade`nA+`t`t97-100`nA`t`t94-96`nA-`t`t90-93`nB+`t`t87-89`nB`t`t84-86`nB-`t`t80-83`nC+`t`t77-79`nC`t`t74-76`nC-`t`t70-73`nD+`t`t67-69`nD`t`t64-66`nD-`t`t60-63`nF`t`t0-59
return

^Space:: ;Make active window AlwaysOnTop, and tell the user if it is or not.
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

;***********************************ADD CHARS AROUND TEXT***********************************
^SC028::addCharAroundText("""") ;^' Add double quotes around selected text.
^+SC028::addCharAroundText("'") ;^+' Add single quotes around selected text.

;Add brackets around selected text.
^+<::
^+>::addCharAroundText("<", ">")

;Add () around selected text.
^+(::
^+)::addCharAroundText("(", ")")

;****************************************GLOBAL iCUE HOTKEYS***************************************
;These 3 hotkeys are sent by the iCUE software, which AutoHotkey detects.
+F24::Send, ^c ;M1 on K95 RGB copies to the clipboard.
+F21::Send, ^x ;M2 on K95 RGB cuts to the clipboard.
+F22::Send, ^v ;M3 on K95 RGB pastes the clipboard.

^!F23::topMouseButtons(FrontMouseButtonBehavior) ;Top Front Mouse Button on Scimitar RGB.
^+F23::topMouseButtons(BackMouseButtonBehavior) ;Top Back Mouse Button on Scimitar RGB.

;****************************************CONTEXT-SENSITIVE HOTKEYS***************************************
#If programmingMode = false
\::
Send, ^+{Left}
Send, {BackSpace}
return

::i::I

#If programmingMode = true
F5::Send, #{F5} ;For compiling C code in VSCode.

#IfWinActive Search ;When Cortana/Search is open.
!s::Send, {Space}meaning

RWin::
Send, {LWin}
Sleep 300
Send, {LWin}
return

#If currentProfile != "Terraria"
;Scroll down faster by holding down the G3 key on Scimitar Pro RGB.
F15 & WheelDown::Send, {WheelDown 8}

;Scroll up faster by holding down the G3 key on Scimitar Pro RGB.
F15 & WheelUp::Send, {WheelUp 8}

;A way to make the mouse move faster while Mouse G3 and the Right Button are held down.
;It's basically the complete opposite of the sniper button.
F15 & RButton::
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

~RShift::Send, {Media_Play_Pause}
^!Left::Send, {Media_Prev}
^!Right::Send, {Media_Next}

!PGUP::SoundSet, +1
!PGDN::SoundSet, -1

#If !WinActive("ahk_exe explorer.exe") AND usingALaptop = true ;Really only useful for laptops.
!Up::changeVolume(1)
!Down::changeVolume(-1)
#If

;*****************************EDIT CLIPBOARD CONTENT GUI BEHAVIOR******************************
;Toggles between showing and hiding the Clipboard GUI.
#c::
GuiControl, ECC:,clipboardBoxText, %Clipboard%
GuiControl, ECC:Focus, clipboardBoxText

showClipboardGUIToggle := !showClipboardGUIToggle

if (showClipboardGUIToggle = 1)
	GUI, ECC:Show, w650 h400,Clipboard Edit
else
	GUI, ECC:Hide
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

;**************************************************MSR FUNCTIONS AND LABELS**************************************************
;Used for the Reload hotkey (^#r) and also for space bar on the 2nd keeb.
;Writes file to disk to guarantee they won't be lost if they're hidden and the script reloads. Also for convenience whilst editing the script, etc.
reloadMSR() {
	writeGroupToFile("F6", WindowGroupF6, 1)
	writeGroupToFile("F7", WindowGroupF7, 1)
	writeGroupToFile("F8", WindowGroupF8, 1)
	writeGroupToFile("F10", WindowGroupF10, 1)
	Reload
}

onExitLabel:
if A_ExitReason not in Reload ;TODO: This might need to be adjusted and/or removed... Lots of testing needs to happen.
	dumpAllCWGGroups()
ExitApp

#F11:: ;Force the script to create a dump of the IDs.
dumpAllCWGGroups()
{
	winGroupBackupDump("F6", WindowGroupF6)
	winGroupBackupDump("F7", WindowGroupF7)
	winGroupBackupDump("F8", WindowGroupF8)
	winGroupBackupDump("F10", WindowGroupF10)
	Tippy("Group dump files have been created", 1300)
}
return

;Called by top 2 mouse button hotkeys.
topMouseButtons(buttonMode) {
global

	if (buttonMode = "Double Click")
		Send, {Click 2}
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
	else if (buttonMode = "F9")
		F9Hotkey()
	else if (buttonMode = "F10")
		nextWinOrShowHideWins("F10", WindowGroupF10, CurrentWinF10)
	else if (buttonMode = "F12")
		F12Hotkey()
	else
		MsgBox, 262160, Error., That mouse button mode is not defined.
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

	; IniWrite, %laptopBatteryIconX%, %MSR_CONFIG_PATH%, Miscellaneous, laptopBatteryIconX
	; IniWrite, %laptopBatteryIconY%, %MSR_CONFIG_PATH%, Miscellaneous, laptopBatteryIconY
	; IniWrite, %WinWX%, %MSR_CONFIG_PATH%, Miscellaneous, WinWX
	; IniWrite, %WinWY%, %MSR_CONFIG_PATH%, Miscellaneous, WinWY
}

readConfigFile() { ;Reads values from the ini file for #o.
global
	;Last parameter is default value if key can't be read.
	IniRead, InsMonChoice, %MSR_CONFIG_PATH%, MonitorChoices, InsMonChoice, Primary Mon
	IniRead, CtrlInsMonChoice, %MSR_CONFIG_PATH%, MonitorChoices, CtrlInsMonChoice, Secondary Mon
	IniRead, ChrBookTypeMonChoice, %MSR_CONFIG_PATH%, MonitorChoices, ChrBookTypeMonChoice, Primary Mon

	IniRead, F3Behavior, %MSR_CONFIG_PATH%, Fx, F3Behavior, Google Chrome
	IniRead, F6Mode, %MSR_CONFIG_PATH%, Fx, F6Mode, Window Group
	IniRead, F7Mode, %MSR_CONFIG_PATH%, Fx, F7Mode, Window Group
	IniRead, F8Mode, %MSR_CONFIG_PATH%, Fx, F8Mode, Window Hider
	IniRead, F10Mode, %MSR_CONFIG_PATH%, Fx, F10Mode, Window Hider
	IniRead, F12Behavior, %MSR_CONFIG_PATH%, Fx, F12Behavior, Word

	IniRead, FrontMouseButtonBehavior, %MSR_CONFIG_PATH%, MouseButtons, FrontMouseButtonBehavior, Double Click
	IniRead, BackMouseButtonBehavior, %MSR_CONFIG_PATH%, MouseButtons, BackMouseButtonBehavior, F6

	; IniRead, laptopBatteryIconX, %MSR_CONFIG_PATH%, Miscellaneous, laptopBatteryIconX
	; IniRead, laptopBatteryIconY, %MSR_CONFIG_PATH%, Miscellaneous, laptopBatteryIconY
	; IniRead, WinWX, %MSR_CONFIG_PATH%, Miscellaneous, WinWX
	; IniRead, WinWY, %MSR_CONFIG_PATH%, Miscellaneous, WinWY
}

;Used if you want to reset the config file. Because IniRead allows you to set default values in case there's an error, those default values will be used, allowing this to actually work really easily.
deleteConfigFile() {
	FileDelete, %MSR_CONFIG_PATH%
	if (ErrorLevel != 0)
		MsgBox, 262160, Something Happened, An error occurred while trying to delete the config file. Most likely the file doesn't exist and thus you tried to delete something that doesn't exist.
	else
		Tippy("Config File has been deleted.", 950)
}

;Used or #+d and ^#+d hotkeys.
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

addCharAroundText(character, optional2ndChar := "") ;optional2ndChar is only used for things like <> or (), where there are 2 different characters, instead of something like "", which doesn't require the parameter.
{
	originalClipboard := ClipboardAll ;Restore this later.

	Send, ^c
	ClipWait, 2 ;Wait 2 seconds.

	Send, %character%
	Sleep 100
	Send, ^v
	Sleep 100

	if (optional2ndChar != "") ;Determine if there's another character to the pair to add to the end, like for (), <>, etc.
		Send, %optional2ndChar%
	else
		Send, %character%

	Clipboard := originalClipboard ;Restore.
	originalClipboard := "" ;Free because could potentially be huge.
}

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

;**************************************************EXPERIMENTAL**************************************************
;**************************************************TEMPORARY**************************************************
:*:hon comp::Honors: Composition II
:*:hcomp::Honors Composition II

;For Dell keyboard.
Volume_Down::SoundSet, -2
Volume_Up::SoundSet, +2

#If WinActive("ahk_exe Zoom.exe")
; RAlt::Send, #+s ;Snip & Sketch.
; RCtrl::Send, #+s ;Snip & Sketch.

$PrintScreen::Send, #{PrintScreen}

$CapsLock:: ;"Hide" the mouse pointer, and hide the Zoom meeting controls.
MouseGetPos, mousePosX, mousePosY
MouseMove, 1920, 540, 0
Send, {LAlt}
return

#If WinActive("ahk_exe Zoom.exe") && usingALaptop = true
;For taking Screenshots during Calculus and other online classes. Snip and Sketch has to already be in Window snip mode, though.
RCtrl::
Send, #+s
Sleep 800
MouseMove, 2, 2, 0, R
Send, {Click}
Sleep 1000
MouseMove, 1762, 914, 0
Sleep 1000
Send, {Click}
Sleep 1000
Send, ^s
Sleep 1000
Send, {Enter}
Sleep 1000
Send, !{F4}
return
#If