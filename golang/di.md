# Overview
1. Idioms for [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) design pattern


# Setup
```sh
go install github.com/google/wire/cmd/wire@latest;
```
1. Ensure `$GOPATH/bin` is on your `$PATH`
    1. eg. `$HOME/go/bin/wire`
1. Alternative: symlink into `~/bin`
    1. `ln -sv $HOME/go/bin/wire $HOME/bin;`


# [Wire](https://github.com/google/wire) overview
1. [**Compile time**](https://en.wikipedia.org/wiki/Compile_time) dependency injection (Not runtime)
1. Can inject into factory function args
    1. Pass the factory function into `wire.Build(...)`
1. Can inject into struct properties
    1. Pass `wire.Struct(new(Foo), "*")` into `wire.Build(...)`
1. Can inject interface, struct, ...
1. For more common types (like `string`), best to create custom type
    1. eg. `type dbUser string` ... `wire.Value(dbUser("admin"))`
    1. In [Spring](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-annotation-config) you would use Bean name or [`@Qualifier`](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-scanning-qualifiers) instead.
    1. In [Guice](https://github.com/google/guice) you would use a [Binding annotation](https://github.com/google/guice/wiki/BindingAnnotations) instead.
    1. In [Angular](https://angular.io/), you would use a [Decorator](https://angular.io/guide/dependency-injection-in-action#qualify-dependency-lookup-with-parameter-decorators) instead.


# `wire.go` file
1. Each command might require their own object graph
    1. eg. `my-project/cmd/run-foo/wire.go`
1. The first two lines are important!!
    1. These lines avoid duplicate declarations.
    1. *yes*, the blank line **after** the comment is important.
    1. This `wire.go` file is ignored by the `go build` (only used by `wire`)
```go
// go:build wireinject

type appObjects struct {
    config *appConfig
    server *http.Server

    //NOTE: add field for other fields needed directly from main func
}

func BuildObjects() (*appObjects, error) {
    wire.Build(
        NewFoo,
        NewBar,
        NewBaz,

        // Allows wiring an instance
        wire.Value(FancyStr("cheese")),

        // Injects all objects required in main func
        wire.Struct(new(appObjects), "*"),
    )

    // just to appease the compiler
    return &appObjects{}, nil
}

// Assuming you have factory functions like:
func NewFoo(b *Bar) (*Foo, error) { ... }

func NewBar() (*Bar, error) { ... }
```


# Patterns
## Need: interface, Have: implementation instance
- Given:
```go
type Cheese interface

var myMozzarella Cheese

func NewTaco(c *Cheese) (*taco, error) { ... }
```
- In `wire.go`
```
wire.Build(
    NewTaco,
    wire.InterfaceValue(new(Cheese), myMozzarella),
    ...)
```

## Need: interface, Have: implementing type
1. `wire.Bind(new(TheInterface), new(*TheImplType))`
```go
type Cheese interface

// Cheddar implements Cheese
type Cheddar struct {}

func NewTaco(c *Cheese) (*taco, error) { ... }
```
1. In `wire.go`
```
wire.Build(
    NewTaco,
    wire.Bind(new(Taco), new(*Cheddar)),
    ...)
```

## Need: `type`, Have: instance
```go
var co Cotija

func NewTaco(c Cotija) (*taco, error) { ... }
```
1. In `wire.go`
```
wire.Build(
    NewTaco,
    wire.Value(co),
)
```


- TODO: running wire on package with wire.go


# Idioms
1. commit `wire_gen.go`


# Other resources
1. https://github.com/google/wire
