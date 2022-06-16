# Overview
1. [Graal](https://www.graalvm.org/) allows compiling java to native
1. [bytecode](TODO) to native code
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

- TODO: SubstrateVM
- TODO: native-image
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
- TODO: $HOME/.sdkman/candidates/java/current/bin/native-image
- TODO: install "gu"
- TODO: Must have META-INF/MANIFEST.MF
- TODO: native-image: reports incompatible features
- TODO: native-image: substitutions for incompatible bytecode
- TODO: Dashboard: https://www.graalvm.org/dashboard/

# Other resources
