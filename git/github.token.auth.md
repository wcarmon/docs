# Overview
1. How to create an authorization token for interacting with github
1. How to access github via the command line & JetBrains products (Goland, IntelliJ, PyCharm, etc.)


# JetBrains
1. install/enable [Github plugin](https://plugins.jetbrains.com/plugin/13115-github) (bundled)
1. See https://www.jetbrains.com/help/idea/github.html


# Github SSO
1. Developer settings
1. Personal access tokens (classic) or [https://github.com/settings/tokens](https://github.com/settings/tokens)
1. Click `Generate new token` (upper right)
1. Give it a name
1. Expiration: ...
1. Scopes:
    1. `repo` > *all*
    1. `workflow`
    1. `admin:org` > `read:org`
    1. `gist`
1. Click `Generate token` button (lower left)
1. Save the new token to a local file (eg. `~/github_token.txt`)
1. Find the row for your newly created token
1. Click `Configure SSO` button
1. Click `Authorize`
1. Attempt to push to a repo on github
    1. user: `john.smith@company.com` (or your github user name)
    1. pass: `<your-token>`


# Other Resources
1. https://www.jetbrains.com/help/idea/github.html
1. https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
1. https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
