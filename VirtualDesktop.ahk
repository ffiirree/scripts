;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; log
global INFO := "INFO", DEBUG := "DEBUG", WARN := "WARN", ERROR := "ERROR", FATAL := "FATAL"
LOG(Level, Line, Str) {
    OutputDebug, %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%:%A_MSec% %Level% %A_ScriptName%:%Line%] %Str%
}

LOG_BLANK_LINE() {
    blank := ""
    OutputDebug, %blank%
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class VirtualDesktopManager
class VirtualDesktopManager {
    ; Get the current desktop UUID. Length should be 32 always, 
    ; but there's no guarantee this couldn't change in a later Windows release so we check.
    id_length := 32

    count := 1
    index := 1

    current_id := ""
    session_id := ""

    __REG_KEY_NAME_CURRENT_ID := ""
    __REG_KEY_NAME_ALL_IDS := "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops"

    __New() 
    {
        process_id := DllCall("GetCurrentProcessId", "UInt")
        if ErrorLevel {
            LOG(ERROR, A_LineNumber, Format("GetCurrentProcessId: {}", ErrorLevel))
            return
        }
        LOG(INFO, A_LineNumber, Format("Process id: {}", process_id))

        session_id := ""
        DllCall("ProcessIdToSessionId", "UInt", process_id, "UInt*", session_id)
        if ErrorLevel {
            LOG(ERROR, A_LineNumber, Format("ProcessIdToSessionId: {}", ErrorLevel))
            return
        }

        this.session_id := session_id
        LOG(INFO, A_LineNumber, Format("Session id: {}", this.session_id))

        this.__REG_KEY_NAME_CURRENT_ID := Format("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\{}\VirtualDesktops", this.session_id)
        this.current_id := this.__read_reg(this.__REG_KEY_NAME_CURRENT_ID, "CurrentVirtualDesktop")
        this.id_length := StrLen(this.current_id)
        LOG(INFO, A_LineNumber, Format("Length of virtual desktop id: {}", this.id_length))
    }

    update() 
    {
        ; current virtual desktop id
        this.current_id := this.__read_reg(this.__REG_KEY_NAME_CURRENT_ID, "CurrentVirtualDesktop")
        LOG(INFO, A_LineNumber, Format("Current virtual desktop id: {}", this.current_id))

        ; the number of virtual desktops
        all_ids := this.__read_reg(this.__REG_KEY_NAME_ALL_IDS, "VirtualDesktopIDs")
        this.count := all_ids ? Round(StrLen(all_ids) / this.id_length) : 1
        LOG(INFO, A_LineNumber, Format("The number of virtual desktop: {}", this.count))

        ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
        while (this.current_id and A_Index < this.count) {
            if (SubStr(all_ids, ((A_Index - 1) * this.id_length) + 1, this.id_length) = this.current_id) {
                this.index := A_Index
                break
            }
        }

        LOG(INFO, A_LineNumber, Format("Current virtual desktop index: {}", this.index))
    }

    slide(idx)
    {
        LOG_BLANK_LINE()

        LOG(INFO, A_LineNumber, Format("{} -> {}", this.index, idx))

        ; Re-generate the list of desktops and where we fit in that. We do this because
        ; the user may have switched desktops via some other means than the script.
        this.update()

        ; Don't attempt to switch to an invalid desktop
        if (idx > this.count || idx < 1) {
            LOG(ERROR, A_LineNumber, Format("The target index {} is out of the range.", idx))
            return
        }

        ; Go right until we reach the desktop we want
        while(this.index < idx) {
            Send ^#{Right}
            this.index++
            LOG(INFO, A_LineNumber, Format("[R] Target index: {}, current index: {}", idx, this.index))
        }

        ; Go left until we reach the desktop we want
        while(this.index > idx) {
            Send ^#{Left}
            this.index--
            LOG(INFO, A_LineNumber, Format("[L] Target index: {}, current index: {}", idx, this.index))
        }
    }

    ; create a new virtual desktop and switches to it
    create()
    {
        Send, #^d
        this.count++
        this.index := this.count
        LOG(INFO, A_LineNumber, Format("Create a virtual desktop: {}", this.index))
    }

    ; delete the current virtual desktop
    remove()
    {
        Send, #^{F4}
        this.count--
        this.index--
        LOG(INFO, A_LineNumber, Format("Remove a virtual desktop: {}", this.index + 1))
    }

    __read_reg(key, name) 
    {
        RegRead, value, %key%, %name%
        if ErrorLevel {
            LOG(ERROR, A_LineNumber, Format("RegRead: {}", ErrorLevel))
            return
        }

        return value
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetKeyDelay, 50
manager := new VirtualDesktopManager()
manager.update()

; ; default
; default_count := 3, default_index := 2
; while(manager.count != default_count) {
;     manager.count > default_count ? manager.remove() : manager.create()
;     manager.update()
; }
; manager.slide(default_index)

; User config!
LWin & 1::manager.slide(1)
LWin & 2::manager.slide(2)
LWin & 3::manager.slide(3)
LWin & 4::manager.slide(4)
LWin & 5::manager.slide(5)
LWin & 6::manager.slide(6)
LWin & 7::manager.slide(7)
LWin & 8::manager.slide(8)
LWin & 9::manager.slide(9)

^WheelLeft:: manager.slide(Mod(manager.index, manager.count) + 1)
^WheelRight::manager.slide(Mod(manager.index - 2 + manager.count, manager.count) + 1)

RButton::
    MIN_DIS := 160

    MouseGetPos, x_s, y_s
    KeyWait, RButton, U
    MouseGetPos, x_e, y_e

    if((x_s - x_e > MIN_DIS) and (Abs(y_s - y_e) < (MIN_DIS / 2))) {
        LOG(INFO, A_LineNumber, "LEFT")
        manager.slide(manager.index + 1)
    }
    else if((x_e - x_s > MIN_DIS) and (Abs(y_s - y_e) < (MIN_DIS / 2))) {
        LOG(INFO, A_LineNumber, "RIGHT")
        manager.slide(manager.index - 1)
    }
    else if(Abs(x_s - x_e) < (MIN_DIS / 2) and (y_s - y_e > MIN_DIS)) {
        LOG(INFO, A_LineNumber, "UP")

        If !WinActive("Task View")  {
            Send, #{Tab}
        }
    }
    else if(Abs(x_s - x_e) < (MIN_DIS / 2) and (y_e - y_s > MIN_DIS)) {
        LOG(INFO, A_LineNumber, "DOWN")

        If WinActive("Task View") {
            Send, #{Tab} 
        }
        else { 
            Send, #d
        }
    }
    else {
        SendInput, {RButton}
    }
Return

; Run windows terminal
^!t::Run wt
