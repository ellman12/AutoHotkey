;Extremely useful groups of hotkeys that make the historically and typically useless NumPad control music, YouTube, and more depending on what's active at the moment. Can also be overridden by the user if they want.
;Created: IDK. Improved: Friday, September 25, 2020.

;Allows the user to save the current volume level, and then return to it later.
;A good use case for this is if you need to greatly increase the volume to hear something in another application,
; and don't want to accidentally blow your ears out when resuming playback of your music or something else.
^NumPadSub::
global SavedNumMinusVol
SoundGet, SavedNumMinusVol
message := "Volume level of " . Round(SavedNumMinusVol, 2) . " has been saved!"
Tippy(message, 1400)
return

;Change the step value of NumPad 2 and NumPad 8.
!NumPadSub::InputBox, Num2And8Step, Input Num2 and Num8 step value, Input Num2 and Num8 step value. Current value: %Num2And8Step%., , , , , , , , %Num2And8Step%

^Pause:: ;autoNumPadModeToggle hotkey. Technically ^NumLock. https://www.autohotkey.com/docs/KeyList.htm#numpad
autoNumPadModeToggle := !autoNumPadModeToggle
if (autoNumPadModeToggle = "1")
	Tippy("NumPad mode will be set automatically.", 2000)
else
	Tippy("NumPad is controlled by you now.", 2000)
return

;If NumLock is On and ScrollLock is Off. This mode makes listening to music much easier and thus much more enjoyable.
#If numPadMode = "MusicBee" and !(getKeyState("F24", "P"))
{

$Numpad0::return
$NumpadIns::return

$NumpadDot::return
$NumpadDel::return

$Numpad1::return
$NumpadEnd::return

;Turns the volume down according to the "Num2And8Step" variable.
$Numpad2::SoundSet, -%Num2And8Step%
$NumpadDown::SoundSet, -%Num2And8Step%

$Numpad3::return
$NumpadPgdn::return

$NumpadAdd::changeVolume(1)
$NumpadEnter::changeVolume(-1)

$Numpad4::Send, {Media_Prev}
$NumpadLeft::Send, {Media_Prev}

$Numpad5::Send, {Media_Play_Pause}
$NumpadClear::Send, {Media_Play_Pause}

$Numpad6::Send, {Media_Next}
$NumpadRight::Send, {Media_Next}

$Numpad7::return
$NumpadHome::return

;Turns the volume up according to the "Num2And8Step" variable.
$Numpad8::SoundSet, +%Num2And8Step%
$NumpadUp::SoundSet, +%Num2And8Step%

$Numpad9::return
$NumpadPgup::return

$NumpadDiv::SoundSet, -1
$NumpadMult::SoundSet, +1

NumPadSub::restoreSavedVolume()
}

;If NumLock is On and ScrollLock is On.
#If numPadMode = "YouTube" and !(getKeyState("F24", "P"))
{
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

$NumpadAdd::changeVolume(1)
$NumpadEnter::changeVolume(-1)

;Backwards five seconds.
$Numpad4::Send, {Left}
$NumpadLeft::Send, {Left}

;Play/pause
$Numpad5::Send, k
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

$NumpadDiv::SoundSet, -1
$NumpadMult::SoundSet, +1

NumPadSub::restoreSavedVolume()
}

;If NumLock is Off and ScrollLock is On/Off. All keys in "Normal" mode behave like they normally would.
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

;If NumLock is Off and ScrollLock is On.
;Designed for use with video sites that aren't YouTube and that have worse interfaces than YT, as well as less useful shortcuts like j, k, l, etc.
;Those have been transformed into ones that should work with most lower-budget and lower-quality video players.
#If numPadMode = "Dumbed-Down" and !(getKeyState("F24", "P"))
{
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

;Send f to make the video full screen
$Numpad3::Send, f
$NumpadPgdn::Send, f

$NumpadAdd::changeVolume(1)
$NumpadEnter::changeVolume(-1)

;Backwards five (usually) seconds.
$Numpad4::Send, {Left}
$NumpadLeft::Send, {Left}

;Play/pause
$Numpad5::Send, {Space}
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

$NumpadDiv::SoundSet, -1
$NumpadMult::SoundSet, +1

NumPadSub::restoreSavedVolume()
}
#If

;Log volume scaling stuff: https://www.autohotkey.com/boards/viewtopic.php?t=38738
changeVolume(ud) { ;Called by NumPadAdd and NumPadEnter.
	fullVolumeTippy()
	static p := 20
	SoundGet, vol
	SoundSet, % vol * (1 + ud * p / 100)
}

;Used for NumPadSub. Checks to see if SavedNumMinusVol is 0 or NULL. If so, it won't "restore" it.
restoreSavedVolume() {
	if ((SavedNumMinusVol = 0) OR (SavedNumMinusVol = NULL)) {
		MsgBox, 262160, Error. SavedNumMinusVol is either 0 or NULL., Please use ^NumPadSub to save a volume level first.
		return
	} else
		SoundSet, %SavedNumMinusVol% ;Restore the saved volume level from ^NumPadSub.
}

fullVolumeTippy() {
	SoundGet, systemMasterVolume
	if (systemMasterVolume = 100) {
		Tippy("The master volume is at 100%!", 1000)
		return
	}
}