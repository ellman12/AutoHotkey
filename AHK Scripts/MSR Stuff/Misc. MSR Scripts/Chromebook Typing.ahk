;If you've never typed on a Chromebook before, basically, it hides the mouse pointer when you start typing.
;Sometimes that's helpful, most of the time it's annoying.

chromebookTypingToggle := 0

;Toggle the variable, and inform the user of the mode they're in.
^+Insert::
chromebookTypingToggle := !chromebookTypingToggle

if (chromebookTypingToggle = 1)
	Tippy("Chromebook Typing is ENABLED", 400)
else if (chromebookTypingToggle = 0)
	Tippy("Chromebook Typing is DISABLED", 400)
return


;Keys that move the mouse pointer when the variable is set to true (1)
#If chromebookTypingToggle = 1
~a::chromebookTyping()
~b::chromebookTyping()
~c::chromebookTyping()
~d::chromebookTyping()
~e::chromebookTyping()
~f::chromebookTyping()
~g::chromebookTyping()
~h::chromebookTyping()
~i::chromebookTyping()
~j::chromebookTyping()
~k::chromebookTyping()
~l::chromebookTyping()
~m::chromebookTyping()
~n::chromebookTyping()
~o::chromebookTyping()
~p::chromebookTyping()
~q::chromebookTyping()
~r::chromebookTyping()
~s::chromebookTyping()
~t::chromebookTyping()
~u::chromebookTyping()
~v::chromebookTyping()
~w::chromebookTyping()
~x::chromebookTyping()
~y::chromebookTyping()
~z::chromebookTyping()
~Space::chromebookTyping()
~BackSpace::chromebookTyping()
~Delete::chromebookTyping()
~Enter::chromebookTyping()
#If

;Function called when Chromebook Typing is on. Monitor pointer is moved to depends on the setting in the Control Panel.
chromebookTyping() {
global
	if (ChrBookTypeMonChoice = "Primary Mon")
		MouseMove, 1920, 540, 0
	else if (ChrBookTypeMonChoice == "Secondary Mon")
		MouseMove, -1920, 540, 0
}