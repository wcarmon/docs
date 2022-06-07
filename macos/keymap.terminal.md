# Overview
- Configuring win keyboard for terminals on MacOS


# Changing Keyboard shortcuts via hidutil
1. Open terminal
1. Define the key constants in [keymap.os](./keymap.os.md) doc
1. Remap keyboard:
```sh
PRODUCT_ID_FOR_WIN_KEYBOARD=0x07a5;

```


# Checklist to verify keyboard shortcuts
|Shortcut|Behavior|
|---|---|
|`ALT` + `b`|Move cursor **back** 1 word|
|`ALT` + `f`|Move cursor **forward** 1 word|
|`CTRL` + `a`|Move cursor to **start** of line|
|`CTRL` + `e`|Move cursor to **end** of line|
|`CTRL` + `k`|clear from cursor to end|
|`CTRL` + `l`|Clear terminal|
|`CTRL` + `left`|Move cursor to previous word|
|`CTRL` + `r`|command history|
|`CTRL` + `right`|Move cursor to next word|
|`CTRL` + `u`|clear from cursor to start|
|`CTRL` + `z`|Move process to background|
|`end`|Move cursor to end of line|
|`home`|Move cursor to start of line|


# Other resources
1. https://www.makeuseof.com/linux-bash-terminal-shortcuts/
1. https://www.redhat.com/sysadmin/top-10-shortcuts
