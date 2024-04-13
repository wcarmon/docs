# Overview
1. Info about [Set](https://en.wikipedia.org/wiki/Set_(abstract_data_type)) Data Structure
1. No duplicates


# [`HashSet`](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html)
1. Unordered
1. Values must impl [`Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html) and [`Hash`](https://doc.rust-lang.org/std/hash/trait.Hash.html) traits
1. Java equivalent: [`HashSet`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/HashSet.html)
1. C++ equivalent: [`unordered_set`](https://en.cppreference.com/w/cpp/container/unordered_set)


# [`BTreeSet`](https://doc.rust-lang.org/std/collections/struct.BTreeSet.html)
1. Ordered/Sorted
1. Values must impl [`Ord`](https://doc.rust-lang.org/std/cmp/trait.Ord.html)
1. Java equivalent: [`TreeSet`](https://docs.oracle.com/en%2Fjava%2Fjavase%2F21%2Fdocs%2Fapi%2F%2F/java.base/java/util/TreeSet.html)
1. C++ equivalent: [`set`](https://en.cppreference.com/w/cpp/container/set)


Other references
1. https://brilliant.org/wiki/sets-adt/
