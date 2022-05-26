# Overview
1. Getting consistent behavior across linux/mac/windows keyboards (for JetBrains products)
    1. muscle memory reuse


# JetBrains Keymap files
1. [User keymap files](https://www.jetbrains.com/help/idea/configuring-keyboard-and-mouse-shortcuts.html#custom_keymap_location)

## Linux
1. `$HOME/.config/JetBrains/<product><version>/keymaps`
    1. eg. `$HOME/.config/JetBrains/IntelliJIdea2022.1/keymaps`

## Mac
1. `~/Library/Application Support/JetBrains/<product><version>/keymaps`

## windows
1. `%APPDATA%\JetBrains\<product><version>\keymaps`

# Examples of product+version
1. `CLion2021.3`
1. `DataGrip2022.1`
1. `GoLand2022.1`
1. `IntelliJIdea2021.3`
1. `IntelliJIdea2022.1`
1. `PyCharm2021.3`
1. `PyCharm2022.1`


# My most common shortcuts
|Category|Feature|Linux, win, XWin shortcut|MacOS keymap shortcut|
|---|---|---|---|
|Edit|Basic code completion, Variable name completion, Second basic completion|`CTRL+Space`|TODO|
|Edit|Change case|`CTRL+SHIFT+U`|⇧ ⌘ U|
|Edit|Comment or uncomment the current line|`CTRL+/`, `CTRL+SHIFT+/`|⌘ /|
|Edit|Complete statement, Finish lookup with smart enter|`CTRL+SHIFT+Enter`|⌃ Space|
|Edit|Delete line|`CTRL+Y`|⌘ ⌫|
|Edit|Duplicate line|`CTRL+D`|⌘ D|
|Edit|Inline|`CTRL+ALT+N`|⌥ ⌘ N|
|Edit|Move statement up/down|`CTRL+SHIFT+Up`, `CTRL+SHIFT+Down`|⇧ ⌘ ↓|
|Edit|Optimize Imports|`ALT+CTRL+O`|TODO|
|Edit|Override or implement a method|`CTRL+O`|TODO|
|Edit|Postfix completion|`CTRL+J`|TODO|
|Edit|Quick fixes, Global method name completion|`ALT+Enter`|TODO|
|Edit|Redo|`CTRL+SHIFT+Z`|⇧ ⌘ Z|
|Edit|Reformat|`ALT+CTRL+L`|⌥ ⌘ L|
|Edit|Sort lines|`ALT+SHIFT+L`|-|
|Edit|Syntax aware selection|`CTRL+W`, `CTRL+SHIFT+W`|TODO|
|Edit|Type-matching completion|`CTRL+SHIFT+Space`|⌃ ⇧ Space|
|Edit|Undo|`CTRL+Z`|⌘ Z|
|Git|add|`ALT+CTRL+A`|TODO|
|Git|commit|`CTRL+K`|⌘ K|
|Git|push|`CTRL+SHIFT+K`|⇧ ⌘ K|
|Navigate|AceJump - Activate / Cycle AceJump Mode|`CTRL+;`, `CTRL+'`|--|
|Navigate|Diff|`CTRL+D`|⌘ D|
|Navigate|File structure popup|`CTRL+F12`|⌘ F12|
|Navigate|Find (in current file)|`CTRL+F`|⌘ F|
|Navigate|Find in files|`CTRL+SHIFT+F`|⇧ ⌘ F|
|Navigate|Find usages|`ALT+F7`|⌥ F7|
|Navigate|Go to action|`CTRL+SHIFT+A`|⇧ ⌘ A|
|Navigate|Go to declaration|`CTRL+B`|⇧ ⌘ B|
|Navigate|Go to File|`CTRL+SHIFT+N`|⇧ ⌘ O|
|Navigate|Go to Line|`CTRL+G`|⌘ L|
|Navigate|Go to symbol|`ALT+CTRL+SHIFT+N`|⌥ ⌘ O|
|Navigate|Jump to next error|`F2`|(same)|
|Navigate|Last edit location|`CTRL+SHIFT+Backspace`|⇧ ⌘ ⌫|
|Navigate|Move caret to next method (member)|`ALT+Down`|⌃ ⇧ ↓|
|Navigate|Param Info|`CTRL+P`|⌘ P|
|Navigate|Project view|`ALT+1`|⌘ 1|
|Navigate|Recent files popup|`CTRL+E`|⌘ E|
|Navigate|Replace (in current file)|`CTRL+R`|⌘ R|
|Navigate|Replace in files|`CTRL+SHIFT+R`|⇧ ⌘ R|
|Navigate|Search Everywhere|`SHIFT+SHIFT`|(same)|
|Navigate|Select Multiple files|`CTRL+Click`|`Windows+Click`|
|Refactor|Extract constant|`ALT+CTRL+C`|⌥ ⌘ C|
|Refactor|Extract method|`ALT+CTRL+M`|⌥ ⌘ M|
|Refactor|Introduce/Extract variable|`ALT+CTRL+V`|⌥ ⌘ V|
|Refactor|Rename|`SHIFT+F6`|⇧ F6|
|Run|Debug ...|`ALT+SHIFT+F9`|⌃ ⌥ D|
|Run|Run ...|`ALT+SHIFT+F10`|⌃ ⌥ R|


## Shortcuts to manually map (not part of XWin keymap)
1. For MacOS, use a keymap based [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap)
1. Might need to enable the [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) plugin on macOS

|Category|Feature|Linux, win, XWin shortcut|MacOS keymap shortcut|Add mapping (on MacOS)|
|---|---|---|---|---|
|Edit|Column select|`ALT+SHIFT+Insert`|`⇧ ⌘ 8`|**`⌥ ⇧ Help`**|
|Files|Generate..., New Directory|`ALT+Insert`|`⌘ N`|**`⌥ Help`**|
|Navigate|AceJump: Activate / Cycle AceJump Mode|`CTRL+;`, `CTRL+'`|--|**`⌃ ;` `⌃ '`**|
|Navigate|Database Tool window|`ALT+D`|--|**`⌥ D`**|
|Navigate|Split and Move Right|`ALT+S`|--|**`⌥ S`**|

- TODO: collapse/expand

## Manual shortcuts with OS conflict
|Category|Feature|Linux, win, XWin shortcut|MacOS keymap shortcut|Add mapping (on MacOS)|
|---|---|---|---|---|
|Navigate|Move caret to next/previous word|`CTRL+Right` / `CTRL+Left` |`⌥ →` / `⌥ ←`|**`TODO`**|
|Navigate|Settings/Preferences|`CTRL+ALT+S`|`⌘ ,`|**`TODO`**|
|Run|Toggle line breakpoint|`CTRL+F8`|`⌘ F8`|**`TODO`**|


# Other resources
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://www.jetbrains.com/help/idea/reference-keymap-mac-default.html
1. https://www.jetbrains.com/help/idea/settings-keymap.html
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
