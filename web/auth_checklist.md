# Overview
1. Checklist of security tasks for Servers


--------
# General advice

## Max length on strings
1. TODO


## Rate limiting
1. Add small geometric backoff delay after each login failure
1. Bound the delay
    1. Goal is to waste time for attacker
1. Scope to account
    1. Better to be locked out of your account than having account compromised
    1. If you scope to IP, attackers just use multiple or spoofing
    1. If you scope to IP, all users with same proxy affected


## Multifactor auth
1. TOTP: TODO
1. TODO: account recovery thru email (but rate limited to avoid spam)


--------
# [Cookies](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies)
1. Eg. `Set-Cookie: session_id=...; Secure; HttpOnly; SameSite=Lax; Max-Age=14400`

## HttpOnly
1. javascript cannot access nor manipulate


## Secure
1. Only sent over https (not http)


## Expiration & Max Age
1. `Max-Age=<#seconds>`
    1. eg. ``

## [SameSite](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#controlling_third-party_cookies_with_samesite)
1. Helps prevent leak to other sites (privacy)
1. TODO: summarize difference between Lax and Strict


## Invalidate cookies on logout
```
Set-Cookie: session_id=; Max-Age=-1
```


--------
# Passwords

## Min length
1. Long passwords have exponentially more permutations
1. Try [zxcvbn](https://github.com/dropbox/zxcvbn) password strength estimator

## Salt
1. TODO

## Pepper
1. TODO


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
# Login screen

## Same error message for all failures
1. TODO


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
