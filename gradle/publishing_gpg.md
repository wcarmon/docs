# Overview
1. How to setup gpg signature for publishing artifacts
1. Key setup is a one-time


# Generate Key
```sh
gpg --gen-key;

# Verify
gpg --list-keys;
gpg --list-secret-keys --keyid-format LONG;
```
1. **Store this key somewhere safe!**


# Backup gpg Key
```sh
export BACKUP_FILE=~/private.gpg.backup;
gpg -o $BACKUP_FILE \
--export-options backup \
--export-secret-keys java@wcarmon.com
```

# Restore gpg Key
```sh
gpg --import-options restore --import $BACKUP_FILE
```


# Give Gradle access to gpg key
1. Add properties to `~/.gradle/gradle.properties`
1. See [`./examples/gradle.properties`](./examples/gradle.properties)
1. (NOT RECOMMENDED) ~~they also have a way to pass via command line, but not as secure~~


# Distribute your public key
```sh
# -- Format: about 40 chars, uppercase hexidecimal string
# -- gpg -K;
KEY_ID=...

gpg --keyserver keys.openpgp.org --send-keys $KEY_ID;
gpg --keyserver keyserver.ubuntu.com --send-keys $KEY_ID;
gpg --keyserver pgp.mit.edu --send-keys $KEY_ID;
```


# Other Resources
1. https://central.sonatype.org/publish/requirements/gpg/
1. https://docs.gradle.org/current/userguide/signing_plugin.html
