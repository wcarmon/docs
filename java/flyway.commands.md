# Overview

1. Flyway commands/operations

# Read-only operations (Safe)

## Info command

1. Prints details & status info about all migrations
1. [cli](https://documentation.red-gate.com/fd/info-184127459.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayinfo-184127426.html)

## Snapshot command

1. Captures database schema
1. [cli](https://documentation.red-gate.com/fd/snapshot-184127462.html)
1. not available for gradle

## Validate command

1. Verify migrations applied match the locally available migrations
1. [cli](https://documentation.red-gate.com/fd/validate-184127464.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayvalidate-184127430.html)

## Check command

1. Builds a report? TODO more here
1. [cli](https://documentation.red-gate.com/fd/check-184127457.html)
1. not available for gradle

# Safe Mutation operations

## Baseline command

1. Introduces flyway to existing database
1. Migrations are done relative to baseline, so re-basing can simplify migrations
1. Creates flyway_schema_history table
1. [cli](https://documentation.red-gate.com/fd/baseline-184127456.html)
1. [gradle](https://flywaydb.org/documentation/usage/gradle/baseline)

## [Migrate](https://flywaydb.org/documentation/usage/commandline/migrate)

1. Migrates schema to the latest version
1. Creates flyway_schema_history table if required
1. Applies changes
1. [cli](https://flywaydb.org/documentation/usage/commandline/migrate)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywaymigrate-184127427.html)

## Repair command

1. Fixes issues in flyway's schema history table
1. [cli](https://documentation.red-gate.com/fd/repair-184127461.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayrepair-184127428.html)

# Dangerous Mutation operations

## [Clean](https://documentation.red-gate.com/fd/clean-184127458.html) command

1. DO NOT use in production
1. drops all objects (in configured schemas)
1. [cli](https://documentation.red-gate.com/fd/clean-184127458.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayclean-184127425.html)

## Undo command

1. Undo most recently applied migration
1. Teams edition only
1. [cli](https://documentation.red-gate.com/fd/undo-184127463.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayundo-184127429.html)
