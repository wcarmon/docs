# Overview

1. Summary of major changes for each PostgreSQL version

# [PG 17](TODO) - Sep 2024

1. TODO

# [PG 16](https://www.postgresql.org/about/news/postgresql-16-released-2715/) - Sep 2023

1. [Details](https://www.postgresql.org/docs/release/16.0/)
1. New query planner optimizations
1. Much faster bulk loading via [`COPY`](https://www.postgresql.org/docs/16/sql-copy.html)
1. CPU acceleration using SIMD
1. [Better JSON support](https://www.postgresql.org/docs/16/functions-json.html)
1. Finer-grained access control features (eg. regex matching)

# [PG 15](https://www.postgresql.org/about/news/postgresql-15-released-2526/) - Oct 2022

1. [Details](https://www.postgresql.org/docs/release/15.0/)
1. Better [`MERGE`](https://www.postgresql.org/docs/15/sql-merge.html) (think atomic upsert)
1. [new regex functions](https://www.postgresql.org/docs/15/functions-matching.html#FUNCTIONS-POSIX-REGEXP)
1. Faster sorting
1. Faster window functions
1. Improvements for async remote queries
1. Improvements for backups
1. Compression: LZ4 support on WAL
1. Prefetch WAL
1. json logging (for DB system logs)

# [PG 14](https://www.postgresql.org/about/news/postgresql-14-released-2318/) - Sep 2021

1. [Details](https://www.postgresql.org/docs/release/14.0/)
1. JSON ergonomic improvements
1. Query pipelining

# [PG 13](https://www.postgresql.org/about/news/postgresql-13-released-2077/) - Sep 2020

1. [Details](https://www.postgresql.org/docs/13/release-13.html)
1. Parallel Vacuuming
1. More DBAdmin featuers
1. random uuid generation (without extensions)
1. new `datetime` function for SQL/JSON
1. tie resolution for `FETCH FIRST`
