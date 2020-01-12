#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

/*
This is the script that allows me to control media stuff with the NumPad. It has several modes, which all cause it to different things.
Originally I was going to have it do the NumPad modes automatically, but applying what I learned from my experience with iCUE, I decided against it.
For two reasons: 1) more control, and 2) so the script doesn't try to act smart and switch between modes automatically (like trying to edit a profile in
iCUE and it keeps flipping profiles (modes) constantly, which is EXTREMELY ANNOYING when trying to work on something). That's also one of the reasons I moved
as much of my stuff as possible from iCUE to AHK. Text programming is always better than GUI programming (like iCUE).
*/

global master_volume


;Log volume scaling stuff for NumpadAdd and NumpadEnter. IDK where I found this, nor do I know how it works.
f(x) {
return exp(6.908*x)/1000.0
}
inv(y) {
return ln(1000.0*y)/6.908
}


;Gets the master volume, displays it, and allows the user to input their own exact and custom volume.
^NumpadSub::
SoundGet, master_volume
InputBox, master_volume , Input Custom Volume, Input a custom volume. Current volume: %master_volume%., , , , , , , , %master_volume%
SoundSet, %master_volume%
return

;Change the step value of NumPad 2 and NumPad 8.
!NumpadSub::
InputBox, Num2And8Step, Input Num2 and Num8 step value, Input Num2 and Num8 step value. Current value: %Num2And8Step%., , , , , , , , %Num2And8Step%
return


;If NumLock = On and ScrollLock = Off. The brackets are for condensing the code.
;This mode makes listening to music much easier and thus much more enjoyable.
#If NumPadMode = "MusicBee"
{

;No function.
$Numpad0::
return

$NumpadIns::
return


;No function.
$NumpadDot::
return

$NumpadDel::
return


;No function.
$Numpad1::
return

$NumpadEnd::
return


;Turns the volume down according to the "Num2And8Step" variable.
$Numpad2::
SoundSet, -%Num2And8Step%
return

$NumpadDown::
SoundSet, -%Num2And8Step%
return


;No function.
$Numpad3::
return

$NumpadPgdn::
return


;Increase (Add) and decrease (Enter) the volume with some logarithmic volume scaling stuff.
$NumpadAdd::
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return


$NumpadEnter::
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return


;Previous track.
$Numpad4::
Send, {Media_Prev}
return

$NumpadLeft::
Send, {Media_Prev}
return


;Play/pause
$Numpad5::
Send, {Media_Play_Pause}
return

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::
Send, {Media_Play_Pause}
return


;Forward five seconds.
$Numpad6::
Send, {Media_Next}
return

$NumpadRight::
Send, {Media_Next}
return


;No function.
$Numpad7::
return

$NumpadHome::
return


;Turns the volume up according to the "Num2And8Step" variable.
$Numpad8::
SoundSet, +%Num2And8Step%
return

$NumpadUp::
SoundSet, +%Num2And8Step%
return


;No function.
$Numpad9::
return

$NumpadPgup::
return


;Lower volume by 1
$NumpadDiv::
SoundSet, -1
return


;Raises volume by 1
$NumpadMult::
SoundSet, +1
return


;Shows the current and exact master volume.
$NumpadSub::
SoundGet, master_volume
master_volume := Round(master_volume, 2)
MsgBox, 0, Master Volume, Master volume is %master_volume% percent., 0.39
return

}

;If NumLock = On and ScrollLock = On.
;This mode makes watching YouTube videos easier.
#If NumPadMode = "YouTube"
{

;No function.
$Numpad0::
return

$NumpadIns::
return


;Toggle captions.
$NumpadDot::
Send, c
return

$NumpadDel::
Send, c
return


;Mute.
$Numpad1::
Send, m
return

$NumpadEnd::
Send, m
return


;Turns the volume down according to the "Num2And8Step" variable.
$Numpad2::
SoundSet, -%Num2And8Step%
return

$NumpadDown::
SoundSet, -%Num2And8Step%
return


;Send f to make the YouTube video full screen
$Numpad3::
Send, f
return

$NumpadPgdn::
Send, f
return


;Increase (Add) and decrease (Enter) the volume with some logarithmic volume scaling stuff.
$NumpadAdd::
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return


$NumpadEnter::
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return


;Backwards five seconds.
$Numpad4::
Send, {Left}
return

$NumpadLeft::
Send, {Left}
return


;Play/pause
$Numpad5::
Send, k
return

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::
Send, k
return


;Forward five seconds.
$Numpad6::
Send, {Right}
return

$NumpadRight::
Send, {Right}
return


;Backwards ten seconds.
$Numpad7::
Send, j
return

$NumpadHome::
Send, j
return


;Turns the volume up according to the "Num2And8Step" variable.
$Numpad8::
SoundSet, +%Num2And8Step%
return

$NumpadUp::
SoundSet, +%Num2And8Step%
return


;Forwards ten seconds.
$Numpad9::
Send, l
return

$NumpadPgup::
Send, l
return


;Lower volume by 1
$NumpadDiv::
SoundSet, -1
return


;Raises volume by 1
$NumpadMult::
SoundSet, +1
return


;Shows the current and exact master volume.
$NumpadSub::
SoundGet, master_volume
master_volume := Round(master_volume, 2)
MsgBox, 0, Master Volume, Master volume is %master_volume% percent., 0.39
return

}

;If NumLock = Off and ScrollLock = On/Off.
;All keys in "Normal" mode behave like they normally would.
;Hotkeys with one space between them are a pair.
;E.g., 0 and Ins are a pair, because 0 and Ins are on the same physical key.
;Two spaces separate each pair.
#If NumPadMode = "Normal"
{

$Numpad0::
Send, {Numpad0}
return

$NumpadIns::
Send, {Numpad0}
return


$NumpadDot::
Send, {NumpadDot}
return

$NumpadDel::
Send, {NumpadDot}
return


$Numpad1::
Send, {Numpad1}
return

$NumpadEnd::
Send, {Numpad1}
return


$Numpad2::
Send, {Numpad2}
return

$NumpadDown::
Send, {Numpad2}
return


$Numpad3::
Send, {Numpad3}
return

$NumpadPgdn::
Send, {Numpad3}
return


$NumpadAdd::
Send, {NumpadAdd}
return


$NumpadEnter::
Send, {NumpadEnter}
return


$Numpad4::
Send, {Numpad4}
return

$NumpadLeft::
Send, {Numpad4}
return


$Numpad5::
Send, {Numpad5}
return

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::
Send, {Numpad5}
return


$Numpad6::
Send, {Numpad6}
return

$NumpadRight::
Send, {Numpad6}
return


$Numpad7::
Send, {Numpad7}
return

$NumpadHome::
Send, {Numpad7}
return


$Numpad8::
Send, {Numpad8}
return

$NumpadUp::
Send, {Numpad8}
return


$Numpad9::
Send, {Numpad9}
return

$NumpadPgup::
Send, {Numpad9}
return


$NumpadDiv::
Send, {NumpadDiv}
return

$NumpadMult::
Send, {NumpadMult}
return

$NumpadSub::
Send, {NumpadSub}
return

}
#If