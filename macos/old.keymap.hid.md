# Overview
1. Old advice on how to remap keyboard using hidutil
1. Use [BetterTouchTool](https://folivora.ai/) instead


# ~~Steps: Via command line~~

1. Make constants for each relevant [keycode](https://www.freebsddiary.org/APC/usb_hid_usages.php)

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
    1. or `hidutil list | grep -i microso` (or some unique string to identify your keyboard)
        1. See the **2nd** column

3. Remap
    1. See [example-1](./keyboard-remap-1.sh)
    1. See [example-2](./keyboard-remap-2.sh)


## Verify

```sh
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID_FOR_WIN_KEYBOARD}" \
--get "UserKeyMapping";
```

# Reset/Undo

```sh
# -- Reset just one keyboard
hidutil property \
--matching "{\"ProductID\":$PRODUCT_ID_FOR_WIN_KEYBOARD}" \
--set '{"UserKeyMapping":[]}';

# -- Reset all keyboards
hidutil property --set '{"UserKeyMapping":[]}';
```

- *or just restart the machine*
