# Temporal with tls enabled dependencies

## Setup

run from a shell

`./tls/make-certs.sh`

There will be a `sudo` promote which is required to update permissions of the generated key files.

## Startup

run from a shell

`COMPOSE_PROJECT_NAME=tls_test docker-compose -f docker-compose-tls.yml up`
