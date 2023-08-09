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

# Approach-2: Attach to running JVM

# Approach-3: Bundled/Packaged with the application



# Classloaders
1. BootstrapClassLoader
1. PlatformClassLoader
1. AppClassLoader


# Errors/Exceptions
- [`ClassNotFoundException`](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/ClassNotFoundException.html): JVM cannot find definition for class
- [`NoClassDefFoundError`](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/lang/NoClassDefFoundError.html): JVM aware of the class, it existed previously, but cannot find definition/code anymore


# Other resources
1. https://docs.oracle.com/en/java/javase/20/docs/api/java.instrument/java/lang/instrument/package-summary.html