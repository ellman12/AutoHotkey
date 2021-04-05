;For use with the Citra 3DS emulator. Assign the 4 D-pad buttons an X and Y coordinate to move to and click.
;Created Monday, April 5, 2021
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

global UP_X :=
global UP_Y :=
global DOWN_X :=
global DOWN_Y :=
global LEFT_X :=
global LEFT_Y :=
global RIGHT_X :=
global RIGHT_Y :=

; global dpadToggled = 1

; #If dpadToggled = 1
Up::moveAndClick(UP_X, UP_Y)
Down::moveAndClick(DOWN_X, DOWN_Y)
Left::moveAndClick(LEFT_X, LEFT_Y)
Right::moveAndClick(RIGHT_X, RIGHT_Y)
; #If

moveAndClick(x, y)
{
    MouseMove, x, y, 0
}