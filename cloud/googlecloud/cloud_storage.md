# Overview
1. How to setup/configure a usable [Cloud Storage](https://cloud.google.com/storage?hl=en) system


# Setup
1. [Create a bucket](https://cloud.google.com/storage/docs/creating-buckets)
1. Create a [service account](./service_account.md)
1. Set Privileges on the bucket for the service account
1. Install [`gcloud`](https://cloud.google.com/sdk/docs/install)
<details>
    <summary>Linux Bash</summary>
```bash
sudo apt-get update; sudo apt-get install apt-transport-https ca-certificates gnupg curl
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install -y google-cloud-cli
gcloud components update
```
</details>
1. Authorize `gcloud`
<details>
    <summary>Linux Bash</summary>
```bash
gcloud init;
gcloud auth login;
```
1. Choose [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
1.




# Other resources
1. TODO
