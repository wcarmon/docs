# Overview
1. Java 9+ modules


# Key points
1. Modules always end up being a waste of time because popular 3rd party libs haven't adopted them (eg. Netty, Google, ...).
1. a module contains one or more packages
1. a module [`exports`](TODO) packages
1. a module depends on other modules via [`requires`](TODO)
1. (unlike packages) modules have no hierarchy
    1. names are just names (similar to golang packages)
1. `--add-exports`: only public members accessible
1. `--add-opens`:
    1. even private members accessible thru reflection (eg. `Field::setAccessible(true)`)
    1. Runtime concern, not compile time
1. `--patch-module`: merges all classes from an artifact into a module (helps fix split packages)

# New abilities
1. Hiding packages from other modules
1. Fine grained control over access at runtime (Reflection too)
1. Granular JVM
1. Faster startup


# Gotchas
## Split packages
1. eg. jsr305, replace with jetbrains annotations package
1. Sometimes split package issues manifest with unrelated error messages
1. `--patch-module name.of.module=path/to/my.jar` might help
    1. also requires an `--add-modules` step
1. `--upgrade-module-path` might help

## Google libs tend not to have `module-info.java`
    1. eg. [google.cloud.storage](https://mvnrepository.com/artifact/com.google.cloud/google-cloud-storage)


# TODO:
- TODO: "legacy" jars
- TODO: classpath
- TODO: jdeps
- TODO: gradle
- TODO: modulepath
- TODO: naming (chars, length, ...)
- TODO: unused required (Intellij)
- TODO: open
- TODO: opens
- TODO: transitive


# Other resources
1. TODO