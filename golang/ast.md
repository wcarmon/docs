# Overview
- How to parse and (re)write `*.go` source files


# Key Concepts
1. Use [`parser.ParseFile(...)`](https://pkg.go.dev/go/parser#ParseFile) to build a [`*ast.File`](https://pkg.go.dev/go/ast#File) from a file or from source as `[]byte`
1. Use [`printer.Fprint(...)`](https://pkg.go.dev/go/printer#Fprint) to write a [`*ast.File`](https://pkg.go.dev/go/ast#File) to a [Writer](https://pkg.go.dev/io#Writer)
1. core ast package [handles comments poorly](https://github.com/dave/dst#where-does-goast-break)
    1. see https://github.com/dave/dst


# Idioms
TODO ...


# Other resources
1. https://github.com/dave/dst
1. https://eli.thegreenplace.net/2021/rewriting-go-source-code-with-ast-tooling/
1. https://medium.com/justforfunc/understanding-go-programs-with-go-parser-c4e88a6edb87
1. https://astexplorer.net/
1. https://yuroyoro.github.io/goast-viewer/index.html
1. https://abhinavg.net/posts/understanding-token-pos/
