# Overview
- Configuring keyboard for chrome


# Keyboard shortcuts
1. MacOS manages app shortcuts via [System Preferences](TODO) app
1. `System Preferences` > `Keyboard` > `Shortcuts` tab > `App Shortcuts` > `All Applications` > `+` button > `Google Chrome`
    1. `New Tab`: ^T
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
|Shortcut|Behavior|
|---|---|
|`CTRL` + `+`|zoom in|
|`CTRL` + `-`|zoom out|
|`CTRL` + `l`|address bar|
|`CTRL` + `SHIFT` + `i`|open developer tools|
|`CTRL` + `t`|new tab|
|`CTRL` + w|close current tab|
|`SHIFT` + space|move up screen|


# Other resources
1. https://support.google.com/chrome/answer/157179?hl=en&co=GENIE.Platform%3DDesktop
