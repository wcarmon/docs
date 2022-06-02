# Overview
1. How to remap keys
1. How to use linux/windows keyboard with MacOS
1. Challenges of remapping keys


# Linux/windows keyboard on mac machine
## Keys worth remapping
1. Matching physical order relative to space bar

|Button|Default Behavior|Desired behavior|
|---|---|---|
|`ALT`|`option` (⌥) button|`command` (⌘)|
|`CTRL`|`control` (⌃) button|`option` (⌥)|
|`windows`|`command` (⌘) button|`control` (⌃)|
|`Insert`|Help button|TODO|

## Keys which are (roughly) the same
1. `enter` button -> `return` (⏎)
1. `esc` button
1. `shift` button (⇧)
1. `tab` button
1. `Backspace` -> `delete` (⌫)
1. `Delete` -> `delete` (Fn + ⌫)


# Remapping MacOS keys
1. Most cross platform apps have OS specific key maps (eg. Chrome, IDEA, Outlook, ...)

## Steps
1. System Preferences > Keyboard > Modifier Keys... (lower right)
1. Select the "windows" keyboard
    1. Control (⌃) Key: `⌘ Command`
    1. Option (⌥) Key: `⌃ Control`
    1. Command (⌘) Key: `⌥ Option`

## Via command line
1. Get relevant [keycodes](https://www.freebsddiary.org/APC/usb_hid_usages.php)
1. Get keyboard `Product id`
    1. Apple icon > `About This Mac` > `System Report` button > `Hardware` > `USB` > ...
    1. or `hidutil --list | grep -i microso` (or some unique string to identify your keyboad)
```sh
PRODUCT_ID=0x07a5;

readonly KEYBOARD_LEFT_ALT=0x7000000e2;
readonly KEYBOARD_META=0x7000000e3; # aka Left windows key, aka Left GUI key
readonly KEYBOARD_RIGHT_ALT=0x7000000e6;


KEYBOARD_LEFT_CTRL=0x7000000e0;    # TODO: verify
KEYBOARD_RIGHT_CTRL=0x7000000e4;   # TODO: verify
KEYBOARD_END=?


# KEYBOARD_LEFT_ALT -> ?
# KEYBOARD_LEFT_CTRL -> ?
# KEYBOARD_RIGHT_ALT -> ?
# KEYBOARD_RIGHT_CTRL -> ?
# END -> ?

hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID}" \
--set "{\"UserKeyMapping\":
  [
    {
      \"HIDKeyboardModifierMappingSrc\":$KEYBOARD_LEFT_ALT,
      \"HIDKeyboardModifierMappingDst\":0x700000067
    }
  ]
}"
```

### Verify
```sh
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID}" \
--get "UserKeyMapping";
```

### Undo/Reset
```sh
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID}" \
--set '{"UserKeyMapping":[]}';
```
- *or just restart*


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
- hidutil
- UserKeyMapping
- HIDKeyboardModifierMappingSrc
- `hidutil dump services`
- `~/Library/LaunchAgents/local.hidutilKeyMapping.plist`
- `hidutil property --get "UserKeyMapping"`
- `hidutil dump services`
- https://hidutil-generator.netlify.app/
- https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-KEY_TABLE_USAGES
- per device
```
hidutil property --matching '{"ProductID":0x123}' --set '{"UserKeyMapping":
 [{"HIDKeyboardModifierMappingSrc":0x700000054,
   "HIDKeyboardModifierMappingDst":0x700000067
 }]
}'
```
- Usb keyboard device id:
- `launchctl load`
- https://www.nanoant.com/mac/macos-function-key-remapping-with-hidutil
