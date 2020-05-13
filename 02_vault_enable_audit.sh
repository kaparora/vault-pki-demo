#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=
#login into Vault 
vault login root
#check the status of Vault server
vault status

#enable Audit and write logs to a file
vault audit enable file file_path=/var/log/vault_audit.log
#enable another Audit and log to another file but with raw data
vault audit enable -path="file_raw" file  log_raw=true file_path=/var/log/vault_audit_raw.log