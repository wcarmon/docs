# Overview

1. Using [Graal](https://www.graalvm.org/) to build native binaries
1. small executables and fast startup times
1. [Architecture](https://www.graalvm.org/22.1/docs/introduction/)

# Docker based

1. GraalVM

```bash
JDK_IMAGE=ghcr.io/graalvm/jdk-community:21
docker run -it --rm $JDK_IMAGE bash

env
java -version
```

1. Native Image

```bash
NATIVE_IMAGE=ghcr.io/graalvm/native-image-community:21
docker pull $NATIVE_IMAGE
# docker pull --platform linux/aarch64 $NATIVE_IMAGE
# docker pull --platform linux/amd64 $NATIVE_IMAGE

docker run -it --rm $NATIVE_IMAGE native-image --version
```

# Install

1. [via sdkman](https://sdkman.io/jdks)
    1. `sdk install java 22.1.0.r17-grl`
1. [Directly](https://www.graalvm.org/22.1/docs/getting-started/#install-graalvm)

# Dependencies

## Linux

```bash
sudo apt-get install build-essential libz-dev zlib1g-dev
```

# High level flow

1. Build an uber `*.jar`
1. use [`native-image`](https://www.graalvm.org/22.1/reference-manual/native-image/) to convert `*.jar` into native binary
1. Put the binary into a container via docker or similar

# [gu - GraalVM Updater](https://www.graalvm.org/22.1/reference-manual/graalvm-updater/)

1. [gu](https://www.graalvm.org/22.1/reference-manual/graalvm-updater/) is a program which installs/updates Graal components
1. [gu](https://www.graalvm.org/22.1/reference-manual/graalvm-updater/) comes with a graal installation
    1. Example: `sdk install java 22.1.0.r17-grl` (or latest version)
    1. Find: `find $HOME/.sdkman/candidates -name gu`
    1. Symlink: (`ln -s /path/to/gu $HOME/bin`)
1. [Add any ca-certificates](./cacerts.md), if needed
1. Verify install: `gu --version`
1. [`gu`](https://www.graalvm.org/22.1/reference-manual/graalvm-updater/) can install [`native-image`](https://www.graalvm.org/22.1/reference-manual/native-image/)
    1. `gu install native-image`

# [Native Image](https://www.graalvm.org/22.1/reference-manual/native-image/)

1. Install using `gu`
    1. `gu install native-image`
1. [`native-image`](https://www.graalvm.org/22.1/reference-manual/native-image/) is a program which builds binaries from `*.jar` and/or `*.class`
    1. Find: `find $HOME/.sdkman/candidates -name native-image`
    1. Symlink: `ln -s /path/to/native-image $HOME/bin`
1. Verify install: `native-image --version`

## Cross compile

1. OS & Arch combinations are $GRAAL_HOME/lib/svm/clibraries/
    - linux-amd64
    - darwin-aarch64
    - ...

## Set output path

```sh
native-image --target="linux-amd64" -jar foo.jar build/myBinary
```

# TODO: organize these:

- TODO: gu list
- TODO: Must have META-INF/MANIFEST.MF
- TODO: native-image: --initialize-at-build-time
- TODO: native-image: --no-fallback
- TODO: native-image: --trace-class-initialization
- TODO: native-image: -XX:+TraceClassLoading
- TODO: native-image: container: https://github.com/graalvm/container
- TODO: native-image: distroless: https://github.com/GoogleContainerTools/distroless
- TODO: native-image: gradle integration
- TODO: native-image: native-image.properties
- TODO: native-image: reports incompatible features
- TODO: native-image: substitutions for incompatible bytecode
- TODO: SubstrateVM
- TODO: Dashboard: https://www.graalvm.org/dashboard/

# Other Resources

1. TODO
