# Overview
1. TODO


# General
1. Registration
    1. assigning positive numeric id to each class which can be serialized & deserialized 
1. Serialization
    1. converting a class to/from `ByteArray`


# Cons
1. Every class requires no-arg constructor
    1. Mitigate: https://github.com/EsotericSoftware/kryo?tab=readme-ov-file#instantiatorstrategy
1. Fails when you try to register classes manually
    1. Cannot register internal Kotlin classes like EMPTY_SET and EMPTY_LIST
    1. Workaround:
        - `listOf(...)` -> `TODO`
        - `mutableListOf()` -> `ArrayList`
        - `mutableSetOf()` -> `HashSet`
        - `mutableSortedSetOf()` -> `TreeSet`
        - `setOf(...)` -> `TODO`  
        - `listOf()` -> `Collections.emptyList()` (`java.util.Collections$EmptySet` is still private)
        - `setOf()` -> `Collections.emptySet()`
    1. Forces you to use non-idiomatic kotlin code


# Registration
```
    kryo.register(ArrayList::class.java)
    kryo.register(Collections.emptyList<String>().javaClass)
    kryo.register(Collections.emptyMap<String, String>().javaClass)
    kryo.register(Collections.emptySet<String>().javaClass)
    kryo.register(Collections.singleton("example").javaClass)
    kryo.register(Collections.singletonList("example").javaClass)
    kryo.register(Collections.singletonMap("key", "value").javaClass)
    kryo.register(HashMap::class.java)
    kryo.register(HashSet::class.java)
    kryo.register(Instant::class.java)
    kryo.register(LinkedHashSet::class.java)
    kryo.register(LocalDate::class.java)
    kryo.register(LocalDateTime::class.java)
    kryo.register(TreeSet::class.java)
    kryo.register(UUID::class.java, DefaultSerializers.UUIDSerializer())    
```        
    
    
# Other resources
1. TODO

    
