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

#generate multiple certificates 
for i in {1..5}
do
    vault write -format=json pki_int/issue/example-dot-com common_name=www.test${i}.example.com > certs/test${i}.example.crt
done