# Overview

1. [Thread](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html) Basics
1. [ThreadPool](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/ExecutorService.html) basics

# Table of Contents

TODO


--------

# Goals

1. Do work in parallel
1. Coordinate independent tasks
1. Mutate data safely

# [Thread states](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html)

1. six-states
1. Intuition: [created](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#NEW), [running](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.State.html#RUNNABLE), waiting (3 types), [terminated](https://docs.oracle.com/en/java/javase/12/docs/api/java.base/java/lang/Thread.State.html#TERMINATED)
    1. [Wait on lock](TODO)
    1. [Wait on notify](TODO)
    1. [Wait on timeout](TODO)

# [Priority](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/Thread.html#setPriority(int))

1. Between [`1` and `10` (highest)](https://docs.oracle.com/en/java/javase/12/docs/api/constant-values.html#java.lang.Thread.NORM_PRIORITY)

# Thread Pools

1. Reuse previously created, idle threads
1. Reduce thread construction overhead

# More info

1. [Thread states](https://www.geeksforgeeks.org/lifecycle-and-states-of-a-thread-in-java)
