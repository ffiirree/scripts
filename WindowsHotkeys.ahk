;====================================================================o
;                                                                    ;
; Manage the virtual desktops.                                       ;
;                                                                    ;
;====================================================================o

^Left:: Send "^#{Left}"
^Right:: Send "^#{Right}"

DesktopStatus() {
    if (WinGetTitle("A") == "Task View") {
        return "TASKVIEW"
    }
    else if (WinGetTitle("A") == "Program Manager") {
        return "DESKTOP"
    }
    return "NORMAL"
}

; Gesture
RButton:: {
    MIN_DIS := 125

    MouseGetPos &x_s, &y_s
    KeyWait "RButton", "U"
    MouseGetPos &x_e, &y_e

    ; Right
    if ((x_s - x_e > MIN_DIS) && (Abs(y_s - y_e) < (MIN_DIS / 2))) {
        Send "^#{Right}"
    }
    ; Left
    else if ((x_e - x_s > MIN_DIS) && (Abs(y_s - y_e) < (MIN_DIS / 2))) {
        Send "^#{Left}"
    }
    ; Up
    else if (Abs(x_s - x_e) < (MIN_DIS / 2) && (y_s - y_e > MIN_DIS)) {
        status := DesktopStatus()

        ; DESKTOP -> NORMAL
        if (status = "DESKTOP") {
            Send "#d"
        }
        ; NORMAL -> TASKVIEW
        else if (status = "NORMAL") {
            Send "#{Tab}"
        }
    }
    ; Down
    else if (Abs(x_s - x_e) < (MIN_DIS / 2) && (y_e - y_s > MIN_DIS)) {
        status := DesktopStatus()

        ; TASKVIEW -> NORMAL
        if (status = "TASKVIEW") {
            Send "#{Tab}"
        }
        ; NORMAL -> DESKTOP
        else if (status = "NORMAL") {
            Send "#d"
        }
    }
    else {
        SendInput "{RButton}"
    }
}

;====================================================================o
;                                                                    ;
; Run windows terminal.                                              ;
;                                                                    ;
;====================================================================o
^!t:: Run "wt"

;====================================================================o
;                                                                    ;
; AltTab                                                             ;
;                                                                    ;
;====================================================================o
~LButton & RButton::AltTab

;====================================================================o
;                                                                    ;
; Volume                                                             ;
;                                                                    ;
;====================================================================o
#HotIf MouseIsOver("ahk_class Shell_TrayWnd") or MouseIsOver("ahk_class Shell_SecondaryTrayWnd")
~WheelUp::Volume_Up
~WheelDown::Volume_Down

MouseIsOver(Title) {
    MouseGetPos , , &Id
    return WinExist(Title " ahk_id " Id)
}
#HotIf

^Up::Volume_Up
^Down::Volume_Down

;====================================================================o
;                                                                    ;
; Google                                                             ;
;                                                                    ;
;====================================================================o
^g:: {
    A_Clipboard := ""
    Send "^c"
    ClipWait
    Run "https://www.google.com/search?q=" A_Clipboard
}

;====================================================================o
;                                                                    ;
; Set windows on top.                                                ;
;                                                                    ;
;====================================================================o
^Space:: WinSetAlwaysOnTop -1, "A"

;====================================================================o
;                                                                    ;
; Adobe Acrobat Pro DC:                                              ;
;     mouse forward: Alt + ->                                        ;
;     mouse back:    Alt + <-                                        ;
;====================================================================o
#HotIf "Acrobat.exe" = WinGetProcessName("A")
XButton1:: Send "!{Left}"
XButton2:: Send "!{Right}"
#HotIf