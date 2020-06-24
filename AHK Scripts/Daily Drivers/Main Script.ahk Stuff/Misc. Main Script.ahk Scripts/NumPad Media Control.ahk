;This is the script that allows me to control media stuff with the NumPad.
;It has several modes, which all cause it to different things.

;PC's master volume.
global systemMasterVolume

;Log volume scaling stuff for NumpadAdd and NumpadEnter. IDK where I found this, nor do I understand/know how it works.
f(x) {
	return exp(6.908*x)/1000.0
}

inv(y) {
	return ln(1000.0*y)/6.908
}


;Gets the master volume, displays it, and allows the user to input their own exact and custom volume.
; NumpadSub::
; SoundGet, systemMasterVolume
; InputBox, systemMasterVolume , Input Custom Volume, Input a custom volume. Current volume: %systemMasterVolume%., , , , , , , , %systemMasterVolume%
; if ErrorLevel = 1 ;If the user presses Escape or CANCEL.
; 	MsgBox, ,CANCEL/Escape was pressed., CANCEL/Escape was pressed., 0.95
; else ;Else adjust set the volume to the inputted variable.
; 	SoundSet, %systemMasterVolume%
; return

;Change the step value of NumPad 2 and NumPad 8.
!NumpadSub::
InputBox, Num2And8Step, Input Num2 and Num8 step value, Input Num2 and Num8 step value. Current value: %Num2And8Step%., , , , , , , , %Num2And8Step%
return

;Toggles the autoNumPadModeToggle, and informs the user what mode they're in.
;According to the documentation https://www.autohotkey.com/docs/KeyList.htm...
;"While the Ctrl key is held down, the NumLock key produces the key code of Pause, so use ^Pause in hotkeys instead of ^NumLock."
;That explains why ^Numlock wasn't working; rather strange.
^Pause::

autoNumPadModeToggle := !autoNumPadModeToggle

	if (autoNumPadModeToggle = "1") {
		MsgBox, 0, autoNumPadModeToggle is ENABLED, autoNumPadModeToggle is ENABLED, 0.3
	} else if (autoNumPadModeToggle = "0") {
		MsgBox, 0, autoNumPadModeToggle is DISABLED, autoNumPadModeToggle is DISABLED, 0.3
	}

return

;If NumLock = On and ScrollLock = Off. The brackets are for condensing the code.
;This mode makes listening to music much easier and thus much more enjoyable.
#If numPadMode = "MusicBee" and !(getKeyState("F24", "P"))
{

;No function.
$Numpad0::return

$NumpadIns::return


;No function.
$NumpadDot::return

$NumpadDel::return


;No function.
$Numpad1::return

$NumpadEnd::return


;Turns the volume down according to the "Num2And8Step" variable.
$Numpad2::SoundSet, -%Num2And8Step%

$NumpadDown::SoundSet, -%Num2And8Step%


;No function.
$Numpad3::return

$NumpadPgdn::return


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
$Numpad4::Send, {Media_Prev}

$NumpadLeft::Send, {Media_Prev}


;Play/pause
$Numpad5::Send, {Media_Play_Pause}

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::Send, {Media_Play_Pause}


;Next track.
$Numpad6::Send, {Media_Next}

$NumpadRight::Send, {Media_Next}


;No function.
$Numpad7::return

$NumpadHome::return


;Turns the volume up according to the "Num2And8Step" variable.
$Numpad8::SoundSet, +%Num2And8Step%

$NumpadUp::SoundSet, +%Num2And8Step%


;No function.
$Numpad9::

$NumpadPgup::


;Lower volume by 1
$NumpadDiv::SoundSet, -1

;Raises volume by 1
$NumpadMult::SoundSet, +1


;Shows the current rounded master volume.
$NumPadSub::
SoundGet, systemMasterVolume
systemMasterVolume := Round(systemMasterVolume, 2)
MsgBox, 0, Master Volume, Master volume is %systemMasterVolume% percent., 0.39
return

}

;If NumLock = On and ScrollLock = On.
;This mode makes watching YouTube videos easier.
#If numPadMode = "YouTube" and !(getKeyState("F24", "P"))
{

;No function.
$Numpad0::return

$NumpadIns::return


;Toggle captions.
$NumpadDot::Send, c

$NumpadDel::Send, c


;Mute.
$Numpad1::Send, m

$NumpadEnd::Send, m


;Turns the volume down according to the "Num2And8Step" variable.
$Numpad2::SoundSet, -%Num2And8Step%

$NumpadDown::SoundSet, -%Num2And8Step%


;Send f to make the YouTube video full screen
$Numpad3::Send, f

$NumpadPgdn::Send, f


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
$Numpad4::Send, {Left}

$NumpadLeft::Send, {Left}


;Play/pause
$Numpad5::Send, k

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::Send, k


;Forward five seconds.
$Numpad6::Send, {Right}

$NumpadRight::Send, {Right}


;Backwards ten seconds.
$Numpad7::Send, j

$NumpadHome::Send, j


;Turns the volume up according to the "Num2And8Step" variable.
$Numpad8::SoundSet, +%Num2And8Step%

$NumpadUp::SoundSet, +%Num2And8Step%


;Forwards ten seconds.
$Numpad9::Send, l

$NumpadPgup::Send, l


;Lower volume by 1
$NumpadDiv::SoundSet, -1

;Raises volume by 1
$NumpadMult::SoundSet, +1


;Shows the current and exact master volume.
$NumPadSub::
SoundGet, systemMasterVolume
systemMasterVolume := Round(systemMasterVolume, 2)
MsgBox, 0, Master Volume, Master volume is %systemMasterVolume% percent., 0.39
return

}

;If NumLock = Off and ScrollLock = On/Off.
;All keys in "Normal" mode behave like they normally would.
;Hotkeys with one space between them are a pair.
;E.g., 0 and Ins are a pair, because 0 and Ins are on the same physical key.
;Two spaces separate each pair.
#If numPadMode = "Normal" and !(getKeyState("F24", "P"))
{

$Numpad0::Send, {Numpad0}

$NumpadIns::Send, {Numpad0}


$NumpadDot::Send, {NumpadDot}

$NumpadDel::Send, {NumpadDot}


$Numpad1::Send, {Numpad1}

$NumpadEnd::Send, {Numpad1}


$Numpad2::Send, {Numpad2}

$NumpadDown::Send, {Numpad2}


$Numpad3::Send, {Numpad3}

$NumpadPgdn::Send, {Numpad3}


$NumpadAdd::Send, {NumpadAdd}

$NumpadEnter::Send, {NumpadEnter}


$Numpad4::Send, {Numpad4}

$NumpadLeft::Send, {Numpad4}


$Numpad5::Send, {Numpad5}

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::Send, {Numpad5}


$Numpad6::Send, {Numpad6}

$NumpadRight::Send, {Numpad6}


$Numpad7::Send, {Numpad7}

$NumpadHome::Send, {Numpad7}


$Numpad8::Send, {Numpad8}

$NumpadUp::Send, {Numpad8}


$Numpad9::Send, {Numpad9}

$NumpadPgup::Send, {Numpad9}


$NumpadDiv::Send, {NumpadDiv}

$NumpadMult::Send, {NumpadMult}


$NumPadSub::Send, {NumpadSub}

}

;If NumLock = Off and ScrollLock = On. The brackets are for condensing the code.
;This mode makes watching videos easier on sites other than YouTube
; (and that don't have as many keyboard shortcuts like YouTube does).
;Examples are on online education websites like D2L Brightspace, websites for
;pirating movies, etc. These sites that have video players don't typically have video
; players that are all that great. Thus, this numPadMode was born.
;The reason it's called "Dumbed-Down" is because, well, it's a dumbed-down version
; of the YouTube numPadMode.
#If numPadMode = "Dumbed-Down" and !(getKeyState("F24", "P"))
{

;No function.
$Numpad0::return

$NumpadIns::return


;Toggle captions.
$NumpadDot::Send, c

$NumpadDel::Send, c


;Mute.
$Numpad1::Send, m

$NumpadEnd::Send, m


;Turns the volume down according to the "Num2And8Step" variable.
$Numpad2::SoundSet, -%Num2And8Step%

$NumpadDown::SoundSet, -%Num2And8Step%


;Send f to make the YouTube video full screen
$Numpad3::Send, f

$NumpadPgdn::Send, f


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
$Numpad4::Send, {Left}

$NumpadLeft::Send, {Left}


;Play/pause
$Numpad5::Send, {Space}

;This weird key goes with Numpad5.
;I never knew about this key until trying to figure out why Numpad5 wouldn't send "5" in Normal mode.
;It doesn't appear to have any function (at least in Windows 10).
$NumpadClear::Send, {Space}


;Forward five seconds.
$Numpad6::Send, {Right}

$NumpadRight::Send, {Right}


;Backwards ten seconds.
$Numpad7::Send, {Left 2}

$NumpadHome::Send, {Left 2}


;Turns the volume up according to the "Num2And8Step" variable.
$Numpad8::SoundSet, +%Num2And8Step%

$NumpadUp::SoundSet, +%Num2And8Step%


;Forwards ten seconds.
$Numpad9::Send, {Right 2}

$NumpadPgup::Send, {Right 2}


;Lower volume by 1
$NumpadDiv::SoundSet, -1

;Raises volume by 1
$NumpadMult::SoundSet, +1


;Shows the current and exact master volume.
$NumPadSub::
SoundGet, systemMasterVolume
systemMasterVolume := Round(systemMasterVolume, 2)
MsgBox, 0, Master Volume, Master volume is %systemMasterVolume% percent., 0.39
return

}
#If