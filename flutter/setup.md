# Overview
1. How to setup flutter


# Android SDK
1. https://developer.android.com/about/versions/12/setup-sdk#install-sdk
1. Install command-line tools:
    1. Android Studio > SDK Manager > SDK Tools > Android SDK Command-line Tools


# Linux
```bash
apt install -y bash curl file git unzip xz-utils zip
apt install -y ninja-build libgtk-3-dev libglu1-mesa
```
1. Download from https://docs.flutter.dev/get-started/install/linux
1. Add to `PATH` (eg. ln -s /path/to/flutter/bin/{flutter,dart} $HOME/bin/)
```bash
flutter precache;
flutter config --no-analytics;
flutter doctor --android-licenses;
```
1. Find the path of `adb` & `sdkmanager`
    1. eg. `$HOME/Android/Sdk/platform-tools/adb`
    1. eg. `$HOME/Android/Sdk/tools/bin/sdkmanager`
1. Install & Find android studio path
- eg. Jetbrains installs into `$HOME/.local/share/JetBrains/Toolbox/apps/AndroidStudio/`
```bash
ANDROID_SDK_HOME=$HOME/Android/Sdk
ANDROID_STUDIO_HOME=$HOME/.local/share/JetBrains/Toolbox/apps/AndroidStudio/ch-0/212.5712.43.2112.8609683;

flutter config --android-sdk=$ANDROID_SDK_HOME;
flutter config --android-studio-dir $ANDROID_STUDIO_HOME;
```
1. Run doctor to verify install
```bash
flutter doctor -v;
```


# Mac
1. TODO


# windows
1. TODO


# Upgrade
1. `flutter upgrade`


# Devices setup
- Check `flutter devices`



# Other resources
