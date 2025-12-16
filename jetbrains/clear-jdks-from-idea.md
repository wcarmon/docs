


# How to deal with corrupt JDK setup

1. Close Intellij
```sh
rm -rvf $HOME/.cache/JetBrains/IntelliJIdea*/caches
rm -vf $HOME/.config/JetBrains/IntelliJIdea*/options/jdk.table.xml
rm -vf $HOME/.config/JetBrains/IntelliJIdea*/workspace/*.xml
```
1. Start Intellij
