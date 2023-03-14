# Overview
1. TODO


# [Create/Setup](https://cloud.google.com/iam/docs/service-accounts-create)
1. Open console
1. Choose project

1. Enter service name & description
    1. choose a name that is email address safe 
1. Choose some [roles](https://cloud.google.com/iam/docs/understanding-roles#service-accounts-roles) (can defer this step)
    1. [Storage roles](https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles)
    1. [signJSON, signBlob, ...](https://cloud.google.com/iam/docs/understanding-roles#iam.serviceAccountTokenCreator)
1. Done
1. Manage Keys
1. Add key
1. Create new key
    1. Key Type: JSON


## Verify
```bash
ACCT_EMAIL=later-server@wc-chrono.iam.gserviceaccount.com
gcloud iam service-accounts list     
gcloud iam service-accounts describe $ACCT_EMAIL
```

# Add/Grant/Remove/Revoke Roles/Permissions
1. Concepts: https://cloud.google.com/iam/docs/roles-overview
    1. Role >|o----|< Permissions
    1. User >|o---o|< Role
    1. Custom roles are the only way to grant granular permissions to users
1. [Create a (custom) role for service account](https://console.cloud.google.com/iam-admin/roles) 
    - Alternative: `gcloud iam roles create my-server-runner --project ...`
    - Title: `myServerRunner`
    - Id: `myServerRunner`
1. Add Permissions to role
```bash
ROLE_NAME=laterServerRunner
PROJECT_NAME=wc-chrono

PROJECT_NAME=myProject
ROLE_NAME=myRole

# See https://cloud.google.com/iam/docs/understanding-roles

gcloud iam roles update $ROLE_NAME \
--project $PROJECT_NAME \
--add-permissions iam.serviceAccounts.signBlob;

gcloud iam roles update $ROLE_NAME \
--project $PROJECT_NAME \
--add-permissions storage.objects.create,storage.objects.delete,storage.objects.get,storage.objects.getIamPolicy,storage.objects.list;

gcloud iam roles update $ROLE_NAME \
--project $PROJECT_NAME \
--add-permissions logging.buckets.write,logging.logEntries.create,logging.logEntries.route;

gcloud iam roles update $ROLE_NAME \
--project $PROJECT_NAME \
--add-permissions cloudtrace.traces.patch;

gcloud iam roles update $ROLE_NAME \
--project $PROJECT_NAME \
--add-permissions run.jobs.run,run.routes.invoke;
  
# TODO: secretmanager.versions.access?     
```


## Verify    
```
PROJECT_NAME=myProject
ROLE_NAME=myRole

gcloud iam roles describe $ROLE_NAME --project $PROJECT_NAME
```        

# Use service account with Cloud Run
1. Open console for Cloud Run
1. Go to service details
1. Click `Edit & Deploy a new version`
1. Click `Security` tab
    1. Use the Service Account created above
1. Deploy


# Secret Manager
1. (optional) [Enable the API](https://cloud.google.com/secret-manager/docs/configuring-secret-manager) for your project
1. [Create a new secret](https://console.cloud.google.com/security/secret-manager/create)
    1. Name: eg. `my-server-creds`
    1. Value: /path/to/your/creds.json file
    1. (Defaults are fine for everything else)

# Associate Secret with Cloud Run
1. Open console for Cloud Run
1. Go to service details
1. Click `Container` tab
1. Secrets > Reference a secret
1. select the secret
1. Mounted as volume
    1. /etc/gcloud/secrets/creds.json 
1. Deploy

## Verify
- TODO


# Debug
1. See logs for any IAM failures


# Other resources
1. TODO
