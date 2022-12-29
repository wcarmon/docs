# Overview
1. [flyway](https://documentation.red-gate.com/fd) is a popular tool for managing database lifecycle
1. Migrations written in SQL or Java
1. [cli client](https://flywaydb.org/documentation/usage/commandline/), java client, [gradle plugin](https://flywaydb.org/documentation/usage/gradle/) for 6+


# Baseline
1. [cli](https://documentation.red-gate.com/fd/baseline-184127456.html)
1. [gradle](https://flywaydb.org/documentation/usage/gradle/baseline)


# [Clean](https://documentation.red-gate.com/fd/clean-184127458.html)
1. DO NOT use in production
1. drops all objects (in configured schemas)
1. [cli](https://documentation.red-gate.com/fd/clean-184127458.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayclean-184127425.html)


# Check
1. [cli](https://documentation.red-gate.com/fd/check-184127457.html)
1. not available for gradle


# Info
1. [cli](https://documentation.red-gate.com/fd/info-184127459.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayinfo-184127426.html)


# [Migrate](https://flywaydb.org/documentation/usage/commandline/migrate)
1. migrates schema to the latest version
1. applies changes
1. [cli](https://flywaydb.org/documentation/usage/commandline/migrate)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywaymigrate-184127427.html)


# Repair
1. [cli](https://documentation.red-gate.com/fd/repair-184127461.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayrepair-184127428.html)


# Snapshot
1. captures database schema
1. [cli](https://documentation.red-gate.com/fd/snapshot-184127462.html)
1. not available for gradle


# Undo
1. Teams edition only
1. undo most recently applied migration
1. [cli](https://documentation.red-gate.com/fd/undo-184127463.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayundo-184127429.html)


# Validate
1. verify migrations applied match the locally available migrations
1. [cli](https://documentation.red-gate.com/fd/validate-184127464.html)
1. [gradle](https://documentation.red-gate.com/fd/gradle-task-flywayvalidate-184127430.html)


# Other resources
1. TODO
