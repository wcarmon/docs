# Overview
1. TODO


# Classes
## [`ReentrantLock`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/locks/ReentrantLock.html)
1. Recursive (re-acquirable) lock
1. [C++ equivalent](https://en.cppreference.com/w/cpp/thread/recursive_mutex)
1. Go & Rust don't have recursive locks (perhaps because re-acquiring a lock increases complexity)


## [`ReentrantReadWriteLock`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/locks/ReentrantReadWriteLock.html)
1. Similar to `ReentrantLock`, but optimized for multiple-readers
1. [Most similar lock in C++](https://en.cppreference.com/w/cpp/thread/shared_mutex)


# AutoCloseable locks
1. Unlike Java, C++ ([scoped lock](https://en.cppreference.com/w/cpp/thread/scoped_lock)), Rust ([drop](https://doc.rust-lang.org/std/sync/struct.Mutex.html#method.unlock)), and Golang (`defer`) have idioms for auto-closing locks

## Example: Java 8+ [`AutoCloseable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/AutoCloseable.html) lock (useful in [try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) block)
```java
public interface CloseableLock extends Lock {

    /** @return an {@link AutoCloseable} after lock acquired. */
    LockResource lockAsResource();
}
```
```java
/** Allows ReentrantLock in try-with-resources */
public final class CloseableReentrantLock extends ReentrantLock implements CloseableLock {

    /** @return an {@link AutoCloseable} after lock acquired. */
    public LockResource lockAsResource() {
        lock();
        return this::unlock;
    }
}
```
```java
/** Allows ReentrantReadWriteLock in try-with-resources */
public final class CloseableReentrantReadWriteLock extends ReentrantReadWriteLock {

    /** @return an {@link AutoCloseable} after lock acquired. */
    public LockResource lockReadAsResource() {
        this.readLock().lock();
        return () -> this.readLock().unlock();
    }

    /** @return an {@link AutoCloseable} after lock acquired. */
    public LockResource lockWriteAsResource() {
        this.writeLock().lock();
        return () -> this.writeLock().unlock();
    }
}
```

Usage:
```java
    try (var _r = stateLock.lockAsResource()) {
        // do something atomically
    }
```


# Other resources
1. TODO
