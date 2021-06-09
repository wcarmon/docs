# Overview
- Why to prefer [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) over [`LinkedList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/LinkedList.html)


--------
# Table of Contents
- [Performance](#performance)
  * [Iteration, Traversal & Search](#iteration-traversal--search)
  * [Direct access to element](#direct-access-to-element)
  * [Append](#appendhttpsdocsoraclecomenjavajavase11docsapijavabasejavautillisthtmladde)
  * [Delete/Insert between elements](#deleteinsert-between-elements)
- [Memory](#memory)
- [More Info](#more-info)


--------
# Performance
- TL;DR; Use [`ArrayList`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) unless you can **prove** that `LinkedList` is faster for your use case

## Iteration, Traversal & Search
- `ArrayList` faster because **sequential** memory access is faster than **random** access
  - CPUs are optimized for handling sequential memory ([Locality of reference](https://en.wikipedia.org/wiki/Locality_of_reference#:~:text=In%20computer%20science%2C%20locality%20of,a%20short%20period%20of%20time.&text=Temporal%20locality%20refers%20to%20the,a%20relatively%20small%20time%20duration.), [Mechanical sympathy](https://dzone.com/articles/mechanical-sympathy), etc.)
  - Java uses native [System array utils](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/System.html#arraycopy(java.lang.Object,int,java.lang.Object,int,int)), which are extremely fast
- `LinkedList` requires dereferencing each [LinkedList::Node](https://hg.openjdk.java.net/jdk/jdk11/file/1ddf9a99e4ad/src/java.base/share/classes/java/util/LinkedList.java#l974) element to read


## [Direct access to element](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#get(int))
- `ArrayList` can jump to any element in constant time - `O(1)`
- `LinkedList` must iterate to find elements (except first and last) - `O(n)`
  - See above about [Iteration, Traversal & search](#iteration-traversal--search)
  - Note this also makes things like [binary search](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Arrays.html#binarySearch(byte%5B%5D,byte)) slower
  

## [Append](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#add(E))
- `ArrayList` is only slower when [resize](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/ArrayList.html) is required
  - Solution: start with enough capacity to avoid resize
- `LinkedList` must allocate [`Node`](https://hg.openjdk.java.net/jdk/jdk11/file/1ddf9a99e4ad/src/java.base/share/classes/java/util/LinkedList.java#l974) for each element & update pointers
  - So, `LinkedList::add` is slower than `ArrayList::add`, except for the resize case


## [Delete](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#remove(int))/[Insert](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#add(int,E)) between elements
- `LinkedList` can be faster here since `ArrayList` must shift elements
  - Since CPUs are optimized for array operations, benchmarks are required
  - [System::arrayCopy](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/System.html#arraycopy(java.lang.Object,int,java.lang.Object,int,int)) is extremely fast
- `LinkedList` can be slower here because it requires **traversing** to the insertion/deletion point

  
--------
# Memory
- `LinkedList` wraps every element in [LinkedList::Node](https://hg.openjdk.java.net/jdk/jdk11/file/1ddf9a99e4ad/src/java.base/share/classes/java/util/LinkedList.java#l974)
    - Memory overhead
    - `Arraylist` uses direct references to the elements   
- If you have GC pressure...
  - `LinkedList` may be able to allocate where `ArrayList` cannot (because `LinkedList` memory is non-contiguous)
  - This is a narrow case (you are close to memory exhaustion and expect a large allocation to help)
- `LinkedList` creates more GC pressure (since it requires more memory)
  - This can make your app slower (more GC pauses)


--------
# More Info
- [The author of LinkedList doesn't use it](https://twitter.com/joshbloch/status/583813919019573248)
- https://www.techiedelight.com/arraylist-vs-linkedlist-java/
- [Stack overflow](https://stackoverflow.com/questions/322715/when-to-use-linkedlist-over-arraylist-in-java?rq=1)
