# my-vault
this project is designed to be a personal password manager, similar to LastPass

- a master password is held by the user
- there is a kms key pair that does all encryption and decryption
- all data in db is encrypted with this key pair on top of the native encryption at rest
- master password is encrypted by user and sent to lambda each request, along with a desired app
- if the master password matches, then the password for the desired app is returned

### docker

1. **dynamo-load**
   - docker container used to given csv data into a given dynamo table

### terraform
- all aws resources

### docker-compose.yaml - builds the following containers

- dynamo-load

