# Overview

- Configuring win keyboard shortcuts for chrome on MacOS

# Changing Keyboard shortcuts via hidutil

1. Open terminal
1. Define the key constants in [keymap.os](./keymap.os.md#steps-via-command-line) doc
1. Remap keyboard:
    1. See [keymap.os.md](./keymap.os.md) doc

## Reset/Undo

- See [keymap.os](./keymap.os.md#resetundo) doc

# Changing Keyboard shortcuts from Chrome (not recommended)
1. NOTE: Affects all keyboards
1. MacOS manages app shortcuts via System Preferences app
1. `System Preferences` > `Keyboard` > `Shortcuts` tab > `App Shortcuts` > `All Applications` > `+` button > `Google Chrome`
    1. `New Tab`: `^T`
    1. etc (see below)
1. Setting via terminal/shell/command-line:

- `~` means `option` or `⌥` key
- `@` means `command` or `⌘` key
- `^` means `control` or `^` key
```sh
defaults write com.google.Chrome NSUserKeyEquivalents {};
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Close Tab" "^w";
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "New Tab" "⌘t";
# TODO more here
```

## Verify

```sh
defaults read com.google.Chrome | grep -A 10 NSUserKey;
```

# Checklist to verify keyboard shortcuts

- The list below uses at-least-one of each special key combinations
- Mac:
    - `⌃`: control (only one, on the left, furthest from space bar)
    - `⌥`: option
    - `⌘`: command (closest to space bar)

| Linux/win shortcut     | Mac shortcut              | Action                                   |
|------------------------|---------------------------|------------------------------------------|
| `ALT` + `f`            |                           | Open chrome menu                         |
| `ALT` + `SHIFT` + `i`  | `⌘` + `⌥` + `shift` + `i` | Open feedback form                       |
| `ALT` + Home           | `⌘` + `shift` + `h`       | Open home page                           |
| `CTRL` + `+`           | `⌘` + `+`                 | Zoom in                                  |
| `CTRL` + `f`           | `⌘` + `f`                 | Find                                     |
| `CTRL` + `l`           | `⌘` + `l`                 | Select Address bar                       |
| `CTRL` + `SHIFT` + `i` | `⌘` + `⌥` + `i`           | Open developer tools                     |
| `CTRL` + `SHIFT` + `j` |                           | Open developer tools                     |
| `CTRL` + `t`           | `⌘` + `t`                 | Open new tab                             |
| `CTRL` + `w`           | `⌘` + `w`                 | Close current tab                        |
| `CTRL` + left          | `⌥` + left                | (in text) Jump to start of previous word |
| `CTRL` + right         | `⌥` + right               | (in text) Jump to end of current word    |
| Home                   | `⌘` + left                | (in text) Jump to start of text          |
| End                    | `⌘` + right               | (in text) Jump to end of text            |
| `SHIFT` + `space`      | (same)                    | Scroll up                                |

# Other Resources

1. Official Linux, win, Mac [keyboard shortcuts](https://support.google.com/chrome/answer/157179?hl=en&co=GENIE.Platform%3DDesktop)
1. https://www.edorozco.com/making-the-most-out-of-google-chrome/
