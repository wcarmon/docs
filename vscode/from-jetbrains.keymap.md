# Overview
1. Migrating keymappings from JetBrains to vscode


# User keybindings
1. `$HOME/.config/Code/User/keybindings.json` (User scoped keybindings)
1. `$HOME/.config/Code/User/settings.json` (User scoped settings)


--------
# Sidebars (vscode) == Tool window (JetBrains)
|Shows...|JetBrains|vscode|
|---|---|---|
|File tree|`ALT + 1`|`CTRL + SHIFT + E`|
|Git changes|`CTRL + K`|`CTRL + SHIFT + G`|
|Run|`Alt + 4`|todo|
|Debug|`Alt + 5`|todo|
|Tabnine Chat|`ALT + CTRL + I`|`ALT + CTRL + I`|
|Show/Hide Left Sidebar|ALT + 1|CTRL + B|
|todo|todo|todo|


--------
# Editor: Key Bindings (Default)
|Action|JetBrains|vscode|Destructive in vsc|Destructive in JB|
|---:|---:|---:|:---:|:---:|
|Column select|`ALT + SHIFT + INS`|`ALT + SHIFT + DOWN`|TODO|TODO|
|Change font size (Change zoom level)|`CTRL + Mouse wheel`|`CTRL+ +`, `CTRL+ -`|TODO|TODO|
|Copy line|`CTRL + C` (without selection)|TODO|TODO|TODO|
|Extend selection|`CTRL + W`|`ALT + SHIFT+RIGHT`|**Yes**|no|
|Move line|`CTRL + SHIFT+DOWN`|`ALT + DOWN`|TODO|TODO|
|Toggle case on selection|`CTRL + SHIFT+U`|`transform` action|TODO|TODO|


# Navigation: Key Bindings (Default)
|Action|JetBrains|vscode|Destructive in vsc|Destructive in JB|
|---:|---:|---:|:---:|:---:|
|Ace Jump|(custom)|TODO|TODO|TODO|
|Center editor group|TODO|`CTRL + 2`|TODO|TODO|
|Close active editor|TODO|`CTRL + W`|TODO|no|
|First editor group|TODO|`CTRL + 1`|TODO|TODO|
|Run anything|`CTRL + SHIFT + A`|`CTRL + SHIFT + P`|TODO|Type info|
|Settings|`ALT + CTRL + S`|`CTRL+,`|no|TODO|
|Switch tab|TODO|TODO|TODO|TODO|
|Un-close active editor|TODO|TODO|TODO|TODO|


# Port to vscode
|Action/Command|vscode binding(s)|
|---:|---:|
|Delete line|`CTRL + Y`, `CTRL + SHIFT + K`|
|Duplicate line|`CTRL + D`|
|Last edit location|`CTRL + SHIFT + Backspace`, `CTRL + K, CTRL + Q` <br>`navigateToLastEditLocation`|
|Recently opened files|`CTRL + E`|
|Replace in file|`CTRL + R`|
|Sort lines|`ALT + SHIFT + L`|


# Change these ... conflicts
|Action/Command|vscode default|my custom|Conflicts with|
|---|---|---|---|
|Go to Definition|`F12`|todo|guake/yakuake|
|todo|todo|todo|todo|


# Same Defaults (in JetBrains and vscode)
|Action/Command|JetBrains & vscode|Custom|
|---:|---:|:---:|
|Find in file|`CTRL + F`|--|
|Go to line|`CTRL + G`|--|
|Move editor into next group|`ALT + S`|yes|
|Redo|`CTRL + SHIFT + Z`|--|
|Switch tabs|`CTRL + Tab`|--|
|Toggle line comment|`CTRL+/`|--|
|Undo|`CTRL + Z`|--|


# TODO: Unorganized
|JetBrains Action|JetBrains shortcut|vscode Command|vscode shortcut|
|---|---|---|---|
|Restart IDE|--|Reload Window|--|


# Other resources
1. [Linux default keymap](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)
1. [All default keymaps](https://code.visualstudio.com/docs/configure/keybindings#_keyboard-shortcuts-reference)
