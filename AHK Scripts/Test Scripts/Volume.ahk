#NoEnv
SetBatchLines, -1
#MaxHotkeysPerInterval 200
#Include C:\Users\Elliott\Documents\GitHub\AutoHotkey\AHK Scripts\Test Scripts\VA.ahk

; Create the slider window
Gui, Add, Progress, w100 h20 x0 y0 Range0-100 vVolSlider, 0
Gui, Add, Text, w100 h20 x0 y0 vVolText BackgroundTrans Center +0x200, 0
Gui, +AlwaysOnTop -Caption +ToolWindow
Gui, Show, Hide w100 h20 x0 y0, Volume
return

; --- Volume Keybinds ---

*Volume_Up::
*Volume_Down::
; Calculate step size
amount := GetKeyState("Ctrl", "P") ? 100 : GetKeyState("Alt", "P") ? 10 : 2
if (A_ThisHotkey == "*Volume_Down")
	amount *= -1

; Adjust volume of the appropriate target
if GetKeyState("LWin", "P")
{
	WinGet, ProcessName, ProcessName, A
	AppVolume(ProcessName).AdjustVolume(amount)
}
else
	VA_SetMasterVolume(VA_GetMasterVolume() + amount)

SetTimer, UpdateSlider, -0 ; Asynchronous function call
return

*x::
; Mute the appropriate target
if GetKeyState("LWin", "P")
{
	WinGet, ProcessName, ProcessName, A
	AppVolume(ProcessName).ToggleMute()
}
else
	VA_SetMasterMute(!VA_GetMasterMute())

SetTimer, UpdateSlider, -0 ; Asynchronous function call
return


; --- Slider Window Functions ---

UpdateSlider()
{
	if GetKeyState("LWin", "P")
	{
		; Application volume level
		WinGet, ProcessName, ProcessName, A
		AV := AppVolume(ProcessName)
		Volume := Round(AV.GetVolume())
		Mute := AV.GetMute() ? " X" : ""
		GetWindowRect(WinExist("A"), x1, y1, x2, y2)
		y := y1, x := x2 - 100
	}
	else
	{
		; Global volume level
		Volume := Round(VA_GetMasterVolume())
		Mute := VA_GetMasterMute() ? " X" : ""
		x := 0, y := 0
	}

	; Update and show the window
	GuiControl,, VolSlider, %Volume%
	GuiControl,, VolText, %Volume%%Mute%
	Gui, Show, NoActivate x%x% y%y%

	; Dismiss after a while
	SetTimer, ClearTip, -2000
}

ClearTip()
{
	Gui, Show, Hide
}

; W10 compatible function to find a window's visible boundaries
GetWindowRect(hWnd, ByRef x1, ByRef y1, ByRef x2, ByRef y2)
{
	size := VarSetCapacity(rect, 16, 0)
	error := DllCall("dwmapi\DwmGetWindowAttribute"
	, "UPtr", hWnd  ; HWND  hwnd
	, "UInt", 9     ; DWORD dwAttribute (DWMWA_EXTENDED_FRAME_BOUNDS)
	, "UPtr", &rect ; PVOID pvAttribute
	, "UInt", size  ; DWORD cbAttribute
	, "UInt")       ; HRESULT
	if (error)
		DllCall("GetWindowRect", "UPtr", WinExist("A"), "UPtr", &rect, "UInt")

	x1 := NumGet(rect, 0, "Int"), y1 := NumGet(rect, 4, "Int")
	x2 := NumGet(rect, 8, "Int"), y2 := NumGet(rect, 12, "Int")
}


; --- AppVolume Library ---

AppVolume(app:="", device:="")
{
	return new AppVolume(app, device)
}

class AppVolume
{
	ISAVs := []

	__New(app:="", device:="")
	{
		static IID_IASM2 := "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"
		, IID_IASC2 := "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}"
		, IID_ISAV := "{87CE5498-68D6-44E5-9215-6DA47EF883D8}"

		; Activate the session manager of the given device
		pIMMD := VA_GetDevice(device)
		VA_IMMDevice_Activate(pIMMD, IID_IASM2, 0, 0, pIASM2)
		ObjRelease(pIMMD)

		; Enumerate sessions for on this device
		VA_IAudioSessionManager2_GetSessionEnumerator(pIASM2, pIASE)
		ObjRelease(pIASM2)

		; Search for audio sessions with a matching process ID or Name
		VA_IAudioSessionEnumerator_GetCount(pIASE, Count)
		Loop, % Count
		{
			; Get this session's IAudioSessionControl2 via its IAudioSessionControl
			VA_IAudioSessionEnumerator_GetSession(pIASE, A_Index-1, pIASC)
			pIASC2 := ComObjQuery(pIASC, IID_IASC2)
			ObjRelease(pIASC)

			; If its PID matches save its ISimpleAudioVolume pointer
			VA_IAudioSessionControl2_GetProcessID(pIASC2, PID)
			if (PID == app || this.GetProcessName(PID) == app)
				this.ISAVs.Push(ComObjQuery(pIASC2, IID_ISAV))

			ObjRelease(pIASC2)
		}

		; Release the IAudioSessionEnumerator
		ObjRelease(pIASE)
	}

	__Delete()
	{
		for k, pISAV in this.ISAVs
			ObjRelease(pISAV)
	}

	AdjustVolume(Amount)
	{
		return this.SetVolume(this.GetVolume() + Amount)
	}

	GetVolume()
	{
		for k, pISAV in this.ISAVs
		{
			VA_ISimpleAudioVolume_GetMasterVolume(pISAV, fLevel)
			return fLevel * 100
		}
	}

	SetVolume(level)
	{
		level := level>100 ? 100 : level<0 ? 0 : level ; Limit to range 0-100
		for k, pISAV in this.ISAVs
			VA_ISimpleAudioVolume_SetMasterVolume(pISAV, level / 100)
		return level
	}

	GetMute()
	{
		for k, pISAV in this.ISAVs
		{
			VA_ISimpleAudioVolume_GetMute(pISAV, bMute)
			return bMute
		}
	}

	SetMute(bMute)
	{
		for k, pISAV in this.ISAVs
			VA_ISimpleAudioVolume_SetMute(pISAV, bMute)
		return bMute
	}

	ToggleMute()
	{
		return this.SetMute(!this.GetMute())
	}

	GetProcessName(PID) {
		hProcess := DllCall("OpenProcess"
		, "UInt", 0x1000 ; DWORD dwDesiredAccess (PROCESS_QUERY_LIMITED_INFORMATION)
		, "UInt", False  ; BOOL  bInheritHandle
		, "UInt", PID    ; DWORD dwProcessId
		, "UPtr")
		dwSize := VarSetCapacity(strExeName, 512 * A_IsUnicode, 0) // A_IsUnicode
		DllCall("QueryFullProcessImageName"
		, "UPtr", hProcess  ; HANDLE hProcess
		, "UInt", 0         ; DWORD  dwFlags
		, "Str", strExeName ; LPSTR  lpExeName
		, "UInt*", dwSize   ; PDWORD lpdwSize
		, "UInt")
		DllCall("CloseHandle", "UPtr", hProcess, "UInt")
		SplitPath, strExeName, strExeName
		return strExeName
	}
}


; --- Vista Audio Additions ---

;
; ISimpleAudioVolume : {87CE5498-68D6-44E5-9215-6DA47EF883D8}
;
VA_ISimpleAudioVolume_SetMasterVolume(this, ByRef fLevel, GuidEventContext="") {
	return DllCall(NumGet(NumGet(this+0)+3*A_PtrSize), "ptr", this, "float", fLevel, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMasterVolume(this, ByRef fLevel) {
	return DllCall(NumGet(NumGet(this+0)+4*A_PtrSize), "ptr", this, "float*", fLevel)
}
VA_ISimpleAudioVolume_SetMute(this, ByRef Muted, GuidEventContext="") {
	return DllCall(NumGet(NumGet(this+0)+5*A_PtrSize), "ptr", this, "int", Muted, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMute(this, ByRef Muted) {
	return DllCall(NumGet(NumGet(this+0)+6*A_PtrSize), "ptr", this, "int*", Muted)
}