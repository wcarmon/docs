# Overview
1. How to have a smooth experience with Linux Mint and vscode


# Find keyboard conflicts
- For F5: `gsettings list-recursively | grep -i f5`


# Guake
- Remove guake and use [yaquake](https://apps.kde.org/yakuake/) instead


# Drop conflicts
```
gsettings set org.cinnamon.desktop.keybindings.wm begin-move "[]"
gsettings set org.gnome.desktop.wm.keybindings begin-move "[]"
gsettings set org.mate.Marco.window-keybindings begin-move 'disabled'

# gsettings set org.guake.keybindings.local switch-tab5 ''
```