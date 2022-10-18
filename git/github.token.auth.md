# Overview
1. How to create an authorization token for interacting with github
1. Accessing github via the command line & Jetbrains products (Goland, IntelliJ, PyCharm, etc.)


# Github SSO
1. Developer settings
1. Personal access tokens (classic) or [https://github.com/settings/tokens](https://github.com/settings/tokens)
1. Click `Generate new token` (upper right)
1. Give it a name
1. Expiration: ...
1. Scopes:
    1. Repo / <all>
    1. workflow
    1. admin:org / read:org
    1. gist
1. Click `Generate token` button (lower left)

1. Attempt to push to a repo
    1. user: `john.smith@company.com`
    1. pass: `<the-token>`


# Other resources
1. https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
