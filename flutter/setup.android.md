# Overview
1. Setting up Flutter for Android


# Android SDK
1. https://developer.android.com/about/versions/12/setup-sdk#install-sdk
1. Install command-line tools:
    1. Android Studio > SDK Manager > SDK Tools > Android SDK Command-line Tools
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


# Devices
1. Android Studio > Device Manager >

# Other resources
1. ...