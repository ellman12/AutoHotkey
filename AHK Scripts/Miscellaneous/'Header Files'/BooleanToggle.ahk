;Pass in a boolean toggle, and it gets togled to its opposite state. Also has two custom Tippy messages for true/false.
#Include, C:\Users\%A_UserName%\Documents\GitHub\AutoHotkey\AHK Scripts\Miscellaneous\'Header Files'\Tippy.ahk

BooleanToggle(ByRef Boolean, TippyMsgTrue, TippyMsgFalse) {
    Boolean := !Boolean

    if (Boolean = true)
        Tippy(TippyMsgTrue, 400)
    else
        Tippy(TippyMsgFalse, 400)

    return Boolean
}