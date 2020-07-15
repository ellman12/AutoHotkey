;Tippy is such a useful function I made it its own file that can be #Included in other files.
;It's literally like a C Header File.

;Used for making the use of ToolTips a lot simpler and easier.
Tippy(Text, Duration) {
	ToolTip, %Text%
	Sleep %Duration%
	ToolTip ;Remove the ToolTip.
}