# Overview
1. Key points about [numpy](https://numpy.org/)


# What
1. Array/grid data structure
1. N-dimensional, contiguous


# Why
1. Fast, because written in [C](https://github.com/numpy/numpy), not python
    1. orders of magnitude faster than pure python
1. Less memory consumption than pure python [List](TODO)
1. Useful for Linear Algebra, Machine Learning, Statistics, etc.


# [Types](https://numpy.org/doc/stable/user/basics.types.html#array-types-and-conversions-between-types)
1. All elements of the np array have the same type
1. [`dtype`](https://numpy.org/doc/stable/reference/generated/numpy.dtype.html#numpy.dtype) sets the explicit data type for each element
    1. Signed
        1. `np.int8`
        1. `np.int16`
        1. `np.int32`
        1. `np.int64`
    1. Unsigned
        1. `np.uint8`
        1. `np.uint16`
        1. `np.uint32`
        1. `np.uint64`
    1. Floating point
        1. `np.float32`
        1. `np.float64`


# Usage
## [Create](https://numpy.org/doc/stable/user/basics.creation.html)
1. [Conversion from other Python structures](https://numpy.org/doc/stable/reference/generated/numpy.array.html#numpy.array) (i.e. lists and tuples)
```python
a1D = np.array([1, 2, 3, 4], dtype=np.int8)
a2D = np.array([[1, 2], [3, 4]])
```
1. Intrinsic NumPy array creation functions 
- [`.arange`](TODO)
- [`.ones`](TODO)
- [`.zeros`](TODO)
```python
TODO
```
1. Replicating, joining, or mutating existing arrays
```python
```
1. Reading arrays from disk, either from standard or custom formats
```python
```
1. Creating arrays from raw bytes through the use of strings or buffers
```python
```
1. Use of special library functions (e.g., random)
```python
```


## Update
1. TODO

## Get
1. starts at zero (like c, golang, rust, java, ...)

## Delete
1. TODO

## Broadcast
1. TODO: https://numpy.org/doc/stable/user/basics.broadcasting.html

# Relation to other tools
1. The foundation for TODO


# Other resources
1. https://numpy.org/
1. https://github.com/numpy/numpy-tutorials

