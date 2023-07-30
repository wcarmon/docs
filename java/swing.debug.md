# Overview
1. TODO


--------
# [SwingExplorer](https://github.com/swingexplorer/swingexplorer)

1. Clone repo
```bash
mkdir -p $HOME/git-repos/external;
cd $HOME/git-repos/external;
git clone https://github.com/swingexplorer/swingexplorer.git
cd swingexplorer/src/dist-files/bin
ln -sv $(readlink -f ./swexpl) $HOME/bin/
```
1. See [command line args](https://github.com/swingexplorer/swingexplorer/blob/7539add39b8b6741f59baab87a4034778c782113/src/dist-files/bin/swexpl)
1. Make a gradle task:
```kts

```
1. See also [git repo](https://github.com/swingexplorer/swingexplorer/tree/master)
1. See also [maven repo](https://mvnrepository.com/artifact/org.swingexplorer/swingexplorer-core/1.7.0)
1. See also: [Jetbrains plugin](https://plugins.jetbrains.com/plugin/8385-swingexplorer-integration-v2) (I don't know how to use)


--------
# [SwingSpy](https://github.com/igr/swingspy)

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
1. TODO: module stuff: opens java.desktop/javax.swing=ALL-UNNAMED
1. Run the app
1. CTRL + SHIFT + Click


# Other resources
1. TODO