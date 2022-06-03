# Overview
1. Making Jetbrains shortcuts more like Linux/windows (IDEA, Goland, WebStorm, ...)


# My most common shortcuts
1. These work out-of-the-box when using [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) based keymap

|Category|Feature|Linux, win, XWin shortcut|MacOS keymap shortcut|Action Id|
|---|---|---|---|---|
|Edit|Basic code completion, Variable name completion, Second basic completion|`CTRL+Space`|TODO| `TODO` |
|Edit|Change case|`CTRL+SHIFT+U`|⇧ ⌘ U| `TODO` |
|Edit|Comment or uncomment the current line|`CTRL+/`, `CTRL+SHIFT+/`|⌘ /| `TODO` |
|Edit|Complete statement, Finish lookup with smart enter|`CTRL+SHIFT+Enter`|⌃ Space| `TODO` |
|Edit|Delete line|`CTRL+Y`|⌘ ⌫| `TODO` |
|Edit|Duplicate line|`CTRL+D`|⌘ D| `TODO` |
|Edit|Inline|`CTRL+ALT+N`|⌥ ⌘ N| `TODO` |
|Edit|Move statement up/down|`CTRL+SHIFT+Up`, `CTRL+SHIFT+Down`|⇧ ⌘ ↓| `TODO` |
|Edit|Optimize Imports|`CTRL+ALT+O`|TODO| `TODO` |
|Edit|Override or implement a method|`CTRL+O`|TODO| `TODO` |
|Edit|Postfix completion, live templates|`CTRL+J`|TODO| `TODO` |
|Edit|Quick fixes, Global method name completion|`ALT+Enter`|TODO| `TODO` |
|Edit|Redo|`CTRL+SHIFT+Z`|⇧ ⌘ Z| `TODO` |
|Edit|Reformat|`CTRL+ALT+L`|⌥ ⌘ L| `TODO` |
|Edit|Sort lines|`ALT+SHIFT+L`|-| `TODO` |
|Edit|Syntax aware selection|`CTRL+W`, `CTRL+SHIFT+W`|TODO| `TODO` |
|Edit|Type-matching completion|`CTRL+SHIFT+Space`|⌃ ⇧ Space| `TODO` |
|Edit|Undo|`CTRL+Z`|⌘ Z| `TODO` |
|Git|add|`CTRL+ALT+A`|TODO| `TODO` |
|Git|commit|`CTRL+K`|⌘ K| `TODO` |
|Git|push|`CTRL+SHIFT+K`|⇧ ⌘ K| `TODO` |
|Navigate|AceJump - Activate / Cycle AceJump Mode|`CTRL+;`, `CTRL+'`|--| `TODO` |
|Navigate|Diff|`CTRL+D`|⌘ D| `TODO` |
|Navigate|File structure popup|`CTRL+F12`|⌘ F12| `TODO` |
|Navigate|Find (in current file)|`CTRL+F`|⌘ F| `TODO` |
|Navigate|Find in files|`CTRL+SHIFT+F`|⇧ ⌘ F| `TODO` |
|Navigate|Find usages|`ALT+F7`|⌥ F7| `TODO` |
|Navigate|Go to action|`CTRL+SHIFT+A`|⇧ ⌘ A| `TODO` |
|Navigate|Go to declaration|`CTRL+B`|⇧ ⌘ B| `TODO` |
|Navigate|Go to File|`CTRL+SHIFT+N`|⇧ ⌘ O| `TODO` |
|Navigate|Go to Line|`CTRL+G`|⌘ L| `TODO` |
|Navigate|Go to symbol|`CTRL+ALT+SHIFT+N`|⌥ ⌘ O| `TODO` |
|Navigate|Jump to next error|`F2`|(same)| `TODO` |
|Navigate|Last edit location|`CTRL+SHIFT+Backspace`|⇧ ⌘ ⌫| `TODO` |
|Navigate|Move caret to next method (member)|`ALT+Down`|⌃ ⇧ ↓| `TODO` |
|Navigate|Param Info|`CTRL+P`|⌘ P| `TODO` |
|Navigate|Project view|`ALT+1`|⌘ 1| `TODO` |
|Navigate|Recent files popup|`CTRL+E`|⌘ E| `TODO` |
|Navigate|Replace (in current file)|`CTRL+R`|⌘ R| `TODO` |
|Navigate|Replace in files|`CTRL+SHIFT+R`|⇧ ⌘ R| `TODO` |
|Navigate|Search Everywhere|`SHIFT+SHIFT`|(same)| `TODO` |
|Navigate|Select Multiple files|`CTRL+Click`|`Windows+Click`| `TODO` |
|Navigate|Select next/previous Tab|`ALT+Left` `ALT+Right`|TODO| `TODO` |
|Refactor|Extract constant|`CTRL+ALT+C`|⌥ ⌘ C| `TODO` |
|Refactor|Extract method|`CTRL+ALT+M`|⌥ ⌘ M| `TODO` |
|Refactor|Introduce/Extract variable|`CTRL+ALT+V`|⌥ ⌘ V| `TODO` |
|Refactor|Rename|`SHIFT+F6`|⇧ F6| `TODO` |
|Run|Debug ...|`ALT+SHIFT+F9`|⌃ ⌥ D| `TODO` |
|Run|Run ...|`ALT+SHIFT+F10`|⌃ ⌥ R| `TODO` |


## Shortcuts to manually map (not part of XWin keymap)
1. For MacOS, use a keymap based [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap)
1. Might need to enable the [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) plugin on macOS

|Category|Feature|Linux, win, XWin shortcut|MacOS keymap shortcut|Add mapping (on MacOS)|Action ID|
|---|---|---|---|---|---|
|Edit|Column select|`ALT+SHIFT+Insert`|`⇧ ⌘ 8`|**`⌥ ⇧ Help`**| `TODO` |
|Files|Generate..., New Directory|`ALT+Insert`|`⌘ N`|**`⌥ Help`**| `TODO` |
|Navigate|AceJump: Activate / Cycle AceJump Mode|`CTRL+;`, `CTRL+'`|--|**`⌃ ;` `⌃ '`**| `TODO` |
|Navigate|Database Tool window|`ALT+D`|--|**`⌥ D`**| `ActivateDatabaseToolWindow` |
|Navigate|Split and Move Right|`ALT+S`|--|**`⌥ S`**| `TODO` |

- TODO: collapse/expand

## Manual shortcuts with OS conflict
1. `System Preferences` > `Keyboard` > `Shortcuts` >
    1. `Mission Control` > Disable `Move left a space`  (conflicts with `Move caret to previous word`)
    1. `Mission Control` > Disable `Move right a space` (conflicts with `Move caret to next word`)
    1. `Keyboard` > Disable `Move focus to status menus` (conflicts with `Toggle line breakpoint`)
    1. `Services` > Disable `Open man Page in Terminal`
    1. `Services` > Disable `Open man Page Index in Terminal`
    1. `Services` > Disable `Show Map`
    1. `Services` > Disable `Add to Reading List`
    1. `Services` > Disable `Open URL`

|Category|Feature|Linux, win, XWin shortcut|MacOS keymap shortcut|Add mapping (on MacOS)|
|---|---|---|---|---|
|Navigate|Move caret to next/previous word|`CTRL+Right` / `CTRL+Left` |`⌥ →` / `⌥ ←`|Works once conflict removed|
|Navigate|Settings/Preferences|`CTRL+ALT+S`|`⌘ ,`|**TODO: conflict: `⌃ ⌥ S` or `Control+Option+S`**|
|Run|Toggle line breakpoint|`CTRL+F8`|`⌘ F8`|Works once conflict removed|


# Option symbol conflicts
1. If you *lack* an explicit mapping, by default, `Option`+<letter> will print greek letters
    1. [jetbrains yourtrack issue](https://youtrack.jetbrains.com/issue/JBR-3409/Some-shortcuts-with-opt-key-cannot-trigger#focus=Comments-27-6081024.0-0)
1. Add [explicit key mappings](https://www.jetbrains.com/help/idea/configuring-keyboard-and-mouse-shortcuts.html)


# Quick checklist to verify shortcuts
## Triads
1. `CTRL+ALT+SHIFT+N` (go to symbol)

## Pairs
1. `ALT+SHIFT+L` (Edit > Sort lines)
1. `CTRL+ALT+L` (Code > Reformat Code)
1. `CTRL+SHIFT+A` (go to action)

## Single
1. `ALT+1` (Tool Window > Project)
1. `CTRL+J` (Insert Live Template...)
1. `SHIFT+F6` (Refactor > Rename...)
1. `SHIFT+SHIFT` (Search anywhere)


# Jetbrains user-defined keymap files
- Linux: `$HOME/.config/JetBrains/IntelliJIdea<version>/jba_config/keymaps/*.xml`
    1. or `$HOME/.config/JetBrains/IntelliJIdea<version>/keymaps/*.xml`
- MacOS: `~/Library/Application Support/JetBrains/IntelliJIdea<version>/jba_config/mac.keymaps/*.xml`
    1. **NOT** `~/Library/Application Support/JetBrains/IntelliJIdea<version>/keymaps/*.xml`
- win: `%APPDATA%\JetBrains\IntelliJIdea<version>\keymaps\*.xml`
- (You can replace `IntelliJIdea` with other products like `GoLand`, `IdeaIC`, `PyCharm`, or `DataGrip`)


# Other resources
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://www.jetbrains.com/help/idea/reference-keymap-mac-default.html
1. https://www.jetbrains.com/help/idea/settings-keymap.html
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://defkey.com/what-means
