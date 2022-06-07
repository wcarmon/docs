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
```sh
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID_FOR_WIN_KEYBOARD}" \
--set '{"UserKeyMapping":[]}';
```


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

# Quick checklist to verify keyboard shortcuts
|win Keyboard Shortcut|Behavior|
|---|---|
|`CTRL` + `+`|zoom in|
|`CTRL` + `-`|zoom out|
|`CTRL` + `l`|address bar|
|`CTRL` + `SHIFT` + `i`|open developer tools|
|`CTRL` + `t`|new tab|
|`CTRL` + `w`|close current tab|
|`SHIFT` + `space`|move up screen|


# Other resources
1. https://support.google.com/chrome/answer/157179?hl=en&co=GENIE.Platform%3DDesktop
