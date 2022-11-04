# Overview
1. How to setup flutter


# Android
1. see [android doc](./setup.android.md)


# Linux (Desktop)
```bash
apt install -y bash curl file git unzip xz-utils zip
apt install -y ninja-build libgtk-3-dev libglu1-mesa
```
1. Download from https://docs.flutter.dev/get-started/install/linux
```bash
FLUTTER_SDK=~/opt/flutter
mkdir -p $FLUTTER_SDK
cd $FLUTTER_SDK
tar xf ~/Downloads/flutter_linux_*-stable.tar.xz
```
1. Add flutter & dart to `PATH`
```bash
ln -s --force $FLUTTER_SDK/bin/{flutter,dart} $HOME/bin/
ls -l $HOME/bin/ | grep flutter
```
1. Verify install
```bash
flutter precache;
flutter config --no-analytics;
flutter doctor --android-licenses;
```
1. Run doctor to verify install
```bash
flutter doctor;

# if there are issues
flutter doctor -v;
```


# Mac
1. Install via [brew](https://brew.sh/)
```bash
brew install --cask flutter
```
1. Install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html)
```bash
brew install cocoapods;
```
1. Allow the binaries to run: see [macos doc](../macos/unverified-binaries.md)
    1. Try to run `flutter` or `dart`
    1. Apple menu > System Preferences > Security & Privacy > General
    1. On the bottom, find the failed `flutter` execution (or `dart`)
    1. [Click `Allow Anyway` button](https://www.alphr.com/cannot-be-opened-because-the-developer-cannot-be-verified/)

1. Run doctor to verify install
```bash
flutter doctor;

# if there are issues
flutter doctor -v;
```


# windows
1. TODO


# Upgrade
1.
```bash
flutter upgrade;
dart pub outdated;
dart pub upgrade;
flutter clean;
```


# Devices setup
- Check `flutter devices`


# Create an app
```
flutter create ...
```
1. https://docs.flutter.dev/get-started/codelab


# Other Resources
1. https://docs.flutter.dev/get-started/install
1. https://docs.flutter.dev/get-started/editor
1. https://docs.flutter.dev/get-started/codelab