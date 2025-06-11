# Overview
1. Setting up Flutter for Android


# Android SDK
1. https://developer.android.com/about/versions/12/setup-sdk#install-sdk
1. Install command-line tools:
    1. Android Studio > SDK Manager > SDK Tools > Android SDK Command-line Tools
1. Find the path of `adb` (or `sdkmanager`)
    1. see scripts below
1. Find android studio path
- eg. JetBrains installs into `$HOME/.local/share/JetBrains/Toolbox/apps/AndroidStudio/`
```bash
ANDROID_SDK_HOME="$(dirname $(dirname $(find $HOME -type f -name "adb" 2>/dev/null | sort --reverse | head -1)))"

# Verify: file must exist: $ANDROID_SDK_HOME/platform-tools/adb
ls -hl $ANDROID_SDK_HOME/platform-tools/adb;


ANDROID_STUDIO_HOME="$(dirname $(dirname $(find $HOME -type f -name "studio.sh" 2>/dev/null | sort --reverse | head -1)))"

# Verify: file must exist: `$ANDROID_STUDIO_HOME/bin/studio.sh`
ls -hl $ANDROID_STUDIO_HOME/bin/studio.sh;
```
1. Configure flutter to use paths
```bash
flutter config --android-sdk=$ANDROID_SDK_HOME;
flutter config --android-studio-dir=$ANDROID_STUDIO_HOME;

# Verify
flutter doctor;
```


# Devices
1. Android Studio > Device Manager >

# Other Resources
1. ...