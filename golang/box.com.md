# Overview
1. Interating with box.com




# Config model
```go
// See https://developer.box.com/guides/authentication/jwt/with-sdk/
type BoxConfig struct {
	BoxAppSettings BoxAppSettings `json:"boxAppSettings"`
	EnterpriseID   string         `json:"enterpriseID"`
}

type BoxAppSettings struct {
	AppAuth AppAuth `json:"appAuth"`

	// TODO: document format
	ClientID string `json:"clientID"`

	// TODO: document format
	ClientSecret string `json:"clientSecret"`
}

type AppAuth struct {
	// TODO: document format
	PublicKeyID string `json:"publicKeyID"`

	//  PKCS#8 format
	PrivateKey string `json:"privateKey"`

	// TODO: document format
	Passphrase string `json:"passphrase"`
}
```


# Create JWTClaim
```go
```

# Create JsonWebSignature
```go
```

# Request access token
```go
```