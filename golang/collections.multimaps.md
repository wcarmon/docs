# Overview
- How to use a Multimap/Bag DataStructure


# Creation
```go
type bagEntry[T any] struct {
	count int
	value T
}

// key:   string
// value: int
bag := make(map[string]*bagEntry[int])
```

# Size
TODO: what do Guava MultiMaps do?


# Insertion/Update
```go
func AddToBag[K comparable, V any](
	bag map[K]*bagEntry[V],
	key K,
	value V) {

	if entry, found := bag[key]; found {
        entry.count++
        return
	}

	bag[key] = &bagEntry[V]{
		count: 1,
		value: value}
}
```


# Removal
```go
func RemoveFromBag[K comparable, V any](
	bag map[K]*bagEntry[V],
	key K) {

	entry, found := bag[key]
	if !found {
		return
	}

	entry.count--
	if entry.count <= 0 {
		delete(bag, key)
	}
}
```


# Retrieval
TODO


# Contains check
TODO...


# Iteration
TODO...


# Shallow copy
TODO: ...


# Other resources
1. [Guava MultiMap](https://guava.dev/releases/31.0-jre/api/docs/com/google/common/collect/Multimap.html)
1. [Apache commons :: Bag](https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/Bag.html)
