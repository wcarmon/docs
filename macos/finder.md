# Overview
1. Making finder more developer friendly


# Library dir, Path in title, Hidden dirs

```sh
defaults write com.apple.Finder AppleShowAllFiles true;
defaults write -g NSFullScreenDarkMenu -bool true;
defaults write -g NSAutomaticWindowAnimationsEnabled -bool true;
defaults write com.apple.dock expose-animation-duration -float 0.18;
defaults write com.apple.finder PathBarRootAtHome -bool true;
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;
defaults write com.apple.finder QuitMenuItem true;
defaults write -g ApplePressAndHoldEnabled -bool false;
chflags nohidden ~/library/;
cupsctl WebInterface=yes;
killall Dock;
killall Finder;
```


# Exposing `~/Library` directory
1. Most apps try to hide `~/Library`
1. Create a symlink so can always access:
```sh
ln -s ~/Library ~/lib;
```
1. Alternative: Use: `command` + `shift` + dot


# Open file dialog

## Show hidden directories (like ~/Library)
1. `command` + `shift` + dot == `⌘ ⇧ .`

## Paste url into open dialog
- `command` + `shift` + `g` == `⌘ ⇧ g`


# Other Resources

