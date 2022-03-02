# Overview
1. How to select the correct collection


# Single type (not pairs)
| |Allow duplicates|No duplicates|
|---|---|---|
|**Strict order**|[List](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html)|[SortedSet](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/SortedSet.html) or [LinkedHashSet](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/LinkedHashSet.html)|
|**Any order**|[MultiSet](https://github.com/google/guava/wiki/NewCollectionTypesExplained#Multiset) or [Bag](https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/Bag.html)|[Set](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Set.html)|


# Key-value pairs
| |Fixed keys|Dynamic keys|
|---|---|---|
|to **one** value|[POJO](./pojos.lombok.java8-11.md) or [EnumMap](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/EnumMap.html)|[Map](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html)|
|to **many** values|[POJO](./pojos.lombok.java8-11.md) or [EnumMap](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/EnumMap.html)|`Map<K, Collection<V>>` or [`MultiMap<K, V>`](https://guava.dev/releases/31.0.1-jre/api/docs/com/google/common/collect/Multimap.html)|
