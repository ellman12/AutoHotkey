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

* Here's how this giant script is laid out: https://imgur.com/R14NAWW

* Important Acronyms, Contractions, Etc.:
* MRS: Main Script Revised
* TCT: Title Capitalization Tool
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

/* TODO:
if the volume just got turned up quite a ways, give some kind of warning (large Tippy, etc.) warning me to turn the volume down. Put in either Main or NumPad.#SingleInstance, Force
bedtime script
thing that after certain amount of time moves mouse pointer off screen. If it's moved by user put back to where it was. Have a #o thing to customize delay
customize other top mouse button behavior
remove extra unnecessary params in CWG
*/

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

;These can be changed in #o, but set them to their normal, default values.
global F6Mode := "Window Group"
global F7Mode := "Window Group"
global F8Mode := "Window Hider"
global F10Mode := "Window Hider"

;Prevents losing windows when reloading the script with windows hidden.
global F6WindowsHidden := false
global F7WindowsHidden := false
global F8WindowsHidden := false
global F10WindowsHidden := false

;Declare these as 1 so the first time you press F8, it hides everything.
;If it's 1, hide windows; if it's 0, show windows.
global F6ShowHideToggle := 0
global F7ShowHideToggle := 0
global F8ShowHideToggle := 0
global F10ShowHideToggle := 0

;*******************************EDIT CLIPBOARD CONTENT INITIALIZATION******************************
GUI, ECC:Font, s12
GUI, ECC:Add, Button, gclipboardFinishButton x4 y2 w80,&Finish

GUI, ECC:Font, s11
GUI, ECC:Add, Edit, HScroll wrap x4 y36 w640 h355 vclipboardBoxText gclipboardTextBoxLabel,%Clipboard%

GUI, ECC:+AlwaysOnTop
GUI, ECC:+Resize
GUI, ECC:Color, Silver

;Toggle for showing or hiding the Clipboard GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
showClipboardGUIToggle := 0

;*************Screen Clipper.ahk Initialization Stuff************
Hotkey, #s, CreateCapWindow, On ;Take a screen clip with the Screen Clipper script.
SaveToFile := 1 ;Set this to 1 to save all clips with a unique name , Set it to 0 to overwrite the saved clip every time a new clip is made.
ShowCloseButton := 1 ;Set this to 1 to show a small close button in the top right corner of the clip. Set this to 0 to keep the close button, but not show it.
CoordMode, Mouse , Screen ;Use the screen as the reference to get positions from.

IfNotExist, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;if there is no folder for saved clips...
	FileCreateDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;create the folder.
SetWorkingDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;Set the saved clips folder as the working dir.
Handles := [] ;Create an array to hold the name of the different gui's.
Index := 0 ;Used as the name of the current gui cap window.

;*******************************MSR CONTROL PANEL INITIALIZATION******************************
;This is a GUI for MSR that allows the user to change how parts of the script work: stuff
; which probably couldn't really be done well with hotkeys.
GUI, oldCPanel:+AlwaysOnTop
GUI, oldCPanel:Color, Silver

;Insert.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x5 y5,Insert Hotkey Monitor Choice
GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, DropDownList, x5 y30 w136 vInsMonChoice, Primary Mon||Secondary Mon

;Ctrl + Insert.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x5 y60,Ctrl + Insert Hotkey Monitor Choice
GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, DropDownList, x5 y85 w136 vCtrlInsMonChoice, Primary Mon|Secondary Mon||

;For Chromebook Typing, which monitor to send the mouse pointer too.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x5 y115,Chromebook Typing Monitor Choice
GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, DropDownList, x5 y140 w136 vChrBookTypeMonChoice, Primary Mon||Secondary Mon|

;Default screen X and Y of battery icons; user can change them later in #o.
if (A_ComputerName = "Elliott-Laptop") {
	laptopBatteryIconX := 1432
	laptopBatteryIconY := 885
    usingALaptop := true
} else if (A_ComputerName = "Elliott-DSU-Lap") {
	laptopBatteryIconX := 1664
	laptopBatteryIconY := 1049 ;This is WITHOUT the Ink Workspace button shown. If it's shown, it's 1618 and 1049.
    usingALaptop := true
} else if (A_ComputerName = "Elliott-PC") {
	usingALaptop := false
	laptopBatteryIconX := NULL
	laptopBatteryIconY := NULL
} else {
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. A_ComputerName is: %A_ComputerName%`n`nIf you're on a desktop computer this can be totally ignored.
}

;X choice for the #b hotkey.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x5 y170,#B Screen X
GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, Edit, x5 y195 w100 vlaptopBatteryIconX, %laptopBatteryIconX%

;Y choice for the #b hotkey.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x120 y170,#B Screen Y
GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, Edit, x120 y195 w100 vlaptopBatteryIconY, %laptopBatteryIconY%

;For the Custom Window Group stuff.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x5 y225,Custom Window Groups

GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, Text, x5 y250,F6:
GUI, oldCPanel:Add, DDL, vF6Mode w118 x25 y248,Window Group||Window Hider

GUI, oldCPanel:Add, Text, x150 y250,F7:
GUI, oldCPanel:Add, DDL, vF7Mode w118 x177 y248,Window Group||Window Hider

GUI, oldCPanel:Add, Text, x5 y275,F8:
GUI, oldCPanel:Add, DDL, vF8Mode w118 x25 y273,Window Group|Window Hider||

GUI, oldCPanel:Add, Text, x150 y275,F10:
GUI, oldCPanel:Add, DDL, vF10Mode w118 x177 y273,Window Group|Window Hider||

;F3 Behavior.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x5 y303,F3 Behavior:

GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, DDL, vF3Mode w118 x102 y302, Google Chrome||VSCode

;Front Top Mouse Button.
GUI, oldCPanel:Font, s13
GUI, oldCPanel:Add, Text, x4 y334,Top Mouse Button Behavior

GUI, oldCPanel:Font, s11
GUI, oldCPanel:Add, DDL, vMouseButtonMode w125 x5 y356, Double Click||Next F6 Window

;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appears when the user wants it.
global controlPanelGUIToggle := 0

;Default values.
global InsMonChoice := "Primary Mon"
global CtrlInsMonChoice := "Secondary Mon"
global ChrBookTypeMonChoice := "Primary Mon"

CONTROL_PANEL_WIDTH := 286
CONTROL_PANEL_HEIGHT := 384

;************************************************new GUI****************************************************
GUI, CPanel:+AlwaysOnTop
GUI, CPanel:Color, Silver
GUI, CPanel:Margin, 3, 1

;Insert, Ctrl + Insert, and Chromebook Typing.
GUI, CPanel:Font, s9 q5
GUI, CPanel:Add, Text, xm+1 ym, Insert Monitor Choice
GUI, CPanel:Add, DDL, xm ym+14 w100 vInsMonChoice, Primary Mon||Secondary Mon

GUI, CPanel:Add, Text, xp+150 ym, Ctrl + Insert Monitor Choice
GUI, CPanel:Add, DDL, xp-1 ym+14 w100 vCtrlInsMonChoice, Primary Mon|Secondary Mon||

GUI, CPanel:Add, Text, xm+1 yp+27, Chromebook Typing Monitor
GUI, CPanel:Add, DDL, xm yp+14 w100 vChrBookTypeMonChoice, Primary Mon||Secondary Mon|

;F3 Behavior.
GUI, CPanel:Add, Text, x153 yp-14, F3 Behavior
GUI, CPanel:Add, DDL, x152 y56 w97 vF3Mode, Google Chrome||VSCode

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
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. A_ComputerName is: %A_ComputerName%`n`nIf you're on a desktop computer this can be totally ignored.
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
GUI, CPanel:Add, DDL, xm+17 yp-3 vF6Mode w94, Window Group||Window Hider

GUI, CPanel:Add, Text, xm yp+26, F8:
GUI, CPanel:Add, Text, xm+120 yp, F10:
GUI, CPanel:Add, DDL, xm+17 yp-3 vF8Mode w94, Window Group|Window Hider||

GUI, CPanel:Add, DDL, xm+143 yp-23 vF7Mode w94, Window Group||Window Hider
GUI, CPanel:Add, DDL, xp yp+23 vF10Mode w94, Window Group|Window Hider||

;Top Two Mouse Buttons.
FrontMouseButtonBehavior := "Double Click"
BackMouseButtonBehavior := "F6"

GUI, CPanel:Add, Text, xm yp+27, Front and Back Top Mouse Buttons Behavior
GUI, CPanel:Add, DDL, xm yp+17 w87 vFrontMouseButtonBehavior, Double Click||F6|F7|F8|F10
GUI, CPanel:Add, DDL, xm+90 yp w87 vBackMouseButtonBehavior, Double Click|F6||F7|F8|F10

; GUI, CPanel:Show, w%CONTROL_PANEL_WIDTH% h%CONTROL_PANEL_HEIGHT% x1090,MSR Control Panel

;****************************************MISC VARIABLES, INITIALIZATION, ETC*********************************
global Num2And8Step := 3 ;When Num2 or Num8 pressed, how much to increase/decrease volume.
global autoNumPadModeToggle := true ;If true, switch NumPad modes automatically. If false user manually controls it.
global systemMasterVolume ;Used for NumPad Media Control stuff.

global programmingMode := false ;Toggle for Programming Mode: disabling certain hotkeys/hotstrings to make programming easier. ^!Insert is the hotkey.

;Used for F9 and F11 on 2nd keeb for showing/hiding these programs. 1 = visible; 0 = not visible.
global OutlookVisibilityToggle := 1
global DiscordVisibilityToggle := 1

global F3Mode := "Google Chrome" ;Change in #o between this and VSCode.
global MouseButtonMode := "Double Click" ;Change between this and Next F6 Window.

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
			global numPadMode = "YouTube"
		} else if InStr(activeWindowTitle, "- MediaSpace") {
			SetNumLockState, Off
			SetScrollLockState, On
			global numPadMode = "Dumbed-Down"
		} else {
			SetNumLockState, On
			SetScrollLockState, Off
			global numPadMode = "MusicBee"
		}

	} else {

		;This works so much better than having a bunch of ugly numLockToggled = 1 and scrollLockToggled = 0 things everywhere.
		;These variables are used in NumPad Media Control.ahk.
		if (numLockToggled = 1 and scrollLockToggled = 0)
			global numPadMode = "MusicBee"
		else if (numLockToggled = 1 and scrollLockToggled = 1)
			global numPadMode = "YouTube"
		else if (numLockToggled = 0 and scrollLockToggled = 0)
			global numPadMode = "Normal"
		else if (numLockToggled = 0 and scrollLockToggled = 1)
			global numPadMode = "Dumbed-Down"
		else
			global numPadMode = "Normal"
	}
	Sleep 100 ;This sleep statement DRASTICALLY helps reduce the power and CPU usage of the MSR.
}

;Other files with many different hotkeys in them.
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\BooleanToggle.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\inArray.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk

#Include, %A_ScriptDir%\MSR Profiles\Browser.ahk
#Include, %A_ScriptDir%\MSR Profiles\Default.ahk
#Include, %A_ScriptDir%\MSR Profiles\Google Docs.ahk
#Include, %A_ScriptDir%\MSR Profiles\Google Sheets.ahk
#Include, %A_ScriptDir%\MSR Profiles\Microsoft Excel.ahk
#Include, %A_ScriptDir%\MSR Profiles\Microsoft Word.ahk
#Include, %A_ScriptDir%\MSR Profiles\VSCode.ahk

#Include, %A_ScriptDir%\Misc. MSR Scripts\ApplicationSwitcher.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\AutoCorrect.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\C-C++ Programming.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Custom Window Groups.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\NumPad Media Control.ahk
#Include, %A_ScriptDir%\Misc. MSR Scripts\Run\Run.ahk

#Include, %A_ScriptDir%\Screen Clipper Script\Screen Clipper.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Factorio.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Minecraft.ahk
#Include, %A_ScriptDir%\Video Game Stuff\Terraria.ahk

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\Secondary Macro Keyboard\Hasu USB to USB Script.ahk

;This is after the 2nd keeb script because if it is #Included before it and it's enabled it breaks the keys like j, k, l, a, etc.
#Include, %A_ScriptDir%\Misc. MSR Scripts\Chromebook Typing.ahk

;****************************************MISC HOTKEYS***************************************
^#r::reloadMSR() ;Reload MSR. If any windows are hidden, don't allow it to Reload until they're unhidden.

!#r::Reload ;Force Reload the script, even if there are windows hidden (or if the script says there is, but there actually isn't).

;Shows you miscellaneous variables, toggles, etc.
^#BackSpace::MsgBox, 0, Misc. Variables`, Toggles`, etc., MSR Profile: %currentProfile%`n`nnumPadMode: %NumPadMode%`n`nautoNumPadModeToggle: %autoNumPadModeToggle%

^Space::WinSet, AlwaysOnTop, Toggle, A ;Make active window AlwaysOnTop.

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
^!Insert::
programmingMode := !programmingMode

if (programmingMode = 1)
	Tippy("programmingMode On", 400)
else
	Tippy("programmingMode Off", 400)
return

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

!Insert::MouseMove, mousePosX, mousePosY, 0 ;Moves mouse pointer back to where it was before pressing Insert or ^Insert (but not both).

;Opens Wi-Fi menu.
#w::
MouseGetPos, originalX, originalY
MouseMove, %WinWX%, %WinWY%, 0
Sleep 200
Send, {Click}
MouseMove, originalX, originalY
return

~$RShift:: ;A "sniper" button, which slows the mouse pointer speed down to a crawl and still outputs the RShift key.
Send, {RShift}
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,1)
KeyWait, RShift
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;Top Front Mouse Button on Scimitar RGB.
^!F23::
if (FrontMouseButtonBehavior = "Double Click")
	Send, {Click 2}
else if (FrontMouseButtonBehavior = "F6")
	nextWinOrShowHideWins("F6", WindowGroupF6, CurrentWinF6)
else if (FrontMouseButtonBehavior = "F7")
	nextWinOrShowHideWins("F7", WindowGroupF7, CurrentWinF7)
else if (FrontMouseButtonBehavior = "F8")
	nextWinOrShowHideWins("F8", WindowGroupF8, CurrentWinF8)
else if (FrontMouseButtonBehavior = "F10")
	nextWinOrShowHideWins("F10", WindowGroupF10, CurrentWinF10)
return

;Top Back Mouse Button on Scimitar RGB.
^+F23::
if (BackMouseButtonBehavior = "Double Click")
	Send, {Click 2}
else if (BackMouseButtonBehavior = "F6")
	nextWinOrShowHideWins("F6", WindowGroupF6, CurrentWinF6)
else if (BackMouseButtonBehavior = "F7")
	nextWinOrShowHideWins("F7", WindowGroupF7, CurrentWinF7)
else if (BackMouseButtonBehavior = "F8")
	nextWinOrShowHideWins("F8", WindowGroupF8, CurrentWinF8)
else if (BackMouseButtonBehavior = "F10")
	nextWinOrShowHideWins("F10", WindowGroupF10, CurrentWinF10)
return

;****************************************GLOBAL K95 RGB HOTKEYS***************************************
;These 3 hotkeys are sent by the iCUE software, which AutoHotkey detects.
+F24::Send, ^c ;M1 on K95 RGB copies to the clipboard.
+F21::Send, ^x ;M2 on K95 RGB cuts to the clipboard.
+F22::Send, ^v ;M3 on K95 RGB pastes the clipboard.

;****************************************CONTEXT-SENSITIVE HOTKEYS***************************************
#If programmingMode = false
\::
Send, ^+{Left}
Send, {BackSpace}
return

::i::I

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

;*****************************************TITLE CAPITALIZATION TOOL (TCT)*********************************
;These hotkeys allow the user to adjust and modify text/titles in different ways.
;Inspiration and code for this: https://autohotkey.com/board/topic/57888-title-case/ and https://autohotkey.com/board/topic/123994-capitalize-a-title/
^!t:: ;Converts text to Title Case.
  Send, ^c ;Copy text, and wait a bit so it can actually process that.
  Sleep 45

  ;Makes the title in AHK's "Title Case", which in reality just capitalizes the first letter of each word.
  StringUpper, NewTitle, Clipboard, T
  head := SubStr(NewTitle, 1, 1) ;Manipulates and edits the String somehow.
  tail := SubStr(NewTitle, 2)

  ;Stores the NewTitle in the Clipboard.             This is the list of words to NOT capitalize.
  Clipboard := head RegExReplace(tail, "i)\b(a|an|and|at|but|by|for|in|nor|of|on|or|so|the|to|up|with|yet)\b", "$L1")

  Send ^v ;Paste the new title.
return

^!u:: ;Converts text to UPPER CASE.
	Send, ^c
	Sleep 45
	StringUpper, NewTitle, Clipboard
	Clipboard := NewTitle
	Send, ^v
return

^!l:: ;Converts text to lower case.
	Send, ^c
	Sleep 45
	StringLower, NewTitle, Clipboard
	Clipboard := NewTitle
	Send, ^v
return

^!s:: ;Converts text to sentence case.
	Send, ^c
	Sleep 45
	StringLower, NewTitle, Clipboard
	NewTitle := RegExReplace(Clipboard, "((?:^|[.!?]\s+)[a-z])", "$u1")
	Clipboard := NewTitle
	Send, ^v
return

^!f:: ;Converts text to First Letter Capitalization.
	Send, ^c
	Sleep 45
	StringUpper, NewTitle, Clipboard, T
	Clipboard := NewTitle
	Send, ^v
return

;Convert text to aLt CaSe, with the first letter being lower case.
;altCaseToggle is a toggle for if the alt case starts in lower case or not.
;A_LoopField is the single character at that point in the Parse Loop.
;0 = convert the char (A_LoopField) to lower...
;...1 = convert the char to UPPER.
^!a::
	finalString :=
	altCaseToggle := 0

	Send, ^c
	Sleep, 50

	;Loop through the contents of the Clipboard, and toggle between cases.
	Loop, Parse, Clipboard
	{
		if (altCaseToggle = 0) {
			if (A_LoopField = A_Space) {
				;If the current char is a space, don't toggle the var and just concatenate it to the finalString.
				finalString := finalString . A_Space
			} else {
				StringLower, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		} else if (altCaseToggle = 1) {
			if (A_LoopField = A_Space) {
				finalString := finalString . A_Space
			} else {
				StringUpper, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		}
	}

	Clipboard := finalString
	Send, ^v
return

^!+a:: ;Convert text to AlT cAsE, with the first letter being UPPER case.
	finalString :=
	altCaseToggle := 1

	Send, ^c
	Sleep, 50

	;Loop through the contents of the Clipboard, and toggle between cases.
	Loop, Parse, Clipboard
	{
		if (altCaseToggle = 0) {
			if (A_LoopField = A_Space) {
				finalString := finalString . A_Space
			} else {
				StringLower, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		} else if (altCaseToggle = 1) {
			if (A_LoopField = A_Space) {
				finalString := finalString . A_Space
			} else {
				StringUpper, strLwUpOutput, A_LoopField
				finalString := finalString . strLwUpOutput
				altCaseToggle := !altCaseToggle
			}
		}
	}

	Clipboard := finalString
	Send, ^v
return

^+s:: ;A d d s   a   s p a c e   b e t w e e n   l e t t e r s .
	finalString :=
	Send, ^c
	Sleep, 50

	;Loop through the contents of the Clipboard, and toggle between cases.
	Loop, Parse, Clipboard
		finalString := finalString . A_LoopField . A_Space

	Clipboard := finalString
	Send, ^v
return

;*****************************EDIT CLIPBOARD CONTENT GUI BEHAVIOR******************************
;Toggles between showing and hiding the Clipboard GUI.
#c::
GuiControl, ECC:,clipboardBoxText, %Clipboard%

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
else
	GUI, CPanel:Hide
return

CPanelGuiClose:
CPanelGuiEscape:
GUI, CPanel:Submit
controlPanelGUIToggle := !controlPanelGUIToggle
return

;*****************************************EASY WINDOW DRAGGING (EWD)*********************************
;Normally, a window can only be dragged by clicking on its title bar.
;This extends that so that any point inside a window can be dragged.
~LButton & RButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
if EWD_WinState = 0  ; Only if the window isn't maximized
	SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
	SetTimer, EWD_WatchMouse, Off
	return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
	SetTimer, EWD_WatchMouse, Off
	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
	return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return

;**************************************************FUNCTIONS AND LABELS**************************************************
;Used for the Reload hotkey and also for the 2nd keeb.
;Checking for if windows are hidden helps prevent them from getting indefinitely hidden and thus lost.
reloadMSR() {
	if (F6ShowHideToggle = 1)
		MsgBox, 262160, Error. Can't Reload MSR., There are F6 windows hidden. Unhide them and then reload MSR.
	else if (F7ShowHideToggle = 1)
		MsgBox, 262160, Error. Can't Reload MSR., There are F7 windows hidden. Unhide them and then reload MSR.
	else if (F8ShowHideToggle = 1)
		MsgBox, 262160, Error. Can't Reload MSR., There are F8 windows hidden. Unhide them and then reload MSR.
	else if (F10ShowHideToggle = 1)
		MsgBox, 262160, Error. Can't Reload MSR., There are F10 windows hidden. Unhide them and then reload MSR.
	else
		Reload ;If no windows are hidden.
}

;**************************************************EXPERIMENTAL**************************************************
;**************************************************TEMPORARY**************************************************
:*:hon comp::Honors: Composition II
:*:hcomp::Honors Composition II

;For Pop Culture paper.
:*:shrek::Shrek
:*:fiona::Fiona
:*:farquaad::Farquaad
:*:lofa::Lord Farquaad
:*:duloc::Duloc

#IfWinActive, ahk_exe Zoom.exe
$PrintScreen::Send, #{PrintScreen}

$CapsLock:: ;"Hide" the mouse pointer, and hide the Zoom meeting controls.
MouseGetPos, mousePosX, mousePosY
MouseMove, 1920, 540, 0
Send, {LAlt}
return
#If