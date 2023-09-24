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
sdk install gradle 8.1.1;
sdk install visualvm 2.1.6;
sdk install kotlin 1.8.20;

# v20 based
sdk install java 20-open;
sdk install java 20-oracle;

# v19 based
sdk install java 22.3.1.r19-grl;

# v17 based
sdk install java 17.0.7-oracle;
sdk install java 22.3.2.r17-grl;
```

# List active versions

```sh
sdk current gradle;
sdk current java;
sdk current kotlin;
sdk current visualvm;
```

# Set current version

1. `use` sets version temporarily (for current shell)
1. `default` sets globally

```bash
sdk default java 20.0.1-oracle;
```

# List installed versions

```bash
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

# Other Resources

1. https://www.oracle.com/java/technologies/javase-jdk11-downloads.html
1. https://openjdk.java.net/
1. https://sdkman.io/usage
1. https://github.com/sdkman/sdkman-cli
1. https://www.baeldung.com/java-sdkman-intro
