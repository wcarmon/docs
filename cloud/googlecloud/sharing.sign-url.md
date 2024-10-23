# Overview
1. How to sign urls for controlled public file sharing


# For quick public sharing
1. [Install gcloud cli](https://cloud.google.com/sdk/docs/install)
1. Login to [Google cloud console / storage](https://console.cloud.google.com/storage/browser)
1. Select a Bucket
1. Upload file
1. Click file options menu
1. Copy the gsutil URI
1. Find local service creds json file
```bash
SERVICE_CREDS_FILE=$HOME/google-keys/foo.json
GS_URI= ...paste...

gcloud storage sign-url $GS_URI --private-key-file=$SERVICE_CREDS_FILE --duration=1h
```

# Other resources
1. https://cloud.google.com/sdk/gcloud/reference/storage/sign-url
