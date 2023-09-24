# Overview

1. How to efficiently watch a directory for modified, added, removed files

# Example (Java 11+)

```java
    final var dirToWatch = ...;

    checkArgument(Files.isDirectory(dirToWatch), "directory required: " + dirToWatch);

    final var watchService = FileSystems.getDefault().newWatchService();
    dirToWatch.register(
            watchService,
            // TODO: Remove any operations you don't care about
            StandardWatchEventKinds.ENTRY_CREATE,
            StandardWatchEventKinds.ENTRY_DELETE,
            StandardWatchEventKinds.ENTRY_MODIFY);

    // TODO: run this part in a separate thread, (eg. in ExecutorService)

    while (true) {

        // NOTE: WatchService::take is blocking
        final var key = watchService.take();

        for (var event : key.pollEvents()) {
            final var kind = event.kind();
            final var f = (Path) event.context();

            if (kind == StandardWatchEventKinds.ENTRY_CREATE) {
                System.out.println("File created: " + f);

            } else if (kind == StandardWatchEventKinds.ENTRY_MODIFY) {
                System.out.println("File modified: " + f);

            } else if (kind == StandardWatchEventKinds.ENTRY_DELETE) {
                System.out.println("File deleted: " + f);
            }
        }

        key.reset();
    }
```

# Other resources

1. [Official JDK 20](https://docs.oracle.com/en/java/javase/20/docs/api/java.base/java/nio/file/WatchService.html)
1. [Official JDK 17](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/nio/file/WatchService.html)
