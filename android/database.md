# Overview
1. Relational Database options


# SQLDelight
1. `Pro`: thoughtfully designed
1. `Pro`: Square product
1. `Pro`: Supports indexes
1. `Pro`: Developer controls the SQL
1. `Pro`: Mature JetBrains plugin
1. `Pro`: compile time generation (type safety)
1. `Pro`: helpful error messages


# ObjectBox
1. `Con`: Goofy query syntax
2. `Con`: every entity must have an id of type `long`


# ~~Room~~
1. `Con`: deep integration in to coroutines
1. `Con`: yet another bloated ORM
1. `Con`: generates SQL
1. `Con`: Framework (limited to their imagination)


# SQLite (directly)
1. `Pro`: Native to Android
1. `Con`: They don't expose JDBC
1. `Con`: They don't expose xerial's api
1. `Con`: Their abstraction layers are complex and unintuitive (`SQLiteDatabase` and `SQLiteOpenHelper`)
1. `Con`: Their abstraction layers are harder to test than standard APIs


# Jooq
1. TODO


# Abandonware
1. ~~greenDAO~~
1. ~~Realm~~
