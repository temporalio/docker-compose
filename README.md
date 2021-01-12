# Temporal docker-compose files

With provided docker-compose files you can run a local version of Temporal server with dependencies.
Try our [Go](https://github.com/temporalio/samples-go) and [Java](https://github.com/temporalio/samples-java) samples to see it in action.

## Installing prerequisites

Install:
  * [docker](https://docs.docker.com/engine/installation/)
  * [docker-compose](https://docs.docker.com/compose/install/)

## Default configuration

With every release of the Temporal server, there is also a corresponding
docker hub image .

The following step will bring up a docker container that is running the Temporal server
and its dependencies (cassandra). The Temporal gRPC frontend is exposed on port `7233`.

```bash
$ docker-compose up
```

View Temporal Web UI at [http://localhost:8088](http://localhost:8088).
Use preconfigured Temporal CLI tool (`tctl`) from `temporal-admin-tools`:
```bash
$ alias tctl="docker exec temporal-admin-tools tctl"
```
For example to register new namespace `test-namespace` with 1 retention day:
```bash
$ tctl --ns test-namespace namespace register -rd 1
```

## Custom image configuration

Clone main Temporal repo: [https://github.com/temporalio/temporal](https://github.com/temporalio/temporal):
```bash
$ git clone https://github.com/temporalio/temporal.git
$ cd temporal
```

Replace **YOUR_TAG** and **YOUR_COMMIT** in the below command and build custom docker image of Temporal server:
```bash
$ git checkout YOUR_COMMIT
$ docker build . -t temporalio/auto-setup:YOUR_TAG --build-arg TARGET=auto-setup
```
Replace the tag of **image: temporalio/auto-setup** to **YOUR_TAG** in `docker-compose.yml`.
Then start the service using the below commands:
```bash
$ docker-compose up
```

## Other storage configurations

Default `docker-compose.yml` file runs Temporal server with Cassandra. There are other configuration files:

| File                         | Description |
|------------------------------|-------------|
| docker-compose.yml           | Cassandra (default) |
| docker-compose-cas-es.yml    | Cassandra and Elasticsearch |
| docker-compose-mysql.yml     | MySQL |
| docker-compose-mysql-es.yml  | MySQL and Elasticsearch |
| docker-compose-postgres.yml  | PostgreSQL |
| docker-compose-cockroach.yml | CockroachDB |

Use one of the these files to run corresponding Temporal configuration. For example to run Temporal with MySQL
and Elasticsearch for enhance visibility queries run:

```bash
$ docker-compose -f docker-compose-mysql-es.yml up
```

## Quickstart for production

In a typical production setting, dependencies (such as `cassandra` or `elasticsearch`) are managed/started independently of the Temporal server.
To use the container in a production setting, use the following command:

```plain
$ docker run -e CASSANDRA_SEEDS=10.x.x.x                -- csv of cassandra server ipaddrs
    -e KEYSPACE=<keyspace>                              -- Cassandra keyspace
    -e VISIBILITY_KEYSPACE=<visibility_keyspace>        -- Cassandra visibility keyspace
    -e SKIP_SCHEMA_SETUP=true                           -- do not setup cassandra schema during startup
    -e RINGPOP_SEEDS=10.x.x.x,10.x.x.x  \               -- csv of ipaddrs for gossip bootstrap
    -e NUM_HISTORY_SHARDS=1024  \                       -- Number of history shards
    -e SERVICES=history,matching \                      -- Spinup only the provided services
    -e LOG_LEVEL=debug,info \                           -- Logging level
    -e DYNAMIC_CONFIG_FILE_PATH=config/foo.yaml         -- Dynamic config file to be watched
    temporalio/server:<tag>
```
