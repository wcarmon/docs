# Overview
1. Pros & cons of duckdb


# Pros
1. Can load multiple sources & duck files into a connection


# Cons
1. no concurrent writers to a duck file (compare to PG or sqlite)
1. No support in jetbrains tools
1. Cannot connect cli and application to a database simultaneously
1. Slow ingestion (same as sqlite)
1. cloogy jni issues
1. no support for SERIAL column type
    1. but they do support sequences
1. ChatGPT advice is useless since no one uses it
1. Examples online are all in python
1. Cannot open the same file multiple times    

