# Temporal Server Kubernetes manifests

This repository provides Kubernetes manifests that enable you to run a development version of the Temporal Server.
There are a variety of manifest folders, each setup to utilize a different set of dependencies.

## Prerequisites

To use these manifests, you must first have a Kubernetes cluster setup. If you'd just like to try this locally without using a Kubernetes cluster setup in the cloud then tools like `minikube`, `kind` or Docker Desktop's built-in kubernetes setup will all work just fine to create a cluster you can use for exploring Temporal.

You must have `kubectl` configured and be able to succesfully run commands like `kubectl get pods` to be able to follow the examples in this document.

## How to use

The following command will run a developer setup of the Temporal Server and its default dependencies in the `temporal` namespace in your Kubernetes cluster:

```bash
kubectl create namespace temporal
kubectl apply -n temporal -R -f https://raw.githubusercontent.com/temporalio/docker-compose/main/k8s/temporal.yaml
```

You can check to see when everything is up and running using `kubectl get pods -n temporal` and checking that all pods are showing `STATUS` as `RUNNING`.
```bash
kubectl get pods -n temporal
```

Once everything is up you can open the Temporal Web UI in your browser. You can use port forwarding to be able to reach the Temporal Web UI from your workstation using the `kubectl port-forward ...` command. Leave this running in a terminal window and then visit [http://localhost:8088](http://localhost:8088) in your browser.
```bash
kubectl port-forward -n temporal services/temporal-web 8088:8088
```

You can also interact with the Server using a preconfigured CLI (tctl).
First create an alias for `tctl`:

```bash
alias tctl="kubectl exec -n temporal deployment/temporal-admin-tools -- tctl"
```

The following is an example of how to register a new namespace `test-namespace` with 1 day of retention:

```bash
tctl --ns test-namespace namespace register -rd 1
```

You can find our `tctl` docs on [docs.temporal.io](https://docs.temporal.io/docs/system-tools/tctl/).

Get started building Workflows with a [Go sample](https://github.com/temporalio/samples-go), [Java sample](https://github.com/temporalio/samples-java), or write your own using one of the [SDKs](https://docs.temporal.io/docs/sdks-introduction).

### Other manifest sets

The manifests set at `k8s/temporal-default` installs a PostgreSQL database, an Elasticsearch instance and Temporal Server.
The other manifest directories in the repo spin up instances of the Temporal Server using different databases and dependencies.
For example you can run the Temporal Server with MySQL and Elastic Search with this command:

```bash
kubectl create namespace temporal
kubectl apply -n temporal -R -f https://raw.githubusercontent.com/temporalio/docker-compose/main/k8s/temporal-mysql-es.yaml
```

Here is a list of available manifest sets and the dependencies they install.

| Directory                          | Description                            |
|------------------------------------| -------------------------------------- |
| k8s/temporal-default               | PostgreSQL and Elasticsearch           |
| k8s/temporal-postgres              | PostgreSQL                             |
| k8s/temporal-cass                  | Cassandra                              |
| k8s/temporal-cass-es               | Cassandra and Elasticsearch            |
| k8s/temporal-mysql                 | MySQL                                  |
| k8s/temporal-mysql-es              | MySQL and Elasticsearch                |
| k8s/temporal-cockroach             | CockroachDB                            |
| k8s/temporal-cockroach-es          | CockroachDB and Elasticsearch          |
