# Overview
1. Some pros & cons of using json/jsonb in postgres


# Gotchas
1. Non-standard syntax (same is true for all json databases)
1. No schema validation on json docs
    1. although relevant pg extensions exist
1. No check constraints on json
1. Room for error on mapping to/from jsonb
     1. https://www.postgresql.org/docs/current/datatype-json.html


# Other Resources
1. https://www.postgresql.org/docs/current/datatype-json.html
