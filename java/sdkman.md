# Overview
1. How to use [sdkman](https://sdkman.io/)
    1. to manage versions of jdk, kotlin, gradle, visualvm, ...


# Setup
1. Short: `curl -s "https://get.sdkman.io" | bash`
1. Long: [Official docs](https://sdkman.io/install)


# CLI: Enable sdkman commands
```sh
source "$HOME/.sdkman/bin/sdkman-init.sh"
```


# Update sdkman
1. Self update
```sh
sdk update;
```


# List sdks
```sh
sdk list gradle;
sdk list java;
sdk list kotlin;
sdk list visualvm;
```


# Install sdk
1. Fortunately, these commands are idempotent
```sh
sdk install gradle 7.5.1;
sdk install visualvm 2.1.4;

sdk install java 19-oracle;
sdk install java 19-open;

sdk install java 17.0.1-open;
sdk install java 17.0.3-oracle

sdk install java 22.2.r17-grl;

sdk install kotlin 1.7.20;
```


# List active versions
```sh
sdk current gradle;
sdk current java;
sdk current kotlin;
sdk current visualvm;
```


# List installed versions
```
ls -hl $HOME/.sdkman/candidates/java;
```


# Upgrade to latest
```sh
sdk upgrade java;
sdk upgrade gradle;
sdk upgrade kotlin;
sdk upgrade visualvm;
```


# Set/Get Default versions
```
sdk use java 17.0.1-open;
sdk default java 17.0.1-open;
```


# Uninstall/remove old versions
```
sdk uninstall java 11.0.8;
sdk uninstall java 14.0.2-open;
sdk uninstall java 14.0.2-zulu;
sdk uninstall java 15-open;
sdk uninstall java 15.0.0-zulu;
sdk uninstall java 8.0.265-open;
sdk uninstall java 8.0.265-zulu;
```


# Oracle versions
1. These might require login


# Other resources
1. https://www.oracle.com/java/technologies/javase-jdk11-downloads.html
1. https://openjdk.java.net/
1. https://sdkman.io/usage
1. https://github.com/sdkman/sdkman-cli
1. https://www.baeldung.com/java-sdkman-intro
