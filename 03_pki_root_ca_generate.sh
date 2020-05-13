#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

#enable Vault PKI secret engine 
vault secrets enable pki

#set default ttl
vault secrets tune -max-lease-ttl=87600h pki

#generate root CA
vault write -format=json pki/root/generate/internal \
common_name="example.com" ttl=87600h  > pki-ca-root.json

#save the certificate in a sepearate file, we will add it later as trusted to our browser/computer
cat pki-ca-root.json | jq -r .data.certificate > ca.pem

#publish urls for the root ca
vault write pki/config/urls \
        issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
        crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

#vault secrets disable pki