# Overview
- Idioms for sorting collections


# Slices
1. For builtin types:
```go
    // -- sort ints
    myInts := []int{3, 5, 2}
    sort.Ints(myInts)

    fmt.Printf("%v", myInts) // [2 3 5]

    // -- sort floats
    myFloats := []float64{3.3, 5.5, 2.1}
    sort.Float64s(myFloats)

    fmt.Printf("%v", myFloats) // [2.1 3.3 5.5]

    // -- sort strings
    s := []string{"c", "a", "b"}
    sort.Strings(s)

    fmt.Printf("%v", s) // [a b c]
```
1. For custom types
```go
type Car struct {
	Model string
	Year  int32
}

func main() {
    cars := []Car{
		Car{Model: "X3", Year: 2020},
		Car{Model: "GLE", Year: 2022},
		Car{Model: "Jetta", Year: 2011},
	}

	// -- Sort cars by Year,
	// Stable means "when year is same, retain original order"
   	sort.SliceStable(
		cars,
		func(i, j int) bool {
			return cars[i].Year < cars[j].Year
		})
}
```

## Sort by multiple fields
```go
type Foo struct {
	A, B, C string
}

...
	sort.Slice(foos, func(i, j int) bool {
		switch {
		case foos[i].A != foos[j].A:
			return foos[i].A < foos[j].A

		case foos[i].B != foos[j].B:
			return foos[i].B < foos[j].B

		default:
			return foos[i].C < foos[j].C
		}
	})
```


# Maps
1. Example
```go
TODO: copy keys into slice, sort the slice, lookup via keys
```
1. Note that [`fmt.Print*`](https://pkg.go.dev/fmt) prints maps with keys sorted


# Sets
1. Example
```go
TODO: copy into slice, sort the slice
```

# Other Resources
1. https://gobyexample.com/sorting
1. https://gobyexample.com/sorting-by-functions
1. [reversing](https://pkg.go.dev/sort#Reverse)
1. [sort.Slice](https://pkg.go.dev/sort#Slice)
1. [sort.SliceStable](https://pkg.go.dev/sort#SliceStable)
1. https://www.practical-go-lessons.com/chap-16-interfaces#sort.interface
1. https://yourbasic.org/golang/how-to-sort-in-go/
