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


# Conflicts: OS (Linux)
|Action/Command|vscode default|my custom|Conflicts with|
|---:|:---:|:---:|:---|
|Go to Definition|`F12`|`CTRL + M`|guake/yakuake|


# Conflicts: vscode <-> JetBrains (High priority)
|Shortcut|vscode command|JetBrains action|
|---:|:---|:---|
|`ctrl + H`|replace|type hierarchy|
|`ctrl + K`|enter keep preview mode editor open|JetBrains,commit project to vcs|
|`ctrl + N`|new file|go to class|
|`ctrl + P`|quick open, go to file|parameter info|
|`ctrl + shift + A`|toggle block comment|find action|
|`ctrl + shift + enter`|insert line above|complete statement|
|`ctrl + shift + K`|delete line|push commits|
|`ctrl + shift + N`|new window/instance|go to file|
|`ctrl + shift + V`|open markdown preview|paste from recent buffers...|
|`ctrl + T`|show all symbols|update project from vcs|
|`ctrl + W`|close window/instance|JetBrains,extend selection|


# Conflicts: vscode <-> JetBrains (Low priority)
|Shortcut|vscode command|JetBrains action|
|---:|:---|:---|
|`alt + enter`|select all occurrences of find match|show intention actions and quick-fixes|
|`ctrl + D`|add selection to next find match|JetBrains,duplicate current line|
|`ctrl + enter`|insert line below|JetBrains,smart line split|
|`ctrl + O`|open file|override methods|
|`ctrl + shift + E`|show explorer / toggle focus|recent locations popup|
|`ctrl + shift + F`|show search|find in path|
|`ctrl + shift + f10`|peek definition|run context configuration from editor|
|`ctrl + shift + H`|replace in files|method hierarchy|
|`ctrl + shift + I`|format document|open quick definition lookup|
|`ctrl + shift + J`|toggle search details|smart line join|
|`ctrl + shift + space`|trigger parameter hints|smart code completion|
|`f11`|toggle full screen|toggle bookmark|
|`f5`|start / continue|JetBrains,copy|
|`f9`|toggle breakpoint|resume program|


# Custom: Easy to port to vscode (No conflicts)
|Action/Command|vscode binding(s)|
|---:|---:|
|Delete line|`CTRL + Y`, `CTRL + SHIFT + K`|
|Duplicate line|`CTRL + D`|
|Go forward|`ALT + CTRL + =`|
|Last edit location|`CTRL + SHIFT + Backspace`, `CTRL + K, CTRL + Q` <br>`navigateToLastEditLocation`|
|Recently opened files|`CTRL + E`|
|Replace in file|`CTRL + R`|
|Sort lines|`ALT + SHIFT + L`|


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


# TODO: Unorganized
|JetBrains Action|JetBrains shortcut|vscode Command|vscode shortcut|
|---|---|---|---|
|Restart IDE|--|Reload Window|--|

- (On MacOS) vscode treats `cmd` and `ctrl` as different keycodes

# Other resources
1. [Linux default keymap](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)
1. [All default keymaps](https://code.visualstudio.com/docs/configure/keybindings#_keyboard-shortcuts-reference)
