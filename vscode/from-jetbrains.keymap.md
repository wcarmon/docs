# Overview
1. Migrating keymappings from Jetbrains to vscode


--------
# Sidebars (vscode) == Tool window (JetBrains)
|Shows...|Jetbrains|vscode|
|---|---|---|
|File tree|`ALT + 1`|`CTRL + SHIFT + E`|
|todo|todo|todo|


--------
# Editor: Key Bindings
|Action|Jetbrains|vscode|Destructive in vsc|Destructive in JB|
|---:|---:|---:|:---:|:---:|
|Column select|`ALT + SHIFT + INS`|`ALT + SHIFT + DOWN`|TODO|TODO|
|Change font size (Change zoom level)|`CTRL + Mouse wheel`|`CTRL+ +`, `CTRL+ -`|TODO|TODO|
|Copy line|`CTRL + C` (without selection)|TODO|TODO|TODO|
|Extend selection|`CTRL + W`|`ALT + SHIFT+RIGHT`|**Yes**|no|
|Move line|`CTRL + SHIFT+DOWN`|`ALT + DOWN`|TODO|TODO|
|Toggle case on selection|`CTRL + SHIFT+U`|`transform` action|TODO|TODO|


# Navigation: Key Bindings
|Action|Jetbrains|vscode|Destructive in vsc|Destructive in JB|
|---:|---:|---:|:---:|:---:|
|Ace Jump|(custom)|TODO|TODO|TODO|
|Center editor group|TODO|`CTRL + 2`|TODO|TODO|
|Close active editor|TODO|`CTRL + W`|TODO|no|
|First editor group|TODO|`CTRL + 1`|TODO|TODO|
|Run anything|`CTRL + SHIFT + A`|`CTRL + SHIFT + P`|TODO|Type info|
|Settings|`ALT + CTRL + S`|`CTRL+,`|no|TODO|
|Switch tab|TODO|TODO|TODO|TODO|
|Un-close active editor|TODO|TODO|TODO|TODO|


# Key Bindings: ported to vscode
|Action|vscode binding(s)|
|---:|---:|
|Delete line|`CTRL + Y`, `CTRL + SHIFT + K`|
|Duplicate line|`CTRL + D`|
|Last edit location|`CTRL + SHIFT + Backspace`, `CTRL + K, CTRL + Q` <br>`navigateToLastEditLocation`|
|Recently opened files|`CTRL + E`|
|Replace in file|`CTRL + R`|
|Sort lines|`ALT + SHIFT + L`|


# Key Bindings: Same Defaults (in Jetbrains and vscode)
|Action|Jetbrains & vscode|Custom|
|---:|---:|:---:|
|Find in file|`CTRL + F`|--|
|Go to line|`CTRL + G`|--|
|Move editor into next group|`ALT + S`|yes|
|Redo|`CTRL + SHIFT + Z`|--|
|Switch tabs|`CTRL + Tab`|--|
|Toggle line comment|`CTRL+/`|--|
|Undo|`CTRL + Z`|--|


# TODO: migrate these
1. go to definition
1. toggle: show/hide type hints
1. focus on tabnine chat
1. Copy absolute path of current file to clipboard


# Other resources
1. [Linux default keymap](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)
1. [All default keymaps](https://code.visualstudio.com/docs/configure/keybindings#_keyboard-shortcuts-reference)
