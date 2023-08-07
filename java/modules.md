# Overview
1. Java 9+ modules


# Key points
1. a module contains one or more packages
1. a module [`exports`](TODO) packages
1. a module depends on other modules via [`requires`](TODO)


# New abilities
1. Hiding packages from other modules
1. Fine grained control over access at runtime (Reflection too)


# Gotchas
1. Split packages
    1. eg. jsr305, replace with jetbrains annotations package
    1. Sometimes split package issues manifest with unrelated error messages
1. Granular JVM
1. Faster startup


- TODO: "legacy" jars
- TODO: classpath
- TODO: jdeps
- TODO: gradle
- TODO: modulepath
- TODO: naming
- TODO: unused required (Intellij)
- TODO: open
- TODO: opens
- TODO: transitive


# Other resources
1. TODO