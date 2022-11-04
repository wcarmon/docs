# Overview
- Configuring win keyboard for built-in terminal app on MacOS


# Changing Keyboard shortcuts via hidutil
1. Open terminal
1. Define the key constants in [keymap.os](./keymap.os.md#steps-via-command-line) doc
1. Remap keyboard:
```sh
PRODUCT_ID_FOR_WIN_KEYBOARD=0x07a5;

# TODO: more here
```


# Changing Keyboard shortcuts from iterm
1. TODO


# Checklist to verify keyboard shortcuts
1. See [iterm2](./keymap.iterm2.md) doc


- TODO: global hotkey like guake (F12)


# Other Resources
1. https://www.makeuseof.com/linux-bash-terminal-shortcuts/
1. https://www.redhat.com/sysadmin/top-10-shortcuts
