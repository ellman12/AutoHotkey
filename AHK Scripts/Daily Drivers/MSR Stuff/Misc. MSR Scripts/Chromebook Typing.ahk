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
	Tippy("Chromebook Typing is ENABLED", 400)
} else if (chromebookTypingToggle = "0") {
	Tippy("Chromebook Typing is DISABLED", 400)
}
return


;Keys that move the mouse pointer when the variable is set to true (1)
#If chromebookTypingToggle = "1"

~a::
chromebookTyping()
return

~b::
chromebookTyping()
return

~c::
chromebookTyping()
return

~d::
chromebookTyping()
return

~e::
chromebookTyping()
return

~f::
chromebookTyping()
return

~g::
chromebookTyping()
return

~h::
chromebookTyping()
return

~i::
chromebookTyping()
return

~j::
chromebookTyping()
return

~k::
chromebookTyping()
return

~l::
chromebookTyping()
return

~m::
chromebookTyping()
return

~n::
chromebookTyping()
return

~o::
chromebookTyping()
return

~p::
chromebookTyping()
return

~q::
chromebookTyping()
return

~r::
chromebookTyping()
return

~s::
chromebookTyping()
return

~t::
chromebookTyping()
return

~u::
chromebookTyping()
return

~v::
chromebookTyping()
return

~w::
chromebookTyping()
return

~x::
chromebookTyping()
return

~y::
chromebookTyping()
return

~z::
chromebookTyping()
return

~Space::
chromebookTyping()
return

~BackSpace::
chromebookTyping()
return

~Delete::
chromebookTyping()
return

~Enter::
chromebookTyping()
return

#If

;Function called when Chromebook Typing is on. Monitor pointer is moved to depends on the setting in the Control Panel.
chromebookTyping() {
	
	;Forgot this stupid thing and wasted so much time trying to figure out why it wasn't working.
	;I hate this global thing so much...
	global

	if (ChrBookTypeMonChoice = "1 (Primary Mon)") {
		MouseMove, 1920, 540, 0
	} else if (ChrBookTypeMonChoice = "2 (Secondary Mon)") {
		MouseMove, -1920, 540, 0
	} else {
		MsgBox Chromebook Typing error
	}

	
}