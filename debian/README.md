# Debian Packages _(cardano-db-sync-dist)_

> Debian packages for deploying cardano-db-sync and its dependencies

Because they depend on each other, they must be build in order, eg `cardano-conf` ->
`cardano-node` -> `cardano-db-sync`

## Prerequisites

The following Debian packages are required to build:

 * [build-essential](https://packages.debian.org/stable/build-essential)
 * [curl](https://packages.debian.org/stable/curl)
 * [debhelper](https://packages.debian.org/stable/debhelper)

```
sudo apt-get install build-essential curl debhelper
```

## Quick Start

Build the packages:

```
cd debian
make
```

Install dependencies:

```
sudo apt-get install postgresql
```

Install them:

```
sudo dpkg --install \
  cardano-conf_11.0.1+config_all.deb \
  cardano-node_11.0.1-1_amd64.deb \
  cardano-db-sync_13.7.2.1_amd64.deb
```

Start `cardano-node` in the desired network:

```
# eg cardano-node@mainnet.service
sudo systemctl enable --now cardano-node@NETWORK.service
```

Create the database user and database:

```
sudo -u postgres createuser cardano-node --no-superuser --createdb
# eg cardano-db-sync-mainnet
sudo -u cardano-node createdb cardano-db-sync-NETWORK
```

Start `cardano-db-sync`:

```
# eg cardano-db-sync@mainnet.service
sudo systemctl enable --now cardano-db-sync@NETWORK.service
```
