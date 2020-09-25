/*
Vista Audio control functions for managing the volumes of individual apps
Get the latest version at Github
https://gist.github.com/dlee13/9ac1e17afbf53e4981ae8dba6d59fcce

Thanks to Lexikos for his VA Library
https://autohotkey.com/board/topic/21984-vista-audio-control-functions/
Thanks to GeekDude for his ISimpleAudioVolume functions
https://www.autohotkey.com/boards/viewtopic.php?t=35241
*/

; Convert string to binary GUID structure
VA_GUID(ByRef guid_out, guid_in := "%guid_out%") {
	if (guid_in == "%guid_out%")
		guid_in := guid_out
	if guid_in is Integer
		return guid_in
	VarSetCapacity(guid_out, 16, 0)
	DllCall("ole32\CLSIDFromString", "WStr", guid_in, "Ptr", &guid_out)
	return &guid_out
}

; Returns a reference to an ISimpleAudioVolume object created from the PID or name you provide
VA_GetAudioSession(AppID := 0)
{
	static CLSID_MMDeviceEnumerator := "{BCDE0395-E52F-467C-8E3D-C4579291692E}"
		, IID_IMMDeviceEnumerator := "{A95664D2-9614-4F35-A746-DE8DB63617E6}"
		, IID_IASM2 := "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"
		, IID_IASC2 := "{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}"
		, IID_ISAV := "{87CE5498-68D6-44E5-9215-6DA47EF883D8}"
	
	; Get PID from app name
	if AppID is not Integer
	{
		if (InStr(AppID, ".exe", false, 0)) {
			Process, Exist, % AppID
			AppID := ErrorLevel
		} else {
			WinGet, AppID, PID, % AppID
		}
	}
	
	; GetDefaultAudioEndpoint
	deviceEnumerator := ComObjCreate(CLSID_MMDeviceEnumerator, IID_IMMDeviceEnumerator)
	DllCall(NumGet(NumGet(deviceEnumerator+0)+32), "Ptr", deviceEnumerator, "Int", 0, "Int", 0, "Ptr*", DAE)
	ObjRelease(deviceEnumerator)
	
	; Activate the session manager
	DllCall(NumGet(NumGet(DAE+0)+24), "Ptr", DAE, "Ptr", VA_GUID(IID_IASM2), "UInt", 0, "UInt", 0, "Ptr*", IASM2)
	
	; Enumerate sessions for this device
	DllCall(NumGet(NumGet(IASM2+0)+40), "Ptr", IASM2, "Ptr*", IASE)
	DllCall(NumGet(NumGet(IASE+0)+24), "Ptr", IASE, "Int*", Count)
	
	; Search for an audio session with the required name
	Loop, % Count
	{
		; Get the IAudioSessionControl object
		DllCall(NumGet(NumGet(IASE+0)+32), "Ptr", IASE, "Int", A_Index-1, "Ptr*", IASC)
		
		; Query the IAudioSessionControl for an IAudioSessionControl2 object
		IASC2 := ComObjQuery(IASC, IID_IASC2)
		ObjRelease(IASC)
		
		; Get the session's process ID
		DllCall(NumGet(NumGet(IASC2+0)+112), "Ptr", IASC2, "UInt*", SPID)
		
		; If the process name is the one we are looking for
		if (SPID == AppID) {
			; Query for the ISimpleAudioVolume
			ISAV := ComObjQuery(IASC2, IID_ISAV)
			ObjRelease(IASC2)
			break
		}
		ObjRelease(IASC2)
	}
	ObjRelease(IASE)
	ObjRelease(IASM2)
	ObjRelease(DAE)
	return ISAV
}

; Release the ISimpleAudioVolume object you created earlier
VA_ReleaseAudioSession(AudioSession)
{
	ObjRelease(AudioSession)
}

; Get the volume level of an audio session
VA_GetAppVolume(AudioSession)
{
	DllCall(NumGet(NumGet(AudioSession+0)+32), "Ptr", AudioSession, "Float*", fLevel)
	return fLevel*100
}

; Set the volume level of an audio session
VA_SetAppVolume(AudioSession, fLevel)
{
	fLevel := ((fLevel > 100) ? 100 : ((fLevel < 0) ? 0 : fLevel))/100
	DllCall(NumGet(NumGet(AudioSession+0)+24), "Ptr", AudioSession, "Float", fLevel, "Ptr", VA_GUID(""))
}

; Get the muting state of an audio session
VA_GetAppMute(AudioSession)
{
	DllCall(NumGet(NumGet(AudioSession+0)+48), "Ptr", AudioSession, "Int*", Muted)
	return Muted
}

; Set the muting state of an audio session
VA_SetAppMute(AudioSession, Muted)
{
	DllCall(NumGet(NumGet(AudioSession+0)+40), "Ptr", AudioSession, "Int", Muted, "Ptr", VA_GUID(""))
}
