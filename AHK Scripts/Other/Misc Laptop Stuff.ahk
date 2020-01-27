#SingleInstance force
SendMode, Input

#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\ApplicationSwitcher.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\AutoCorrect.ahk
#Include, C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Daily Drivers\Main Script.ahk Stuff\Run.AHK


PrintScreen::
Send, {AppsKey}
return

!PrintScreen::
Send, ^{Esc}
return




;Log volume scaling stuff for NumpadAdd and NumpadEnter. IDK where I found this, nor do I know how it works.
f(x) {
return exp(6.908*x)/1000.0
}
inv(y) {
return ln(1000.0*y)/6.908
}


!Up::
;~ SoundSet, +1
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return

!Down::
;~ SoundSet, -1
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return


:*:ai::AI
:*:aai::artificial intelligence

;Commented out because it's useless.
/*
;Shows the current and exact master volume.
!\::
SoundGet, master_volume
master_volume := Round(master_volume, 2)
MsgBox, 0, Master Volume, Master volume is %master_volume% percent., 0.39
return
*/

;Get the current master volume, and add the inputted value to the current master volume.
!\::
SoundGet, master_volume
InputBox, master_volume_alt , Add/subtract to the master volume, Input a number to add/subtract to the current master volume. Current volume: %master_volume%., , , , , , , , %master_volume%
if (ErrorLevel = 1) {
} else if (ErrorLevel = 0) {
	master_volume += master_volume_alt
    SoundSet, %master_volume%
}
return

;Gets the aforementioned master volume, displays it, and allows the user to input their own exact and custom volume.
^\::
SoundGet, master_volume
InputBox, master_volume , Input Custom Volume, Input a custom volume. Current volume: %master_volume%., , , , , , , , %master_volume%
SoundSet, %master_volume%
return

^Space::
WinSet, AlwaysOnTop, Toggle, A
return

;For English papers
;~ #Enter::
;~ SendInput, Title: `nMcFarland Link: `n`nLink: `n`nAccessed: `nAuthor: `nSource: `nPublisher: `nInfo:{Space}
;~ return


;For Firefox
^Tab::
Send, ^{PGDN}
return

^+Tab::
Send, ^{PGUP}
return


;Move mouse off screen...
Insert::
MouseGetPos, mousePosX, mousePosY
MouseMove, 1920, 540, 0
return

;... and back to where it was initially
!Insert::
MouseMove, mousePosX, mousePosY, 0
return

;For use with my little red mouse
;Wheel left
XButton1::
Send, ^+{Tab}
return

;Wheel right
XButton2::
Send, ^{Tab}
return

!XButton1::
Send, !{Left}
return

!XButton2::
Send, !{Right}
return

;~ RButton & XButton1::
;~ Send, !{Left}
;~ return

;~ RButton & XButton2::
;~ Send, !{Right}
;~ return

;~ $RButton::
;~ Send, {RButton}
;~ return


;The grave accent key (that weird thing under the Tilde ~ symbol) sends Alt + Tab. This scan code is for the grave accent key.
sc029::
Send, !{Tab}
return

;Holding Ctrl and pushing the grave accent key inserts the grave accent symbol: `. This scan code is for the grave accent key.
^sc029::
Send, ``
return

#p::
Suspend
return

:*:itss::it's

CapsLock::
return