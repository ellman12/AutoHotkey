#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

/*
This is the script that allows me to control media stuff with the NumPad. It has several modes, which all cause it to different things.
Originally I was going to have it do the NumPad modes automatically, but applying what I learned from my experience with iCUE, I decided against it.
For two reasons: 1) more control, and 2) so the script doesn't try to act smart and switch between modes automatically (like trying to edit a profile in
iCUE and it keeps flipping profiles (modes) constantly, which is annoying as fuck when trying to work on something). That's also one of the reasons I moved
as much of my stuff as possible from iCUE to AHK. Text programming is always better than GUI programming (like iCUE).
*/

global master_volume

$Numpad0::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
  ;This disables the key, so it doesn't do anything.
  return
} else if (NumPadMode = "Normal") {
	Send, {Numpad0}
}
return

$NumpadIns::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
  ;This disables the key, so it doesn't do anything.
  return
} else if (NumPadMode = "Normal") {
	Send, {Numpad0}
}
return


$NumpadDot::
if (NumPadMode = "iTunes") {
	return
} else if (NumPadMode = "YouTube") {
	Send, c
} else {
	Send, {NumpadDot}
	return
}
return

$NumpadDel::
if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad1}
	return
}
return


$Numpad2::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
	SoundSet, -%Num2And8Step%
	return	
} else if (NumPadMode = "Normal") {
	Send, {Numpad2}
	return
}

$NumpadDown::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
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

*/





f(x)
{
return exp(6.908*x)/1000.0
}
inv(y)
{
return ln(1000.0*y)/6.908
}




NumpadAdd::
soundget, v
p:=inv(v/100.0)+0.02
nv:=f(p)*100.0
soundset, nv
return


NumpadEnter::
soundget, v
p:=inv(v/100.0)-0.02
nv:=f(p)*100.0
soundset, nv
return






$Numpad4::
if (NumPadMode = "YouTube") {
	Send, {Left}
	return
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
	Send, {Media_Next}
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad6}
	return
}
return

/*
$NumpadAdd::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
	SoundSet, +2
	return	
} else if (NumPadMode = "Normal") {
	Send, {+}
	return
}
return
*/

$Numpad7::
if (NumPadMode = "YouTube") {
	Send, j
	return
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad7}
	return
}
return


$Numpad8::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
	SoundSet, +%Num2And8Step%
	return	
} else if (NumPadMode = "Normal") {
	Send, {Numpad8}
	return
}
return

$NumpadUp::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
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
} else if (NumPadMode = "iTunes") {
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
} else if (NumPadMode = "iTunes") {
	return
} else if (NumPadMode = "Normal") {
	Send, {Numpad9}
	return
}
return


$NumpadDiv::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
	SoundSet, -1
	return	
} else if (NumPadMode = "Normal") {
	Send, {NumpadDiv}
	return
}
return

$NumpadMult::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
	SoundSet, +1
	return	
} else if (NumPadMode = "Normal") {
	Send, {NumpadMult}
	return
}
return

;Shows the current and exact master volume.
$NumpadSub::
if (NumPadMode = "iTunes" or NumPadMode = "YouTube") {
	SoundGet, master_volume
	master_volume := Round(master_volume, 2)
	MsgBox, 0, Master Volume, Master volume is %master_volume% percent., 0.39
} else if (NumPadMode = "Normal") {
	Send, {NumpadSub}
	return
}
return

;Gets the aforementioned master volume, displays it, and allows the user to input their own exact and custom volume.
^NumpadSub::
SoundGet, master_volume
InputBox, master_volume , Input Custom Volume, Input a custom volume. Current volume: %master_volume%., , , , , , , , %master_volume%
SoundSet, %master_volume%
return

!NumpadSub::
InputBox, Num2And8Step, Input Num2 and Num8 step value, Input Num2 and Num8 step value. Current value: %Num2And8Step%., , , , , , , , %Num2And8Step%
return