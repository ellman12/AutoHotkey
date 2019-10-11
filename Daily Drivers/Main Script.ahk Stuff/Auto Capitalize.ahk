#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force


;This is some stuff I found on the AHK Forums.
;It sometimes works.
;It's an Auto Capitalize thing.

;--------------------PERIOD
:*c?:. a::. A
:*c?:. b::. B
:*c?:. c::. C
:*c?:. d::. D
:*c?:. e::. E
:*c?:. f::. F
:*c?:. g::. G
:*c?:. h::. H
:*c?:. i::. I
:*c?:. j::. J
:*c?:. k::. K
:*c?:. l::. L
:*c?:. m::. M
:*c?:. n::. N
:*c?:. o::. O
:*c?:. p::. P
:*c?:. q::. Q
:*c?:. r::. R
:*c?:. s::. S
:*c?:. t::. T
:*c?:. u::. U
:*c?:. v::. V
:*c?:. w::. W
:*c?:. x::. X
:*c?:. y::. Y
:*c?:. z::. Z
;--------------------QUESTION MARK
:*c?:? a::? A
:*c?:? b::? B
:*c?:? c::? C
:*c?:? d::? D
:*c?:? e::? E
:*c?:? f::? F
:*c?:? g::? G
:*c?:? h::? H
:*c?:? i::? I
:*c?:? j::? J
:*c?:? k::? K
:*c?:? l::? L
:*c?:? m::? M
:*c?:? n::? N
:*c?:? o::? O
:*c?:? p::? P
:*c?:? q::? Q
:*c?:? r::? R
:*c?:? s::? S
:*c?:? t::? T
:*c?:? u::? U
:*c?:? v::? V
:*c?:? w::? W
:*c?:? x::? X
:*c?:? y::? Y
:*c?:? z::? Z
;--------------------EXCLAM
:*c?:! a::! A
:*c?:! b::! B
:*c?:! c::! C
:*c?:! d::! D
:*c?:! e::! E
:*c?:! f::! F
:*c?:! g::! G
:*c?:! h::! H
:*c?:! i::! I
:*c?:! j::! J
:*c?:! k::! K
:*c?:! l::! L
:*c?:! m::! M
:*c?:! n::! N
:*c?:! o::! O
:*c?:! p::! P
:*c?:! q::! Q
:*c?:! r::! R
:*c?:! s::! S
:*c?:! t::! T
:*c?:! u::! U
:*c?:! v::! V
:*c?:! w::! W
:*c?:! x::! X
:*c?:! y::! Y
:*c?:! z::! Z
;------------------------------------------------------------------------------


#SingleInstance force
#NoEnv
Process Priority,,High
SetBatchLines -1

Loop {
   Input key, I L1 V,
(  Join
{ScrollLock}{CapsLock}{NumLock}{Esc}{BS}{PrintScreen}{Pause}{LControl}{RControl}
{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}
{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}
)
   If StrLen(ErrorLevel) > 3  ; NewInput, EndKey
      state =
   Else If InStr(".!?",key)   ; Sentence end
      state = 1
   Else If InStr("`t `n",key) ; White space
      state += (state = 1)    ; state1 -> state2
   Else {
      StringUpper key, key
      If state = 2            ; End-Space*-Letter
         Send {BS}{%key%}     ; Letter -> Upper case
      state =
   }
}

~LButton::
~RButton::
~MButton::
~WheelDown::
~WheelUp::
~XButton1::
~XButton2::State =