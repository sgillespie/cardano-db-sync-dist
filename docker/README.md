# Docker Images _(cardano-db-sync-dist)_

> Container images for deploying cardano-db-sync and its dependencies

This directory builds the following images:

 * `cardano-conf`: network configuration files for `mainnet`, `preprod`, and `preview`
 * `cardano-node`: cardano-node static binaries with baked-in configs
 * `cardano-db-sync`: cardano-db-sync static binaries with baked-in configs and migrations

`cardano-conf` is a shared config image. Because the other images depend on it, they must 
be built in order, eg `cardano-conf` -> `cardano-node`, `cardano-db-sync`.

## Prerequisites

 * [Podman](https://podman.io/) (or [Docker](https://www.docker.com/))
 * [Make](https://www.gnu.org/software/make/)

**Note**: The `Makefile` uses Podman. To build with Docker instead, edit the `Makefile`.

## Quick Start

Build the images:

```
cd docker
make
```

Run them on the desired network:

```
# Preview is the default network
podman compose up # or: docker compose up

# Alternatively, specify the network (eg NETWORK=mainnet)
NETWORK=<NET> docker compose up
```

## Configuration

Network configs are baked into the runtime images: they are selected at runtime under
`/etc/cardano/$NETWORK/`. It is strongly recommended to customize then to your needs,
which generally will result in faster sync times and reduced RAM utilization.

To customize them, extract the configs to a directory on the host:

```
# Extract an editable copy from the conf image
mkdir -p config
podman run --rm ghcr.io/sgillespie/cardano-conf:11.0.1 | tar -C ./config -x

# Mount it to shadow the baked-in config
podman run -v "$PWD/config:/etc/cardano:ro" -e NETWORK=mainnet \
  ghcr.io/sgillespie/cardano-db-sync:13.7.2.1
```

## PostgreSQL

cardano-db-sync depends on a PostgreSQL server. You can either set the standard `PG*`
environment variables, or specify a `PGPASSFILE`. The following variables are accepted:

 * `PGHOST`: The PostgreSQL host
 * `PGPORT`: Specify the port to connect the PostgreSQL host with
 * `PGUSER`: Specify a user to connect to the PostgreSQL host with
 * `PGPASSWORD`: Specify a password to connect with
 * `PGDATABASE`: Specify the name of the DB Sync database (default:
   cardano-db-sync-<network>)
 * `PGPASSFILE`: A PostgreSQL password file used to authenticate to PostgreSQL, must be
   mounted with permission mode `0600` (required if not using the `PG*` variables above)

