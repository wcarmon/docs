# Overview
1. Gradle overview


# Domain Model (Mental Model)

## Project
1. TODO
1. List Projects: `./gradlew projects --info -q` 


## Task
1. Unit of work
1. can be invoked (think function, method, process, ...)
1. can depend on other tasks
1. can be configured via scripting 
1. can be added thru plugins 
1. List Tasks: `./gradlew tasks -q`
1. eg. [`assemble`](TODO) task compiles and packages code into jar


## buildscript
1. executable script (kts for kotlin, or groovy by default)
1. `*.gradle.kt`: Kotlin buildscript  
1. `*.gradle`: Groovy buildscript  
1. most top level parts of `build.gradle.kts` are functions which accept a lambda
    1. eg. [`plugins { ... }`](TODO), 
    1. eg. [`application { ... }`](TODO),
    1. eg. [`dependencies { ... }`](TODO)
    1. eg. [`repositories { ... }`](TODO)


## Configuration
1. Each configuration has a set of dependencies
1. controls where dependency is used
1. like [Maven scope](TODO)
1. Can extend other configurations
1. List:
    1. Option-1: [`./gradlew outgoingVariants -q`](https://docs.gradle.org/current/userguide/variant_model.html)        
    1. Option-2:
        1. add this to `build.gradle.kts`: `configurations.forEach(::println)`
        1. run any gradle command (eg. `./gradlew projects -q`)
1. Common configurations include
    1. [`annotationProcessor`](TODO): used by annotation processor at compile time 
    1. [`api`](TODO): dependency is part of the public API of the current project
    1. [`compileOnly`](TODO): compile time, not runtime
    1. [`implementation`](TODO): available at compile time and runtime, extends api
    1. [`runtimeOnly`](TODO): available only at runtime (not compile time)
    1. [`testCompileOnly`](TODO): TODO
    1. [`testImplementation`](TODO): TODO
    1. [`testRuntimeOnly`](TODO):  extends `runtimeOnly`, only for running tests


## [Plugin](https://docs.gradle.org/current/userguide/plugins.html)
1. Plugins extend a project
1. Plugins can add tasks
1. Plugins can define new [`Configurations`](TODO)
1. Two types: [binary plugins](https://docs.gradle.org/current/userguide/plugins.html#sec:binary_plugins) and [script plugins](https://docs.gradle.org/current/userguide/plugins.html#sec:script_plugins)
1. Binary plugins can be in a buildscript, in the project hierarchy or in a plugin jar (external)
1. Plugins are **resolved** first, then **applied** to a `Project`
1. Resolve:
    1. Resolve: find correct version of jar containing plugin, and add jar to script classpath
    1. Script plugins self-resolve (from file-path or url)
    1. plugins that ship with gradle self resolve
1. Apply:  
    1. idempotent (can apply multiple times)
1. The [`plugin { ... }`](https://docs.gradle.org/current/userguide/plugins.html#sec:plugins_block) block resolves and applies to current project 
1. Gradle ships with a few plugins
1. Java support comes from the [`java-library`](TODO) plugin

1. eg. [`application`](TODO) plugin compiles and runs java apps (`./gradlew run`)
1. List: TODO



## Dependencies
1. TODO


## Component

## Variant



## Repository
1. TODO


# -----------------------------------------
# TODO


## dependency configuration
1. dependency configurations group dependencies
1. dependency configurations have FileCollection type
1. Configurations can extend from each other
1. Gradle plugins can add new configurations to our project
1. dependency configuration has a name and several properties



# Other resources
1. https://docs.gradle.org/current/userguide/variant_model.html#gradle_component_model
