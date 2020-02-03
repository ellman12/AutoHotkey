ChangeCase(String,Type) { ;type is S,I,U,L, or T
If (Type="S") { ;Sentence case.
 X = I,AHK,AutoHotkey ;comma seperated list of words that should always be capitalized
 S := RegExReplace(RegExReplace(String, "(.*)", "$L{1}"), "(?<=[\.\!\?]\s|\n).|^.", "$U{0}")
 Loop Parse, X, `, ;Parse the exceptions
  S := RegExReplace(S,"i)\b" A_LoopField "\b", A_LoopField)
 Return S
}
If (Type="I") ;iNVERSE
 Return % RegExReplace(String, "([A-Z])|([a-z])", "$L1$U2")
Return % RegExReplace(String, "(.*)", "$" Type "{1}")
}

Data =
(
Ask For Help
ask Questions aND (hopEfully) Get ansWers. post helpful Tips and Tricks.
WHY? shout! tESt.
)

MsgBox % ChangeCase(Data,"I")
MsgBox % ChangeCase("This is a Test","I")
MsgBox % ChangeCase("This is a Test","U")
MsgBox % ChangeCase("This is a Test","L")
MsgBox % ChangeCase("This is a Test","T")

