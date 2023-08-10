# Overview
1. How to use swing debugging tools


--------
# [SwingExplorer](https://github.com/swingexplorer/swingexplorer)
1. add to `build.gradle.kts`: `implementation("org.swingexplorer:swingexplorer-core")`
1. Find path of javaassist jar
1. Find path of swingexplorer agent jar
1. See [runner script](../bash/examples/jvm/run_with_swingexplorer.sh)

## Extras
1. See also [git repo](https://github.com/swingexplorer/swingexplorer/tree/master)
1. See also [maven repo](https://mvnrepository.com/artifact/org.swingexplorer/swingexplorer-core/1.7.0)
1. See also: [Jetbrains plugin](https://plugins.jetbrains.com/plugin/8385-swingexplorer-integration-v2) (I don't know how to use)



--------
# [JSpy](https://github.com/nokia/jspy)
1. ... TODO: no maven artifact :-(


--------
# [SwingSpy](https://github.com/igr/swingspy)
1. TODO: module stuff: --add-opens java.desktop/javax.swing=ALL-UNNAMED

## Download
1. [Download jar from maven](https://mvnrepository.com/artifact/org.jodd/jodd-swingspy/3.9)
1. Install into `main`
```java
    try {
        Class.forName("jodd.swingspy.SwingSpy").getMethod("install").invoke(null);

    } catch (Exception ex) {
        System.err.println("SwingSpy is not installed... " + ex);
    }
```
1. Run the app
1. CTRL + SHIFT + Click

