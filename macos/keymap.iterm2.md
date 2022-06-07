# Overview
1. Configuring win keyboard shortcuts for [iTerm2](https://iterm2.com/documentation.html) app on MacOS
1. Assumes you already applied changes for [chrome](./keymap.chrome.md) and [slack](./keymap.slack.md)


# Behave more like linux terminal
1. `Preferences`... > `Profiles` > `Default` (or Profile name) > `Keys` > `Key Mappings`
1. Press `Presets...` dropdown button
1. Select **Terminal app compatibility** or **Natural Text Editing**


# Checklist to verify keyboard shortcuts

## These work out of the box
|win Keyboard Shortcut|Action|
|---|---|
|`end`|Move cursor to end of line|
|`home`|Move cursor to start of line|
|`CTRL` + `SHIFT` + v|Paste|

## Add mapping for these
|win Keyboard Shortcut|Behavior|iterm action|Send|
|---|---|---|---|
|`ALT` + `b`|Move cursor **back** 1 word| Send escape sequence | `b`|
|`ALT` + `f`|Move cursor **forward** 1 word| Send escape sequence | `f`|
|`CTRL` + `left`|Move cursor to previous word| Send escape sequence | `b`|
|`CTRL` + `right`|Move cursor to next word| Send escape sequence | `f`|

|`CTRL` + `a`|Move cursor to **start** of line| <--- control a
|`CTRL` + `e`|Move cursor to **end** of line|  <--- control e
|`CTRL` + `r`|command history| <--- control r
|`CTRL` + `z`|Move process to background| <--- control z


# TODO (low priority)
|`CTRL` + `k`|Clear from cursor to end|
|`CTRL` + `l`|Clear terminal|
|`CTRL` + `u`|Clear from cursor to start|
|`SHIFT` + Insert|Paste|
|TODO|copy|



# Other resources
1. https://stackoverflow.com/questions/6205157/how-to-set-keyboard-shortcuts-to-jump-to-beginning-end-of-line
1. https://apple.stackexchange.com/questions/154292/iterm-going-one-word-backwards-and-forwards
