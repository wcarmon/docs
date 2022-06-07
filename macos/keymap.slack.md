# Overview
- Configuring Keyboard shortcuts for [slack](https://slack.com/)


# Changing Keyboard shortcuts via hidutil
1. Open terminal
1. Define the key constants in [keymap.os](./keymap.os.md) doc
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
    }
  ]
}"
```


# Checklist to verify keyboard shortcuts
|win Keyboard Shortcut|Action|
|---|---|
|`ALT` + `+`|increase font size|
|`ALT` + `-`|decrease font size|
|`ALT` + `/`|show shortcuts|
|`ALT` + `CTRL` + `f`|Toggle full screen|
|`ALT` + `CTRL` + `SHIFT` + c|Format selection as code block|
|`ALT` + `n`|new message|
|`ALT` + `SHIFT` + `k`|All DMs|
|`ALT` + `SHIFT` + `t`|All Threads|
|`CTRL` + `left`|Move cursor to previous word|
|`CTRL` + `right`|Move cursor to next word|
|`end`|Move cursor to end of line|
|`home`|Move cursor to start of line|
|`SHIFT` + enter|Start new line (same message)|


# Other resources
