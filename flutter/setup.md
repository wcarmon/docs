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
```bash
brew install --cask flutter
```
1. Run doctor to verify install
```bash
flutter doctor;

# if there are issues
flutter doctor -v;
```


# windows
1. TODO


# Upgrade
1. `flutter upgrade`


# Devices setup
- Check `flutter devices`



# Other resources
