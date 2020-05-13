#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=`cat user.token`

cert1=$(sed '3q;d' cert_key_list)
echo $cert1

#revoke  certificate
vault write pki_int/revoke serial_number=${cert1}

#read the revoked certificate 
vault read  pki_int/cert/${cert1}