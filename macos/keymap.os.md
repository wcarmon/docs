# Overview

1. How to remap keys
1. How to use linux/windows keyboard with MacOS
1. Challenges of remapping keys

# Linux/windows keyboard on mac machine

## Keys worth remapping

1. Matching physical order relative to space bar

| windows Keyboard Button | Default Behavior     | Desired behavior (based on location) |
|-------------------------|----------------------|--------------------------------------|
| `ALT`                   | `option` (⌥) button  | `command` (⌘)                        |
| `CTRL`                  | `control` (⌃) button | `option` (⌥)                         |
| `windows`               | `command` (⌘) button | `control` (⌃)                        |
| `Insert`                | Help button          | TODO                                 |

## Keys which are (roughly) the same location and functionality

1. `enter` button -> `return` (⏎)
1. `esc` button
1. `shift` button (⇧)
1. `tab` button
1. `Backspace` -> `delete` (⌫)
1. `Delete` -> `delete` (Fn + ⌫)

# Remapping MacOS keys

1. Most cross platform apps have OS specific key maps (eg. Chrome, IDEA, Outlook, ...)

## Steps: Via command line

1. Get relevant [keycodes](https://www.freebsddiary.org/APC/usb_hid_usages.php)

```
readonly DEFAULT_MAC_KEYBOARD_CONTROL=0x7000000e0;
readonly DEFAULT_MAC_KEYBOARD_DELETE=0x70000002a;
readonly DEFAULT_MAC_KEYBOARD_LEFT_COMMAND=0x7000000e3;
readonly DEFAULT_MAC_KEYBOARD_LEFT_OPTION=0x7000000e2;
readonly DEFAULT_MAC_KEYBOARD_LEFT_SHIFT=0x7000000e1;
readonly DEFAULT_MAC_KEYBOARD_RIGHT_COMMAND=0x7000000e7;
readonly DEFAULT_MAC_KEYBOARD_RIGHT_OPTION=0x7000000e6;
readonly DEFAULT_MAC_KEYBOARD_RIGHT_SHIFT=0x7000000e5;
#readonly DEFAULT_MAC_KEYBOARD_FN=TODO;
# DEFAULT_MAC_KEYBOARD_INSERT=?? 62?  49?

readonly DEFAULT_WIN_KEYBOARD_BACKSPACE=0x70000002a;
readonly DEFAULT_WIN_KEYBOARD_DELETE=0x70000004c;
readonly DEFAULT_WIN_KEYBOARD_END=0x70000004d;
readonly DEFAULT_WIN_KEYBOARD_HOME=0x70000004a;
readonly DEFAULT_WIN_KEYBOARD_INSERT=0x700000049;
readonly DEFAULT_WIN_KEYBOARD_LEFT_ALT=0x7000000e2;
readonly DEFAULT_WIN_KEYBOARD_LEFT_CTRL=0x7000000e0;
readonly DEFAULT_WIN_KEYBOARD_LEFT_SHIFT=0x7000000e1;
readonly DEFAULT_WIN_KEYBOARD_META=0x7000000e3; # aka Left windows key, aka Left GUI key
readonly DEFAULT_WIN_KEYBOARD_RIGHT_ALT=0x7000000e6;
readonly DEFAULT_WIN_KEYBOARD_RIGHT_CTRL=0x7000000e4;
readonly DEFAULT_WIN_KEYBOARD_RIGHT_SHIFT=0x7000000e5;
```

2. Get keyboard `Product id`
    1. Apple icon > `About This Mac` > `System Report` button > `Hardware` > `USB` > ...
    1. or `hidutil list | grep -i microso` (or some unique string to identify your keyboad)
        1. See the **2nd** column

```sh
PRODUCT_ID_FOR_WIN_KEYBOARD=0x07a5;

# -- remap just one keyboard
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

### Verify

```sh
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID_FOR_WIN_KEYBOARD}" \
--get "UserKeyMapping";
```

1. `ALT+CTRL+?`: TODO
1. `ALT+SHIFT+?`: TODO
1. `ALT+Tab`: switch window
1. `CTRL+Right`: jump to next word
1. `CTRL+SHIFT+Right`: highlight next word
1. `CTRL+SHIFT+Z`: redo
1. `CTRL+Z`: undo
1. `SHIFT+Right`: highlight next char
1. TODO: Quit an app
1. TODO: Spotlight

### Reset/Undo

```sh
# -- Reset just one keyboard
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID_FOR_WIN_KEYBOARD}" \
--set '{"UserKeyMapping":[]}';

# -- Reset all keyboards
hidutil property --set '{"UserKeyMapping":[]}';
```

- *or just restart the machine*

# Disable greek letters for option key

1. `System Preferences` > `Keyboard` > `Input Sources` Tab
1. click `+` at bottom left
1. add and select `Other` > `Unicode Hex Input`
1. In top menu, on right, change input source to `U+`

# Other keyboard settings

1. `System Preferences` > `Keyboard` > `Text` tab
    1. uncheck `Use smart quotes and dashes`
    1. remove any replacements

# Disable VoiceOver

1. `System Preferences` > `Keyboard` > `Shortcuts` > `Accessibility` > `Turn VoiceOver on or off`
    1. Conflicts with some jetbrains shortcuts

# Other Resources

1. https://9to5mac.com/2016/03/17/how-to-remap-windows-keyboard-buttons-match-mac-layout/
1. https://www.lifewire.com/what-are-windows-keyboard-equivalents-to-mac-2260203
1. https://defkey.com/what-means
1. https://hidutil-generator.netlify.app/
1. https://www.manpagez.com/man/1/hidutil/
1. https://www.nanoant.com/mac/macos-function-key-remapping-with-hidutil
1. https://www.freebsddiary.org/APC/usb_hid_usages.php
1. https://developer.apple.com/library/archive/technotes/tn2450/_index.html
1. https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/

--------

# TODO: organize

- `~/Library/LaunchAgents/local.hidutilKeyMapping.plist`
- `launchctl load`
- IOHIDKeyboardFilter
