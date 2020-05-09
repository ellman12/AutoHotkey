#NoEnv
#singleinstance force

CurrentMode := 0 ; 0 = Off, 1 = working, 2 = break

Gui, Add, Text, x2 w163 Center vModeTxt
Gui, Add, Button, x2 y42 w80 h20 gPause, Pause
Gui, Add, Button, x82 y42 w80 h20 gReset, Reset
Gui, Add, Text, x67 y22 w60 h20 BackgroundTrans E0x20 vTText
Gui, Add, Button, x2 y62 w163 h20 gStart Center, Start / Stop
Gui, Show, h89 w165, Flowtime
Gui -MinimizeBox
WinSet,AlwaysOnTop,On,Flowtime
SetMode(0)
return

SetMode(mode){
	global CurrentMode, ModeTxt, StartTime, EndPause
	GoSub, StopTimers

	if (mode == 0){
		; Off
		SetTime(0)
		GuiControl, , ModeTxt, Off
	} else if (mode == 1){
		; Work Mode
		SetTime(0)
		GuiControl, , ModeTxt, Time this session
		StartTime := A_TickCount
		Settimer, UpdateWorkTime, 1000
	} else {
		; Break Mode
		GuiControl, , ModeTxt, Time until end of break
		t := (A_TickCount - StartTime)*.4 ; length of break
		SetTime(t)
		EndPause := t + A_TickCount
		SetTimer, UpdatePauseTime, 1000
		SetTimer, BackToWork, % "-" t
	}
	CurrentMode := mode
}

Start:
	if (CurrentMode){
		SetMode(0)
	} else if (CurrentMode == 0){
		SetMode(1)
	}
	return

Pause:
	if (CurrentMode == 1){
		SetMode(2)
	}
	return

Reset:
	SetMode(1)
	return

UpdateWorkTime:
	SetTime(A_TickCount - StartTime)
	return

UpdatePauseTime:
	t := EndPause - A_TickCount
	SetTime(t)
	return

BackToWork:
    SoundBeep, 500, 1000
	msgbox BREAK OVER, BACK TO WORK, PEON!!
	SetMode(1)
	return

StopTimers:
	Settimer, UpdateWorkTime, Off
	SetTimer, UpdatePauseTime, Off
	SetTimer, BackToWork, Off
	return

MillisecToTime(msec) {
    secs := floor(mod((msec / 1000),60))
    mins := floor(mod((msec / (1000 * 60)), 60) )
    hour := floor(mod((msec / (1000 * 60 * 60)) , 24))
    return Format("{:02}:{:02}:{:02}",hour,mins,secs)
}

SetTime(t){
    global TText
    GuiControl, , TText ,  % MillisecToTime(t)
}

GuiClose:
GuiEscape:
ExitApp
return