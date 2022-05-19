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


# Maps
TODO: copy keys into slice, sort the slice, lookup via keys


# Sets
TODO: copy into slice, sort the slice


# Other resources
1. https://gobyexample.com/sorting
1. https://gobyexample.com/sorting-by-functions
1. https://yourbasic.org/golang/how-to-sort-in-go/
1. [sort.Slice](https://pkg.go.dev/sort#Slice)
1. [sort.SliceStable](https://pkg.go.dev/sort#SliceStable)
