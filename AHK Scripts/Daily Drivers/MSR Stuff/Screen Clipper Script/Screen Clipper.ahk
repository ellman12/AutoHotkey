;Where I found this script: https://www.youtube.com/watch?v=yohbs_IILxc&feature=em-uploademail

;Written By: Hellbent
;Date Started: Dec 6th, 2019
;Name: Screen Clipper.
;Inspired by the screen clipping tool by Joe Glines.

; ;User Defined Values
; ;************************************************
; Hotkey, #s , CreateCapWindow , On  ;<------------------    Adjust the hotkey value to suit your needs / wants
; ;************************************************
; SaveToFile := 1 		 		   		;<------------------    Set this to 1 to save all clips with a unique name , Set it to 0 to overwrite the saved clip every time a new clip is made.
; ;************************************************
; ShowCloseButton := 1 			   		;<------------------    Set this to 1 to show a small close button in the top right corner of the clip. Set this to 0 to keep the close button, but not show it.
; ;************************************************

#SingleInstance, Force  ; Force the script to close any other instances of this script. (Run one copy at a time)
SetBatchLines, -1 ;Set the script to run at top speed.
; CoordMode, Mouse , Screen ;Use the screen as the refrence to get positions from.

; IfNotExist, %A_ScriptDir%\Saved Clips ; if there is no folder for saved clips
; 	FileCreateDir, %A_ScriptDir%\Saved Clips ; create the folder.
; SetWorkingDir, %A_ScriptDir%\Saved Clips ;Set the saved clips folder as the working dir.
; Handles := [] ; Create an array to hold the name of the different gui's.
; Index := 0 ;Used as the name of the current gui cap window.
return   ; End of Auto-Execute Section.

;**************************************************************************************
;**************************************************************************************
; ^!ESC:: ExitApp ; Hotkey to exit the script.
; ^ESC::	Reload ; Hotkey to reload the script.
!#s::openOrShowClipsFolder()

openOrShowClipsFolder() { ;Opens/activates the folder containing the saved clips.
IfWinExist, Saved Clips
	WinActivate
else
	Run, explorer.exe %A_ScriptDir%\Screen Clipper Script\Saved Clips
}
;**************************************************************************************
;**************************************************************************************

CloseClip: ;Close (Destroy this gui)
	hwnd := WinActive() ;Get the handle to the active window
	Gui, % Handles[hwnd] ": Destroy"  ;Destroy the gui with the name stored in the Handles array at position hwnd.
	return

MoveWindow:
	PostMessage, 0xA1 , 2  ;Move the active window
	return

CreateCapWindow: ;Create a gui to used for setting the screen cap area and to display the resulting screen shot.
	Index++ ;Increment the current index. (the gui's name)
	Gui, %Index% : New , +AlwaysOnTop -Caption -DPIScale +ToolWindow +LastFound +Border hwndHwnd ;Create a new gui and set its options.
	Handles[hwnd] := Index  ;Use the windows handle (hwnd) as the index for the the value of the windows name.
	Gui, %Index% : Color , 123456 ;Set the color of the gui (This color will be made transparent in the next step)
	WinSet, TransColor , 123456 ;Set only this color as transparent
	Gui, %Index% : Font, cMaroon s10 Bold Q5 , Segoe UI ;Set this gui's font. (Used for the close button)
	Active := 1
	ToolTip, Click and drag to capture a screenshot. Click without dragging (or right click) to cancel. ;Display a tooltip that tells the user what to do.
	SetTimer, Tooltips , 30 ;Set a timer to move the tooltip around with the users cursor.
	return

Tooltips:
	ToolTip, Click and drag to capture a screenshot. Click without dragging (or right click) to cancel. ;Display a tooltip that tells the user what to do.
	return

DrawCapArea:
	if( !FirstPosition ){ ;If the first position hasn't been set yet.
		FirstPosition := 1 ;The first position is now set.
		MouseGetPos, SX , SY ;Get the x and y starting position.
	}else	{ ;After the first position is set.
		MouseGetPos, EX , EY ;Get the current position of the cursor.
		if( SX <= EX && SY <= EY )  ;If the current position is below and to the right of the starting position.
			WinPos := { X: SX , Y: SY , W: EX - SX , H: EY - SY } ;Create a object to hold the windows positions.
		else if( SX > EX && SY <= EY ) ;If the current position is below and to the left of the starting position.
			WinPos := { X: EX , Y: SY , W: SX - EX , H: EY - SY } ;Create a object to hold the windows positions.
		else if( SX <= EX && SY > EY) ;If the current position is above and to the right of the starting position.
			WinPos := { X: SX , Y: EY , W: EX - SX , H: SY - EY } ;Create a object to hold the windows positions.
		else if( SX > EX && SY > EY) ;If the current position is above and to the left of the starting position.
			WinPos := { X: EX , Y: EY , W: SX - EX , H: SY - EY } ;Create a object to hold the windows positions.
	}
	if( WinPos.W ) ;if the winpos object exists
		Gui, %Index% : Show , % "x" WinPos.X " y" WinPos.Y " w" WinPos.W " h" WinPos.H " NA" ;Show the window in the correct position.
	return

TakeScreenShot:
	pToken := Gdip_Startup() ;Start using Gdip
	ClipBitmap := Gdip_BitmapFromScreen( WinPos.X "|" WinPos.Y "|" WinPos.W "|" WinPos.H) ;Create a bitmap of the screen.
	Gdip_SaveBitmapToFile( ClipBitmap , A_WorkingDir "\" ( ( SaveToFile = 1 ) ? ( ClipName := "Saved Clip " A_Now ) : ( ClipName := "Temp Clip") ) ".png", 100 ) ; Save the bitmap to file
	Gdip_DisposeImage( ClipBitmap ) ;Dispose of the bitmap to free memory.
	Gdip_Shutdown(pToken) ;Turn off gdip
	return

#If (Active) ;Context sen Hotkeys.

LButton::
	WinPos := "" ;Clear this object.
	FirstPosition := 0 ;Variable used to determin if the starting point has been set yet.
	SetTimer, DrawCapArea , 30 ;Set a timer for drawing a rectangle around the capture area.
	return

LButton Up::
	Active := 0 ;Set context hotkeys off
	SetTimer, DrawCapArea , Off ;Turn off the drawing timer.
	SetTimer, Tooltips , Off ;Turn off the tooltips timer
	ToolTip, ;Turn off any tooltips.
	if( WinPos.W < 10 || WinPos.H < 10 ) { ; if the cap area width or height is less than 10px.
		Gui, %Index% : Destroy ;Destroy the gui
		return ; Skip taking a screen clip.
	}
	Gui, %Index% : -Border ;Remove the border before taking the screen clip
	gosub, TakeScreenShot ;Take a screen shot of the cap area.
	Gui, %Index% : +Border ;Add the border again.

	Gui, %Index% : Add , Text , % ( ( ShowCloseButton ) ? ( " Center 0x200 Border " ) : ( "" ) ) " x" WinPos.W - 20 " y0 w20 h20 BackgroundTrans gCloseClip" , % ( ( ShowCloseButton ) ? ( "X" ) : ( "" ) ) ;Create a trigger used for closing this window.
	Gui, %Index% : Add , Text , % "x0 y0 w" WinPos.W " h" WinPos.H " BackgroundTrans gMoveWindow" ;Create a trigger used for moving the window around.
	Gui, %Index% : Add , Picture , % "x0 y0 w" WinPos.W " h" WinPos.H ,% ClipName ".png"   ;Add the Screen clip image
	return

RButton::  ;If the right mouse button is pressed while selecting the screen clip area, Cancel the action and restore variables etc.
	Active := 0 ;Set context hotkeys off
	SetTimer, DrawCapArea , Off ;Turn off the drawing timer.
	SetTimer, Tooltips , Off ;Turn off the tooltips timer
	ToolTip, ;Turn off any tooltips.
	Gui, %Index% : Destroy ;Destroy the current gui
	return

#If

;******************************************************************************************************************************************
;******************************************************************************************************************************************
;***************************************************      GDIP Functions      *************************************************************
;******************************************************************************************************************************************
;******************************************************************************************************************************************
Gdip_Startup(){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}
Gdip_BitmapFromScreen(Screen=0, Raster=""){
	if (Screen = 0){
		Sysget, x, 76
		Sysget, y, 77
		Sysget, w, 78
		Sysget, h, 79
	}else if (SubStr(Screen, 1, 5) = "hwnd:"){
		Screen := SubStr(Screen, 6)
		if !WinExist( "ahk_id " Screen)
			return -2
		WinGetPos,,, w, h, ahk_id %Screen%
		x := y := 0
		hhdc := GetDCEx(Screen, 3)
	}else if (Screen&1 != ""){
		Sysget, M, Monitor, %Screen%
		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
	}else	{
		StringSplit, S, Screen, |
		x := S1, y := S2, w := S3, h := S4
	}
	if (x = "") || (y = "") || (w = "") || (h = "")
		return -1
	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
	ReleaseDC(hhdc)
	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
	return pBitmap
}
Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality=75){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	SplitPath, sOutput,,, Extension
	if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
		return -1
	Extension := "." Extension
	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", nCount, "uint*", nSize)
	VarSetCapacity(ci, nSize)
	DllCall("gdiplus\GdipGetImageEncoders", "uint", nCount, "uint", nSize, Ptr, &ci)
	if !(nCount && nSize)
		return -2
	If (A_IsUnicode){
		StrGet_Name := "StrGet"
		Loop, % nCount 	{
			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
			if !InStr(sString, "*" Extension)
				continue
			pCodec := &ci+idx
			break
		}
	} else {
		Loop, % nCount 	{
			Location := NumGet(ci, 76*(A_Index-1)+44)
			nSize := DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "uint", 0, "int",  0, "uint", 0, "uint", 0)
			VarSetCapacity(sString, nSize)
			DllCall("WideCharToMultiByte", "uint", 0, "uint", 0, "uint", Location, "int", -1, "str", sString, "int", nSize, "uint", 0, "uint", 0)
			if !InStr(sString, "*" Extension)
				continue
			pCodec := &ci+76*(A_Index-1)
			break
		}
	}
	if !pCodec
		return -3
	if (Quality != 75){
		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
		if Extension in .JPG,.JPEG,.JPE,.JFIF
		{
			DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, "uint*", nSize)
			VarSetCapacity(EncoderParameters, nSize, 0)
			DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, "uint", nSize, Ptr, &EncoderParameters)
			Loop, % NumGet(EncoderParameters, "UInt") 	{
				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6){
					p := elem+&EncoderParameters-pad-4
					NumPut(Quality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
					break
				}
			}
		}
	}
	if (!A_IsUnicode){
		nSize := DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, 0, "int", 0)
		VarSetCapacity(wOutput, nSize*2)
		DllCall("MultiByteToWideChar", "uint", 0, "uint", 0, Ptr, &sOutput, "int", -1, Ptr, &wOutput, "int", nSize)
		VarSetCapacity(wOutput, -1)
		if !VarSetCapacity(wOutput)
			return -4
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &wOutput, Ptr, pCodec, "uint", p ? p : 0)
	}
	else
		E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, Ptr, &sOutput, Ptr, pCodec, "uint", p ? p : 0)
	return E ? -5 : 0
}
Gdip_DisposeImage(pBitmap){
   return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
}
Gdip_Shutdown(pToken){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}
GetDCEx(hwnd, flags=0, hrgnClip=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
    return DllCall("GetDCEx", Ptr, hwnd, Ptr, hrgnClip, "int", flags)
}
CreateCompatibleDC(hdc=0){
   return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}
CreateDIBSection(w, h, hdc="", bpp=32, ByRef ppvBits=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	hdc2 := hdc ? hdc : GetDC()
	VarSetCapacity(bi, 40, 0)
	NumPut(w, bi, 4, "uint") , NumPut(h, bi, 8, "uint") , NumPut(40, bi, 0, "uint") , NumPut(1, bi, 12, "ushort") , NumPut(0, bi, 16, "uInt") , NumPut(bpp, bi, 14, "ushort")
	hbm := DllCall("CreateDIBSection" , Ptr, hdc2 , Ptr, &bi , "uint", 0 , A_PtrSize ? "UPtr*" : "uint*", ppvBits , Ptr, 0 , "uint", 0, Ptr)
	if !hdc
		ReleaseDC(hdc2)
	return hbm
}
SelectObject(hdc, hgdiobj){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("SelectObject", Ptr, hdc, Ptr, hgdiobj)
}
GetDC(hwnd=0){
	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
}
BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster=""){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("gdi32\BitBlt" , Ptr, dDC , "int", dx , "int", dy , "int", dw , "int", dh , Ptr, sDC , "int", sx , "int", sy , "uint", Raster ? Raster : 0x00CC0020)
}
ReleaseDC(hdc, hwnd=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	return DllCall("ReleaseDC", Ptr, hwnd, Ptr, hdc)
}
Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette=0){
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, A_PtrSize ? "UPtr*" : "uint*", pBitmap)
	return pBitmap
}
DeleteObject(hObject){
   return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
}
DeleteDC(hdc){
   return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
}