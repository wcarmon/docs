# Pros

1. Light
1. Relatively fast
1. Relatively simple
1. Supports check constraints
1. Universally supported (IDEs, Tertiary libraries, Android, UI tools)
1. Backups are trivial (just compress the file)

# Cons

1. Concurrency: Only allows single writer at any time (queuing), no concurrent writers
1. Ergonomics: `ALTER TABLE` cannot add constraints
1. Ergonomics: `ALTER TABLE` cannot add indexes
1. IO: Only useful for local apps (not over a network)
1. Performance: Doesn't scale to terabytes
1. Performance: Few opportunities for tuning performance (compare to PostgreSQL)
1. Structure: No schemas
1. Structure: Types aren't very granular
