#!/usr/bin/env bash
set -eu
cat assets/pki/localhost.crt assets/pki/ca/ca.crt >/tmp/chain.crt
openssl s_server -key assets/pki/localhost.key -cert /tmp/chain.crt -accept 13100 -www
# test with `curl --cacert assets/pki/ca/ca.crt 'https://localhost:13100/'`
