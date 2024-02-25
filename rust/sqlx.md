# Overview
1. How to use [sqlx](https://github.com/launchbadge/sqlx)


# Reasons to avoid sqlx
1. Unnecessary Complexity
    1. Mandatory lifetime annotation on `sqlx::query::Query`
1. [The severity and count of open issues](https://github.com/launchbadge/sqlx/issues)
1. No examples of INSERT/UPDATE/DELETE (they seem query focused only)
1. No support for bulk/batch insert/update/delete
1. No support for (or at least examples) of Prepared statement insert/update
1. No reason compiler should require a live database
    1. They have a cache feature, but it's not smooth especially for first use
1. Migrations require write permissions to a database
1. sqlx-cli has unhelpful error messages (compare to rustc)
    1. See ticket I opened
1. sqlx-cli migration runner doesn't report what it executed
1. Docs are unclear about what placeholder type to use `?, ?` or `$1, $2`


# Migrations
1. `$PROJECT_ROOT/migrations/*.sql`
    1. eg. 0001.initial_setup.sql
1. Sync: `sqlx migrate run`


# .env file
1. `$PROJECT_ROOT/.env`
```env
# Local Postgres URL
DATABASE_URL=postgres://postgres:postgres@localhost:25432/postgres

# Avoid hitting database on every compile
# See https://github.com/launchbadge/sqlx/blob/main/sqlx-cli/README.md#force-building-in-offline-mode
SQLX_OFFLINE=true
```

# [sqlx cli](https://github.com/launchbadge/sqlx/tree/main/sqlx-cli)
1. Install: `cargo install sqlx-cli`
