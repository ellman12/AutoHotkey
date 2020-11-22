;Toggle between showing and hiding an AutoHotkey GUI window.
;toggleVar = the corresponding boolean.
;GUI_Name = the GUI name thing for differentiating all the different GUI windows.
;width = GUI window width.
;height = GUI window height.
;GUIWindowTitle = the actual title of the window.
toggleGUI(ByRef toggleVar, GUI_Name, width, height, GUIWindowTitle)
{
    toggleVar := !toggleVar
    if (toggleVar == 1)
        GUI, %GUI_Name%:Show, w%width% h%height%, %GUIWindowTitle%
    else
        GUI, %GUI_Name%:Hide
}