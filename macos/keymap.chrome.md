# Overview

- Configuring win keyboard shortcuts for chrome on MacOS

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

- The list below uses at-least-one of each special key combinations
- Mac:
    - `⌃`: control
    - `⌘`: command
    - `⌥`: option

| Linux/win shortcut     | Mac shortcut    | Action                                   |
|------------------------|-----------------|------------------------------------------|
| `ALT` + `f`            |                 | Open chrome menu                         |
| `ALT` + `SHIFT` + i    |                 | Open feedback form                       |
| `ALT` + Home           |                 | Open home page                           |
| `CTRL` + `+`           |                 | Zoom in                                  |
| `CTRL` + `f`           | `⌘` + `f`       | Find                                     |
| `CTRL` + `l`           | `⌘` + `l`       | Select Address bar                       |
| `CTRL` + `SHIFT` + `i` | `⌘` + `⌥` + `i` | Open developer tools                     |
| `CTRL` + `SHIFT` + `j` |                 | Open developer tools                     |
| `CTRL` + `t`           |                 | Open new tab                             |
| `CTRL` + `w`           |                 | Close current tab                        |
| `CTRL` + left          |                 | (in text) Jump to start of previous word |
| `CTRL` + right         |                 | (in text) Jump to end of current word    |
| `SHIFT` + `space`      |                 | Scroll up                                |

# Other Resources

1. [Linux, win, Mac keyboard shortcuts](https://support.google.com/chrome/answer/157179?hl=en&co=GENIE.Platform%3DDesktop)
