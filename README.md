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

- [x] `WIN_IP`: windows host ip adderss.
- [x] `WSL_IP`: WSL2 ip adderss.
- [x] `alias`: code -> Visual Stuido Code in windows.
- [x] `Symbolic links`: desktop -> Windows Desktop / download -> Windows Download
- [x] `bat` configuration.
- [x] `proxy`: WSL2 proxy / WSL2 git proxy.

## AutoHotkey

|                         Keys                          | Actions                                                    |
| :---------------------------------------------------: | ---------------------------------------------------------- |
|            `RButton` slides left  / right             | **Switch** to the virtual desktop on the **left / right**. |
|              `Ctrl` + `Left`  / `Right`               | **Switch** to the virtual desktop on the **left / right**. |
|                  `RButton` slides up                  | **Show task view**.                                        |
|                 `RButton` slides down                 | **Show desktop**.                                          |
|                 `Ctrl` + `Alt` + `T`                  | **Run** windows terminal.                                  |
|                 `LButton` + `RButton`                 | `AltTab`.                                                  |
|                `Ctrl` + `Up` / `Down`                 | **Volume Up / Down**.                                      |
| `WheelUp` / `WheelDown` when cursor is on the TaskBar | **Volume Up / Down**.                                      |
|                     `Ctrl` + `G`                      | `Google` the selection.                                    |
|                   `Ctrl` + `Space`                    | **Set the Active Window Stay on Top**.                     |
|                Mouse `Back`/`Forward`                 | `Alt` + `Left`/`Right`(Adobe Acrobat PDF only)             |

### Run on startup

1. `Win` + `R` and input `shell:startup`, then, `Enter`.
2. Copy `.ahk` file to this folder.

## PowerShell

### Download & Install

[Github : PowerShell](https://github.com/PowerShell/PowerShell)

### Install Oh-My-Push

```sh
winget install JanDeDobbeleer.OhMyPosh -s winget
```

#### Theme

```sh
code $PROFILE

# Add to the profile
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\ys.omp.json" | Invoke-Expression
```

> If you have some garbled icons on your VS Code terminal with the theme, please install the font on your Windows OS and set the terminal's font in your VS Code "setting.json" file. Like:
> 
> "terminal.integrated.fontFamily": "CodeNewRoman NFM"

### PSReadLine

```sh
Install-Module -Name PSReadLine -AllowClobber -Force

# Add to $PROFILE
# Enable Predictive IntelliSense
Set-PSReadLineOption -PredictionSource History
# Disable Predictive IntelliSense
Set-PSReadLineOption -PredictionSource None

Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Custom Key Bindings
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
```

## Some fonts

[Github : Nerd fonts](https://github.com/ryanoasis/nerd-fonts)

## Xray

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install nginx
sudo systemctl status nginx

# http://<IP>:80
# check 
sudo ufw status
sudo ufw allow 'Nginx Full'

sudo apt install socat
curl https://get.acme.sh | sh

/root/.acme.sh/acme.sh  --issue --server letsencrypt -d zhliangqi.com -w /var/www/html --keylength ec-256

wget https://github.com/XTLS/Xray-install/raw/main/install-release.sh
sudo bash install-release.sh
```
