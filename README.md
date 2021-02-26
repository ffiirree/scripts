# Scripts

## Windows Terminal

![terminal](/images/wt.png)

## WSL2

### install zsh

```bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# .zshrc
plugins=(git z extract zsh-syntax-highlighting zsh-autosuggestions)
```

### use .xshrc

```bash
cat .xshrc >> .zshrc
```

- [x] WIN_IP: windows host ip adderss.
- [x] WSL_IP: WSL2 ip adderss.
- [x] alias: code -> Visual Stuido Code in windows.
- [x] Symbolic links: desktop -> Windows Desktop / download -> Windows Download
- [x] bat configuration.

## AutoHotkey
Keys | Actions
:-:|---
`Win` + `1`, `2`, ...       | **Switch** to virtual desktop **1, 2, etc**.
`Ctrl` + `WheelLeft` / `WheelRight`   | **Switch** to the virtual desktop on the **left / right**.
`RButton` slides left  / right   | **Switch** to the virtual desktop on the **left / right**.
`Ctrl` + `Left`  / `Right`  | **Switch** to the virtual desktop on the **left / right**.
`RButton` slides up         | **Show task view**.
`RButton` slides down       | **Show desktop**.
`Ctrl` + `Alt` + `T`        | **Run** windows terminal.
`LButton` + `RButton`       | `AltTab`.
`Ctrl` + `Up` / `Down`      | **Volume Up / Down**.
`WheelUp` / `WheelDown` when cursor is in the taskbar | **Volume Up / Down**.
`Ctrl` + `G`                | `Google` the selection.
`Ctrl` + `Alt` + `C`        | `Copy` the file path.
`Ctrl` + `Space`            | **Windows on top**.

### Run on startup

1. `Win` + `R` and input `shell:startup`, then, `Enter`.
2. Copy `.ahk` file to this folder.
