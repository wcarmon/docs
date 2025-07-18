# Overview

1. Making JetBrains shortcuts more like Linux/windows (IDEA, Goland, WebStorm, ...)
1. See [keymap](../java/intellij/keymaps.md) doc first


# TL;DR;
1. Download [./jetbrains-keymaps/win_keyboard_macos_5.xml](./jetbrains-keymaps/win_keyboard_macos_5.xml)
    1. Keymap **5** works without any other remapping from other tools
1. Copy `*.xml` into ...
    1. **Mac**: `$HOME/Library/Application Support/JetBrains/IntelliJIdea<version>/keymaps/`
    1. Linux: `$HOME/.config/JetBrains/IntelliJIdea<version>/keymaps/` 
    1. win: `%APPDATA%\JetBrains\IntelliJIdea<version>\keymaps\`
    1. Replace `IntelliJIdea` with other products like `GoLand`, `IdeaIC`, `PyCharm`, or `DataGrip`
1. Restart IDE
1. Select & use keymap



## Load your custom keymap

1. Open Goland/IDEA/Pycharm
1. Disable synchronization
    1. Check `Copy actual/last settings from account to this IDE`
    1. Click `Disable Settings Sync` button
1. Move keymap xml to ...
    1. `~/Library/Application Support/JetBrains/GoLand<version>/keymaps/*.xml`
    1. `~/Library/Application Support/JetBrains/IntellijIdea<version>/keymaps/*.xml`
    1. `~/Library/Application Support/JetBrains/PyCharm<version>/keymaps/*.xml`
1. Restart GoLand (or IDEA or PyCharm)
1. Enable Sync ...
    1. Click **`Keep and Sync Local Settings`**
    1. This will automatically write files to `~/Library/Application Support/JetBrains/<product><version>/jba_config/...`
1. Settings/Preferences > Keymaps
1. Select your keymap


# Mapping Keyboards to JetBrains keymap xml file
|`<keyboard-shortcut>` literal|Native Apple keyboard|USB windows keyboard|
|---|---|---|
|`alt`|`⌥` (option)|`Alt` key|
|`ctrl` or `control`|`⌃` (control)|`Ctrl` key|
|`shift`|`⇧` (shift)|`Shift` key|
|`meta`|`⌘` (command)|[super/windows key](https://en.wikipedia.org/wiki/Windows_key)|


## `ctrl` vs `control`
- TL;DR; use `control`
- JetBrains products on MacOS will read both `ctrl` vs `control`
- When you save the keymap on macos, it saves `"control"`
- When you save the keymap on Linux or Windows, it saves `"ctrl"` (TODO: verify)


# Alignment with Linux/win

1. Try copying [my keymap xml file](./wc_win_keyboard_on_macos_keymap_1.xml) into the dir above
    1. Assuming you remapped the modifiers as described in [keymap](./keymap.md) doc
    1. `"alt"` in `<keyboard-shortcut>` means **TODO**
    1. `"back_space"` in `<keyboard-shortcut>` means **TODO**
    1. `"close_bracket"` in `<keyboard-shortcut>` means **TODO**
    1. `"comma"` in `<keyboard-shortcut>` means **TODO**
    1. `"control"` and `"ctrl"` in `<keyboard-shortcut>` both mean **todo**
    1. `"enter"` in `<keyboard-shortcut>` means `ENTER` or `return` key
    1. `"equals"` in `<keyboard-shortcut>` means `=` key
    1. `"help"` in `<keyboard-shortcut>` means `Insert` key
    1. `"left"` in `<keyboard-shortcut>` means Left arrow key
    1. `"meta"` in `<keyboard-shortcut>` means **TODO**
    1. `"open_bracket"` in `<keyboard-shortcut>` means **TODO**
    1. `"period"` in `<keyboard-shortcut>` means dot/period key
    1. `"right"` in `<keyboard-shortcut>` means Right arrow key
    1. `"shift"` in `<keyboard-shortcut>` means `SHIFT` key
1. Order:
    1. ~~Order: `shift meta alt <letters-numbers>`~~ Order doesn't matter
    1. when the ide saves, it uses somewhat random order (maybe pressed order when recording)
1. Case:
    1. Case doesn't matter


# My most common shortcuts

1. These work out-of-the-box on native keyboard when using [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) based keymap
1. These might still be awkward on an external (linux/win) keyboard

| Category | Feature                                                                  | Linux, win, XWin shortcut          | MacOS keymap shortcut | Action Id                                       |
|----------|--------------------------------------------------------------------------|------------------------------------|-----------------------|-------------------------------------------------|
| Edit     | Basic code completion, Variable name completion, Second basic completion | `CTRL+Space`                       | TODO                  | `TODO`                                          |
| Edit     | Change case                                                              | `CTRL+SHIFT+U`                     | ⇧ ⌘ U                 | `EditorToggleCase`                              |
| Edit     | Comment or uncomment the current line                                    | `CTRL+/`, `CTRL+SHIFT+/`           | ⌘ /                   | `CommentByLineComment`, `CommentByBlockComment` |
| Edit     | Complete statement, Finish lookup with smart enter                       | `CTRL+SHIFT+Enter`                 | ⌃ Space               | `TODO`                                          |
| Edit     | Delete line                                                              | `CTRL+Y`                           | ⌘ ⌫                   | `EditorDeleteLine`                              |
| Edit     | Duplicate line                                                           | `CTRL+D`                           | ⌘ D                   | `TODO`                                          |
| Edit     | Inline                                                                   | `CTRL+ALT+N`                       | ⌥ ⌘ N                 | `Inline`                                        |
| Edit     | Move line up/down                                                        | `ALT+SHIFT+Up`, `ALT+SHIFT+Down`   | TODO ↓                | `MoveLineUp`, `MoveLineDown`                    |
| Edit     | Move statement up/down                                                   | `CTRL+SHIFT+Up`, `CTRL+SHIFT+Down` | ⇧ ⌘ ↓                 | `MoveStatementUp`, `MoveStatementDown`          |
| Edit     | Optimize Imports                                                         | `CTRL+ALT+O`                       | TODO                  | `TODO`                                          |
| Edit     | Override or implement a method                                           | `CTRL+O`                           | TODO                  | `TODO`                                          |
| Edit     | Postfix completion, live templates                                       | `CTRL+J`                           | TODO                  | `TODO`                                          |
| Edit     | Quick fixes, Global method name completion                               | `ALT+Enter`                        | TODO                  | `TODO`                                          |
| Edit     | Redo                                                                     | `CTRL+SHIFT+Z`                     | ⇧ ⌘ Z                 | `TODO`                                          |
| Edit     | Reformat                                                                 | `CTRL+ALT+L`                       | ⌥ ⌘ L                 | `TODO`                                          |
| Edit     | Sort lines                                                               | `ALT+SHIFT+L`                      | -                     | `TODO`                                          |
| Edit     | Syntax aware selection (Extend, Shrink)                                  | `CTRL+W`, `CTRL+SHIFT+W`           | TODO                  | `TODO`                                          |
| Edit     | Type-matching completion                                                 | `CTRL+SHIFT+Space`                 | ⌃ ⇧ Space             | `TODO`                                          |
| Edit     | Undo                                                                     | `CTRL+Z`                           | ⌘ Z                   | `TODO`                                          |
| Git      | add                                                                      | `CTRL+ALT+A`                       | TODO                  | `TODO`                                          |
| Git      | commit                                                                   | `CTRL+K`                           | ⌘ K                   | `TODO`                                          |
| Git      | push                                                                     | `CTRL+SHIFT+K`                     | ⇧ ⌘ K                 | `TODO`                                          |
| Navigate | AceJump - Activate / Cycle AceJump Mode                                  | `CTRL+;`, `CTRL+'`                 | --                    | `AceAction`                                     |
| Navigate | Diff                                                                     | `CTRL+D`                           | ⌘ D                   | `TODO`                                          |
| Navigate | File structure popup                                                     | `CTRL+F12`                         | ⌘ F12                 | `TODO`                                          |
| Navigate | Find (in current file)                                                   | `CTRL+F`                           | ⌘ F                   | `TODO`                                          |
| Navigate | Find in files                                                            | `CTRL+SHIFT+F`                     | ⇧ ⌘ F                 | `TODO`                                          |
| Navigate | Find usages                                                              | `ALT+F7`                           | ⌥ F7                  | `TODO`                                          |
| Navigate | Go to action                                                             | `CTRL+SHIFT+A`                     | ⇧ ⌘ A                 | `TODO`                                          |
| Navigate | Go to declaration                                                        | `CTRL+B`                           | ⇧ ⌘ B                 | `TODO`                                          |
| Navigate | Go to File                                                               | `CTRL+SHIFT+N`                     | ⇧ ⌘ O                 | `TODO`                                          |
| Navigate | Go to Line                                                               | `CTRL+G`                           | ⌘ L                   | `TODO`                                          |
| Navigate | Go to symbol                                                             | `CTRL+ALT+SHIFT+N`                 | ⌥ ⌘ O                 | `TODO`                                          |
| Navigate | Jump to next error                                                       | `F2`                               | (same)                | `TODO`                                          |
| Navigate | Last edit location                                                       | `CTRL+SHIFT+Backspace`             | ⇧ ⌘ ⌫                 | `JumpToLastChange`                              |
| Navigate | Move caret to next/previous method (member)                              | `ALT+Down`, `ALT+Up`               | ⌃ ⇧ ↓                 | `MethodDown`, `MethodUp`                        |
| Navigate | Param Info                                                               | `CTRL+P`                           | ⌘ P                   | `TODO`                                          |
| Navigate | Project view                                                             | `ALT+1`                            | ⌘ 1                   | `ActivateProjectToolWindow`                     |
| Navigate | Recent files popup                                                       | `CTRL+E`                           | ⌘ E                   | `TODO`                                          |
| Navigate | Replace (in current file)                                                | `CTRL+R`                           | ⌘ R                   | `TODO`                                          |
| Navigate | Replace in files                                                         | `CTRL+SHIFT+R`                     | ⇧ ⌘ R                 | `TODO`                                          |
| Navigate | Search Everywhere                                                        | `SHIFT+SHIFT`                      | (same)                | `TODO`                                          |
| Navigate | Select Multiple files                                                    | `CTRL+Click`                       | `Windows+Click`       | `TODO`                                          |
| Navigate | Select next/previous Tab                                                 | `ALT+Left` `ALT+Right`             | TODO                  | `TODO`                                          |
| Refactor | Extract constant                                                         | `CTRL+ALT+C`                       | ⌥ ⌘ C                 | `TODO`                                          |
| Refactor | Extract method                                                           | `CTRL+ALT+M`                       | ⌥ ⌘ M                 | `TODO`                                          |
| Refactor | Introduce/Extract variable                                               | `CTRL+ALT+V`                       | ⌥ ⌘ V                 | `TODO`                                          |
| Refactor | Rename                                                                   | `SHIFT+F6`                         | ⇧ F6                  | `TODO`                                          |
| Run      | Debug ...                                                                | `ALT+SHIFT+F9`                     | ⌃ ⌥ D                 | `TODO`                                          |
| Run      | Run ...                                                                  | `ALT+SHIFT+F10`                    | ⌃ ⌥ R                 | `TODO`                                          |

## Shortcuts to manually map (not part of XWin keymap)

1. For MacOS, use a keymap based [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap)
1. Might need to enable the [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) plugin on macOS

| Category | Feature                                | Linux, win, XWin shortcut | MacOS keymap shortcut | Add mapping (on MacOS) | Action ID                    |
|----------|----------------------------------------|---------------------------|-----------------------|------------------------|------------------------------|
| Edit     | Column select                          | `ALT+SHIFT+Insert`        | `⇧ ⌘ 8`               | **`⌥ ⇧ Help`**         | `TODO`                       |
| Files    | Generate..., New Directory             | `ALT+Insert`              | `⌘ N`                 | **`⌥ Help`**           | `TODO`                       |
| Navigate | AceJump: Activate / Cycle AceJump Mode | `CTRL+;`, `CTRL+'`        | --                    | **`⌃ ;` `⌃ '`**        | `TODO`                       |
| Navigate | Database Tool window                   | `ALT+D`                   | --                    | **`⌥ D`**              | `ActivateDatabaseToolWindow` |
| Navigate | Split and Move Right                   | `ALT+S`                   | --                    | **`⌥ S`**              | `TODO`                       |

- TODO: collapse/expand

## Manual shortcuts with OS conflict

1. `System Preferences` > `Keyboard` > `Shortcuts` >
    1. `Mission Control` > Disable `Move left a space`  (conflicts with `Move caret to previous word`)
    1. `Mission Control` > Disable `Move right a space` (conflicts with `Move caret to next word`)
    1. `Keyboard` > Disable `Move focus to status menus` (conflicts with `Toggle line breakpoint`)
    1. `Services` > Disable everything
        1. Specifically: Everything under Files and folders, Internet, Messaging, Pictures, Text
        1. `Services` > Disable `Open man Page in Terminal`
        1. `Services` > Disable `Open man Page Index in Terminal`
        1. `Services` > Disable `Show Map`
        1. `Services` > Disable `Add to Reading List`
        1. `Services` > Disable `Open URL`

| Category | Feature                          | Linux, win, XWin shortcut  | MacOS keymap shortcut | Add mapping (on MacOS)                            |
|----------|----------------------------------|----------------------------|-----------------------|---------------------------------------------------|
| Navigate | Move caret to next/previous word | `CTRL+Right` / `CTRL+Left` | `⌥ →` / `⌥ ←`         | Works once conflict removed                       |
| Navigate | Settings/Preferences             | `CTRL+ALT+S`               | `⌘ ,`                 | **TODO: conflict: `⌃ ⌥ S` or `Control+Option+S`** |
| Run      | Toggle line breakpoint           | `CTRL+F8`                  | `⌘ F8`                | Works once conflict removed                       |

# Option symbol conflicts

1. If you *lack* an explicit mapping, by default, `Option`+<letter> will print greek letters
    1. [jetbrains yourtrack issue](https://youtrack.jetbrains.com/issue/JBR-3409/Some-shortcuts-with-opt-key-cannot-trigger#focus=Comments-27-6081024.0-0)
1. Add [explicit key mappings](https://www.jetbrains.com/help/idea/configuring-keyboard-and-mouse-shortcuts.html)

--------

# Quick checklist to verify keyboard shortcuts

- The lists below use at-least-one of each special key combinations

## Key triads

1. `CTRL + ALT + SHIFT + N` (go to symbol)

## Key pairs

| Keymap             | Purpose              |
|--------------------|----------------------|
| `ALT + CTRL + L`   | Code > Reformat Code |
| `ALT + SHIFT + L`  | Edit > Sort lines    |
| `CTRL + SHIFT + A` | Go to action         |

## Single modifier key

| Keymap          | Purpose                 |
|-----------------|-------------------------|
| `ALT + 1`       | Tool Window > Project   |
| `CTRL + J`      | Insert Live Template... |
| `SHIFT + F6`    | Refactor > Rename...    |
| `SHIFT + SHIFT` | Search anywhere         |

# Other Resources

1. https://defkey.com/what-means
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://www.jetbrains.com/help/idea/reference-keymap-mac-default.html
1. https://www.jetbrains.com/help/idea/settings-keymap.html
