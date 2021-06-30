# Overview
- Local Containerization Use Case 01
- Make incremental changes, Verify changes on "prod-like" environment


# Table of contents
- [Development steps without Containerization](#development-steps-without-containerization)
    * [Step-1: Write code locally](#step-1-write-code-locally)
    * [Step-2: Local build](#step-2--do-a-local-build)
    * [Step-3: git commit & push](#step-3-git-commit--push)
    * [Step-4: Create a pull request](#step-4--create-a-pull-request)
    * [Step-5: Trigger CI/CD & Wait](#step-5--trigger-ci-cd---wait)
    * [Step-6: Deploy to some shared env (eg. Dev/QA)](#step-6--deploy-to-some-shared-env--eg-dev-qa-)
    * [Step-7: Test your changes](#step-7--test-your-changes)
- [Development steps with Containerization](#development-steps-with-containerization)
    * [Step-1: Write code locally](#step-1--write-code-locally-1)
    * [Step-2: Local build](#step-2--do-a-local-build-1)
    * [Step-3: Run a local docker or kubernetes command](#step-3--run-a-local-docker-or-k8s-command)
    * [Step-4: Test your changes](#step-4--test-your-changes)
- [Comparison](#comparison)


--------
# Development steps without Containerization
- **One** iteration between **25-minutes** and **75-minutes** (or more in worst case)
- Every iteration costs the same


## Step-1: Write code locally

## Step-2: Local build
- poorly designed & legacy build system runs slower
- This is mostly to avoid sending obviously broken code into a long pipeline
- Cost: **1-10 minutes**

## Gotchas
1. Delayed if your deps are retrieved over slow network


## Step-3: git commit & push
- Pre-commit verification checks take time
- Hooks require a proper formatted message
- Cost: **2-minutes**


## Step-4: Create a pull request
- Manual, one-time step (per branch)
- Cost: **3-minutes**

## Gotchas
1. Fails when git not available
1. Delayed when network is slow


## Step-5: Trigger CI/CD & Wait
- If you're lucky, CI is auto-triggered when you push to an existing Pull Request
- CI/CD infra is shared
- Cost: **15-30 minutes** (maybe more)

## Gotchas
1. Can fail if CI server out of capacity
1. Delayed when CI server is overwhelmed
1. Delayed when the network is slow


## Step-6: Deploy to some shared env (eg. Dev/QA)
- Cost: **4-30 minutes** (more if waiting for others)

## Gotchas
1. Shared env so may have to wait for others
1. Have to coordinate deployments & changes with ALL other Engineers
1. Might be unable to test until specific date (eg. breaking schema changes)
1. The larger the team, the more Engineers are blocked by this
1. Potential data conflicts when others mutate shared data stores (DB, Kafka, NFS, ...)
1. No guarantees your code is running while testing (eg. accidental deploy, auto-deploy, ...)
1. No control over settings (Environment specific & shared)


## Step-7: Test your changes
- This is the goal
- If you made a mistake, you need to start over


--------
# Development steps with Containerization
- First iteration costs between **2-minutes** and **14-minutes**
- Subsequent iterations cost between **1-minute** and **7-minutes**

## Step-1: Write code locally
(same as without containerization)


## Step-2: Local build
- Faster than above because ...
    1. you can (safely) skip tests and static analysis (they will run at CI)
    1. you can skip building modules you didn't change
    1. you can cache your dependencies
- This produces an artifact you can use directly in next step
- Cost: **1-7 minutes**


## Step-3: Run a local docker or kubernetes command
- This spins up a complete "prod-like" local env
    - [Kafka](https://hub.docker.com/r/confluentinc/cp-kafka/), [RDBMS](https://hub.docker.com/_/postgres), [Cache](https://hub.docker.com/_/redis), [NGINX](https://hub.docker.com/_/nginx), [Tomcat](https://hub.docker.com/_/tomcat), [Couchbase](https://hub.docker.com/_/couchbase), [Apache](https://hub.docker.com/_/httpd), [hundreds of other popular tools](https://hub.docker.com/search?image_filter=official&type=image)
- Can pre-hydrate data stores with **exact** data you need
- Can either run specific components or combine multiple components into 1 config (via [Kubernetes](https://kubernetes.io/) or [docker-compose](https://docs.docker.com/compose/))
- Can run multiple instances without conflicts
    - Separate networks, ports, file systems, ...
- Can pre-wire together connected tools
- Completely isolated from other Engineers
- [Intellij has docker features](https://www.jetbrains.com/help/idea/docker.html) and [Kubernetes features](https://www.jetbrains.com/help/idea/kubernetes.html#resource-config-files) to further streamline

- Cost: **1-7 minutes**


## Step-4: Test your changes
- This is the goal
- If you made a mistake, just run Steps 1 & 2 (skip Step-3)


------
# Comparison

## Best case
|Iteration|With Containerization| Without Containerization|
|---| ---| ---|
|1| 2-minutes| |
|2| 1-minute| |
|3| 1-minute| |


## Worst case
