

# Max length on strings

# Cookies

## http-only
1. TODO

## secure
1. TODO


# Min length on password
1. Long passwords have exponentially more permutations
1. Try [zxcvbn](https://github.com/dropbox/zxcvbn) password strength estimator


--------
# Tokens (eg. [JWT](TODO))

## Digitally sign token
1. Avoids tampering attacks


## Token lifetime as short as possible
1. Minimizes exposure for compromised tokens


--------
# Session Id

## Generate randomly
1. Predictable session ids are trivial for attackers to simulate

## Never accept session ID from URL
1. legacy Apache Tomcat versions & legacy php did this (`JSESSIONID`)
1. URL is public
1. Allows attacker to share dangerous URLs which victims might visit


--------
# Uploads

## Rename uploaded files
1. TODO

## Max file size
1. TODO

## Set your own mime-type
1. TODO

## Write to disk with minimal permissions
1. `chmod 0644`

## Don't allow path traversal
1. TODO
