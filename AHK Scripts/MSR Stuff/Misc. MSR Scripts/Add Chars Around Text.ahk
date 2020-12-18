^SC028::addCharAroundText("""") ;^' Add double quotes around selected text.
^+SC028::addCharAroundText("'") ;^+' Add single quotes around selected text.

;Add brackets around selected text.
^+<::
^+>::addCharAroundText("<", ">")

;Add () around selected text.
^+(::
^+)::addCharAroundText("(", ")")

addCharAroundText(character, optional2ndChar := "") ;optional2ndChar is only used for things like <> or (), where there are 2 different characters, instead of something like "", which doesn't require the parameter.
{
	originalClipboard := ClipboardAll ;Restore this later.

	Send, ^c
	ClipWait, 2 ;Wait 2 seconds.

	Send, %character%
	Sleep 100
	Send, ^v
	Sleep 100

	if (optional2ndChar != "") ;Determine if there's another character to the pair to add to the end, like for (), <>, etc.
		Send, %optional2ndChar%
	else
		Send, %character%

	Clipboard := originalClipboard ;Restore.
	originalClipboard := "" ;Free because could potentially be huge.
}