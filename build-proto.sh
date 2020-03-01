#!/usr/bin/env bash
set -eu -o pipefail

[ -e build-proto.sh ] || { >&2 echo "Wrong directory"; exit 1; }

rm -rf lib/generated
mkdir lib/generated
protoc --dart_out=grpc:lib/generated -Iproto proto/*.proto
