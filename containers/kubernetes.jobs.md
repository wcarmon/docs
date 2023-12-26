# Overview
1. Info on Kubernetes [`Job`](https://kubernetes.io/docs/concepts/workloads/controllers/job/)s and [`CronJob`](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)s


# Idioms
1.


# [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
1. Namespaced
1. Runs completable task (unlike a Pod/Server which run forever)
1. Single shot (does not run continuously)
1. Might take hours to complete
```sh
kubectl explain job.spec
kubectl explain job.spec.parallelism
kubectl explain job.spec.template
```


# [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) (`cj`)
1. Namespaced
1. Run once or periodically (but not continuously)
1. one line of a crontab
```sh
```


# Other resources
1. TODO
