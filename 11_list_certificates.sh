#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=`cat user.token`

#list all certificates created by the intermediate CA
vault list pki_int/certs
vault list pki_int/certs > cert_key_list