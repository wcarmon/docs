# Overview
1. Best libraries for Connection pools in rust
    1. https://www.cockroachlabs.com/blog/what-is-connection-pooling/
    1. https://en.wikipedia.org/wiki/Connection_pool


# Candidates
1. Best: [**Deadpool**](https://docs.rs/deadpool/latest/deadpool/)
1. [bb8](https://github.com/djc/bb8)
1. [r2d2](https://github.com/sfackler/r2d2)
1. Worst: [~~mobc~~](https://docs.rs/mobc/latest/mobc/)


# [Deadpool](https://docs.rs/deadpool/latest/deadpool/) (best)
1. `Pro`: Simple
1. `Pro`: Resizable
1. `Pro`: [rusqlite](https://github.com/jgallagher/rusqlite) support (meaning sqlite)
1. `Pro`: [tiberius](https://docs.rs/tiberius/latest/tiberius/) support (meaning mssql/sql-server)
1. `Pro`: [tokio-postgres](https://docs.rs/tokio-postgres/latest/tokio_postgres/) support (meaning postgres)
1. `Pro`: Good documentation
1. `Pro`: Actively maintained (as of Q1 2024)


# [bb8](https://github.com/djc/bb8)
1. `Con`: No [sqlite](https://www.sqlite.org/index.html) support
1. `Pro`: [tiberius](https://docs.rs/tiberius/latest/tiberius/) support (meaning mssql/sql-server)
1. `Pro`: [tokio-postgres](https://docs.rs/tokio-postgres/latest/tokio_postgres/) support
1. `Pro`: Actively maintained (as of Q1 2024)


# [r2d2](https://github.com/sfackler/r2d2)
1. `Con`: Abandoned? (no code updates in over a year)
1. `Con`: No releases in the last 18 months
1. `Con`: No SQL Server support (mssql)
1. `Con`: No tiberius support
1. `Pro`: [rusqlite](https://github.com/jgallagher/rusqlite) support (meaning sqlite)
1. `Pro`: Simple


# [~~mobc~~](https://docs.rs/mobc/latest/mobc/)
1. `Con`: Least popular of the options above
1. `Con`: No [sqlite](https://www.sqlite.org/index.html) support
1. `Con`: No SQL Server support (mssql)
