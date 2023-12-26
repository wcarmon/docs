# Overview
1. Info on Kubernetes [`Job`](https://kubernetes.io/docs/concepts/workloads/controllers/job/)s and [`CronJob`](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)s


# Idioms
1. Don't rely on Kubernetes to guarantee "exactly one" execution
1. Set a `activeDeadlineSeconds`
1. Set a `restartPolicy`
1. Set a `timeZone` for `CronJob`s


# [Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
1. Namespaced
1. Runs completable task (unlike a Pod/Server which run forever)
1. Jobs run immediately (as soon as you create the `Job` resource)
1. Single shot (does not run continuously)
1. Might take hours to complete
```sh
kubectl explain job.spec;
kubectl explain job.spec.parallelism;
kubectl explain job.spec.activeDeadlineSeconds;

kubectl explain job.spec.template;
kubectl explain job.spec.template.spec;
kubectl explain job.spec.template.spec.restartPolicy;
kubectl explain job.spec.template.spec.volumes;

kubectl get job;
kubectl describe job;

kubectl logs $JOB_NAME;
```


# [CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) (`cj`)
1. Namespaced
1. Run once or periodically (but not continuously)
1. one line of a crontab
```sh
kubectl explain cj.spec;
kubectl explain cj.spec.concurrencyPolicy;
kubectl explain cj.spec.jobTemplate;
kubectl explain cj.spec.schedule;
kubectl explain cj.spec.timeZone;
```
