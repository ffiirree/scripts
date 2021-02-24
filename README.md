# Scripts

## Windows Terminal

![terminal](/images/wt.png)

## WSL2

```bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# .zshrc
plugins=( [plugins...] zsh-syntax-highlighting)
```

## AutoHotkey
Keys | Actions
:-:|---
`Win` + `1`, `2`, ...|**Switch** to virtual desktop **1, 2, etc**.
`Ctrl` + `WheelLeft` / `WheelRight`   | **Switch** to the virtual desktop on the **left / right**.
`RButton` slides left  / right   | **Switch** to the virtual desktop on the **left / right**.
`RButton` slides up     | **Show task view**.
`RButton` slides down   | **Show desktop**.
`Ctrl` + `Alt` + `T`    | **Run** windows terminal.
`LButton` + `RButton`   | `AltTab`.
`Ctrl` + `Up` / `Down`  | **Volume Up / Down**.
`WheelUp` / `WheelDown` when cursor is in the taskbar | **Volume Up / Down**.
`Ctrl` + `G`            | `Google` the selection.
`Ctrl` + `Alt` + `C`    | `Copy` the file path.



### Run on startup

Copy `.ahk` files to `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`
