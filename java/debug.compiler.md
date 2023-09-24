# Overview

1. How to debug Java compiler & Annotation processor

# Run compiler via IDEA

1. Enable `Debug Build Process`
1. File | Settings | Build, Execution, Deployment | Build Tools | Gradle
    1. Build and run using: `IDEA`
1. File | Settings | Build, Execution, Deployment | Compiler | Annotation Processors
    1. Enable Annotation Processor
1. Create [debug configuration](https://www.jetbrains.com/help/idea/tutorial-remote-debug.html#96630f1f)
    1. [Remote JVM Debug](https://www.jetbrains.com/help/idea/tutorial-remote-debug.html#debugger_rc)
    1. Name/Label: Use something like `Debug Java compiler`
1. Add breakpoint in annotation processor
    1. eg. `lombok.launch.AnnotationProcessorHider.AnnotationProcessor::init`
1. Build (`CTRL`+`F9`)
    1. The console shows a message like:

```
Executing pre-compile tasks…
Build: waiting for debugger connection on port 44355
```
