# Overview
1. Key ideas in [numpy](https://numpy.org/)


# What
1. Array/grid data structure
1. N-dimensional, contiguous


# Why
1. Fast, because written in [C](https://github.com/numpy/numpy), not python
    1. orders of magnitude faster than pure python
1. Less memory consumption than pure python [List](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
    1. Lists are basically arrays of pointers
1. Useful for Linear Algebra, Machine Learning, Statistics, etc.


# Key Concepts
1. `ndarray` == `array` (alias)
1. Fixed size (cannot grow)
    1. changing the size deletes the original

## Dimension (Rank)
- starts with `axis0`
- 1D is a vector (like c array or python list)
- 2D is an matrix
- 3 or more dimensions is a Tensor
    - These are hard to visualize

## Shape
- Tuple of ints representing size of each dimension

## [Types](https://numpy.org/doc/stable/user/basics.types.html#array-types-and-conversions-between-types)
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
        1. `np.float128`
        1. `np.complex64`
        1. `np.complex128`
        1. `np.complex256`
    1. Other
        1. `object`: any python object
        1. `bool`


# Usage

## [Create](https://numpy.org/doc/stable/user/basics.creation.html)

1. [Conversion from other Python structures](https://numpy.org/doc/stable/reference/generated/numpy.array.html#numpy.array) (i.e. lists and tuples)
```python
a1D = np.array([1, 2, 3, 4], dtype=np.int8)
a2D = np.array([[1, 2], [3, 4]])
```
1. NumPy creation functions
    - [`np.arange`](https://numpy.org/doc/stable/reference/generated/numpy.arange.html#numpy.arange): increment at fixed interval (like `1`)
    - [`np.linspace(start=0, stop=10, num=5)`](https://numpy.org/doc/stable/reference/generated/numpy.linspace.html): evenly spaced across range
    - [`np.zeros`](https://numpy.org/doc/stable/reference/generated/numpy.zeros.html): filled with zeros
    - [`np.ones`](https://numpy.org/doc/stable/reference/generated/numpy.ones.html): filled with ones
    - [`np.eye`](https://numpy.org/doc/stable/reference/generated/numpy.eye.html#numpy.eye): filled in diagonal elements
    - [`np.random`](TODO): random data
1. [Replicating, joining, or mutating existing arrays](https://numpy.org/doc/stable/user/basics.creation.html#replicating-joining-or-mutating-existing-arrays)
    - [TODO]
```python
```
1. Reading arrays from disk, either from standard or custom formats
  - TODO: csv 
```python
TODO
```


## Update
1. TODO

## Read/Get
1. starts at zero (like c, golang, rust, java, ...)
1. `my_array.ndim`: number of dimensions
1. `my_array.shape`: returns a tuple of ints with size in each dimension
1. `my_array.dtype`: data type of each element
1. `my_array.size`: total element count
- TODO: indexing and slicing

## Slice
1. TODO

## Delete
1. TODO

## Broadcast
1. Allows operations on arrays of different shapes
1. Numpy has [rules about which shapes are compatible](TODO)
1. TODO: https://numpy.org/doc/stable/user/basics.broadcasting.html

# Utility functions
- [`abs`](TODO)  
- [`add`](TODO)  
- [`all`](TODO)  
- [`any`](TODO)  
- [`ceil`](TODO)  
- [`floor`](TODO)  
- [`max`](TODO)  
- [`min`](TODO)  
- [`multiply`](TODO)  
- [`round`](TODO)  
- [`sort`](TODO)  


# Relation to other tools
1. The foundation for OpenCV
1. The foundation for Pandas
1. The foundation for TODO
1. The foundation for TODO


# Other Resources
1. https://numpy.org/
1. https://github.com/numpy/numpy-tutorials
1. https://numpy.org/doc/1.23/numpy-ref.pdf
