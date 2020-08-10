#NoEnv
Centered := False ; initial value = False / not centered
BtnW := 200 ; fixed button width
BtnH := 30  ; fixed button height
Random, GuiW, 300, 800  ; rendom GUI width
Random, GuiH, 100, 400  ; random GUI height
Gui, Add, Button, w%BtnW% h%BtnH% vCenteredBtn, Centered Button
Gui, Show, w%GuiW% h%GuiH%, Centered Button
Return

GuiClose:
ExitApp

GuiSize:
   If (Centered = False) { ; the button hasn't been centered as yet
      ; Calculate the horizontally centered X-position
      BtnX := (A_GuiWidth - BtnW) // 2
      ; Calculate the vertically centered Y-position
      BtnY := (A_GuiHeight - BtnH) // 2
      ; Center the button
      GuiControl, Move, CenteredBtn, x%BtnX% y%BtnY%
      ; Mark as centered
      Centered := True
   }
Return