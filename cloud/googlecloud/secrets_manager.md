# Overview
1. How to Setup a expose a Secret to a Cloud Run container
1. How to Setup a Secret


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
