# Overview
1. TODO


# Null handling
1. important interface: [`Scanner`](https://pkg.go.dev/database/sql#Scanner)
1. Core lib provides nilable types
    1. [bool](https://pkg.go.dev/database/sql#NullBool)
    1. [int64](https://pkg.go.dev/database/sql#NullInt64)
    1. [string](https://pkg.go.dev/database/sql#NullString)
    1. [time](https://pkg.go.dev/database/sql#NullTime)
    1. ...


# pgx
```go
type DbConf struct {
    Host string
    Pass string
    Port uint32
    User string

    // SELECT datname FROM pg_database;
    Name string
}

func (c *DbConf) ConnStr() string {
    return fmt.Sprintf("postgres://%s:%s@%s:%d/%s",
    c.User, c.Pass, c.Host, c.Port, c.Name)
}
```
- Build a conf:
```
dbConf := {
    Host: "localhost",
    Name: "foo",
    Pass: os.Getenv("DB_PASS"),
    Port: 5432,
    User: "admin",
}

conn, err := pgx.Connect(ctx, dbConf.ConnStr())
// handle err

defer conn.close(ctx)
```


# Idioms
1. TODO

# Other resources
1. TODO