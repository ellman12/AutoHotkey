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
*/
;///////////////////////////////////////////////////////////////////////

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

