#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;This awesome little script allows me to show and hide windows.
;I can't remember where I found this script; probably on the AHK forums.
;I don't really know how it works, because comments are nonexistent.

/*
******************************Hotkeys******************************
* ^F10:: Hide Current Window and add it to hidden window list.
* !F10:: Show and activate "previously" hidden window (the one at the top of the list).
* +F10:: Show all hidden windows (unhide them).
* #F10:: Display a list of hidden windows with their index next to it. If user presses 1-9, it will show and activate the window with that index.
*/


^F10:: ;Hide current window - add to list
	SetTitleMatchMode, 3 ;***
	if (NumHiddenWindows = "")
		NumHiddenWindows:=0
	NumHiddenWindows:=NumHiddenWindows+1
	WinGetTitle PreviousHiddenWindow, A
	HiddenWindows%NumHiddenWindows%:=PreviousHiddenWindow
	WinMinimize A
	WinHide %PreviousHiddenWindow%
	WinActivate
	;msgbox _%NumHiddenWindows%_%PreviousHiddenWindow%
	
return ;*

!F10:: ;bring back previously hidden window
	SetTitleMatchMode, 3 ;***
	;Msgbox %PrevMinimize%
	if (PreviousHiddenWindow <> "")
	{
		WinShow %PreviousHiddenWindow%
		WinRestore %PreviousHiddenWindow%
		WinActivate %PreviousHiddenWindow%
		NumHiddenWindows:=NumHiddenWindows - 1
		PreviousHiddenWindow:=HiddenWindows%NumHiddenWindows%
	}
	
return

+F10::ShowAllHiddenWindows() ;Show All Hidden Windows

#F10:: ;Hidden Window List & Goto
	SetTitleMatchMode, 3 ;***
	if (NumHiddenWindows="" or NumHiddenWindows <= 0)
	{
		msgbox There are no Hidden Windows at this time.
		return
	}
	WindowList=
	Loop %NumHiddenWindows%
	{
		if (A_Index >= 10)
			WindowList:=WindowList . "...The Following windows cannot be reached directly through this...`n"
		CurWindow:=HiddenWindows%A_Index%
		;WinShow %CurWindow%
		WindowList:=WindowList . A_Index . ") " . CurWindow . "`n"
		
	}
	
	Progress , m zh0 fs12 c00 WS550 W750
		, %WindowList%
		, 
		, Window List - Select the number you want to unhide
		
	Input, VKey_Main, L1
	progress , off

	
	if (VKey_Main >= 1 and VKey_Main <= 9)
	{
		WinToShow:=HiddenWindows%VKey_Main%
		WinShow %WinToShow%
		WinActivate %WinToShow%
		if (VKey_Main < NumHiddenWindows)
		{
			NumLoops:= NumHiddenWindows - VKey_Main
			Loop %NumLoops%
			{
				IndexToEdit:=VKey_Main + A_Index - 1
				IndexToCopy:=IndexToEdit + 1
				HiddenWindows%IndexToEdit%:=HiddenWindows%IndexToCopy%
			}
			NumHiddenWindows:=NumHiddenWindows - 1		
		}
		else
		{
			NumHiddenWindows:=NumHiddenWindows - 1
			PreviousHiddenWindow:=HiddenWindows%NumHiddenWindows%
		}
		
	}
	
return ;*

ShowAllHiddenWindows()
{
	global NumHiddenWindows
	global HiddenWindows
	SetTitleMatchMode, 3
	;msgbox _%NumHiddenWindows%_
	if (NumHiddenWindows="" or NumHiddenWindows <= 0)
		return
	Loop %NumHiddenWindows%
	{
		CurWindow:=HiddenWindows%A_Index%
		;msgbox %CurWindow%
		WinShow %CurWindow%
		WinRestore %CurWindow%
		WinActivate %CurWindow%
	}
	NumHiddenWindows:=0
}