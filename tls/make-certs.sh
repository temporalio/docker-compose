#!/usr/bin/env bash
set -xe

docker build -t temporal_cfssl:test - < ${PWD}/tls/Dockerfile.cfssl
mkdir .pki
docker run --rm --workdir /pki -v ${PWD}/.pki:/pki -v ${PWD}/tls:/tls --entrypoint /tls/gen-certs.sh temporal_cfssl:test

sudo chown root .pki/postgresql-key.pem && sudo chmod 640 .pki/postgresql-key.pem
sudo chown root .pki/elasticsearch-key.pem && sudo chmod 640 .pki/elasticsearch-key.pem
