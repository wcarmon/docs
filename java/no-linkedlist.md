# Overview
- Why to prefer [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) over [`LinkedList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/LinkedList.html)


--------
# Table of Contents


--------
# Performance
- TL;DR; Use `ArrayList`

## Iteration & Search
- `ArrayList` faster because sequential memory access is faster than random
- `LinkedList` requires dereferencing each [LinkedList::Node](TODO) element to read


## Direct access to element
- `ArrayList` can jump to any index in constant time
- `LinkedList` must iterate to find elements (except first and last)
  - See above about iteration & search
  - Note this also makes things like [binary search](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Arrays.html#binarySearch(byte%5B%5D,byte)) slower

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

