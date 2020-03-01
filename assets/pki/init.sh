#!/usr/bin/env bash
set -eu -o pipefail

for n in certs crl newcerts private; do mkdir -p ca/$n && touch ca/$n/.gitkeep; done
touch ca/index.txt
[ -e ca/serial ] || echo 1000 >ca/serial

openssl genrsa -out ca/private/ca.key 2048
chmod 0400 ca/private/ca.key
openssl req -config openssl.cnf -key ca/private/ca.key -new -x509 -days 3650 -sha256 -extensions v3_ca \
	-subj "/C=DE/ST=Nowhere/L=Nowhere/O=Nowhere/OU=Nowhere/CN=test-pki-ca" \
	-out ca/ca.crt

./create-cert.sh openssl.cnf localhost
