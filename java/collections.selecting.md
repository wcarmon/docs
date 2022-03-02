# Overview
1. How to select the correct [Collection](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Collection.html)


# Ask yourself
1. Do I need kv pairs or just "multiple items"?
1. Do I need thread-safety?
1. Is order important?
1. Should I allow duplicates?



# Single Type (not pairs)
| |Allow duplicates|No duplicates|
|---|---|---|
|**Strict order**|[ArrayList](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html), [ArrayBlockingQueue](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/concurrent/ArrayBlockingQueue.html)|[TreeSet](https://cr.openjdk.java.net/~iris/se/11/latestSpec/api/java.base/java/util/TreeSet.html), [LinkedHashSet](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/LinkedHashSet.html)|
|**Any order**|[HashMultiSet](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/HashMultiset.html), [ConcurrentHashMultiSet](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/ConcurrentHashMultiset.html), [Bag](https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/Bag.html)|[Set](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Set.html)|


# Key-value pairs
| |Fixed keys|Dynamic keys|
|---|---|---|
|to **one** value|[POJO](./pojos.lombok.java8-11.md) or [EnumMap](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/EnumMap.html)|[Map](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html)|
|to **many** values|[POJO](./pojos.lombok.java8-11.md) or [EnumMap](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/EnumMap.html)|`Map<K, Collection<V>>` or [`MultiMap<K, V>`](https://guava.dev/releases/31.0.1-jre/api/docs/com/google/common/collect/Multimap.html)|
