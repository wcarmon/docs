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
1. Injects into factory function args (Provider)
    1. Pass the factory function into `wire.Build(...)`
    1. Factory functions look like `func NewFoo(bar Bar) error`
1. Injects into struct properties
    1. Pass `wire.Struct(new(Foo), "*")` into `wire.Build(...)`
1. Can inject interface, struct, ...
1. For common types (like `string`), create custom type
    1. eg. `type dbUser string` ... `wire.Value(dbUser("admin"))`
    1. In [Spring](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-annotation-config), you would use Bean name or [`@Qualifier`](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#beans-scanning-qualifiers) instead.
    1. In [Guice](https://github.com/google/guice), you would use a [Binding annotation](https://github.com/google/guice/wiki/BindingAnnotations) instead.
    1. In [Angular](https://angular.io/), you would use a [Decorator](https://angular.io/guide/dependency-injection-in-action#qualify-dependency-lookup-with-parameter-decorators) instead.
1. [Providers](https://github.com/google/wire/blob/main/docs/guide.md#defining-providers) must be [exported](https://go.dev/ref/spec#Exported_identifiers) (factory functions)
1. Provider functions cannot be inlined


# `wire.go` file
1. Each [command](https://github.com/golang-standards/project-layout#cmd) might require their own object graph
    1. eg. `my-project/cmd/run-foo/wire.go`
1. The first two lines below are important!!
    1. These two lines avoid duplicate declarations compile failure
    1. *yes*, the blank line **after** the comment is important.
    1. *yes*, no spaces between `//` and `go:build`
    1. `go build` ignores this `wire.go` file (`wire.go` is only used by `wire`)
```go
//go:build wireinject

// wire will inject the instances
type appObjects struct {
    config *appConfig
    server *http.Server

    //TODO: add field for each obj used directly in main func
}

func BuildAppObjects() (*appObjects, error) {
    panic(wire.Build(
        NewFoo,
        NewBar,
        NewBaz,

        // Allows wiring an instance
        wire.Value(FancyStr("cheese")),

        // Injects all objects required in main func
        wire.Struct(new(appObjects), "*"),
    ))
}
```
- Assuming you have factory functions (Provider) like:
```
func NewFoo(b *Bar) (*Foo, error) { ... }

func NewBar() (*Bar, error) { ... }
```

# in main `func`
```go
func main() {

    appCtx, err := BuildAppObjects()
    // check for error

    // Use appCtx.config
}
```


# Patterns
## Inject: Interface, Given: Provider func
- Use provider + [`wire.Bind`](https://github.com/google/wire/blob/main/wire.go#L113)
```go
type Cheese interface {
	// ... methods here ...
}

// Implements Cheese
type brie struct {
	// ... fields here ...
}

// Provider func
func NewBrie() *brie {
	return ...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		// Provider for impl
		NewBrie,

		// Bind impl to interface
		wire.Bind(new(Cheese), new(*brie)),

		// appObjects references Cheese (interface)
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Interface, Given: Concrete type
- Use [`wire.InterfaceValue`](https://github.com/google/wire/blob/0675cdc9191c85b3aeb6bc2529e7e28263d7e202/wire.go#L142)
```go
type Cheese interface {
	// ... methods here ...
}

// Implements Cheese
type brie struct {
	// ... fields here ...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		wire.InterfaceValue(new(Cheese), new(*brie)),

		// appObjects references Cheese (interface)
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Interface, Given: Interface func
- Just use Provider
```go
type Cheese interface {
	// ... methods here ...
}

// Implements Cheese
type brie struct {
	// ... fields here ...
}

// interface builder func
func NewCheese() (Cheese, error) {
	return &brie{}, nil
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		NewCheese,

		// appObjects references Cheese (interface)
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Interface, Given: Concrete instance
- Use [`wire.Value`](https://github.com/google/wire/blob/main/wire.go#L130) + [`wire.Bind`](https://github.com/google/wire/blob/main/wire.go#L113)
```go
type Cheese interface {
	// ... methods here ...
}

// Implements Cheese
type brie struct {
	// ... fields here ...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		// Provider for impl
		wire.Value(
		    brie{ /* ...fields here... */ }),

		// Bind impl to interface
		wire.Bind(new(Cheese), &b),

		// appObjects references Cheese (interface)
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Concrete type pointer, Given: Provider func
```go
type brie struct {
	// ... fields here ...
}

// Provider func
func NewBrie() (*brie, error) {
	return ...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		NewBrie,

		// appObjects references *brie
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Concrete type pointer, Given: Concrete instance
```go
type brie struct {
	// ... fields here ...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		wire.Value(&brie{
			// ... fields here ...
		}),

		// appObjects references *brie
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Concrete type pointer, Given: Concrete type
1. not supported
1. use patterns above for [`Given: Concrete instance`](./di.md#inject-concrete-type-pointer-given-concrete-instance) or [`Given: Provider func`](TODO)


## Inject: Concrete type, Given: Provider func
```go
type DbUrl url.URL

// provider func
func NewDbUrl() (DbUrl, error) {
	u, err := url.Parse("...")
	if err != nil {
		...
	}

	return DbUrl(*u), nil
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		NewDbUrl,

		// appObjects references DbUrl (not a pointer)
		wire.Struct(new(appObjects), "*"),
	))
```

## Inject: Concrete type, Given: Concrete instance
```go
type DbUser string
```
In `wire.go`:
```go
...
	panic(wire.Build(
		wire.Value(DbUser("dbUser1")),

		// appObjects references DbUser (not a pointer)
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: Concrete type, Given: Concrete type
1. not supported
1. use patterns above for [`Given: Concrete instance`](TODO) or [`Given: Provider func`](TODO)


## Inject: func (literal), Given: Provider func
```go
func NewTimeProvider() func() time.Time {
	return func() time.Time {
		return time.Now()
	}
}

type appObjects struct {
	Clock func() time.Time
	...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		NewTimeProvider,

		// appObjects references: func() time.Time
		wire.Struct(new(appObjects), "*"),
	))
```


## Inject: func (custom type), Given: Provider func
```go
type TimeProvider func() time.Time

func NewTimeProvider() TimeProvider {
	return func() time.Time {
		return time.Now()
	}
}

type appObjects struct {
	Clock TimeProvider
	...
}
```
In `wire.go`:
```go
...
	panic(wire.Build(
		NewTimeProvider,

		// appObjects references TimeProvider
		wire.Struct(new(appObjects), "*"),
	))
```

## Inject: func (literal or custom type), Given: Concrete instance (literal)
1. not supported
1. Use Provider func


# TODO
- TODO: wire.FieldsOf example
- TODO: cleanup function example
- TODO: providerSets for grouping example


# Generate (Running `wire` binary)
```sh
DIR_CONTAINING_WIRE_DOT_GO=/path/to/cmd/run-server;
wire $DIR_CONTAINING_WIRE_DOT_GO;
```
1. commit generated `wire_gen.go`


# Other resources
1. https://github.com/google/wire
