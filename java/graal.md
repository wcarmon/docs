# Overview
1. Using [Graal](https://www.graalvm.org/) to build native binaries
1. small executables and fast startup times
1. [Architecture](https://www.graalvm.org/22.1/docs/introduction/)


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
1. Build a `*.jar`
1. use [`native-image`](https://www.graalvm.org/22.1/reference-manual/native-image/) to convert `*.jar` into native binary
1. Put the binary into a container via docker or similar


# gu - GraalVM Updater
1. [gu](https://www.graalvm.org/22.1/reference-manual/graalvm-updater/) comes with a graal installation
    1. `sdk install java 22.1.0.r17-grl`
    1. See `$HOME/.sdkman/candidates/java/current/bin/gu` (if graal is your default jvm)
    1. Or else run `find $HOME/.sdkman/candidates -name gu`
    1. symlink: (`ln -s /path/to/gu ~/bin/gu`)
1. [`gu`](https://www.graalvm.org/22.1/reference-manual/graalvm-updater/) can install [`native-image`](https://www.graalvm.org/22.1/reference-manual/native-image/)


# Native Image
1. [`native-image`](https://www.graalvm.org/22.1/reference-manual/native-image/) builds binaries from `*.jar` and/or `*.class`
    1.
    1. See `$HOME/.sdkman/candidates/java/current/bin/native-image`


- TODO: SubstrateVM
- TODO: native-image: -XX:+TraceClassLoading
- TODO: native-image: --initialize-at-build-time
- TODO: native-image: distroless: https://github.com/GoogleContainerTools/distroless
- TODO: native-image: container: https://github.com/graalvm/container
- TODO: native-image: --no-fallback
- TODO: native-image: --trace-class-initialization
- TODO: native-image: gradle integration
- TODO: native-image: native-image.properties
- TODO: gu list
- TODO: gu install native-image
- TODO: install "gu"
- TODO: Must have META-INF/MANIFEST.MF
- TODO: native-image: reports incompatible features
- TODO: native-image: substitutions for incompatible bytecode
- TODO: Dashboard: https://www.graalvm.org/dashboard/

# Other resources
