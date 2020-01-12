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


/*
$Numpad0::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
  ;This disables the key, so it doesn't do anything.
  return
} else if (NumPadMode = "Normal") {
	Send, {Numpad0}
}
return

$NumpadIns::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
  ;This disables the key, so it doesn't do anything.
  return
} else if (NumPadMode = "Normal") {
	Send, {Numpad0}
}
return


$NumpadDot::
if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "YouTube") {
	Send, c
} else {
	Send, {NumpadDot}
	return
}
return

$NumpadDel::
if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "YouTube") {
	Send, c
} else {
	Send, {NumpadDot}
	return
}
return


$Numpad1::
if (NumPadMode = "YouTube") {
	Send, m
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad1}
	return
}
return

$NumpadEnd::
if (NumPadMode = "YouTube") {
	Send, m
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad1}
	return
}
return


$Numpad2::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, -%Num2And8Step%
	return	
} else if (NumPadMode = "Normal") {
	Send, {Numpad2}
	return
}

$NumpadDown::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, -3
	return	
} else if (NumPadMode = "Normal") {
	Send, {Numpad2}
	return
} else {
	Send, {Numpad2}
	return
}


$Numpad3::
if (NumPadMode = "YouTube") {
	Send, f
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad3}
	return
}
return

$NumpadPgdn::
if (NumPadMode = "YouTube") {
	Send, f
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad3}
	return
}
return

/*
$NumpadEnter::
if (NumLockToggled = 1) {
	SoundSet, -2
} else if (NumLockToggled = 0) {
	Send, {NumpadEnter}
	return
}
return
*/

/*
;Some logarithmic volume scaling stuff I was trying. Idk if it really works all that well. Idk where I found it, too.
NumpadAdd::changeVolume(1)
NumpadEnter::changeVolume(-1)

changeVolume(ud){
	static p := 20
	static lb := 1		; lower bound
	SoundGet, vol
	vol := vol * (1 + ud * p / 100)
	if (vol <= lb && ud < 0)	; Mute if less than lower bound and ud is negative.
		vol := 0
	else if (vol == 0 && ud > 0)			; Unmute if vol is 0 and ud is positive.
		vol := lb		
	SoundSet, vol
}







f(x)
{
return exp(6.908*x)/1000.0
}
inv(y)
{
return ln(1000.0*y)/6.908
}



$NumpadAdd::
if (NumPadMode = "YouTube") or (NumPadMode = "MusicBee") {
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return
} else {
	Send, {NumpadAdd}
	return
}
	

$NumpadEnter::
if (NumPadMode = "YouTube") or (NumPadMode = "MusicBee") {
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return
} else {
	Send, {NumpadEnter}
	return
}



$Numpad4::
if (NumPadMode = "YouTube") {
	Send, {Left}
	return
} else if (NumPadMode = "MusicBee") {
	Send, {Media_Prev}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad4}
	return
}
return

$NumpadLeft::
if (NumPadMode = "YouTube") {
	Send, {Left}
	return
} else if (NumPadMode = "MusicBee") {
	Send, {Media_Prev}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad4}
	return
}
return


$Numpad5::
if (NumPadMode = "YouTube") {
	Send, k
	return
} else if (NumPadMode = "MusicBee") {
	Send, {Media_Play_Pause}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad5}
	return
}
return

$NumpadClear:: ;This weird key goes with Numpad5. I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
if (NumPadMode = "YouTube") {
	Send, k
	return
} else if (NumPadMode = "MusicBee") {
	Send, {Media_Play_Pause}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad5}
	return
}
return


$Numpad6::
if (NumPadMode = "YouTube") {
	Send, {Right}
	return
} else if (NumPadMode = "MusicBee") {
	Send, {Media_Next}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad6}
	return
}
return

$NumpadRight::
if (NumPadMode = "YouTube") {
	Send, {Right}
	return
} else if (NumPadMode = "MusicBee") {
	Send, {Media_Next}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad6}
	return
}
return

/*
$NumpadAdd::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, +2
	return	
} else if (NumPadMode = "Normal") {
	Send, {+}
	return
}
return


$Numpad7::
if (NumPadMode = "YouTube") {
	Send, j
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad7}
	return
}
return

$NumpadHome::
if (NumPadMode = "YouTube") {
	Send, j
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad7}
	return
}
return


$Numpad8::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, +%Num2And8Step%
	return	
} else if (NumPadMode = "Normal") {
	Send, {Numpad8}
	return
}
return

$NumpadUp::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, +3
	return	
} else if (NumPadMode = "Normal") {
	Send, {Numpad8}
	return
}
return


$Numpad9::
if (NumPadMode = "YouTube") {
	Send, l
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad9}
	return
}
return

$NumpadPgup::
if (NumPadMode = "YouTube") {
	Send, l
	return
} else if (NumPadMode = "MusicBee") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad9}
	return
}
return


$NumpadDiv::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, -1
	return	
} else if (NumPadMode = "Normal") {
	Send, {NumpadDiv}
	return
}
return

$NumpadMult::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundSet, +1
	return	
} else if (NumPadMode = "Normal") {
	Send, {NumpadMult}
	return
}
return

;Shows the current and exact master volume.
$NumpadSub::
if (NumPadMode = "MusicBee" or NumPadMode = "YouTube") {
	SoundGet, master_volume
	master_volume := Round(master_volume, 2)
	MsgBox, 0, Master Volume, Master volume is %master_volume% percent., 0.39
} else if (NumPadMode = "Normal") {
	Send, {NumpadSub}
	return
}
return