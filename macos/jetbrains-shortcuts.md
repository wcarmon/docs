# Overview
1. Making Jetbrains shortcuts more like Linux/windows (IDEA, Goland, WebStorm, ...)


# My most common shortcuts
1. These work out-of-the-box when using [XWin](https://plugins.jetbrains.com/plugin/13094-xwin-keymap) based keymap

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
|Edit|Optimize Imports|`CTRL+ALT+O`|TODO|
|Edit|Override or implement a method|`CTRL+O`|TODO|
|Edit|Postfix completion, live templates|`CTRL+J`|TODO|
|Edit|Quick fixes, Global method name completion|`ALT+Enter`|TODO|
|Edit|Redo|`CTRL+SHIFT+Z`|⇧ ⌘ Z|
|Edit|Reformat|`CTRL+ALT+L`|⌥ ⌘ L|
|Edit|Sort lines|`ALT+SHIFT+L`|-|
|Edit|Syntax aware selection|`CTRL+W`, `CTRL+SHIFT+W`|TODO|
|Edit|Type-matching completion|`CTRL+SHIFT+Space`|⌃ ⇧ Space|
|Edit|Undo|`CTRL+Z`|⌘ Z|
|Git|add|`CTRL+ALT+A`|TODO|
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
|Navigate|Go to symbol|`CTRL+ALT+SHIFT+N`|⌥ ⌘ O|
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
|Navigate|Select next/previous Tab|`ALT+Left` `ALT+Right`|TODO|
|Refactor|Extract constant|`CTRL+ALT+C`|⌥ ⌘ C|
|Refactor|Extract method|`CTRL+ALT+M`|⌥ ⌘ M|
|Refactor|Introduce/Extract variable|`CTRL+ALT+V`|⌥ ⌘ V|
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
1. Create/open your key bindings file
```sh
mkdir ~/Library/KeyBindings;
touch ~/Library/KeyBindings/DefaultKeyBinding.dict
```
1. Add this & save
```
/*
^ : Ctrl
$ : Shift
~ : Option (Alt)
@ : Command (Apple)
# : Numeric Keypad
*/

{
    "@\UF702"  = "moveWordBackward:";                            /* Cmd  + LeftArrow */
    "@\U007F"  = "deleteWordBackward:";                          /* Cmd  + Backspace */
    "@\UF703"  = "moveWordForward:";                             /* Cmd  + RightArrow */
    "@\UF728"  = "deleteWordForward:";                           /* Cmd  + Delete */

    "~a" = ();
    "~b" = ();
    "~c" = ();
    "~d" = ();
    "~e" = ();
    "~f" = ();
    "~g" = ();
    "~h" = ();
    "~i" = ();
    "~j" = ();
    "~k" = ();
    "~l" = ();
    "~m" = ();
    "~n" = ();
    "~o" = ();
    "~p" = ();
    "~q" = ();
    "~r" = ();
    "~s" = ();
    "~t" = ();
    "~u" = ();
    "~v" = ();
    "~w" = ();
    "~x" = ();
    "~y" = ();
    "~z" = ();
}
```



# Quick checklist to verify shortcuts
## Triads
1. `CTRL+ALT+SHIFT+N` (go to symbol)

## Pairs
1. `ALT+SHIFT+L` (sort lines)
1. `CTRL+ALT+L` (reformat)
1. `CTRL+SHIFT+A` (go to action)

## Single
1. `ALT+1` (project view)
1. `CTRL+J` (live templates)
1. `SHIFT+F6` (rename)
1. `SHIFT+SHIFT` (Search anywhere)


# Other resources
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://www.jetbrains.com/help/idea/reference-keymap-mac-default.html
1. https://www.jetbrains.com/help/idea/settings-keymap.html
1. https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf
1. https://defkey.com/what-means
