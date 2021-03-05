#If, singleQuotesToggled = 1 AND matchPairsToggled = 1
$SC028::Send, ''{Left 1}

#If, doubleQuotesToggled = 1 AND matchPairsToggled = 1
$+SC028::Send, ""{Left 1}

#If, parenthesesToggled = 1 AND matchPairsToggled = 1
$+9::Send, (){Left 1}

#If, squareBracketsToggled = 1 AND matchPairsToggled = 1
$SC01A::Send, []{Left 1}

#If, curlyBracketsToggled = 1 AND matchPairsToggled = 1
$+SC01A::
Send, {Raw}{}
Send, {Left 1}
return

#If