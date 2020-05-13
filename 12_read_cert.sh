#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=`cat user.token`
cert1=$(sed '3q;d' cert_key_list)
echo $cert1

#read certificate 
vault read  pki_int/cert/${cert1}