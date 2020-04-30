safeWindowTitles := []
safeWindowIDs := []

;******************GUI INITIALIZATION******************
;Make the GUI (and then make it AlwaysOnTop).
GUI, SafeWinsGUI:New
GUI, SafeWinsGUI:+AlwaysOnTop

GUI, SafeWinsGUI:Font, norm S12
GUI, SafeWinsGUI:Add, Text, x4 y4, Ctrl + F11: Add Windows

GUI, SafeWinsGUI:Font, norm S10
GUI, SafeWinsGUI:Add, Button, x4 y240 w190 gDeleteButton, Delete Selected Item

GUI, SafeWinsGUI:Font, norm S9           ;Display ↓ grid; ↓ can't move headers around (but can resize).
GUI, SafeWinsGUI:Add, ListView, x4 y34 w190 h200  LV0x1 -LV0x10, Title|ID

SafeWinsImageListID := IL_Create() ;Initially create an ImageList to store icons in. It grows automatically.
LV_SetImageList(SafeWinsImageListID) ;sets the image list for the ListView to use the ImageList created in the line above

;Set column widths.
LV_ModifyCol(1, 160) ;Title.
LV_ModifyCol(2, 30) ;ID.

GUI, SafeWinsGUI:Show, x1460 w200 h340, Safe Windows
return

;Adds windows to the Safe Windows arrays.
^F11::
    ;https://www.autohotkey.com/docs/commands/ListView.htm#BuiltIn
    GUI, SafeWinsGUI:Default

    ;Get the active title, ID, and the window icon.
    WinGetTitle, safeWinsActiveTitle, A
    WinGet, safeWinsActiveID, ID, A
    WInGet, activeWinProcPath, ProcessPath, A

    ;Boolean to track if the active title was found in the array.
    ;If it was, don't add it (duplicate it); if it wasn't, add it to the array.
    found := false

    ;Check if the title is already included in the array.
    ;There can (and probably will) be multiple window IDs. E.g., multiple titles (tabs), 1 ID for Firefox.
    for index, title in safeWindowTitles {
        ;If the current title was found inside the array
        if (title = safeWinsActiveTitle) {
            ;Then mark it as found and break the loop.
            found := true
            break
        }
    }

    ;If the title was never found in the array.
    if (found = false) {
        ;Add it to the array.
        safeWindowTitles.Push(safeWinsActiveTitle)

        ;Put the Icon of the program into the ImageList for use with the ListView.
        IL_Add(SafeWinsImageListID, activeWinProcPath)

        ;Add the Title and ID to the ListView, and add the Icon using the option "Icon1" "Icon2" etc.
        ;Icon number is defined by "LV_GetCount() + 1" which gets the number of rows in before adding and adds one.
        LV_Add("Icon" LV_GetCount() + 1, safeWinsActiveTitle, safeWinsActiveID, activeWinProcPath)
    }

return


DeleteButton:
	LV_GetText(text, LV_GetNext(), 1)
	MsgBox, 4, , % "Do you want to delete " . text
	IfMsgBox, Yes
		{
		DeleteIndex := LV_GetNext()
		LV_Delete(DeleteIndex)
		DllCall("ComCtl32.dll\ImageList_Remove", "Ptr", SafeWinsImageListID, "Int", DeleteIndex - 1, "UInt")    ; -1 because range of listview start from 1 but imagelist starts from 0
		
		;Because the ImageList has changed, we must reorder the icons attached to items in the ListView to match the new indexing of the ImageList.
		Loop % LV_GetCount()
			{
			LV_Modify(A_Index, "Icon" . A_Index)
			}
		}
return