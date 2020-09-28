;Used for making the use of ToolTips a lot simpler and easier.
Tippy(Message, Delay) {
	ToolTip, %Message%
	SetTimer, removeToolTip, %Delay%
}

removeToolTip:
ToolTip
return