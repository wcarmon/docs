# Overview
- Why to prefer [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) over [`LinkedList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/LinkedList.html)

--------
# Table of Contents


--------
# Performance

## Iteration & Search
- ArrayList faster because sequential memory access is faster than random
- LinkedList requires dereferencing each [LinkedList::Node](TODO) element

## Delete/Insert between elements
TODO

## Append
TODO

--------
# Memory
- Every elemnt of LinkedList must be wrapped in [LinkedList::Node](TODO)
    - Arraylist uses direct references to the elements


--------
# More Info

