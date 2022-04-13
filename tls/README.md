# Temporal with tls enabled dependencies

## Setup

run from a shell

`./tls/make-certs.sh`

## Startup

run from a shell

`COMPOSE_PROJECT_NAME=tls_test docker-compose -f docker-compose-tls.yml build --no-cache`

`COMPOSE_PROJECT_NAME=tls_test docker-compose -f docker-compose-tls.yml up`
