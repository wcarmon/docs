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

# Add/Grant/Remove/Revoke roles
1. https://console.cloud.google.com/projectselector2/iam-admin/iam?supportedpurview=project,folder,organizationId
    1. Resource Type: `storage.v1.bucket`


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
1. Deploy    
1. Click `Container` tab
1. Secrets > Reference a secret
 


# Other resources
1. TODO
