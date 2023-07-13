# Overview
1. Gradle overview


# Model

## Project
1. TODO

## Task
1. Unit of work
1. can be invoked (think function, method, process, ...)
1. can depend on other tasks
1. can be configured via scripting 
1. can be added thru plugins 
1. List tasks: `./gradlew tasks -q`
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


## Plugin
1. Gradle ships with a few plugins
1. Java support comes from the [`java-library`](TODO) plugin
1. Plugins can add tasks
1. eg. [`application`](TODO) compiles and runs java apps (`./gradlew run`)
1. Can define new [`Configurations`](TODO)


## Dependencies
1. `implementation`: available at compile time and runtime
1. `runtimeOnly`: available only at runtime (not compile time)
1. `api`: dependency is part of the public API of the current project


# -----------------------------------------
# TODO

## Mental model
1. Task
    1. 
    
1. Plugin    

1. Project    

1. Repository
    

## dependency configuration
1. dependency configurations group dependencies
1. dependency configurations have FileCollection type
1. Configurations can extend from each other
1. Gradle plugins can add new configurations to our project
1. dependency configuration has a name and several properties



# Other resources
1. TODO
