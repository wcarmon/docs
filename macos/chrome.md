# Overview


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
```

## Verify
```sh
defaults read com.google.Chrome | grep -A 10 NSUserKey;
```

# Other resources
