# Overview
1. Configuring win keyboard shortcuts for [iTerm2](https://iterm2.com/documentation.html) app on MacOS
1. Assumes you already applied changes for [chrome](./keymap.chrome.md) and [slack](./keymap.slack.md)


# Behave more like linux terminal
1. `Preferences`... > `Profiles` > `Default` (or Profile name) > `Keys` > `Key Mappings`
1. Press `Presets...` dropdown button
1. Select **Terminal app compatibility** or **Natural Text Editing**


# Checklist to verify keyboard shortcuts

## These work out of the box (assuming hidutil remappings for chrome and slack)
|win Keyboard Shortcut|Action|
|---|---|
|`ALT` + `b`|Move cursor **back** 1 word| Send escape sequence | `b`|
|`ALT` + `f`|Move cursor **forward** 1 word| Send escape sequence | `f`|
|`CTRL` + `SHIFT` + v|Paste|
|`end`|Move cursor to end of line|
|`home`|Move cursor to start of line|

## Add mapping for these keys
|win Keyboard Shortcut|Behavior|iterm action|Send|
|---|---|---|---|
|`CTRL` + `a`|Move cursor to **start** of line|Send Hex Code|`0x01`|
|`CTRL` + `e`|Move cursor to **end** of line|Send Hex Code|`0x05`|
|`CTRL` + `k`|Clear from cursor to end|Send Hex Code|`0xb`|
|`CTRL` + `l`|Clear terminal|Send Hex Code|`0xc`|
|`CTRL` + `left`|Move cursor to previous word| Send escape sequence |`b`|
|`CTRL` + `r`|command history|Send Hex Code|`0x12` (18th letter in hex)|
|`CTRL` + `right`|Move cursor to next word| Send escape sequence | `f`|
|`CTRL` + `u`|Clear from cursor to start|Send Hex Code|`0x15`|
|`CTRL` + `z`|Move process to background|Send Hex Code|`0x1a`|
|TODO|Undo|Send Hex Code|`0x1f`|


# TODO (low priority)
|`SHIFT` + Insert|Paste|
|TODO|copy|



# Other resources
1. https://stackoverflow.com/questions/6205157/how-to-set-keyboard-shortcuts-to-jump-to-beginning-end-of-line
1. https://apple.stackexchange.com/questions/154292/iterm-going-one-word-backwards-and-forwards
https://iterm2.com/documentation-escape-codes.html
1. https://gist.github.com/mul14/32cb303493b4c8057a6ca147010276a0
