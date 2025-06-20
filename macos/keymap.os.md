# Overview

1. How to remap keys
1. How to use linux/windows keyboard with MacOS
1. Challenges of remapping keys

# Linux/windows keyboard on mac machine

# Keyboard Layout

## Linux/windows layout

| 0          | 1        | 2     | 3         | 4           |
|------------|----------|-------|-----------|-------------|
| left SHIFT |          |       |           | right SHIFT |
| left CTRL  | left ALT | SPACE | rigth ALT | right CTRL  |

## Apple layout

| 0            | 1           | 2            | 3     | 4             | 5            |
|--------------|-------------|--------------|-------|---------------|--------------|
| left shift   |             |              |       |               | right shift  |
| left control | left option | left command | space | right command | right option |

## Keys worth remapping

1. Matching physical order (relative to space bar)

| Linux/windows Keyboard Button | Default Behavior     | Desired behavior (based on location) | Location                     |
|-------------------------------|----------------------|--------------------------------------|------------------------------|
| `ALT`                         | `option` (⌥) button  | `command` (⌘)                        | Closest pair to space bar    |
| `CTRL`                        | `control` (⌃) button | `option` (⌥)                         | Furthest pair from space bar |
| `windows` key                 | `command` (⌘) button | `control` (⌃)                        | Only on, on the left         |
| `Insert`                      | Help button          | TODO                                 |                              |

- Unfortunately popular applications have different shortcuts for different OS (eg. Chrome, Slack, etc)

## Keys which are (roughly) the same location and functionality

| Linux/win   | Mac               |
|-------------|-------------------|
| `Backspace` | `delete` (⌫)      |
| `Delete`    | `delete` (Fn + ⌫) |
| `enter`     | `return` (⏎)      |
| `esc`       |                   |
| `shift`     | (⇧)               |
| `tab`       |                   |


# OS keyboard shortcuts to disable (to avoid conflicts with development tools)
- System Settings > Keyboard shortcuts 

## Launchpad & Dock
- Disable all

## Display
- Disable all (since they are mapped to F14 and F15 which the native keyboard lacks)

## Mission Control
- Disable all

## Windows

### Windows > General
- Disable Minimize

## Keyboard
- Disable all
- (at a minimum) Uncheck all the ones related to `Move focus *`

## Input Sources
- Disable all

## Screenshots
- Only Keep ...
    - "Save picture of screen as file"
    - "Screenshot and recording options"

## Presenter Overlay
- Disable all


## Services
- Disable all

## Spotlight
- Retain all


## Accessibility
- Disable all


## App Shortcuts
- Disable all


## Function Keys
- Toggle **on**
    - This avoids conflicts with vscode and cursor
    - So you'll use `fn + F11`, and `fn + F12` for audio controls


## Modifier Keys
- (no changes)


# Remapping MacOS keys

1. Most cross platform apps have OS specific key maps (eg. Chrome, IDEA, Outlook, ...)
1. Use [BetterTouchTool](https://folivora.ai/)


# Other keyboard settings

1. `System Preferences` > `Keyboard` > `Text` tab
    1. uncheck `Use smart quotes and dashes`
1. `System Preferences` > `Keyboard` > `Text Input` > `Text Replacements`    
    1. remove any replacements


# Trackpad
1. Disable Dictionary
    1. Settings > Trackpad > Trackpad Gestures > Point & Click
        1. Look up & data detectors: Off


# Disable greek letters for option key

1. `System Preferences` > `Keyboard` > `Input Sources` Tab
1. click `+` at bottom left
1. add and select `Other` > `Unicode Hex Input`
1. In top menu, on right, change input source to `U+`
1. TODO: this doesn't help anymore


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
