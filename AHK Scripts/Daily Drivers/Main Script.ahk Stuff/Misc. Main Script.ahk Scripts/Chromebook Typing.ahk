#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
SendMode, Input

/*
;Chromebook Typing.
;If you've never typed on a Chromebook before, basically, it hides the mouse pointer when you start typing.
;Sometimes that's helpful, most of the time it's annoying.
;I had a shower thought one day, and this is what I came up with. I knew I had to try this.
;It seems to work pretty well.
;Essentially, when the chromebookTypingToggle variable is set to true, when you type a letter A-Z, Delete, Backspace, etc., it moves the mouse to the
;2nd display, thus getting the annoying pointer out of the way.
*/

chromebookTypingToggle := false


;Toggle the variable, and inform the user of the mode they're in.
^+Insert::
chromebookTypingToggle := !chromebookTypingToggle

if (chromebookTypingToggle = "1") {
	MsgBox, 64, Chromebook Typing is ENABLED, Chromebook Typing is ENABLED, 0.3
} else if (chromebookTypingToggle = "0") {
	MsgBox, 64, Chromebook Typing is DISABLED, Chromebook Typing is DISABLED, 0.3
} else {
	MsgBox, 16, You shouldn't be seeing this., This is an else statement error MsgBox for Chromebook Typing. If you see this`, it's probably an error or something lol.
}

return


;Keys that move the mouse pointer when the variable is set to true (1)
#If chromebookTypingToggle = "1"

$a::
MouseMove, -1920, 540, 0
SendInput, a
return

$b::
MouseMove, -1920, 540, 0
SendInput, b
return

$c::
MouseMove, -1920, 540, 0
SendInput, c
return

$d::
MouseMove, -1920, 540, 0
SendInput, d
return

$e::
MouseMove, -1920, 540, 0
SendInput, e
return

$f::
MouseMove, -1920, 540, 0
SendInput, f
return

$g::
MouseMove, -1920, 540, 0
SendInput, g
return

$h::
MouseMove, -1920, 540, 0
SendInput, h
return

$i::
MouseMove, -1920, 540, 0
SendInput, i
return

$j::
MouseMove, -1920, 540, 0
SendInput, j
return

$k::
MouseMove, -1920, 540, 0
SendInput, k
return

$l::
MouseMove, -1920, 540, 0
SendInput, l
return

$m::
MouseMove, -1920, 540, 0
SendInput, m
return

$n::
MouseMove, -1920, 540, 0
SendInput, n
return

$o::
MouseMove, -1920, 540, 0
SendInput, o
return

$p::
MouseMove, -1920, 540, 0
SendInput, p
return

$q::
MouseMove, -1920, 540, 0
SendInput, q
return

$r::
MouseMove, -1920, 540, 0
SendInput, r
return

$s::
MouseMove, -1920, 540, 0
SendInput, s
return

$t::
MouseMove, -1920, 540, 0
SendInput, t
return

$u::
MouseMove, -1920, 540, 0
SendInput, u
return

$v::
MouseMove, -1920, 540, 0
SendInput, v
return

$w::
MouseMove, -1920, 540, 0
SendInput, w
return

$x::
MouseMove, -1920, 540, 0
SendInput, x
return

$y::
MouseMove, -1920, 540, 0
SendInput, y
return

$z::
MouseMove, -1920, 540, 0
SendInput, z
return

$Space::
MouseMove, -1920, 540, 0
SendInput, {Space}
return

$BackSpace::
MouseMove, -1920, 540, 0
SendInput, {BackSpace}
return

$Delete::
MouseMove, -1920, 540, 0
SendInput, {Delete}
return

$Enter::
MouseMove, -1920, 540, 0
SendInput, {Enter}
return

#If