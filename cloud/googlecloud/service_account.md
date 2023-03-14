# Overview
1. How to setup a service account in Google Cloud
1. How to setup a role & permissions

# Concepts
1. https://cloud.google.com/iam/docs/roles-overview
    1. Role >|o----|< Permissions
    1. User >|o---o|< Role
    1. Custom roles are the only way to grant granular permissions to users

# Create custom role with permissions
1. [Create a (custom) role for service account](https://console.cloud.google.com/iam-admin/roles) 
    - Alternative: `gcloud iam roles create my-server-runner --project ...`
    - Title: `myServerRunner`
    - Id: `myServerRunner`
1. Add Permissions to the Role
```bash
PROJECT_NAME="myProject"
ROLE_NAME="myRole"

# See https://cloud.google.com/iam/docs/understanding-roles

# -- See https://cloud.google.com/iam/docs/understanding-roles#iam.serviceAccountTokenCreator
gcloud iam roles update $ROLE_NAME \
--project $PROJECT_NAME \
--add-permissions iam.serviceAccounts.signBlob;

# -- See https://cloud.google.com/iam/docs/understanding-roles#cloud-storage-roles
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
```


## Verify    
```
PROJECT_NAME=myProject
ROLE_NAME=myRole

gcloud iam roles describe $ROLE_NAME --project $PROJECT_NAME
```


# [Create/Setup](https://cloud.google.com/iam/docs/service-accounts-create)
1. [Open console](https://console.cloud.google.com/iam-admin/iam)
1. Choose your [project](https://cloud.google.com/docs/overview#projects)
    1. [Your projects](https://console.cloud.google.com/cloud-resource-manager)
1. Enter Service name
    1. Choose a name that is email address safe
1. Enter description
    1. eg. "Account to run XYZ service"
1. Select the previously created Role
1. click "Done"

# (Optional) Add a key
1. Manage Keys
1. Add key
1. Create new key
    1. Key Type: JSON
1. Download the *.json file    


## Verify
```bash
ACCT_EMAIL=later-server@wc-chrono.iam.gserviceaccount.com
gcloud iam service-accounts list     
gcloud iam service-accounts describe $ACCT_EMAIL
```


# Use Service account with Cloud Run
1. [Open Google Cloud Console (Cloud Run section)](https://console.cloud.google.com/run)
1. Go to Service details
1. Click `Edit & Deploy a new version`
1. Click `Security` tab
    1. Use the Service Account created above
1. Deploy


# Debug
1. See [cloud logs](https://console.cloud.google.com/logs/query) for any IAM failures


# Other resources
1. https://cloud.google.com/run
1. https://console.cloud.google.com/run
1. https://cloud.google.com/iam/docs/service-account-overview
1. https://cloud.google.com/iam/docs/grant-role-console
