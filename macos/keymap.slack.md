# Overview
- Configuring win keyboard shortcuts for [slack](https://slack.com/) on MacOS


# Changing Keyboard shortcuts via hidutil
1. Open terminal
1. Define the key constants in [keymap.os](./keymap.os.md#steps-via-command-line) doc
1. Remap keyboard:
```sh
PRODUCT_ID_FOR_WIN_KEYBOARD=0x07a5;

hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID_FOR_WIN_KEYBOARD}" \
--set "{\"UserKeyMapping\":
  [
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_WIN_KEYBOARD_LEFT_CTRL,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_MAC_KEYBOARD_LEFT_COMMAND
    },
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_WIN_KEYBOARD_RIGHT_CTRL,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_MAC_KEYBOARD_RIGHT_COMMAND
    },
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_MAC_KEYBOARD_LEFT_COMMAND,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_WIN_KEYBOARD_LEFT_CTRL
    },
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_MAC_KEYBOARD_RIGHT_COMMAND,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_WIN_KEYBOARD_RIGHT_CTRL
    },

    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_WIN_KEYBOARD_LEFT_ALT,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_MAC_KEYBOARD_LEFT_OPTION
    },
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_WIN_KEYBOARD_RIGHT_ALT,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_MAC_KEYBOARD_RIGHT_OPTION
    },
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_MAC_KEYBOARD_LEFT_OPTION,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_WIN_KEYBOARD_LEFT_ALT
    },
    {
      \"HIDKeyboardModifierMappingSrc\":$DEFAULT_MAC_KEYBOARD_RIGHT_OPTION,
      \"HIDKeyboardModifierMappingDst\":$DEFAULT_WIN_KEYBOARD_RIGHT_ALT
    }
  ]
}"
```


## Reset/Undo
- See [keymap.os](./keymap.os.md#resetundo) doc


--------
# Checklist to verify keyboard shortcuts
|win Keyboard Shortcut|Action|
|---|---|
|`ALT` + `CTRL` + `SHIFT` + c|Format selection as code block|
|`ALT` + `left`|Move cursor to previous word|
|`ALT` + `right`|Move cursor to next word|
|`CTRL` + `+`|Increase font size|
|`CTRL` + `-`|Decrease font size|
|`CTRL` + `/`|Show shortcuts|
|`CTRL` + `end`|Move cursor to end of line|
|`CTRL` + `home`|Move cursor to start of line|
|`CTRL` + `meta` + `f`|Toggle full screen|
|`CTRL` + `n`|New message|
|`CTRL` + `SHIFT` + `k`|All DMs|
|`CTRL` + `SHIFT` + `t`|All Threads|
|`CTRL` + `z`|Undo|
|`SHIFT` + enter|Start new line (same message)|


# Other Resources
1. https://slack.com/help/articles/201374536-Slack-keyboard-shortcuts
1. https://www.howtogeek.com/670384/every-slack-keyboard-shortcut-and-how-to-use-them/
