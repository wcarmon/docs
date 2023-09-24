# Overview

1. How Java/JVM agents work
1. See also [asm/byte buddy doc](./bytecode_asm_aspects.md)

# Key points

1. Agents can make arbitrary mutations to class files (even those already loaded)
1. Agents can generate new class files
1. Agents are deployed as **jar** files (so you must build them first)
1. JVM allows multiple agents, executed in order specified on command line
    1. TODO: how to do multiple when packaged (approach 3)
1. You specify Agent class in `src/main/resources/META-INF/MANIFEST.MF`
    1. attributes depend on approach, see below
1. There are 3 ways to load agent
    1. Approach-1: Command line
    1. Approach-2: Attach to running JVM
    1. Approach-3: Bundled/Packaged with the application (into same Jar)

# Approach-1: Command line

```bash
java -javaagent:/path/to/jar ...

java -javaagent:/path/to/jar=option1 ...   <-- TODO: better example
```

1. `MANIFEST.MF` must contain [`Premain-Class` attribute](https://docs.oracle.com/en/java/javase/20/docs/api/java.instrument/java/lang/instrument/package-summary.html#manifest-attributes-heading)
1. `Premain-Class` attribute must point to a class with `public static void premain(String agentArgs, Instrumentation inst) {` method
    1. Intellij will enforce
1. Any code which is legal for `public static void main(...)` is legal for `public static void premain(...)`

# Approach-2: Attach to running JVM

1. TODO

# Approach-3: Bundled/Packaged with the application

1. `MANIFEST.MF` must contain [`Launcher-Agent-Class` attribute](https://docs.oracle.com/en/java/javase/20/docs/api/java.instrument/java/lang/instrument/package-summary.html#manifest-attributes-heading)
1. `Launcher-Agent-Class` attribute must point to a class with `public static void agentmain(String agentArgs, Instrumentation inst) {` method
    1. Intellij will enforce
1. JVM invokes `agentmain(...)` method before `main(...)` method

# [Classloaders](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/ClassLoader.html)

1. [BootstrapClassLoader](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/ClassLoader.html)
    1. has no parent
1. PlatformClassLoader
    1. Loads JDK
1. [System Class loader == AppClassLoader](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/ClassLoader.html#getSystemClassLoader())
    1. Loads your application classes

# Errors/Exceptions

- [`ClassNotFoundException`](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/ClassNotFoundException.html): JVM cannot find definition for class
- [`NoClassDefFoundError`](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/NoClassDefFoundError.html): JVM aware of the class, it existed previously, but cannot find definition/code anymore

# Gotchas

- Debugging `premain` doesn't work

# Other resources

1. https://docs.oracle.com/en/java/javase/20/docs/api/java.instrument/java/lang/instrument/package-summary.html
