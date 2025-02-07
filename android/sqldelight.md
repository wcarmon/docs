# Overview
1. TODO


# Notes
1. SQLDelight auto-creates the database on first access, see [`AndroidSqliteDriver`](https://github.com/sqldelight/sqldelight/blob/master/drivers/android-driver/src/main/java/app/cash/sqldelight/driver/android/AndroidSqliteDriver.kt#L29)
    1. Uses the `CREATE TABLE` statements in your `*.sq` files
    1. See `/data/data/com.foo.bar/databases/quux.db
        1. `quux.db` is the `name` argument to [`AndroidSqliteDriver`](https://github.com/sqldelight/sqldelight/blob/master/drivers/android-driver/src/main/java/app/cash/sqldelight/driver/android/AndroidSqliteDriver.kt#L58) ctor
1. Inject the `AndroidSqliteDriver` into your DAOs


# $PROJ_ROOT/app/build.gradle.kts
```build.gradle.kts
plugins {
    ...
    id("app.cash.sqldelight") version "2.x.y"
}

...

dependencies {
    implementation(libs.sqlite.driver)
}

...

// Generates typesafe kotlin code for queries at compile time
// AndroidSqliteDriver uses MyDatabase.Schema to query, do DML, etc
sqldelight {
    databases {
        create("MyDatabase") {
            packageName.set("com.foo.bar")
        }
    }
}
```