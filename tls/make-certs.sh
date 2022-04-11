#!/usr/bin/env bash
set -xe

docker build -t temporal_tls:test -f ${PWD}/tls/Dockerfile.tls .
mkdir .pki
docker run --rm -v temporal_tls_pki:/pki -v ${PWD}/.pki:/pki-out temporal_tls:test
