# Overview

1. TODO


# Limitations
1. visualvm [cannot profile **remote** apps](https://visualvm.github.io/applications_remote.html)


# Plugins

## Startup profiler
1. Helpful for short-lived apps & junit tests
1. Allows instrumentation from startup
1. Only works on local applications
1. Uses JMX agent internally
    1. enables taking heap dumps
1. Must use same (OS) user for profiler and the app 


### Usage
1. Start new process and profile its start
1. Point to the same JVM the app uses
1. Choose a port
1. Profile: memory or cpu
    1. Memory: defaults are fine
1. Copy cli flag for `-agentpath:...` 
1. Add `-agentpath:...` flag to jvm options for my java program
    1. eg. `/path/to/java -Dcom.sun.management.jmxremote -agentpath:/home/myself/.sdkman/candidates/visualvm/current/visualvm/lib/deployed/jdk16/linux-amd64/libprofilerinterface.so=/home/myself/.sdkman/candidates/visualvm/current/visualvm/lib,5140`
        1. linux uses `libprofilerinterface.so`
    1. eg. `/path/to/java.exe -Dcom.sun.management.jmxremote -agentpath:c:/Users/myself/opt/VisualVM/.../windows-amd64/profilerinterface.dll=c:\...\profiler\lib,5140 -jar app.jar`
        1. windows uses `profilerinterface.dll`
1. Click "Profile" button on lower right
1. VisualVM will wait for the app to connect
    1. "Connecting to the target VM..."
1. Start the application (with the flags above)


# gradle
1. TODO

```build.gradle.kts
...TODO
```

```build.gradle
tasks.test {
    jvmArgs = [
    ]
}
```


# gradle test
1. TODO


# Change font size

```bash
visualvm --fontsize 18
```

# Alternatives

## JProfiler
- $550 (one developer, installable on multiple machines)
- $2,200 (one active process at a time)


## Yourkit
- $550 (one machine)
- $2,750 (one active process at a time)


# Other Resources

1. TODO
