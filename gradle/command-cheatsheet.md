# Overview
1. Frequently used commands for [gradle](https://gradle.org/) 6+


# Commands
1. Assuming working diretory is `$PROJ_ROOT` (dir containing `build.gradle.kts`)


## Setup, Init, Upgrade
```
gradle init
gradle wrapper --gradle-version 7.4.2
gradle wrapper

# -- Upgrade
./gradlew wrapper --gradle-version=7.4.2 --distribution-type=all
./gradlew wrapper --gradle-version=7.3.3 --distribution-type=bin
```


## Building
```sh
./gradlew build --info
./gradlew build --quiet
./gradlew build --scan
./gradlew build --warn
./gradlew build --warning-mode all
./gradlew build -Dorg.gradle.debug=true
./gradlew build -x test

# -- Clean first
./gradlew clean build -q
./gradlew clean build -x detekt -x test -q
./gradlew clean build --exclude-task test -q
```


## Dependencies
```sh
./gradlew dependencies -q


# -- For one configuration
./gradlew dependencies --configuration compileOnly -q
./gradlew dependencies --configuration runtimeClasspath -q
./gradlew dependencies --configuration runtimeOnly -q
./gradlew dependencies --configuration testCompileOnly


# -- List outdated/old deps
./gradlew dependencyUpdates -q
./gradlew dependencyUpdates
./gradlew dependencyUpdates --refresh-dependencies --quiet


# -- For one module
./gradlew module-123:dependencies -q
./gradlew module-123:dependencies --configuration runtimeClasspath --quiet
```


## Auto Formatting
```sh
./gradlew spotlessApply -q
./gradlew spotlessCheck
./gradlew clean build spotlessApply -x test -q
```


## Static analysis
```sh
# "check" runs pmd tasks
./gradlew check
./gradlew check -q
./gradlew clean build sonarqube -x test -q

./gradlew detekt -q

./gradlew detektMain -q --continuous
./gradlew detektMain -q

./gradlew detektTest -q
```


## Testing
```sh
./gradlew test -i
./gradlew test
```


## Packaging
```sh
./gradlew jar
```


## [Protocol Buffers](https://developers.google.com/protocol-buffers)
```sh
./gradlew generateProto -q
./gradlew clean build generateProto -x test -q
```


## Clearing cache
```sh
rm -rf $HOME/.gradle/caches/modules-2/files-2.1/*
```


## Spring boot
```sh
./gradlew my-sb-module:build my-sb-module:bootRun
```


## Deploy
```sh
./gradlew deploy --exclude-task test
```


## Debugging gradle
```sh
./gradlew --version
./gradlew buildEnvironment
./gradlew model
./gradlew projects
./gradlew properties
./gradlew tasks --all -q
./gradlew --stop
```


# Other resources
1. TODO...
