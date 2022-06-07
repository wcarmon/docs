# Overview
- Configuring win keyboard for chrome on MacOS


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


## Reset/Undo
- See [keymap.os](./keymap.os.md#resetundo) doc


# Changing Keyboard shortcuts from Chrome (not recommended)
1. MacOS manages app shortcuts via System Preferences app
1. `System Preferences` > `Keyboard` > `Shortcuts` tab > `App Shortcuts` > `All Applications` > `+` button > `Google Chrome`
    1. `New Tab`: `^T`
    1. etc (see below)
1. Setting via terminal/shell/command-line:
```sh
defaults write com.google.Chrome NSUserKeyEquivalents {};
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Close Tag" "^w";
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "New Tab" "^t";
# TODO more here
```

## Verify
```sh
defaults read com.google.Chrome | grep -A 10 NSUserKey;
```

# Checklist to verify keyboard shortcuts
|win Keyboard Shortcut|Action|
|---|---|
|`CTRL` + `+`|Zoom in|
|`CTRL` + `-`|Zoom out|
|`CTRL` + `l`|Select Address bar|
|`CTRL` + `SHIFT` + `i`|Open developer tools|
|`CTRL` + `t`|Open new tab|
|`CTRL` + `w`|Close current tab|
|`SHIFT` + `space`|Move up screen|


# Other resources
1. https://support.google.com/chrome/answer/157179?hl=en&co=GENIE.Platform%3DDesktop
