#!/bin/sh
set -o xtrace
#stop and remove vault containers if running
docker stop vault-demo-vault test.example.com 
docker rm vault-demo-vault test.example.com

#delete all generated files
rm pki-ca-root.json
rm ca.pem
rm pki_intermediate.csr
rm intermediate.cert.pem
rm roleid
rm secretid
rm test.example.com.crt
rm web-server/certs/test.example.pem
rm user.token
rm web-server/certs/test.example.key
rm certs/*
rm cert_key_list
rm log/*
