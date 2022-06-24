#!/usr/bin/env bash
set -xe

# Build container image for generating cert material
DOCKER_BUILDKIT=1 docker build -t temporal_tls:test -f ${PWD}/tls/Dockerfile.tls .
mkdir -p .pki

# Run container to name volume and copy out CA certificate
docker run --rm -v temporal_tls_pki:/pki -v ${PWD}/.pki:/pki-out temporal_tls:test

# Build extra layers which copy in CA certificate to local trust store
# Allows for not having to disable host verification on TLS connections
COMPOSE_PROJECT_NAME=tls_test docker-compose -f docker-compose-tls.yml build --no-cache

# Run example docker-compose environment with elasticsearch and postgresql protected with TLS
COMPOSE_PROJECT_NAME=tls_test docker-compose -f docker-compose-tls.yml up
