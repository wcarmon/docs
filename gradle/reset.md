# Overview
1. How to safely reset a corrupt gradle project

# Clear global cache
```bash
gradle stop;

rm -rf $HOME/.gradle/.tmp;
rm -rf $HOME/.gradle/caches;
rm -rf $HOME/.gradle/daemon;
rm -rf $HOME/.gradle/jdks;
rm -rf $HOME/.gradle/native;
rm -rf $HOME/.gradle/notifications;
rm -rf $HOME/.gradle/workers;
rm -rf $HOME/.gradle/wrapper;
```


# Cleanup 1 gradle project
```bash
cd $PROJ_ROOT;

rm -vf ./gradlew
rm -vf ./gradlew.bat
rm -rf ./.gradle
rm -rf ./build
rm -rf ./gradle

mkdir -p src/{main,test}/{java,resources}

gradle init;
gradle wrapper;
```


# Other resources
1. TODO
