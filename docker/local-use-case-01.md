# Overview
- Local Containerization - Use Case 01
  1. Make incremental changes
  1. Verify changes on "prod-like" environment
- Explains why *non*-container dev discourages innovation


# [TL;DR](https://www.dictionary.com/browse/tldr):
- Local Containerization makes **iterations** shorter.  For short iterations ...
   - Engineers fix issues faster
   - Engineers evolve code faster
   - Mistakes are discovered faster
   - Engineers can experiment with improvements faster
- Local Containerization gives Engineers **isolated** environments.  For isolated envs ...
   - cata & artifact conflicts with peers are removed
   - conflicts with upstream & downstream testing removed
   - coordination bottlenecks of shared environments are removed
   - mistakes are cheap and easy to correct
   - Engineers can control **local** data stores


# Table of contents
- [Analogies](#analogies)
- [Development steps without Containerization](#development-steps-without-containerization)
    * [Step-1: Write code locally](#step-1-write-code-locally)
    * [Step-2: Local build](#step-2-local-build)
    * [Step-3: git commit & push](#step-3-git-commit--push)
    * [Step-4: Create a pull request](#step-4-create-a-pull-request)
    * [Step-5: CI/CD](#step-5-cicd)
    * [Step-6: Deploy to some shared env (eg. Dev/QA)](#step-6--deploy-to-some-shared-env--eg-dev-qa-)
    * [Step-7: Test your changes](#step-7--test-your-changes)
- [Development steps with Containerization](#development-steps-with-containerization)
    * [Step-1: Write code locally](#step-1--write-code-locally-1)
    * [Step-2: Local build](#step-2--local-build-1)
    * [Step-3: Run a local docker or kubernetes command](#step-3--run-a-local-docker-or-k8s-command)
    * [Step-4: Test your changes](#step-4-test-your-changes)
- [Comparison](#comparison)


--------
# Analogies

## Workspace Isolation
- It would create problems if all engineers **shared** the same file system for code
- It would create problems if all employees **shared** the same email inbox

## Short Iterations
- Imagine an interactive conversations over snail-mail vs text


--------
# Development steps without Containerization
- **Each** iteration: costs between **25-minutes** and **75-minutes** (or more in worst case)
- Each iteration costs the same


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


## Step-5: CI/CD
- If you're lucky, [CI](https://en.wikipedia.org/wiki/Continuous_integration) is [auto-triggered](https://www.linkedin.com/pulse/automate-jenkins-build-job-srikant-pandey/?trk=related_artice_Automatically%20triggering%20a%20Jenkins%20Build%20on%20every%20Code%20Push%20Event_article-card_title) when you [push](https://git-scm.com/docs/git-push) to an existing [Pull Request](https://www.atlassian.com/git/tutorials/making-a-pull-request)
- CI/CD infrastructure is shared
- Cost: **15-30 minutes** (maybe more)

## Gotchas
1. Can fail if CI server out of capacity
1. Delayed when CI server is overwhelmed
1. Delayed when the network is slow


## Step-6: Deploy to some shared env (eg. Dev/QA)
- Cost: **4-30 minutes** (*more if waiting for other Engineers*)

## Gotchas
1. Shared env, so may have to wait for others
1. Must coordinate deployments & data store changes with **ALL** other Engineers
1. Maybe unable to test until specific date (eg. breaking schema changes)
1. The larger the team, the more Engineers are blocked by this
1. Potential data conflicts when others mutate shared data stores (DB, Kafka, NFS, ...)
1. No guarantees your code is running while testing (eg. Another Engineer accidental deploy, auto-deploy triggered, ...)
1. No control over settings (Environment specific & shared)
1. Might require special permissions or Data Store Admin to make data store changes


## Step-7: Test your changes
- This is the goal
- If you made a mistake, must start over at Step-1 :-(


--------
# Development steps with Containerization
- First iteration: costs between **2-minutes** and **14-minutes**
- Subsequent iterations: cost between **1-minute** and **7-minutes**

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
- Can either run specific components or combine multiple components into one config (via [Kubernetes](https://kubernetes.io/) or [docker-compose](https://docs.docker.com/compose/))
- Can run multiple instances without conflicts
    - Separate networks, ports, file systems, ...
- Can pre-wire together connected tools
- Can trash and rebuild broken/corrupt environment quickly
- Completely isolated from other Engineers
- [Intellij has docker features](https://www.jetbrains.com/help/idea/docker.html) and [Kubernetes features](https://www.jetbrains.com/help/idea/kubernetes.html#resource-config-files) to further streamline
- Can *"Enter"* local containers to debug, verify logs, increase logging, check for internal errors, ...
- Cost: **1-7 minutes**


## Step-4: Test your changes
- This is the goal
- If you made a mistake, just run Steps 1 & 2 (skip Step-3)


------
# Comparison

## Best case
|Iteration|With Containerization| Without Containerization|
|---| ---| ---|
|1| 2-minutes| 25-minutes|
|2| 1-minute| 25-minutes|
|3| 1-minute| 25-minutes|
...

In the best case...
- Without containers, 20-builds costs more than 8-hours of "unproductive" time
- With containers, we can iterate 30+ times every hour


## Worst case
|Iteration|With Containerization| Without Containerization|
|---| ---| ---|
|1| 14-minutes| 75-minutes|
|2| 7-minutes| 75-minutes|
|3| 7-minutes| 75-minutes|

In the worst case...
- Without containers, we can do at about 6-iterations each **day**
- With containers, we can do 6-iterations each **hour**
