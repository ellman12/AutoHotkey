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
* best in separate files: the long files with context-sensitive hotkeys, as well as 'header' files.

* Here's how this giant script is laid out: https://imgur.com/R14NAWW

* Important Acronyms:
* MRS: Main Script Revised

* Conventions for the number of * for a title/header.
* Title:    50 **************************************************
* Header 1: 35 ***********************************
* Header 2: 20 ********************
* Header 3: 14 **************
* Header 4: 9  *********
*/
;///////////////////////////////////////////////////////////////////////


/* TODO:
Remove Run and other help GUIs and replace with txt files
Fix the number of *'s for headers and titles so it's consistent
Refine the command line stuff
Redo that pic of the layout of this script; missed some important parts.
*/

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

;Pic of all these icons: https://diymediahome.org/wp-content/uploads/shell32_icons.jpg
Menu, Tray, Icon, shell32.dll, 233 ;Changes the icon to a cute little computer.

/*
;******************************************AUTO-EXECUTE*************************************************
;****************************************CUSTOM WINDOW GROUPS*********************************
;Tracks all the window IDs for the custom groups.
global WindowGroupF6 := [] ;Stores Window IDs.
global CurrentWinF6 := 1 ;Tracks the current window you're on.
global WindowGroupF7 := []
global CurrentWinF7 := 1
global WindowGroupF8 := []
global CurrentWinF8 := 1
global WindowGroupF10 := []
global CurrentWinF10 := 1

;Prevents losing windows when reloading the script with windows hidden.
global F6WindowsHidden := false
global F7WindowsHidden := false
global F8WindowsHidden := false
global F10WindowsHidden := false

;Declare these as 1 so the first time you press F8, it hides everything.
;If it's 1, hide windows; if it's 0, show windows.
global F6ShowHideToggle := 1
global F7ShowHideToggle := 1
global F8ShowHideToggle := 1
global F10ShowHideToggle := 1

;*************Screen Clipper.ahk Initialization Stuff************
Hotkey, #s , CreateCapWindow , On ;Take a screen clip with the Screen Clipper script.
SaveToFile := 1 ;Set this to 1 to save all clips with a unique name , Set it to 0 to overwrite the saved clip every time a new clip is made.
ShowCloseButton := 1 ;Set this to 1 to show a small close button in the top right corner of the clip. Set this to 0 to keep the close button, but not show it.
CoordMode, Mouse , Screen ;Use the screen as the reference to get positions from.

IfNotExist, %A_ScriptDir%\Screen Clipper Script\Saved Clips ; if there is no folder for saved clips
	FileCreateDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ; create the folder.
SetWorkingDir, %A_ScriptDir%\Screen Clipper Script\Saved Clips ;Set the saved clips folder as the working dir.
Handles := [] ; Create an array to hold the name of the different gui's.
Index := 0 ;Used as the name of the current gui cap window.

;*******************************MAIN SCRIPT CONTROL PANEL INITIALIZATION******************************
;This is a GUI for the Main Script that allows the user to change how parts of the script work: stuff
; which probably couldn't really be done well with hotkeys.
GUI, CPanel:+AlwaysOnTop
GUI, CPanel:Color, Silver

;Insert.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y5,Insert Hotkey Monitor Choice
GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y30 w136 vInsMonChoice, 1 (Primary Mon)||2 (Secondary Mon)

;Ctrl + Insert.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y60,Ctrl + Insert Hotkey Monitor Choice
GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y85 w136 vCtrlInsMonChoice, 1 (Primary Mon)|2 (Secondary Mon)||

;For Chromebook Typing, which monitor to send the mouse pointer too.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y115,Chromebook Typing Monitor Choice
GUI, CPanel:Font, s11
GUI, CPanel:Add, DropDownList, x5 y140 w136 vChrBookTypeMonChoice, 1 (Primary Mon)||2 (Secondary Mon)|

;Default screen X and Y of battery icons; user can change them later in #o.
if (A_ComputerName = "Ellott-Laptop") {
	laptopBatteryIconX := 1432
	laptopBatteryIconY := 885
    usingALaptop = true
} else if (A_ComputerName = "Elliott-DSU-Lap") {
	laptopBatteryIconX := 1664
	laptopBatteryIconY := 1049 ;This is WITHOUT the Ink Workspace button shown. If it's shown, it's 1618 and 1049.
    usingALaptop = true
} else if (A_ComputerName = "Elliott-PC") {
	usingALaptop = false
} else {
	MsgBox, 16, Error. Computer/laptop name not part of the script., Error. Computer/laptop name not part of the script. A_ComputerName is: %A_ComputerName%`n`nIf you're on a desktop computer this can be totally ignored.
}

;X choice for the #b hotkey.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y170,#B Screen X
GUI, CPanel:Font, s11
GUI, CPanel:Add, Edit, x5 y195 w100 vlaptopBatteryIconX, %laptopBatteryIconX%

;X choice for the #b hotkey.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x120 y170,#B Screen Y
GUI, CPanel:Font, s11
GUI, CPanel:Add, Edit, x120 y195 w100 vlaptopBatteryIconY, %laptopBatteryIconY%

;For the Custom Window Group stuff.
GUI, CPanel:Font, s13
GUI, CPanel:Add, Text, x5 y225,Custom Window Groups

GUI, CPanel:Font, s11
GUI, CPanel:Add, Text, x5 y250,F6
GUI, CPanel:Add, DDL, vF6Choice w118 x25 y248,Window Group||Window Hider

GUI, CPanel:Add, Text, x150 y250,F7
GUI, CPanel:Add, DDL, vF7Choice w118 x177 y248,Window Group||Window Hider

GUI, CPanel:Add, Text, x5 y275,F8
GUI, CPanel:Add, DDL, vF8Choice w118 x25 y273,Window Group|Window Hider||

GUI, CPanel:Add, Text, x150 y275,F10
GUI, CPanel:Add, DDL, vF10Choice w118 x177 y273,Window Group||Window Hider||

;Toggle for showing or hiding the GUI.
;If it's 1, show the GUI; if it's 0, hide it.
;Starts out as 0, so it only appers when the user wants it.
global showControlPanelGUI := 0

;Default values.
global InsMonChoice := "1 (Primary Mon)"
global CtrlInsMonChoice := "2 (Secondary Mon)"
global ChrBookTypeMonChoice := "1 (Primary Mon)"

CONTROL_PANEL_WIDTH := 298
CONTROL_PANEL_HEIGHT := 300

;****************************************MISC VARIABLES, INITIALIZATION, ETC*********************************
;Used for the step values for NumPad2 and NumPad8 for NumPad Media Control.
global Num2And8Step := 3

;Toggle for if the NumPad switches modes automatically or not; starts out at true, for convenience.
global autoNumPadModeToggle := true

;Toggle for Programming Mode: disabling certain hotkeys/hotstrings to make programming easier. ^!Insert is the hotkey.
global programmingMode := false

;Toggle for Game Mode. This disables any hotkeys/hotstrings that I find annoying whilst gaming. This is toggled in Run.ahk.
global gameModeActive := false ;TODO: WHAT IS THIS?

;The stuff in this loop needs to be running constantly.
Loop {

	global activeWindowTitle
	WinGetActiveTitle, activeWindowTitle

	global activeWindowID
	WinGet, activeWindowID, ID, A

	;Constantly checking to see what profile the script should put the user in.
	global currentProfile := autoSelectProfiles()

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
		if (numLockToggled = 1 and scrollLockToggled = 0) {
			global numPadMode = "MusicBee"
		} else if (numLockToggled = 1 and scrollLockToggled = 1) {
			global numPadMode = "YouTube"
		} else if (numLockToggled = 0 and scrollLockToggled = 0) {
			global numPadMode = "Normal"
		} else if (numLockToggled = 0 and scrollLockToggled = 1) {
			global numPadMode = "Dumbed-Down"
		} else {
			global numPadMode = "Normal"
		}

	}

	This sleep statement DRASTICALLY helps reduce the power and CPU usage of the Main Script.
	Sleep 200
}
*/
;TODO: #Include files.

;****************************************MISC HOTKEYS***************************************
^#r::Reload ;TODO: When Window Groups is done make this keep hidden windows safe from being lost.

;Force Reload the script, even if there are windows hidden (or if the script says there is, but there actually isn't).
!#r::Reload

;Shows you miscellaneous variables, toggles, etc.
^#BackSpace::MsgBox, Misc. Variables`, Toggles`, etc.,Current Main Script.ahk profile:  %currentProfile%`n`nNumPadMode: %numPadMode%`n`nChromebook Typing Toggled: %chromebookTypingToggle%`n`nautoNumPadModeToggle: %autoNumPadModeToggle%

^Space::WinSet, AlwaysOnTop, Toggle, A

^#s::Run, C:\Program Files\AutoHotkey\WindowSpy.ahk

^CtrlBreak:: ;Technically Ctrl + Pause. Read about this here: https://www.autohotkey.com/docs/KeyList.htm#other
#!p::
Suspend, Toggle
return

Pause:: ;Suspends all hotkeys for the specified number in milliseconds.
#p::
SetTimer, setTimerLabel, 2500, On
Suspend, On
return

setTimerLabel:
Suspend, Off
SetTimer, setTimerLabel, Off
return

sc029::Send, !{Tab} ;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab.

^sc029::Send, `` ;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `.

^+sc029::Send, ~ ;Holding Ctrl and Shift and pushing the grave accent key inserts the tilde symbol: ~.

*CapsLock::return ;Completely disables this horrible key.

!SC00C::WinMinimize, A ;Alt + -

!SC00D::WinMaximize, A ;Alt + +.

^+f::Run, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts

;Open Notepad.
#n::Run, Notepad

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
if (InsMonChoice = "1 (Primary Mon)")
	MouseMove, 1920, 540, 0
else if (InsMonChoice = "2 (Secondary Mon)")
	MouseMove, -1920, 540, 0
return

^Insert:: ;Moves mouse pointer as far off the screen as possible (on second display).
if (CtrlInsMonChoice = "1 (Primary Mon)")
	MouseMove, 1920, 540, 0
else if (CtrlInsMonChoice = "2 (Secondary Mon)")
	MouseMove, -1920, 540, 0
return

!Insert::MouseMove, mousePosX, mousePosY, 0 ;Moves mouse pointer back to where it was before pressing Insert or ^Insert (but not both).

~$RShift:: ;A "sniper" button, which slows the mouse pointer speed down to a crawl and still outputs the RShift key.
Send, {RShift}
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,1)
KeyWait, RShift
DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,1)
return

;****************************************K95 RGB HOTKEYS***************************************
;These 3 hotkeys are sent by the iCUE software, which AutoHotkey detects.
;M1 on K95 RGB copies to the clipboard.
+F24::Send, ^c

;M2 on K95 RGB cuts to the clipboard.
+F21::Send, ^x

;M3 on K95 RGB pastes to the clipboard.
+F22::Send, ^v

;****************************************CONTEXT-SENSITIVE HOTKEYS***************************************
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
#If

#IfWinActive Search ;When Cortana/Search is open.
!s::Send, {Space}meaning

RWin::
Send, {LWin}
Sleep 300
Send, {LWin}
return
#If

#If programmingMode = false
\::
Send, ^+{Left}
Send, {BackSpace}
return

::i::I
::git::Git

#If usingALaptop = true
#b:: ;Open battery menu.
MouseMove, %laptopBatteryIconX%, %laptopBatteryIconY%, 0
Sleep 300
Send, {Click}
return

~RShift::Send, {Media_Play_Pause}
^!Left::Send, {Media_Prev}
^!Right::Send, {Media_Next}

!PGUP::SoundSet, +1
!PGDN::SoundSet, -1

;Get the current master volume, and add the inputted value to the current master volume.
!\::
SoundGet, systemMasterVolume
InputBox, masterVolumeAlt , Add/subtract to the master volume, Input a number to add/subtract to the current master volume. Current volume: %systemMasterVolume%., , , , , , , , %systemMasterVolume%
if (ErrorLevel = 1) {
} else if (ErrorLevel = 0) {
	systemMasterVolume += masterVolumeAlt
    SoundSet, %systemMasterVolume%
}
return

;For Firefox
^Tab::
Send, ^{PGDN}
return

^+Tab::
Send, ^{PGUP}
return

#IfWinNotActive, ahk_exe explorer.exe

!Up::
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return

!Down::
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return

#If

;*****************************************HOTKEYS FOR TITLE STUFF*********************************