# Overview


# Column name conversion func
```go
// ConvertNumToColString converts column number to excel column string
// colNum >= 0
//
// Examples:
//  0 		-> "A"
//  1 		-> "B"
//  2 		-> "C"
//  10 		-> "K"
//  25 		-> "Z"
//  26 		-> "AA"
//  38 		-> "AM"
//  51 		-> "AZ"
//  52 		-> "BA"
//  65 		-> "BN"
//  104 	-> "DA"
//  999 	-> "ALL"
//  4460 	-> "FOO"
func ConvertNumToColString(colNum int) (string, error) {
	if colNum < 0 {
		return "", fmt.Errorf("colNum must be non-zero")
	}

	out := ""
	colRemain := colNum + 1

	for colRemain > 0 {

		thisPart := colRemain % 26
		if thisPart == 0 {
			thisPart = 26
		}

		colRemain = (colRemain - thisPart) / 26

		// Upper case letters from A=65 to Z=90
		colChar := string(rune(thisPart + 64))
		out = colChar + out
	}

	return out, nil
}
```


# Other resources
