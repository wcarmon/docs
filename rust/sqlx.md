# Overview
1. How to use [sqlx](TODO)


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


# Other resources
1. TODO
