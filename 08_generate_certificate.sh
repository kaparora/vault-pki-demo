#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:8200
#set roleid and secretid as env variables from the previous step
export VAULT_USER="kapil"
export VAULT_PASSWORD="secret"

vault login -format=json -method=userpass \
    username=${VAULT_USER} \
    password=${VAULT_PASSWORD} | jq -r .auth.client_token > user.token

#store the token as env variable, now this token can be used to authenticate against Vault
export VAULT_TOKEN=`cat user.token`

#Use the new token to generate a new certificate and store it in a file
vault write -format=json pki_int/issue/example-dot-com \
    common_name=test.example.com > test.example.com.crt

#extract the certificate, issuing ca in the pem file and private key in the key file seperately
cat test.example.com.crt | jq -r .data.certificate > web-server/certs/test.example.pem
cat test.example.com.crt | jq -r .data.issuing_ca >> web-server/certs/test.example.pem
cat test.example.com.crt | jq -r .data.private_key > web-server/certs/test.example.key